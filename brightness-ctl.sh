#!/bin/bash
base_path=/sys/class/backlight/intel_backlight

max_brightness=$(cat "${base_path}/max_brightness")
min_brightness=1
step=10

getCurrentBrightness() {
  cat "${base_path}/brightness"
}

setValue() {
  value=$1

  echo $value | sudo tee "${base_path}/brightness"
}

increment() {
  newValue=$(($(getCurrentBrightness) + ${step}))
  setValue $newValue
}

decrement() {
  newValue=$(($(getCurrentBrightness) - ${step}))
  setValue $newValue
}

usage() {
cat <<EOF
Usage: $0 [OPTION]

Options:
  inc         Increment the display brightness.
  dec         Decrement the display brightness.
EOF
}

case $1 in
  inc*)
    increment
  ;;
  dec*)
    decrement
  ;;
  *)
    usage
  ;;
esac

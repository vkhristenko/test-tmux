#!/usr/bin/env sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
TMUX_CONF_SOURCE="$SCRIPT_DIR/tmux.conf"
TMUX_START_SOURCE="$SCRIPT_DIR/tmux_start"
TMUX_CONF_TARGET="$HOME/.tmux.conf"
BIN_DIR="$HOME/.local/bin"
TMUX_START_TARGET="$BIN_DIR/tmux_start"

if [ ! -f "$TMUX_CONF_SOURCE" ]; then
  echo "install.sh: missing source file: $TMUX_CONF_SOURCE" >&2
  exit 1
fi

if [ ! -f "$TMUX_START_SOURCE" ]; then
  echo "install.sh: missing source file: $TMUX_START_SOURCE" >&2
  exit 1
fi

mkdir -p "$BIN_DIR"
install -m 644 "$TMUX_CONF_SOURCE" "$TMUX_CONF_TARGET"
install -m 755 "$TMUX_START_SOURCE" "$TMUX_START_TARGET"

printf 'Installed %s\n' "$TMUX_CONF_TARGET"
printf 'Installed %s\n' "$TMUX_START_TARGET"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *)
    printf 'Note: add %s to PATH if it is not already available.\n' "$BIN_DIR"
    ;;
esac

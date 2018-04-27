Date: Fri, 27 Apr 2018 16:39:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: [GIT PULL] Staging driver fixes for 4.17-rc3
Message-ID: <20180427143954.GA9054@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.17-rc3

for you to fetch changes up to bcdd0ca8cb8730573afebcaae4138f8f4c8eaa20:

  tty: Use __GFP_NOFAIL for tty_ldisc_get() (2018-04-25 15:03:44 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.17-rc3

Here are some tty and serial driver fixes for reported issues for
4.17-rc3.

Nothing major, but a number of small things:
	- device tree fixes/updates for serial ports
	- earlycon fixes
	- n_gsm fixes
	- tty core change reverted to help resolve syszkaller reports
	- other serial driver small fixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Biju Das (1):
      serial: sh-sci: Document r8a77470 bindings

Daniel Kurtz (1):
      earlycon: Use a pointer table to fix __earlycon_table stride

Geert Uytterhoeven (2):
      dt-bindings: meson-uart: DT fix s/clocks-names/clock-names/
      dt-bindings: mvebu-uart: DT fix s/interrupts-names/interrupt-names/

Karthikeyan Ramasubramanian (1):
      tty: serial: qcom_geni_serial: Use signed variable to get IRQ

Marc Zyngier (1):
      serial: mvebu-uart: Fix local flags handling on termios update

Michal Simek (1):
      tty: serial: xuartps: Setup early console when uartclk is also passed

Stefan Agner (2):
      serial: imx: warn user when using unsupported configuration
      serial: imx: fix cached UCR2 read on software reset

Tetsuo Handa (3):
      tty: Avoid possible error pointer dereference at tty_ldisc_restore().
      tty: Don't call panic() at tty_ldisc_init()
      tty: Use __GFP_NOFAIL for tty_ldisc_get()

Tony Lindgren (2):
      tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
      tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

 .../bindings/serial/amlogic,meson-uart.txt         |  2 +-
 .../devicetree/bindings/serial/mvebu-uart.txt      |  2 +-
 .../bindings/serial/renesas,sci-serial.txt         |  2 ++
 drivers/of/fdt.c                                   |  7 ++++--
 drivers/tty/n_gsm.c                                | 23 ++++++++++++++++-
 drivers/tty/serial/earlycon.c                      |  6 +++--
 drivers/tty/serial/imx.c                           | 19 +++++++++++++-
 drivers/tty/serial/mvebu-uart.c                    |  1 -
 drivers/tty/serial/qcom_geni_serial.c              | 10 +++++---
 drivers/tty/serial/xilinx_uartps.c                 |  2 +-
 drivers/tty/tty_io.c                               |  5 +++-
 drivers/tty/tty_ldisc.c                            | 29 ++++++++++------------
 include/asm-generic/vmlinux.lds.h                  |  2 +-
 include/linux/serial_core.h                        | 21 ++++++++++------
 include/linux/tty.h                                |  2 +-
 15 files changed, 93 insertions(+), 40 deletions(-)

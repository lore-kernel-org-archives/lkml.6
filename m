Date: Wed, 4 Apr 2018 12:31:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 4.17-rc1
Message-ID: <20180404103140.GA10186@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.17-rc1

for you to fetch changes up to 4f794097797f551917b68797e39f25fcb17d5b3a:

  serial: expose buf_overrun count through proc interface (2018-03-23 16:34:06 +0100)

----------------------------------------------------------------
TTY/Serial driver patches for 4.17-rc1

Here is the big set of tty and serial driver patches for 4.17-rc1

Not all that big really, most are just small fixes and additions to
existing drivers.  There's a bunch of work on the imx serial driver
recently for some reason, and a new embedded serial driver added as
well.

Full details are in the shortlog.

All of these have been in the linux-next tree for a while with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Khoroshilov (1):
      serial: mxs-auart: disable clks of Alphascale ASM9260

Andy Shevchenko (2):
      serial, pci_ids: Move duplicate IDs to PCI IDs database
      serial: 8250_dw: Switch to use acpi_dev_present()

Bich HEMON (3):
      dt-bindings: serial: stm32: add RS485 optional properties
      serial: stm32: add support for RS485 hardware control mode
      serial: stm32: fix initialization of RS485 mode

Christian Brauner (4):
      devpts: hoist out check for DEVPTS_SUPER_MAGIC
      devpts: resolve devpts bind-mounts
      devpts: comment devpts_mntget()
      selftests: add devpts selftests

Colin Ian King (1):
      serial: mvebu-uart: remove duplicated bit-wise or of STAT_FRM_ERR

Frédéric Danis (1):
      serdev: Fix typo in serdev_device_alloc

Gabriel Matni (1):
      serial: mvebu-uart: fix tx lost characters

Geert Uytterhoeven (9):
      serial: arc_uart: Fix out-of-bounds access through DT alias
      serial: fsl_lpuart: Fix out-of-bounds access through DT alias
      serial: imx: Fix out-of-bounds access through serial port index
      serial: mxs-auart: Fix out-of-bounds access through serial port index
      serial: pxa: Fix out-of-bounds access through serial port index
      serial: samsung: Fix out-of-bounds access through serial port index
      serial: sh-sci: Fix out-of-bounds access through DT alias
      serial: sirf: Fix out-of-bounds access through DT alias
      serial: xuartps: Fix out-of-bounds access through DT alias

Greg Kroah-Hartman (1):
      Merge 4.16-rc6 into tty-next

Jan Kundrát (1):
      gpio: serial: max310x: Use HW type for gpio_chip's label

Jeremy Kerr (1):
      serial: expose buf_overrun count through proc interface

Joel Stanley (1):
      serial: 8250: Add Nuvoton NPCM UART

Joshua Scott (1):
      serial: 8250_dw: Allow TX FIFO to drain before writing to UART_LCR

Karthikeyan Ramasubramanian (1):
      tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP

Kees Cook (4):
      console: SisUSB2VGA: Drop dummy con_font_get()
      console: Fill in struct consw argument names
      console: Expand dummy functions for CFI
      console: Drop added "static" for newport_con

Mathieu Malaterre (1):
      powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused

Michael Moese (1):
      8250-men-mcb: add support for 16z025 and 16z057

Mike Frysinger (1):
      vt: change SGR 21 to follow the standards

Palmer Dabbelt (1):
      tty: New RISC-V SBI console driver

Patrice Chotard (3):
      tty: st-asc: Update tty alias
      ARM: dts: STi: Fix aliases property name for STi boards
      ARM: dts: STi: Remove "console=ttyASN" from bootargs for STi boards

Sergei Shtylyov (1):
      DT: serial: renesas,sci-serial: document R8A77980 bindings

Troy Kisky (1):
      tty: serial: imx: allow breaks to be received when using dma

Ulrich Hecht (1):
      serial: sh-sci: use hrtimer for receive timeout

Uwe Kleine-König (22):
      serial: altera: ensure port->regshift is honored consistently
      serial: altera: don't enable any irq if the device doesn't feature an irq
      serial: altera: set RRDY flag also without irq
      serial: imx: drop if that always evaluates to true
      serial: imx: rename variables to match the register names
      serial: imx: Only handle irqs that are actually enabled
      serial: imx: simplify tracking of dma being initialized
      serial: imx: drop check for enabled dma in .startup
      serial: imx: Rename register fields to match newer reference manuals
      serial: imx: document functions that are called with port.lock taken
      serial: imx: add wrappers for writel and readl
      serial: imx: implement shadow registers for UCRx and UFCR
      serial: imx: simplify some conditions related to dma
      serial: imx: simplify check that prevents starting PIO when DMA is in use
      serial: imx: use u32 variables with matching names for registers
      serial: imx: setup fifo waterlevel before enabling aging timer
      serial: imx: Stop to receive in .stop_rx()
      serial: imx: ensure that RX irqs are off if RX is off
      serial: imx: Also enable the aging timer in PIO mode
      serial: imx: Fix handling of TC irq in combination with DMA
      serial: imx: don't prepare to send if no data is available
      serial: imx: consistently use imx_uart_ as prefix for all functions

Vignesh R (2):
      serial: 8250: Don't service RX FIFO if interrupts are disabled
      serial: 8250: 8250_omap: Fix throttling when DMA is enabled

Wei Yongjun (1):
      tty: serial: msm_geni_serial: Fix return value check in qcom_geni_serial_probe()

 Documentation/devicetree/bindings/serial/8250.txt  |    1 +
 .../bindings/serial/renesas,sci-serial.txt         |    2 +
 .../devicetree/bindings/serial/st,stm32-usart.txt  |    2 +
 arch/arm/boot/dts/stih407-b2120.dts                |    4 +-
 arch/arm/boot/dts/stih410-b2120.dts                |    4 +-
 arch/arm/boot/dts/stih410-b2260.dts                |    4 +-
 arch/arm/boot/dts/stih418-b2199.dts                |    4 +-
 drivers/parport/parport_serial.c                   |    3 -
 drivers/tty/hvc/Kconfig                            |   10 +
 drivers/tty/hvc/Makefile                           |    1 +
 drivers/tty/hvc/hvc_riscv_sbi.c                    |   60 +
 drivers/tty/serdev/core.c                          |    2 +-
 drivers/tty/serial/8250/8250_dw.c                  |   34 +-
 drivers/tty/serial/8250/8250_men_mcb.c             |  125 +-
 drivers/tty/serial/8250/8250_of.c                  |    1 +
 drivers/tty/serial/8250/8250_omap.c                |   11 +-
 drivers/tty/serial/8250/8250_pci.c                 |    3 -
 drivers/tty/serial/8250/8250_port.c                |   36 +-
 drivers/tty/serial/8250/Kconfig                    |    5 +-
 drivers/tty/serial/Kconfig                         |   15 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/altera_uart.c                   |   58 +-
 drivers/tty/serial/arc_uart.c                      |    5 +
 drivers/tty/serial/fsl_lpuart.c                    |    4 +
 drivers/tty/serial/imx.c                           | 1209 +++++++++++---------
 drivers/tty/serial/max310x.c                       |    2 +-
 drivers/tty/serial/mvebu-uart.c                    |    4 +-
 drivers/tty/serial/mxs-auart.c                     |   40 +-
 drivers/tty/serial/pxa.c                           |    4 +
 drivers/tty/serial/qcom_geni_serial.c              | 1158 +++++++++++++++++++
 drivers/tty/serial/samsung.c                       |    4 +
 drivers/tty/serial/serial_core.c                   |    2 +
 drivers/tty/serial/sh-sci.c                        |   51 +-
 drivers/tty/serial/sirfsoc_uart.c                  |    5 +
 drivers/tty/serial/st-asc.c                        |    4 +-
 drivers/tty/serial/stm32-usart.c                   |  134 ++-
 drivers/tty/serial/stm32-usart.h                   |    3 +
 drivers/tty/serial/xilinx_uartps.c                 |    2 +-
 drivers/tty/vt/vt.c                                |    6 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c            |   68 +-
 drivers/video/console/dummycon.c                   |   69 +-
 drivers/video/console/newport_con.c                |    8 +-
 drivers/video/console/vgacon.c                     |   20 +-
 drivers/video/fbdev/core/fbcon.c                   |    3 +-
 fs/devpts/inode.c                                  |   66 +-
 include/linux/console.h                            |   58 +-
 include/linux/pci_ids.h                            |    3 +
 include/linux/serial_core.h                        |    2 +-
 include/uapi/linux/serial_core.h                   |    3 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/filesystems/.gitignore     |    1 +
 tools/testing/selftests/filesystems/Makefile       |    2 +-
 tools/testing/selftests/filesystems/devpts_pts.c   |  313 +++++
 53 files changed, 2902 insertions(+), 738 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_riscv_sbi.c
 create mode 100644 drivers/tty/serial/qcom_geni_serial.c
 create mode 100644 tools/testing/selftests/filesystems/devpts_pts.c

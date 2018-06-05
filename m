Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeFES70 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeFES7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:59:25 -0400
Date: Tue, 5 Jun 2018 20:59:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 4.18-rc1
Message-ID: <20180605185901.GD24892@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.18-rc1

for you to fetch changes up to 4b4ecd9cb853c14913a3726cfcc60ccda1d2924a:

  vt: Perform safe console erase only once (2018-05-25 18:01:16 +0200)

----------------------------------------------------------------
TTY/Serial patches for 4.18-rc1

Here is the big tty/serial driver update for 4.18-rc1.

There's nothing major here, just lots of serial driver updates.  Full
details are in the shortlog, nothing anything specific to call out here.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      tty: nozomi: fix spelling mistake in macro NOZOMI_STATE_UKNOWN

DaeRyong Jeong (1):
      tty: Fix data race in tty_insert_flip_string_fixed_flag

Dan Carpenter (1):
      serial/aspeed-vuart: fix a couple mod_timer() calls

Daniel Wagner (1):
      serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding version

Dave Martin (1):
      tty: pl011: Avoid spuriously stuck-off interrupts

Douglas Anderson (1):
      serial: core: Make sure compiler barfs for 16-byte earlycon names

Evan Green (1):
      tty: serial: msm_geni_serial: Fix TX infinite loop

Geert Uytterhoeven (2):
      serial: sh-sci: Add support for dynamic instances
      serial: Remove depends on HAS_DMA in case of platform dependency

Giulio Benetti (1):
      tty: fix typo in ASYNCB_FOURPORT comment

Greg Kroah-Hartman (1):
      Merge 4.17-rc3 into tty-next

Jeremy Kerr (4):
      serial: Introduce UPSTAT_SYNC_FIFO for synchronised FIFOs
      serial/8250: export serial8250_read_char
      serial/aspeed-vuart: Implement rx throttling
      serial/aspeed-vuart: Implement quick throttle mechanism

Jia-Ju Bai (1):
      tty: ipwireless: Replace GFP_ATOMIC with GFP_KERNEL in ipwireless_network_create

Joey Pabalinas (2):
      tty/nozomi: cleanup DUMP() macro
      tty/nozomi: fix inconsistent indentation

John Crispin (1):
      tty: serial: drop ATH79 specific SoC symbols

John Garry (1):
      serial: 8250_of: Add IO space support

Joshua Scott (1):
      serial: 8250_dw: Limit dw8250_tx_wait_empty quirk to armada-38x devices

Karthikeyan Ramasubramanian (8):
      tty: serial: qcom_geni_serial: Add comments for clarification
      tty: serial: qcom_geni_serial: Cleanup redundant code
      tty: serial: qcom_geni_serial: Use min3 to find minimum of 3 values
      tty: serial: qcom_geni_serial: Initialize console port statically
      tty: serial: qcom_geni_serial: Remove unnecessary memory barrier
      tty: serial: qcom_geni_serial: Use iowrite32_rep to write to FIFO
      tty: serial: qcom_geni_serial: Return IRQ_NONE for spurious interrupts
      tty: serial: qcom_geni_serial: Add early console support

Kurt Kanzenbach (1):
      tty: serial: 8250: pass IRQ shared flag to UART ports

Luc Van Oostenryck (1):
      tty: n_gsm: fix gsm_mux_net_start_xmit()'s return type

Marek Szyprowski (2):
      serial: samsung: fix maxburst parameter for DMA transactions
      serial: samsung: check DMA engine capabilities before using DMA mode

Marek Vasut (1):
      serial: 8250: Add missing rxtrig_bytes on Altera 16550 UART

Michal Simek (7):
      earlycon: Initialize port->uartclk based on clock-frequency property
      serial: 8250_early: Setup divider when uartclk is passed
      serial: uartps: Remove console_initcall from the driver
      serial: uartps: Use dynamic array for console port
      serial: uartps: Move cnds_uart_get_port to probe
      serial: uartps: Remove static port array
      earlycon: Remove hardcoded port->uartclk initialization in of_setup_earlycon

Miquel Raynal (1):
      serial: mvebu-uart: add suspend/resume support

Nicolas Pitre (1):
      vt: Perform safe console erase only once

Pascal Huerst (2):
      tty: serial: msm_serial: Add support for suspend/resume
      tty: serial: msm_serial: Add __maybe_unused to suspend/resume callbacks

Phil Edworthy (1):
      serial: 8250_dw: Fix runtime PM handling

Sebastian Andrzej Siewior (1):
      tty/serial: atmel: use port->name as name in request_irq()

Sebastian Reichel (4):
      serial: imx: cleanup imx_uart_disable_dma()
      serial: imx: dma_unmap_sg buffers on shutdown
      serial: imx: drop CTS/RTS handling from shutdown
      serial: imx: disable UCR4_OREN on shutdown

Stefan Potyra (1):
      sc16is7xx: Check for an error when the clock is enabled.

Tony Lindgren (1):
      serial: 8250: omap: Fix idling of clocks for unused uarts

Ulrich Hecht (1):
      serial: sh-sci: Support for HSCIF RX sampling point adjustment

Vignesh R (1):
      serial: 8250: omap: Provide ability to enable/disable UART as wakeup source

Wolfram Sang (1):
      tty: serial: simplify getting .drvdata

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 arch/arm/boot/dts/armada-38x.dtsi               |   4 +-
 drivers/tty/ipwireless/network.c                |   2 +-
 drivers/tty/n_gsm.c                             |   2 +-
 drivers/tty/nozomi.c                            | 104 +++++++-------
 drivers/tty/pty.c                               |   3 +
 drivers/tty/serial/8250/8250_aspeed_vuart.c     | 125 +++++++++++++++++
 drivers/tty/serial/8250/8250_dw.c               |  35 ++++-
 drivers/tty/serial/8250/8250_early.c            |   2 +-
 drivers/tty/serial/8250/8250_of.c               |  63 +++++----
 drivers/tty/serial/8250/8250_omap.c             |  27 +++-
 drivers/tty/serial/8250/8250_port.c             |   6 +-
 drivers/tty/serial/Kconfig                      |   8 +-
 drivers/tty/serial/amba-pl011.c                 |  16 +++
 drivers/tty/serial/atmel_serial.c               |   5 +-
 drivers/tty/serial/earlycon.c                   |   5 +-
 drivers/tty/serial/imx.c                        |  43 +++---
 drivers/tty/serial/msm_serial.c                 |  23 +++
 drivers/tty/serial/mvebu-uart.c                 |  64 +++++++++
 drivers/tty/serial/qcom_geni_serial.c           | 177 ++++++++++++++++--------
 drivers/tty/serial/samsung.c                    |  40 ++++--
 drivers/tty/serial/sc16is7xx.c                  |   5 +-
 drivers/tty/serial/serial_core.c                |   4 +-
 drivers/tty/serial/sh-sci.c                     |  81 +++++++----
 drivers/tty/serial/sh-sci.h                     |   4 +
 drivers/tty/serial/st-asc.c                     |   6 +-
 drivers/tty/serial/xilinx_uartps.c              | 108 ++++++---------
 drivers/tty/vt/vt.c                             |  16 +--
 include/linux/serial_8250.h                     |   1 +
 include/linux/serial_core.h                     |   4 +-
 include/uapi/linux/tty_flags.h                  |   2 +-
 31 files changed, 694 insertions(+), 297 deletions(-)

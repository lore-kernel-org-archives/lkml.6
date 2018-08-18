Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E879C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A64215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A64215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeHRTEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:37 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A40E3BD4;
        Sat, 18 Aug 2018 15:56:27 +0000 (UTC)
Date:   Sat, 18 Aug 2018 17:56:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 4.19-rc1
Message-ID: <20180818155625.GA22484@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.19-rc1

for you to fetch changes up to 47ac76662ca9c5852fd353093f19de3ae85f2e66:

  tty: serial: 8250: Revert NXP SC16C2552 workaround (2018-08-12 18:53:30 +0200)

----------------------------------------------------------------
TTY/Serial driver patches for 4.19-rc1

Here is the big tty and serial driver pull request for 4.19-rc1.

It's not all that big, just a number of small serial driver updates and
fixes, along with some better vt handling for unicode characters for
those using braille terminals.

Full details are in the shortlog.

All of these patches have been in linux-next for a long time with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaron Sierra (1):
      serial: 8250_exar: Read INT0 from slave device, too

Adam Borowski (4):
      vt: don't reinvent min()
      vt: selection: handle storing of characters above U+FFFF
      vt: selection: take screen contents from uniscr if available
      vt: drop unused struct vt_struct

Alexander Sverdlin (2):
      serial: 8250: of: Correct of_platform_serial_setup() error handling
      serial: 8250: of: Defer probe on missing IRQ

Andy Shevchenko (5):
      serial: 8250_dw: Introduce IO accessors to extended registers
      serial: 8250_exar: Remove useless has_slave member
      serial: 8250_exar: Describe all members in struct exar8250_board
      serial: 8250_exar: Drop unused variable in pci_xr17v35x_setup()
      serial: 8250: Use cached port name directly in messages

Anton Vasilyev (1):
      tty: rocket: Fix possible buffer overwrite on register_PCI

Arnd Bergmann (1):
      tty: use 64-bit timstamp

Baruch Siach (1):
      dt-bindings: serial: imx: clarify rs485 support usage

Chen Hu (1):
      serial: 8250_dw: always set baud rate in dw8250_set_termios

Chris Brandt (6):
      serial: sh-sci: Add support for R7S9210
      serial: sh-sci: Document r7s9210 bindings
      serial: sh-sci: Improve interrupts description
      serial: sh-sci: Allow for compressed SCIF address
      serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE
      serial: sh-sci: Improve support for separate TEI and DRI interrupts

Christophe JAILLET (1):
      serial: pxa: Fix an error handling path in 'serial_pxa_probe()'

Colin Ian King (2):
      parport: parport_serial: Add WCH CH382L PCIe single parallel port support
      tty: serial: jsm: remove redundant pointer ch

Daniel Golle (1):
      tty: serial: exar: generalize RS485 setup

Geert Uytterhoeven (7):
      serial: sh-sci: Stop RX FIFO timer during port shutdown
      serial: sh-sci: Postpone DMA release when falling back to PIO
      serial: sh-sci: Stop TX DMA workqueue during port shutdown
      serial: sh-sci: Stop using deprecated dmaengine_terminate_all()
      serial: sh-sci: Fix use-after-free on subsequent port startup
      serial: sh-sci: Drop superfluous assignment in sci_request_dma()
      serial: sh-sci: Document that serial aliases became optional

Girish Mahadevan (1):
      tty: serial: qcom_geni_serial: Add support for flow control

Greg Kroah-Hartman (1):
      Merge 4.18-rc3 into tty-next

Helmut Grohne (3):
      serial: xuartps: fix typo in cdns_uart_startup
      serial: xuartps: reduce hardware TX race condition
      serial: xuartps: remove unnecessary register write

Jan Kundrát (1):
      serial: max310x: Check the clock readiness

Jisheng Zhang (4):
      serial: 8250: let serial8250_get_divisor() get uart_port * as param
      serial: 8250: introduce get_divisor() and set_divisor() hook
      serial: 8250: export serial8250_do_set_divisor()
      serial: 8250_dw: add fractional divisor support

Johan Hovold (4):
      serdev: add controller runtime PM support
      tty: fix termios input-speed encoding
      tty: fix termios input-speed encoding when using BOTHER
      tty: support CIBAUD without BOTHER

Mark (1):
      tty: serial: 8250: Revert NXP SC16C2552 workaround

Mars Cheng (3):
      dt-bindings: mediatek: add support for mt6765 reference board
      dt-bindings: mtk-uart: add mt6765 uart bindings
      dt-bindings: interrupt-controller: add binding for mt6765

Matthijs van Duin (1):
      pty: fix O_CLOEXEC for TIOCGPTPEER

Nicolas Pitre (6):
      vt: preserve unicode values corresponding to screen characters
      vt: introduce unicode mode for /dev/vcs
      vt: unicode fallback for scrollback
      vt: coherence validation code for the unicode screen buffer
      vt: add /dev/vcsu* to devices.txt
      vt: avoid a VLA in the unicode screen scroll function

Nishanth Menon (2):
      dt-bindings: serial: 8250_omap: Add compatible for AM654 UART controller
      serial: 8250_omap: Add support for AM654 UART controller

Peter Zijlstra (1):
      atomic/tty: Fix up atomic abuse in ldsem

Phil Edworthy (2):
      dt: serial: Add Renesas RZ/N1 binding documentation
      serial: 8250_dw: Add compatible string for Renesas RZ/N1 UART

Robin Gong (1):
      tty: serial: imx: correct dma cookie status

Samuel Thibault (1):
      kbd: complete dead keys definitions

Sean Wang (1):
      serdev: add dev_pm_domain_attach|detach()

Shubhrajyoti Datta (4):
      tty: serial: uartlite: Add structure for private data
      tty: serial: uartlite: Add clock adaptation
      tty: serial: uartlite: Add support for suspend and resume
      dt-bindings: serial: Add binding for uartlite

Srinath Mannam (1):
      serial: 8250_dw: Add ACPI support for uart on Broadcom SoC

Tycho Andersen (1):
      uart: fix race between uart_put_char() and uart_shutdown()

Uwe Kleine-König (1):
      serial: imx: fix comment about UCR2_SRST and its handling for shadowing

Zhouyang Jia (1):
      drivers/tty: add error handling for pcmcia_loop_config

 Documentation/admin-guide/devices.txt              |  16 +-
 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../interrupt-controller/mediatek,sysirq.txt       |   1 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   6 +-
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 .../devicetree/bindings/serial/omap_serial.txt     |   1 +
 .../bindings/serial/renesas,rzn1-uart.txt          |  10 +
 .../bindings/serial/renesas,sci-serial.txt         |  19 +-
 .../bindings/serial/xlnx,opb-uartlite.txt          |  23 ++
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   2 +-
 drivers/parport/parport_serial.c                   |   9 +
 drivers/s390/char/keyboard.c                       |  30 +-
 drivers/tty/pty.c                                  |   2 +-
 drivers/tty/rocket.c                               |   2 +-
 drivers/tty/serdev/core.c                          |  48 ++-
 drivers/tty/serial/8250/8250_core.c                |   6 +-
 drivers/tty/serial/8250/8250_dw.c                  |  74 ++++-
 drivers/tty/serial/8250/8250_exar.c                |  54 +--
 drivers/tty/serial/8250/8250_of.c                  |   6 +-
 drivers/tty/serial/8250/8250_omap.c                |   1 +
 drivers/tty/serial/8250/8250_port.c                |  63 ++--
 drivers/tty/serial/8250/serial_cs.c                |   6 +-
 drivers/tty/serial/imx.c                           |   5 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |   3 +-
 drivers/tty/serial/max310x.c                       |  14 +-
 drivers/tty/serial/pxa.c                           |   3 +-
 drivers/tty/serial/qcom_geni_serial.c              | 261 +++++++++++++--
 drivers/tty/serial/serial_core.c                   |  17 +-
 drivers/tty/serial/sh-sci.c                        | 191 ++++++-----
 drivers/tty/serial/uartlite.c                      | 112 ++++++-
 drivers/tty/serial/xilinx_uartps.c                 |  23 +-
 drivers/tty/tty_baudrate.c                         |  22 +-
 drivers/tty/tty_io.c                               |  19 +-
 drivers/tty/tty_ldsem.c                            |  82 ++---
 drivers/tty/vt/keyboard.c                          |  30 +-
 drivers/tty/vt/selection.c                         |  48 +--
 drivers/tty/vt/vc_screen.c                         |  90 ++++-
 drivers/tty/vt/vt.c                                | 367 ++++++++++++++++++++-
 include/linux/console_struct.h                     |   5 +-
 include/linux/selection.h                          |   6 +
 include/linux/serial_8250.h                        |   3 +
 include/linux/serial_core.h                        |   7 +
 include/linux/tty_ldisc.h                          |   4 +-
 include/uapi/linux/keyboard.h                      |  23 +-
 44 files changed, 1381 insertions(+), 338 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt

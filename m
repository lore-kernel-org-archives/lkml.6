Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A9EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F402146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546011311;
	bh=wEQlVWPDFrwYt8U+egjdNped99sTcIz4jOIoRM0hUQM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ivUoxDJuSYsndhR4scQ9ncZJOcT6HUKUMDS3X3rg4ej3mZzkrkNKC23BXFZWuHuw3
	 nXrBUbrITIzt0D9n60Q9K5LxAUII4iA+O7mcIlGfltUhWQMeevpszCA9Y+8S6ht3Y5
	 uoI6k4KxReWKUufjcU2fiLouKjclgiPX14y4vZn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbeL1PfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeL1PfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:35:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361E920869;
        Fri, 28 Dec 2018 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546011308;
        bh=wEQlVWPDFrwYt8U+egjdNped99sTcIz4jOIoRM0hUQM=;
        h=Date:From:To:Cc:Subject:From;
        b=0BSTr5+EcpeZ9sLjIyLpNUv1UZuKRI0x9nMfKHB4kLRh61+9B57TG5rnkddTloRGQ
         q0LBfzU6fEroCDWXDC3AhKVTQf2c3LZCd8jC0p0wODCLtpKmUgjHz2kOLTKi7BP/m8
         tW9bZdPMz0bKq/JZggtnUXu+MUq5JVk0WVEncRBs=
Date:   Fri, 28 Dec 2018 16:35:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial patches for 4.21-rc1
Message-ID: <20181228153506.GA23511@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.21-rc1

for you to fetch changes up to 598134ffcab5bfb1d342458732394487063e1b9e:

  Revert "serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250" (2018-12-24 09:18:00 +0100)

----------------------------------------------------------------
TTY/Serial driver patches for 4.21-rc1

Here is the large TTY/Serial driver set of patches for 4.21-rc1.

A number of small serial driver changes along with some good tty core
fixes for long-reported issues with locking.  There is also a new
console font added to the tree, for high-res screens, so that should be
helpful for many.

The last patch in the series is a revert of an older one in the tree, it
came late but it resolves a reported issue that linux-next was having
for some people.

Full details are in the shortlog, and all of these, with the exception
of the revert, have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aisheng Dong (1):
      dt-bindings: serial: lpuart: add imx8qxp compatible string

Alexander Shiyan (3):
      serial: max310x: Fix tx_empty() callback
      serial: sccnxp: Adds a delay between sequential read/write cycles
      serial: sccnxp: Allow to use non-standard baud rates

Amanoel Dawod (1):
      Fonts: New Terminus large console font

Anders Roxell (2):
      serial: set suppress_bind_attrs flag only if builtin
      writeback: don't decrement wb->refcnt if !wb->bdi

Andy Duan (2):
      serial: fsl_lpuart: fix the typo: UARTCR1_PE -> UARTCTRL_PE
      serial: fsl_lpuart: clear parity enable bit when disable parity

Beomho Seo (1):
      tty: serial: samsung: Properly set flags in autoCTS mode

Colin Ian King (1):
      serial-uartlite: fix null pointer dereference on pointer port

Darwin Dingel (2):
      dt-bindings: serial: 8250: Add rate limit for serial port input overruns
      serial: 8250: Rate limit serial port rx interrupts during input overruns

Dmitry Safonov (6):
      tty/ldsem: Wake up readers after timed out down_write()
      tty: Hold tty_ldisc_lock() during tty_reopen()
      tty: Don't block on IO when ldisc change is pending
      tty: Simplify tty->count math in tty_reopen()
      tty/ldsem: Add lockdep asserts for ldisc_sem
      tty/ldsem: Decrement wait_readers on timeouted down_read()

Douglas Anderson (6):
      tty: serial: qcom_geni_serial: Don't slow all ports just for kgdb
      serial: qcom_geni_serial: Finish supporting sysrq
      serial: core: Allow processing sysrq at port unlock time
      serial: qcom_geni_serial: Process sysrq at port unlock time
      serial: core: Include console.h from serial_core.h
      serial: 8250: Process sysrq at port unlock time

Fabrizio Castro (2):
      dt-bindings: serial: sh-sci: Document r8a774a1 bindings
      dt-bindings: serial: sh-sci: Document r8a774c0 bindings

Florian Fainelli (1):
      serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250

Geert Uytterhoeven (4):
      serial: sh-sci: Improve type-safety calling sci_receive_chars()
      serial: sh-sci: Fix locking in sci_submit_rx()
      serial: sh-sci: Fix crash in rx_timer_fn() on PIO fallback
      serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure

Greg Kroah-Hartman (7):
      Merge 4.20-rc2 into tty-next
      Merge 4.20-rc4 into tty-next
      Revert "serial/sunsu: add missing of_node_put()"
      Revert "tty: xilinx_uartps: Correct return value in probe"
      Revert "sysctl: clean up nr_pdflush_threads leftover"
      Merge 4.20-rc6 into tty-next
      Revert "serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250"

Johan Hovold (4):
      serdev: use zero to indicate infinite write timeout
      serdev: make synchronous write return bytes written
      serdev: make synchronous write helper interruptible
      serdev: document the write functions using kernel-doc

Long Cheng (2):
      dt-bindings: dma: uart: add uart dma bindings
      serial: 8250-mtk: add uart DMA support

Marcel Ziswiler (1):
      serial: tegra: fix some spelling mistakes

Mark Tomlinson (1):
      tty/sysrq: Do not call sync directly from sysrq_do_reset()

Matthias Kaehlcke (2):
      sysrq: Use panic() to force a crash
      tty: serial: qcom_geni_serial: Fix wrap around of TX buffer

Michal Simek (1):
      serial: uartps: Fix error path when alloc failed

Miquel Raynal (2):
      serial: mvebu-uart: clarify the baud rate derivation
      serial: mvebu-uart: initialize over sampling stack register

Mukesh Kumar Savaliya (1):
      tty: serial: qcom_geni_serial: Rectify UART suspend mechanism

Nava kishore Manne (1):
      serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly

Peter Korsgaard (1):
      ttyprintk: make the printk log level configurable

Peter Zijlstra (1):
      tty/ldsem: Convert to regular lockdep annotations

Rafael Aquini (1):
      sysctl: clean up nr_pdflush_threads leftover

Rajan Vaja (1):
      tty: xilinx_uartps: Correct return value in probe

Rob Herring (1):
      tty: Use of_node_name_{eq,prefix} for node name comparisons

Ryan Case (3):
      tty: serial: qcom_geni_serial: Fix softlock
      tty: serial: qcom_geni_serial: Remove interrupt storm
      tty: serial: qcom_geni_serial: Fix UART hang

Sergey Senozhatsky (1):
      tty/serial: do not free trasnmit buffer page under port lock

Seung-Woo Kim (1):
      tty: serial: samsung: Increase maximum baudrate

Shubhrajyoti Datta (7):
      serial-uartlite: Move the uart register
      serial-uartlite: Add get serial id if not provided
      serial-uartlite: Do not use static struct uart_driver out of probe()
      serial-uartlite: Add runtime support
      serial-uartlite: Fix the unbind path
      serial: uartps: Add the device_init_wakeup
      serial: uartps: Check if the device is a console

Songjun Wu (11):
      serial: lantiq: Get serial id from dts
      serial: lantiq: Change ltq_w32_mask to asc_update_bits
      serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32
      serial: lantiq: Rename fpiclk to freqclk
      serial: lantiq: Replace clk_enable/clk_disable with clk generic API
      serial: lantiq: Add CCF support
      serial: lantiq: Reorder the head files
      serial: lantiq: Replace lantiq_soc.h with lantiq.h
      serial: lantiq: Change init_lqasc to static declaration
      dt-bindings: serial: lantiq: Add optional properties for CCF
      include: Add lantiq.h in include/linux/

Stefan Agner (1):
      serial: imx: fix error handling in console_setup

Wolfram Sang (1):
      tty: serial: qcom_geni_serial: simplify getting .driver_data

Yangtao Li (3):
      drivers/tty: add missing of_node_put()
      serial/sunsu: add missing of_node_put()
      tty/sysrq: add of_node_put()

zhong jiang (1):
      pch_uart: remove set but not used variable 'tx_empty'

 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 +
 Documentation/devicetree/bindings/serial/8250.txt  |    1 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |    2 +
 .../devicetree/bindings/serial/lantiq_asc.txt      |   15 +
 .../bindings/serial/renesas,sci-serial.txt         |   16 +-
 drivers/char/Kconfig                               |    8 +
 drivers/char/ttyprintk.c                           |    4 +-
 drivers/gnss/serial.c                              |    2 +-
 drivers/gnss/sirf.c                                |    2 +-
 drivers/tty/hvc/hvc_opal.c                         |    2 +-
 drivers/tty/hvc/hvc_vio.c                          |   11 +-
 drivers/tty/n_hdlc.c                               |    4 +-
 drivers/tty/n_r3964.c                              |    2 +-
 drivers/tty/n_tty.c                                |    8 +-
 drivers/tty/serdev/core.c                          |   70 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |    6 +-
 drivers/tty/serial/8250/8250_core.c                |   25 +
 drivers/tty/serial/8250/8250_fsl.c                 |   29 +-
 drivers/tty/serial/8250/8250_mtk.c                 |  210 +-
 drivers/tty/serial/8250/8250_of.c                  |    5 +
 drivers/tty/serial/8250/8250_omap.c                |    6 +-
 drivers/tty/serial/8250/8250_port.c                |    8 +-
 drivers/tty/serial/amba-pl011.c                    |    2 +
 drivers/tty/serial/fsl_lpuart.c                    |    6 +-
 drivers/tty/serial/imx.c                           |    2 +-
 drivers/tty/serial/lantiq.c                        |  145 +-
 drivers/tty/serial/max310x.c                       |    7 +-
 drivers/tty/serial/mvebu-uart.c                    |   29 +-
 drivers/tty/serial/pch_uart.c                      |    3 -
 drivers/tty/serial/pic32_uart.c                    |    1 +
 drivers/tty/serial/pmac_zilog.c                    |    4 +-
 drivers/tty/serial/qcom_geni_serial.c              |  163 +-
 drivers/tty/serial/samsung.c                       |    5 +-
 drivers/tty/serial/sccnxp.c                        |   54 +-
 drivers/tty/serial/serial-tegra.c                  |   10 +-
 drivers/tty/serial/serial_core.c                   |   22 +-
 drivers/tty/serial/sh-sci.c                        |   29 +-
 drivers/tty/serial/suncore.c                       |    8 +-
 drivers/tty/serial/sunsu.c                         |    4 +-
 drivers/tty/serial/uartlite.c                      |   97 +-
 drivers/tty/serial/xilinx_uartps.c                 |   17 +-
 drivers/tty/sysrq.c                                |   18 +-
 drivers/tty/tty_io.c                               |   14 +-
 drivers/tty/tty_ldisc.c                            |   16 +
 drivers/tty/tty_ldsem.c                            |   62 +-
 include/linux/backing-dev-defs.h                   |    8 +
 include/linux/font.h                               |    4 +-
 include/linux/lantiq.h                             |   23 +
 include/linux/serdev.h                             |    2 +-
 include/linux/serial_8250.h                        |    4 +
 include/linux/serial_core.h                        |   38 +-
 include/linux/tty.h                                |    7 +
 lib/fonts/Kconfig                                  |   10 +
 lib/fonts/Makefile                                 |    1 +
 lib/fonts/font_ter16x32.c                          | 2072 ++++++++++++++++++++
 lib/fonts/fonts.c                                  |    4 +
 56 files changed, 3047 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 include/linux/lantiq.h
 create mode 100644 lib/fonts/font_ter16x32.c

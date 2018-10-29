Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25678C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84B02082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RukCF7Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84B02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJ2XdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeJ2XdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:33:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19DA12082D;
        Mon, 29 Oct 2018 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540824267;
        bh=FySykbuIxaCxXQD8rHeULh6DfjUrudcEHGr0IkKPcsk=;
        h=Date:From:To:Cc:Subject:From;
        b=RukCF7IphJzfHF9ZSJKHJfOfUPLpefRWHhGC5jKKVwWt+kX0OrfJO9D4C9k0Uzmfx
         V6EiD98qqHcsn0pKa40iHAk3wjmz/q7QjcBMKo/4BMfMaNRIuu8nnjhlTrSea+BacQ
         t8yuRzAQc+WkDpHIbBMQr5aQiU7aEf+1bqKulH7o=
Date:   Mon, 29 Oct 2018 15:44:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 4.20-rc1
Message-ID: <20181029144432.GA2127@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-4.20-rc1

for you to fetch changes up to 59eaeba63a171127a90bb76187536ba66076af40:

  of: base: Change logic in of_alias_get_alias_list() (2018-10-15 16:16:06 +0200)

----------------------------------------------------------------
TTY/Serial patches for 4.20-rc1

Here is the big tty and serial pull request for 4.20-rc1

Lots of little things here, including a merge from the SPI tree in order
to keep things simpler for everyone to sync around for one platform.

Major stuff is:
	- tty buffer clearing after use
	- atmel_serial fixes and additions
	- xilinx uart driver updates
and of course, lots of tiny fixes and additions to individual serial
drivers.

All of these have been in linux-next with no reported issues for a
while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Anson Huang (2):
      tty: serial: imx: add lock for registers save/restore
      tty: serial: imx: add pinctrl sleep/default mode switch for suspend

Anton Vasilyev (1):
      serial: mxs-auart: Fix potential infinite loop

Baolin Wang (5):
      serial: sprd: Remove unused structure
      serial: sprd: Use readable macros instead of magic number
      serial: sprd: Remove unnecessary resource validation
      serial: sprd: Change 'int' to 'unsigned int'
      serial: sprd: Fix the indentation issue

Biju Das (1):
      dt-bindings: serial: sh-sci: Document r8a7744 bindings

Chris Brandt (1):
      serial: sh-sci: Add earlycon for R7S9210

Dai Okamura (1):
      serial: 8250_uniphier: add auto-flow-control support

Douglas Anderson (1):
      tty: serial: qcom_geni_serial: Fix serial when not used as console

Geert Uytterhoeven (3):
      Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
      Revert "serial: sh-sci: Allow for compressed SCIF address"
      tty: serial: qcom_geni_serial: Drop useless check for dev.of_node

Greg Kroah-Hartman (7):
      Merge tag 'ib-mfd-spi-tty-v4.20' of git://git.kernel.org/.../lee/mfd into tty-next
      Merge tag 'ib-mfd-spi-tty-v4.20-1' of git://git.kernel.org/.../lee/mfd into tty-next
      Merge 4.19-rc4 into tty-next
      Merge 4.19-rc6 into tty-next
      Revert "serial:serial_core: Allow use of CTS for PPS line discipline"
      Merge 4.19-rc7 into tty-next
      tty: wipe buffer if not echoing data

He Zhe (2):
      kgdboc: Passing ekgdboc to command line causes panic
      kgdboc: Change printk to the right fashion

Hiromitsu Yamasaki (1):
      serial: sh-sci: Add r8a77990 support

Jiri Slaby (1):
      TTY: tty_buffer, warn on leaks

John Garry (1):
      serial: 8250_of: Fix for lack of interrupt support

Lance Roy (1):
      TTY: sn_console: Replace spin_is_locked() with spin_trylock()

Laura Abbott (2):
      kgdboc: Fix restrict error
      kgdboc: Fix warning with module build

Lee Jones (4):
      dt-bindings: mfd: atmel-usart: Correct interrupts property to include IRQ number
      MAINTAINERS: Change Radu's email address
      spi: at91-usart: Make local functions static
      mfd: at91-usart: Include Device Tree header

Linus Torvalds (1):
      tty: wipe buffer.

Lokesh Vutla (1):
      serial: 8250_omap: Make 8250_omap driver driver depend on ARCH_K3

Marek Szyprowski (1):
      serial: samsung: Enable baud clock for UART reset procedure in resume

Marek Vasut (1):
      serial: 8250: Fix clearing FIFOs in RS485 mode again

Masahiro Yamada (2):
      serial: 8250_uniphier: remove unused "fifo-size" property
      serial: 8250_uniphier: flatten probe function

Michal Simek (15):
      serial: uartps: console_setup() can't be placed to init section
      serial: uartps: Do not initialize field to zero again
      serial: uartps: Do not use static struct uart_driver out of probe()
      serial: uartps: Move alias reading higher in probe()
      serial: uartps: Move register to probe based on run time detection
      serial: uartps: Fill struct uart_driver in probe()
      serial: uartps: Change logic how console_port is setup
      serial: uartps: Register own uart console and driver structures
      serial: uartps: Move Port ID to device data structure
      serial: uartps: Enable automatic flow control
      of: base: Introduce of_alias_get_alias_list() to check alias IDs
      serial: uartps: Change uart ID port allocation
      serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES
      of: base: Fix english spelling in of_alias_get_alias_list()
      of: base: Change logic in of_alias_get_alias_list()

Miles Chen (1):
      tty: check name length in tty_find_polling_driver()

Nava kishore Manne (1):
      serial: uartps: Fix suspend functionality

Nicolas Ferre (2):
      tty/serial_core: add ISO7816 infrastructure
      tty/serial: atmel: add ISO7816 support

Phil Elwell (2):
      sc16is7xx: Fix for multi-channel stall
      sc16is7xx: Fix for "Unexpected interrupt: 8"

Radu Pirea (6):
      MAINTAINERS: Add AT91 USART MFD entry
      dt-bindings: Add binding for atmel-usart in SPI mode
      mfd: at91-usart: Add MFD driver for USART
      MAINTAINERS: Add AT91 USART SPI entry
      spi: at91-usart: Add driver for at91-usart as SPI
      tty/serial: atmel: Change the driver to work under at91-usart MFD

Rob Herring (1):
      tty: Convert to using %pOFn instead of device_node.name

Sebastian Andrzej Siewior (1):
      serial: 8250: drop the printk from serial8250_interrupt()

Shubhrajyoti Datta (4):
      tty: serial: uartlite: Enable clocks at probe
      tty: serial: uartlite: Move uart register to probe
      tty: serial: uartlite: remove console_init
      tty: serial: uartlite: Use dynamic array for console port

Steve Sakoman (1):
      serial:serial_core: Allow use of CTS for PPS line discipline

Tobin C. Harding (2):
      tty_port: Remove incorrect whitespace after comments
      serial: docs: Fix filename for serial reference implementation

Ulrich Hecht (1):
      serial: sh-sci: do not warn if DMA transfers are not supported

Vabhav Sharma (1):
      serial: fsl_lpuart: Remove the alias node dependence

Wei Yongjun (1):
      serial: uartps: Fix missing unlock on error in cdns_get_id()

YueHaibing (1):
      tty: serial: remove set but not used variable 'error'

jun qian (1):
      tty:serial:imx: use spin_lock instead of spin_lock_irqsave in isr

 .../bindings/{serial => mfd}/atmel-usart.txt       |  25 +-
 .../bindings/serial/renesas,sci-serial.txt         |   6 +
 .../devicetree/bindings/serial/uniphier-uart.txt   |   3 +-
 Documentation/serial/driver                        |   2 +-
 Documentation/serial/serial-iso7816.txt            |  83 ++++
 MAINTAINERS                                        |  16 +
 arch/alpha/include/uapi/asm/ioctls.h               |   2 +
 arch/mips/include/uapi/asm/ioctls.h                |   2 +
 arch/parisc/include/uapi/asm/ioctls.h              |   2 +
 arch/powerpc/include/uapi/asm/ioctls.h             |   2 +
 arch/sh/include/uapi/asm/ioctls.h                  |   2 +
 arch/sparc/include/uapi/asm/ioctls.h               |   2 +
 arch/xtensa/include/uapi/asm/ioctls.h              |   2 +
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/at91-usart.c                           |  72 ++++
 drivers/of/base.c                                  |  54 +++
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-at91-usart.c                       | 432 +++++++++++++++++++++
 drivers/tty/ehv_bytechan.c                         |  12 +-
 drivers/tty/n_tty.c                                |  20 +-
 drivers/tty/serial/8250/8250_core.c                |   6 +-
 drivers/tty/serial/8250/8250_of.c                  |  22 +-
 drivers/tty/serial/8250/8250_port.c                |  29 +-
 drivers/tty/serial/8250/8250_uniphier.c            |  62 +--
 drivers/tty/serial/8250/Kconfig                    |   2 +-
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/atmel_serial.c                  | 232 +++++++++--
 drivers/tty/serial/atmel_serial.h                  |   3 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   8 +-
 drivers/tty/serial/fsl_lpuart.c                    |  12 +-
 drivers/tty/serial/imx.c                           |  38 +-
 drivers/tty/serial/kgdboc.c                        |  46 ++-
 drivers/tty/serial/mxs-auart.c                     |   3 +-
 drivers/tty/serial/pmac_zilog.c                    |   8 +-
 drivers/tty/serial/qcom_geni_serial.c              |  69 ++--
 drivers/tty/serial/samsung.c                       |   8 +
 drivers/tty/serial/sc16is7xx.c                     |  47 ++-
 drivers/tty/serial/serial_core.c                   |  60 +++
 drivers/tty/serial/sh-sci.c                        |   9 +-
 drivers/tty/serial/sn_console.c                    |  15 +-
 drivers/tty/serial/sprd_serial.c                   |  98 +++--
 drivers/tty/serial/uartlite.c                      |  71 ++--
 drivers/tty/serial/xilinx_uartps.c                 | 303 ++++++++++-----
 drivers/tty/tty_buffer.c                           |  13 +-
 drivers/tty/tty_io.c                               |   2 +-
 drivers/tty/tty_port.c                             |   7 -
 include/dt-bindings/mfd/at91-usart.h               |  17 +
 include/linux/of.h                                 |  10 +
 include/linux/serial_core.h                        |   3 +
 include/uapi/asm-generic/ioctls.h                  |   2 +
 include/uapi/linux/serial.h                        |  17 +
 53 files changed, 1584 insertions(+), 397 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 Documentation/serial/serial-iso7816.txt
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

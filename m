Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521042812-2-1211742582215973741
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042812; b=RDxFwPiEmchr4mUL9ss9EzlLS1WBkc9vO6hfdvr6E6Y1rLc
    YiESxyZAWGXFTVc1ZM/YUnOOeM8/DDHtsmYE4xsl4m5Y5SLjAbhYpJw53PmzChxU
    QHHf7fiA8FY2chWt74RaJQW09p61PArbc7vZvorpiEYu4iZWZKXNwdaDIYu9iqCP
    r+q40h8PdRpQTR3wSV7+9XWMpb56Y3Z7iI31uQm4EFz/6ML6I4iRz42vVWlk1pF4
    HNE3LYMEUZRph5mPrCs6EXMGh+UhmGJ6rdJDLCUnKUOYoYBCcjLzR6uwlKCNXeNm
    iRNp+nwZeJsm9cZs7nVaPoDgAJLPYl/wV0/GxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521042812;
    bh=3kA2nEXoiJZip789YzoQ3A3ct71FyVi4ZW6og080xP0=; b=qEbdBQQqOZKg
    Kl1P/YtunQjlw8Ec7FEmaqg9FmVebwbLJDByAi8OTIuSIXzZaw6FeXVLQ1/1M7Rs
    rh0ep2dXzUYWz3DXUeyxk7v8aR6iTtd28A02s1d0k1XjfWh5ggtCBvM5mcfc7++d
    +b/Bq0IZi0UaLSvVpx7GVMzabhu9o2s9v7K9kgmmb63TkSEpb62f3Z/Bwkzd+p+x
    Pk18ie5RFg2vwLb2FPwPvVYBgNOBziZwngsMK/LKTwwj/KTZgsYAx4HzzT0hW5GG
    viVYqDr8HDkMF0JqXOZB9JffUbzBPqmBlOEXUyF7OnLyExkq7sbXP9hLCdsVcA4F
    Jp2dHzMVuA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCNPx3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:53:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48563 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCNPx2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 11:53:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 41/47] serial: remove blackfin drivers
Date: Wed, 14 Mar 2018 16:35:54 +0100
Message-Id: <20180314153603.3127932-42-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:0u8bJ/qfdr7ab/xVN/szAGHy5+ICHOm2kQ71o92jwiE9m0zglNr
 HdJ5dzRBgv3NqFibhF7VVFjN8kdlSWh+XTY358rYs4oEQOULBJkjouTAi105cb22KHaPIYF
 uhi18jwVXC5brAv+a/qqr9i+vyylSLBdOM2ZkFJcX9KHzyR2lXZ6ReinMjuI1xdKuXd/r6A
 w7K1cvXHLPT5KykvzJEGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4N/AJ9O7jyI=:Dl7e+bH8UtExNqdMShagyI
 /HWtq+iVxmOaieH7cyFqzZL/OTwE4/Xs9WMVC9isME5Lxvi0NsI9ckS6eKYNHOsnpRr8Ov6gg
 vRQD8gZyGtjAI664kZwYa1qu3J0bDU8tZ6AhJ9Z4UR1PA9ndl+OKV9GxxvBPh1BDaQYzhciad
 88o8R7yPMzNy6UR/7YLHCor1EPny41YRFJALc5ekTgRgZ+t5obvYyVyyCfGo2PZOgRGjRN47H
 57CeHSwRsPV+0UOdkn471nyU+AH0grau0Llz4MRV2zJ9tG9aL08SfPBo6g62UEz7jtjEnsabq
 Yeixqdb0oNLT67t92ZxmhqMTJnK77ooMBqCcqPU5O5p2iIbKmzGKS2ZYzJLlUXRrlQe/p5Twy
 MpjfEF04ZBhiai9Sic7PR0vlQsFTAdC5IkFJwVLok8hSuJYncBK5iReLZr/zEK55IrT1AqhrF
 u4/msuI1w3Mw9p9lnyHCbTEB32D5iwg31k2DseeE0vJ30wXjkX9WrNoQALiUCArHLxpnspCjL
 IA75ilPV/SyLHMXeWvpsKA68KLxX+B0dzdqa5IQD3qEda2eoAMTcX2WQbKmUdLfjW28VUCai5
 Tf7OGmCoFEAqvTAoS2nxTPeOBToERJ/d2htLK0gG2OLlfeqr+gWX0tuGv6nPmmj1kT05Uc80B
 5QdGqkSw4LZtKkjFT3nxbf0HKw2VV/vwh+Rby5p+1MQnc3O8azGqK9Y3lBKXs8vUVjpK44rzY
 MRBxEq51yQ9N6wiZ8sVxMuqeYaPr06/B03gKeA==
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The blackfin architecture is getting removed, so both the bfin_uart
and bfin_sport_uart can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/Kconfig           |  149 ----
 drivers/tty/serial/Makefile          |    2 -
 drivers/tty/serial/bfin_sport_uart.c |  937 --------------------
 drivers/tty/serial/bfin_sport_uart.h |   86 --
 drivers/tty/serial/bfin_uart.c       | 1551 ----------------------------------
 5 files changed, 2725 deletions(-)
 delete mode 100644 drivers/tty/serial/bfin_sport_uart.c
 delete mode 100644 drivers/tty/serial/bfin_sport_uart.h
 delete mode 100644 drivers/tty/serial/bfin_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f6e09326042d..031552eb3f65 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -498,92 +498,6 @@ config SERIAL_SA1100_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
-config SERIAL_BFIN
-	tristate "Blackfin serial port support"
-	depends on BLACKFIN
-	select SERIAL_CORE
-	select SERIAL_BFIN_UART0 if (BF531 || BF532 || BF533 || BF561)
-	help
-	  Add support for the built-in UARTs on the Blackfin.
-
-	  To compile this driver as a module, choose M here: the
-	  module is named bfin_uart.ko.
-
-config SERIAL_BFIN_CONSOLE
-	bool "Console on Blackfin serial port"
-	depends on SERIAL_BFIN=y
-	select SERIAL_CORE_CONSOLE
-
-choice
-	prompt "UART Mode"
-	depends on SERIAL_BFIN
-	default SERIAL_BFIN_DMA
-	help
-	  This driver supports the built-in serial ports of the Blackfin family
-	  of CPUs
-
-config SERIAL_BFIN_DMA
-	bool "DMA mode"
-	depends on !DMA_UNCACHED_NONE && KGDB_SERIAL_CONSOLE=n
-	help
-	  This driver works under DMA mode. If this option is selected, the
-	  blackfin simple dma driver is also enabled.
-
-config SERIAL_BFIN_PIO
-	bool "PIO mode"
-	help
-	  This driver works under PIO mode.
-
-endchoice
-
-config SERIAL_BFIN_UART0
-	bool "Enable UART0"
-	depends on SERIAL_BFIN
-	help
-	  Enable UART0
-
-config BFIN_UART0_CTSRTS
-	bool "Enable UART0 hardware flow control"
-	depends on SERIAL_BFIN_UART0
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_UART1
-	bool "Enable UART1"
-	depends on SERIAL_BFIN && (!BF531 && !BF532 && !BF533 && !BF561)
-	help
-	  Enable UART1
-
-config BFIN_UART1_CTSRTS
-	bool "Enable UART1 hardware flow control"
-	depends on SERIAL_BFIN_UART1
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_UART2
-	bool "Enable UART2"
-	depends on SERIAL_BFIN && (BF54x || BF538 || BF539)
-	help
-	  Enable UART2
-
-config BFIN_UART2_CTSRTS
-	bool "Enable UART2 hardware flow control"
-	depends on SERIAL_BFIN_UART2
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_UART3
-	bool "Enable UART3"
-	depends on SERIAL_BFIN && (BF54x)
-	help
-	  Enable UART3
-
-config BFIN_UART3_CTSRTS
-	bool "Enable UART3 hardware flow control"
-	depends on SERIAL_BFIN_UART3
-	help
-	  Enable hardware flow control in the driver.
-
 config SERIAL_IMX
 	tristate "IMX serial port support"
 	depends on HAS_DMA
@@ -1231,69 +1145,6 @@ config SERIAL_SC16IS7XX_SPI
           This is additional support to exsisting driver.
           You must select at least one bus for the driver to be built.
 
-config SERIAL_BFIN_SPORT
-	tristate "Blackfin SPORT emulate UART"
-	depends on BLACKFIN
-	select SERIAL_CORE
-	help
-	  Enable SPORT emulate UART on Blackfin series.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called bfin_sport_uart.
-
-config SERIAL_BFIN_SPORT_CONSOLE
-	bool "Console on Blackfin sport emulated uart"
-	depends on SERIAL_BFIN_SPORT=y
-	select SERIAL_CORE_CONSOLE
-
-config SERIAL_BFIN_SPORT0_UART
-	bool "Enable UART over SPORT0"
-	depends on SERIAL_BFIN_SPORT && !(BF542 || BF544)
-	help
-	  Enable UART over SPORT0
-
-config SERIAL_BFIN_SPORT0_UART_CTSRTS
-	bool "Enable UART over SPORT0 hardware flow control"
-	depends on SERIAL_BFIN_SPORT0_UART
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_SPORT1_UART
-	bool "Enable UART over SPORT1"
-	depends on SERIAL_BFIN_SPORT
-	help
-	  Enable UART over SPORT1
-
-config SERIAL_BFIN_SPORT1_UART_CTSRTS
-	bool "Enable UART over SPORT1 hardware flow control"
-	depends on SERIAL_BFIN_SPORT1_UART
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_SPORT2_UART
-	bool "Enable UART over SPORT2"
-	depends on SERIAL_BFIN_SPORT && (BF54x || BF538 || BF539)
-	help
-	  Enable UART over SPORT2
-
-config SERIAL_BFIN_SPORT2_UART_CTSRTS
-	bool "Enable UART over SPORT2 hardware flow control"
-	depends on SERIAL_BFIN_SPORT2_UART
-	help
-	  Enable hardware flow control in the driver.
-
-config SERIAL_BFIN_SPORT3_UART
-	bool "Enable UART over SPORT3"
-	depends on SERIAL_BFIN_SPORT && (BF54x || BF538 || BF539)
-	help
-	  Enable UART over SPORT3
-
-config SERIAL_BFIN_SPORT3_UART_CTSRTS
-	bool "Enable UART over SPORT3 hardware flow control"
-	depends on SERIAL_BFIN_SPORT3_UART
-	help
-	  Enable hardware flow control in the driver.
-
 config SERIAL_TIMBERDALE
 	tristate "Support for timberdale UART"
 	select SERIAL_CORE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index c21835dc16b2..a9242484e821 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -29,8 +29,6 @@ obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
-obj-$(CONFIG_SERIAL_BFIN) += bfin_uart.o
-obj-$(CONFIG_SERIAL_BFIN_SPORT) += bfin_sport_uart.o
 obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_MAX310X) += max310x.o
diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
deleted file mode 100644
index 4ccca5d22f4f..000000000000
diff --git a/drivers/tty/serial/bfin_sport_uart.h b/drivers/tty/serial/bfin_sport_uart.h
deleted file mode 100644
index 4b12f45d6580..000000000000
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
deleted file mode 100644
index 4755fa696321..000000000000
-- 
2.9.0


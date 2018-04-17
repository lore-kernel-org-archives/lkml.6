Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx4+aDOqq6wCwC6D2tfrJasJFZHVPueSxZHdrmwtP5KTbuAD5DUsmQCrRZBpjPPRVw/blFqTI
ARC-Seal: i=1; a=rsa-sha256; t=1523993027; cv=none;
        d=google.com; s=arc-20160816;
        b=ib0oq4Ei8935mFWqvMjPjVnmLy27EMp8AnjIyXIrxsNKzzEGvYTNUpyM7o92xexyEP
         qBQ0Nfoy2eAYQ6ZSOco9msqbv4Qr0WpsWVjmmfV8/fMqpmsiriQud2t2Hp1+rD3PcO9b
         bapfRwWy8/Sc2KO7zYGG4uPWlvWBER9cg6HSAeYlFW0xir7E6Jb2qMBhdTMg/iRjaQQM
         EHxQB/6Pj//EjRgGhdhrj6ar+/inUHEVzqxZYRo51IWhGi+TaUlQC8IF0jYEiqdebFAP
         jSGQ1KMSot4Ebf412BLz9Bmv2w7G+XdZmXxREATS0MsbM0+tOFgYKkXfybOGjCu/l9Wn
         mBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=fM1Zer7bK0JMWf+pJ4xJ5uoBpAbmCK6jArjflAQyiaE=;
        b=O5MTL8Mns70XGz/QhiBvR3k/h+gv7M+zeMA6WlE+s5YHyALRhZllMo5tNeXA13KRV8
         8INr5u03qhpczvsvRj5UGobsO4W1wut0nIMw201ldUI9vMABKZAzncEPvy6AR65/31N3
         YdK6YqBmOFCCmLNCBuut1wmq7Z1KMZ/OCFLW2mQN4UmTH0CmbjHBfprbox48ObC7NxA5
         vYBmH4EzqVNmWcJR3JTNtbxOphMYpu3M7438Gk655jycZkNEnDVbQycg05h1sKbF7qoJ
         V6qEaQdR/3MgSIChO5LFzTyasGLdSml8kVyTpi/dpwIpGkeEmC8avA4NY2tTZsXfVeHI
         8X5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:1a is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:1a is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Alan Tull <atull@kernel.org>,
	Moritz Fischer <mdf@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Matias Bjorling <mb@lightnvm.io>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Richard Weinberger <richard@nod.at>,
	Kalle Valo <kvalo@codeaurora.org>,
	Ohad Ben-Cohen <ohad@wizery.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>
Cc: iommu@lists.linux-foundation.org,
	linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-ide@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	linux-fpga@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 17/20] serial: Remove depends on HAS_DMA in case of platform dependency
Date: Tue, 17 Apr 2018 19:49:17 +0200
Message-Id: <1523987360-18760-18-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598022513220291064?=
X-GMAIL-MSGID: =?utf-8?q?1598022513220291064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
In most cases this other symbol is an architecture or platform specific
symbol, or PCI.

Generic symbols and drivers without platform dependencies keep their
dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
cannot work anyway.

This simplifies the dependencies, and allows to improve compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Acked-by,
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/tty/serial/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0f058df0b0701fe2..25b8c0a8a50397d6 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -115,7 +115,6 @@ config SERIAL_SB1250_DUART_CONSOLE
 
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
-	depends on HAS_DMA
 	depends on ARCH_AT91 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
@@ -500,7 +499,6 @@ config SERIAL_SA1100_CONSOLE
 
 config SERIAL_IMX
 	tristate "IMX serial port support"
-	depends on HAS_DMA
 	depends on ARCH_MXC || COMPILE_TEST
 	select SERIAL_CORE
 	select RATIONAL
@@ -1262,7 +1260,6 @@ config SERIAL_PCH_UART_CONSOLE
 
 config SERIAL_MXS_AUART
 	tristate "MXS AUART support"
-	depends on HAS_DMA
 	depends on ARCH_MXS || MACH_ASM9260 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
@@ -1473,7 +1470,6 @@ config SERIAL_SPRD_CONSOLE
 config SERIAL_STM32
 	tristate "STMicroelectronics STM32 serial port support"
 	select SERIAL_CORE
-	depends on HAS_DMA
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
 	  This driver is for the on-chip Serial Controller on
-- 
2.7.4

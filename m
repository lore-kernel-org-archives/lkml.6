Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELtYiLS8WnOVhhKm6Wh8/fHnD2oxvIDtQDT40JRSR5a/Ogmwfcay0s0dgwedWFNAyspmq631
ARC-Seal: i=1; a=rsa-sha256; t=1521208366; cv=none;
        d=google.com; s=arc-20160816;
        b=L41uV3yaWYvGKh5Wyr8J7vwmLg0ZZ+SGvt+igpAfpKnBuExC192A0oHzAmsxMVsBqk
         s+9mnkKMDDjjbk0QEwFErlNTOkTmzhYFT9gx/SVeVoEYlewJ37HG22Rpn/2s73TRogdl
         izmtMeoNe6W+uYm27vDF+jGDDm0WqDknHt579+wDfza+8wGH1nYSny84wF0ep1fj3b8h
         3UOIp2lIE0E8y6cRAOv2jCFOkkNTBwj6TPwTGUx/JNx+Uy8LA7b/S9W0U5Qlhq848AzY
         bsI1FTKhkXoTfIEf4UtSiNqPALAmt57fA1YGLcBmRUbO+5dnYP7xu2/nEO7I9sEOU62m
         ezXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=OSYnrAYqRpcncSRGYvYpIAQ7qeWjiBYPc0LV+x1zpNg=;
        b=S8sv5HWThMwyDx7uME2xVj9r/9BES+vmeh7zYuxqxUI8l5ZKAZcT1Z2aLUfe+IoziN
         eTB7KOcPiUX7aQekZ+i6auz5v4K5oLL9VBOhNE8DXazyTTSN7thVgN6t3pJxTU5s8fkU
         3mCavsVG/qMBNXcUXelWcPEPaAg0kZMJ3M8kgE/uPyxlMLxleuDtQM5loIIR+chxkmVj
         uc/ef+SOlbmRci7oxVqQIEbSZDFMTA8zIHmacgP0Jysz+bnGQujSCYwEzaH6YMSfXDrI
         xIdCArhAxrocQBlVHOdgwMI4jtUBb8DkuR0NnsAbfEL5DAcWbh5baa+T/oT+I+fIi1T3
         h53A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
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
	linux-scsi@vger.kernel.org,
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
Subject: [PATCH v2 18/21] serial: Remove depends on HAS_DMA in case of platform dependency
Date: Fri, 16 Mar 2018 14:51:51 +0100
Message-Id: <1521208314-4783-19-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102583994466893?=
X-GMAIL-MSGID: =?utf-8?q?1595102583994466893?=
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
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/tty/serial/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3682fd3e960cbd64..a0ea146a2ef5af53 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -115,7 +115,6 @@ config SERIAL_SB1250_DUART_CONSOLE
 
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
-	depends on HAS_DMA
 	depends on ARCH_AT91 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
@@ -586,7 +585,6 @@ config BFIN_UART3_CTSRTS
 
 config SERIAL_IMX
 	tristate "IMX serial port support"
-	depends on HAS_DMA
 	depends on ARCH_MXC || COMPILE_TEST
 	select SERIAL_CORE
 	select RATIONAL
@@ -1436,7 +1434,6 @@ config SERIAL_PCH_UART_CONSOLE
 
 config SERIAL_MXS_AUART
 	tristate "MXS AUART support"
-	depends on HAS_DMA
 	depends on ARCH_MXS || MACH_ASM9260 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
@@ -1656,7 +1653,6 @@ config SERIAL_SPRD_CONSOLE
 config SERIAL_STM32
 	tristate "STMicroelectronics STM32 serial port support"
 	select SERIAL_CORE
-	depends on HAS_DMA
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
 	  This driver is for the on-chip Serial Controller on
-- 
2.7.4

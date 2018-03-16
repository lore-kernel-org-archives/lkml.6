Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELuBM50jr965p1OaNddx5HCYwf/ApGPHbyLtaE8BxpR48g4IaS4GicCDYNuPYxJBFhGoVJYN
ARC-Seal: i=1; a=rsa-sha256; t=1521208373; cv=none;
        d=google.com; s=arc-20160816;
        b=vekeJ2TOEQ7sOPapNulQAiPuwlcYkbU6Kbuatmt6hu4muWMaoS3Ry3gKK4WogGz54L
         WC6YRy+zOVAVQBtnJQsvUPuQak1M9p3TiZY858ShRHqDvFmVt2RWyVTXr5FKs/uRbufv
         bOzubupx5Lyr8bBUk3D2gqNMddYTtcz7YCrKmeH40Eg8zyI+vRxQ3CwgvQNILZzC4WCb
         CotB+jxpCyu4NTDAevGU1j4/PllCsFHphFjGax6vW+M76oCFsU08XuFgzTSdZrT9qn5s
         2T6VRfrmBXE5KyQPPe1/gM25oZBVGKRGCBGELbkhLqXssdEHLJnL6H3tU0eiMcNL+L9m
         sEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wc7B4MHZO/3seTOwpgO889k5hOy0F/v9WODZZ9IRg4o=;
        b=Wn3BWAUE8rcpdbFQMeBsuErlmanf0VNz226nGVMe0/sNDQeGgWvUb+FIPU652axLaP
         D93Blgfeo9v7EpbfnhqoHSDeK0CcCtAcM5dAlk/TiyxGJvH8jJDMd6vCgvSjA5xe9Yph
         m9wliwQjppB91DDfaRKcxZkJtK+JEPpM4jhTF4B6twq9hCpHChvX1pmSEbN9eN61xYw9
         gWdMCVN26XIkMRnool/Gc9gHrZajrtzb11tCme3IyEo8fWB+sR1twZXBnloCcnHID/Ea
         zhEg3CBIpZYARNV8ey8LaMOFSSM9CLBw40pp7OFWltBhzDQJHMn43ef4gtSR6SXMzy0C
         EKOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
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
Subject: [PATCH v2 21/21] usb: Remove depends on HAS_DMA in case of platform dependency
Date: Fri, 16 Mar 2018 14:51:54 +0100
Message-Id: <1521208314-4783-22-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102591173946332?=
X-GMAIL-MSGID: =?utf-8?q?1595102591173946332?=
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
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com> [drivers/usb/gadget/]
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/usb/gadget/udc/Kconfig | 4 ++--
 drivers/usb/mtu3/Kconfig       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 0875d38476ee9395..9c3b4f86965e80c7 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -179,7 +179,7 @@ config USB_R8A66597
 
 config USB_RENESAS_USBHS_UDC
 	tristate 'Renesas USBHS controller'
-	depends on USB_RENESAS_USBHS && HAS_DMA
+	depends on USB_RENESAS_USBHS
 	help
 	   Renesas USBHS is a discrete USB host and peripheral controller chip
 	   that supports both full and high speed USB 2.0 data transfers.
@@ -192,7 +192,7 @@ config USB_RENESAS_USBHS_UDC
 config USB_RENESAS_USB3
 	tristate 'Renesas USB3.0 Peripheral controller'
 	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on EXTCON && HAS_DMA
+	depends on EXTCON
 	help
 	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
 	   that supports super, high, and full speed USB 3.0 data transfers.
diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 25cd61947beea51e..c0c0eb88e5eafc74 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -2,7 +2,7 @@
 
 config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
-	depends on EXTCON && (USB || USB_GADGET) && HAS_DMA
+	depends on EXTCON && (USB || USB_GADGET)
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
-- 
2.7.4

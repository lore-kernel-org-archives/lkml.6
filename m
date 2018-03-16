Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELspQU0ydeF6qjC9JQlO0b5tO+HvuRwBallBms0fGBgzZgeYNb9XnXn6VWUnfNd9IdIsue4H
ARC-Seal: i=1; a=rsa-sha256; t=1521208373; cv=none;
        d=google.com; s=arc-20160816;
        b=m8US8IsgHSiq9oS+bgPsnhgwcKV+rABNklvSk+eIoGJ4WxcT3ZdkgtUscouashdIZ3
         JEkr232d+lLUs+FEdya8tXrundQhaALYYHG2dk45VZSokDkNInUfF0P5MimWQfykDCy3
         r6t39rbLWAJmLPNFVMEhSYdIz2ifpd7Bqhsbb62frMI6QEbpn+SpL3eu4zaoU23TK7Tb
         63I526D8uFQlTKDyh34L5kRSkz+Vz2rtpAfHnv7Rcm5OYwj6ZvcezBfHGTQ6lAlitrre
         BI84ZOtx79XTkrIzszs4DWj3MX/ry+ZCBHzZT3U/+3gmYCTwRCNV/kQvdkYtET1xv5un
         XGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GznvkEnDKo//kC+AQ7jUmmtEihD0g3JT2nu0Fs2gMRo=;
        b=UbXjy6AqEpB5lzPT1FCc5jr892wz2kKtw6qv8/2JudWsggGNvrCSA3y5NSUjbQrMMQ
         b8K4MF1uckRziQVZKJUF2mMiyjbakE1cZ4BnqPaIiaGEr0XcpOAlcuEMtpI1/pAVyeEY
         7syIXxUJrf3PsDYjTI3J9lH10H3un1g0wfnlycAiTRBLCH1kz9MTEyt7aUdh9KzkSDoC
         DPxaO5PBzotw4Aq/11Hwwy6EWvLjGQkHAXPFucvCkJKP5p0GMzkEH5JrXfFXKzK1Svy4
         hXdXXF1Rzccng/eiNB72NQhWM2j7Soee4hSksaYOJMfB2IvN4UtzuU4rb29mUtqC9nPk
         OXSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:13 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
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
Subject: [PATCH v2 20/21] staging: vc04_services: Remove depends on HAS_DMA in case of platform dependency
Date: Fri, 16 Mar 2018 14:51:53 +0100
Message-Id: <1521208314-4783-21-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102590692587571?=
X-GMAIL-MSGID: =?utf-8?q?1595102590692587571?=
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
 drivers/staging/vc04_services/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index f5aaf7d629f0fae9..98064ce2c2b47c7f 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,6 +1,5 @@
 menuconfig BCM_VIDEOCORE
 	tristate "Broadcom VideoCore support"
-	depends on HAS_DMA
 	depends on OF
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
 	default y
-- 
2.7.4

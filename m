Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2480911-1523991275-2-16576911016164175617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523991274; b=acZFVwOfvlC2Lk2sAfOsFECK7E8EOo1U/i/hoCFoWOugMjncqx
    OFlqNgzQ+7CzzWA3c5V0sNUiLYw+LNieCyFSqphvb1iumcLG/cDoQkkKd6I0FIY0
    +G3T4BcgWeE5kh2ij9UZcjIXS+UYqBomz7zo502CrXnvIbvz6TTDTdO6PTv9VKXX
    WWFrNMuI4w8QofCrqItWEI1kne2PcAZ6HfJ3lzxdn0YIOdgmJWncIbmjzFwkWR9K
    zMv/VnvPDL1VpjCJudtpQ/X6ObYTJrGqVvPICMXkfBbG2lTgLZeT3g3x/mEiZNVM
    3p4LORVbUZPj7g2WdFDtV8kpFn5ZhUWH+EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523991274; bh=3OOBL
    Ie1uNiy2mUZVDs9pNHvpaac1pnWoGBP8T+BzPs=; b=lGj15Qb3WA92tY4JOOIxl
    GoevbZebvkdWGp9nWWCL/WTOGTLdP8A2Vh83+u318M6Vo9OjVFARIe3eMzdSzIIZ
    lMy3/tRRqAceTCqQ5pgkcsOyW6n+bb1kTLjhRujXF+qVw4L7fhPtLTp00Il1d6Gz
    Rplvpo4XqSMol+7hYwA5mNpR/Ixv5H46cbM7EXo+DXqV5o5UeuvXKzo2gCJHWDVU
    GRRsIOij4qVRjK6oYfIAoeN6UMtLH2f9JoHGajkTxYv6WnlhFawTB6cd6Ci+G0gn
    MDMgwXjTTHVnQBeFIM3VvjyIaNqcnVRDKjoUo1dXOF9vg5+TJb1dCoNEmFKMIEst
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE80RJSL+G5N/psQtcqAFzcjNCh0KYzzdpM80qAPW/dBBRE3/t++QII9xLcnwE7L2IYFoNjUkExzFs+LG7aUVYV1/t/+FgmveuybMRlqSK4gkCMxUBp6
    Ut41N8tlBnqSfiBLFxeV0SStKXLAiy0fAXM7YEwxoCGYoBeNCU0x1va9mglSx5Agj+uSXxSzm4+aigHgalhoHZd5+norH2m+OjhXE1UZH0cJGJ2kBaW3sjON
    PHKSX+5uk1AEAI+BXe7Ezw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=DDOyTI_5AAAA:8 a=d5QUEaZ_3_V5qvzpo28A:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 14/20] mtd: Remove depends on HAS_DMA in case of platform
 dependency
Date: Tue, 17 Apr 2018 19:49:14 +0200
Message-Id: <1523987360-18760-15-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 linux-media@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-serial@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-remoteproc@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
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
v3:
  - Rebase to v4.17-rc1,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Drop new dependency of MTD_NAND_MARVELL on HAS_DMA,
  - Split per subsystem.
---
 drivers/mtd/nand/raw/Kconfig | 8 ++------
 drivers/mtd/spi-nor/Kconfig  | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 19a2b283fbbe627e..6871ff0fd300bb81 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -46,7 +46,7 @@ config MTD_NAND_DENALI
 config MTD_NAND_DENALI_PCI
         tristate "Support Denali NAND controller on Intel Moorestown"
 	select MTD_NAND_DENALI
-	depends on HAS_DMA && PCI
+	depends on PCI
         help
           Enable the driver for NAND flash on Intel Moorestown, using the
           Denali NAND controller core.
@@ -152,7 +152,6 @@ config MTD_NAND_S3C2410_CLKSTOP
 config MTD_NAND_TANGO
 	tristate "NAND Flash support for Tango chips"
 	depends on ARCH_TANGO || COMPILE_TEST
-	depends on HAS_DMA
 	help
 	  Enables the NAND Flash controller on Tango chips.
 
@@ -285,7 +284,7 @@ config MTD_NAND_MARVELL
 	tristate "NAND controller support on Marvell boards"
 	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_MVEBU || \
 		   COMPILE_TEST
-	depends on HAS_IOMEM && HAS_DMA
+	depends on HAS_IOMEM
 	help
 	  This enables the NAND flash controller driver for Marvell boards,
 	  including:
@@ -447,7 +446,6 @@ config MTD_NAND_SH_FLCTL
 	tristate "Support for NAND on Renesas SuperH FLCTL"
 	depends on SUPERH || COMPILE_TEST
 	depends on HAS_IOMEM
-	depends on HAS_DMA
 	help
 	  Several Renesas SuperH CPU has FLCTL. This option enables support
 	  for NAND Flash using FLCTL.
@@ -515,7 +513,6 @@ config MTD_NAND_SUNXI
 config MTD_NAND_HISI504
 	tristate "Support for NAND controller on Hisilicon SoC Hip04"
 	depends on ARCH_HISI || COMPILE_TEST
-	depends on HAS_DMA
 	help
 	  Enables support for NAND controller on Hisilicon SoC Hip04.
 
@@ -529,7 +526,6 @@ config MTD_NAND_QCOM
 config MTD_NAND_MTK
 	tristate "Support for NAND controller on MTK SoCs"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on HAS_DMA
 	help
 	  Enables support for NAND controller on MTK SoCs.
 	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 89da88e591215db1..c493b8230a38c059 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -71,7 +71,7 @@ config SPI_FSL_QUADSPI
 config SPI_HISI_SFC
 	tristate "Hisilicon SPI-NOR Flash Controller(SFC)"
 	depends on ARCH_HISI || COMPILE_TEST
-	depends on HAS_IOMEM && HAS_DMA
+	depends on HAS_IOMEM
 	help
 	  This enables support for hisilicon SPI-NOR flash controller.
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

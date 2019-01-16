Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29120859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF4oTYU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbfAPGtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:49:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55477 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfAPGtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:49:45 -0500
Received: by mail-it1-f194.google.com with SMTP id m62so1476749ith.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePRRANffvCjiHiv6FsBbr+wmBpF6QbDYYwGweWE2XRw=;
        b=DF4oTYU9lRqaxwpkvnt7zBCsJJR8syFogNjTtf5ZH6D1yQKhiP5wde6ASpNlZUMjlu
         wpVzwnUDXfM59ptNxKQ8cNgcMyn1XMII6HAI/YUhn1keuRyWbPa/g79aeHZeFDivdNap
         xenKtTVHRHPSbrQCBXz3TMpJRzQ4P1JQn4+ytJnoWCtTVm4MIHkRJsP2k0zwjlXfeuUl
         EXCX8oRJ35vGX3LWiR9250JK6DYoFnNtj6I8a1TKV0O6EsplUNye+Xob9Y81rtvPvMQn
         vlBljS6QyzZ+lXQyoGNYTtZJSXd07MF5RLYcN/mPV9cReE1hA8i61x4MYO/TulapooRj
         o7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePRRANffvCjiHiv6FsBbr+wmBpF6QbDYYwGweWE2XRw=;
        b=P03lzBi3hnS3UVWGYGh3vf8RzUdI91S0Wr0li0fHA7LbeRyFMICLc1nNpwH0OXhq1E
         9jUCY8vtu8E2iCdvt/XFtp3tF3wiCTOnKu41Yc3AQQRyNJrTipnkghWMAStvkb/+u18W
         cbAjaaLNvmk6AJ1hzyZgMuB1o/J/2NMwA7Uy/o9s3rbnogiXzx2rENjR7dpW6S7u4kOm
         P3acZS9A7Ihg4gVUG3CHemGwQSOISo1NQNW3W70p/+1Rz0tEIgdTumeAAcu48GVTLxcX
         dOXa+SMFcA4VC98xf/VFMUQzCqL1GlkTz/D71TFth0sRh5eeYccIeXaVi8QwwJfgl01t
         0EuQ==
X-Gm-Message-State: AJcUukfLBxEAjGohUlZ9B6SGr7tGnBTwmWxc6SSi1uzSmBE6xResw1XP
        aBiNKf3qH5M5xpjwy7Qmzts=
X-Google-Smtp-Source: ALg8bN7PGJpKnPEKa2C7gDSGBgB1/5LudDaog3mn+OwYWkbmBLBWEcHvllW/ax4rDzXAjgrcgIleeA==
X-Received: by 2002:a02:284:: with SMTP id 126mr4502520jau.47.1547621383940;
        Tue, 15 Jan 2019 22:49:43 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id h14sm2113409ior.41.2019.01.15.22.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 22:49:43 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        NeilBrown <neil@brown.name>, sergio.paracuellos@gmail.com
Subject: [PATCH v5] staging: Mediatek: Use individual config flags in Makefile
Date:   Tue, 15 Jan 2019 23:48:43 -0700
Message-Id: <20190116064842.5911-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115174346.GA11832@kroah.com>
References: <20190115174346.GA11832@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These drivers can be useful on other MT76xx SoCs, which have compatible
peripherals.  The drivers were selectable in Kconfig, but they were
quietly excluded from the build because the SOC_MT7621 chip was not
selected.  So, make the Makefiles use the same flags as Kconfig for
these drivers.

mt7621-dma and mt7621-dts are left alone because they truly do require
that SoC.

I have personally confirmed that the mt7621-spi driver works on the
MT7688, which was what prompted this change.

Cc: linux-kernel@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Cc: NeilBrown <neil@brown.name>
Cc: sergio.paracuellos@gmail.com
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
Changelog:
  v2:
    - Also make the change for skipped/forgotten drivers such as mt7621-eth
  v3..v4:
    - Rebase against staging-testing
    - Also make the change for new PCIe PHY driver
    - Slightly change commit wording
  v5:
    - Fix dependency issue in mt7621-mmc/Kconfig; it now needs to
      explicitly depend on RALINK because SOC_MT7621 is not required now
    - Remove check for nonexistent config MTD_NAND_RALINK from
      mt7621-mmc/Kconfig

 drivers/staging/Makefile                | 14 +++++++-------
 drivers/staging/mt7621-mmc/Kconfig      |  2 +-
 drivers/staging/mt7621-pci-phy/Makefile |  2 +-
 drivers/staging/mt7621-pci/Makefile     |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 4d563ed0bc79..cc5530cc996b 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -41,14 +41,14 @@ obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
 obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
 obj-$(CONFIG_PI433)		+= pi433/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci-phy/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-pinctrl/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-spi/
+obj-$(CONFIG_PCI_MT7621)	+= mt7621-pci/
+obj-$(CONFIG_PCI_MT7621_PHY)	+= mt7621-pci-phy/
+obj-$(CONFIG_PINCTRL_RT2880)	+= mt7621-pinctrl/
+obj-$(CONFIG_SPI_MT7621)	+= mt7621-spi/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
-obj-$(CONFIG_SOC_MT7621)	+= ralink-gdma/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
+obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
+obj-$(CONFIG_MTK_MMC)		+= mt7621-mmc/
+obj-$(CONFIG_NET_MEDIATEK_SOC_STAGING)	+= mt7621-eth/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
 obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
diff --git a/drivers/staging/mt7621-mmc/Kconfig b/drivers/staging/mt7621-mmc/Kconfig
index c6dfe8c637dc..1eb79cd6e22f 100644
--- a/drivers/staging/mt7621-mmc/Kconfig
+++ b/drivers/staging/mt7621-mmc/Kconfig
@@ -1,6 +1,6 @@
 config MTK_MMC
 	tristate "MTK SD/MMC"
-	depends on !MTD_NAND_RALINK && MMC
+	depends on RALINK && MMC
 
 config MTK_AEE_KDUMP
 	bool "MTK AEE KDUMP"
diff --git a/drivers/staging/mt7621-pci-phy/Makefile b/drivers/staging/mt7621-pci-phy/Makefile
index 2b82ccfc28c6..a970056f05c1 100644
--- a/drivers/staging/mt7621-pci-phy/Makefile
+++ b/drivers/staging/mt7621-pci-phy/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_SOC_MT7621)       += pci-mt7621-phy.o
+obj-$(CONFIG_PCI_MT7621_PHY)       += pci-mt7621-phy.o
diff --git a/drivers/staging/mt7621-pci/Makefile b/drivers/staging/mt7621-pci/Makefile
index 607b84bedcc3..d4655a726b61 100644
--- a/drivers/staging/mt7621-pci/Makefile
+++ b/drivers/staging/mt7621-pci/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_SOC_MT7621)       += pci-mt7621.o
+obj-$(CONFIG_PCI_MT7621)       += pci-mt7621.o
-- 
2.20.1


Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1AC20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyqRWgt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfAORCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:02:52 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39761 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbfAORCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:02:51 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so5329719itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjB65PZIebC31N1Ziq25rVbpbu1WqErfH1EBrSorP7k=;
        b=JyqRWgt/FK8hoswtS3ThjZ+0IAJxLIzcCNIU+JrqPPhpAfXgBMHcuCFJsRBWXi3feX
         d0DItC18dQFpozLBkQ8oVCgFC5KqDUkhrmEFL284qYn2e6IUMEmacEPRCL8J8DOnvsQR
         ha7uz6NuboaKs+VfmkFTz78bprKBWpvVvj8c9ANkJIS5CN2LV67I/+RxXEDDOM/8cjJ7
         3nM9qCInAvBDo39bGopnD20YhygEi3XBkSkwoPlBZBqblyBAk4vrcJwnfnWXRrK3K0Pk
         4y8yGkJuq51ucEXTPXnlFZyQV7RBc3SWROEqzBKTMVfWqrKkBdGfaxBGln6p+2AcpF1Z
         AcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjB65PZIebC31N1Ziq25rVbpbu1WqErfH1EBrSorP7k=;
        b=VQSA7xXq6/HOZQ/p7Gtde37WEnb16AsRkHIj6BRHtWkjscY8iB12UevYo3IhjibbUA
         MWjhtfZMeJ4oUL0ui8xmtzoDX8kLvhxz+wJdBSE0ZM9Nz/Edc/q0GtR3pP75Zs3yZEMz
         uu3rp8tFwnGvv23hBC+t1WuklLV1wuxgRkpbtb69ac98XKJTHFU6/8TV09vmfNM6lmVt
         hgbUtSsGs2xOe3aLJus4I2o/4NWm0oG9TmqnanHgqhXcHB/dbH9qP+zQ120x9fLf5SwY
         g/3RjNK5HphNBtBC8Sjc6/XyTBe2HhxQVXz1ecGifCHUSjCaAOMCGYFJupq3HJUmOaZv
         OK0Q==
X-Gm-Message-State: AJcUukcuC1y+ACJSmbjO20vPzqvQu3P3I9ewApQxXMz8xcn06On4M+zH
        oOkdZGIpb64sUI7xx0SLgRouykiAYsM=
X-Google-Smtp-Source: ALg8bN5Y9Q3mVAe+2FPKNf7A+Gaq4PdTBjkt0AHqQ+kaLiK0XcjaJMly4yNC7puyK+gJkIhSnz3wHg==
X-Received: by 2002:a02:3f0b:: with SMTP id d11mr2915198jaa.26.1547571770027;
        Tue, 15 Jan 2019 09:02:50 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id y5sm1902486itb.42.2019.01.15.09.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 09:02:48 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        NeilBrown <neil@brown.name>, sergio.paracuellos@gmail.com
Subject: [PATCH v3] staging: Mediatek: Use individual config flags in Makefile
Date:   Tue, 15 Jan 2019 10:02:21 -0700
Message-Id: <20190115170221.26693-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115153000.GA15206@kroah.com>
References: <20190115153000.GA15206@kroah.com>
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
 drivers/staging/Makefile                | 14 +++++++-------
 drivers/staging/mt7621-pci-phy/Makefile |  2 +-
 drivers/staging/mt7621-pci/Makefile     |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

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


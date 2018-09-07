Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA331C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550FD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GRKWfw44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550FD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeIHAZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:25:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeIHAYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:24:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so15989660wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=io06vx7Rq8vLff3aAI0vGsa77/DULCcl4h6sMX7yPhA=;
        b=GRKWfw44LCAUDJ/+WW/sck+S1wTxKgSNInnBo/Q9YaXNphfnGXw06/7J3Ez1L/jTMs
         UZh2cvjefXMWm8+55e6W/IsZiQi8C1vW58SEd/NW/Bxc2Sj+NrXH8/s+81Eku6bisP96
         Ej7fZWV5UIEYHc0kZhGl1kxC+qMSr5SY/5vm7YPmXijyJE+FXtiNXq7FRPTO5saNt7Py
         gwzM6b6VlgDvekED1sXecoX9dB9t9ccYPakKTd6l4/IUfpHsIGNDVIhW1DPtbpFN0QLT
         4xxsO5xk1B/lS5gJd2RnDzOVMoatT78Fq5r2wQXSTDQOMUJ+MwM/oKH2xJYf6B6qOJtm
         RLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=io06vx7Rq8vLff3aAI0vGsa77/DULCcl4h6sMX7yPhA=;
        b=Ohd6gq5mq7z+LER/oCEi5RcN4YS0lQAHxPFBtMz2faqb4cpBc3YDP4/8bRNCMK+nba
         Gw+3k0U02I9mGrOn+cvfabGydCFV5IYzTbgKCcFOQkGx3xvm/MrH595QRyxXUlLRVUgX
         yCTUBrdKSNAk1zODiwTv3LcIUA6b+CFplazE7M3V3EXyCbrkfVleJlJIfC9fL1qIu9oL
         2azSogZwDrg/zUS+5OiMwG40ozrlzu0miWkrmTjnt9Curr7qJMbIf4B1k9CiWBSpkJyZ
         Mid8St1XJEjWAYBCHX2wHFtrenqUR3KoQGA4fQQChDdmR5A2ny8/LZfqTWIW5YQ2gq+2
         g/Yg==
X-Gm-Message-State: APzg51Ba0ABneCjYHUVorEpe7tpuqVP7B/riyjG46V/hjZrX4rPu5NCw
        0+zGJAgMdiG5umwk5rP3dOyTlw==
X-Google-Smtp-Source: ANB0VdZuSObSY2YRl1nDmXGUwpfw2IOIlmMmGYvv/dJXeEr4r3AhROdWB643QaKFXAjh3hdIbQLFQw==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr7362404wrc.88.1536349344660;
        Fri, 07 Sep 2018 12:42:24 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y17-v6sm11700133wrh.49.2018.09.07.12.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 12:42:24 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/5] ata: ahci_sunxi: use xxxsetbits32 functions
Date:   Fri,  7 Sep 2018 19:41:47 +0000
Message-Id: <1536349307-20714-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ahci_sunxi to use xxxsetbits32 functions

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci_sunxi.c | 51 ++++++++++++------------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 911710643305..0799441f1237 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/setbits.h>
 #include "ahci.h"
 
 #define DRV_NAME "ahci-sunxi"
@@ -58,34 +59,6 @@ MODULE_PARM_DESC(enable_pmp,
 #define AHCI_P0PHYCR	0x0178
 #define AHCI_P0PHYSR	0x017c
 
-static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
-{
-	u32 reg_val;
-
-	reg_val = readl(reg);
-	reg_val &= ~(clr_val);
-	writel(reg_val, reg);
-}
-
-static void sunxi_setbits(void __iomem *reg, u32 set_val)
-{
-	u32 reg_val;
-
-	reg_val = readl(reg);
-	reg_val |= set_val;
-	writel(reg_val, reg);
-}
-
-static void sunxi_clrsetbits(void __iomem *reg, u32 clr_val, u32 set_val)
-{
-	u32 reg_val;
-
-	reg_val = readl(reg);
-	reg_val &= ~(clr_val);
-	reg_val |= set_val;
-	writel(reg_val, reg);
-}
-
 static u32 sunxi_getbits(void __iomem *reg, u8 mask, u8 shift)
 {
 	return (readl(reg) >> shift) & mask;
@@ -100,22 +73,22 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 	writel(0, reg_base + AHCI_RWCR);
 	msleep(5);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
+	setbits32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits32(reg_base + AHCI_PHYCS0R,
 			 (0x7 << 24),
 			 (0x5 << 24) | BIT(23) | BIT(18));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
+	clrsetbits32(reg_base + AHCI_PHYCS1R,
 			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
 			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
-	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
-	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
+	setbits32(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
+	clrbits32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits32(reg_base + AHCI_PHYCS0R,
 			 (0x7 << 20), (0x3 << 20));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
+	clrsetbits32(reg_base + AHCI_PHYCS2R,
 			 (0x1f << 5), (0x19 << 5));
 	msleep(5);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
+	setbits32(reg_base + AHCI_PHYCS0R, (0x1 << 19));
 
 	timeout = 250; /* Power up takes aprox 50 us */
 	do {
@@ -130,7 +103,7 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 		udelay(1);
 	} while (1);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
+	setbits32(reg_base + AHCI_PHYCS2R, (0x1 << 24));
 
 	timeout = 100; /* Calibration takes aprox 10 us */
 	do {
@@ -158,10 +131,10 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* Setup DMA before DMA start */
-	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
+	clrsetbits32(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
 
 	/* Start DMA */
-	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
+	setbits32(port_mmio + PORT_CMD, PORT_CMD_START);
 }
 
 static const struct ata_port_info ahci_sunxi_port_info = {
-- 
2.16.4


Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E5FC7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698E62054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1RL0pv17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698E62054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeJXQDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:03:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44242 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbeJXQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:03:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so4373592wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ikxhkAlY3IsVD60OGSXDQ3Qj8tMnntG3LfkwFZuf0hc=;
        b=1RL0pv17yJgRj0+4QnhogGdwK44kO6UBlmB9GnWzUCr7QP+GMAGLU9g4xhqdWC3ELs
         pWQLV/+p/WHKEm8BdDd10R3h2jCMWKXpW9ZxV9PSvhLnVbnZ7+WSewEWuYCbzFLbDb6+
         VJWEYOdzAFnVhn8UVws9j04g6NVrbncSLmyFkrpLwZ9bmd62F6KUfQaZBjOlgF9jUAco
         GD6aZ8naaJ3NvjKq/Iq33fBj3RkVTn8sDYHqmWvD3VGApLL85o6/RJEtO0+x7e3dWkp4
         lcLC/Md6CwjFt7/Bzy9MOJ6ybl9DAscaGvyi6CZVr7fuSvHeMZpKKSiNJmMHrpRSA3nf
         z/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ikxhkAlY3IsVD60OGSXDQ3Qj8tMnntG3LfkwFZuf0hc=;
        b=b7fJNRJ8v30qT66b5mhxs6RrMGLFPR8FyL5SGL4dCTsjPqT/8I8YcI0XNutkBBBCAO
         KoJPNitCy81x3oxCzmhZixla4LgtKy10VOlNRKZZJfsaVhQYkcSl/fIpcsNmmuWW3WC/
         gNO37dYngERCfTebsLDRsN1xFpZF9TmE2Oh8Bxhw/OTV/w8vDsM1vCzB4rQBDcS8JnQL
         Oj+1ZxEHIKOwSrkeokcQWwmIOROLmZM1V+YPYCm8uZlzUoHRYWzkHNKGGRDTX/h2v2Po
         CHpnB6diPV0nW2iV6mVpmRV5VkqaFvOQHf/k2UpLYqQkalCiU2we26lqW9uSoWMDBqrj
         dpwQ==
X-Gm-Message-State: AGRZ1gIUAJjLHBTQYm2fHnkcG1SQCk6gVkcXJoYTW52uA6mCbb8SibIo
        beMdor2ouVl+ZYnIFjGK787/wA==
X-Google-Smtp-Source: AJdET5fgLMMx5BIAi763+0NbrSmi/Rw+CJVINiJBNj1b9j92EgeOf+sJocfQ7cCvbhY41n/8xgmVnA==
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr1530852wri.139.1540366566485;
        Wed, 24 Oct 2018 00:36:06 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b139-v6sm6254351wmd.36.2018.10.24.00.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 00:36:05 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 4/7] ata: ahci_sunxi: use xxxsetbitsi_le32 functions
Date:   Wed, 24 Oct 2018 07:35:50 +0000
Message-Id: <1540366553-18541-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ahci_sunxi to use xxxsetbits_le32 functions

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci_sunxi.c | 62 +++++++++++-----------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 911710643305..69c2e01c3d52 100644
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
@@ -100,22 +73,21 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 	writel(0, reg_base + AHCI_RWCR);
 	msleep(5);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
-			 (0x7 << 24),
-			 (0x5 << 24) | BIT(23) | BIT(18));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
-			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
-			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
-	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
-	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
-			 (0x7 << 20), (0x3 << 20));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
-			 (0x1f << 5), (0x19 << 5));
+	setbits_le32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits_le32(reg_base + AHCI_PHYCS0R, (0x7 << 24),
+			(0x5 << 24) | BIT(23) | BIT(18));
+	clrsetbits_le32(reg_base + AHCI_PHYCS1R,
+			(0x3 << 16) | (0x1f << 8) | (0x3 << 6),
+			(0x2 << 16) | (0x6 << 8) | (0x2 << 6));
+	setbits_le32(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
+	clrbits_le32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits_le32(reg_base + AHCI_PHYCS0R,
+			(0x7 << 20), (0x3 << 20));
+	clrsetbits_le32(reg_base + AHCI_PHYCS2R,
+			(0x1f << 5), (0x19 << 5));
 	msleep(5);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
+	setbits_le32(reg_base + AHCI_PHYCS0R, (0x1 << 19));
 
 	timeout = 250; /* Power up takes aprox 50 us */
 	do {
@@ -130,7 +102,7 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 		udelay(1);
 	} while (1);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
+	setbits_le32(reg_base + AHCI_PHYCS2R, (0x1 << 24));
 
 	timeout = 100; /* Calibration takes aprox 10 us */
 	do {
@@ -158,10 +130,10 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* Setup DMA before DMA start */
-	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
+	clrsetbits_le32(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
 
 	/* Start DMA */
-	sunxi_setbits(port_mmio + PORT_CMD, PORT_CMD_START);
+	setbits_le32(port_mmio + PORT_CMD, PORT_CMD_START);
 }
 
 static const struct ata_port_info ahci_sunxi_port_info = {
-- 
2.18.1


Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E58C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2823208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jrqmTlP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2823208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbeIYBIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:08:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44674 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731739AbeIYBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:08:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so20791441wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pWHvUjKo4i6ohSlwpU0vAnvtudKupWWoYoY2y+vsPgQ=;
        b=jrqmTlP8dntC/ALT8wvXKSSKlDBvX4/FJd4vIq8DoM7hwXkoTIvz0716mOCYi+0UvN
         ZXH4xFfmYqgtny42XiZwWWvy2NJW7BnYS9j7WMopDDDplEl8b5Yvur4+c8n1yzhShFR4
         L+r0KMpNiJluIe8NPPHidTZRzx84nFIRfDLqRpJKbGlxb7l/JQTQeL7DJqs1ljV4o7ND
         UDnDygrZ5L7xbOZecbZ8/a++KTooNdW50xXH7HsEn/3cp2CW9hKd9cIOx6GJw72auCoB
         x6boHjaBtPJqKs0UoSQxAbEslIsKsVlwKy41IOrwrsOJS4BzwO9cyqH6nBGLIr3I9fwf
         cidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pWHvUjKo4i6ohSlwpU0vAnvtudKupWWoYoY2y+vsPgQ=;
        b=egswSlCgziAMJcTzWYr7s3ojnOIlytFnaHRSx0ZB/obPxUYIfhtI4MEjMkal5OitUr
         /CRPN0dK+IJonbwZtN9C33fl9I5Ek+I3xLgwPaKrAYsUht9zc4krx7kqoDzx9ON4BBoN
         y6JjQQSaGu3yil8n3tt7Mj+uwuZs5C39y3JCkpQ6eSjkLLWgJMTTzH0eStujFajUCPiZ
         +1G6BVI4AGR2yqbIIzfZ91eApp82srFXRHXQ8r+G+bmHb8FJe38bMjeZm/4qE6wrZte+
         6ygABPOGnB3LFqBSE9k4e9xU9R7I1a+EkmO6LfT7aMMFQ6vjyk6LwB6FfmfQh6cZz5fI
         PVLw==
X-Gm-Message-State: ABuFfojYbhloKt1HUROikuT5xY/89ZvsBEWtXeI1ba/D1ThC9EsGFkvy
        VZLexSmdgAXSUvqR0OdNB6m/Xg==
X-Google-Smtp-Source: ACcGV63SQvGBuj4vr55uwHKmDbT0+MT0tVNwf4TH75jZ1LX5/4qJMVBvOOnTZl6bGLxEWV+jzwz3cg==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr130013wrm.143.1537815870803;
        Mon, 24 Sep 2018 12:04:30 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e141-v6sm27721433wmd.32.2018.09.24.12.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 12:04:30 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, narmstrong@baylibre.com,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 4/7] ata: ahci_sunxi: use xxxsetbits32 functions
Date:   Mon, 24 Sep 2018 19:04:13 +0000
Message-Id: <1537815856-31728-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
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
index 911710643305..5b285a6dff60 100644
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
+	setbits_le32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits_le32(reg_base + AHCI_PHYCS0R,
 			 (0x7 << 24),
 			 (0x5 << 24) | BIT(23) | BIT(18));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
+	clrsetbits_le32(reg_base + AHCI_PHYCS1R,
 			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
 			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
-	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
-	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
+	setbits_le32(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
+	clrbits_le32(reg_base + AHCI_PHYCS1R, BIT(19));
+	clrsetbits_le32(reg_base + AHCI_PHYCS0R,
 			 (0x7 << 20), (0x3 << 20));
-	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
+	clrsetbits_le32(reg_base + AHCI_PHYCS2R,
 			 (0x1f << 5), (0x19 << 5));
 	msleep(5);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
+	setbits_le32(reg_base + AHCI_PHYCS0R, (0x1 << 19));
 
 	timeout = 250; /* Power up takes aprox 50 us */
 	do {
@@ -130,7 +103,7 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 		udelay(1);
 	} while (1);
 
-	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
+	setbits_le32(reg_base + AHCI_PHYCS2R, (0x1 << 24));
 
 	timeout = 100; /* Calibration takes aprox 10 us */
 	do {
@@ -158,10 +131,10 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
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
2.16.4


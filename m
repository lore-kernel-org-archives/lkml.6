Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2255C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B2B2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9uev1PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B2B2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeH3XF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36675 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbeH3XF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so3079409wmj.1;
        Thu, 30 Aug 2018 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oe7h7xIfk8wXHX/0FC9e1cxcaJIngJnxvR4UbXqmMVg=;
        b=q9uev1PIjkWXxvAYB+XuPf9jmG/C5rOPO9UbUFkMk9LC1q7c00OERutFya7Ett7dCK
         b8felrkiQocDePiPHvzM8eVOQQGdeB+QHz6z61192uXqDGdQsxNzXlWylLM/ZVVt2qBI
         SfKEMDy7Y06yF+6n+4I9hzJjV4Pi1BKUqLg2YZE8vWxANnv4b9nxApH3P1i7NDWXErTX
         /xDlAIaJzNOAjzD/I9ZJXYpyCYN+L1asSoLDJNKSV6mCg6BDN6aeDf56vStIyqWx1CWe
         BDgcBKU/A2MAq0ZMMRP59BIvsw+v0LBeK06bArreMF8lgXl+j5ndwLJdNc1WGDvUpp1k
         kJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oe7h7xIfk8wXHX/0FC9e1cxcaJIngJnxvR4UbXqmMVg=;
        b=fQqVEO2mTo11PCzvO97hYjk+hhU8e4QfRBP1ZVnsZrMKlJeFgy34M4LMzZfjz05Ma6
         oaiC2MmLaZPkN7/9C6HP2JinjUO2/sqGyugF/frouIKA59+ZeuY6T8gQ2uZGCebsN2Gp
         zHTlz4iNhxQ+tYaZj7U7epA05rpuVgx5ENcYhSaQM55i9ioA6Sg40kJGp2U29j4vYXjk
         78rn/sYCEvYjBik2celN/l3SDGYAC9J6sUgaiAHg2bc+AFnGFvbnjCvsjnvPKU83BVPd
         OAWO1lvw/cV2PV3k5tipTbrYZg/fx8X5Dq6sr+IyL4kQAxwym4mjC61SempLJQex3BTo
         IaxA==
X-Gm-Message-State: APzg51Bmtj3iXbOoudW82iTltrMeVUYZg+pGFBjCkkoDy+gl85/3+q2E
        euk6hfH2fe496BF5vHiDplo=
X-Google-Smtp-Source: ANB0VdZEluVefV/6s3f5uSVg3ODg+tNOUFKWcNJeVcxI9utgBCGm1zIV3IsZYyB9D0beZnASM514Ww==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133-v6mr2583188wmg.108.1535655708335;
        Thu, 30 Aug 2018 12:01:48 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:47 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 13/13 DONOTMERGE] ata: ahci_sunxi: remove PHY code
Date:   Thu, 30 Aug 2018 21:01:20 +0200
Message-Id: <20180830190120.722-14-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since PHY code is now handled by sun4i-a10-sata-phy, the code in
ahci_sunxi is useless, remove it.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci_sunxi.c | 93 ------------------------------------------------
 1 file changed, 93 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index b8cf3a1be80b..af17f8ce65b2 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -58,15 +58,6 @@ MODULE_PARM_DESC(enable_pmp,
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
 static void sunxi_setbits(void __iomem *reg, u32 set_val)
 {
 	u32 reg_val;
@@ -86,81 +77,6 @@ static void sunxi_clrsetbits(void __iomem *reg, u32 clr_val, u32 set_val)
 	writel(reg_val, reg);
 }
 
-static u32 sunxi_getbits(void __iomem *reg, u8 mask, u8 shift)
-{
-	return (readl(reg) >> shift) & mask;
-}
-
-static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
-{
-	u32 reg_val;
-	int timeout;
-
-	/*
-	 * When using the new binding, the presence of a sata port node
-	 * means that PHY is handled by the PHY driver.
-	 * */
-	if (of_get_child_count(dev->of_node)) {
-		dev_info(dev, "Bypassing PHY init\n");
-		return 0;
-	}
-
-	/* This magic is from the original code */
-	writel(0, reg_base + AHCI_RWCR);
-	msleep(5);
-
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
-	msleep(5);
-
-	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
-
-	timeout = 250; /* Power up takes aprox 50 us */
-	do {
-		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
-		if (reg_val == 0x02)
-			break;
-
-		if (--timeout == 0) {
-			dev_err(dev, "PHY power up failed.\n");
-			return -EIO;
-		}
-		udelay(1);
-	} while (1);
-
-	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
-
-	timeout = 100; /* Calibration takes aprox 10 us */
-	do {
-		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS2R, 0x1, 24);
-		if (reg_val == 0x00)
-			break;
-
-		if (--timeout == 0) {
-			dev_err(dev, "PHY calibration failed.\n");
-			return -EIO;
-		}
-		udelay(1);
-	} while (1);
-
-	msleep(15);
-
-	writel(0x7, reg_base + AHCI_RWCR);
-
-	return 0;
-}
-
 static void ahci_sunxi_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
@@ -186,7 +102,6 @@ static struct scsi_host_template ahci_platform_sht = {
 
 static int ahci_sunxi_probe(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	int rc;
 
@@ -200,10 +115,6 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
-	if (rc)
-		goto disable_resources;
-
 	hpriv->flags = AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
 		       AHCI_HFLAG_YES_NCQ;
 
@@ -238,10 +149,6 @@ static int ahci_sunxi_resume(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
-	if (rc)
-		goto disable_resources;
-
 	rc = ahci_platform_resume_host(dev);
 	if (rc)
 		goto disable_resources;
-- 
2.16.4


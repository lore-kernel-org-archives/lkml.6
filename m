Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B67C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB2720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="ETNHltkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfAaVdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:33:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfAaVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:33:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so1909791pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zBtANhfwlHrkA9s4uLMxxoXbJiZYcxP3YKb55Uu2Jkk=;
        b=ETNHltkHvzs2m8RnUOBZVmg23iuDjb1uvwnJlQ9lbyBGMqiXDcluNAjVoh2i7hMi5M
         YztEneoQ6+i3A/ZmhhVctTHkoru5rxZdOcDvaaaSUPrrebf2G1c3C79p0OH7z7RnSX4y
         9t++hEC7kUYMKMsnoDocGHt5b8l+ydEaZcSoqXs8DGLPAGWkegsXrdd9a8VPO8CFMI1I
         qoKArtHYOnGPVHIFR8TiQi7LKPg5Gl5DMZ0PJHdJvm2y6WMJzsgtrDKPoLT9dYzlJ8vh
         W3LRV1ftunJVoUZ4tiOPBAr6vNUhJistn82pJZ+BUpO0ym/Bz5RqDt9+qVfplsYchNWX
         tBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zBtANhfwlHrkA9s4uLMxxoXbJiZYcxP3YKb55Uu2Jkk=;
        b=B+N9Hr0wOmOlGOgKmJT3aJKRZUpNXDRLewnE7xLxZjRz/l7vXAwJuRUwbXPEB1znz4
         tNn5PYuEYVxTbahGzv5iLPJW3Og6rJ0rrR0S+9SQYWIDS42lNjQ4lnIEcDQCGkf8qBJE
         aBMWpB8eSmBjjjFVukVRAEK7fdEdMezQTxGQ/0/E4zDXOjcSH/tqSfschVtEN9bsACei
         XXKV000uLk0HvLAD4wuG13fSUp3JgEJx3vQxDno4c9XIRe1lBN2wdavnwX6pHawRTanR
         kWVHsB/W2ZGQ3tAXlco8qWQDEB+Fio4xdT/Zr1wmo38Kd/JdkVvdtkKF01gQcj5KUm0W
         LsXA==
X-Gm-Message-State: AJcUuke/LAxliotsEBFzsJ0jEyqggzMmxoRNlGebk9CwD/2YBHaYzXeJ
        y8EcNmIpAovZXJtlqURwk6ob7Q==
X-Google-Smtp-Source: ALg8bN4i+wzXhdb50I+j173iuvXtJrYaj6ZWCvaDvuAzzDO55LkkinYdlWSkV3duULgJwcGcqjELmw==
X-Received: by 2002:a62:444b:: with SMTP id r72mr37032456pfa.184.1548970416495;
        Thu, 31 Jan 2019 13:33:36 -0800 (PST)
Received: from localhost.localdomain (cpe-76-176-152-96.san.res.rr.com. [76.176.152.96])
        by smtp.gmail.com with ESMTPSA id n21sm7513227pfg.84.2019.01.31.13.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:33:35 -0800 (PST)
From:   alex.williams@ettus.com
To:     davem@davemloft.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mdf@kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Williams <alex.williams@ni.com>
Subject: [PATCH v2 net-next 1/2] net: nixge: Separate ctrl and dma resources
Date:   Thu, 31 Jan 2019 13:33:27 -0800
Message-Id: <20190131213328.11236-1-alex.williams@ettus.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williams <alex.williams@ni.com>

The DMA engine is a separate entity altogether, and this allows the DMA
controller's address to float elsewhere in the FPGA's map.

Signed-off-by: Alex Williams <alex.williams@ni.com>
---
 drivers/net/ethernet/ni/nixge.c | 74 ++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 1e408d1a9b5f..73a98bd2fcd2 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -105,6 +105,12 @@
 #define NIXGE_MAX_JUMBO_FRAME_SIZE \
 	(NIXGE_JUMBO_MTU + NIXGE_HDR_SIZE + NIXGE_TRL_SIZE)
 
+enum nixge_version {
+	NIXGE_V2,
+	NIXGE_V3,
+	NIXGE_VERSION_COUNT
+};
+
 struct nixge_hw_dma_bd {
 	u32 next_lo;
 	u32 next_hi;
@@ -1225,11 +1231,59 @@ static void *nixge_get_nvmem_address(struct device *dev)
 	return mac;
 }
 
+/* Match table for of_platform binding */
+static const struct of_device_id nixge_dt_ids[] = {
+	{ .compatible = "ni,xge-enet-2.00", .data = (void *)NIXGE_V2 },
+	{ .compatible = "ni,xge-enet-3.00", .data = (void *)NIXGE_V3 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, nixge_dt_ids);
+
+static int nixge_of_get_resources(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	enum nixge_version version;
+	struct resource *ctrlres;
+	struct resource *dmares;
+	struct net_device *ndev;
+	struct nixge_priv *priv;
+
+	ndev = platform_get_drvdata(pdev);
+	priv = netdev_priv(ndev);
+	of_id = of_match_node(nixge_dt_ids, pdev->dev.of_node);
+	if (!of_id)
+		return -ENODEV;
+
+	version = (enum nixge_version)of_id->data;
+	if (version <= NIXGE_V2)
+		dmares = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	else
+		dmares = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						      "dma");
+
+	priv->dma_regs = devm_ioremap_resource(&pdev->dev, dmares);
+	if (IS_ERR(priv->dma_regs)) {
+		netdev_err(ndev, "failed to map dma regs\n");
+		return PTR_ERR(priv->dma_regs);
+	}
+	if (version <= NIXGE_V2) {
+		priv->ctrl_regs = priv->dma_regs + NIXGE_REG_CTRL_OFFSET;
+	} else {
+		ctrlres = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						       "ctrl");
+		priv->ctrl_regs = devm_ioremap_resource(&pdev->dev, ctrlres);
+	}
+	if (IS_ERR(priv->ctrl_regs)) {
+		netdev_err(ndev, "failed to map ctrl regs\n");
+		return PTR_ERR(priv->ctrl_regs);
+	}
+	return 0;
+}
+
 static int nixge_probe(struct platform_device *pdev)
 {
 	struct nixge_priv *priv;
 	struct net_device *ndev;
-	struct resource *dmares;
 	const u8 *mac_addr;
 	int err;
 
@@ -1261,14 +1315,9 @@ static int nixge_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 
 	netif_napi_add(ndev, &priv->napi, nixge_poll, NAPI_POLL_WEIGHT);
-
-	dmares = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->dma_regs = devm_ioremap_resource(&pdev->dev, dmares);
-	if (IS_ERR(priv->dma_regs)) {
-		netdev_err(ndev, "failed to map dma regs\n");
-		return PTR_ERR(priv->dma_regs);
-	}
-	priv->ctrl_regs = priv->dma_regs + NIXGE_REG_CTRL_OFFSET;
+	err = nixge_of_get_resources(pdev);
+	if (err)
+		return err;
 	__nixge_hw_set_mac_address(ndev);
 
 	priv->tx_irq = platform_get_irq_byname(pdev, "tx");
@@ -1337,13 +1386,6 @@ static int nixge_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* Match table for of_platform binding */
-static const struct of_device_id nixge_dt_ids[] = {
-	{ .compatible = "ni,xge-enet-2.00", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, nixge_dt_ids);
-
 static struct platform_driver nixge_driver = {
 	.probe		= nixge_probe,
 	.remove		= nixge_remove,
-- 
2.14.5


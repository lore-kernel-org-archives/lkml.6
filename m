Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD192080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="M8pfRQ7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD192080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbeJ3IG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:06:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbeJ3IG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:06:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so4788223pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=c1gb1eLFkeEdkSyvpmjJ05MGg7OBN8UdX8BqfGz2H/c=;
        b=M8pfRQ7WctGqZ1fWsyUE65spECgyhr0jMCE7XX1jhgRqatTO43blFUeTCgFNthkNEA
         sLCUK6L8BVDoNbylHouAwhi11KAlVO+wcl0WaV2MtvxgFEXqJI62/npeR1nvOk/Ke8Yu
         q7DUGi+UUxZnVpbvA15TsTUYw7M3rIs0BGrH3TVkB+0QWAAjf9GRaN+7HqOJJemxZeln
         Gc3PgNSs9WGjwL36B8aLavfRDOUXc2v7kcPSb5CZOMz2Amh8g7Zuxxtza/trS3L+XRiy
         mUvc0sNFmbEpKzbpo74ZNv/KmYRx+P0rYwQz1OsdIbWvsRCG5RaS9V1jEmeeGWXuwaYL
         JEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c1gb1eLFkeEdkSyvpmjJ05MGg7OBN8UdX8BqfGz2H/c=;
        b=iWcLxjaYdcSgOmr/8Fg34Fg2LpGwUpgZb8dv+8V1kd0Yaa3j+3SjzrK7UtXsXgpqym
         oX1AMHW1IL1BSvwVGYJt+P5k0ftQ7gSxj+5GRqPLTEL1lL68fhJR8IFP510Ob3ioW0Et
         ETX9SnwdMRHw+TmbQvIorIZz69WHqTMEPYFT6NMc2FWP4jUMqL422mInO61ifOwI7QaK
         rgXRf+06muXbvt1+Oz9d5+5La3KBzFsqBFkFZ0KtIk3tN51C77Vux7mV4AVuXoJZROz2
         zUeJ5xhePUNex4mmapMoTxH24XAIYJWEY5QQeSTUsybdu9gjL4AQGIbkrtx36rtX1nFn
         HJuw==
X-Gm-Message-State: AGRZ1gJJYX8MVl9LntfkXQm7jO4LWFnXB2KduvqoH1qQniVoHMByyqCD
        7zkTDZKbC/xCCqCuSAWqQcVSiA==
X-Google-Smtp-Source: AJdET5eMICgmkqHQPxhFSfLSiEYfNxz6UObjLqyAqtBo3aoWIkGIb3Ll58JciwyDkzTeZYsOjnxegw==
X-Received: by 2002:a63:50b:: with SMTP id 11mr15305910pgf.411.1540854934360;
        Mon, 29 Oct 2018 16:15:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-76-176-152-96.san.res.rr.com. [76.176.152.96])
        by smtp.gmail.com with ESMTPSA id r18-v6sm21698122pgv.17.2018.10.29.16.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 16:15:33 -0700 (PDT)
From:   alex.williams@ettus.com
To:     netdev@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mdf@kernel.org, keescook@chromium.org,
        Alex Williams <alex.williams@ni.com>
Subject: [PATCH net-next 1/2] net: nixge: Separate ctrl and dma resources
Date:   Mon, 29 Oct 2018 16:14:46 -0700
Message-Id: <20181029231447.3690-1-alex.williams@ettus.com>
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
index 0611f2335b4a..89b4f719a87d 100644
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


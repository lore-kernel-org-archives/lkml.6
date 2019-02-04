Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C34C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6575A2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="BrIUteSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfBDRbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:31:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfBDRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:30:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so213988pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyNN/cBC8H0d9mt1rt0a7Z0pTJTwhk8gYyIq7n/7xJo=;
        b=BrIUteSIrwvJg/2uc01Tg+9ntfxpfujvtMk1TYiYj2gBafmE5tw2ZGBpqxm93b1lOA
         ybO2qSM2YJWvMjssHtrnLwAZndx1Cm494wud+eZpeejHDueirnp5MFLSqA3/Pz1zVbHu
         NLvRjdaxfyYVHV59ghBlZdi2iHXmbshKcw4CZPH+xhhc9zN3mvd8ri+RpJlxvfVmAR9T
         oebcvlylamWQyKepfycWxbmRgRQru+XoNXpKd5G7Lr0AxC26fluvf2x4IcXyRVAHxCNY
         tbJGXf+tNhFX2d3D0tJ1KuIPOD0KIgNKiRGses4Xn/aLP/zbxJRNA3MQAKzM9GpbWLXb
         8Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyNN/cBC8H0d9mt1rt0a7Z0pTJTwhk8gYyIq7n/7xJo=;
        b=KRm1mli4ykLDieTkwXaYDf2/2rTLRVv+Yb6OQ2ENsBWBKGt9N69Bn8SW1snxTQGWe+
         cnRxBrJI5h/PEvWfn5W/mS1a7K6zV96uB8JQ2d1imcR+F8/jCJ+CpB6mHPOXM/bo8Y6h
         wTuJpwlIMFTuWKYLzu2Qc899rf7DXLNjoNI5NwOTLeuL+n0Un3EoYf6D250xF17Q5uYw
         NhtCX50r2UtYvW6y3TNdFzbmzUEb3K4aJABafYrIO1awRKvZzr2I+G6vCmQW5N6oGOeg
         mVth5khIkM9UhveLtQPqGMfyx6LWsC2aQ2wfX5jET7hIu5Om5apaH2GRBJpFP0i0Ga2C
         226Q==
X-Gm-Message-State: AHQUAuZp8X42+h26s8sRPP4lG403ywyxT3rD7jIckxF6BZmJIq37eXdg
        M8aQ5CJKCBGI6vY+VfTiOzU/fQ==
X-Google-Smtp-Source: AHgI3IaIzyOCAqTzDveM2kV3aUqjgrqlZBHRTWm/rAVePpIAU97U8n3ZEnfHOJPGd2g1kb6RWnSxaA==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr455812pgk.102.1549301457148;
        Mon, 04 Feb 2019 09:30:57 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id g11sm730212pfo.139.2019.02.04.09.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:30:56 -0800 (PST)
From:   Moritz Fischer <moritz.fischer@ettus.com>
To:     netdev@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williams@ni.com, andrew@lunn.ch, robh+dt@kernel.org,
        davem@davemloft.net, moritz.fischer@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next 2/3] net: nixge: Add support for fixed-link configurations
Date:   Mon,  4 Feb 2019 09:30:39 -0800
Message-Id: <20190204173040.5538-3-moritz.fischer@ettus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204173040.5538-1-moritz.fischer@ettus.com>
References: <20190204173040.5538-1-moritz.fischer@ettus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Add support for fixed-link configurations to nixge driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/net/ethernet/ni/nixge.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index c8dd1e4c759d..96f7a9818294 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1282,9 +1282,9 @@ static int nixge_of_get_resources(struct platform_device *pdev)
 
 static int nixge_probe(struct platform_device *pdev)
 {
+	struct device_node *mn, *phy_node;
 	struct nixge_priv *priv;
 	struct net_device *ndev;
-	struct device_node *mn;
 	const u8 *mac_addr;
 	int err;
 
@@ -1353,21 +1353,30 @@ static int nixge_probe(struct platform_device *pdev)
 		goto unregister_mdio;
 	}
 
-	priv->phy_node = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
-	if (!priv->phy_node) {
-		netdev_err(ndev, "not find \"phy-handle\" property\n");
-		err = -EINVAL;
-		goto unregister_mdio;
+	phy_node = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
+	if (!phy_node && of_phy_is_fixed_link(pdev->dev.of_node)) {
+		err = of_phy_register_fixed_link(pdev->dev.of_node);
+		if (err < 0) {
+			netdev_err(ndev, "broken fixed-link specification\n");
+			goto unregister_mdio;
+		}
+		phy_node = of_node_get(pdev->dev.of_node);
 	}
+	priv->phy_node = phy_node;
 
 	err = register_netdev(priv->ndev);
 	if (err) {
 		netdev_err(ndev, "register_netdev() error (%i)\n", err);
-		goto unregister_mdio;
+		goto free_phy;
 	}
 
 	return 0;
 
+free_phy:
+	if (of_phy_is_fixed_link(pdev->dev.of_node))
+		of_phy_deregister_fixed_link(pdev->dev.of_node);
+	of_node_put(phy_node);
+
 unregister_mdio:
 	if (priv->mii_bus)
 		mdiobus_unregister(priv->mii_bus);
@@ -1385,6 +1394,10 @@ static int nixge_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 
+	if (of_phy_is_fixed_link(pdev->dev.of_node))
+		of_phy_deregister_fixed_link(pdev->dev.of_node);
+	of_node_put(priv->phy_node);
+
 	if (priv->mii_bus)
 		mdiobus_unregister(priv->mii_bus);
 
-- 
2.20.1


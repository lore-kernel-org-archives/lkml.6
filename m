Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D1BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72182081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="ae5GGyXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfBDRa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:30:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46201 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfBDRa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:30:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so216890pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdnN8oMz57K6JwphabgMQst68MVpMqZb8th3jd5zgk0=;
        b=ae5GGyXIQcAiz0To0gPgxCoEA5CoyUjQHcHQLnz18JbBAxVnSCm/ewyi31CJ9Xh2Tw
         JvtnrPiX0kkk8yyCS1DoYqdMHwghzZOc6DNk8auC7AzdCiSghNTehB4jpmxoWiVZIiY0
         9k60W63tBUfWwAT880b3iR6Wag/LQubOiMmVAlxetwQt8igmqUfdkYkzf80LFeAJY3YU
         tk8Gc1mC4jEHcA38KNw622uvK7J3f17HPZVFRcmzX6wcZMJcGUjtoMHrY2PK6BHpoNn8
         KTGSjAy7/rZDcq27tsQUhbVCe7FMyBCL8ykdJboOUWFSzgTUxZRxFcNWAefg+eahVr3t
         eC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdnN8oMz57K6JwphabgMQst68MVpMqZb8th3jd5zgk0=;
        b=GtohIMvzl7BmMxjEKkjjTVtQsQNzClgXo1CV2/2zKYFCgmTZc3OrLcuoxnchz8RrOw
         cT8xWGSBwFGf+PEVkkmxqOrzsB0ANiuI6ovlatq2d0g6oTCy6VqDkA57KeP3WhtYc6Ib
         1ehI6KtMHCRxJ3eIXdnNJthx8S2k8Fc8+JR4xrLjR1R3GsFTSwVPRLDZ0sEaSTdmP1pA
         1sV0YThwpnRrp7Eu9pybuXOAlyN9FoPDqo/5D0MueRXUD2mX8McxSlD4Ir3qn7CM0tBT
         mh90KbzvqQHiU4gOGdXjHHOkp+hEYfO+f8GbLx54q7DOJy6IlGs6DAMGxbme9an0HqTk
         2qKQ==
X-Gm-Message-State: AHQUAubBGGRD9ROdIWBs733cOjg+W9myyldBnCLKZpr7IfU+Dv9AFwyP
        PS3J+E9tXD3npTFhSDUeaykLmQ==
X-Google-Smtp-Source: AHgI3IYuFSSOIc8vrBYatt9NQ9ULxlrErKbd0AiboQmzEyIPNy9pM2F2rdd1Qkc1T7ClkAopcBR7Sw==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr528760plb.46.1549301455688;
        Mon, 04 Feb 2019 09:30:55 -0800 (PST)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id k15sm794363pfb.147.2019.02.04.09.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 09:30:55 -0800 (PST)
From:   Moritz Fischer <moritz.fischer@ettus.com>
To:     netdev@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williams@ni.com, andrew@lunn.ch, robh+dt@kernel.org,
        davem@davemloft.net, moritz.fischer@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next 1/3] net: nixge: Make mdio child node optional
Date:   Mon,  4 Feb 2019 09:30:38 -0800
Message-Id: <20190204173040.5538-2-moritz.fischer@ettus.com>
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

Make MDIO child optional and only instantiate the
MDIO bus if the child is actually present.

There are currently no (in-tree) users of this
binding; all (out-of-tree) users use overlays that
get shipped together with the FPGA images that contain
the IP.

This will significantly increase maintainabilty
of future revisions of this IP.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from RFC:
- Add Andrew's Reviewed-by tag
- Rebased on top of net-next

---
 .../devicetree/bindings/net/nixge.txt         | 27 ++++++++++++++++---
 drivers/net/ethernet/ni/nixge.c               | 19 ++++++++-----
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nixge.txt b/Documentation/devicetree/bindings/net/nixge.txt
index 44a7358b4399..bb2929f9c64f 100644
--- a/Documentation/devicetree/bindings/net/nixge.txt
+++ b/Documentation/devicetree/bindings/net/nixge.txt
@@ -16,6 +16,9 @@ Required properties:
 - nvmem-cells: Phandle of nvmem cell containing the MAC address
 - nvmem-cell-names: Should be "address"
 
+Optional properties:
+- mdio subnode to indicate presence of MDIO controller
+
 Examples (10G generic PHY):
 	nixge0: ethernet@40000000 {
 		compatible = "ni,xge-enet-3.00";
@@ -33,8 +36,26 @@ Examples (10G generic PHY):
 		phy-mode = "xgmii";
 		phy-handle = <&ethernet_phy1>;
 
-		ethernet_phy1: ethernet-phy@4 {
-			compatible = "ethernet-phy-ieee802.3-c45";
-			reg = <4>;
+		mdio {
+			ethernet_phy1: ethernet-phy@4 {
+				compatible = "ethernet-phy-ieee802.3-c45";
+				reg = <4>;
+			};
 		};
 	};
+
+Examples (10G generic PHY, no MDIO):
+	nixge0: ethernet@40000000 {
+		compatible = "ni,xge-enet-2.00";
+		reg = <0x40000000 0x6000>;
+
+		nvmem-cells = <&eth1_addr>;
+		nvmem-cell-names = "address";
+
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>, <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rx", "tx";
+		interrupt-parent = <&intc>;
+
+		phy-mode = "xgmii";
+		phy-handle = <&ethernet_phy1>;
+	};
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 73a98bd2fcd2..c8dd1e4c759d 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1284,6 +1284,7 @@ static int nixge_probe(struct platform_device *pdev)
 {
 	struct nixge_priv *priv;
 	struct net_device *ndev;
+	struct device_node *mn;
 	const u8 *mac_addr;
 	int err;
 
@@ -1335,10 +1336,14 @@ static int nixge_probe(struct platform_device *pdev)
 	priv->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
 	priv->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 
-	err = nixge_mdio_setup(priv, pdev->dev.of_node);
-	if (err) {
-		netdev_err(ndev, "error registering mdio bus");
-		goto free_netdev;
+	mn = of_get_child_by_name(pdev->dev.of_node, "mdio");
+	if (mn) {
+		err = nixge_mdio_setup(priv, mn);
+		of_node_put(mn);
+		if (err) {
+			netdev_err(ndev, "error registering mdio bus");
+			goto free_netdev;
+		}
 	}
 
 	priv->phy_mode = of_get_phy_mode(pdev->dev.of_node);
@@ -1364,7 +1369,8 @@ static int nixge_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_mdio:
-	mdiobus_unregister(priv->mii_bus);
+	if (priv->mii_bus)
+		mdiobus_unregister(priv->mii_bus);
 
 free_netdev:
 	free_netdev(ndev);
@@ -1379,7 +1385,8 @@ static int nixge_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 
-	mdiobus_unregister(priv->mii_bus);
+	if (priv->mii_bus)
+		mdiobus_unregister(priv->mii_bus);
 
 	free_netdev(ndev);
 
-- 
2.20.1


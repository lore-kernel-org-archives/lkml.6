Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF8BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D25B20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039584;
	bh=n5nO0GlMPGxWAMka812VGVtEl/U3xUlUTe7QRuD4bQk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TPLWW5GyL3QZ8N92P1ooUx+xx9B2D/9GWIZ5PLFtdCBMSt0CLDs/Gc4mxP3zcQjot
	 BYFf9URg81JcZnLP8SAuAo/bbvNGhtfVyHow5/twix3SDMJ7ICOxhc/Mu25JMTLG7A
	 uG7dJQwddI8eAR69+xJbaXphh+1f8/Ci8uL4KO0w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D25B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeLETxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:53:03 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37455 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbeLETvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so18657580oia.4;
        Wed, 05 Dec 2018 11:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=64JnrfkdMgu2EPsvD7FnBPzsb1bi6pVhE4y3hEeScxc=;
        b=mqjDfWdVbSw45pQziyZXy2CgJWYzD0ANgBTFYhbPCITKaMXsx8NJ/9nIHHqIzwlJ9V
         U0uOCiMFO7LYxY8LePnuvCXcElCE5d7UMhWSxiasOiWl7BBWTPVUj1o8L9RFLZzQodCy
         vgvxOoqVb4DpOizAPdTexV0RHp8bnzBfOuuNXMMZTx0YaKVpRFmyyfN0Z5z0/jXCzNhr
         AOasw0QvzNhKbtpExMpqPnDOjRFYNvXMxaTCUuI3Qexwwv/cEoLluzvbYXSS+/A3SHVX
         iNps5A8Og3CN2Rg5curDngsWHCVk/tCa2/hU5VHDKO+1V71HKKyJW4bKuDjE02jUUaE4
         xh/Q==
X-Gm-Message-State: AA+aEWb2yYzPgnOmgbEU7If7VyqOj59w58g7Dx2+F2P2QR4zmMWt1TEw
        zVfMHi4TJcKvpXB1dlnSFUUISLk=
X-Google-Smtp-Source: AFSGD/W/EwhKzUtm1rBCuJBtyUCihNFA3awqJp1TXimm1xKv2T1MnxZ+AgBUJEFdllwDhZA0hL5bFg==
X-Received: by 2002:aca:aad8:: with SMTP id t207mr14705306oie.90.1544039468996;
        Wed, 05 Dec 2018 11:51:08 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] net: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:32 -0600
Message-Id: <20181205195050.4759-16-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wingman Kwok <w-kwok2@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/ethernet/amd/sunlance.c      | 4 ++--
 drivers/net/ethernet/freescale/gianfar.c | 4 ++--
 drivers/net/ethernet/sun/sunhme.c        | 2 +-
 drivers/net/ethernet/ti/cpsw.c           | 4 ++--
 drivers/net/ethernet/ti/netcp_ethss.c    | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index b4fc0ed5bce8..91c9140d2a52 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1486,9 +1486,9 @@ static int sunlance_sbus_probe(struct platform_device *op)
 	struct device_node *parent_dp = parent->dev.of_node;
 	int err;
 
-	if (!strcmp(parent_dp->name, "ledma")) {
+	if (of_node_name_eq(parent_dp, "ledma")) {
 		err = sparc_lance_probe_one(op, parent, NULL);
-	} else if (!strcmp(parent_dp->name, "lebuffer")) {
+	} else if (of_node_name_eq(parent_dp, "lebuffer")) {
 		err = sparc_lance_probe_one(op, NULL, parent);
 	} else
 		err = sparc_lance_probe_one(op, NULL, NULL);
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3c8da1a18ba0..7b5f08725b5b 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -720,7 +720,7 @@ static int gfar_of_group_count(struct device_node *np)
 	int num = 0;
 
 	for_each_available_child_of_node(np, child)
-		if (!of_node_cmp(child->name, "queue-group"))
+		if (of_node_name_eq(child, "queue-group"))
 			num++;
 
 	return num;
@@ -838,7 +838,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	/* Parse and initialize group specific information */
 	if (priv->mode == MQ_MG_MODE) {
 		for_each_available_child_of_node(np, child) {
-			if (of_node_cmp(child->name, "queue-group"))
+			if (!of_node_name_eq(child, "queue-group"))
 				continue;
 
 			err = gfar_parse_group(child, priv, model);
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 863fd602fd33..ff641cf30a4e 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -2691,7 +2691,7 @@ static int happy_meal_sbus_probe_one(struct platform_device *op, int is_qfe)
 	sbus_dp = op->dev.parent->of_node;
 
 	/* We can match PCI devices too, do not accept those here. */
-	if (strcmp(sbus_dp->name, "sbus") && strcmp(sbus_dp->name, "sbi"))
+	if (!of_node_name_eq(sbus_dp, "sbus") && !of_node_name_eq(sbus_dp, "sbi"))
 		return err;
 
 	if (is_qfe) {
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 500f7ed8c58c..aeb599f230ab 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -3144,7 +3144,7 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
 		const __be32 *parp;
 
 		/* This is no slave child node, continue */
-		if (strcmp(slave_node->name, "slave"))
+		if (!of_node_name_eq(slave_node, "slave"))
 			continue;
 
 		slave_data->phy_node = of_parse_phandle(slave_node,
@@ -3240,7 +3240,7 @@ static void cpsw_remove_dt(struct platform_device *pdev)
 	for_each_available_child_of_node(node, slave_node) {
 		struct cpsw_slave_data *slave_data = &data->slave_data[i];
 
-		if (strcmp(slave_node->name, "slave"))
+		if (!of_node_name_eq(slave_node, "slave"))
 			continue;
 
 		if (of_phy_is_fixed_link(slave_node))
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 0397ccb6597e..bfde91ca5df7 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3621,7 +3621,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 		return -EINVAL;
 	}
 
-	if (!strcmp(node->name, "gbe")) {
+	if (of_node_name_eq(node, "gbe")) {
 		ret = get_gbe_resource_version(gbe_dev, node);
 		if (ret)
 			return ret;
@@ -3635,7 +3635,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 		else
 			ret = -ENODEV;
 
-	} else if (!strcmp(node->name, "xgbe")) {
+	} else if (of_node_name_eq(node, "xgbe")) {
 		ret = set_xgbe_ethss10_priv(gbe_dev, node);
 		if (ret)
 			return ret;
-- 
2.19.1


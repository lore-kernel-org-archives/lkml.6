Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D557C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BD52150C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="rbXVkL01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BD52150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeIYLe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:34:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41169 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIYLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:34:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3-v6so5649851pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 22:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMaqH8rB3bwKy8TYYnWJ1rW2GWmr/yLobWCp71K6zdI=;
        b=rbXVkL01HsdwKtIhx41m7dUMi7s5BkaOkaQ42jG13243gCpw9HvCldnb5oUy5GH1K9
         ina9fV+aeolSDJ0yO5Cw3x45io+75RBHuhwsWTY9aRshWhzh0wJj6cyJvXg4tcH8g9mK
         1BHawN3VWcSnOMJHe3lX6fsdcx4b6e3lJCMNBSvGE7sKMrRW3lqQyU7YSyRCuIhoNUV4
         J6lSxyiBnX+SEOMXDvelDu3Gh4jdZk/xfNZAO4n97+4CVXMgQg2N16nEcUJyVZ8BfJk0
         osJskD1D0F5UZISsoMAZUXuieVKREdUnSfmwBTdUgfIOavlWAVuLKCAlhFz7ZoeAWMpO
         E4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kMaqH8rB3bwKy8TYYnWJ1rW2GWmr/yLobWCp71K6zdI=;
        b=e3KgM3cpjd0qTKQuB6A2lBU+HwYH05d5c1a7irmuddJ2KdBgkTUCXgUaBz9yfHg3Bz
         hLp8bXYHlxU/9783ALNfHcA8Qxqa2bLDzu51oOJZx/15jD1J6LXe6HSIf18rljqKiCFR
         TQLgqDD5aJSkFg0Una2u1HiwU5OdMZ3hgiX2614nGFBJLGBmbQ7bfG2eFQnFc9H3fasM
         ajpu1UABrkCBHx617QJ/M0CYDqqqTvU2PnO/bcbqrtR3v0DMlrrrQxdCbyxMJs2GPZYt
         5IV+bm9kIIU/x86Cca5tDlqzaQXM0kb2nj12aCtjram1TKgEJJYxM4TI8Ky+asOJtiy9
         /jjw==
X-Gm-Message-State: ABuFfoiWL/lephreP8zrSvVPpb9pVQ+IR3Tf54gggUtUN3kN8QaN0rEv
        qsgKYukk2XUqk1MFFUJt5DnkiQ==
X-Google-Smtp-Source: ACcGV60udHizmPhKz7WOfqvVITmITeRsX32vKMD60EX9a+cgBvKGtyM2gICCSaM6/XLQtyOxJizrXg==
X-Received: by 2002:a17:902:4381:: with SMTP id j1-v6mr1722817pld.227.1537853350893;
        Mon, 24 Sep 2018 22:29:10 -0700 (PDT)
Received: from mercury.CELSYSJYN.IN ([182.72.92.62])
        by smtp.gmail.com with ESMTPSA id d12-v6sm1222840pfn.118.2018.09.24.22.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Sep 2018 22:29:09 -0700 (PDT)
From:   Silesh C V <svellattu@mvista.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Silesh C V <svellattu@mvista.com>
Subject: [PATCH v2 2/2] treewide: use bus_find_device_by_fwnode
Date:   Tue, 25 Sep 2018 10:58:48 +0530
Message-Id: <1537853328-1282-2-git-send-email-svellattu@mvista.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537853328-1282-1-git-send-email-svellattu@mvista.com>
References: <1537853328-1282-1-git-send-email-svellattu@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bus_find_device_by_fwnode helper to find the device having a
specific firmware node on a bus.
---
 drivers/hwtracing/coresight/of_coresight.c         | 14 ++++----------
 drivers/i2c/i2c-core-of.c                          |  9 ++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  8 +-------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  8 +-------
 drivers/nvmem/core.c                               |  7 +------
 drivers/of/of_mdio.c                               |  8 +-------
 drivers/of/platform.c                              |  7 +------
 drivers/spi/spi.c                                  | 10 +++-------
 8 files changed, 14 insertions(+), 57 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 6880bee..8193b50 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -17,12 +17,6 @@
 #include <linux/cpumask.h>
 #include <asm/smp_plat.h>
 
-
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static struct device *
 of_coresight_get_endpoint_device(struct device_node *endpoint)
 {
@@ -32,8 +26,8 @@ static int of_dev_node_match(struct device *dev, void *data)
 	 * If we have a non-configurable replicator, it will be found on the
 	 * platform bus.
 	 */
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      endpoint, of_dev_node_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, NULL,
+					&endpoint->fwnode);
 	if (dev)
 		return dev;
 
@@ -41,8 +35,8 @@ static int of_dev_node_match(struct device *dev, void *data)
 	 * We have a configurable component - circle through the AMBA bus
 	 * looking for the device that matches the endpoint node.
 	 */
-	return bus_find_device(&amba_bustype, NULL,
-			       endpoint, of_dev_node_match);
+	return bus_find_device_by_fwnode(&amba_bustype, NULL,
+					&endpoint->fwnode);
 }
 
 static void of_coresight_get_ports(const struct device_node *node,
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 6cb7ad6..2b8ef8d 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -116,18 +116,13 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 	of_node_put(bus);
 }
 
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /* must call put_device() when done with returned i2c_client device */
 struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 {
 	struct device *dev;
 	struct i2c_client *client;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	dev = bus_find_device_by_fwnode(&i2c_bus_type, NULL, &node->fwnode);
 	if (!dev)
 		return NULL;
 
@@ -145,7 +140,7 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_adapter *adapter;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	dev = bus_find_device_by_fwnode(&i2c_bus_type, NULL, &node->fwnode);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 081aa91..b0d418e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4832,19 +4832,13 @@ static void hns_roce_v1_cleanup_eq_table(struct hns_roce_dev *hr_dev)
 };
 MODULE_DEVICE_TABLE(acpi, hns_roce_acpi_match);
 
-static int hns_roce_node_match(struct device *dev, void *fwnode)
-{
-	return dev->fwnode == fwnode;
-}
-
 static struct
 platform_device *hns_roce_find_pdev(struct fwnode_handle *fwnode)
 {
 	struct device *dev;
 
 	/* get the 'device' corresponding to the matching 'fwnode' */
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      fwnode, hns_roce_node_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, NULL, fwnode);
 	/* get the platform device */
 	return dev ? to_platform_device(dev) : NULL;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index 16294cd..d5d7c88 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -758,17 +758,11 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
 	return (void *)misc_op;
 }
 
-static int hns_dsaf_dev_match(struct device *dev, void *fwnode)
-{
-	return dev->fwnode == fwnode;
-}
-
 struct
 platform_device *hns_dsaf_find_platform_device(struct fwnode_handle *fwnode)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      fwnode, hns_dsaf_dev_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, NULL, fwnode);
 	return dev ? to_platform_device(dev) : NULL;
 }
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index aa16578..b62f236 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -262,11 +262,6 @@ static void nvmem_release(struct device *dev)
 	.name		= "nvmem",
 };
 
-static int of_nvmem_match(struct device *dev, void *nvmem_np)
-{
-	return dev->of_node == nvmem_np;
-}
-
 static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 {
 	struct device *d;
@@ -274,7 +269,7 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	if (!nvmem_np)
 		return NULL;
 
-	d = bus_find_device(&nvmem_bus_type, NULL, nvmem_np, of_nvmem_match);
+	d = bus_find_device_by_fwnode(&nvmem_bus_type, NULL, &nvmem_np->fwnode);
 
 	if (!d)
 		return NULL;
diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index e92391d..2906a6b 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -282,12 +282,6 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 }
 EXPORT_SYMBOL(of_mdiobus_register);
 
-/* Helper function for of_phy_find_device */
-static int of_phy_match(struct device *dev, void *phy_np)
-{
-	return dev->of_node == phy_np;
-}
-
 /**
  * of_phy_find_device - Give a PHY node, find the phy_device
  * @phy_np: Pointer to the phy's device tree node
@@ -303,7 +297,7 @@ struct phy_device *of_phy_find_device(struct device_node *phy_np)
 	if (!phy_np)
 		return NULL;
 
-	d = bus_find_device(&mdio_bus_type, NULL, phy_np, of_phy_match);
+	d = bus_find_device_by_fwnode(&mdio_bus_type, NULL, &phy_np->fwnode);
 	if (d) {
 		mdiodev = to_mdio_device(d);
 		if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY)
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 6c59673..36dd58e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -37,11 +37,6 @@
 	{} /* Empty terminated list */
 };
 
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * of_find_device_by_node - Find the platform_device associated with a node
  * @np: Pointer to device tree node
@@ -55,7 +50,7 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, NULL, &np->fwnode);
 	return dev ? to_platform_device(dev) : NULL;
 }
 EXPORT_SYMBOL(of_find_device_by_node);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9da0bc5..97128a5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3324,16 +3324,12 @@ int spi_write_then_read(struct spi_device *spi,
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
-static int __spi_of_device_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 /* must call put_device() when done with returned spi_device device */
 static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 {
-	struct device *dev = bus_find_device(&spi_bus_type, NULL, node,
-						__spi_of_device_match);
+	struct device *dev = bus_find_device_by_fwnode(&spi_bus_type, NULL,
+							&node->fwnode);
+
 	return dev ? to_spi_device(dev) : NULL;
 }
 
-- 
1.9.1


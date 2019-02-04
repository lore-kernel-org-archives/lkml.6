Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCC8C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55D92073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277937;
	bh=oTH3ePMmHCN10NpSl885csCSStnDUVLZcMkhKhsPtkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c6SRHUvCbGNwnrpzzBm6c3+fdVgQF52V4Il5Qe2GyQuSpUKd/oAVhJQc7ckjZbbai
	 PqBGy6Nfl3b6bsxrP8FgMNm4oOo2kmegoVKPFKyYDGmoz1BExla/rBaGRRInhkZw5T
	 y2vXHjLBXNgh+m3JBUQUzKwQF561P6lKzQBDo478=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfBDK64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfBDKuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672712184B;
        Mon,  4 Feb 2019 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277419;
        bh=oTH3ePMmHCN10NpSl885csCSStnDUVLZcMkhKhsPtkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6Lkf2ePAAAjCfq7x2IoxBbZ6np7odaaSWVkFTgi+u4zs1u6FDLnRZlpd44gnO7yt
         2+8tGttFTbqVj/DKtkFslwpt7Gbpia6N0pmLwMhyYvYb+k6GLur6917lnD4QM5Mpve
         SnTqHWXfZVut72SZC5G668If9QWIrNDmh9bF32R8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Rowand <frank.rowand@sony.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 68/74] of: Convert to using %pOFn instead of device_node.name
Date:   Mon,  4 Feb 2019 11:37:21 +0100
Message-Id: <20190204103628.846624258@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

commit a613b26a50136ae90ab13943afe90bcbd34adb44 upstream.

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/device.c   |    5 +++--
 drivers/of/of_mdio.c  |   12 ++++++------
 drivers/of/of_numa.c  |    4 ++--
 drivers/of/overlay.c  |    4 ++--
 drivers/of/platform.c |    8 ++++----
 drivers/of/unittest.c |   12 ++++++------
 6 files changed, 23 insertions(+), 22 deletions(-)

--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -221,7 +221,8 @@ static ssize_t of_device_get_modalias(st
 		return -ENODEV;
 
 	/* Name & Type */
-	csize = snprintf(str, len, "of:N%sT%s", dev->of_node->name,
+	/* %p eats all alphanum characters, so %c must be used here */
+	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
 			 dev->of_node->type);
 	tsize = csize;
 	len -= csize;
@@ -300,7 +301,7 @@ void of_device_uevent(struct device *dev
 	if ((!dev) || (!dev->of_node))
 		return;
 
-	add_uevent_var(env, "OF_NAME=%s", dev->of_node->name);
+	add_uevent_var(env, "OF_NAME=%pOFn", dev->of_node);
 	add_uevent_var(env, "OF_FULLNAME=%pOF", dev->of_node);
 	if (dev->of_node->type && strcmp("<NULL>", dev->of_node->type) != 0)
 		add_uevent_var(env, "OF_TYPE=%s", dev->of_node->type);
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -97,8 +97,8 @@ static int of_mdiobus_register_phy(struc
 		return rc;
 	}
 
-	dev_dbg(&mdio->dev, "registered phy %s at address %i\n",
-		child->name, addr);
+	dev_dbg(&mdio->dev, "registered phy %pOFn at address %i\n",
+		child, addr);
 	return 0;
 }
 
@@ -127,8 +127,8 @@ static int of_mdiobus_register_device(st
 		return rc;
 	}
 
-	dev_dbg(&mdio->dev, "registered mdio device %s at address %i\n",
-		child->name, addr);
+	dev_dbg(&mdio->dev, "registered mdio device %pOFn at address %i\n",
+		child, addr);
 	return 0;
 }
 
@@ -263,8 +263,8 @@ int of_mdiobus_register(struct mii_bus *
 				continue;
 
 			/* be noisy to encourage people to set reg property */
-			dev_info(&mdio->dev, "scan phy %s at address %i\n",
-				 child->name, addr);
+			dev_info(&mdio->dev, "scan phy %pOFn at address %i\n",
+				 child, addr);
 
 			if (of_mdiobus_child_is_phy(child)) {
 				rc = of_mdiobus_register_phy(mdio, child, addr);
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -168,8 +168,8 @@ int of_node_to_nid(struct device_node *d
 		np = of_get_next_parent(np);
 	}
 	if (np && r)
-		pr_warn("Invalid \"numa-node-id\" property in node %s\n",
-			np->name);
+		pr_warn("Invalid \"numa-node-id\" property in node %pOFn\n",
+			np);
 	of_node_put(np);
 
 	/*
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -427,8 +427,8 @@ static int build_changeset_next_level(st
 	for_each_child_of_node(overlay_node, child) {
 		ret = add_changeset_node(ovcs, target_node, child);
 		if (ret) {
-			pr_debug("Failed to apply node @%pOF/%s, err=%d\n",
-				 target_node, child->name, ret);
+			pr_debug("Failed to apply node @%pOF/%pOFn, err=%d\n",
+				 target_node, child, ret);
 			of_node_put(child);
 			return ret;
 		}
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -91,8 +91,8 @@ static void of_device_make_bus_id(struct
 		 */
 		reg = of_get_property(node, "reg", NULL);
 		if (reg && (addr = of_translate_address(node, reg)) != OF_BAD_ADDR) {
-			dev_set_name(dev, dev_name(dev) ? "%llx.%s:%s" : "%llx.%s",
-				     (unsigned long long)addr, node->name,
+			dev_set_name(dev, dev_name(dev) ? "%llx.%pOFn:%s" : "%llx.%pOFn",
+				     (unsigned long long)addr, node,
 				     dev_name(dev));
 			return;
 		}
@@ -142,8 +142,8 @@ struct platform_device *of_device_alloc(
 			WARN_ON(rc);
 		}
 		if (of_irq_to_resource_table(np, res, num_irq) != num_irq)
-			pr_debug("not all legacy IRQ resources mapped for %s\n",
-				 np->name);
+			pr_debug("not all legacy IRQ resources mapped for %pOFn\n",
+				 np);
 	}
 
 	dev->dev.of_node = of_node_get(np);
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -212,8 +212,8 @@ static int __init of_unittest_check_node
 
 	for_each_child_of_node(np, child) {
 		if (child->parent != np) {
-			pr_err("Child node %s links to wrong parent %s\n",
-				 child->name, np->name);
+			pr_err("Child node %pOFn links to wrong parent %pOFn\n",
+				 child, np);
 			rc = -EINVAL;
 			goto put_child;
 		}
@@ -1046,16 +1046,16 @@ static void __init of_unittest_platform_
 	for_each_child_of_node(np, child) {
 		for_each_child_of_node(child, grandchild)
 			unittest(of_find_device_by_node(grandchild),
-				 "Could not create device for node '%s'\n",
-				 grandchild->name);
+				 "Could not create device for node '%pOFn'\n",
+				 grandchild);
 	}
 
 	of_platform_depopulate(&test_bus->dev);
 	for_each_child_of_node(np, child) {
 		for_each_child_of_node(child, grandchild)
 			unittest(!of_find_device_by_node(grandchild),
-				 "device didn't get destroyed '%s'\n",
-				 grandchild->name);
+				 "device didn't get destroyed '%pOFn'\n",
+				 grandchild);
 	}
 
 	platform_device_unregister(test_bus);



Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6381ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5D214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4xskV4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F5D214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeIQXol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:44:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32793 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeIQXol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:44:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id b97-v6so2598251plb.0;
        Mon, 17 Sep 2018 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cR2ZY5S1Yja/f9VPMz3/lblLM7a2jgt5NnCXrQBwTLk=;
        b=c4xskV4sIjAyCBbVTJ0Vt+mRWJYOz75PIRumQMq0iHkphvsdPTjIYEVtJ4a3wbXyXX
         tfJO+aMm7vsU0Azc6J4Gd0U67PNrRvl+toeIOAeYt8qFcJOtmrqhYBNCUhDB8T4ALsJS
         sZEjw/jC0bruDToOUA22z2RCUL5QHYGqxcM8Ha1kBalx2h3vZbp8ePOI+dUSWYoScsh1
         ejHkn1Yn2/TGJonxDJnUr5oPFJj1qG6G/pcbZXQJyCxTq6Xr7RJV6GtvnnkUOfcNBNOH
         pt1SLd3WQsOXhRmQVPAVNva9awHL32vrRaxSZl7pS1sN3i+/o2nRA0jQJu3IocjTE+H+
         eJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cR2ZY5S1Yja/f9VPMz3/lblLM7a2jgt5NnCXrQBwTLk=;
        b=OoGTQMVK+phwpM5/qEDrNesdYYReJljfCh6DYTjDKYbOboflllCfUDlyXZ6kS3XDPq
         3obChRfndzf1lFQTTWqspXYsWG+1WN9vZaq7h6bjuTjTyWQP/bdMZb6XsymNjeIyK8hX
         kb3nkDgP1w+AH6/OmrLPAZZwxgsF8e19ojSXdtcRWgQK88N41kI0JjQTcGNc5uP20YCe
         GwPrQUSbS3/frSTt2Ja7hql1DIo8AFIQZumh/58+Kr/ml3k2PBE/zhNV1BDWOlME8qsX
         OclGw938VBNg9F+fopIg3sRVewuN11DMFhBpHRf3toMUd1v4BZDTMjrXcjlwAKjaTbMj
         VnSg==
X-Gm-Message-State: APzg51Be5co7rYjcsvfRSOd4XCdTLpPsJSw58RDH1HW5P4JW6Q+kqi9E
        Jna16cvzYc0HfmqqRtwDBPM=
X-Google-Smtp-Source: ANB0VdaYkGooPjhs86OMmjctxm1O4CRss1h7MZmiu8Oogo1OczAK60zjhJjI4o/QT766065kQspwgw==
X-Received: by 2002:a17:902:d694:: with SMTP id v20-v6mr25517217ply.328.1537208170392;
        Mon, 17 Sep 2018 11:16:10 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 74-v6sm24076366pfv.33.2018.09.17.11.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:16:09 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC/PATCH 2/5] device property: introduce notion of subnodes for legacy boards
Date:   Mon, 17 Sep 2018 11:16:00 -0700
Message-Id: <20180917181603.125492-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers rely on having notion of sub-nodes when describing
hardware, let's allow static board-defined properties also have it.

The board files will then attach properties to devices in the following
fashion:

	device_add_properties(&board_platform_device.dev,
			      main_device_props);
	device_add_child_properties(&board_platform_device.dev,
				    dev_fwnode(&board_platform_device.dev),
				    child1_device_props);
	device_add_child_properties(&board_platform_device.dev,
				    dev_fwnode(&board_platform_device.dev),
				    child2_device_props);
	...
	platform_device_register(&board_platform_device.dev);

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/pset_property.c | 110 +++++++++++++++++++++++++++++++----
 include/linux/property.h     |   4 ++
 2 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
index 08ecc13080ae..63f2377aefe8 100644
--- a/drivers/base/pset_property.c
+++ b/drivers/base/pset_property.c
@@ -18,6 +18,11 @@ struct property_set {
 	struct device *dev;
 	struct fwnode_handle fwnode;
 	const struct property_entry *properties;
+
+	struct property_set *parent;
+	/* Entry in parent->children list */
+	struct list_head child_node;
+	struct list_head children;
 };
 
 static const struct fwnode_operations pset_fwnode_ops;
@@ -283,10 +288,47 @@ pset_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 					   val, nval);
 }
 
+struct fwnode_handle *pset_fwnode_get_parent(const struct fwnode_handle *fwnode)
+{
+	struct property_set *pset = to_pset_node(fwnode);
+
+	return pset ? &pset->parent->fwnode : NULL;
+}
+
+struct fwnode_handle *
+pset_fwnode_get_next_subnode(const struct fwnode_handle *fwnode,
+			     struct fwnode_handle *child)
+{
+	const struct property_set *pset = to_pset_node(fwnode);
+	struct property_set *first_child;
+	struct property_set *next;
+
+	if (!pset)
+		return NULL;
+
+	if (list_empty(&pset->children))
+		return NULL;
+
+	first_child = list_first_entry(&pset->children, struct property_set,
+				       child_node);
+
+	if (child) {
+		next = list_next_entry(to_pset_node(child), child_node);
+		if (next == first_child)
+			return NULL;
+	} else {
+		next = first_child;
+	}
+
+	return &next->fwnode;
+}
+
 static const struct fwnode_operations pset_fwnode_ops = {
 	.property_present = pset_fwnode_property_present,
 	.property_read_int_array = pset_fwnode_read_int_array,
 	.property_read_string_array = pset_fwnode_property_read_string_array,
+	.get_parent = pset_fwnode_get_parent,
+	.get_next_child_node = pset_fwnode_get_next_subnode,
 };
 
 static void property_entry_free_data(const struct property_entry *p)
@@ -439,24 +481,31 @@ EXPORT_SYMBOL_GPL(property_entries_free);
  */
 static void pset_free_set(struct property_set *pset)
 {
+	struct property_set *child, *next;
+
 	if (!pset)
 		return;
 
+	list_for_each_entry_safe(child, next, &pset->children, child_node) {
+		list_del(&child->child_node);
+		pset_free_set(child);
+	}
+
 	property_entries_free(pset->properties);
 	kfree(pset);
 }
 
 /**
- * pset_copy_set - copies property set
- * @pset: Property set to copy
+ * pset_create_set - creates property set.
+ * @src: property entries for the set.
  *
- * This function takes a deep copy of the given property set and returns
- * pointer to the copy. Call device_free_property_set() to free resources
- * allocated in this function.
+ * This function takes a deep copy of the given property entries and creates
+ * property set. Call pset_free_set() to free resources allocated in this
+ * function.
  *
  * Return: Pointer to the new property set or error pointer.
  */
-static struct property_set *pset_copy_set(const struct property_set *pset)
+static struct property_set *pset_create_set(const struct property_entry *src)
 {
 	struct property_entry *properties;
 	struct property_set *p;
@@ -465,7 +514,11 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-	properties = property_entries_dup(pset->properties);
+	INIT_LIST_HEAD(&p->child_node);
+	INIT_LIST_HEAD(&p->children);
+	p->fwnode.ops = &pset_fwnode_ops;
+
+	properties = property_entries_dup(src);
 	if (IS_ERR(properties)) {
 		kfree(p);
 		return ERR_CAST(properties);
@@ -521,20 +574,53 @@ EXPORT_SYMBOL_GPL(device_remove_properties);
 int device_add_properties(struct device *dev,
 			  const struct property_entry *properties)
 {
-	struct property_set *p, pset;
+	struct property_set *p;
 
 	if (!properties)
 		return -EINVAL;
 
-	pset.properties = properties;
-
-	p = pset_copy_set(&pset);
+	p = pset_create_set(properties);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
-	p->fwnode.ops = &pset_fwnode_ops;
 	set_secondary_fwnode(dev, &p->fwnode);
 	p->dev = dev;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_add_properties);
+
+/**
+ * device_add_child_properties - Add a collection of properties to a device object.
+ * @dev: Device to add properties to.
+ * @properties: Collection of properties to add.
+ *
+ * Associate a collection of device properties represented by @properties as a
+ * child of given @parent firmware node.  The function takes a copy of
+ * @properties.
+ */
+struct fwnode_handle *
+device_add_child_properties(struct device *dev,
+			    struct fwnode_handle *parent,
+			    const struct property_entry *properties)
+{
+	struct property_set *p;
+	struct property_set *parent_pset;
+
+	if (!properties)
+		return ERR_PTR(-EINVAL);
+
+	parent_pset = to_pset_node(parent);
+	if (!parent_pset)
+		return ERR_PTR(-EINVAL);
+
+	p = pset_create_set(properties);
+	if (IS_ERR(p))
+		return ERR_CAST(p);
+
+	p->dev = dev;
+	p->parent = parent_pset;
+	list_add_tail(&p->child_node, &parent_pset->children);
+
+	return &p->fwnode;
+}
+EXPORT_SYMBOL_GPL(device_add_child_properties);
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..bb1cf4f30770 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -275,6 +275,10 @@ void property_entries_free(const struct property_entry *properties);
 
 int device_add_properties(struct device *dev,
 			  const struct property_entry *properties);
+struct fwnode_handle *
+device_add_child_properties(struct device *dev,
+			    struct fwnode_handle *parent,
+			    const struct property_entry *properties);
 void device_remove_properties(struct device *dev);
 
 bool device_dma_supported(struct device *dev);
-- 
2.19.0.397.gdd90340f6a-goog


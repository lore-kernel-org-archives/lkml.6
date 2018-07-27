Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9886C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8572B20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYw8P9fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8572B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeG0E1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39397 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeG0E1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so1682487plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pGnxir1oob5OGoqmjTbPnG7tVmphNN3KedCX4NUtPQ=;
        b=qYw8P9fxzkJYUzUtdD2/UtkpK9LTrVQEzyDiSeLjllFz8LQLwGxu3d+7JeRG5F0dlU
         1IQtqas56zg7B0jsg2lhzsKqQ9bgWfLMILYsyeNx1D53cw84/TlOGpXlOXOjW6POWWze
         L4JWs7YY5Eo47TBC2z8Qcxp6v6tMEXFN6XNxIegMxIrq6ZEtgaC24SnLQtBKtjNKduqG
         heXd0wUsuywOUpOJU+105WtW/8g4+eQ6TEHUhRBJTmtWTMy1juvG//XEkIyMtwL8jUr6
         B11ZmEopJK25Is3TYwfZ+8M1aVodKmmViTctnt3/oy+Fq2Qx9ipNAOVDQH8xom3YrqEO
         ot9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pGnxir1oob5OGoqmjTbPnG7tVmphNN3KedCX4NUtPQ=;
        b=Rt2mda5034et2gVSnKSwettaLQdDy6xoh0hCATq6k816zebzkAAkD/NTx30xxME8LG
         flP9Hz4ghJrYJxPHv4w68JWl/kpdCW51gQg1VPnFECX6hnl5RLwqjfjyc2nU4QlWsmEs
         2sIiHBuAtulLzyRenZPYZ9QF1YnqcWTxorBxb54fo0wHxazsy+VYeAXha/g3p1pm5C4c
         KdmGZPg1YTiESJj9FDAEsahwY+XkTsiu36U6YHklgxRouXi58tcj1aCKpQNkN7kXWSI4
         8kI3uBOyNyLalVAitksCT5+UxW3iD+h4OmbFlSmNaRNrLvQvDz6X8aC8R02xvg77rqRH
         fkLA==
X-Gm-Message-State: AOUpUlF0FEVbj4z1bx0eOaRi4NRB9nfi/cOuzqG35YN+tV9/j7jKACxh
        q4jet8G6jr8M5skrYnbPEU0=
X-Google-Smtp-Source: AAOMgpf0jJDnjUItGnDdnWBwbYOECOaCDCiLZ47b0x+WCmkY3308ALU5RCVPKwnKb4qWWwtELCF/qA==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr4255543plr.231.1532660888594;
        Thu, 26 Jul 2018 20:08:08 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:08 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/10] staging: gasket: sysfs: convert to standard logging
Date:   Thu, 26 Jul 2018 20:07:33 -0700
Message-Id: <20180727030737.231268-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Drop gasket logging calls in favor of standard logging.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 73 +++++++++++++--------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index 1c5f7502e0d5e..418b81797e638 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -3,7 +3,9 @@
 #include "gasket_sysfs.h"
 
 #include "gasket_core.h"
-#include "gasket_logging.h"
+
+#include <linux/device.h>
+#include <linux/printk.h>
 
 /*
  * Pair of kernel device and user-specified pointer. Used in lookups in sysfs
@@ -66,7 +68,7 @@ static struct gasket_sysfs_mapping *get_mapping(struct device *device)
 	int i;
 
 	if (!device) {
-		gasket_nodev_error("Received NULL device!");
+		pr_debug("%s: Received NULL device\n", __func__);
 		return NULL;
 	}
 
@@ -80,7 +82,8 @@ static struct gasket_sysfs_mapping *get_mapping(struct device *device)
 		mutex_unlock(&dev_mappings[i].mutex);
 	}
 
-	gasket_nodev_info("Mapping to device %s not found.", device->kobj.name);
+	dev_dbg(device, "%s: Mapping to device %s not found\n",
+		__func__, device->kobj.name);
 	return NULL;
 }
 
@@ -103,16 +106,15 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 	struct device *device;
 
 	if (!mapping) {
-		gasket_nodev_info("Mapping should not be NULL.");
+		pr_debug("%s: Mapping should not be NULL\n", __func__);
 		return;
 	}
 
 	mutex_lock(&mapping->mutex);
 	if (refcount_read(&mapping->refcount.refcount) == 0)
-		gasket_nodev_error("Refcount is already 0!");
+		dev_err(mapping->device, "Refcount is already 0\n");
 	if (kref_put(&mapping->refcount, release_entry)) {
-		gasket_nodev_info("Removing Gasket sysfs mapping, device %s",
-				  mapping->device->kobj.name);
+		dev_dbg(mapping->device, "Removing Gasket sysfs mapping\n");
 		/*
 		 * We can't remove the sysfs nodes in the kref callback, since
 		 * device_remove_file() blocks until the node is free.
@@ -182,16 +184,13 @@ int gasket_sysfs_create_mapping(
 	static DEFINE_MUTEX(function_mutex);
 
 	mutex_lock(&function_mutex);
-
-	gasket_nodev_info(
-		"Creating sysfs entries for device pointer 0x%p.", device);
+	dev_dbg(device, "Creating sysfs entries for device\n");
 
 	/* Check that the device we're adding hasn't already been added. */
 	mapping = get_mapping(device);
 	if (mapping) {
-		gasket_nodev_error(
-			"Attempting to re-initialize sysfs mapping for device "
-			"0x%p.", device);
+		dev_err(device,
+			"Attempting to re-initialize sysfs mapping for device\n");
 		put_mapping(mapping);
 		mutex_unlock(&function_mutex);
 		return -EBUSY;
@@ -207,13 +206,13 @@ int gasket_sysfs_create_mapping(
 	}
 
 	if (map_idx == GASKET_SYSFS_NUM_MAPPINGS) {
-		gasket_nodev_error("All mappings have been exhausted!");
+		dev_err(device, "All mappings have been exhausted\n");
 		mutex_unlock(&function_mutex);
 		return -ENOMEM;
 	}
 
-	gasket_nodev_info(
-		"Creating sysfs mapping for device %s.", device->kobj.name);
+	dev_dbg(device, "Creating sysfs mapping for device %s\n",
+		device->kobj.name);
 
 	mapping = &dev_mappings[map_idx];
 	kref_init(&mapping->refcount);
@@ -224,7 +223,7 @@ int gasket_sysfs_create_mapping(
 				      GFP_KERNEL);
 	mapping->attribute_count = 0;
 	if (!mapping->attributes) {
-		gasket_nodev_error("Unable to allocate sysfs attribute array.");
+		dev_dbg(device, "Unable to allocate sysfs attribute array\n");
 		mapping->device = NULL;
 		mapping->gasket_dev = NULL;
 		mutex_unlock(&mapping->mutex);
@@ -247,10 +246,9 @@ int gasket_sysfs_create_entries(
 	struct gasket_sysfs_mapping *mapping = get_mapping(device);
 
 	if (!mapping) {
-		gasket_nodev_error(
-			"Creating entries for device 0x%p without first "
-			"initializing mapping.",
-			device);
+		dev_dbg(device,
+			"Creating entries for device without first "
+			"initializing mapping\n");
 		return -EINVAL;
 	}
 
@@ -258,9 +256,9 @@ int gasket_sysfs_create_entries(
 	for (i = 0; strcmp(attrs[i].attr.attr.name, GASKET_ARRAY_END_MARKER);
 		i++) {
 		if (mapping->attribute_count == GASKET_SYSFS_MAX_NODES) {
-			gasket_nodev_error(
+			dev_err(device,
 				"Maximum number of sysfs nodes reached for "
-				"device.");
+				"device\n");
 			mutex_unlock(&mapping->mutex);
 			put_mapping(mapping);
 			return -ENOMEM;
@@ -268,7 +266,7 @@ int gasket_sysfs_create_entries(
 
 		ret = device_create_file(device, &attrs[i].attr);
 		if (ret) {
-			gasket_nodev_error("Unable to create device entries");
+			dev_dbg(device, "Unable to create device entries\n");
 			mutex_unlock(&mapping->mutex);
 			put_mapping(mapping);
 			return ret;
@@ -289,10 +287,9 @@ void gasket_sysfs_remove_mapping(struct device *device)
 	struct gasket_sysfs_mapping *mapping = get_mapping(device);
 
 	if (!mapping) {
-		gasket_nodev_error(
+		dev_err(device,
 			"Attempted to remove non-existent sysfs mapping to "
-			"device 0x%p",
-			device);
+			"device\n");
 		return;
 	}
 
@@ -304,7 +301,7 @@ struct gasket_dev *gasket_sysfs_get_device_data(struct device *device)
 	struct gasket_sysfs_mapping *mapping = get_mapping(device);
 
 	if (!mapping) {
-		gasket_nodev_error("device %p not registered.", device);
+		dev_err(device, "device not registered\n");
 		return NULL;
 	}
 
@@ -342,8 +339,8 @@ struct gasket_sysfs_attribute *gasket_sysfs_get_attr(
 			return &attrs[i];
 	}
 
-	gasket_nodev_error("Unable to find match for device_attribute %s",
-			   attr->attr.name);
+	dev_err(device, "Unable to find match for device_attribute %s\n",
+		attr->attr.name);
 	return NULL;
 }
 EXPORT_SYMBOL(gasket_sysfs_get_attr);
@@ -368,8 +365,8 @@ void gasket_sysfs_put_attr(
 		}
 	}
 
-	gasket_nodev_error(
-		"Unable to put unknown attribute: %s", attr->attr.attr.name);
+	dev_err(device, "Unable to put unknown attribute: %s\n",
+		attr->attr.attr.name);
 }
 EXPORT_SYMBOL(gasket_sysfs_put_attr);
 
@@ -383,26 +380,26 @@ ssize_t gasket_sysfs_register_store(
 	struct gasket_sysfs_attribute *gasket_attr;
 
 	if (count < 3 || buf[0] != '0' || buf[1] != 'x') {
-		gasket_nodev_error(
-			"sysfs register write format: \"0x<hex value>\".");
+		dev_err(device,
+			"sysfs register write format: \"0x<hex value>\"\n");
 		return -EINVAL;
 	}
 
 	if (kstrtoul(buf, 16, &parsed_value) != 0) {
-		gasket_nodev_error(
-			"Unable to parse input as 64-bit hex value: %s.", buf);
+		dev_err(device,
+			"Unable to parse input as 64-bit hex value: %s\n", buf);
 		return -EINVAL;
 	}
 
 	mapping = get_mapping(device);
 	if (!mapping) {
-		gasket_nodev_info("Device driver may have been removed.");
+		dev_err(device, "Device driver may have been removed\n");
 		return 0;
 	}
 
 	gasket_dev = mapping->gasket_dev;
 	if (!gasket_dev) {
-		gasket_nodev_info("Device driver may have been removed.");
+		dev_err(device, "Device driver may have been removed\n");
 		return 0;
 	}
 
-- 
2.18.0.345.g5c9ce644c3-goog


Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6DF20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8CmRmw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6DF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeG0E1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39314 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeG0E1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id a11-v6so2354833pgw.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMwgiws/J1ooOKI/sUjb7fZG3U3VXqRXlpFRHLa0Npw=;
        b=F8CmRmw33qWJQo0SEZtWFggAZAjD8fQVKhbzYMGRr27zrlpNK3bZ93+ER8H6yoXZDZ
         q252W+jhtW+far04iHHPUGyoQ3EqE5IuCAetS0QwrytLUw2o9G2te/IAa+l0zKx3ddvr
         QU76PpGqAqjfXJvHXjKX5/hAxyzhgjp9M0GIXP1Yq8p+yOTiRoyCdRHU0BJFbSqTIhmH
         5NDG2Sn6WQFJIVJJNCIJPPQm9gNbS9W9pHZimDkB5KSEvsGNPkeXCQcl5viU+qHihWP1
         pvuClJR4mJqtbkyqps6qiyWm2LzELz8bt982ihcaXMox3GkSiuWEx9pB71U4js+DaXhJ
         ySuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMwgiws/J1ooOKI/sUjb7fZG3U3VXqRXlpFRHLa0Npw=;
        b=USciD1Lm7c9ZIPOoTi9fKkVwfmKXmzhhGbZaK4JEjCLD7YOHbXn259cF6xWwPmyPXN
         mpTVK1Sru1JPwOcTe3fPWseSKMN5bVtn0DdxYeMN708PStyqeA76T2vvKwGEWhGim2hJ
         jUrdwAKUUvmAZzx1b6lNhV97FjuyHEHqM36eeAtE1MdrOOjqrnYuCpZde1BbVUgDCr2B
         l1prdAa8y7zb+NXQQ0TrFi2Y5aEXEdYIOIWp/LRLLQOtYn7fk5D6tB4Dyy6Iz8msB/V7
         Q/PuedJ0iJbngPU9igQH55pa8eXAurMRusqy7ArSJ4EN/g3a6D04TZC48DfNM6JnLnq6
         uuXA==
X-Gm-Message-State: AOUpUlFyaPAt2QydIglcOSvisqGvkRPVaDU+0gBjRHV+pO1Hy5NbTVgP
        n3f+t37HxNh/5jBGhsAAh4N75He4
X-Google-Smtp-Source: AAOMgpdFYOdN+y0/xG5HHjD/c/i/Eun7X9X0VEto/iqYF4Yoe5zuC3eVa2+h80Mxk93bTfw3lSz2QA==
X-Received: by 2002:a63:f45:: with SMTP id 5-v6mr4377266pgp.447.1532660884679;
        Thu, 26 Jul 2018 20:08:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:04 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/10] staging: gasket: core: convert to standard logging
Date:   Thu, 26 Jul 2018 20:07:29 -0700
Message-Id: <20180727030737.231268-3-toddpoynor@gmail.com>
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

Use standard logging functions, drop use of gasket log functions.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 295 ++++++++++++---------------
 1 file changed, 134 insertions(+), 161 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index e8f3b021c20d1..f44805c38159b 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -10,15 +10,16 @@
 
 #include "gasket_interrupt.h"
 #include "gasket_ioctl.h"
-#include "gasket_logging.h"
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/printk.h>
 
 #ifdef GASKET_KERNEL_TRACE_SUPPORT
 #define CREATE_TRACE_POINTS
@@ -205,8 +206,8 @@ static inline int check_and_invoke_callback(
 {
 	int ret = 0;
 
-	gasket_log_debug(gasket_dev, "check_and_invoke_callback %p",
-			 cb_function);
+	dev_dbg(gasket_dev->dev, "check_and_invoke_callback %p\n",
+		cb_function);
 	if (cb_function) {
 		mutex_lock(&gasket_dev->mutex);
 		ret = cb_function(gasket_dev);
@@ -228,8 +229,8 @@ static inline int gasket_check_and_invoke_callback_nolock(
 	int ret = 0;
 
 	if (cb_function) {
-		gasket_log_debug(
-			gasket_dev, "Invoking device-specific callback.");
+		dev_dbg(gasket_dev->dev,
+			"Invoking device-specific callback.\n");
 		ret = cb_function(gasket_dev);
 	}
 	return ret;
@@ -250,7 +251,7 @@ static int __init gasket_init(void)
 {
 	int i;
 
-	gasket_nodev_info("Performing one-time init of the Gasket framework.");
+	pr_info("Performing one-time init of the Gasket framework.\n");
 	/* Check for duplicates and find a free slot. */
 	mutex_lock(&g_mutex);
 	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
@@ -267,7 +268,7 @@ static int __init gasket_init(void)
 static void __exit gasket_exit(void)
 {
 	/* No deinit/dealloc needed at present. */
-	gasket_nodev_info("Removing Gasket framework module.");
+	pr_info("Removing Gasket framework module.\n");
 }
 
 /* See gasket_core.h for description. */
@@ -277,15 +278,14 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	int desc_idx = -1;
 	struct gasket_internal_desc *internal;
 
-	gasket_nodev_info("Initializing Gasket framework device");
+	pr_info("Initializing Gasket framework device\n");
 	/* Check for duplicates and find a free slot. */
 	mutex_lock(&g_mutex);
 
 	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
 		if (g_descs[i].driver_desc == driver_desc) {
-			gasket_nodev_error(
-				"%s driver already loaded/registered",
-				driver_desc->name);
+			pr_err("%s driver already loaded/registered\n",
+			       driver_desc->name);
 			mutex_unlock(&g_mutex);
 			return -EBUSY;
 		}
@@ -301,17 +301,17 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	}
 	mutex_unlock(&g_mutex);
 
-	gasket_nodev_info("Loaded %s driver, framework version %s",
-			  driver_desc->name, GASKET_FRAMEWORK_VERSION);
+	pr_info("Loaded %s driver, framework version %s\n",
+		driver_desc->name, GASKET_FRAMEWORK_VERSION);
 
 	if (desc_idx == -1) {
-		gasket_nodev_error("Too many Gasket drivers loaded: %d\n",
-				   GASKET_FRAMEWORK_DESC_MAX);
+		pr_err("Too many Gasket drivers loaded: %d\n",
+		       GASKET_FRAMEWORK_DESC_MAX);
 		return -EBUSY;
 	}
 
 	/* Internal structure setup. */
-	gasket_nodev_info("Performing initial internal structure setup.");
+	pr_debug("Performing initial internal structure setup.\n");
 	internal = &g_descs[desc_idx];
 	mutex_init(&internal->mutex);
 	memset(internal->devs, 0, sizeof(struct gasket_dev *) * GASKET_DEV_MAX);
@@ -324,8 +324,8 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 		class_create(driver_desc->module, driver_desc->name);
 
 	if (IS_ERR(internal->class)) {
-		gasket_nodev_error("Cannot register %s class [ret=%ld]",
-				   driver_desc->name, PTR_ERR(internal->class));
+		pr_err("Cannot register %s class [ret=%ld]\n",
+		       driver_desc->name, PTR_ERR(internal->class));
 		ret = PTR_ERR(internal->class);
 		goto unregister_gasket_driver;
 	}
@@ -334,25 +334,24 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	 * Not using pci_register_driver() (without underscores), as it
 	 * depends on KBUILD_MODNAME, and this is a shared file.
 	 */
-	gasket_nodev_info("Registering PCI driver.");
+	pr_debug("Registering PCI driver.\n");
 	ret = __pci_register_driver(
 		&internal->pci, driver_desc->module, driver_desc->name);
 	if (ret) {
-		gasket_nodev_error(
-			"cannot register pci driver [ret=%d]", ret);
+		pr_err("cannot register pci driver [ret=%d]\n", ret);
 		goto fail1;
 	}
 
-	gasket_nodev_info("Registering char driver.");
+	pr_debug("Registering char driver.\n");
 	ret = register_chrdev_region(
 		MKDEV(driver_desc->major, driver_desc->minor), GASKET_DEV_MAX,
 		driver_desc->name);
 	if (ret) {
-		gasket_nodev_error("cannot register char driver [ret=%d]", ret);
+		pr_err("cannot register char driver [ret=%d]\n", ret);
 		goto fail2;
 	}
 
-	gasket_nodev_info("Driver registered successfully.");
+	pr_info("Driver registered successfully.\n");
 	return 0;
 
 fail2:
@@ -386,10 +385,9 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	mutex_unlock(&g_mutex);
 
 	if (!internal_desc) {
-		gasket_nodev_error(
-			"request to unregister unknown desc: %s, %d:%d",
-			driver_desc->name, driver_desc->major,
-			driver_desc->minor);
+		pr_err("request to unregister unknown desc: %s, %d:%d\n",
+		       driver_desc->name, driver_desc->major,
+		       driver_desc->minor);
 		return;
 	}
 
@@ -405,7 +403,7 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 	g_descs[desc_idx].driver_desc = NULL;
 	mutex_unlock(&g_mutex);
 
-	gasket_nodev_info("removed %s driver", driver_desc->name);
+	pr_info("removed %s driver\n", driver_desc->name);
 }
 EXPORT_SYMBOL(gasket_unregister_device);
 
@@ -430,7 +428,7 @@ static int gasket_alloc_dev(
 	struct gasket_dev *gasket_dev;
 	struct gasket_cdev_info *dev_info;
 
-	gasket_nodev_info("Allocating a Gasket device %s.", kobj_name);
+	pr_debug("Allocating a Gasket device %s.\n", kobj_name);
 
 	*pdev = NULL;
 
@@ -440,7 +438,7 @@ static int gasket_alloc_dev(
 
 	gasket_dev = *pdev = kzalloc(sizeof(*gasket_dev), GFP_KERNEL);
 	if (!gasket_dev) {
-		gasket_nodev_error("no memory for device");
+		pr_err("no memory for device\n");
 		return -ENOMEM;
 	}
 	internal_desc->devs[dev_idx] = gasket_dev;
@@ -466,7 +464,7 @@ static int gasket_alloc_dev(
 	dev_info->device = device_create(internal_desc->class, parent,
 		dev_info->devt, gasket_dev, dev_info->name);
 
-	gasket_nodev_info("Gasket device allocated: %p.", dev_info->device);
+	dev_dbg(dev_info->device, "Gasket device allocated.\n");
 
 	/* cdev has not yet been added; cdev_added is 0 */
 	dev_info->gasket_dev_ptr = gasket_dev;
@@ -509,7 +507,7 @@ static int gasket_find_dev_slot(
 	for (i = 0; i < GASKET_DEV_MAX; i++) {
 		if (internal_desc->devs[i] &&
 		    strcmp(internal_desc->devs[i]->kobj_name, kobj_name) == 0) {
-			gasket_nodev_error("Duplicate device %s", kobj_name);
+			pr_err("Duplicate device %s\n", kobj_name);
 			mutex_unlock(&internal_desc->mutex);
 			return -EBUSY;
 		}
@@ -522,8 +520,7 @@ static int gasket_find_dev_slot(
 	}
 
 	if (i == GASKET_DEV_MAX) {
-		gasket_nodev_info(
-			"Too many registered devices; max %d", GASKET_DEV_MAX);
+		pr_err("Too many registered devices; max %d\n", GASKET_DEV_MAX);
 		mutex_unlock(&internal_desc->mutex);
 		return -EBUSY;
 	}
@@ -552,13 +549,13 @@ static int gasket_pci_probe(
 	const struct gasket_driver_desc *driver_desc;
 	struct device *parent;
 
-	gasket_nodev_info("Add Gasket device %s", kobj_name);
+	pr_info("Add Gasket device %s\n", kobj_name);
 
 	mutex_lock(&g_mutex);
 	internal_desc = lookup_internal_desc(pci_dev);
 	mutex_unlock(&g_mutex);
 	if (!internal_desc) {
-		gasket_nodev_info("PCI probe called for unknown driver type");
+		pr_err("PCI probe called for unknown driver type\n");
 		return -ENODEV;
 	}
 
@@ -569,9 +566,9 @@ static int gasket_pci_probe(
 	if (ret)
 		return ret;
 	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
-		gasket_nodev_error("Cannot create %s device %s [ret = %ld]",
-				   driver_desc->name, gasket_dev->dev_info.name,
-				   PTR_ERR(gasket_dev->dev_info.device));
+		pr_err("Cannot create %s device %s [ret = %ld]\n",
+		       driver_desc->name, gasket_dev->dev_info.name,
+		       PTR_ERR(gasket_dev->dev_info.device));
 		ret = -ENODEV;
 		goto fail1;
 	}
@@ -583,7 +580,7 @@ static int gasket_pci_probe(
 
 	ret = check_and_invoke_callback(gasket_dev, driver_desc->add_dev_cb);
 	if (ret) {
-		gasket_log_error(gasket_dev, "Error in add device cb: %d", ret);
+		dev_err(gasket_dev->dev, "Error in add device cb: %d\n", ret);
 		goto fail2;
 	}
 
@@ -599,8 +596,8 @@ static int gasket_pci_probe(
 	ret = sysfs_create_link(&gasket_dev->dev_info.device->kobj,
 				&pci_dev->dev.kobj, dev_name(&pci_dev->dev));
 	if (ret) {
-		gasket_log_error(
-			gasket_dev, "Cannot create sysfs pci link: %d", ret);
+		dev_err(gasket_dev->dev,
+			"Cannot create sysfs pci link: %d\n", ret);
 		goto fail3;
 	}
 	ret = gasket_sysfs_create_entries(
@@ -611,14 +608,13 @@ static int gasket_pci_probe(
 	ret = check_and_invoke_callback(
 		gasket_dev, driver_desc->sysfs_setup_cb);
 	if (ret) {
-		gasket_log_error(
-			gasket_dev, "Error in sysfs setup cb: %d", ret);
+		dev_err(gasket_dev->dev, "Error in sysfs setup cb: %d\n", ret);
 		goto fail5;
 	}
 
 	ret = gasket_enable_dev(internal_desc, gasket_dev);
 	if (ret) {
-		gasket_nodev_error("cannot setup %s device", driver_desc->name);
+		pr_err("cannot setup %s device\n", driver_desc->name);
 		gasket_disable_dev(gasket_dev);
 		goto fail5;
 	}
@@ -677,8 +673,7 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
 	if (!gasket_dev)
 		return;
 
-	gasket_nodev_info(
-		"remove %s device %s", internal_desc->driver_desc->name,
+	pr_info("remove %s device %s\n", internal_desc->driver_desc->name,
 		gasket_dev->kobj_name);
 
 	gasket_disable_dev(gasket_dev);
@@ -711,7 +706,7 @@ static int gasket_setup_pci(
 	gasket_dev->pci_dev = pci_dev;
 	ret = pci_enable_device(pci_dev);
 	if (ret) {
-		gasket_log_error(gasket_dev, "cannot enable PCI device");
+		dev_err(gasket_dev->dev, "cannot enable PCI device\n");
 		return ret;
 	}
 
@@ -777,17 +772,16 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 	gasket_dev->bar_data[bar_num].phys_base =
 		(ulong)pci_resource_start(gasket_dev->pci_dev, bar_num);
 	if (!gasket_dev->bar_data[bar_num].phys_base) {
-		gasket_log_error(gasket_dev, "Cannot get BAR%u base address",
-				 bar_num);
+		dev_err(gasket_dev->dev, "Cannot get BAR%u base address\n",
+			bar_num);
 		return -EINVAL;
 	}
 
 	gasket_dev->bar_data[bar_num].length_bytes =
 		(ulong)pci_resource_len(gasket_dev->pci_dev, bar_num);
 	if (gasket_dev->bar_data[bar_num].length_bytes < desc_bytes) {
-		gasket_log_error(
-			gasket_dev,
-			"PCI BAR %u space is too small: %lu; expected >= %lu",
+		dev_err(gasket_dev->dev,
+			"PCI BAR %u space is too small: %lu; expected >= %lu\n",
 			bar_num, gasket_dev->bar_data[bar_num].length_bytes,
 			desc_bytes);
 		return -ENOMEM;
@@ -796,9 +790,8 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 	if (!request_mem_region(gasket_dev->bar_data[bar_num].phys_base,
 				gasket_dev->bar_data[bar_num].length_bytes,
 				gasket_dev->dev_info.name)) {
-		gasket_log_error(
-			gasket_dev,
-			"Cannot get BAR %d memory region %p",
+		dev_err(gasket_dev->dev,
+			"Cannot get BAR %d memory region %p\n",
 			bar_num, &gasket_dev->pci_dev->resource[bar_num]);
 		return -EINVAL;
 	}
@@ -807,9 +800,8 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 		ioremap_nocache(gasket_dev->bar_data[bar_num].phys_base,
 				gasket_dev->bar_data[bar_num].length_bytes);
 	if (!gasket_dev->bar_data[bar_num].virt_base) {
-		gasket_log_error(
-			gasket_dev,
-			"Cannot remap BAR %d memory region %p",
+		dev_err(gasket_dev->dev,
+			"Cannot remap BAR %d memory region %p\n",
 			bar_num, &gasket_dev->pci_dev->resource[bar_num]);
 		ret = -ENOMEM;
 		goto fail;
@@ -852,8 +844,8 @@ static void gasket_unmap_pci_bar(struct gasket_dev *dev, int bar_num)
 
 	base = pci_resource_start(dev->pci_dev, bar_num);
 	if (!base) {
-		gasket_log_error(
-			dev, "cannot get PCI BAR%u base address", bar_num);
+		dev_err(dev->dev, "cannot get PCI BAR%u base address\n",
+			bar_num);
 		return;
 	}
 
@@ -877,9 +869,8 @@ static int gasket_add_cdev(
 	dev_info->cdev.owner = owner;
 	ret = cdev_add(&dev_info->cdev, dev_info->devt, 1);
 	if (ret) {
-		gasket_log_error(
-			dev_info->gasket_dev_ptr,
-			"cannot add char device [ret=%d]", ret);
+		dev_err(dev_info->gasket_dev_ptr->dev,
+			"cannot add char device [ret=%d]\n", ret);
 		return ret;
 	}
 	dev_info->cdev_added = 1;
@@ -911,16 +902,15 @@ static int gasket_enable_dev(
 		driver_desc->interrupt_bar_index,
 		driver_desc->wire_interrupt_offsets);
 	if (ret) {
-		gasket_log_error(gasket_dev,
-				 "Critical failure to allocate interrupts: %d",
-				 ret);
+		dev_err(gasket_dev->dev,
+			"Critical failure to allocate interrupts: %d\n", ret);
 		gasket_interrupt_cleanup(gasket_dev);
 		return ret;
 	}
 
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
-		gasket_log_debug(
-			gasket_dev, "Initializing page table %d.", tbl_idx);
+		dev_dbg(gasket_dev->dev, "Initializing page table %d.\n",
+			tbl_idx);
 		ret = gasket_page_table_init(
 			&gasket_dev->page_table[tbl_idx],
 			&gasket_dev->bar_data[
@@ -928,9 +918,8 @@ static int gasket_enable_dev(
 			&driver_desc->page_table_configs[tbl_idx],
 			gasket_dev->dev, gasket_dev->pci_dev, true);
 		if (ret) {
-			gasket_log_error(
-				gasket_dev,
-				"Couldn't init page table %d: %d",
+			dev_err(gasket_dev->dev,
+				"Couldn't init page table %d: %d\n",
 				tbl_idx, ret);
 			return ret;
 		}
@@ -948,23 +937,23 @@ static int gasket_enable_dev(
 	ret = check_and_invoke_callback(
 		gasket_dev, driver_desc->hardware_revision_cb);
 	if (ret < 0) {
-		gasket_log_error(
-			gasket_dev, "Error getting hardware revision: %d", ret);
+		dev_err(gasket_dev->dev,
+			"Error getting hardware revision: %d\n", ret);
 		return ret;
 	}
 	gasket_dev->hardware_revision = ret;
 
 	ret = check_and_invoke_callback(gasket_dev, driver_desc->enable_dev_cb);
 	if (ret) {
-		gasket_log_error(
-			gasket_dev, "Error in enable device cb: %d", ret);
+		dev_err(gasket_dev->dev, "Error in enable device cb: %d\n",
+			ret);
 		return ret;
 	}
 
 	/* device_status_cb returns a device status, not an error code. */
 	gasket_dev->status = gasket_get_hw_status(gasket_dev);
 	if (gasket_dev->status == GASKET_STATUS_DEAD)
-		gasket_log_error(gasket_dev, "Device reported as unhealthy.");
+		dev_err(gasket_dev->dev, "Device reported as unhealthy.\n");
 
 	ret = gasket_add_cdev(
 		&gasket_dev->dev_info, &gasket_file_ops, driver_desc->module);
@@ -1084,31 +1073,29 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	filp->private_data = gasket_dev;
 	inode->i_size = 0;
 
-	gasket_log_debug(
-		gasket_dev,
+	dev_dbg(gasket_dev->dev,
 		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
-		"fmode_write: %d is_root: %u)",
+		"fmode_write: %d is_root: %u)\n",
 		current->tgid, task_name, filp->f_mode,
 		(filp->f_mode & FMODE_WRITE), is_root);
 
 	/* Always allow non-writing accesses. */
 	if (!(filp->f_mode & FMODE_WRITE)) {
-		gasket_log_debug(gasket_dev, "Allowing read-only opening.");
+		dev_dbg(gasket_dev->dev, "Allowing read-only opening.\n");
 		return 0;
 	}
 
 	mutex_lock(&gasket_dev->mutex);
 
-	gasket_log_debug(
-		gasket_dev, "Current owner open count (owning tgid %u): %d.",
+	dev_dbg(gasket_dev->dev,
+		"Current owner open count (owning tgid %u): %d.\n",
 		ownership->owner, ownership->write_open_count);
 
 	/* Opening a node owned by another TGID is an error (unless root) */
 	if (ownership->is_owned && ownership->owner != current->tgid &&
 	    !is_root) {
-		gasket_log_error(
-			gasket_dev,
-			"Process %u is opening a node held by %u.",
+		dev_err(gasket_dev->dev,
+			"Process %u is opening a node held by %u.\n",
 			current->tgid, ownership->owner);
 		mutex_unlock(&gasket_dev->mutex);
 		return -EPERM;
@@ -1119,21 +1106,21 @@ static int gasket_open(struct inode *inode, struct file *filp)
 		ret = gasket_check_and_invoke_callback_nolock(
 			gasket_dev, driver_desc->device_open_cb);
 		if (ret) {
-			gasket_log_error(
-				gasket_dev, "Error in device open cb: %d", ret);
+			dev_err(gasket_dev->dev,
+				"Error in device open cb: %d\n", ret);
 			mutex_unlock(&gasket_dev->mutex);
 			return ret;
 		}
 		ownership->is_owned = 1;
 		ownership->owner = current->tgid;
-		gasket_log_debug(gasket_dev, "Device owner is now tgid %u",
-				 ownership->owner);
+		dev_dbg(gasket_dev->dev, "Device owner is now tgid %u\n",
+			ownership->owner);
 	}
 
 	ownership->write_open_count++;
 
-	gasket_log_debug(gasket_dev, "New open count (owning tgid %u): %d",
-			 ownership->owner, ownership->write_open_count);
+	dev_dbg(gasket_dev->dev, "New open count (owning tgid %u): %d\n",
+		ownership->owner, ownership->write_open_count);
 
 	mutex_unlock(&gasket_dev->mutex);
 	return 0;
@@ -1167,19 +1154,18 @@ static int gasket_release(struct inode *inode, struct file *file)
 	get_task_comm(task_name, current);
 	mutex_lock(&gasket_dev->mutex);
 
-	gasket_log_debug(
-		gasket_dev,
+	dev_dbg(gasket_dev->dev,
 		"Releasing device node. Call origin: tgid %u (%s) "
-		"(f_mode: 0%03o, fmode_write: %d, is_root: %u)",
+		"(f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
 		current->tgid, task_name, file->f_mode,
 		(file->f_mode & FMODE_WRITE), capable(CAP_SYS_ADMIN));
-	gasket_log_debug(gasket_dev, "Current open count (owning tgid %u): %d",
-			 ownership->owner, ownership->write_open_count);
+	dev_dbg(gasket_dev->dev, "Current open count (owning tgid %u): %d\n",
+		ownership->owner, ownership->write_open_count);
 
 	if (file->f_mode & FMODE_WRITE) {
 		ownership->write_open_count--;
 		if (ownership->write_open_count == 0) {
-			gasket_log_debug(gasket_dev, "Device is now free");
+			dev_dbg(gasket_dev->dev, "Device is now free\n");
 			ownership->is_owned = 0;
 			ownership->owner = 0;
 
@@ -1200,8 +1186,7 @@ static int gasket_release(struct inode *inode, struct file *file)
 		}
 	}
 
-	gasket_log_debug(
-		gasket_dev, "New open count (owning tgid %u): %d",
+	dev_dbg(gasket_dev->dev, "New open count (owning tgid %u): %d\n",
 		ownership->owner, ownership->write_open_count);
 	mutex_unlock(&gasket_dev->mutex);
 	return 0;
@@ -1227,7 +1212,7 @@ static bool gasket_mmap_has_permissions(
 
 	/* Never allow non-sysadmins to access to a dead device. */
 	if (gasket_dev->status != GASKET_STATUS_ALIVE) {
-		gasket_log_debug(gasket_dev, "Device is dead.");
+		dev_dbg(gasket_dev->dev, "Device is dead.\n");
 		return false;
 	}
 
@@ -1235,10 +1220,9 @@ static bool gasket_mmap_has_permissions(
 	requested_permissions =
 		(vma->vm_flags & (VM_WRITE | VM_READ | VM_EXEC));
 	if (requested_permissions & ~(bar_permissions)) {
-		gasket_log_debug(
-			gasket_dev,
+		dev_dbg(gasket_dev->dev,
 			"Attempting to map a region with requested permissions "
-			"0x%x, but region has permissions 0x%x.",
+			"0x%x, but region has permissions 0x%x.\n",
 			requested_permissions, bar_permissions);
 		return false;
 	}
@@ -1246,10 +1230,9 @@ static bool gasket_mmap_has_permissions(
 	/* Do not allow a non-owner to write. */
 	if ((vma->vm_flags & VM_WRITE) &&
 	    !gasket_owned_by_current_tgid(&gasket_dev->dev_info)) {
-		gasket_log_debug(
-			gasket_dev,
+		dev_dbg(gasket_dev->dev,
 			"Attempting to mmap a region for write without owning "
-			"device.");
+			"device.\n");
 		return false;
 	}
 
@@ -1462,8 +1445,8 @@ static enum do_map_region_status do_map_region(
 			(phys_base + mapped_bytes) >> PAGE_SHIFT,
 			chunk_size, vma->vm_page_prot);
 		if (ret) {
-			gasket_log_error(
-				gasket_dev, "Error remapping PFN range.");
+			dev_err(gasket_dev->dev,
+				"Error remapping PFN range.\n");
 			goto fail;
 		}
 		mapped_bytes += chunk_size;
@@ -1475,9 +1458,8 @@ static enum do_map_region_status do_map_region(
 	/* Unmap the partial chunk we mapped. */
 	mappable_region->length_bytes = mapped_bytes;
 	if (gasket_mm_unmap_region(gasket_dev, vma, mappable_region))
-		gasket_log_error(
-			gasket_dev,
-			"Error unmapping partial region 0x%lx (0x%lx bytes)",
+		dev_err(gasket_dev->dev,
+			"Error unmapping partial region 0x%lx (0x%lx bytes)\n",
 			(ulong)virt_offset,
 			(ulong)mapped_bytes);
 
@@ -1502,9 +1484,8 @@ static int gasket_mm_vma_bar_offset(
 		driver_desc->legacy_mmap_address_offset;
 	bar_index = gasket_get_bar_index(gasket_dev, raw_offset);
 	if (bar_index < 0) {
-		gasket_log_error(
-			gasket_dev,
-			"Unable to find matching bar for address 0x%lx",
+		dev_err(gasket_dev->dev,
+			"Unable to find matching bar for address 0x%lx\n",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
 		return bar_index;
@@ -1537,7 +1518,7 @@ static int gasket_mmap_coherent(
 
 	permissions = driver_desc->coherent_buffer_description.permissions;
 	if (!gasket_mmap_has_permissions(gasket_dev, vma, permissions)) {
-		gasket_log_error(gasket_dev, "Permission checking failed.");
+		dev_err(gasket_dev->dev, "Permission checking failed.\n");
 		trace_gasket_mmap_exit(-EPERM);
 		return -EPERM;
 	}
@@ -1549,8 +1530,8 @@ static int gasket_mmap_coherent(
 		(gasket_dev->coherent_buffer.phys_base) >> PAGE_SHIFT,
 		requested_length, vma->vm_page_prot);
 	if (ret) {
-		gasket_log_error(
-			gasket_dev, "Error remapping PFN range err=%d.", ret);
+		dev_err(gasket_dev->dev, "Error remapping PFN range err=%d.\n",
+			ret);
 		trace_gasket_mmap_exit(ret);
 		return ret;
 	}
@@ -1592,8 +1573,8 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
 	if (vma->vm_start & ~PAGE_MASK) {
-		gasket_log_error(
-			gasket_dev, "Base address not page-aligned: 0x%lx\n",
+		dev_err(gasket_dev->dev,
+			"Base address not page-aligned: 0x%lx\n",
 			vma->vm_start);
 		trace_gasket_mmap_exit(-EINVAL);
 		return -EINVAL;
@@ -1613,18 +1594,16 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	bar_index = gasket_get_bar_index(gasket_dev, raw_offset);
 	is_coherent_region = gasket_is_coherent_region(driver_desc, raw_offset);
 	if (bar_index < 0 && !is_coherent_region) {
-		gasket_log_error(
-			gasket_dev,
-			"Unable to find matching bar for address 0x%lx",
+		dev_err(gasket_dev->dev,
+			"Unable to find matching bar for address 0x%lx\n",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
 		return bar_index;
 	}
 	if (bar_index > 0 && is_coherent_region) {
-		gasket_log_error(
-			gasket_dev,
+		dev_err(gasket_dev->dev,
 			"double matching bar and coherent buffers for address "
-			"0x%lx",
+			"0x%lx\n",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
 		return -EINVAL;
@@ -1644,7 +1623,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	bar_desc = &driver_desc->bar_descriptions[bar_index];
 	permissions = bar_desc->permissions;
 	if (!gasket_mmap_has_permissions(gasket_dev, vma, permissions)) {
-		gasket_log_error(gasket_dev, "Permission checking failed.");
+		dev_err(gasket_dev->dev, "Permission checking failed.\n");
 		trace_gasket_mmap_exit(-EPERM);
 		return -EPERM;
 	}
@@ -1657,8 +1636,8 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	} else {
 		if (!gasket_mmap_has_permissions(gasket_dev, vma,
 						 bar_desc->permissions)) {
-			gasket_log_error(
-				gasket_dev, "Permission checking failed.");
+			dev_err(gasket_dev->dev,
+				"Permission checking failed.\n");
 			trace_gasket_mmap_exit(-EPERM);
 			return -EPERM;
 		}
@@ -1674,7 +1653,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 
 	if (!map_regions || num_map_regions == 0) {
-		gasket_log_error(gasket_dev, "No mappable regions returned!");
+		dev_err(gasket_dev->dev, "No mappable regions returned!\n");
 		return -EINVAL;
 	}
 
@@ -1697,9 +1676,8 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	/* If we could not map any memory, the request was invalid. */
 	if (!has_mapped_anything) {
-		gasket_log_error(
-			gasket_dev,
-			"Map request did not contain a valid region.");
+		dev_err(gasket_dev->dev,
+			"Map request did not contain a valid region.\n");
 		trace_gasket_mmap_exit(-EINVAL);
 		return -EINVAL;
 	}
@@ -1713,8 +1691,8 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	for (i = 0; i < num_map_regions; i++)
 		if (gasket_mm_unmap_region(gasket_dev, vma,
 					   &bar_desc->mappable_regions[i]))
-			gasket_log_error(
-				gasket_dev, "Error unmapping range %d.", i);
+			dev_err(gasket_dev->dev, "Error unmapping range %d.\n",
+				i);
 	kfree(map_regions);
 
 	return ret;
@@ -1738,16 +1716,15 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 	status = gasket_check_and_invoke_callback_nolock(
 		gasket_dev, driver_desc->device_status_cb);
 	if (status != GASKET_STATUS_ALIVE) {
-		gasket_log_debug(gasket_dev, "Hardware reported status %d.",
-				 status);
+		dev_dbg(gasket_dev->dev, "Hardware reported status %d.\n",
+			status);
 		return status;
 	}
 
 	status = gasket_interrupt_system_status(gasket_dev);
 	if (status != GASKET_STATUS_ALIVE) {
-		gasket_log_debug(gasket_dev,
-				 "Interrupt system reported status %d.",
-				 status);
+		dev_dbg(gasket_dev->dev,
+			"Interrupt system reported status %d.\n", status);
 		return status;
 	}
 
@@ -1755,8 +1732,8 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 		status = gasket_page_table_system_status(
 			gasket_dev->page_table[i]);
 		if (status != GASKET_STATUS_ALIVE) {
-			gasket_log_debug(
-				gasket_dev, "Page table %d reported status %d.",
+			dev_dbg(gasket_dev->dev,
+				"Page table %d reported status %d.\n",
 				i, status);
 			return status;
 		}
@@ -1786,9 +1763,8 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 	gasket_dev = (struct gasket_dev *)filp->private_data;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	if (!driver_desc) {
-		gasket_log_debug(
-			gasket_dev,
-			"Unable to find device descriptor for file %s",
+		dev_dbg(gasket_dev->dev,
+			"Unable to find device descriptor for file %s\n",
 			d_path(&filp->f_path, path, 256));
 		return -ENODEV;
 	}
@@ -1802,8 +1778,7 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 		if (driver_desc->ioctl_handler_cb)
 			return driver_desc->ioctl_handler_cb(filp, cmd, argp);
 
-		gasket_log_debug(
-			gasket_dev, "Received unknown ioctl 0x%x", cmd);
+		dev_dbg(gasket_dev->dev, "Received unknown ioctl 0x%x\n", cmd);
 		return -EINVAL;
 	}
 
@@ -1834,8 +1809,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
 	if (ret) {
-		gasket_log_debug(
-			gasket_dev, "Device reset cb returned %d.", ret);
+		dev_dbg(gasket_dev->dev, "Device reset cb returned %d.\n",
+			ret);
 		return ret;
 	}
 
@@ -1845,15 +1820,15 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 
 	ret = gasket_interrupt_reinit(gasket_dev);
 	if (ret) {
-		gasket_log_debug(
-			gasket_dev, "Unable to reinit interrupts: %d.", ret);
+		dev_dbg(gasket_dev->dev, "Unable to reinit interrupts: %d.\n",
+			ret);
 		return ret;
 	}
 
 	/* Get current device health. */
 	gasket_dev->status = gasket_get_hw_status(gasket_dev);
 	if (gasket_dev->status == GASKET_STATUS_DEAD) {
-		gasket_log_debug(gasket_dev, "Device reported as dead.");
+		dev_dbg(gasket_dev->dev, "Device reported as dead.\n");
 		return -EINVAL;
 	}
 
@@ -1909,15 +1884,13 @@ static ssize_t gasket_sysfs_data_show(
 
 	gasket_dev = gasket_sysfs_get_device_data(device);
 	if (!gasket_dev) {
-		gasket_nodev_error(
-			"No sysfs mapping found for device 0x%p", device);
+		dev_err(device, "No sysfs mapping found for device\n");
 		return 0;
 	}
 
 	gasket_attr = gasket_sysfs_get_attr(device, attr);
 	if (!gasket_attr) {
-		gasket_nodev_error(
-			"No sysfs attr found for device 0x%p", device);
+		dev_err(device, "No sysfs attr found for device\n");
 		gasket_sysfs_put_device_data(device, gasket_dev);
 		return 0;
 	}
@@ -2005,8 +1978,8 @@ static ssize_t gasket_sysfs_data_show(
 		}
 		break;
 	default:
-		gasket_log_debug(
-			gasket_dev, "Unknown attribute: %s", attr->attr.name);
+		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
+			attr->attr.name);
 		ret = 0;
 		break;
 	}
@@ -2059,8 +2032,8 @@ int gasket_wait_with_reschedule(
 		msleep(delay_ms);
 		retries++;
 	}
-	gasket_log_debug(gasket_dev, "%s timeout: reg %llx timeout (%llu ms)",
-			 __func__, offset, max_retries * delay_ms);
+	dev_dbg(gasket_dev->dev, "%s timeout: reg %llx timeout (%llu ms)\n",
+		__func__, offset, max_retries * delay_ms);
 	return -ETIMEDOUT;
 }
 EXPORT_SYMBOL(gasket_wait_with_reschedule);
-- 
2.18.0.345.g5c9ce644c3-goog


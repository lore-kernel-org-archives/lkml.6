Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41710C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E9520894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEjs8ot4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E9520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeGaWHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeGaWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so6640564pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2y0bSx0f37hYhO4cotqsdxSMg69uiJBLmoSP7gqbzE=;
        b=kEjs8ot4YNXGBTEFtwLZSCGrMjfW2VpyGwa4QWFV7yNYUdegKqgNUs45C/aPY5m6cB
         7NXr2/SHfWlM4X9WwdYuLy2LJu8O5JvQ/NtdVFdWm9a4ePzJxGMKAjfFkOIttTuQv0Ns
         SwyQScWySgAs3tE3TfpGvp61WL7GYLNtv1aj+O1Uk7IRBGD8yHqCrmyFkDYn1rPoV55A
         8dleO/nzheTwi6C3oaSqrk5VuaniSM/YkljSVZx9VDofZN6EWsIO9y9DidN1xBoZ1N7H
         N1KFOXa8n+7BEEKKfOY9uTu7Ov9W/6sPqhyFHJ9kSd8QXxaNz/pwYDGw+Vrv3SYB0QkI
         eRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2y0bSx0f37hYhO4cotqsdxSMg69uiJBLmoSP7gqbzE=;
        b=qp10g1VxEpEEYL0ReNyTqFZnivoctp83Zk+i2SbaQBQkNZMMXaCmUvVN4z4LrovhtO
         04aiEEVoZVTyQA9gZniUL0G6ehLyjTwBtCZaMqwNuf+knEh18sdlfHtqYsD/rZRAQIcl
         dTCD9TmnLbZ2nNbK1ujR50RT8ISaVINkE6v4koZfeyh0YBH9q/VUaBTwMPS72dBegbz5
         cf1NLTpCV6g7AztRAibtjWZUwJ3g14iswZw3CJSnUoc9DvMFu6qedqszrtMEHAaZBUyf
         RUXqaQJf8pGEkjyLjnjqVR/x3h6Lt9j0FdElwG5S5id36OVrkoUBymqCa+l74iVeiIOK
         5k6g==
X-Gm-Message-State: AOUpUlGizYaiC/UGxLoBvsci/+UBXkx60RykZMIFi6RQ3TqqhaIrEkio
        ViqMMYPmhZ4n4KhPF9NH9pULd7mAc5c=
X-Google-Smtp-Source: AAOMgpffSVavs2yOCs1jXaVBNWZGqyvmI9YOyDcIdcMp8ghX4U4ffdFJkYYmnCTCRAqtT+PYj1vUgQ==
X-Received: by 2002:a62:5a01:: with SMTP id o1-v6mr23968095pfb.0.1533068711667;
        Tue, 31 Jul 2018 13:25:11 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:11 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/15] staging: gasket: core: remove static function forward declarations
Date:   Tue, 31 Jul 2018 13:24:34 -0700
Message-Id: <20180731202448.229487-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731202448.229487-1-toddpoynor@gmail.com>
References: <20180731202448.229487-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove forward declarations of static functions, move code to avoid
forward references, for kernel style.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 1900 +++++++++++++-------------
 1 file changed, 922 insertions(+), 978 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index c00774059f9e..b5a7254fbfb3 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -67,61 +67,6 @@ enum do_map_region_status {
 	DO_MAP_REGION_INVALID,
 };
 
-/* Function declarations; comments are with definitions. */
-static int __init gasket_init(void);
-static void __exit gasket_exit(void);
-
-static int gasket_pci_probe(
-	struct pci_dev *pci_dev, const struct pci_device_id *id);
-static void gasket_pci_remove(struct pci_dev *pci_dev);
-
-static int gasket_setup_pci(struct pci_dev *pci_dev, struct gasket_dev *dev);
-static void gasket_cleanup_pci(struct gasket_dev *dev);
-
-static int gasket_map_pci_bar(struct gasket_dev *dev, int bar_num);
-static void gasket_unmap_pci_bar(struct gasket_dev *dev, int bar_num);
-
-static int gasket_alloc_dev(
-	struct gasket_internal_desc *internal_desc, struct device *dev,
-	struct gasket_dev **pdev, const char *kobj_name);
-static void gasket_free_dev(struct gasket_dev *dev);
-
-static int gasket_find_dev_slot(
-	struct gasket_internal_desc *internal_desc, const char *kobj_name);
-
-static int gasket_add_cdev(
-	struct gasket_cdev_info *dev_info,
-	const struct file_operations *file_ops, struct module *owner);
-
-static int gasket_enable_dev(
-	struct gasket_internal_desc *internal_desc,
-	struct gasket_dev *gasket_dev);
-static void gasket_disable_dev(struct gasket_dev *gasket_dev);
-
-static struct gasket_internal_desc *lookup_internal_desc(
-	struct pci_dev *pci_dev);
-
-static ssize_t gasket_sysfs_data_show(
-	struct device *device, struct device_attribute *attr, char *buf);
-
-static int gasket_mmap(struct file *filp, struct vm_area_struct *vma);
-static int gasket_open(struct inode *inode, struct file *file);
-static int gasket_release(struct inode *inode, struct file *file);
-static long gasket_ioctl(struct file *filp, uint cmd, ulong arg);
-
-static int gasket_mm_vma_bar_offset(
-	const struct gasket_dev *gasket_dev, const struct vm_area_struct *vma,
-	ulong *bar_offset);
-static bool gasket_mm_get_mapping_addrs(
-	const struct gasket_mappable_region *region, ulong bar_offset,
-	ulong requested_length, struct gasket_mappable_region *mappable_region,
-	ulong *virt_offset);
-static enum do_map_region_status do_map_region(
-	const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
-	struct gasket_mappable_region *map_region);
-
-static int gasket_get_hw_status(struct gasket_dev *gasket_dev);
-
 /* Global data definitions. */
 /* Mutex - only for framework-wide data. Other data should be protected by
  * finer-grained locks.
@@ -157,48 +102,6 @@ enum gasket_sysfs_attribute_type {
 	ATTR_USER_MEM_RANGES
 };
 
-/* File operations for all Gasket devices. */
-static const struct file_operations gasket_file_ops = {
-	.owner = THIS_MODULE,
-	.llseek = no_llseek,
-	.mmap = gasket_mmap,
-	.open = gasket_open,
-	.release = gasket_release,
-	.unlocked_ioctl = gasket_ioctl,
-};
-
-/* These attributes apply to all Gasket driver instances. */
-static const struct gasket_sysfs_attribute gasket_sysfs_generic_attrs[] = {
-	GASKET_SYSFS_RO(bar_offsets, gasket_sysfs_data_show, ATTR_BAR_OFFSETS),
-	GASKET_SYSFS_RO(bar_sizes, gasket_sysfs_data_show, ATTR_BAR_SIZES),
-	GASKET_SYSFS_RO(driver_version, gasket_sysfs_data_show,
-			ATTR_DRIVER_VERSION),
-	GASKET_SYSFS_RO(framework_version, gasket_sysfs_data_show,
-			ATTR_FRAMEWORK_VERSION),
-	GASKET_SYSFS_RO(device_type, gasket_sysfs_data_show, ATTR_DEVICE_TYPE),
-	GASKET_SYSFS_RO(revision, gasket_sysfs_data_show,
-			ATTR_HARDWARE_REVISION),
-	GASKET_SYSFS_RO(pci_address, gasket_sysfs_data_show, ATTR_PCI_ADDRESS),
-	GASKET_SYSFS_RO(status, gasket_sysfs_data_show, ATTR_STATUS),
-	GASKET_SYSFS_RO(is_device_owned, gasket_sysfs_data_show,
-			ATTR_IS_DEVICE_OWNED),
-	GASKET_SYSFS_RO(device_owner, gasket_sysfs_data_show,
-			ATTR_DEVICE_OWNER),
-	GASKET_SYSFS_RO(write_open_count, gasket_sysfs_data_show,
-			ATTR_WRITE_OPEN_COUNT),
-	GASKET_SYSFS_RO(reset_count, gasket_sysfs_data_show, ATTR_RESET_COUNT),
-	GASKET_SYSFS_RO(user_mem_ranges, gasket_sysfs_data_show,
-			ATTR_USER_MEM_RANGES),
-	GASKET_END_OF_ATTR_ARRAY
-};
-
-MODULE_DESCRIPTION("Google Gasket driver framework");
-MODULE_VERSION(GASKET_FRAMEWORK_VERSION);
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Rob Springer <rspringer@google.com>");
-module_init(gasket_init);
-module_exit(gasket_exit);
-
 /* Perform a standard Gasket callback. */
 static inline int check_and_invoke_callback(
 	struct gasket_dev *gasket_dev, int (*cb_function)(struct gasket_dev *))
@@ -239,165 +142,43 @@ static int gasket_owned_by_current_tgid(struct gasket_cdev_info *info)
 		(info->ownership.owner == current->tgid));
 }
 
-static int __init gasket_init(void)
+/*
+ * Find the next free gasket_internal_dev slot.
+ *
+ * Returns the located slot number on success or a negative number on failure.
+ */
+static int gasket_find_dev_slot(
+	struct gasket_internal_desc *internal_desc, const char *kobj_name)
 {
 	int i;
 
-	pr_info("Performing one-time init of the Gasket framework.\n");
-	/* Check for duplicates and find a free slot. */
-	mutex_lock(&g_mutex);
-	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
-		g_descs[i].driver_desc = NULL;
-		mutex_init(&g_descs[i].mutex);
-	}
-
-	gasket_sysfs_init();
-
-	mutex_unlock(&g_mutex);
-	return 0;
-}
-
-static void __exit gasket_exit(void)
-{
-	/* No deinit/dealloc needed at present. */
-	pr_info("Removing Gasket framework module.\n");
-}
-
-/* See gasket_core.h for description. */
-int gasket_register_device(const struct gasket_driver_desc *driver_desc)
-{
-	int i, ret;
-	int desc_idx = -1;
-	struct gasket_internal_desc *internal;
-
-	pr_info("Initializing Gasket framework device\n");
-	/* Check for duplicates and find a free slot. */
-	mutex_lock(&g_mutex);
+	mutex_lock(&internal_desc->mutex);
 
-	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
-		if (g_descs[i].driver_desc == driver_desc) {
-			pr_err("%s driver already loaded/registered\n",
-			       driver_desc->name);
-			mutex_unlock(&g_mutex);
+	/* Search for a previous instance of this device. */
+	for (i = 0; i < GASKET_DEV_MAX; i++) {
+		if (internal_desc->devs[i] &&
+		    strcmp(internal_desc->devs[i]->kobj_name, kobj_name) == 0) {
+			pr_err("Duplicate device %s\n", kobj_name);
+			mutex_unlock(&internal_desc->mutex);
 			return -EBUSY;
 		}
 	}
 
-	/* This and the above loop could be combined, but this reads easier. */
-	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
-		if (!g_descs[i].driver_desc) {
-			g_descs[i].driver_desc = driver_desc;
-			desc_idx = i;
+	/* Find a free device slot. */
+	for (i = 0; i < GASKET_DEV_MAX; i++) {
+		if (!internal_desc->devs[i])
 			break;
-		}
 	}
-	mutex_unlock(&g_mutex);
-
-	pr_info("Loaded %s driver, framework version %s\n",
-		driver_desc->name, GASKET_FRAMEWORK_VERSION);
 
-	if (desc_idx == -1) {
-		pr_err("Too many Gasket drivers loaded: %d\n",
-		       GASKET_FRAMEWORK_DESC_MAX);
+	if (i == GASKET_DEV_MAX) {
+		pr_err("Too many registered devices; max %d\n", GASKET_DEV_MAX);
+		mutex_unlock(&internal_desc->mutex);
 		return -EBUSY;
 	}
 
-	/* Internal structure setup. */
-	pr_debug("Performing initial internal structure setup.\n");
-	internal = &g_descs[desc_idx];
-	mutex_init(&internal->mutex);
-	memset(internal->devs, 0, sizeof(struct gasket_dev *) * GASKET_DEV_MAX);
-	memset(&internal->pci, 0, sizeof(internal->pci));
-	internal->pci.name = driver_desc->name;
-	internal->pci.id_table = driver_desc->pci_id_table;
-	internal->pci.probe = gasket_pci_probe;
-	internal->pci.remove = gasket_pci_remove;
-	internal->class =
-		class_create(driver_desc->module, driver_desc->name);
-
-	if (IS_ERR(internal->class)) {
-		pr_err("Cannot register %s class [ret=%ld]\n",
-		       driver_desc->name, PTR_ERR(internal->class));
-		ret = PTR_ERR(internal->class);
-		goto unregister_gasket_driver;
-	}
-
-	/*
-	 * Not using pci_register_driver() (without underscores), as it
-	 * depends on KBUILD_MODNAME, and this is a shared file.
-	 */
-	pr_debug("Registering PCI driver.\n");
-	ret = __pci_register_driver(
-		&internal->pci, driver_desc->module, driver_desc->name);
-	if (ret) {
-		pr_err("cannot register pci driver [ret=%d]\n", ret);
-		goto fail1;
-	}
-
-	pr_debug("Registering char driver.\n");
-	ret = register_chrdev_region(
-		MKDEV(driver_desc->major, driver_desc->minor), GASKET_DEV_MAX,
-		driver_desc->name);
-	if (ret) {
-		pr_err("cannot register char driver [ret=%d]\n", ret);
-		goto fail2;
-	}
-
-	pr_info("Driver registered successfully.\n");
-	return 0;
-
-fail2:
-	pci_unregister_driver(&internal->pci);
-
-fail1:
-	class_destroy(internal->class);
-
-unregister_gasket_driver:
-	mutex_lock(&g_mutex);
-	g_descs[desc_idx].driver_desc = NULL;
-	mutex_unlock(&g_mutex);
-	return ret;
-}
-EXPORT_SYMBOL(gasket_register_device);
-
-/* See gasket_core.h for description. */
-void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
-{
-	int i, desc_idx;
-	struct gasket_internal_desc *internal_desc = NULL;
-
-	mutex_lock(&g_mutex);
-	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
-		if (g_descs[i].driver_desc == driver_desc) {
-			internal_desc = &g_descs[i];
-			desc_idx = i;
-			break;
-		}
-	}
-	mutex_unlock(&g_mutex);
-
-	if (!internal_desc) {
-		pr_err("request to unregister unknown desc: %s, %d:%d\n",
-		       driver_desc->name, driver_desc->major,
-		       driver_desc->minor);
-		return;
-	}
-
-	unregister_chrdev_region(
-		MKDEV(driver_desc->major, driver_desc->minor), GASKET_DEV_MAX);
-
-	pci_unregister_driver(&internal_desc->pci);
-
-	class_destroy(internal_desc->class);
-
-	/* Finally, effectively "remove" the driver. */
-	mutex_lock(&g_mutex);
-	g_descs[desc_idx].driver_desc = NULL;
-	mutex_unlock(&g_mutex);
-
-	pr_info("removed %s driver\n", driver_desc->name);
+	mutex_unlock(&internal_desc->mutex);
+	return i;
 }
-EXPORT_SYMBOL(gasket_unregister_device);
 
 /*
  * Allocate and initialize a Gasket device structure, add the device to the
@@ -474,265 +255,21 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
 }
 
 /*
- * Find the next free gasket_internal_dev slot.
+ * Maps the specified bar into kernel space.
  *
- * Returns the located slot number on success or a negative number on failure.
+ * Returns 0 on success, a negative error code otherwise.
+ * A zero-sized BAR will not be mapped, but is not an error.
  */
-static int gasket_find_dev_slot(
-	struct gasket_internal_desc *internal_desc, const char *kobj_name)
+static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 {
-	int i;
+	struct gasket_internal_desc *internal_desc = gasket_dev->internal_desc;
+	const struct gasket_driver_desc *driver_desc =
+		internal_desc->driver_desc;
+	ulong desc_bytes = driver_desc->bar_descriptions[bar_num].size;
+	int ret;
 
-	mutex_lock(&internal_desc->mutex);
-
-	/* Search for a previous instance of this device. */
-	for (i = 0; i < GASKET_DEV_MAX; i++) {
-		if (internal_desc->devs[i] &&
-		    strcmp(internal_desc->devs[i]->kobj_name, kobj_name) == 0) {
-			pr_err("Duplicate device %s\n", kobj_name);
-			mutex_unlock(&internal_desc->mutex);
-			return -EBUSY;
-		}
-	}
-
-	/* Find a free device slot. */
-	for (i = 0; i < GASKET_DEV_MAX; i++) {
-		if (!internal_desc->devs[i])
-			break;
-	}
-
-	if (i == GASKET_DEV_MAX) {
-		pr_err("Too many registered devices; max %d\n", GASKET_DEV_MAX);
-		mutex_unlock(&internal_desc->mutex);
-		return -EBUSY;
-	}
-
-	mutex_unlock(&internal_desc->mutex);
-	return i;
-}
-
-/*
- * PCI subsystem probe function.
- *
- * Called when a Gasket device is found. Allocates device metadata, maps device
- * memory, and calls gasket_enable_dev to prepare the device for active use.
- *
- * Returns 0 if successful and a negative value otherwise.
- */
-static int gasket_pci_probe(
-	struct pci_dev *pci_dev, const struct pci_device_id *id)
-{
-	int ret;
-	const char *kobj_name = dev_name(&pci_dev->dev);
-	struct gasket_internal_desc *internal_desc;
-	struct gasket_dev *gasket_dev;
-	const struct gasket_driver_desc *driver_desc;
-	struct device *parent;
-
-	pr_info("Add Gasket device %s\n", kobj_name);
-
-	mutex_lock(&g_mutex);
-	internal_desc = lookup_internal_desc(pci_dev);
-	mutex_unlock(&g_mutex);
-	if (!internal_desc) {
-		pr_err("PCI probe called for unknown driver type\n");
-		return -ENODEV;
-	}
-
-	driver_desc = internal_desc->driver_desc;
-
-	parent = &pci_dev->dev;
-	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev, kobj_name);
-	if (ret)
-		return ret;
-	gasket_dev->pci_dev = pci_dev_get(pci_dev);
-	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
-		pr_err("Cannot create %s device %s [ret = %ld]\n",
-		       driver_desc->name, gasket_dev->dev_info.name,
-		       PTR_ERR(gasket_dev->dev_info.device));
-		ret = -ENODEV;
-		goto fail1;
-	}
-
-	ret = gasket_setup_pci(pci_dev, gasket_dev);
-	if (ret)
-		goto fail2;
-
-	ret = check_and_invoke_callback(gasket_dev, driver_desc->add_dev_cb);
-	if (ret) {
-		dev_err(gasket_dev->dev, "Error in add device cb: %d\n", ret);
-		goto fail2;
-	}
-
-	ret = gasket_sysfs_create_mapping(
-		gasket_dev->dev_info.device, gasket_dev);
-	if (ret)
-		goto fail3;
-
-	/*
-	 * Once we've created the mapping structures successfully, attempt to
-	 * create a symlink to the pci directory of this object.
-	 */
-	ret = sysfs_create_link(&gasket_dev->dev_info.device->kobj,
-				&pci_dev->dev.kobj, dev_name(&pci_dev->dev));
-	if (ret) {
-		dev_err(gasket_dev->dev,
-			"Cannot create sysfs pci link: %d\n", ret);
-		goto fail3;
-	}
-	ret = gasket_sysfs_create_entries(
-		gasket_dev->dev_info.device, gasket_sysfs_generic_attrs);
-	if (ret)
-		goto fail4;
-
-	ret = check_and_invoke_callback(
-		gasket_dev, driver_desc->sysfs_setup_cb);
-	if (ret) {
-		dev_err(gasket_dev->dev, "Error in sysfs setup cb: %d\n", ret);
-		goto fail5;
-	}
-
-	ret = gasket_enable_dev(internal_desc, gasket_dev);
-	if (ret) {
-		pr_err("cannot setup %s device\n", driver_desc->name);
-		gasket_disable_dev(gasket_dev);
-		goto fail5;
-	}
-
-	return 0;
-
-fail5:
-	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
-fail4:
-fail3:
-	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
-fail2:
-	gasket_cleanup_pci(gasket_dev);
-	check_and_invoke_callback(gasket_dev, driver_desc->remove_dev_cb);
-	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
-fail1:
-	gasket_free_dev(gasket_dev);
-	return ret;
-}
-
-/*
- * PCI subsystem remove function.
- *
- * Called to remove a Gasket device. Finds the device in the device list and
- * cleans up metadata.
- */
-static void gasket_pci_remove(struct pci_dev *pci_dev)
-{
-	int i;
-	struct gasket_internal_desc *internal_desc;
-	struct gasket_dev *gasket_dev = NULL;
-	const struct gasket_driver_desc *driver_desc;
-	/* Find the device desc. */
-	mutex_lock(&g_mutex);
-	internal_desc = lookup_internal_desc(pci_dev);
-	if (!internal_desc) {
-		mutex_unlock(&g_mutex);
-		return;
-	}
-	mutex_unlock(&g_mutex);
-
-	driver_desc = internal_desc->driver_desc;
-
-	/* Now find the specific device */
-	mutex_lock(&internal_desc->mutex);
-	for (i = 0; i < GASKET_DEV_MAX; i++) {
-		if (internal_desc->devs[i] &&
-		    internal_desc->devs[i]->pci_dev == pci_dev) {
-			gasket_dev = internal_desc->devs[i];
-			break;
-		}
-	}
-	mutex_unlock(&internal_desc->mutex);
-
-	if (!gasket_dev)
-		return;
-
-	pr_info("remove %s device %s\n", internal_desc->driver_desc->name,
-		gasket_dev->kobj_name);
-
-	gasket_disable_dev(gasket_dev);
-	gasket_cleanup_pci(gasket_dev);
-
-	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
-	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
-
-	check_and_invoke_callback(gasket_dev, driver_desc->remove_dev_cb);
-
-	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
-	gasket_free_dev(gasket_dev);
-}
-
-/*
- * Setup PCI & set up memory mapping for the specified device.
- *
- * Enables the PCI device, reads the BAR registers and sets up pointers to the
- * device's memory mapped IO space.
- *
- * Returns 0 on success and a negative value otherwise.
- */
-static int gasket_setup_pci(
-	struct pci_dev *pci_dev, struct gasket_dev *gasket_dev)
-{
-	int i, mapped_bars, ret;
-
-	ret = pci_enable_device(pci_dev);
-	if (ret) {
-		dev_err(gasket_dev->dev, "cannot enable PCI device\n");
-		return ret;
-	}
-
-	pci_set_master(pci_dev);
-
-	for (i = 0; i < GASKET_NUM_BARS; i++) {
-		ret = gasket_map_pci_bar(gasket_dev, i);
-		if (ret) {
-			mapped_bars = i;
-			goto fail;
-		}
-	}
-
-	return 0;
-
-fail:
-	for (i = 0; i < mapped_bars; i++)
-		gasket_unmap_pci_bar(gasket_dev, i);
-
-	pci_disable_device(pci_dev);
-	return -ENOMEM;
-}
-
-/* Unmaps memory and cleans up PCI for the specified device. */
-static void gasket_cleanup_pci(struct gasket_dev *gasket_dev)
-{
-	int i;
-
-	for (i = 0; i < GASKET_NUM_BARS; i++)
-		gasket_unmap_pci_bar(gasket_dev, i);
-
-	pci_disable_device(gasket_dev->pci_dev);
-}
-
-/*
- * Maps the specified bar into kernel space.
- *
- * Returns 0 on success, a negative error code otherwise.
- * A zero-sized BAR will not be mapped, but is not an error.
- */
-static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
-{
-	struct gasket_internal_desc *internal_desc = gasket_dev->internal_desc;
-	const struct gasket_driver_desc *driver_desc =
-		internal_desc->driver_desc;
-	ulong desc_bytes = driver_desc->bar_descriptions[bar_num].size;
-	int ret;
-
-	if (desc_bytes == 0)
-		return 0;
+	if (desc_bytes == 0)
+		return 0;
 
 	if (driver_desc->bar_descriptions[bar_num].type != PCI_BAR) {
 		/* not PCI: skip this entry */
@@ -826,320 +363,329 @@ static void gasket_unmap_pci_bar(struct gasket_dev *dev, int bar_num)
 	release_mem_region(base, bytes);
 }
 
-/* Add a char device and related info. */
-static int gasket_add_cdev(
-	struct gasket_cdev_info *dev_info,
-	const struct file_operations *file_ops, struct module *owner)
-{
-	int ret;
-
-	cdev_init(&dev_info->cdev, file_ops);
-	dev_info->cdev.owner = owner;
-	ret = cdev_add(&dev_info->cdev, dev_info->devt, 1);
-	if (ret) {
-		dev_err(dev_info->gasket_dev_ptr->dev,
-			"cannot add char device [ret=%d]\n", ret);
-		return ret;
-	}
-	dev_info->cdev_added = 1;
-
-	return 0;
-}
-
-/* Perform final init and marks the device as active. */
-static int gasket_enable_dev(
-	struct gasket_internal_desc *internal_desc,
-	struct gasket_dev *gasket_dev)
+/*
+ * Setup PCI & set up memory mapping for the specified device.
+ *
+ * Enables the PCI device, reads the BAR registers and sets up pointers to the
+ * device's memory mapped IO space.
+ *
+ * Returns 0 on success and a negative value otherwise.
+ */
+static int gasket_setup_pci(
+	struct pci_dev *pci_dev, struct gasket_dev *gasket_dev)
 {
-	int tbl_idx;
-	int ret;
-	const struct gasket_driver_desc *driver_desc =
-		internal_desc->driver_desc;
+	int i, mapped_bars, ret;
 
-	ret = gasket_interrupt_init(
-		gasket_dev, driver_desc->name,
-		driver_desc->interrupt_type, driver_desc->interrupts,
-		driver_desc->num_interrupts, driver_desc->interrupt_pack_width,
-		driver_desc->interrupt_bar_index,
-		driver_desc->wire_interrupt_offsets);
+	ret = pci_enable_device(pci_dev);
 	if (ret) {
-		dev_err(gasket_dev->dev,
-			"Critical failure to allocate interrupts: %d\n", ret);
-		gasket_interrupt_cleanup(gasket_dev);
+		dev_err(gasket_dev->dev, "cannot enable PCI device\n");
 		return ret;
 	}
 
-	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
-		dev_dbg(gasket_dev->dev, "Initializing page table %d.\n",
-			tbl_idx);
-		ret = gasket_page_table_init(
-			&gasket_dev->page_table[tbl_idx],
-			&gasket_dev->bar_data[
-				driver_desc->page_table_bar_index],
-			&driver_desc->page_table_configs[tbl_idx],
-			gasket_dev->dev, gasket_dev->pci_dev);
+	pci_set_master(pci_dev);
+
+	for (i = 0; i < GASKET_NUM_BARS; i++) {
+		ret = gasket_map_pci_bar(gasket_dev, i);
 		if (ret) {
-			dev_err(gasket_dev->dev,
-				"Couldn't init page table %d: %d\n",
-				tbl_idx, ret);
-			return ret;
+			mapped_bars = i;
+			goto fail;
 		}
-		/*
-		 * Make sure that the page table is clear and set to simple
-		 * addresses.
-		 */
-		gasket_page_table_reset(gasket_dev->page_table[tbl_idx]);
 	}
 
-	/*
-	 * hardware_revision_cb returns a positive integer (the rev) if
-	 * successful.)
-	 */
-	ret = check_and_invoke_callback(
-		gasket_dev, driver_desc->hardware_revision_cb);
-	if (ret < 0) {
-		dev_err(gasket_dev->dev,
-			"Error getting hardware revision: %d\n", ret);
-		return ret;
-	}
-	gasket_dev->hardware_revision = ret;
+	return 0;
 
-	ret = check_and_invoke_callback(gasket_dev, driver_desc->enable_dev_cb);
-	if (ret) {
-		dev_err(gasket_dev->dev, "Error in enable device cb: %d\n",
-			ret);
-		return ret;
-	}
+fail:
+	for (i = 0; i < mapped_bars; i++)
+		gasket_unmap_pci_bar(gasket_dev, i);
 
-	/* device_status_cb returns a device status, not an error code. */
-	gasket_dev->status = gasket_get_hw_status(gasket_dev);
-	if (gasket_dev->status == GASKET_STATUS_DEAD)
-		dev_err(gasket_dev->dev, "Device reported as unhealthy.\n");
+	pci_disable_device(pci_dev);
+	return -ENOMEM;
+}
 
-	ret = gasket_add_cdev(
-		&gasket_dev->dev_info, &gasket_file_ops, driver_desc->module);
-	if (ret)
-		return ret;
+/* Unmaps memory and cleans up PCI for the specified device. */
+static void gasket_cleanup_pci(struct gasket_dev *gasket_dev)
+{
+	int i;
 
-	return 0;
+	for (i = 0; i < GASKET_NUM_BARS; i++)
+		gasket_unmap_pci_bar(gasket_dev, i);
+
+	pci_disable_device(gasket_dev->pci_dev);
 }
 
-/* Disable device operations. */
-static void gasket_disable_dev(struct gasket_dev *gasket_dev)
+/* Determine the health of the Gasket device. */
+static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 {
+	int status;
+	int i;
 	const struct gasket_driver_desc *driver_desc =
 		gasket_dev->internal_desc->driver_desc;
-	int i;
-
-	/* Only delete the device if it has been successfully added. */
-	if (gasket_dev->dev_info.cdev_added)
-		cdev_del(&gasket_dev->dev_info.cdev);
 
-	gasket_dev->status = GASKET_STATUS_DEAD;
+	status = gasket_check_and_invoke_callback_nolock(
+		gasket_dev, driver_desc->device_status_cb);
+	if (status != GASKET_STATUS_ALIVE) {
+		dev_dbg(gasket_dev->dev, "Hardware reported status %d.\n",
+			status);
+		return status;
+	}
 
-	gasket_interrupt_cleanup(gasket_dev);
+	status = gasket_interrupt_system_status(gasket_dev);
+	if (status != GASKET_STATUS_ALIVE) {
+		dev_dbg(gasket_dev->dev,
+			"Interrupt system reported status %d.\n", status);
+		return status;
+	}
 
 	for (i = 0; i < driver_desc->num_page_tables; ++i) {
-		if (gasket_dev->page_table[i]) {
-			gasket_page_table_reset(gasket_dev->page_table[i]);
-			gasket_page_table_cleanup(gasket_dev->page_table[i]);
+		status = gasket_page_table_system_status(
+			gasket_dev->page_table[i]);
+		if (status != GASKET_STATUS_ALIVE) {
+			dev_dbg(gasket_dev->dev,
+				"Page table %d reported status %d.\n",
+				i, status);
+			return status;
 		}
 	}
 
-	check_and_invoke_callback(gasket_dev, driver_desc->disable_dev_cb);
+	return GASKET_STATUS_ALIVE;
 }
 
-/*
- * Registered descriptor lookup.
- *
- * Precondition: Called with g_mutex held (to avoid a race on return).
- * Returns NULL if no matching device was found.
- */
-static struct gasket_internal_desc *lookup_internal_desc(
-	struct pci_dev *pci_dev)
+static ssize_t gasket_write_mappable_regions(
+	char *buf, const struct gasket_driver_desc *driver_desc, int bar_index)
 {
 	int i;
+	ssize_t written;
+	ssize_t total_written = 0;
+	ulong min_addr, max_addr;
+	struct gasket_bar_desc bar_desc =
+		driver_desc->bar_descriptions[bar_index];
 
-	__must_hold(&g_mutex);
-	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
-		if (g_descs[i].driver_desc &&
-		    g_descs[i].driver_desc->pci_id_table &&
-		    pci_match_id(g_descs[i].driver_desc->pci_id_table, pci_dev))
-			return &g_descs[i];
+	if (bar_desc.permissions == GASKET_NOMAP)
+		return 0;
+	for (i = 0;
+	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
+	     i++) {
+		min_addr = bar_desc.mappable_regions[i].start -
+			   driver_desc->legacy_mmap_address_offset;
+		max_addr = bar_desc.mappable_regions[i].start -
+			   driver_desc->legacy_mmap_address_offset +
+			   bar_desc.mappable_regions[i].length_bytes;
+		written = scnprintf(buf, PAGE_SIZE - total_written,
+				    "0x%08lx-0x%08lx\n", min_addr, max_addr);
+		total_written += written;
+		buf += written;
 	}
-
-	return NULL;
+	return total_written;
 }
 
-/**
- * Lookup a name by number in a num_name table.
- * @num: Number to lookup.
- * @table: Array of num_name structures, the table for the lookup.
- *
- * Description: Searches for num in the table.  If found, the
- *		corresponding name is returned; otherwise NULL
- *		is returned.
- *
- *		The table must have a NULL name pointer at the end.
- */
-const char *gasket_num_name_lookup(
-	uint num, const struct gasket_num_name *table)
+static ssize_t gasket_sysfs_data_show(
+	struct device *device, struct device_attribute *attr, char *buf)
 {
-	uint i = 0;
+	int i, ret = 0;
+	ssize_t current_written = 0;
+	const struct gasket_driver_desc *driver_desc;
+	struct gasket_dev *gasket_dev;
+	struct gasket_sysfs_attribute *gasket_attr;
+	const struct gasket_bar_desc *bar_desc;
+	enum gasket_sysfs_attribute_type sysfs_type;
 
-	while (table[i].snn_name) {
-		if (num == table[i].snn_num)
-			break;
-		++i;
+	gasket_dev = gasket_sysfs_get_device_data(device);
+	if (!gasket_dev) {
+		dev_err(device, "No sysfs mapping found for device\n");
+		return 0;
 	}
 
-	return table[i].snn_name;
-}
-EXPORT_SYMBOL(gasket_num_name_lookup);
-
-/*
- * Open the char device file.
- *
- * If the open is for writing, and the device is not owned, this process becomes
- * the owner.  If the open is for writing and the device is already owned by
- * some other process, it is an error.  If this process is the owner, increment
- * the open count.
- *
- * Returns 0 if successful, a negative error number otherwise.
- */
-static int gasket_open(struct inode *inode, struct file *filp)
-{
-	int ret;
-	struct gasket_dev *gasket_dev;
-	const struct gasket_driver_desc *driver_desc;
-	struct gasket_ownership *ownership;
-	char task_name[TASK_COMM_LEN];
-	struct gasket_cdev_info *dev_info =
-	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
-	struct pid_namespace *pid_ns = task_active_pid_ns(current);
-	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
+	gasket_attr = gasket_sysfs_get_attr(device, attr);
+	if (!gasket_attr) {
+		dev_err(device, "No sysfs attr found for device\n");
+		gasket_sysfs_put_device_data(device, gasket_dev);
+		return 0;
+	}
 
-	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-	ownership = &dev_info->ownership;
-	get_task_comm(task_name, current);
-	filp->private_data = gasket_dev;
-	inode->i_size = 0;
-
-	dev_dbg(gasket_dev->dev,
-		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
-		"fmode_write: %d is_root: %u)\n",
-		current->tgid, task_name, filp->f_mode,
-		(filp->f_mode & FMODE_WRITE), is_root);
 
-	/* Always allow non-writing accesses. */
-	if (!(filp->f_mode & FMODE_WRITE)) {
-		dev_dbg(gasket_dev->dev, "Allowing read-only opening.\n");
-		return 0;
+	sysfs_type =
+		(enum gasket_sysfs_attribute_type)gasket_attr->data.attr_type;
+	switch (sysfs_type) {
+	case ATTR_BAR_OFFSETS:
+		for (i = 0; i < GASKET_NUM_BARS; i++) {
+			bar_desc = &driver_desc->bar_descriptions[i];
+			if (bar_desc->size == 0)
+				continue;
+			current_written =
+				snprintf(buf, PAGE_SIZE - ret, "%d: 0x%lx\n", i,
+					 (ulong)bar_desc->base);
+			buf += current_written;
+			ret += current_written;
+		}
+		break;
+	case ATTR_BAR_SIZES:
+		for (i = 0; i < GASKET_NUM_BARS; i++) {
+			bar_desc = &driver_desc->bar_descriptions[i];
+			if (bar_desc->size == 0)
+				continue;
+			current_written =
+				snprintf(buf, PAGE_SIZE - ret, "%d: 0x%lx\n", i,
+					 (ulong)bar_desc->size);
+			buf += current_written;
+			ret += current_written;
+		}
+		break;
+	case ATTR_DRIVER_VERSION:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%s\n",
+			gasket_dev->internal_desc->driver_desc->driver_version);
+		break;
+	case ATTR_FRAMEWORK_VERSION:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%s\n", GASKET_FRAMEWORK_VERSION);
+		break;
+	case ATTR_DEVICE_TYPE:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%s\n",
+			gasket_dev->internal_desc->driver_desc->name);
+		break;
+	case ATTR_HARDWARE_REVISION:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%d\n", gasket_dev->hardware_revision);
+		break;
+	case ATTR_PCI_ADDRESS:
+		ret = snprintf(buf, PAGE_SIZE, "%s\n", gasket_dev->kobj_name);
+		break;
+	case ATTR_STATUS:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%s\n",
+			gasket_num_name_lookup(
+				gasket_dev->status, gasket_status_name_table));
+		break;
+	case ATTR_IS_DEVICE_OWNED:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%d\n",
+			gasket_dev->dev_info.ownership.is_owned);
+		break;
+	case ATTR_DEVICE_OWNER:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%d\n",
+			gasket_dev->dev_info.ownership.owner);
+		break;
+	case ATTR_WRITE_OPEN_COUNT:
+		ret = snprintf(
+			buf, PAGE_SIZE, "%d\n",
+			gasket_dev->dev_info.ownership.write_open_count);
+		break;
+	case ATTR_RESET_COUNT:
+		ret = snprintf(buf, PAGE_SIZE, "%d\n", gasket_dev->reset_count);
+		break;
+	case ATTR_USER_MEM_RANGES:
+		for (i = 0; i < GASKET_NUM_BARS; ++i) {
+			current_written = gasket_write_mappable_regions(
+				buf, driver_desc, i);
+			buf += current_written;
+			ret += current_written;
+		}
+		break;
+	default:
+		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
+			attr->attr.name);
+		ret = 0;
+		break;
 	}
 
-	mutex_lock(&gasket_dev->mutex);
+	gasket_sysfs_put_attr(device, gasket_attr);
+	gasket_sysfs_put_device_data(device, gasket_dev);
+	return ret;
+}
 
-	dev_dbg(gasket_dev->dev,
-		"Current owner open count (owning tgid %u): %d.\n",
-		ownership->owner, ownership->write_open_count);
+/* These attributes apply to all Gasket driver instances. */
+static const struct gasket_sysfs_attribute gasket_sysfs_generic_attrs[] = {
+	GASKET_SYSFS_RO(bar_offsets, gasket_sysfs_data_show, ATTR_BAR_OFFSETS),
+	GASKET_SYSFS_RO(bar_sizes, gasket_sysfs_data_show, ATTR_BAR_SIZES),
+	GASKET_SYSFS_RO(driver_version, gasket_sysfs_data_show,
+			ATTR_DRIVER_VERSION),
+	GASKET_SYSFS_RO(framework_version, gasket_sysfs_data_show,
+			ATTR_FRAMEWORK_VERSION),
+	GASKET_SYSFS_RO(device_type, gasket_sysfs_data_show, ATTR_DEVICE_TYPE),
+	GASKET_SYSFS_RO(revision, gasket_sysfs_data_show,
+			ATTR_HARDWARE_REVISION),
+	GASKET_SYSFS_RO(pci_address, gasket_sysfs_data_show, ATTR_PCI_ADDRESS),
+	GASKET_SYSFS_RO(status, gasket_sysfs_data_show, ATTR_STATUS),
+	GASKET_SYSFS_RO(is_device_owned, gasket_sysfs_data_show,
+			ATTR_IS_DEVICE_OWNED),
+	GASKET_SYSFS_RO(device_owner, gasket_sysfs_data_show,
+			ATTR_DEVICE_OWNER),
+	GASKET_SYSFS_RO(write_open_count, gasket_sysfs_data_show,
+			ATTR_WRITE_OPEN_COUNT),
+	GASKET_SYSFS_RO(reset_count, gasket_sysfs_data_show, ATTR_RESET_COUNT),
+	GASKET_SYSFS_RO(user_mem_ranges, gasket_sysfs_data_show,
+			ATTR_USER_MEM_RANGES),
+	GASKET_END_OF_ATTR_ARRAY
+};
 
-	/* Opening a node owned by another TGID is an error (unless root) */
-	if (ownership->is_owned && ownership->owner != current->tgid &&
-	    !is_root) {
-		dev_err(gasket_dev->dev,
-			"Process %u is opening a node held by %u.\n",
-			current->tgid, ownership->owner);
-		mutex_unlock(&gasket_dev->mutex);
-		return -EPERM;
-	}
+/* Add a char device and related info. */
+static int gasket_add_cdev(
+	struct gasket_cdev_info *dev_info,
+	const struct file_operations *file_ops, struct module *owner)
+{
+	int ret;
 
-	/* If the node is not owned, assign it to the current TGID. */
-	if (!ownership->is_owned) {
-		ret = gasket_check_and_invoke_callback_nolock(
-			gasket_dev, driver_desc->device_open_cb);
-		if (ret) {
-			dev_err(gasket_dev->dev,
-				"Error in device open cb: %d\n", ret);
-			mutex_unlock(&gasket_dev->mutex);
-			return ret;
-		}
-		ownership->is_owned = 1;
-		ownership->owner = current->tgid;
-		dev_dbg(gasket_dev->dev, "Device owner is now tgid %u\n",
-			ownership->owner);
+	cdev_init(&dev_info->cdev, file_ops);
+	dev_info->cdev.owner = owner;
+	ret = cdev_add(&dev_info->cdev, dev_info->devt, 1);
+	if (ret) {
+		dev_err(dev_info->gasket_dev_ptr->dev,
+			"cannot add char device [ret=%d]\n", ret);
+		return ret;
 	}
+	dev_info->cdev_added = 1;
 
-	ownership->write_open_count++;
-
-	dev_dbg(gasket_dev->dev, "New open count (owning tgid %u): %d\n",
-		ownership->owner, ownership->write_open_count);
-
-	mutex_unlock(&gasket_dev->mutex);
 	return 0;
 }
 
-/*
- * Called on a close of the device file.  If this process is the owner,
- * decrement the open count.  On last close by the owner, free up buffers and
- * eventfd contexts, and release ownership.
- *
- * Returns 0 if successful, a negative error number otherwise.
- */
-static int gasket_release(struct inode *inode, struct file *file)
+/* Disable device operations. */
+static void gasket_disable_dev(struct gasket_dev *gasket_dev)
 {
+	const struct gasket_driver_desc *driver_desc =
+		gasket_dev->internal_desc->driver_desc;
 	int i;
-	struct gasket_dev *gasket_dev;
-	struct gasket_ownership *ownership;
-	const struct gasket_driver_desc *driver_desc;
-	char task_name[TASK_COMM_LEN];
-	struct gasket_cdev_info *dev_info =
-		container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
-	struct pid_namespace *pid_ns = task_active_pid_ns(current);
-	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
 
-	gasket_dev = dev_info->gasket_dev_ptr;
-	driver_desc = gasket_dev->internal_desc->driver_desc;
-	ownership = &dev_info->ownership;
-	get_task_comm(task_name, current);
-	mutex_lock(&gasket_dev->mutex);
+	/* Only delete the device if it has been successfully added. */
+	if (gasket_dev->dev_info.cdev_added)
+		cdev_del(&gasket_dev->dev_info.cdev);
 
-	dev_dbg(gasket_dev->dev,
-		"Releasing device node. Call origin: tgid %u (%s) "
-		"(f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
-		current->tgid, task_name, file->f_mode,
-		(file->f_mode & FMODE_WRITE), is_root);
-	dev_dbg(gasket_dev->dev, "Current open count (owning tgid %u): %d\n",
-		ownership->owner, ownership->write_open_count);
+	gasket_dev->status = GASKET_STATUS_DEAD;
 
-	if (file->f_mode & FMODE_WRITE) {
-		ownership->write_open_count--;
-		if (ownership->write_open_count == 0) {
-			dev_dbg(gasket_dev->dev, "Device is now free\n");
-			ownership->is_owned = 0;
-			ownership->owner = 0;
+	gasket_interrupt_cleanup(gasket_dev);
 
-			/* Forces chip reset before we unmap the page tables. */
-			driver_desc->device_reset_cb(gasket_dev, 0);
+	for (i = 0; i < driver_desc->num_page_tables; ++i) {
+		if (gasket_dev->page_table[i]) {
+			gasket_page_table_reset(gasket_dev->page_table[i]);
+			gasket_page_table_cleanup(gasket_dev->page_table[i]);
+		}
+	}
 
-			for (i = 0; i < driver_desc->num_page_tables; ++i) {
-				gasket_page_table_unmap_all(
-					gasket_dev->page_table[i]);
-				gasket_page_table_garbage_collect(
-					gasket_dev->page_table[i]);
-				gasket_free_coherent_memory_all(gasket_dev, i);
-			}
+	check_and_invoke_callback(gasket_dev, driver_desc->disable_dev_cb);
+}
 
-			/* Closes device, enters power save. */
-			gasket_check_and_invoke_callback_nolock(
-				gasket_dev, driver_desc->device_close_cb);
-		}
+/*
+ * Registered descriptor lookup.
+ *
+ * Precondition: Called with g_mutex held (to avoid a race on return).
+ * Returns NULL if no matching device was found.
+ */
+static struct gasket_internal_desc *lookup_internal_desc(
+	struct pci_dev *pci_dev)
+{
+	int i;
+
+	__must_hold(&g_mutex);
+	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
+		if (g_descs[i].driver_desc &&
+		    g_descs[i].driver_desc->pci_id_table &&
+		    pci_match_id(g_descs[i].driver_desc->pci_id_table, pci_dev))
+			return &g_descs[i];
 	}
 
-	dev_dbg(gasket_dev->dev, "New open count (owning tgid %u): %d\n",
-		ownership->owner, ownership->write_open_count);
-	mutex_unlock(&gasket_dev->mutex);
-	return 0;
+	return NULL;
 }
 
 /*
@@ -1301,12 +847,42 @@ static bool gasket_mm_get_mapping_addrs(
 	return false;
 }
 
-int gasket_mm_unmap_region(
-	const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
-	const struct gasket_mappable_region *map_region)
-{
-	ulong bar_offset;
-	ulong virt_offset;
+/*
+ * Calculates the offset where the VMA range begins in its containing BAR.
+ * The offset is written into bar_offset on success.
+ * Returns zero on success, anything else on error.
+ */
+static int gasket_mm_vma_bar_offset(
+	const struct gasket_dev *gasket_dev, const struct vm_area_struct *vma,
+	ulong *bar_offset)
+{
+	ulong raw_offset;
+	int bar_index;
+	const struct gasket_driver_desc *driver_desc =
+		gasket_dev->internal_desc->driver_desc;
+
+	raw_offset = (vma->vm_pgoff << PAGE_SHIFT) +
+		driver_desc->legacy_mmap_address_offset;
+	bar_index = gasket_get_bar_index(gasket_dev, raw_offset);
+	if (bar_index < 0) {
+		dev_err(gasket_dev->dev,
+			"Unable to find matching bar for address 0x%lx\n",
+			raw_offset);
+		trace_gasket_mmap_exit(bar_index);
+		return bar_index;
+	}
+	*bar_offset =
+		raw_offset - driver_desc->bar_descriptions[bar_index].base;
+
+	return 0;
+}
+
+int gasket_mm_unmap_region(
+	const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
+	const struct gasket_mappable_region *map_region)
+{
+	ulong bar_offset;
+	ulong virt_offset;
 	struct gasket_mappable_region mappable_region;
 	int ret;
 
@@ -1407,36 +983,6 @@ static enum do_map_region_status do_map_region(
 	return DO_MAP_REGION_FAILURE;
 }
 
-/*
- * Calculates the offset where the VMA range begins in its containing BAR.
- * The offset is written into bar_offset on success.
- * Returns zero on success, anything else on error.
- */
-static int gasket_mm_vma_bar_offset(
-	const struct gasket_dev *gasket_dev, const struct vm_area_struct *vma,
-	ulong *bar_offset)
-{
-	ulong raw_offset;
-	int bar_index;
-	const struct gasket_driver_desc *driver_desc =
-		gasket_dev->internal_desc->driver_desc;
-
-	raw_offset = (vma->vm_pgoff << PAGE_SHIFT) +
-		driver_desc->legacy_mmap_address_offset;
-	bar_index = gasket_get_bar_index(gasket_dev, raw_offset);
-	if (bar_index < 0) {
-		dev_err(gasket_dev->dev,
-			"Unable to find matching bar for address 0x%lx\n",
-			raw_offset);
-		trace_gasket_mmap_exit(bar_index);
-		return bar_index;
-	}
-	*bar_offset =
-		raw_offset - driver_desc->bar_descriptions[bar_index].base;
-
-	return 0;
-}
-
 /* Map a region of coherent memory. */
 static int gasket_mmap_coherent(
 	struct gasket_dev *gasket_dev, struct vm_area_struct *vma)
@@ -1626,41 +1172,149 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }
 
-/* Determine the health of the Gasket device. */
-static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
+/*
+ * Open the char device file.
+ *
+ * If the open is for writing, and the device is not owned, this process becomes
+ * the owner.  If the open is for writing and the device is already owned by
+ * some other process, it is an error.  If this process is the owner, increment
+ * the open count.
+ *
+ * Returns 0 if successful, a negative error number otherwise.
+ */
+static int gasket_open(struct inode *inode, struct file *filp)
 {
-	int status;
-	int i;
-	const struct gasket_driver_desc *driver_desc =
-		gasket_dev->internal_desc->driver_desc;
+	int ret;
+	struct gasket_dev *gasket_dev;
+	const struct gasket_driver_desc *driver_desc;
+	struct gasket_ownership *ownership;
+	char task_name[TASK_COMM_LEN];
+	struct gasket_cdev_info *dev_info =
+	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
 
-	status = gasket_check_and_invoke_callback_nolock(
-		gasket_dev, driver_desc->device_status_cb);
-	if (status != GASKET_STATUS_ALIVE) {
-		dev_dbg(gasket_dev->dev, "Hardware reported status %d.\n",
-			status);
-		return status;
+	gasket_dev = dev_info->gasket_dev_ptr;
+	driver_desc = gasket_dev->internal_desc->driver_desc;
+	ownership = &dev_info->ownership;
+	get_task_comm(task_name, current);
+	filp->private_data = gasket_dev;
+	inode->i_size = 0;
+
+	dev_dbg(gasket_dev->dev,
+		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
+		"fmode_write: %d is_root: %u)\n",
+		current->tgid, task_name, filp->f_mode,
+		(filp->f_mode & FMODE_WRITE), is_root);
+
+	/* Always allow non-writing accesses. */
+	if (!(filp->f_mode & FMODE_WRITE)) {
+		dev_dbg(gasket_dev->dev, "Allowing read-only opening.\n");
+		return 0;
 	}
 
-	status = gasket_interrupt_system_status(gasket_dev);
-	if (status != GASKET_STATUS_ALIVE) {
-		dev_dbg(gasket_dev->dev,
-			"Interrupt system reported status %d.\n", status);
-		return status;
+	mutex_lock(&gasket_dev->mutex);
+
+	dev_dbg(gasket_dev->dev,
+		"Current owner open count (owning tgid %u): %d.\n",
+		ownership->owner, ownership->write_open_count);
+
+	/* Opening a node owned by another TGID is an error (unless root) */
+	if (ownership->is_owned && ownership->owner != current->tgid &&
+	    !is_root) {
+		dev_err(gasket_dev->dev,
+			"Process %u is opening a node held by %u.\n",
+			current->tgid, ownership->owner);
+		mutex_unlock(&gasket_dev->mutex);
+		return -EPERM;
 	}
 
-	for (i = 0; i < driver_desc->num_page_tables; ++i) {
-		status = gasket_page_table_system_status(
-			gasket_dev->page_table[i]);
-		if (status != GASKET_STATUS_ALIVE) {
-			dev_dbg(gasket_dev->dev,
-				"Page table %d reported status %d.\n",
-				i, status);
-			return status;
+	/* If the node is not owned, assign it to the current TGID. */
+	if (!ownership->is_owned) {
+		ret = gasket_check_and_invoke_callback_nolock(
+			gasket_dev, driver_desc->device_open_cb);
+		if (ret) {
+			dev_err(gasket_dev->dev,
+				"Error in device open cb: %d\n", ret);
+			mutex_unlock(&gasket_dev->mutex);
+			return ret;
 		}
+		ownership->is_owned = 1;
+		ownership->owner = current->tgid;
+		dev_dbg(gasket_dev->dev, "Device owner is now tgid %u\n",
+			ownership->owner);
 	}
 
-	return GASKET_STATUS_ALIVE;
+	ownership->write_open_count++;
+
+	dev_dbg(gasket_dev->dev, "New open count (owning tgid %u): %d\n",
+		ownership->owner, ownership->write_open_count);
+
+	mutex_unlock(&gasket_dev->mutex);
+	return 0;
+}
+
+/*
+ * Called on a close of the device file.  If this process is the owner,
+ * decrement the open count.  On last close by the owner, free up buffers and
+ * eventfd contexts, and release ownership.
+ *
+ * Returns 0 if successful, a negative error number otherwise.
+ */
+static int gasket_release(struct inode *inode, struct file *file)
+{
+	int i;
+	struct gasket_dev *gasket_dev;
+	struct gasket_ownership *ownership;
+	const struct gasket_driver_desc *driver_desc;
+	char task_name[TASK_COMM_LEN];
+	struct gasket_cdev_info *dev_info =
+		container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
+
+	gasket_dev = dev_info->gasket_dev_ptr;
+	driver_desc = gasket_dev->internal_desc->driver_desc;
+	ownership = &dev_info->ownership;
+	get_task_comm(task_name, current);
+	mutex_lock(&gasket_dev->mutex);
+
+	dev_dbg(gasket_dev->dev,
+		"Releasing device node. Call origin: tgid %u (%s) "
+		"(f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
+		current->tgid, task_name, file->f_mode,
+		(file->f_mode & FMODE_WRITE), is_root);
+	dev_dbg(gasket_dev->dev, "Current open count (owning tgid %u): %d\n",
+		ownership->owner, ownership->write_open_count);
+
+	if (file->f_mode & FMODE_WRITE) {
+		ownership->write_open_count--;
+		if (ownership->write_open_count == 0) {
+			dev_dbg(gasket_dev->dev, "Device is now free\n");
+			ownership->is_owned = 0;
+			ownership->owner = 0;
+
+			/* Forces chip reset before we unmap the page tables. */
+			driver_desc->device_reset_cb(gasket_dev, 0);
+
+			for (i = 0; i < driver_desc->num_page_tables; ++i) {
+				gasket_page_table_unmap_all(
+					gasket_dev->page_table[i]);
+				gasket_page_table_garbage_collect(
+					gasket_dev->page_table[i]);
+				gasket_free_coherent_memory_all(gasket_dev, i);
+			}
+
+			/* Closes device, enters power save. */
+			gasket_check_and_invoke_callback_nolock(
+				gasket_dev, driver_desc->device_close_cb);
+		}
+	}
+
+	dev_dbg(gasket_dev->dev, "New open count (owning tgid %u): %d\n",
+		ownership->owner, ownership->write_open_count);
+	mutex_unlock(&gasket_dev->mutex);
+	return 0;
 }
 
 /*
@@ -1702,209 +1356,333 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 	return gasket_handle_ioctl(filp, cmd, argp);
 }
 
-int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type)
-{
-	int ret;
-
-	mutex_lock(&gasket_dev->mutex);
-	ret = gasket_reset_nolock(gasket_dev, reset_type);
-	mutex_unlock(&gasket_dev->mutex);
-	return ret;
-}
-EXPORT_SYMBOL(gasket_reset);
+/* File operations for all Gasket devices. */
+static const struct file_operations gasket_file_ops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.mmap = gasket_mmap,
+	.open = gasket_open,
+	.release = gasket_release,
+	.unlocked_ioctl = gasket_ioctl,
+};
 
-int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
+/* Perform final init and marks the device as active. */
+static int gasket_enable_dev(
+	struct gasket_internal_desc *internal_desc,
+	struct gasket_dev *gasket_dev)
 {
+	int tbl_idx;
 	int ret;
-	int i;
-	const struct gasket_driver_desc *driver_desc;
+	const struct gasket_driver_desc *driver_desc =
+		internal_desc->driver_desc;
 
-	driver_desc = gasket_dev->internal_desc->driver_desc;
-	if (!driver_desc->device_reset_cb)
-		return 0;
-
-	/* Perform a device reset of the requested type. */
-	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
+	ret = gasket_interrupt_init(
+		gasket_dev, driver_desc->name,
+		driver_desc->interrupt_type, driver_desc->interrupts,
+		driver_desc->num_interrupts, driver_desc->interrupt_pack_width,
+		driver_desc->interrupt_bar_index,
+		driver_desc->wire_interrupt_offsets);
 	if (ret) {
-		dev_dbg(gasket_dev->dev, "Device reset cb returned %d.\n",
-			ret);
+		dev_err(gasket_dev->dev,
+			"Critical failure to allocate interrupts: %d\n", ret);
+		gasket_interrupt_cleanup(gasket_dev);
 		return ret;
 	}
 
-	/* Reinitialize the page tables and interrupt framework. */
-	for (i = 0; i < driver_desc->num_page_tables; ++i)
-		gasket_page_table_reset(gasket_dev->page_table[i]);
+	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
+		dev_dbg(gasket_dev->dev, "Initializing page table %d.\n",
+			tbl_idx);
+		ret = gasket_page_table_init(
+			&gasket_dev->page_table[tbl_idx],
+			&gasket_dev->bar_data[
+				driver_desc->page_table_bar_index],
+			&driver_desc->page_table_configs[tbl_idx],
+			gasket_dev->dev, gasket_dev->pci_dev);
+		if (ret) {
+			dev_err(gasket_dev->dev,
+				"Couldn't init page table %d: %d\n",
+				tbl_idx, ret);
+			return ret;
+		}
+		/*
+		 * Make sure that the page table is clear and set to simple
+		 * addresses.
+		 */
+		gasket_page_table_reset(gasket_dev->page_table[tbl_idx]);
+	}
 
-	ret = gasket_interrupt_reinit(gasket_dev);
+	/*
+	 * hardware_revision_cb returns a positive integer (the rev) if
+	 * successful.)
+	 */
+	ret = check_and_invoke_callback(
+		gasket_dev, driver_desc->hardware_revision_cb);
+	if (ret < 0) {
+		dev_err(gasket_dev->dev,
+			"Error getting hardware revision: %d\n", ret);
+		return ret;
+	}
+	gasket_dev->hardware_revision = ret;
+
+	ret = check_and_invoke_callback(gasket_dev, driver_desc->enable_dev_cb);
 	if (ret) {
-		dev_dbg(gasket_dev->dev, "Unable to reinit interrupts: %d.\n",
+		dev_err(gasket_dev->dev, "Error in enable device cb: %d\n",
 			ret);
 		return ret;
 	}
 
-	/* Get current device health. */
+	/* device_status_cb returns a device status, not an error code. */
 	gasket_dev->status = gasket_get_hw_status(gasket_dev);
-	if (gasket_dev->status == GASKET_STATUS_DEAD) {
-		dev_dbg(gasket_dev->dev, "Device reported as dead.\n");
-		return -EINVAL;
-	}
+	if (gasket_dev->status == GASKET_STATUS_DEAD)
+		dev_err(gasket_dev->dev, "Device reported as unhealthy.\n");
+
+	ret = gasket_add_cdev(
+		&gasket_dev->dev_info, &gasket_file_ops, driver_desc->module);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-EXPORT_SYMBOL(gasket_reset_nolock);
 
-gasket_ioctl_permissions_cb_t gasket_get_ioctl_permissions_cb(
-	struct gasket_dev *gasket_dev)
+/*
+ * PCI subsystem probe function.
+ *
+ * Called when a Gasket device is found. Allocates device metadata, maps device
+ * memory, and calls gasket_enable_dev to prepare the device for active use.
+ *
+ * Returns 0 if successful and a negative value otherwise.
+ */
+static int gasket_pci_probe(
+	struct pci_dev *pci_dev, const struct pci_device_id *id)
 {
-	return gasket_dev->internal_desc->driver_desc->ioctl_permissions_cb;
-}
-EXPORT_SYMBOL(gasket_get_ioctl_permissions_cb);
+	int ret;
+	const char *kobj_name = dev_name(&pci_dev->dev);
+	struct gasket_internal_desc *internal_desc;
+	struct gasket_dev *gasket_dev;
+	const struct gasket_driver_desc *driver_desc;
+	struct device *parent;
 
-static ssize_t gasket_write_mappable_regions(
-	char *buf, const struct gasket_driver_desc *driver_desc, int bar_index)
-{
-	int i;
-	ssize_t written;
-	ssize_t total_written = 0;
-	ulong min_addr, max_addr;
-	struct gasket_bar_desc bar_desc =
-		driver_desc->bar_descriptions[bar_index];
+	pr_info("Add Gasket device %s\n", kobj_name);
 
-	if (bar_desc.permissions == GASKET_NOMAP)
-		return 0;
-	for (i = 0;
-	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
-	     i++) {
-		min_addr = bar_desc.mappable_regions[i].start -
-			   driver_desc->legacy_mmap_address_offset;
-		max_addr = bar_desc.mappable_regions[i].start -
-			   driver_desc->legacy_mmap_address_offset +
-			   bar_desc.mappable_regions[i].length_bytes;
-		written = scnprintf(buf, PAGE_SIZE - total_written,
-				    "0x%08lx-0x%08lx\n", min_addr, max_addr);
-		total_written += written;
-		buf += written;
+	mutex_lock(&g_mutex);
+	internal_desc = lookup_internal_desc(pci_dev);
+	mutex_unlock(&g_mutex);
+	if (!internal_desc) {
+		pr_err("PCI probe called for unknown driver type\n");
+		return -ENODEV;
 	}
-	return total_written;
+
+	driver_desc = internal_desc->driver_desc;
+
+	parent = &pci_dev->dev;
+	ret = gasket_alloc_dev(internal_desc, parent, &gasket_dev, kobj_name);
+	if (ret)
+		return ret;
+	gasket_dev->pci_dev = pci_dev_get(pci_dev);
+	if (IS_ERR_OR_NULL(gasket_dev->dev_info.device)) {
+		pr_err("Cannot create %s device %s [ret = %ld]\n",
+		       driver_desc->name, gasket_dev->dev_info.name,
+		       PTR_ERR(gasket_dev->dev_info.device));
+		ret = -ENODEV;
+		goto fail1;
+	}
+
+	ret = gasket_setup_pci(pci_dev, gasket_dev);
+	if (ret)
+		goto fail2;
+
+	ret = check_and_invoke_callback(gasket_dev, driver_desc->add_dev_cb);
+	if (ret) {
+		dev_err(gasket_dev->dev, "Error in add device cb: %d\n", ret);
+		goto fail2;
+	}
+
+	ret = gasket_sysfs_create_mapping(
+		gasket_dev->dev_info.device, gasket_dev);
+	if (ret)
+		goto fail3;
+
+	/*
+	 * Once we've created the mapping structures successfully, attempt to
+	 * create a symlink to the pci directory of this object.
+	 */
+	ret = sysfs_create_link(&gasket_dev->dev_info.device->kobj,
+				&pci_dev->dev.kobj, dev_name(&pci_dev->dev));
+	if (ret) {
+		dev_err(gasket_dev->dev,
+			"Cannot create sysfs pci link: %d\n", ret);
+		goto fail3;
+	}
+	ret = gasket_sysfs_create_entries(
+		gasket_dev->dev_info.device, gasket_sysfs_generic_attrs);
+	if (ret)
+		goto fail4;
+
+	ret = check_and_invoke_callback(
+		gasket_dev, driver_desc->sysfs_setup_cb);
+	if (ret) {
+		dev_err(gasket_dev->dev, "Error in sysfs setup cb: %d\n", ret);
+		goto fail5;
+	}
+
+	ret = gasket_enable_dev(internal_desc, gasket_dev);
+	if (ret) {
+		pr_err("cannot setup %s device\n", driver_desc->name);
+		gasket_disable_dev(gasket_dev);
+		goto fail5;
+	}
+
+	return 0;
+
+fail5:
+	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
+fail4:
+fail3:
+	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
+fail2:
+	gasket_cleanup_pci(gasket_dev);
+	check_and_invoke_callback(gasket_dev, driver_desc->remove_dev_cb);
+	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
+fail1:
+	gasket_free_dev(gasket_dev);
+	return ret;
 }
 
-static ssize_t gasket_sysfs_data_show(
-	struct device *device, struct device_attribute *attr, char *buf)
+/*
+ * PCI subsystem remove function.
+ *
+ * Called to remove a Gasket device. Finds the device in the device list and
+ * cleans up metadata.
+ */
+static void gasket_pci_remove(struct pci_dev *pci_dev)
 {
-	int i, ret = 0;
-	ssize_t current_written = 0;
+	int i;
+	struct gasket_internal_desc *internal_desc;
+	struct gasket_dev *gasket_dev = NULL;
 	const struct gasket_driver_desc *driver_desc;
-	struct gasket_dev *gasket_dev;
-	struct gasket_sysfs_attribute *gasket_attr;
-	const struct gasket_bar_desc *bar_desc;
-	enum gasket_sysfs_attribute_type sysfs_type;
-
-	gasket_dev = gasket_sysfs_get_device_data(device);
-	if (!gasket_dev) {
-		dev_err(device, "No sysfs mapping found for device\n");
-		return 0;
+	/* Find the device desc. */
+	mutex_lock(&g_mutex);
+	internal_desc = lookup_internal_desc(pci_dev);
+	if (!internal_desc) {
+		mutex_unlock(&g_mutex);
+		return;
 	}
+	mutex_unlock(&g_mutex);
 
-	gasket_attr = gasket_sysfs_get_attr(device, attr);
-	if (!gasket_attr) {
-		dev_err(device, "No sysfs attr found for device\n");
-		gasket_sysfs_put_device_data(device, gasket_dev);
-		return 0;
+	driver_desc = internal_desc->driver_desc;
+
+	/* Now find the specific device */
+	mutex_lock(&internal_desc->mutex);
+	for (i = 0; i < GASKET_DEV_MAX; i++) {
+		if (internal_desc->devs[i] &&
+		    internal_desc->devs[i]->pci_dev == pci_dev) {
+			gasket_dev = internal_desc->devs[i];
+			break;
+		}
 	}
+	mutex_unlock(&internal_desc->mutex);
 
-	driver_desc = gasket_dev->internal_desc->driver_desc;
+	if (!gasket_dev)
+		return;
 
-	sysfs_type =
-		(enum gasket_sysfs_attribute_type)gasket_attr->data.attr_type;
-	switch (sysfs_type) {
-	case ATTR_BAR_OFFSETS:
-		for (i = 0; i < GASKET_NUM_BARS; i++) {
-			bar_desc = &driver_desc->bar_descriptions[i];
-			if (bar_desc->size == 0)
-				continue;
-			current_written =
-				snprintf(buf, PAGE_SIZE - ret, "%d: 0x%lx\n", i,
-					 (ulong)bar_desc->base);
-			buf += current_written;
-			ret += current_written;
-		}
-		break;
-	case ATTR_BAR_SIZES:
-		for (i = 0; i < GASKET_NUM_BARS; i++) {
-			bar_desc = &driver_desc->bar_descriptions[i];
-			if (bar_desc->size == 0)
-				continue;
-			current_written =
-				snprintf(buf, PAGE_SIZE - ret, "%d: 0x%lx\n", i,
-					 (ulong)bar_desc->size);
-			buf += current_written;
-			ret += current_written;
-		}
-		break;
-	case ATTR_DRIVER_VERSION:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n",
-			gasket_dev->internal_desc->driver_desc->driver_version);
-		break;
-	case ATTR_FRAMEWORK_VERSION:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n", GASKET_FRAMEWORK_VERSION);
-		break;
-	case ATTR_DEVICE_TYPE:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n",
-			gasket_dev->internal_desc->driver_desc->name);
-		break;
-	case ATTR_HARDWARE_REVISION:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n", gasket_dev->hardware_revision);
-		break;
-	case ATTR_PCI_ADDRESS:
-		ret = snprintf(buf, PAGE_SIZE, "%s\n", gasket_dev->kobj_name);
-		break;
-	case ATTR_STATUS:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n",
-			gasket_num_name_lookup(
-				gasket_dev->status, gasket_status_name_table));
-		break;
-	case ATTR_IS_DEVICE_OWNED:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n",
-			gasket_dev->dev_info.ownership.is_owned);
-		break;
-	case ATTR_DEVICE_OWNER:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n",
-			gasket_dev->dev_info.ownership.owner);
-		break;
-	case ATTR_WRITE_OPEN_COUNT:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n",
-			gasket_dev->dev_info.ownership.write_open_count);
-		break;
-	case ATTR_RESET_COUNT:
-		ret = snprintf(buf, PAGE_SIZE, "%d\n", gasket_dev->reset_count);
-		break;
-	case ATTR_USER_MEM_RANGES:
-		for (i = 0; i < GASKET_NUM_BARS; ++i) {
-			current_written = gasket_write_mappable_regions(
-				buf, driver_desc, i);
-			buf += current_written;
-			ret += current_written;
-		}
-		break;
-	default:
-		dev_dbg(gasket_dev->dev, "Unknown attribute: %s\n",
-			attr->attr.name);
-		ret = 0;
-		break;
+	pr_info("remove %s device %s\n", internal_desc->driver_desc->name,
+		gasket_dev->kobj_name);
+
+	gasket_disable_dev(gasket_dev);
+	gasket_cleanup_pci(gasket_dev);
+
+	check_and_invoke_callback(gasket_dev, driver_desc->sysfs_cleanup_cb);
+	gasket_sysfs_remove_mapping(gasket_dev->dev_info.device);
+
+	check_and_invoke_callback(gasket_dev, driver_desc->remove_dev_cb);
+
+	device_destroy(internal_desc->class, gasket_dev->dev_info.devt);
+	gasket_free_dev(gasket_dev);
+}
+
+/**
+ * Lookup a name by number in a num_name table.
+ * @num: Number to lookup.
+ * @table: Array of num_name structures, the table for the lookup.
+ *
+ * Description: Searches for num in the table.  If found, the
+ *		corresponding name is returned; otherwise NULL
+ *		is returned.
+ *
+ *		The table must have a NULL name pointer at the end.
+ */
+const char *gasket_num_name_lookup(
+	uint num, const struct gasket_num_name *table)
+{
+	uint i = 0;
+
+	while (table[i].snn_name) {
+		if (num == table[i].snn_num)
+			break;
+		++i;
 	}
 
-	gasket_sysfs_put_attr(device, gasket_attr);
-	gasket_sysfs_put_device_data(device, gasket_dev);
+	return table[i].snn_name;
+}
+EXPORT_SYMBOL(gasket_num_name_lookup);
+
+int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type)
+{
+	int ret;
+
+	mutex_lock(&gasket_dev->mutex);
+	ret = gasket_reset_nolock(gasket_dev, reset_type);
+	mutex_unlock(&gasket_dev->mutex);
 	return ret;
 }
+EXPORT_SYMBOL(gasket_reset);
+
+int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
+{
+	int ret;
+	int i;
+	const struct gasket_driver_desc *driver_desc;
+
+	driver_desc = gasket_dev->internal_desc->driver_desc;
+	if (!driver_desc->device_reset_cb)
+		return 0;
+
+	/* Perform a device reset of the requested type. */
+	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
+	if (ret) {
+		dev_dbg(gasket_dev->dev, "Device reset cb returned %d.\n",
+			ret);
+		return ret;
+	}
+
+	/* Reinitialize the page tables and interrupt framework. */
+	for (i = 0; i < driver_desc->num_page_tables; ++i)
+		gasket_page_table_reset(gasket_dev->page_table[i]);
+
+	ret = gasket_interrupt_reinit(gasket_dev);
+	if (ret) {
+		dev_dbg(gasket_dev->dev, "Unable to reinit interrupts: %d.\n",
+			ret);
+		return ret;
+	}
+
+	/* Get current device health. */
+	gasket_dev->status = gasket_get_hw_status(gasket_dev);
+	if (gasket_dev->status == GASKET_STATUS_DEAD) {
+		dev_dbg(gasket_dev->dev, "Device reported as dead.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(gasket_reset_nolock);
+
+gasket_ioctl_permissions_cb_t gasket_get_ioctl_permissions_cb(
+	struct gasket_dev *gasket_dev)
+{
+	return gasket_dev->internal_desc->driver_desc->ioctl_permissions_cb;
+}
+EXPORT_SYMBOL(gasket_get_ioctl_permissions_cb);
 
 /* Get the driver structure for a given gasket_dev.
  * @dev: pointer to gasket_dev, implementing the requested driver.
@@ -1954,3 +1732,169 @@ int gasket_wait_with_reschedule(
 	return -ETIMEDOUT;
 }
 EXPORT_SYMBOL(gasket_wait_with_reschedule);
+
+/* See gasket_core.h for description. */
+int gasket_register_device(const struct gasket_driver_desc *driver_desc)
+{
+	int i, ret;
+	int desc_idx = -1;
+	struct gasket_internal_desc *internal;
+
+	pr_info("Initializing Gasket framework device\n");
+	/* Check for duplicates and find a free slot. */
+	mutex_lock(&g_mutex);
+
+	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
+		if (g_descs[i].driver_desc == driver_desc) {
+			pr_err("%s driver already loaded/registered\n",
+			       driver_desc->name);
+			mutex_unlock(&g_mutex);
+			return -EBUSY;
+		}
+	}
+
+	/* This and the above loop could be combined, but this reads easier. */
+	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
+		if (!g_descs[i].driver_desc) {
+			g_descs[i].driver_desc = driver_desc;
+			desc_idx = i;
+			break;
+		}
+	}
+	mutex_unlock(&g_mutex);
+
+	pr_info("Loaded %s driver, framework version %s\n",
+		driver_desc->name, GASKET_FRAMEWORK_VERSION);
+
+	if (desc_idx == -1) {
+		pr_err("Too many Gasket drivers loaded: %d\n",
+		       GASKET_FRAMEWORK_DESC_MAX);
+		return -EBUSY;
+	}
+
+	/* Internal structure setup. */
+	pr_debug("Performing initial internal structure setup.\n");
+	internal = &g_descs[desc_idx];
+	mutex_init(&internal->mutex);
+	memset(internal->devs, 0, sizeof(struct gasket_dev *) * GASKET_DEV_MAX);
+	memset(&internal->pci, 0, sizeof(internal->pci));
+	internal->pci.name = driver_desc->name;
+	internal->pci.id_table = driver_desc->pci_id_table;
+	internal->pci.probe = gasket_pci_probe;
+	internal->pci.remove = gasket_pci_remove;
+	internal->class =
+		class_create(driver_desc->module, driver_desc->name);
+
+	if (IS_ERR(internal->class)) {
+		pr_err("Cannot register %s class [ret=%ld]\n",
+		       driver_desc->name, PTR_ERR(internal->class));
+		ret = PTR_ERR(internal->class);
+		goto unregister_gasket_driver;
+	}
+
+	/*
+	 * Not using pci_register_driver() (without underscores), as it
+	 * depends on KBUILD_MODNAME, and this is a shared file.
+	 */
+	pr_debug("Registering PCI driver.\n");
+	ret = __pci_register_driver(
+		&internal->pci, driver_desc->module, driver_desc->name);
+	if (ret) {
+		pr_err("cannot register pci driver [ret=%d]\n", ret);
+		goto fail1;
+	}
+
+	pr_debug("Registering char driver.\n");
+	ret = register_chrdev_region(
+		MKDEV(driver_desc->major, driver_desc->minor), GASKET_DEV_MAX,
+		driver_desc->name);
+	if (ret) {
+		pr_err("cannot register char driver [ret=%d]\n", ret);
+		goto fail2;
+	}
+
+	pr_info("Driver registered successfully.\n");
+	return 0;
+
+fail2:
+	pci_unregister_driver(&internal->pci);
+
+fail1:
+	class_destroy(internal->class);
+
+unregister_gasket_driver:
+	mutex_lock(&g_mutex);
+	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(gasket_register_device);
+
+/* See gasket_core.h for description. */
+void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
+{
+	int i, desc_idx;
+	struct gasket_internal_desc *internal_desc = NULL;
+
+	mutex_lock(&g_mutex);
+	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
+		if (g_descs[i].driver_desc == driver_desc) {
+			internal_desc = &g_descs[i];
+			desc_idx = i;
+			break;
+		}
+	}
+	mutex_unlock(&g_mutex);
+
+	if (!internal_desc) {
+		pr_err("request to unregister unknown desc: %s, %d:%d\n",
+		       driver_desc->name, driver_desc->major,
+		       driver_desc->minor);
+		return;
+	}
+
+	unregister_chrdev_region(
+		MKDEV(driver_desc->major, driver_desc->minor), GASKET_DEV_MAX);
+
+	pci_unregister_driver(&internal_desc->pci);
+
+	class_destroy(internal_desc->class);
+
+	/* Finally, effectively "remove" the driver. */
+	mutex_lock(&g_mutex);
+	g_descs[desc_idx].driver_desc = NULL;
+	mutex_unlock(&g_mutex);
+
+	pr_info("removed %s driver\n", driver_desc->name);
+}
+EXPORT_SYMBOL(gasket_unregister_device);
+
+static int __init gasket_init(void)
+{
+	int i;
+
+	pr_info("Performing one-time init of the Gasket framework.\n");
+	/* Check for duplicates and find a free slot. */
+	mutex_lock(&g_mutex);
+	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
+		g_descs[i].driver_desc = NULL;
+		mutex_init(&g_descs[i].mutex);
+	}
+
+	gasket_sysfs_init();
+
+	mutex_unlock(&g_mutex);
+	return 0;
+}
+
+static void __exit gasket_exit(void)
+{
+	/* No deinit/dealloc needed at present. */
+	pr_info("Removing Gasket framework module.\n");
+}
+MODULE_DESCRIPTION("Google Gasket driver framework");
+MODULE_VERSION(GASKET_FRAMEWORK_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Rob Springer <rspringer@google.com>");
+module_init(gasket_init);
+module_exit(gasket_exit);
-- 
2.18.0.345.g5c9ce644c3-goog


Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE3C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A68820894
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtSiEKny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A68820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbeG2VIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33675 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbeG2VIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:36 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so4503715plb.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNqBkTK9pHiTxiYIr/mMkImaK0NIZbexGQStw3kES3M=;
        b=UtSiEKnyLTcE6G5g+ku0zd8tft0f09HCXgr4LoKhy6QGs8SjyuLr7TvSIA7L5++h8g
         9Veo/Iif0bo3SpmPtJ0FhVlT5R063pp9TlvnNVgmoETi+JiQkbdIjFoHmDNZjjvhoGUy
         /WcguqIRwnt972Zkn+yRFZtxMVqIFylYZELNIXgk8GuhluK9DZQ5+XeFIBlt9rRVAGgk
         mv3+oqWP/mBPj/oPb1IuKJrZec8YFCHxAxKJ1Cos1BMzCi8ZHgqZIpHQ3GjPD/n3AUub
         0jxKti9/CFFH5yQ581cgda4DW6ECRVpWNNDvwaNSW9uGtHvvbLK8YHi5oe6i/wUtmmIS
         T/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNqBkTK9pHiTxiYIr/mMkImaK0NIZbexGQStw3kES3M=;
        b=XziPSziZrGxrdHweeYxn+f/j0ltVVlK9sYzo20Tf1lawCXJjx0dqCo7VsLDprELNtO
         4yXJGcWQJPeJBFGJZst9ReZ+ih6mHAackYFBqKSKOOfhjiLfCr5MxhP7apRvXbaHsYTk
         Z3ODTSgs9dJaM7xGiqvZPm/3HeGBrW+0eNSZLbBqcjzFidf2NjSN+dZ8bCr7qBBJXFJQ
         vHWp9HDPqf6TSOigaKdxVmi6M7nZuaapNR0nVK0FBYjfAtkDtoCPHxHEzBv1Tl78a0iz
         mktbesC16ee/k67ZZLTAkRLH3uYroHRmWn/HQgia2ITESJvuahULWBLchXDju1siJFdt
         kzlQ==
X-Gm-Message-State: AOUpUlF5U17PnSbeO9yKO4h86oGS/YYxn2bAtIrW8KH8BWQkpL7qNZc1
        PM1uwqouVAeXtq22sxMXMCo=
X-Google-Smtp-Source: AAOMgpdu5HjdLQzdjLkqIXpIvoWb2bw4Alz1Ns8iKqgsArHoEbV7lw7wJqwnvocI/LVDCNaMx2rNgQ==
X-Received: by 2002:a17:902:b708:: with SMTP id d8-v6mr13871218pls.184.1532893023888;
        Sun, 29 Jul 2018 12:37:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:03 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/13] staging: gasket: core: simplify comments for static functions
Date:   Sun, 29 Jul 2018 12:36:39 -0700
Message-Id: <20180729193646.201721-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Static functions don't need kernel doc formatting, can be simplified.
Reformat comments that can be single-line.  Remove extraneous text.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 151 ++++++---------------------
 1 file changed, 31 insertions(+), 120 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 291cd6d074a2e..c00774059f9eb 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -199,11 +199,7 @@ MODULE_AUTHOR("Rob Springer <rspringer@google.com>");
 module_init(gasket_init);
 module_exit(gasket_exit);
 
-/*
- * Perform a standard Gasket callback.
- * @gasket_dev: Device specific pointer to forward.
- * @cb_function: Standard callback to perform.
- */
+/* Perform a standard Gasket callback. */
 static inline int check_and_invoke_callback(
 	struct gasket_dev *gasket_dev, int (*cb_function)(struct gasket_dev *))
 {
@@ -219,13 +215,7 @@ static inline int check_and_invoke_callback(
 	return ret;
 }
 
-/*
- * Perform a standard Gasket callback
- * without grabbing gasket_dev->mutex.
- * @gasket_dev: Device specific pointer to forward.
- * @cb_function: Standard callback to perform.
- *
- */
+/* Perform a standard Gasket callback without grabbing gasket_dev->mutex. */
 static inline int gasket_check_and_invoke_callback_nolock(
 	struct gasket_dev *gasket_dev, int (*cb_function)(struct gasket_dev *))
 {
@@ -240,9 +230,8 @@ static inline int gasket_check_and_invoke_callback_nolock(
 }
 
 /*
- * Returns nonzero if the gasket_cdev_info is owned by the current thread group
+ * Return nonzero if the gasket_cdev_info is owned by the current thread group
  * ID.
- * @info: Device node info.
  */
 static int gasket_owned_by_current_tgid(struct gasket_cdev_info *info)
 {
@@ -410,14 +399,9 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 }
 EXPORT_SYMBOL(gasket_unregister_device);
 
-/**
- * Allocate a Gasket device.
- * @internal_desc: Pointer to the internal data for the device driver.
- * @pdev: Pointer to the Gasket device pointer, the allocated device.
- * @kobj_name: PCIe name for the device
- *
- * Description: Allocates and initializes a Gasket device structure.
- *              Adds the device to the device list.
+/*
+ * Allocate and initialize a Gasket device structure, add the device to the
+ * device list.
  *
  * Returns 0 if successful, a negative error code otherwise.
  */
@@ -476,13 +460,7 @@ static int gasket_alloc_dev(
 	return 0;
 }
 
-/*
- * Free a Gasket device.
- * @internal_dev: Gasket device pointer; the device to unregister and free.
- *
- * Description: Removes the device from the device list and frees
- *              the Gasket device structure.
- */
+/* Free a Gasket device. */
 static void gasket_free_dev(struct gasket_dev *gasket_dev)
 {
 	struct gasket_internal_desc *internal_desc = gasket_dev->internal_desc;
@@ -496,7 +474,7 @@ static void gasket_free_dev(struct gasket_dev *gasket_dev)
 }
 
 /*
- * Finds the next free gasket_internal_dev slot.
+ * Find the next free gasket_internal_dev slot.
  *
  * Returns the located slot number on success or a negative number on failure.
  */
@@ -533,10 +511,8 @@ static int gasket_find_dev_slot(
 	return i;
 }
 
-/**
+/*
  * PCI subsystem probe function.
- * @pci_dev: PCI device pointer to the new device.
- * @id: PCI device id structure pointer, the vendor and device ids.
  *
  * Called when a Gasket device is found. Allocates device metadata, maps device
  * memory, and calls gasket_enable_dev to prepare the device for active use.
@@ -641,7 +617,6 @@ static int gasket_pci_probe(
 
 /*
  * PCI subsystem remove function.
- * @pci_dev: PCI device pointer; the device to remove.
  *
  * Called to remove a Gasket device. Finds the device in the device list and
  * cleans up metadata.
@@ -694,8 +669,6 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
 
 /*
  * Setup PCI & set up memory mapping for the specified device.
- * @pci_dev: pointer to the particular PCI device.
- * @internal_dev: Corresponding Gasket device pointer.
  *
  * Enables the PCI device, reads the BAR registers and sets up pointers to the
  * device's memory mapped IO space.
@@ -746,8 +719,6 @@ static void gasket_cleanup_pci(struct gasket_dev *gasket_dev)
 
 /*
  * Maps the specified bar into kernel space.
- * @internal_dev: Device possessing the BAR to map.
- * @bar_num: The BAR to map.
  *
  * Returns 0 on success, a negative error code otherwise.
  * A zero-sized BAR will not be mapped, but is not an error.
@@ -824,7 +795,6 @@ static int gasket_map_pci_bar(struct gasket_dev *gasket_dev, int bar_num)
 
 /*
  * Releases PCI BAR mapping.
- * @internal_dev: Device possessing the BAR to unmap.
  *
  * A zero-sized or not-mapped BAR will not be unmapped, but is not an error.
  */
@@ -856,12 +826,7 @@ static void gasket_unmap_pci_bar(struct gasket_dev *dev, int bar_num)
 	release_mem_region(base, bytes);
 }
 
-/*
- * Handle adding a char device and related info.
- * @dev_info: Pointer to the dev_info struct for this device.
- * @file_ops: The file operations for this device.
- * @owner: The owning module for this device.
- */
+/* Add a char device and related info. */
 static int gasket_add_cdev(
 	struct gasket_cdev_info *dev_info,
 	const struct file_operations *file_ops, struct module *owner)
@@ -881,14 +846,7 @@ static int gasket_add_cdev(
 	return 0;
 }
 
-/*
- * Performs final init and marks the device as active.
- * @internal_desc: Pointer to Gasket [internal] driver descriptor structure.
- * @internal_dev: Pointer to Gasket [internal] device structure.
- *
- * Currently forwards all work to device-specific callback; a future phase will
- * extract elements of character device registration here.
- */
+/* Perform final init and marks the device as active. */
 static int gasket_enable_dev(
 	struct gasket_internal_desc *internal_desc,
 	struct gasket_dev *gasket_dev)
@@ -966,13 +924,7 @@ static int gasket_enable_dev(
 	return 0;
 }
 
-/*
- * Disable device operations.
- * @gasket_dev: Pointer to Gasket device structure.
- *
- * Currently forwards all work to device-specific callback; a future phase will
- * extract elements of character device unregistration here.
- */
+/* Disable device operations. */
 static void gasket_disable_dev(struct gasket_dev *gasket_dev)
 {
 	const struct gasket_driver_desc *driver_desc =
@@ -997,7 +949,7 @@ static void gasket_disable_dev(struct gasket_dev *gasket_dev)
 	check_and_invoke_callback(gasket_dev, driver_desc->disable_dev_cb);
 }
 
-/**
+/*
  * Registered descriptor lookup.
  *
  * Precondition: Called with g_mutex held (to avoid a race on return).
@@ -1045,18 +997,15 @@ const char *gasket_num_name_lookup(
 }
 EXPORT_SYMBOL(gasket_num_name_lookup);
 
-/**
- * Opens the char device file.
- * @inode: Inode structure pointer of the device file.
- * @file: File structure pointer.
+/*
+ * Open the char device file.
  *
- * Description: Called on an open of the device file.  If the open is for
- *              writing, and the device is not owned, this process becomes
- *              the owner.  If the open is for writing and the device is
- *              already owned by some other process, it is an error.  If
- *              this process is the owner, increment the open count.
+ * If the open is for writing, and the device is not owned, this process becomes
+ * the owner.  If the open is for writing and the device is already owned by
+ * some other process, it is an error.  If this process is the owner, increment
+ * the open count.
  *
- *              Returns 0 if successful, a negative error number otherwise.
+ * Returns 0 if successful, a negative error number otherwise.
  */
 static int gasket_open(struct inode *inode, struct file *filp)
 {
@@ -1130,17 +1079,12 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-/**
- * gasket_release - Close of the char device file.
- * @inode: Inode structure pointer of the device file.
- * @file: File structure pointer.
- *
- * Description: Called on a close of the device file.  If this process
- *              is the owner, decrement the open count.  On last close
- *              by the owner, free up buffers and eventfd contexts, and
- *              release ownership.
+/*
+ * Called on a close of the device file.  If this process is the owner,
+ * decrement the open count.  On last close by the owner, free up buffers and
+ * eventfd contexts, and release ownership.
  *
- *              Returns 0 if successful, a negative error number otherwise.
+ * Returns 0 if successful, a negative error number otherwise.
  */
 static int gasket_release(struct inode *inode, struct file *file)
 {
@@ -1199,10 +1143,6 @@ static int gasket_release(struct inode *inode, struct file *file)
 }
 
 /*
- * Permission and validity checking for mmap ops.
- * @gasket_dev: Gasket device information structure.
- * @vma: Standard virtual memory area descriptor.
- *
  * Verifies that the user has permissions to perform the requested mapping and
  * that the provided descriptor/range is of adequate size to hold the range to
  * be mapped.
@@ -1246,11 +1186,6 @@ static bool gasket_mmap_has_permissions(
 }
 
 /*
- * Checks if an address is within the region
- * allocated for coherent buffer.
- * @driver_desc: driver description.
- * @address: offset of address to check.
- *
  * Verifies that the input address is within the region allocated to coherent
  * buffer.
  */
@@ -1502,11 +1437,7 @@ static int gasket_mm_vma_bar_offset(
 	return 0;
 }
 
-/*
- * Map a region of coherent memory.
- * @gasket_dev: Gasket device handle.
- * @vma: Virtual memory area descriptor with region to map.
- */
+/* Map a region of coherent memory. */
 static int gasket_mmap_coherent(
 	struct gasket_dev *gasket_dev, struct vm_area_struct *vma)
 {
@@ -1551,16 +1482,7 @@ static int gasket_mmap_coherent(
 	return 0;
 }
 
-/*
- * Maps a device's BARs into user space.
- * @filp: File structure pointer describing this node usage session.
- * @vma: Standard virtual memory area descriptor.
- *
- * Maps the entirety of each of the device's BAR ranges into the user memory
- * range specified by vma.
- *
- * Returns 0 on success, a negative errno on error.
- */
+/* Map a device's BARs into user space. */
 static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	int i, ret;
@@ -1704,14 +1626,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }
 
-/*
- * Determine the health of the Gasket device.
- * @gasket_dev: Gasket device structure.
- *
- * Checks the underlying device health (via the device_status_cb)
- * and the status of initialized Gasket code systems (currently
- * only interrupts), then returns a gasket_status appropriately.
- */
+/* Determine the health of the Gasket device. */
 static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 {
 	int status;
@@ -1750,14 +1665,10 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 
 /*
  * Gasket ioctl dispatch function.
- * @filp: File structure pointer describing this node usage session.
- * @cmd: ioctl number to handle.
- * @arg: ioctl-specific data pointer.
  *
- * First, checks if the ioctl is a generic ioctl. If not, it passes
- * the ioctl to the ioctl_handler_cb registered in the driver description.
- * If the ioctl is a generic ioctl, the function passes it to the
- * gasket_ioctl_handler in gasket_ioctl.c.
+ * Check if the ioctl is a generic ioctl. If not, pass the ioctl to the
+ * ioctl_handler_cb registered in the driver description.
+ * If the ioctl is a generic ioctl, pass it to gasket_ioctl_handler.
  */
 static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 {
-- 
2.18.0.345.g5c9ce644c3-goog


Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8310C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF8A208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDu+y4tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF8A208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeGaWHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:07:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34058 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbeGaWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:07:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so9636526pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeuGVbuJV/hsVDcewr+5XXqJZ6yqqSWnSo3o3l+EpYY=;
        b=TDu+y4tO10febdXJkMgQ4bOVC8c21VJU+gupb8aZBlzUM6lkeDNUf5e3ipayPS/0hj
         mT0eqVwRTKCL2hliYdxK86eQnnzh75jzF1ofLOwLe/EJQ1u+oa2zedUEKRJ42JgJxNIg
         WmquHseu/sLG26s+/xXRrrUd6LsWgXJQYcCW+yHeOdxYR9ijyEii0gIF3Y6ydIP53QqU
         w8gbIM06e3eUswm7dZrp+DNaxTPOQroA4APBNNJXwb0bT9K9OmmGL9R0sygsYgSemC27
         d6fP/O5AdJv+BvuxBUvb+M9ypwxbfSw0gMny7/zT4rGSTqXWGx64H+TEFsTTXnSYsoTn
         8jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeuGVbuJV/hsVDcewr+5XXqJZ6yqqSWnSo3o3l+EpYY=;
        b=MHV3NcaiMngmtB30+TOuSOv2g9GET9LZyyWTHVr1zUdefQ7P6oSlHVwWq4uRVCd+PC
         745W4CYUAZx1ggQzpDVLGC/gqtdXVsRaycstSCwhcgWBiCt6YbeZt7wdzsfmYRMpTnsI
         v1KzE8w7W908Ef3J/2p+mzexa8RQPXJEtDxXpF+TUq67B5c7Ygz8B9Wx6Yetvgzh5axk
         Lv038nCYPupHctAz/ym0gE82Dpk6GnW71RQlKyeiRsqdaaYV/5ia+TZKUAD29J5y6Iy9
         Js72kJoB4cgPaE1xWVjp3CMxCqqHVhV2kfyK8XhI7QXeQ+AUW12VNAx00b/XZH3P5Duy
         7XBA==
X-Gm-Message-State: AOUpUlGP/VC/mXbrV1FHoCaGSP11uaXcf0hvHHrFO3+odoLBq0GFUbGc
        4WgHLkh+X3K2gOtL92brhGM=
X-Google-Smtp-Source: AAOMgpfQzin23Zbh7lRtigcnB3cLOn/RF2U0hv6x/+ffrmziuwFnrPoo3gMsGGJx8QiilB2M7/JubA==
X-Received: by 2002:a62:3b03:: with SMTP id i3-v6mr23608919pfa.197.1533068717207;
        Tue, 31 Jul 2018 13:25:17 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id t76-v6sm22890129pfe.109.2018.07.31.13.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 13:25:16 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/15] staging: gasket: core: fix function param line continuation style
Date:   Tue, 31 Jul 2018 13:24:39 -0700
Message-Id: <20180731202448.229487-7-toddpoynor@gmail.com>
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

Fix multi-line alignment formatting to look like:
      int ret = long_function_name(device, VARIABLE1, VARIABLE2,
                                   VARIABLE3, VARIABLE4);

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 294 +++++++++++++--------------
 drivers/staging/gasket/gasket_core.h |  68 +++----
 2 files changed, 179 insertions(+), 183 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index b5a7254fbfb3..44344528cd88 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -103,8 +103,9 @@ enum gasket_sysfs_attribute_type {
 };
 
 /* Perform a standard Gasket callback. */
-static inline int check_and_invoke_callback(
-	struct gasket_dev *gasket_dev, int (*cb_function)(struct gasket_dev *))
+static inline int
+check_and_invoke_callback(struct gasket_dev *gasket_dev,
+			  int (*cb_function)(struct gasket_dev *))
 {
 	int ret = 0;
 
@@ -119,8 +120,9 @@ static inline int check_and_invoke_callback(
 }
 
 /* Perform a standard Gasket callback without grabbing gasket_dev->mutex. */
-static inline int gasket_check_and_invoke_callback_nolock(
-	struct gasket_dev *gasket_dev, int (*cb_function)(struct gasket_dev *))
+static inline int
+gasket_check_and_invoke_callback_nolock(struct gasket_dev *gasket_dev,
+					int (*cb_function)(struct gasket_dev *))
 {
 	int ret = 0;
 
@@ -147,8 +149,8 @@ static int gasket_owned_by_current_tgid(struct gasket_cdev_info *info)
  *
  * Returns the located slot number on success or a negative number on failure.
  */
-static int gasket_find_dev_slot(
-	struct gasket_internal_desc *internal_desc, const char *kobj_name)
+static int gasket_find_dev_slot(struct gasket_internal_desc *internal_desc,
+				const char *kobj_name)
 {
 	int i;
 
@@ -186,9 +188,9 @@ static int gasket_find_dev_slot(
  *
  * Returns 0 if successful, a negative error code otherwise.
  */
-static int gasket_alloc_dev(
-	struct gasket_internal_desc *internal_desc, struct device *parent,
-	struct gasket_dev **pdev, const char *kobj_name)
+static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
+			    struct device *parent, struct gasket_dev **pdev,
+			    const char *kobj_name)
 {
 	int dev_idx;
 	const struct gasket_driver_desc *driver_desc =
@@ -228,7 +230,7 @@ static int gasket_alloc_dev(
 		 gasket_dev->dev_idx);
 	dev_info->devt =
 		MKDEV(driver_desc->major, driver_desc->minor +
-			gasket_dev->dev_idx);
+		      gasket_dev->dev_idx);
 	dev_info->device = device_create(internal_desc->class, parent,
 		dev_info->devt, gasket_dev, dev_info->name);
 
@@ -371,8 +373,8 @@ static void gasket_unmap_pci_bar(struct gasket_dev *dev, int bar_num)
  *
  * Returns 0 on success and a negative value otherwise.
  */
-static int gasket_setup_pci(
-	struct pci_dev *pci_dev, struct gasket_dev *gasket_dev)
+static int gasket_setup_pci(struct pci_dev *pci_dev,
+			    struct gasket_dev *gasket_dev)
 {
 	int i, mapped_bars, ret;
 
@@ -421,8 +423,8 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 	const struct gasket_driver_desc *driver_desc =
 		gasket_dev->internal_desc->driver_desc;
 
-	status = gasket_check_and_invoke_callback_nolock(
-		gasket_dev, driver_desc->device_status_cb);
+	status = gasket_check_and_invoke_callback_nolock(gasket_dev,
+							 driver_desc->device_status_cb);
 	if (status != GASKET_STATUS_ALIVE) {
 		dev_dbg(gasket_dev->dev, "Hardware reported status %d.\n",
 			status);
@@ -437,8 +439,7 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 	}
 
 	for (i = 0; i < driver_desc->num_page_tables; ++i) {
-		status = gasket_page_table_system_status(
-			gasket_dev->page_table[i]);
+		status = gasket_page_table_system_status(gasket_dev->page_table[i]);
 		if (status != GASKET_STATUS_ALIVE) {
 			dev_dbg(gasket_dev->dev,
 				"Page table %d reported status %d.\n",
@@ -450,8 +451,10 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 	return GASKET_STATUS_ALIVE;
 }
 
-static ssize_t gasket_write_mappable_regions(
-	char *buf, const struct gasket_driver_desc *driver_desc, int bar_index)
+static ssize_t
+gasket_write_mappable_regions(char *buf,
+			      const struct gasket_driver_desc *driver_desc,
+			      int bar_index)
 {
 	int i;
 	ssize_t written;
@@ -478,8 +481,8 @@ static ssize_t gasket_write_mappable_regions(
 	return total_written;
 }
 
-static ssize_t gasket_sysfs_data_show(
-	struct device *device, struct device_attribute *attr, char *buf)
+static ssize_t gasket_sysfs_data_show(struct device *device,
+				      struct device_attribute *attr, char *buf)
 {
 	int i, ret = 0;
 	ssize_t current_written = 0;
@@ -532,54 +535,49 @@ static ssize_t gasket_sysfs_data_show(
 		}
 		break;
 	case ATTR_DRIVER_VERSION:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n",
-			gasket_dev->internal_desc->driver_desc->driver_version);
+		ret = snprintf(buf, PAGE_SIZE, "%s\n",
+			       gasket_dev->internal_desc->driver_desc->driver_version);
 		break;
 	case ATTR_FRAMEWORK_VERSION:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n", GASKET_FRAMEWORK_VERSION);
+		ret = snprintf(buf, PAGE_SIZE, "%s\n",
+			       GASKET_FRAMEWORK_VERSION);
 		break;
 	case ATTR_DEVICE_TYPE:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n",
-			gasket_dev->internal_desc->driver_desc->name);
+		ret = snprintf(buf, PAGE_SIZE, "%s\n",
+			       gasket_dev->internal_desc->driver_desc->name);
 		break;
 	case ATTR_HARDWARE_REVISION:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n", gasket_dev->hardware_revision);
+		ret = snprintf(buf, PAGE_SIZE, "%d\n",
+			       gasket_dev->hardware_revision);
 		break;
 	case ATTR_PCI_ADDRESS:
 		ret = snprintf(buf, PAGE_SIZE, "%s\n", gasket_dev->kobj_name);
 		break;
 	case ATTR_STATUS:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%s\n",
-			gasket_num_name_lookup(
-				gasket_dev->status, gasket_status_name_table));
+		ret = snprintf(buf, PAGE_SIZE, "%s\n",
+			       gasket_num_name_lookup(gasket_dev->status,
+						      gasket_status_name_table));
 		break;
 	case ATTR_IS_DEVICE_OWNED:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n",
-			gasket_dev->dev_info.ownership.is_owned);
+		ret = snprintf(buf, PAGE_SIZE, "%d\n",
+			       gasket_dev->dev_info.ownership.is_owned);
 		break;
 	case ATTR_DEVICE_OWNER:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n",
-			gasket_dev->dev_info.ownership.owner);
+		ret = snprintf(buf, PAGE_SIZE, "%d\n",
+			       gasket_dev->dev_info.ownership.owner);
 		break;
 	case ATTR_WRITE_OPEN_COUNT:
-		ret = snprintf(
-			buf, PAGE_SIZE, "%d\n",
-			gasket_dev->dev_info.ownership.write_open_count);
+		ret = snprintf(buf, PAGE_SIZE, "%d\n",
+			       gasket_dev->dev_info.ownership.write_open_count);
 		break;
 	case ATTR_RESET_COUNT:
 		ret = snprintf(buf, PAGE_SIZE, "%d\n", gasket_dev->reset_count);
 		break;
 	case ATTR_USER_MEM_RANGES:
 		for (i = 0; i < GASKET_NUM_BARS; ++i) {
-			current_written = gasket_write_mappable_regions(
-				buf, driver_desc, i);
+			current_written =
+				gasket_write_mappable_regions(buf, driver_desc,
+							      i);
 			buf += current_written;
 			ret += current_written;
 		}
@@ -622,9 +620,9 @@ static const struct gasket_sysfs_attribute gasket_sysfs_generic_attrs[] = {
 };
 
 /* Add a char device and related info. */
-static int gasket_add_cdev(
-	struct gasket_cdev_info *dev_info,
-	const struct file_operations *file_ops, struct module *owner)
+static int gasket_add_cdev(struct gasket_cdev_info *dev_info,
+			   const struct file_operations *file_ops,
+			   struct module *owner)
 {
 	int ret;
 
@@ -672,8 +670,8 @@ static void gasket_disable_dev(struct gasket_dev *gasket_dev)
  * Precondition: Called with g_mutex held (to avoid a race on return).
  * Returns NULL if no matching device was found.
  */
-static struct gasket_internal_desc *lookup_internal_desc(
-	struct pci_dev *pci_dev)
+static struct gasket_internal_desc *
+lookup_internal_desc(struct pci_dev *pci_dev)
 {
 	int i;
 
@@ -693,9 +691,9 @@ static struct gasket_internal_desc *lookup_internal_desc(
  * that the provided descriptor/range is of adequate size to hold the range to
  * be mapped.
  */
-static bool gasket_mmap_has_permissions(
-	struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
-	int bar_permissions)
+static bool gasket_mmap_has_permissions(struct gasket_dev *gasket_dev,
+					struct vm_area_struct *vma,
+					int bar_permissions)
 {
 	int requested_permissions;
 	/* Always allow sysadmin to access. */
@@ -735,8 +733,9 @@ static bool gasket_mmap_has_permissions(
  * Verifies that the input address is within the region allocated to coherent
  * buffer.
  */
-static bool gasket_is_coherent_region(
-	const struct gasket_driver_desc *driver_desc, ulong address)
+static bool
+gasket_is_coherent_region(const struct gasket_driver_desc *driver_desc,
+			  ulong address)
 {
 	struct gasket_coherent_buffer_desc coh_buff_desc =
 		driver_desc->coherent_buffer_description;
@@ -750,8 +749,8 @@ static bool gasket_is_coherent_region(
 	return false;
 }
 
-static int gasket_get_bar_index(
-	const struct gasket_dev *gasket_dev, ulong phys_addr)
+static int gasket_get_bar_index(const struct gasket_dev *gasket_dev,
+				ulong phys_addr)
 {
 	int i;
 	const struct gasket_driver_desc *driver_desc;
@@ -786,10 +785,11 @@ static int gasket_get_bar_index(
  *
  * Returns true if there's anything to map, and false otherwise.
  */
-static bool gasket_mm_get_mapping_addrs(
-	const struct gasket_mappable_region *region, ulong bar_offset,
-	ulong requested_length, struct gasket_mappable_region *mappable_region,
-	ulong *virt_offset)
+static bool
+gasket_mm_get_mapping_addrs(const struct gasket_mappable_region *region,
+			    ulong bar_offset, ulong requested_length,
+			    struct gasket_mappable_region *mappable_region,
+			    ulong *virt_offset)
 {
 	ulong range_start = region->start;
 	ulong range_length = region->length_bytes;
@@ -835,8 +835,8 @@ static bool gasket_mm_get_mapping_addrs(
 		 */
 		mappable_region->start = bar_offset;
 		*virt_offset = 0;
-		mappable_region->length_bytes = min(
-			requested_length, range_end - bar_offset);
+		mappable_region->length_bytes =
+			min(requested_length, range_end - bar_offset);
 		return true;
 	}
 
@@ -852,9 +852,9 @@ static bool gasket_mm_get_mapping_addrs(
  * The offset is written into bar_offset on success.
  * Returns zero on success, anything else on error.
  */
-static int gasket_mm_vma_bar_offset(
-	const struct gasket_dev *gasket_dev, const struct vm_area_struct *vma,
-	ulong *bar_offset)
+static int gasket_mm_vma_bar_offset(const struct gasket_dev *gasket_dev,
+				    const struct vm_area_struct *vma,
+				    ulong *bar_offset)
 {
 	ulong raw_offset;
 	int bar_index;
@@ -877,9 +877,9 @@ static int gasket_mm_vma_bar_offset(
 	return 0;
 }
 
-int gasket_mm_unmap_region(
-	const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
-	const struct gasket_mappable_region *map_region)
+int gasket_mm_unmap_region(const struct gasket_dev *gasket_dev,
+			   struct vm_area_struct *vma,
+			   const struct gasket_mappable_region *map_region)
 {
 	ulong bar_offset;
 	ulong virt_offset;
@@ -893,9 +893,9 @@ int gasket_mm_unmap_region(
 	if (ret)
 		return ret;
 
-	if (!gasket_mm_get_mapping_addrs(
-		map_region, bar_offset, vma->vm_end - vma->vm_start,
-		&mappable_region, &virt_offset))
+	if (!gasket_mm_get_mapping_addrs(map_region, bar_offset,
+					 vma->vm_end - vma->vm_start,
+					 &mappable_region, &virt_offset))
 		return 1;
 
 	/*
@@ -904,18 +904,17 @@ int gasket_mm_unmap_region(
 	 *
 	 * Next multiple of y: ceil_div(x, y) * y
 	 */
-	zap_vma_ptes(
-		vma, vma->vm_start + virt_offset,
-		DIV_ROUND_UP(mappable_region.length_bytes, PAGE_SIZE) *
-			PAGE_SIZE);
+	zap_vma_ptes(vma, vma->vm_start + virt_offset,
+		     DIV_ROUND_UP(mappable_region.length_bytes, PAGE_SIZE) *
+		     PAGE_SIZE);
 	return 0;
 }
 EXPORT_SYMBOL(gasket_mm_unmap_region);
 
 /* Maps a virtual address + range to a physical offset of a BAR. */
-static enum do_map_region_status do_map_region(
-	const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
-	struct gasket_mappable_region *mappable_region)
+static enum do_map_region_status
+do_map_region(const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
+	      struct gasket_mappable_region *mappable_region)
 {
 	/* Maximum size of a single call to io_remap_pfn_range. */
 	/* I pulled this number out of thin air. */
@@ -944,10 +943,9 @@ static enum do_map_region_status do_map_region(
 
 	virt_base = vma->vm_start + virt_offset;
 	bar_index =
-		gasket_get_bar_index(
-			gasket_dev,
-			(vma->vm_pgoff << PAGE_SHIFT) +
-				driver_desc->legacy_mmap_address_offset);
+		gasket_get_bar_index(gasket_dev,
+				     (vma->vm_pgoff << PAGE_SHIFT) +
+				     driver_desc->legacy_mmap_address_offset);
 	phys_base = gasket_dev->bar_data[bar_index].phys_base + phys_offset;
 	while (mapped_bytes < map_length) {
 		/*
@@ -957,10 +955,10 @@ static enum do_map_region_status do_map_region(
 		chunk_size = min(max_chunk_size, map_length - mapped_bytes);
 
 		cond_resched();
-		ret = io_remap_pfn_range(
-			vma, virt_base + mapped_bytes,
-			(phys_base + mapped_bytes) >> PAGE_SHIFT,
-			chunk_size, vma->vm_page_prot);
+		ret = io_remap_pfn_range(vma, virt_base + mapped_bytes,
+					 (phys_base + mapped_bytes) >>
+					 PAGE_SHIFT, chunk_size,
+					 vma->vm_page_prot);
 		if (ret) {
 			dev_err(gasket_dev->dev,
 				"Error remapping PFN range.\n");
@@ -984,8 +982,8 @@ static enum do_map_region_status do_map_region(
 }
 
 /* Map a region of coherent memory. */
-static int gasket_mmap_coherent(
-	struct gasket_dev *gasket_dev, struct vm_area_struct *vma)
+static int gasket_mmap_coherent(struct gasket_dev *gasket_dev,
+				struct vm_area_struct *vma)
 {
 	const struct gasket_driver_desc *driver_desc =
 		gasket_dev->internal_desc->driver_desc;
@@ -1008,10 +1006,9 @@ static int gasket_mmap_coherent(
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	ret = remap_pfn_range(
-		vma, vma->vm_start,
-		(gasket_dev->coherent_buffer.phys_base) >> PAGE_SHIFT,
-		requested_length, vma->vm_page_prot);
+	ret = remap_pfn_range(vma, vma->vm_start,
+			      (gasket_dev->coherent_buffer.phys_base) >>
+			      PAGE_SHIFT, requested_length, vma->vm_page_prot);
 	if (ret) {
 		dev_err(gasket_dev->dev, "Error remapping PFN range err=%d.\n",
 			ret);
@@ -1022,9 +1019,9 @@ static int gasket_mmap_coherent(
 	/* Record the user virtual to dma_address mapping that was
 	 * created by the kernel.
 	 */
-	gasket_set_user_virt(
-		gasket_dev, requested_length,
-		gasket_dev->coherent_buffer.phys_base, vma->vm_start);
+	gasket_set_user_virt(gasket_dev, requested_length,
+			     gasket_dev->coherent_buffer.phys_base,
+			     vma->vm_start);
 	return 0;
 }
 
@@ -1058,8 +1055,8 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	raw_offset = (vma->vm_pgoff << PAGE_SHIFT) +
 		driver_desc->legacy_mmap_address_offset;
 	vma_size = vma->vm_end - vma->vm_start;
-	trace_gasket_mmap_entry(
-		gasket_dev->dev_info.name, raw_offset, vma_size);
+	trace_gasket_mmap_entry(gasket_dev->dev_info.name, raw_offset,
+				vma_size);
 
 	/*
 	 * Check if the raw offset is within a bar region. If not, check if it
@@ -1103,8 +1100,10 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 
 	if (driver_desc->get_mappable_regions_cb) {
-		ret = driver_desc->get_mappable_regions_cb(
-			gasket_dev, bar_index, &map_regions, &num_map_regions);
+		ret = driver_desc->get_mappable_regions_cb(gasket_dev,
+							   bar_index,
+							   &map_regions,
+							   &num_map_regions);
 		if (ret)
 			return ret;
 	} else {
@@ -1231,8 +1230,8 @@ static int gasket_open(struct inode *inode, struct file *filp)
 
 	/* If the node is not owned, assign it to the current TGID. */
 	if (!ownership->is_owned) {
-		ret = gasket_check_and_invoke_callback_nolock(
-			gasket_dev, driver_desc->device_open_cb);
+		ret = gasket_check_and_invoke_callback_nolock(gasket_dev,
+							      driver_desc->device_open_cb);
 		if (ret) {
 			dev_err(gasket_dev->dev,
 				"Error in device open cb: %d\n", ret);
@@ -1298,16 +1297,14 @@ static int gasket_release(struct inode *inode, struct file *file)
 			driver_desc->device_reset_cb(gasket_dev, 0);
 
 			for (i = 0; i < driver_desc->num_page_tables; ++i) {
-				gasket_page_table_unmap_all(
-					gasket_dev->page_table[i]);
-				gasket_page_table_garbage_collect(
-					gasket_dev->page_table[i]);
+				gasket_page_table_unmap_all(gasket_dev->page_table[i]);
+				gasket_page_table_garbage_collect(gasket_dev->page_table[i]);
 				gasket_free_coherent_memory_all(gasket_dev, i);
 			}
 
 			/* Closes device, enters power save. */
-			gasket_check_and_invoke_callback_nolock(
-				gasket_dev, driver_desc->device_close_cb);
+			gasket_check_and_invoke_callback_nolock(gasket_dev,
+								driver_desc->device_close_cb);
 		}
 	}
 
@@ -1367,21 +1364,21 @@ static const struct file_operations gasket_file_ops = {
 };
 
 /* Perform final init and marks the device as active. */
-static int gasket_enable_dev(
-	struct gasket_internal_desc *internal_desc,
-	struct gasket_dev *gasket_dev)
+static int gasket_enable_dev(struct gasket_internal_desc *internal_desc,
+			     struct gasket_dev *gasket_dev)
 {
 	int tbl_idx;
 	int ret;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
 
-	ret = gasket_interrupt_init(
-		gasket_dev, driver_desc->name,
-		driver_desc->interrupt_type, driver_desc->interrupts,
-		driver_desc->num_interrupts, driver_desc->interrupt_pack_width,
-		driver_desc->interrupt_bar_index,
-		driver_desc->wire_interrupt_offsets);
+	ret = gasket_interrupt_init(gasket_dev, driver_desc->name,
+				    driver_desc->interrupt_type,
+				    driver_desc->interrupts,
+				    driver_desc->num_interrupts,
+				    driver_desc->interrupt_pack_width,
+				    driver_desc->interrupt_bar_index,
+				    driver_desc->wire_interrupt_offsets);
 	if (ret) {
 		dev_err(gasket_dev->dev,
 			"Critical failure to allocate interrupts: %d\n", ret);
@@ -1392,12 +1389,11 @@ static int gasket_enable_dev(
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		dev_dbg(gasket_dev->dev, "Initializing page table %d.\n",
 			tbl_idx);
-		ret = gasket_page_table_init(
-			&gasket_dev->page_table[tbl_idx],
-			&gasket_dev->bar_data[
-				driver_desc->page_table_bar_index],
-			&driver_desc->page_table_configs[tbl_idx],
-			gasket_dev->dev, gasket_dev->pci_dev);
+		ret = gasket_page_table_init(&gasket_dev->page_table[tbl_idx],
+					     &gasket_dev->bar_data[driver_desc->page_table_bar_index],
+					     &driver_desc->page_table_configs[tbl_idx],
+					     gasket_dev->dev,
+					     gasket_dev->pci_dev);
 		if (ret) {
 			dev_err(gasket_dev->dev,
 				"Couldn't init page table %d: %d\n",
@@ -1415,8 +1411,8 @@ static int gasket_enable_dev(
 	 * hardware_revision_cb returns a positive integer (the rev) if
 	 * successful.)
 	 */
-	ret = check_and_invoke_callback(
-		gasket_dev, driver_desc->hardware_revision_cb);
+	ret = check_and_invoke_callback(gasket_dev,
+					driver_desc->hardware_revision_cb);
 	if (ret < 0) {
 		dev_err(gasket_dev->dev,
 			"Error getting hardware revision: %d\n", ret);
@@ -1436,8 +1432,8 @@ static int gasket_enable_dev(
 	if (gasket_dev->status == GASKET_STATUS_DEAD)
 		dev_err(gasket_dev->dev, "Device reported as unhealthy.\n");
 
-	ret = gasket_add_cdev(
-		&gasket_dev->dev_info, &gasket_file_ops, driver_desc->module);
+	ret = gasket_add_cdev(&gasket_dev->dev_info, &gasket_file_ops,
+			      driver_desc->module);
 	if (ret)
 		return ret;
 
@@ -1452,8 +1448,8 @@ static int gasket_enable_dev(
  *
  * Returns 0 if successful and a negative value otherwise.
  */
-static int gasket_pci_probe(
-	struct pci_dev *pci_dev, const struct pci_device_id *id)
+static int gasket_pci_probe(struct pci_dev *pci_dev,
+			    const struct pci_device_id *id)
 {
 	int ret;
 	const char *kobj_name = dev_name(&pci_dev->dev);
@@ -1497,8 +1493,8 @@ static int gasket_pci_probe(
 		goto fail2;
 	}
 
-	ret = gasket_sysfs_create_mapping(
-		gasket_dev->dev_info.device, gasket_dev);
+	ret = gasket_sysfs_create_mapping(gasket_dev->dev_info.device,
+					  gasket_dev);
 	if (ret)
 		goto fail3;
 
@@ -1513,13 +1509,13 @@ static int gasket_pci_probe(
 			"Cannot create sysfs pci link: %d\n", ret);
 		goto fail3;
 	}
-	ret = gasket_sysfs_create_entries(
-		gasket_dev->dev_info.device, gasket_sysfs_generic_attrs);
+	ret = gasket_sysfs_create_entries(gasket_dev->dev_info.device,
+					  gasket_sysfs_generic_attrs);
 	if (ret)
 		goto fail4;
 
-	ret = check_and_invoke_callback(
-		gasket_dev, driver_desc->sysfs_setup_cb);
+	ret = check_and_invoke_callback(gasket_dev,
+					driver_desc->sysfs_setup_cb);
 	if (ret) {
 		dev_err(gasket_dev->dev, "Error in sysfs setup cb: %d\n", ret);
 		goto fail5;
@@ -1611,8 +1607,8 @@ static void gasket_pci_remove(struct pci_dev *pci_dev)
  *
  *		The table must have a NULL name pointer at the end.
  */
-const char *gasket_num_name_lookup(
-	uint num, const struct gasket_num_name *table)
+const char *gasket_num_name_lookup(uint num,
+				   const struct gasket_num_name *table)
 {
 	uint i = 0;
 
@@ -1677,8 +1673,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 }
 EXPORT_SYMBOL(gasket_reset_nolock);
 
-gasket_ioctl_permissions_cb_t gasket_get_ioctl_permissions_cb(
-	struct gasket_dev *gasket_dev)
+gasket_ioctl_permissions_cb_t
+gasket_get_ioctl_permissions_cb(struct gasket_dev *gasket_dev)
 {
 	return gasket_dev->internal_desc->driver_desc->ioctl_permissions_cb;
 }
@@ -1713,9 +1709,9 @@ struct device *gasket_get_device(struct gasket_dev *dev)
  * Description: Busy waits for a specific combination of bits to be set on a
  * Gasket register.
  **/
-int gasket_wait_with_reschedule(
-	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	uint max_retries, u64 delay_ms)
+int gasket_wait_with_reschedule(struct gasket_dev *gasket_dev, int bar,
+				u64 offset, u64 mask, u64 val,
+				uint max_retries, u64 delay_ms)
 {
 	uint retries = 0;
 	u64 tmp;
@@ -1797,17 +1793,17 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	 * depends on KBUILD_MODNAME, and this is a shared file.
 	 */
 	pr_debug("Registering PCI driver.\n");
-	ret = __pci_register_driver(
-		&internal->pci, driver_desc->module, driver_desc->name);
+	ret = __pci_register_driver(&internal->pci, driver_desc->module,
+				    driver_desc->name);
 	if (ret) {
 		pr_err("cannot register pci driver [ret=%d]\n", ret);
 		goto fail1;
 	}
 
 	pr_debug("Registering char driver.\n");
-	ret = register_chrdev_region(
-		MKDEV(driver_desc->major, driver_desc->minor), GASKET_DEV_MAX,
-		driver_desc->name);
+	ret = register_chrdev_region(MKDEV(driver_desc->major,
+					   driver_desc->minor), GASKET_DEV_MAX,
+				     driver_desc->name);
 	if (ret) {
 		pr_err("cannot register char driver [ret=%d]\n", ret);
 		goto fail2;
@@ -1853,8 +1849,8 @@ void gasket_unregister_device(const struct gasket_driver_desc *driver_desc)
 		return;
 	}
 
-	unregister_chrdev_region(
-		MKDEV(driver_desc->major, driver_desc->minor), GASKET_DEV_MAX);
+	unregister_chrdev_region(MKDEV(driver_desc->major, driver_desc->minor),
+				 GASKET_DEV_MAX);
 
 	pci_unregister_driver(&internal_desc->pci);
 
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 8bd431ad3b58..713bf42de41a 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -318,11 +318,11 @@ struct gasket_dev {
 };
 
 /* Type of the ioctl handler callback. */
-typedef long (*gasket_ioctl_handler_cb_t)
-		(struct file *file, uint cmd, void __user *argp);
+typedef long (*gasket_ioctl_handler_cb_t)(struct file *file, uint cmd,
+					  void __user *argp);
 /* Type of the ioctl permissions check callback. See below. */
-typedef int (*gasket_ioctl_permissions_cb_t)(
-	struct file *filp, uint cmd, void __user *argp);
+typedef int (*gasket_ioctl_permissions_cb_t)(struct file *filp, uint cmd,
+					     void __user *argp);
 
 /*
  * Device type descriptor.
@@ -457,8 +457,8 @@ struct gasket_driver_desc {
 	 * descriptor for an open file is closed. This call is intended to
 	 * handle any per-user or per-fd cleanup.
 	 */
-	int (*device_release_cb)(
-		struct gasket_dev *gasket_dev, struct file *file);
+	int (*device_release_cb)(struct gasket_dev *gasket_dev,
+				 struct file *file);
 
 	/*
 	 * device_close_cb: Callback for when a device node is closed for the
@@ -527,10 +527,10 @@ struct gasket_driver_desc {
 	 * information is then compared to mmap request to determine which
 	 * regions to actually map.
 	 */
-	int (*get_mappable_regions_cb)(
-		struct gasket_dev *gasket_dev, int bar_index,
-		struct gasket_mappable_region **mappable_regions,
-		int *num_mappable_regions);
+	int (*get_mappable_regions_cb)(struct gasket_dev *gasket_dev,
+				       int bar_index,
+				       struct gasket_mappable_region **mappable_regions,
+				       int *num_mappable_regions);
 
 	/*
 	 * ioctl_permissions_cb: Check permissions for generic ioctls.
@@ -631,16 +631,16 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type);
  */
 
 /* Unmaps the specified mappable region from a VMA. */
-int gasket_mm_unmap_region(
-	const struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
-	const struct gasket_mappable_region *map_region);
+int gasket_mm_unmap_region(const struct gasket_dev *gasket_dev,
+			   struct vm_area_struct *vma,
+			   const struct gasket_mappable_region *map_region);
 
 /*
  * Get the ioctl permissions callback.
  * @gasket_dev: Gasket device structure.
  */
-gasket_ioctl_permissions_cb_t gasket_get_ioctl_permissions_cb(
-	struct gasket_dev *gasket_dev);
+gasket_ioctl_permissions_cb_t
+gasket_get_ioctl_permissions_cb(struct gasket_dev *gasket_dev);
 
 /**
  * Lookup a name by number in a num_name table.
@@ -648,37 +648,37 @@ gasket_ioctl_permissions_cb_t gasket_get_ioctl_permissions_cb(
  * @table: Array of num_name structures, the table for the lookup.
  *
  */
-const char *gasket_num_name_lookup(
-	uint num, const struct gasket_num_name *table);
+const char *gasket_num_name_lookup(uint num,
+				   const struct gasket_num_name *table);
 
 /* Handy inlines */
-static inline ulong gasket_dev_read_64(
-	struct gasket_dev *gasket_dev, int bar, ulong location)
+static inline ulong gasket_dev_read_64(struct gasket_dev *gasket_dev, int bar,
+				       ulong location)
 {
 	return readq(&gasket_dev->bar_data[bar].virt_base[location]);
 }
 
-static inline void gasket_dev_write_64(
-	struct gasket_dev *dev, u64 value, int bar, ulong location)
+static inline void gasket_dev_write_64(struct gasket_dev *dev, u64 value,
+				       int bar, ulong location)
 {
 	writeq(value, &dev->bar_data[bar].virt_base[location]);
 }
 
-static inline void gasket_dev_write_32(
-	struct gasket_dev *dev, u32 value, int bar, ulong location)
+static inline void gasket_dev_write_32(struct gasket_dev *dev, u32 value,
+				       int bar, ulong location)
 {
 	writel(value, &dev->bar_data[bar].virt_base[location]);
 }
 
-static inline u32 gasket_dev_read_32(
-	struct gasket_dev *dev, int bar, ulong location)
+static inline u32 gasket_dev_read_32(struct gasket_dev *dev, int bar,
+				     ulong location)
 {
 	return readl(&dev->bar_data[bar].virt_base[location]);
 }
 
-static inline void gasket_read_modify_write_64(
-	struct gasket_dev *dev, int bar, ulong location, u64 value,
-	u64 mask_width, u64 mask_shift)
+static inline void gasket_read_modify_write_64(struct gasket_dev *dev, int bar,
+					       ulong location, u64 value,
+					       u64 mask_width, u64 mask_shift)
 {
 	u64 mask, tmp;
 
@@ -688,9 +688,9 @@ static inline void gasket_read_modify_write_64(
 	gasket_dev_write_64(dev, tmp, bar, location);
 }
 
-static inline void gasket_read_modify_write_32(
-	struct gasket_dev *dev, int bar, ulong location, u32 value,
-	u32 mask_width, u32 mask_shift)
+static inline void gasket_read_modify_write_32(struct gasket_dev *dev, int bar,
+					       ulong location, u32 value,
+					       u32 mask_width, u32 mask_shift)
 {
 	u32 mask, tmp;
 
@@ -707,8 +707,8 @@ const struct gasket_driver_desc *gasket_get_driver_desc(struct gasket_dev *dev);
 struct device *gasket_get_device(struct gasket_dev *dev);
 
 /* Helper function, Asynchronous waits on a given set of bits. */
-int gasket_wait_with_reschedule(
-	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	uint max_retries, u64 delay_ms);
+int gasket_wait_with_reschedule(struct gasket_dev *gasket_dev, int bar,
+				u64 offset, u64 mask, u64 val,
+				uint max_retries, u64 delay_ms);
 
 #endif /* __GASKET_CORE_H__ */
-- 
2.18.0.345.g5c9ce644c3-goog


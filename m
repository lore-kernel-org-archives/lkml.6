Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230224-2-13803299171675091839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230223; b=dClF6Bo11JOmiijw/n4SjBFghnejJJMaObirGI2WiLaMBh/MxL
    ZL4UEkMp/r2u/tR4B9Bnhwb+3kqv34JZ0O2YD68b2bj5OpkH+iIYeIbDKS0Q8ePA
    zJ6CFbhU7UaVgFRlJ96ZaLThngApiUKHECBlYo16a0uouGyFtnyNbkOcOHtI5spG
    ZzVKjk5PW1O+1BuuIC1iGMnZyH+6obE7uvnaisqVJH+3l4fnwDA0Ie2rMiE4RJlW
    Y9whJGZqaUutogfbVyNJR4PEwbmB5XSS5oIPbT6qegi5oAqViAAo2kcgRpxO6DW+
    PIaTH4MZrxpxAsG0TF9e169XLdSWJDSYC0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230223; bh=
    5a/6/2k0XCB5GYijfUUtcVBdCm+sS1B4nxCT50r8t18=; b=CRbCCaHgXUQB8Yap
    Qup5xYgemvOTJzqudMwmuyl4gVIqZE7FwY4iv0PtG28Lyxy/Bb/JhuHK2pHYO4+S
    zZzIXUKKPbBkXgO949dU8+vZDMWR3+joB+4x72eQHMSZQTqlgWDnQCFVMhh6ZpAz
    ErUZhDKTrhys5yBb+HMrn8w2ss4PuNo97hCcISwlfvxL1Cm8ZAitbmkElmVSIggX
    DGoJ0LNXfkTsfe/uGqOyCOUMI5M0tVQjTTuqbgkS83iDqedkDycjC76YKTlT3Rhu
    YTCIIpbKCgNM5stlI/SUvsZ/yH1KFigE/uR5ioI2a+kYMrjkkmXhOl+fpuO9XBau
    wpSAGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNszNPXxRXgVAWa2HyXbHJdwLqsE7VZNpS4u18mbFBGUKyAdRCHlVyKkSqv2pY7Nalpex7zDjtkXv7jJO0hfmqjdDBhcIfNR5hOqvcAok6OvKuoP+lWc
    dzdAjNxG570GiP81oBJY3VQHThmSX+jwqQ8icTHYd7qoSaVDbVOGmKPRy3hOFIoChgtjk3IxhvQI/Qy5RqaYxA3s3U6u4+3VErme7zt68IJL6uNzj+pesAoS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=lv8UENJSWkxc-nshS30A:9 a=-MVNzyC9OVqSXvTM:21
    a=P_67FydXmPAHE84B:21 a=v267Yqbayi0ID-Je:21 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeEBDDA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:03:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbeEBDC6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058672"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v5 28/28] fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support
Date: Wed,  2 May 2018 10:50:31 +0800
Message-Id: <1525229431-3087-29-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DMA memory regions are required for Accelerated Function Unit (AFU) usage.
These two ioctls allow user space applications to map user memory regions
for dma, and unmap them after use. Iova is returned from driver to user
space application via DFL_FPGA_PORT_DMA_MAP ioctl. Application needs to unmap
it after use, otherwise, driver will unmap them in device file release
operation.

Each AFU has its own rb tree to keep track of its mapped DMA regions.

Ioctl interfaces:
* DFL_FPGA_PORT_DMA_MAP
  Do the dma mapping per user_addr and length which provided by user.
  Return iova in provided struct dfl_fpga_port_dma_map.

* DFL_FPGA_PORT_DMA_UNMAP
  Unmap the dma region per iova provided by user.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: moved the code to drivers/fpga folder as suggested by Alan Tull.
    switched to GPLv2 license.
    fixed kbuild warnings.
v3: improved commit description and fixed coding style issues.
    replaced fpga_pdata_to_pcidev with fpga_pdata_to_fpga_cdev
v4: rebase and fix SPDX license issue
v5: rebase, and add DFL_ prefix to IOCTL APIs.
---
 drivers/fpga/Makefile             |   2 +-
 drivers/fpga/dfl-afu-dma-region.c | 463 ++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl-afu-main.c       |  61 ++++-
 drivers/fpga/dfl-afu.h            |  31 ++-
 include/uapi/linux/fpga-dfl.h     |  37 +++
 5 files changed, 591 insertions(+), 3 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-dma-region.c

diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 041e3cd1..dd454ab 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
 obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
-dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o
+dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
new file mode 100644
index 0000000..600fd0c
--- /dev/null
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Accelerated Function Unit (AFU) DMA Region Management
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+
+#include "dfl-afu.h"
+
+static void put_all_pages(struct page **pages, int npages)
+{
+	int i;
+
+	for (i = 0; i < npages; i++)
+		if (pages[i])
+			put_page(pages[i]);
+}
+
+void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
+{
+	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+
+	afu->dma_regions = RB_ROOT;
+}
+
+/**
+ * afu_dma_adjust_locked_vm - adjust locked memory
+ * @dev: port device
+ * @npages: number of pages
+ * @incr: increase or decrease locked memory
+ *
+ * Increase or decrease the locked memory size with npages input.
+ *
+ * Return 0 on success.
+ * Return -ENOMEM if locked memory size is over the limit and no CAP_IPC_LOCK.
+ */
+static int afu_dma_adjust_locked_vm(struct device *dev, long npages, bool incr)
+{
+	unsigned long locked, lock_limit;
+	int ret = 0;
+
+	/* the task is exiting. */
+	if (!current->mm)
+		return 0;
+
+	down_write(&current->mm->mmap_sem);
+
+	if (incr) {
+		locked = current->mm->locked_vm + npages;
+		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+			ret = -ENOMEM;
+		else
+			current->mm->locked_vm += npages;
+	} else {
+		if (WARN_ON_ONCE(npages > current->mm->locked_vm))
+			npages = current->mm->locked_vm;
+		current->mm->locked_vm -= npages;
+	}
+
+	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
+		incr ? '+' : '-', npages << PAGE_SHIFT,
+		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
+		ret ? "- execeeded" : "");
+
+	up_write(&current->mm->mmap_sem);
+
+	return ret;
+}
+
+/**
+ * afu_dma_pin_pages - pin pages of given dma memory region
+ * @pdata: feature device platform data
+ * @region: dma memory region to be pinned
+ *
+ * Pin all the pages of given dfl_afu_dma_region.
+ * Return 0 for success or negative error code.
+ */
+static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
+			     struct dfl_afu_dma_region *region)
+{
+	int npages = region->length >> PAGE_SHIFT;
+	struct device *dev = &pdata->dev->dev;
+	int ret, pinned;
+
+	ret = afu_dma_adjust_locked_vm(dev, npages, true);
+	if (ret)
+		return ret;
+
+	region->pages = kcalloc(npages, sizeof(struct page *), GFP_KERNEL);
+	if (!region->pages) {
+		ret = -ENOMEM;
+		goto unlock_vm;
+	}
+
+	pinned = get_user_pages_fast(region->user_addr, npages, 1,
+				     region->pages);
+	if (pinned < 0) {
+		ret = pinned;
+		goto put_pages;
+	} else if (pinned != npages) {
+		ret = -EFAULT;
+		goto free_pages;
+	}
+
+	dev_dbg(dev, "%d pages pinned\n", pinned);
+
+	return 0;
+
+put_pages:
+	put_all_pages(region->pages, pinned);
+free_pages:
+	kfree(region->pages);
+unlock_vm:
+	afu_dma_adjust_locked_vm(dev, npages, false);
+	return ret;
+}
+
+/**
+ * afu_dma_unpin_pages - unpin pages of given dma memory region
+ * @pdata: feature device platform data
+ * @region: dma memory region to be unpinned
+ *
+ * Unpin all the pages of given dfl_afu_dma_region.
+ * Return 0 for success or negative error code.
+ */
+static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
+				struct dfl_afu_dma_region *region)
+{
+	long npages = region->length >> PAGE_SHIFT;
+	struct device *dev = &pdata->dev->dev;
+
+	put_all_pages(region->pages, npages);
+	kfree(region->pages);
+	afu_dma_adjust_locked_vm(dev, npages, false);
+
+	dev_dbg(dev, "%ld pages unpinned\n", npages);
+}
+
+/**
+ * afu_dma_check_continuous_pages - check if pages are continuous
+ * @region: dma memory region
+ *
+ * Return true if pages of given dma memory region have continuous physical
+ * address, otherwise return false.
+ */
+static bool afu_dma_check_continuous_pages(struct dfl_afu_dma_region *region)
+{
+	int npages = region->length >> PAGE_SHIFT;
+	int i;
+
+	for (i = 0; i < npages - 1; i++)
+		if (page_to_pfn(region->pages[i]) + 1 !=
+				page_to_pfn(region->pages[i + 1]))
+			return false;
+
+	return true;
+}
+
+/**
+ * dma_region_check_iova - check if memory area is fully contained in the region
+ * @region: dma memory region
+ * @iova: address of the dma memory area
+ * @size: size of the dma memory area
+ *
+ * Compare the dma memory area defined by @iova and @size with given dma region.
+ * Return true if memory area is fully contained in the region, otherwise false.
+ */
+static bool dma_region_check_iova(struct dfl_afu_dma_region *region,
+				  u64 iova, u64 size)
+{
+	if (!size && region->iova != iova)
+		return false;
+
+	return (region->iova <= iova) &&
+		(region->length + region->iova >= iova + size);
+}
+
+/**
+ * afu_dma_region_add - add given dma region to rbtree
+ * @pdata: feature device platform data
+ * @region: dma region to be added
+ *
+ * Return 0 for success, -EEXIST if dma region has already been added.
+ *
+ * Needs to be called with pdata->lock heold.
+ */
+static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
+			      struct dfl_afu_dma_region *region)
+{
+	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct rb_node **new, *parent = NULL;
+
+	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n",
+		(unsigned long long)region->iova);
+
+	new = &afu->dma_regions.rb_node;
+
+	while (*new) {
+		struct dfl_afu_dma_region *this;
+
+		this = container_of(*new, struct dfl_afu_dma_region, node);
+
+		parent = *new;
+
+		if (dma_region_check_iova(this, region->iova, region->length))
+			return -EEXIST;
+
+		if (region->iova < this->iova)
+			new = &((*new)->rb_left);
+		else if (region->iova > this->iova)
+			new = &((*new)->rb_right);
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&region->node, parent, new);
+	rb_insert_color(&region->node, &afu->dma_regions);
+
+	return 0;
+}
+
+/**
+ * afu_dma_region_remove - remove given dma region from rbtree
+ * @pdata: feature device platform data
+ * @region: dma region to be removed
+ *
+ * Needs to be called with pdata->lock heold.
+ */
+static void afu_dma_region_remove(struct dfl_feature_platform_data *pdata,
+				  struct dfl_afu_dma_region *region)
+{
+	struct dfl_afu *afu;
+
+	dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
+		(unsigned long long)region->iova);
+
+	afu = dfl_fpga_pdata_get_private(pdata);
+	rb_erase(&region->node, &afu->dma_regions);
+}
+
+/**
+ * afu_dma_region_destroy - destroy all regions in rbtree
+ * @pdata: feature device platform data
+ *
+ * Needs to be called with pdata->lock heold.
+ */
+void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
+{
+	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct rb_node *node = rb_first(&afu->dma_regions);
+	struct dfl_afu_dma_region *region;
+
+	while (node) {
+		region = container_of(node, struct dfl_afu_dma_region, node);
+
+		dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
+			(unsigned long long)region->iova);
+
+		rb_erase(node, &afu->dma_regions);
+
+		if (region->iova)
+			dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+				       region->iova, region->length,
+				       DMA_BIDIRECTIONAL);
+
+		if (region->pages)
+			afu_dma_unpin_pages(pdata, region);
+
+		node = rb_next(node);
+		kfree(region);
+	}
+}
+
+/**
+ * afu_dma_region_find - find the dma region from rbtree based on iova and size
+ * @pdata: feature device platform data
+ * @iova: address of the dma memory area
+ * @size: size of the dma memory area
+ *
+ * It finds the dma region from the rbtree based on @iova and @size:
+ * - if @size == 0, it finds the dma region which starts from @iova
+ * - otherwise, it finds the dma region which fully contains
+ *   [@iova, @iova+size)
+ * If nothing is matched returns NULL.
+ *
+ * Needs to be called with pdata->lock held.
+ */
+struct dfl_afu_dma_region *
+afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
+{
+	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct rb_node *node = afu->dma_regions.rb_node;
+	struct device *dev = &pdata->dev->dev;
+
+	while (node) {
+		struct dfl_afu_dma_region *region;
+
+		region = container_of(node, struct dfl_afu_dma_region, node);
+
+		if (dma_region_check_iova(region, iova, size)) {
+			dev_dbg(dev, "find region (iova = %llx)\n",
+				(unsigned long long)region->iova);
+			return region;
+		}
+
+		if (iova < region->iova)
+			node = node->rb_left;
+		else if (iova > region->iova)
+			node = node->rb_right;
+		else
+			/* the iova region is not fully covered. */
+			break;
+	}
+
+	dev_dbg(dev, "region with iova %llx and size %llx is not found\n",
+		(unsigned long long)iova, (unsigned long long)size);
+
+	return NULL;
+}
+
+/**
+ * afu_dma_region_find_iova - find the dma region from rbtree by iova
+ * @pdata: feature device platform data
+ * @iova: address of the dma region
+ *
+ * Needs to be called with pdata->lock held.
+ */
+static struct dfl_afu_dma_region *
+afu_dma_region_find_iova(struct dfl_feature_platform_data *pdata, u64 iova)
+{
+	return afu_dma_region_find(pdata, iova, 0);
+}
+
+/**
+ * afu_dma_map_region - map memory region for dma
+ * @pdata: feature device platform data
+ * @user_addr: address of the memory region
+ * @length: size of the memory region
+ * @iova: pointer of iova address
+ *
+ * Map memory region defined by @user_addr and @length, and return dma address
+ * of the memory region via @iova.
+ * Return 0 for success, otherwise error code.
+ */
+int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
+		       u64 user_addr, u64 length, u64 *iova)
+{
+	struct dfl_afu_dma_region *region;
+	int ret;
+
+	/*
+	 * Check Inputs, only accept page-aligned user memory region with
+	 * valid length.
+	 */
+	if (!PAGE_ALIGNED(user_addr) || !PAGE_ALIGNED(length) || !length)
+		return -EINVAL;
+
+	/* Check overflow */
+	if (user_addr + length < user_addr)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_WRITE, (void __user *)(unsigned long)user_addr,
+		       length))
+		return -EINVAL;
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->user_addr = user_addr;
+	region->length = length;
+
+	/* Pin the user memory region */
+	ret = afu_dma_pin_pages(pdata, region);
+	if (ret) {
+		dev_err(&pdata->dev->dev, "failed to pin memory region\n");
+		goto free_region;
+	}
+
+	/* Only accept continuous pages, return error else */
+	if (!afu_dma_check_continuous_pages(region)) {
+		dev_err(&pdata->dev->dev, "pages are not continuous\n");
+		ret = -EINVAL;
+		goto unpin_pages;
+	}
+
+	/* As pages are continuous then start to do DMA mapping */
+	region->iova = dma_map_page(dfl_fpga_pdata_to_parent(pdata),
+				    region->pages[0], 0,
+				    region->length,
+				    DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
+		dev_err(&pdata->dev->dev, "failed to map for dma\n");
+		ret = -EFAULT;
+		goto unpin_pages;
+	}
+
+	*iova = region->iova;
+
+	mutex_lock(&pdata->lock);
+	ret = afu_dma_region_add(pdata, region);
+	mutex_unlock(&pdata->lock);
+	if (ret) {
+		dev_err(&pdata->dev->dev, "failed to add dma region\n");
+		goto unmap_dma;
+	}
+
+	return 0;
+
+unmap_dma:
+	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+		       region->iova, region->length, DMA_BIDIRECTIONAL);
+unpin_pages:
+	afu_dma_unpin_pages(pdata, region);
+free_region:
+	kfree(region);
+	return ret;
+}
+
+/**
+ * afu_dma_unmap_region - unmap dma memory region
+ * @pdata: feature device platform data
+ * @iova: dma address of the region
+ *
+ * Unmap dma memory region based on @iova.
+ * Return 0 for success, otherwise error code.
+ */
+int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova)
+{
+	struct dfl_afu_dma_region *region;
+
+	mutex_lock(&pdata->lock);
+	region = afu_dma_region_find_iova(pdata, iova);
+	if (!region) {
+		mutex_unlock(&pdata->lock);
+		return -EINVAL;
+	}
+
+	if (region->in_use) {
+		mutex_unlock(&pdata->lock);
+		return -EBUSY;
+	}
+
+	afu_dma_region_remove(pdata, region);
+	mutex_unlock(&pdata->lock);
+
+	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+		       region->iova, region->length, DMA_BIDIRECTIONAL);
+	afu_dma_unpin_pages(pdata, region);
+	kfree(region);
+
+	return 0;
+}
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index e7024dd..56241b8 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -293,7 +293,11 @@ static int afu_release(struct inode *inode, struct file *filp)
 
 	pdata = dev_get_platdata(&pdev->dev);
 
-	port_reset(pdev);
+	mutex_lock(&pdata->lock);
+	__port_reset(pdev);
+	afu_dma_region_destroy(pdata);
+	mutex_unlock(&pdata->lock);
+
 	dfl_feature_dev_use_end(pdata);
 
 	return 0;
@@ -364,6 +368,55 @@ static long afu_ioctl_get_region_info(struct dfl_feature_platform_data *pdata,
 	return 0;
 }
 
+static long
+afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
+{
+	struct dfl_fpga_port_dma_map map;
+	unsigned long minsz;
+	long ret;
+
+	minsz = offsetofend(struct dfl_fpga_port_dma_map, iova);
+
+	if (copy_from_user(&map, arg, minsz))
+		return -EFAULT;
+
+	if (map.argsz < minsz || map.flags)
+		return -EINVAL;
+
+	ret = afu_dma_map_region(pdata, map.user_addr, map.length, &map.iova);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(arg, &map, sizeof(map))) {
+		afu_dma_unmap_region(pdata, map.iova);
+		return -EFAULT;
+	}
+
+	dev_dbg(&pdata->dev->dev, "dma map: ua=%llx, len=%llx, iova=%llx\n",
+		(unsigned long long)map.user_addr,
+		(unsigned long long)map.length,
+		(unsigned long long)map.iova);
+
+	return 0;
+}
+
+static long
+afu_ioctl_dma_unmap(struct dfl_feature_platform_data *pdata, void __user *arg)
+{
+	struct dfl_fpga_port_dma_unmap unmap;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct dfl_fpga_port_dma_unmap, iova);
+
+	if (copy_from_user(&unmap, arg, minsz))
+		return -EFAULT;
+
+	if (unmap.argsz < minsz || unmap.flags)
+		return -EINVAL;
+
+	return afu_dma_unmap_region(pdata, unmap.iova);
+}
+
 static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct platform_device *pdev = filp->private_data;
@@ -384,6 +437,10 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return afu_ioctl_get_info(pdata, (void __user *)arg);
 	case DFL_FPGA_PORT_GET_REGION_INFO:
 		return afu_ioctl_get_region_info(pdata, (void __user *)arg);
+	case DFL_FPGA_PORT_DMA_MAP:
+		return afu_ioctl_dma_map(pdata, (void __user *)arg);
+	case DFL_FPGA_PORT_DMA_UNMAP:
+		return afu_ioctl_dma_unmap(pdata, (void __user *)arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
@@ -460,6 +517,7 @@ static int afu_dev_init(struct platform_device *pdev)
 	mutex_lock(&pdata->lock);
 	dfl_fpga_pdata_set_private(pdata, afu);
 	afu_mmio_region_init(pdata);
+	afu_dma_region_init(pdata);
 	mutex_unlock(&pdata->lock);
 
 	return 0;
@@ -473,6 +531,7 @@ static int afu_dev_destroy(struct platform_device *pdev)
 	mutex_lock(&pdata->lock);
 	afu = dfl_fpga_pdata_get_private(pdata);
 	afu_mmio_region_destroy(pdata);
+	afu_dma_region_destroy(pdata);
 	dfl_fpga_pdata_set_private(pdata, NULL);
 	mutex_unlock(&pdata->lock);
 
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 7376af9..42d26b9 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -41,11 +41,31 @@ struct dfl_afu_mmio_region {
 };
 
 /**
+ * struct fpga_afu_dma_region - afu DMA region data structure
+ *
+ * @user_addr: region userspace virtual address.
+ * @length: region length.
+ * @iova: region IO virtual address.
+ * @pages: ptr to pages of this region.
+ * @node: rb tree node.
+ * @in_use: flag to indicate if this region is in_use.
+ */
+struct dfl_afu_dma_region {
+	u64 user_addr;
+	u64 length;
+	u64 iova;
+	struct page **pages;
+	struct rb_node node;
+	bool in_use;
+};
+
+/**
  * struct dfl_afu - afu device data structure
  *
  * @region_cur_offset: current region offset from start to the device fd.
  * @num_regions: num of mmio regions.
  * @regions: the mmio region link list of this afu feature device.
+ * @dma_regions: root of dma regions rb tree.
  * @num_umsgs: num of umsgs.
  * @pdata: afu platform device's pdata.
  */
@@ -54,6 +74,7 @@ struct dfl_afu {
 	int num_regions;
 	u8 num_umsgs;
 	struct list_head regions;
+	struct rb_root dma_regions;
 
 	struct dfl_feature_platform_data *pdata;
 };
@@ -68,4 +89,12 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
 int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
 				  u64 offset, u64 size,
 				  struct dfl_afu_mmio_region *pregion);
-#endif
+void afu_dma_region_init(struct dfl_feature_platform_data *pdata);
+void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata);
+int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
+		       u64 user_addr, u64 length, u64 *iova);
+int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova);
+struct dfl_afu_dma_region *
+afu_dma_region_find(struct dfl_feature_platform_data *pdata,
+		    u64 iova, u64 size);
+#endif /* __DFL_AFU_H */
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index 8a7dd5e..77af6c1 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -113,6 +113,43 @@ struct dfl_fpga_port_region_info {
 
 #define DFL_FPGA_PORT_GET_REGION_INFO	_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 2)
 
+/**
+ * DFL_FPGA_PORT_DMA_MAP - _IOWR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 3,
+ *						struct dfl_fpga_port_dma_map)
+ *
+ * Map the dma memory per user_addr and length which are provided by caller.
+ * Driver fills the iova in provided struct afu_port_dma_map.
+ * This interface only accepts page-size aligned user memory for dma mapping.
+ * Return: 0 on success, -errno on failure.
+ */
+struct dfl_fpga_port_dma_map {
+	/* Input */
+	__u32 argsz;		/* Structure length */
+	__u32 flags;		/* Zero for now */
+	__u64 user_addr;        /* Process virtual address */
+	__u64 length;           /* Length of mapping (bytes)*/
+	/* Output */
+	__u64 iova;             /* IO virtual address */
+};
+
+#define DFL_FPGA_PORT_DMA_MAP		_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 3)
+
+/**
+ * DFL_FPGA_PORT_DMA_UNMAP - _IOW(FPGA_MAGIC, PORT_BASE + 4,
+ *						struct dfl_fpga_port_dma_unmap)
+ *
+ * Unmap the dma memory per iova provided by caller.
+ * Return: 0 on success, -errno on failure.
+ */
+struct dfl_fpga_port_dma_unmap {
+	/* Input */
+	__u32 argsz;		/* Structure length */
+	__u32 flags;		/* Zero for now */
+	__u64 iova;		/* IO virtual address */
+};
+
+#define DFL_FPGA_PORT_DMA_UNMAP		_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 4)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
1.8.3.1


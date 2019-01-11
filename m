Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0D720878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eXxrL1Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfAKSGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44014 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbfAKSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5RJs067682;
        Fri, 11 Jan 2019 12:05:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229927;
        bh=Vuobl6L8/SeJAw1nxcVr/vK+1Onj7AR669w5+DEbb48=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eXxrL1NpJsMhgXzepRvPINfsRGgnREW61I0ejKsJ8GJoXmGhijauOfqxTeKQEobzG
         VbPPLIfZD2Uo+bPmY2J/x32XdyNfvVbHfk1siPNdL3G23mzMYs8AXltivyuR/zxmfx
         EPUcbpLQa67lL42tiv7Kp8QdP9GFr31GSw8Kutms=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5RQW008983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:27 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:27 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:27 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5RUc022557;
        Fri, 11 Jan 2019 12:05:27 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5QU07718;
        Fri, 11 Jan 2019 12:05:26 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 03/14] staging: android: ion: Merge ion-ioctl.c into ion.c
Date:   Fri, 11 Jan 2019 12:05:12 -0600
Message-ID: <20190111180523.27862-4-afd@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file ion-ioctl.c is now much to small and tightly integrated
with the main ion.c file to justify keeping it separate. Merge
this file.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/Makefile    |  2 +-
 drivers/staging/android/ion/ion-ioctl.c | 86 -------------------------
 drivers/staging/android/ion/ion.c       | 79 ++++++++++++++++++++++-
 drivers/staging/android/ion/ion.h       |  8 ---
 4 files changed, 78 insertions(+), 97 deletions(-)
 delete mode 100644 drivers/staging/android/ion/ion-ioctl.c

diff --git a/drivers/staging/android/ion/Makefile b/drivers/staging/android/ion/Makefile
index bb30bf8774a0..17f3a7569e3d 100644
--- a/drivers/staging/android/ion/Makefile
+++ b/drivers/staging/android/ion/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_ION) +=	ion.o ion-ioctl.o ion_heap.o
+obj-$(CONFIG_ION) += ion.o ion_heap.o
 obj-$(CONFIG_ION_SYSTEM_HEAP) += ion_system_heap.o ion_page_pool.o
 obj-$(CONFIG_ION_CARVEOUT_HEAP) += ion_carveout_heap.o
 obj-$(CONFIG_ION_CHUNK_HEAP) += ion_chunk_heap.o
diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
deleted file mode 100644
index b366f97a5728..000000000000
--- a/drivers/staging/android/ion/ion-ioctl.c
+++ /dev/null
@@ -1,86 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2011 Google, Inc.
- */
-
-#include <linux/kernel.h>
-#include <linux/file.h>
-#include <linux/fs.h>
-#include <linux/uaccess.h>
-
-#include "ion.h"
-
-union ion_ioctl_arg {
-	struct ion_allocation_data allocation;
-	struct ion_heap_query query;
-};
-
-static int validate_ioctl_arg(unsigned int cmd, union ion_ioctl_arg *arg)
-{
-	switch (cmd) {
-	case ION_IOC_HEAP_QUERY:
-		if (arg->query.reserved0 ||
-		    arg->query.reserved1 ||
-		    arg->query.reserved2)
-			return -EINVAL;
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	int ret = 0;
-	union ion_ioctl_arg data;
-
-	if (_IOC_SIZE(cmd) > sizeof(data))
-		return -EINVAL;
-
-	/*
-	 * The copy_from_user is unconditional here for both read and write
-	 * to do the validate. If there is no write for the ioctl, the
-	 * buffer is cleared
-	 */
-	if (copy_from_user(&data, (void __user *)arg, _IOC_SIZE(cmd)))
-		return -EFAULT;
-
-	ret = validate_ioctl_arg(cmd, &data);
-	if (ret) {
-		pr_warn_once("%s: ioctl validate failed\n", __func__);
-		return ret;
-	}
-
-	if (!(_IOC_DIR(cmd) & _IOC_WRITE))
-		memset(&data, 0, sizeof(data));
-
-	switch (cmd) {
-	case ION_IOC_ALLOC:
-	{
-		int fd;
-
-		fd = ion_alloc(data.allocation.len,
-			       data.allocation.heap_id_mask,
-			       data.allocation.flags);
-		if (fd < 0)
-			return fd;
-
-		data.allocation.fd = fd;
-
-		break;
-	}
-	case ION_IOC_HEAP_QUERY:
-		ret = ion_query_heaps(&data.query);
-		break;
-	default:
-		return -ENOTTY;
-	}
-
-	if (_IOC_DIR(cmd) & _IOC_READ) {
-		if (copy_to_user((void __user *)arg, &data, _IOC_SIZE(cmd)))
-			return -EFAULT;
-	}
-	return ret;
-}
diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index de1ca5e26a4a..2d6d8c0994b2 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -390,7 +390,7 @@ static const struct dma_buf_ops dma_buf_ops = {
 	.unmap = ion_dma_buf_kunmap,
 };
 
-int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
+static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 {
 	struct ion_device *dev = internal_dev;
 	struct ion_buffer *buffer = NULL;
@@ -447,7 +447,7 @@ int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 	return fd;
 }
 
-int ion_query_heaps(struct ion_heap_query *query)
+static int ion_query_heaps(struct ion_heap_query *query)
 {
 	struct ion_device *dev = internal_dev;
 	struct ion_heap_data __user *buffer = u64_to_user_ptr(query->heaps);
@@ -492,6 +492,81 @@ int ion_query_heaps(struct ion_heap_query *query)
 	return ret;
 }
 
+union ion_ioctl_arg {
+	struct ion_allocation_data allocation;
+	struct ion_heap_query query;
+};
+
+static int validate_ioctl_arg(unsigned int cmd, union ion_ioctl_arg *arg)
+{
+	switch (cmd) {
+	case ION_IOC_HEAP_QUERY:
+		if (arg->query.reserved0 ||
+		    arg->query.reserved1 ||
+		    arg->query.reserved2)
+			return -EINVAL;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	int ret = 0;
+	union ion_ioctl_arg data;
+
+	if (_IOC_SIZE(cmd) > sizeof(data))
+		return -EINVAL;
+
+	/*
+	 * The copy_from_user is unconditional here for both read and write
+	 * to do the validate. If there is no write for the ioctl, the
+	 * buffer is cleared
+	 */
+	if (copy_from_user(&data, (void __user *)arg, _IOC_SIZE(cmd)))
+		return -EFAULT;
+
+	ret = validate_ioctl_arg(cmd, &data);
+	if (ret) {
+		pr_warn_once("%s: ioctl validate failed\n", __func__);
+		return ret;
+	}
+
+	if (!(_IOC_DIR(cmd) & _IOC_WRITE))
+		memset(&data, 0, sizeof(data));
+
+	switch (cmd) {
+	case ION_IOC_ALLOC:
+	{
+		int fd;
+
+		fd = ion_alloc(data.allocation.len,
+			       data.allocation.heap_id_mask,
+			       data.allocation.flags);
+		if (fd < 0)
+			return fd;
+
+		data.allocation.fd = fd;
+
+		break;
+	}
+	case ION_IOC_HEAP_QUERY:
+		ret = ion_query_heaps(&data.query);
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_READ) {
+		if (copy_to_user((void __user *)arg, &data, _IOC_SIZE(cmd)))
+			return -EFAULT;
+	}
+	return ret;
+}
+
 static const struct file_operations ion_fops = {
 	.owner          = THIS_MODULE,
 	.unlocked_ioctl = ion_ioctl,
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index ff455fdde1a8..084f246dcfc9 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -205,10 +205,6 @@ int ion_heap_map_user(struct ion_heap *heap, struct ion_buffer *buffer,
 int ion_heap_buffer_zero(struct ion_buffer *buffer);
 int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot);
 
-int ion_alloc(size_t len,
-	      unsigned int heap_id_mask,
-	      unsigned int flags);
-
 /**
  * ion_heap_init_shrinker
  * @heap:		the heap
@@ -330,8 +326,4 @@ void ion_page_pool_free(struct ion_page_pool *pool, struct page *page);
 int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
 			 int nr_to_scan);
 
-long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
-
-int ion_query_heaps(struct ion_heap_query *query);
-
 #endif /* _ION_H */
-- 
2.19.1


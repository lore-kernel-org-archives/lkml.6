Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCB2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9472133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fK7zwxua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbfAKSGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:06:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44022 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbfAKSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5Tl6067691;
        Fri, 11 Jan 2019 12:05:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229929;
        bh=K267lkW4KeQtuZFOzqwIlRDpSn/7/8Az4lTQlhB2Wcs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fK7zwxuay1LxRXBLAG+554Hynre3FPIGbicwuGC5trOn5ISRg/w2zeg6Zywx8JtW9
         lk0LEC3Iuwadrus3nMheATkicrNodz8NOo3Tg+sQKFVAd2gqd83ZYZrnqh02SRPhE3
         W5sDx+aAxtRbt44IiRvm4FGPums2rC2QIb64j4W8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5TNX116676
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:29 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:29 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:29 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5S6I022573;
        Fri, 11 Jan 2019 12:05:28 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5SU07726;
        Fri, 11 Jan 2019 12:05:28 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 05/14] staging: android: ion: Remove struct ion_platform_heap
Date:   Fri, 11 Jan 2019 12:05:14 -0600
Message-ID: <20190111180523.27862-6-afd@ti.com>
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

Now that ION heap registration has been re-worked to not depend on board
files or have a central heap register helper there is no need to have
this data structure. Most of the fields are unused.

Some heap creation helpers are still available that use this to define
the a heap but only use 2 or 3 elements from this struct, just convert
these to get supplied these values from the heap registrar directly.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/ion.h             | 23 -------------------
 .../staging/android/ion/ion_carveout_heap.c   | 12 ++++------
 drivers/staging/android/ion/ion_chunk_heap.c  | 17 ++++++--------
 3 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 084f246dcfc9..2ef78c951a6b 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -21,29 +21,6 @@
 
 #include "../uapi/ion.h"
 
-/**
- * struct ion_platform_heap - defines a heap in the given platform
- * @type:	type of the heap from ion_heap_type enum
- * @id:		unique identifier for heap.  When allocating higher numb ers
- *		will be allocated from first.  At allocation these are passed
- *		as a bit mask and therefore can not exceed ION_NUM_HEAP_IDS.
- * @name:	used for debug purposes
- * @base:	base address of heap in physical memory if applicable
- * @size:	size of the heap in bytes if applicable
- * @priv:	private info passed from the board file
- *
- * Provided by the board file.
- */
-struct ion_platform_heap {
-	enum ion_heap_type type;
-	unsigned int id;
-	const char *name;
-	phys_addr_t base;
-	size_t size;
-	phys_addr_t align;
-	void *priv;
-};
-
 /**
  * struct ion_buffer - metadata for a particular buffer
  * @ref:		reference count
diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index 4a9f9c275654..891f5703220b 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -103,17 +103,14 @@ static struct ion_heap_ops carveout_heap_ops = {
 	.unmap_kernel = ion_heap_unmap_kernel,
 };
 
-struct ion_heap *ion_carveout_heap_create(struct ion_platform_heap *heap_data)
+struct ion_heap *ion_carveout_heap_create(phys_addr_t base, size_t size)
 {
 	struct ion_carveout_heap *carveout_heap;
 	int ret;
 
 	struct page *page;
-	size_t size;
-
-	page = pfn_to_page(PFN_DOWN(heap_data->base));
-	size = heap_data->size;
 
+	page = pfn_to_page(PFN_DOWN(base));
 	ret = ion_heap_pages_zero(page, size, pgprot_writecombine(PAGE_KERNEL));
 	if (ret)
 		return ERR_PTR(ret);
@@ -127,9 +124,8 @@ struct ion_heap *ion_carveout_heap_create(struct ion_platform_heap *heap_data)
 		kfree(carveout_heap);
 		return ERR_PTR(-ENOMEM);
 	}
-	carveout_heap->base = heap_data->base;
-	gen_pool_add(carveout_heap->pool, carveout_heap->base, heap_data->size,
-		     -1);
+	carveout_heap->base = base;
+	gen_pool_add(carveout_heap->pool, carveout_heap->base, size, -1);
 	carveout_heap->heap.ops = &carveout_heap_ops;
 	carveout_heap->heap.type = ION_HEAP_TYPE_CARVEOUT;
 	carveout_heap->heap.flags = ION_HEAP_FLAG_DEFER_FREE;
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 5a8917d9beac..c2321a047f0f 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -108,16 +108,13 @@ static struct ion_heap_ops chunk_heap_ops = {
 	.unmap_kernel = ion_heap_unmap_kernel,
 };
 
-struct ion_heap *ion_chunk_heap_create(struct ion_platform_heap *heap_data)
+struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size)
 {
 	struct ion_chunk_heap *chunk_heap;
 	int ret;
 	struct page *page;
-	size_t size;
-
-	page = pfn_to_page(PFN_DOWN(heap_data->base));
-	size = heap_data->size;
 
+	page = pfn_to_page(PFN_DOWN(base));
 	ret = ion_heap_pages_zero(page, size, pgprot_writecombine(PAGE_KERNEL));
 	if (ret)
 		return ERR_PTR(ret);
@@ -126,23 +123,23 @@ struct ion_heap *ion_chunk_heap_create(struct ion_platform_heap *heap_data)
 	if (!chunk_heap)
 		return ERR_PTR(-ENOMEM);
 
-	chunk_heap->chunk_size = (unsigned long)heap_data->priv;
+	chunk_heap->chunk_size = chunk_size;
 	chunk_heap->pool = gen_pool_create(get_order(chunk_heap->chunk_size) +
 					   PAGE_SHIFT, -1);
 	if (!chunk_heap->pool) {
 		ret = -ENOMEM;
 		goto error_gen_pool_create;
 	}
-	chunk_heap->base = heap_data->base;
-	chunk_heap->size = heap_data->size;
+	chunk_heap->base = base;
+	chunk_heap->size = size;
 	chunk_heap->allocated = 0;
 
-	gen_pool_add(chunk_heap->pool, chunk_heap->base, heap_data->size, -1);
+	gen_pool_add(chunk_heap->pool, chunk_heap->base, size, -1);
 	chunk_heap->heap.ops = &chunk_heap_ops;
 	chunk_heap->heap.type = ION_HEAP_TYPE_CHUNK;
 	chunk_heap->heap.flags = ION_HEAP_FLAG_DEFER_FREE;
 	pr_debug("%s: base %pa size %zu\n", __func__,
-		 &chunk_heap->base, heap_data->size);
+		 &chunk_heap->base, size);
 
 	return &chunk_heap->heap;
 
-- 
2.19.1


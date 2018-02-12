Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1166103-1518432777-2-6410492352418281052
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518432776; b=c2KmBQbp2RiCqggsNju7L21flfeJImzXq9Zhu2YMWC2oPck
    a78JmDk/K6A5Vjk4zGvS8f2IyislIfN7/VNHCWzlLvxu50rAcG8FElWlY895Aw/9
    xfGXM4bhHj+IncL5rRuMQ+gS3Gpl1dpl533+/SKB19qnSft4Njie0tejcYIX02Lf
    m9SEH48S9Knd6C6yYEMpG8IywTSGVGHpTyFgA0oknoHEYbaIJrmWYgBqv/nPrwHM
    FNLk6r+7ZTYHhE/xFrvOqM+sRDfbPrUNa1ry08tlO0HK/tTAQzpUeMpf+mh0WWNZ
    kjn6v0plR5JNI8dJHkax3SJT+qxJ9DzJZnWFVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518432776; bh=G
    VU3iLfAv4g5E5XWv1dCprzAgkeTFWfw7BA2kBXkhOc=; b=l1bT9l9F5D20FDpz1
    +0ZCuFYCsaNyAvZ2mYxZ+sx8r7+4y+L02iXpK7vMPdNF1qKZ4WiVmQlDOpNpOsR1
    U2bXhQKbpI5S9fJ2neBXDyleuVuTLG6W3R6EgC2mnvn0whRpu9YkrXpPkwr1FWlw
    KWLFvZD/oqWQbwpwB08+ke6H1XrwowXGLXTC68Y5wnspniP9aEBsgixuU6m03i0a
    7/tlRzkGQ/RrugE9gHSE5TtK3UmaXAzdMDH/GBrbmCPcmly9eDNEBIqbIzc4la6c
    P40T6d4B7AVbhNyXfWtKCCgpib0dtGatbhuw8ks1Pe9uXocGZnnruFmPKETSLlbB
    QpKjw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>,
 <sumit.semwal@linaro.org>
Subject: [PATCH v2 9/9] staging: android: ion: Combine cache and uncache pools
Date: Mon, 12 Feb 2018 18:43:14 +0800
Message-ID: <1518432194-41536-10-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Yisheng Xie <xieyisheng1@huawei.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now we call dma_map in the dma_buf API callbacks and handle explicit
caching by the dma_buf sync API, which make cache and uncache pools
in the same handling flow, which can be combined.

Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion.c             |  5 --
 drivers/staging/android/ion/ion.h             | 13 +----
 drivers/staging/android/ion/ion_page_pool.c   |  5 +-
 drivers/staging/android/ion/ion_system_heap.c | 76 +++++----------------------
 4 files changed, 16 insertions(+), 83 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 461b193..c094be2 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -33,11 +33,6 @@
 static struct ion_device *internal_dev;
 static int heap_id;
 
-bool ion_buffer_cached(struct ion_buffer *buffer)
-{
-	return !!(buffer->flags & ION_FLAG_CACHED);
-}
-
 /* this function should only be called while dev->lock is held */
 static void ion_buffer_add(struct ion_device *dev,
 			   struct ion_buffer *buffer)
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 1bc443f..ea08978 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -185,14 +185,6 @@ struct ion_heap {
 };
 
 /**
- * ion_buffer_cached - this ion buffer is cached
- * @buffer:		buffer
- *
- * indicates whether this ion buffer is cached
- */
-bool ion_buffer_cached(struct ion_buffer *buffer);
-
-/**
  * ion_device_add_heap - adds a heap to the ion device
  * @heap:		the heap to add
  */
@@ -302,7 +294,6 @@ size_t ion_heap_freelist_shrink(struct ion_heap *heap,
  * @gfp_mask:		gfp_mask to use from alloc
  * @order:		order of pages in the pool
  * @list:		plist node for list of pools
- * @cached:		it's cached pool or not
  *
  * Allows you to keep a pool of pre allocated pages to use from your heap.
  * Keeping a pool of pages that is ready for dma, ie any cached mapping have
@@ -312,7 +303,6 @@ size_t ion_heap_freelist_shrink(struct ion_heap *heap,
 struct ion_page_pool {
 	int high_count;
 	int low_count;
-	bool cached;
 	struct list_head high_items;
 	struct list_head low_items;
 	struct mutex mutex;
@@ -321,8 +311,7 @@ struct ion_page_pool {
 	struct plist_node list;
 };
 
-struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int order,
-					   bool cached);
+struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int order);
 void ion_page_pool_destroy(struct ion_page_pool *pool);
 struct page *ion_page_pool_alloc(struct ion_page_pool *pool);
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page);
diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 6d2caf0..db8f614 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -123,8 +123,7 @@ int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
 	return freed;
 }
 
-struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int order,
-					   bool cached)
+struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int order)
 {
 	struct ion_page_pool *pool = kmalloc(sizeof(*pool), GFP_KERNEL);
 
@@ -138,8 +137,6 @@ struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int order,
 	pool->order = order;
 	mutex_init(&pool->mutex);
 	plist_node_init(&pool->list, order);
-	if (cached)
-		pool->cached = true;
 
 	return pool;
 }
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index bc19cdd..701eb9f 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -41,31 +41,16 @@ static inline unsigned int order_to_size(int order)
 
 struct ion_system_heap {
 	struct ion_heap heap;
-	struct ion_page_pool *uncached_pools[NUM_ORDERS];
-	struct ion_page_pool *cached_pools[NUM_ORDERS];
+	struct ion_page_pool *pools[NUM_ORDERS];
 };
 
-/**
- * The page from page-pool are all zeroed before. We need do cache
- * clean for cached buffer. The uncached buffer are always non-cached
- * since it's allocated. So no need for non-cached pages.
- */
 static struct page *alloc_buffer_page(struct ion_system_heap *heap,
 				      struct ion_buffer *buffer,
 				      unsigned long order)
 {
-	bool cached = ion_buffer_cached(buffer);
-	struct ion_page_pool *pool;
-	struct page *page;
+	struct ion_page_pool *pool = heap->pools[order_to_index(order)];
 
-	if (!cached)
-		pool = heap->uncached_pools[order_to_index(order)];
-	else
-		pool = heap->cached_pools[order_to_index(order)];
-
-	page = ion_page_pool_alloc(pool);
-
-	return page;
+	return ion_page_pool_alloc(pool);
 }
 
 static void free_buffer_page(struct ion_system_heap *heap,
@@ -73,7 +58,6 @@ static void free_buffer_page(struct ion_system_heap *heap,
 {
 	struct ion_page_pool *pool;
 	unsigned int order = compound_order(page);
-	bool cached = ion_buffer_cached(buffer);
 
 	/* go to system */
 	if (buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE) {
@@ -81,10 +65,7 @@ static void free_buffer_page(struct ion_system_heap *heap,
 		return;
 	}
 
-	if (!cached)
-		pool = heap->uncached_pools[order_to_index(order)];
-	else
-		pool = heap->cached_pools[order_to_index(order)];
+	pool = heap->pools[order_to_index(order)];
 
 	ion_page_pool_free(pool, page);
 }
@@ -190,8 +171,7 @@ static void ion_system_heap_free(struct ion_buffer *buffer)
 static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
 				  int nr_to_scan)
 {
-	struct ion_page_pool *uncached_pool;
-	struct ion_page_pool *cached_pool;
+	struct ion_page_pool *pool;
 	struct ion_system_heap *sys_heap;
 	int nr_total = 0;
 	int i, nr_freed;
@@ -203,26 +183,15 @@ static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
 		only_scan = 1;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
-		uncached_pool = sys_heap->uncached_pools[i];
-		cached_pool = sys_heap->cached_pools[i];
+		pool = sys_heap->pools[i];
 
 		if (only_scan) {
-			nr_total += ion_page_pool_shrink(uncached_pool,
+			nr_total += ion_page_pool_shrink(pool,
 							 gfp_mask,
 							 nr_to_scan);
 
-			nr_total += ion_page_pool_shrink(cached_pool,
-							 gfp_mask,
-							 nr_to_scan);
 		} else {
-			nr_freed = ion_page_pool_shrink(uncached_pool,
-							gfp_mask,
-							nr_to_scan);
-			nr_to_scan -= nr_freed;
-			nr_total += nr_freed;
-			if (nr_to_scan <= 0)
-				break;
-			nr_freed = ion_page_pool_shrink(cached_pool,
+			nr_freed = ion_page_pool_shrink(pool,
 							gfp_mask,
 							nr_to_scan);
 			nr_to_scan -= nr_freed;
@@ -253,26 +222,16 @@ static int ion_system_heap_debug_show(struct ion_heap *heap, struct seq_file *s,
 	struct ion_page_pool *pool;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
-		pool = sys_heap->uncached_pools[i];
+		pool = sys_heap->pools[i];
 
-		seq_printf(s, "%d order %u highmem pages uncached %lu total\n",
+		seq_printf(s, "%d order %u highmem pages %lu total\n",
 			   pool->high_count, pool->order,
 			   (PAGE_SIZE << pool->order) * pool->high_count);
-		seq_printf(s, "%d order %u lowmem pages uncached %lu total\n",
+		seq_printf(s, "%d order %u lowmem pages %lu total\n",
 			   pool->low_count, pool->order,
 			   (PAGE_SIZE << pool->order) * pool->low_count);
 	}
 
-	for (i = 0; i < NUM_ORDERS; i++) {
-		pool = sys_heap->cached_pools[i];
-
-		seq_printf(s, "%d order %u highmem pages cached %lu total\n",
-			   pool->high_count, pool->order,
-			   (PAGE_SIZE << pool->order) * pool->high_count);
-		seq_printf(s, "%d order %u lowmem pages cached %lu total\n",
-			   pool->low_count, pool->order,
-			   (PAGE_SIZE << pool->order) * pool->low_count);
-	}
 	return 0;
 }
 
@@ -285,8 +244,7 @@ static void ion_system_heap_destroy_pools(struct ion_page_pool **pools)
 			ion_page_pool_destroy(pools[i]);
 }
 
-static int ion_system_heap_create_pools(struct ion_page_pool **pools,
-					bool cached)
+static int ion_system_heap_create_pools(struct ion_page_pool **pools)
 {
 	int i;
 	gfp_t gfp_flags = low_order_gfp_flags;
@@ -297,7 +255,7 @@ static int ion_system_heap_create_pools(struct ion_page_pool **pools,
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;
 
-		pool = ion_page_pool_create(gfp_flags, orders[i], cached);
+		pool = ion_page_pool_create(gfp_flags, orders[i]);
 		if (!pool)
 			goto err_create_pool;
 		pools[i] = pool;
@@ -320,18 +278,12 @@ static struct ion_heap *__ion_system_heap_create(void)
 	heap->heap.type = ION_HEAP_TYPE_SYSTEM;
 	heap->heap.flags = ION_HEAP_FLAG_DEFER_FREE;
 
-	if (ion_system_heap_create_pools(heap->uncached_pools, false))
+	if (ion_system_heap_create_pools(heap->pools))
 		goto free_heap;
 
-	if (ion_system_heap_create_pools(heap->cached_pools, true))
-		goto destroy_uncached_pools;
-
 	heap->heap.debug_show = ion_system_heap_debug_show;
 	return &heap->heap;
 
-destroy_uncached_pools:
-	ion_system_heap_destroy_pools(heap->uncached_pools);
-
 free_heap:
 	kfree(heap);
 	return ERR_PTR(-ENOMEM);
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

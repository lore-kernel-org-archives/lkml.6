Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1971162-1519881517-4-1816429442705754296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-15', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519881516; b=hLPdlJiRQLDyOEwzKK4re6ghT5FCUOgIcoPy4fmZrTLzeYL
    XGyPi7aL9TtJFDhp3tAKejGYkt8fiTsTeixB/bQ+mwb6We0NSVbwhfT/DpTUrwWc
    U5KId3gh12pIOvW+OJrdWfUOK4+Fv3iCr3cWiFDQO8MnhDcO9WPZHs9QCX7KkH7E
    DANuHYIX0vq2m32qnUeWNY3C2mg2W43ELnMLOM6Y38DZWB8cx5dDmeq1Maf/AP3Z
    Y0Ny81P8qkijHmBXCueU54GD2tFsx9WSKQwsT9AFz1bCrUmd6bLCxccvPi+RnaBk
    4MkGaaB24lxM1S7nQrEMewI2RMjYzFt132rATWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519881516; bh=j
    SLuOs1yIV5xQKzJQuspK19mITzHsIpp/r8hntEIpOE=; b=szF9bUkecQf1yQT/X
    Ifu1NU3W30HhXXVbw+aNYhXnMd7I6ibDAjQ0dm/sZu5j6skPOldPPnj565SVxi53
    BLedV4Bl2sbk6K5bMkW/bFi3qFGKx+GLZknEVX+rln2l5cCpWPe7poqW4183p3OD
    PynO3P3PamEGFv+6bYqefeb87f+vXZvcq5WuMa4lqyyq96pEYUrmi9h08zO/IvM/
    YdPw0Leh4O88a+alxczAAjUpmMbcwEOLgVhhVMVANq1juAHH+IDU2Ae5HXM6r2/B
    dKT28lRmT4Hlh4ZBjvFdulFqsIvBki1fhF+M198O+5sig+1dau5PZtYHNA0uQ0U0
    kNYNw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=OsuW9qQT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=nH2mmTPB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=OsuW9qQT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=nH2mmTPB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33E2B60117
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Wed, 28 Feb 2018 21:18:27 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [RFC] android: ion: How to properly clean caches for uncached
 allocations
Message-ID: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The issue:

Currently in ION if you allocate uncached memory it is possible that there
are still dirty lines in the cache.  And often these dirty lines in the
cache are the zeros which were meant to clear out any sensitive kernel
data.

What this means is that if you allocate uncached memory from ION, and then
subsequently write to that buffer (using the uncached mapping you are
provided by ION) then the data you have written could be corrupted at some
point in the future if a dirty line is evicted from the cache.

Also this means there is a potential security issue.  If an un-privileged
userspace user allocated uncached memory (for example from the system heap)
and then if they were to read from that buffer (through the un-cached
mapping they are provided by ION), and if some of the zeros which were
written to that memory are still in the cache then this un-privileged
userspace user could read potentially sensitive kernel data.


An unacceptable fix:

I have included some sample code which should resolve this issue for the
system heap and the cma heap on some architectures, however this code
would not be acceptable for upstreaming since it uses hacks to clean
the cache.
Similar changes would need to be made to carveout heap and chunk heap.

I would appreciate some feedback on the proper way for ION to clean the
caches for memory it has allocated that is intended for uncached access.

I realize that it may be tempting, as a solution to this problem, to
simply strip uncached support from ION. I hope that we can try to find a
solution which preserves uncached memory support as ION uncached memory
is often used (though perhaps not in upstreamed code) in cases such as
multimedia use cases where there is no CPU access required, in secure
heap allocations, and in some cases where there is minimal CPU access
and therefore uncached memory performs better.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 drivers/staging/android/ion/ion.c             | 16 ++++++++++++++++
 drivers/staging/android/ion/ion.h             |  5 ++++-
 drivers/staging/android/ion/ion_cma_heap.c    |  3 +++
 drivers/staging/android/ion/ion_page_pool.c   |  8 ++++++--
 drivers/staging/android/ion/ion_system_heap.c |  7 ++++++-
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 57e0d8035b2e..10e967b0a0f4 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -38,6 +38,22 @@ bool ion_buffer_cached(struct ion_buffer *buffer)
 	return !!(buffer->flags & ION_FLAG_CACHED);
 }
 
+void ion_pages_sync_for_device(struct page *page, size_t size,
+			       enum dma_data_direction dir)
+{
+	struct scatterlist sg;
+	struct device dev = {0};
+
+	/* hack, use dummy device */
+	arch_setup_dma_ops(&dev, 0, 0, NULL, false);
+
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, page, size, 0);
+	/* hack, use phys address for dma address */
+	sg_dma_address(&sg) = page_to_phys(page);
+	dma_sync_sg_for_device(&dev, &sg, 1, dir);
+}
+
 /* this function should only be called while dev->lock is held */
 static void ion_buffer_add(struct ion_device *dev,
 			   struct ion_buffer *buffer)
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index a238f23c9116..227b9928d185 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -192,6 +192,9 @@ struct ion_heap {
  */
 bool ion_buffer_cached(struct ion_buffer *buffer);
 
+void ion_pages_sync_for_device(struct page *page, size_t size,
+			       enum dma_data_direction dir);
+
 /**
  * ion_buffer_fault_user_mappings - fault in user mappings of this buffer
  * @buffer:		buffer
@@ -333,7 +336,7 @@ struct ion_page_pool {
 struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int order,
 					   bool cached);
 void ion_page_pool_destroy(struct ion_page_pool *pool);
-struct page *ion_page_pool_alloc(struct ion_page_pool *pool);
+struct page *ion_page_pool_alloc(struct ion_page_pool *pool, bool *from_pool);
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page);
 
 /** ion_page_pool_shrink - shrinks the size of the memory cached in the pool
diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
index 49718c96bf9e..82e80621d114 100644
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -59,6 +59,9 @@ static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
 		memset(page_address(pages), 0, size);
 	}
 
+	if (!ion_buffer_cached(buffer))
+		ion_pages_sync_for_device(pages, size, DMA_BIDIRECTIONAL);
+
 	table = kmalloc(sizeof(*table), GFP_KERNEL);
 	if (!table)
 		goto err;
diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index b3017f12835f..169a321778ed 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -63,7 +63,7 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 	return page;
 }
 
-struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
+struct page *ion_page_pool_alloc(struct ion_page_pool *pool, bool *from_pool)
 {
 	struct page *page = NULL;
 
@@ -76,8 +76,12 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 		page = ion_page_pool_remove(pool, false);
 	mutex_unlock(&pool->mutex);
 
-	if (!page)
+	if (!page) {
 		page = ion_page_pool_alloc_pages(pool);
+		*from_pool = false;
+	} else {
+		*from_pool = true;
+	}
 
 	return page;
 }
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index bc19cdd30637..3bb4604e032b 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -57,13 +57,18 @@ static struct page *alloc_buffer_page(struct ion_system_heap *heap,
 	bool cached = ion_buffer_cached(buffer);
 	struct ion_page_pool *pool;
 	struct page *page;
+	bool from_pool;
 
 	if (!cached)
 		pool = heap->uncached_pools[order_to_index(order)];
 	else
 		pool = heap->cached_pools[order_to_index(order)];
 
-	page = ion_page_pool_alloc(pool);
+	page = ion_page_pool_alloc(pool, &from_pool);
+
+	if (!from_pool && !ion_buffer_cached(buffer))
+		ion_pages_sync_for_device(page, PAGE_SIZE << order,
+					  DMA_BIDIRECTIONAL);
 
 	return page;
 }
-- 
1.8.5.2


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

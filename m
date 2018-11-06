Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0142420869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyATRpiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0142420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbeKGC5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:57:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40520 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbeKGC5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:57:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so12991726wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/p1C2en6WkzqyYzwqhfMVjEjLC8W2pVad1SwIjalI/E=;
        b=nyATRpiWBqngCu7QjqO4XXK83FQNZsKfFPf57sCtgHvviu7PArkTLdMehdnK7dHHpD
         9MxiAaBO4bPn5jc383fEGPwHVoeqd1cUxa3eRgNWOHflu7CQyq6OPT1H9TgdwRQ9PguD
         vzoksX95HHp9ASrKwM8AFZm1E9S3cfhUxtUSjhWcwW3G0g8aQJJwk+2wS8PGHJDgdKcR
         VE0ke2Wn47WQYQeWqf7VVhqBrfWhVaGtkYM6I5MbsoMQKVc1GsICbypziDotFiYyoeVs
         PT9kNAEsF6gWVs8+I4JWnU3Ibc5nzd8GP3VrsxoI7HapbLf/O04EgTyNhCrD4SwpYwUi
         wPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/p1C2en6WkzqyYzwqhfMVjEjLC8W2pVad1SwIjalI/E=;
        b=tamHcZvARnu7Vr2GFn39zWrc4tWPTREdVebls6rirVT9jYtbaCl3WFj/b+aS8KksyX
         jvz4gpX/UOEzgcVw81rvkUy4Px51Nowy9E+czvMkfy3VVTIi7s897cX3BVmv41V8eE4M
         60hqU3H6iMSrDZUqn/k2EbugI9zIVfIIilMp887IolE2M35SHG0KbdB6OL/hOpbIaegk
         oM91MAgRiVSzIqICHnQVyXH0lktNLbFjLBclbi6/X13m/VB049SQ03d/0ZqQcmEYGrEP
         +JAWOfdgPcQ15elGOvY96v+oDn6NWAXbFDRFMZipgun4Bp8eBH6+tFVvuC0cv4ndDyQQ
         Dgvw==
X-Gm-Message-State: AGRZ1gKWmXreMyRrXhJ0I17qItOJVSUV5Bz18RnfI1Hm/fgPbkvegzmj
        rtAYm9N39OgGQKdi+MZn6uHgWA==
X-Google-Smtp-Source: AJdET5cvicvjmlptbgumfF3UL9OrRHXGli3dXE/sunjhu8/9FdOLTQfSyPlfueW9q0xTTyQWW1eaQQ==
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr2902444wme.108.1541525442372;
        Tue, 06 Nov 2018 09:30:42 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z17-v6sm16328416wrm.65.2018.11.06.09.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:30:41 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 01/22] kasan, mm: change hooks signatures
Date:   Tue,  6 Nov 2018 18:30:16 +0100
Message-Id: <bdc446e1248f16e9d616628482da0c888ddb8463.1541525354.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag-based KASAN changes the value of the top byte of pointers returned
from the kernel allocation functions (such as kmalloc). This patch updates
KASAN hooks signatures and their usage in SLAB and SLUB code to reflect
that.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 43 +++++++++++++++++++++++++++++--------------
 include/linux/slab.h  |  4 ++--
 mm/kasan/kasan.c      | 30 ++++++++++++++++++------------
 mm/slab.c             | 12 ++++++------
 mm/slab.h             |  2 +-
 mm/slab_common.c      |  4 ++--
 mm/slub.c             | 15 +++++++--------
 7 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 46aae129917c..52c86a568a4e 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -51,16 +51,16 @@ void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_poison_slab(struct page *page);
 void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
 void kasan_poison_object_data(struct kmem_cache *cache, void *object);
-void kasan_init_slab_obj(struct kmem_cache *cache, const void *object);
+void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object);
 
-void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
+void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
 void kasan_kfree_large(void *ptr, unsigned long ip);
 void kasan_poison_kfree(void *ptr, unsigned long ip);
-void kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
+void *kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
 		  gfp_t flags);
-void kasan_krealloc(const void *object, size_t new_size, gfp_t flags);
+void *kasan_krealloc(const void *object, size_t new_size, gfp_t flags);
 
-void kasan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
+void *kasan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
 bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
 
 struct kasan_cache {
@@ -105,19 +105,34 @@ static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
 static inline void kasan_poison_object_data(struct kmem_cache *cache,
 					void *object) {}
-static inline void kasan_init_slab_obj(struct kmem_cache *cache,
-				const void *object) {}
+static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
+				const void *object)
+{
+	return (void *)object;
+}
 
-static inline void kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags) {}
+static inline void *kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags)
+{
+	return ptr;
+}
 static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
 static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
-static inline void kasan_kmalloc(struct kmem_cache *s, const void *object,
-				size_t size, gfp_t flags) {}
-static inline void kasan_krealloc(const void *object, size_t new_size,
-				 gfp_t flags) {}
+static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
+				size_t size, gfp_t flags)
+{
+	return (void *)object;
+}
+static inline void *kasan_krealloc(const void *object, size_t new_size,
+				 gfp_t flags)
+{
+	return (void *)object;
+}
 
-static inline void kasan_slab_alloc(struct kmem_cache *s, void *object,
-				   gfp_t flags) {}
+static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
+				   gfp_t flags)
+{
+	return object;
+}
 static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 				   unsigned long ip)
 {
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374e7156..351ac48dabc4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -444,7 +444,7 @@ static __always_inline void *kmem_cache_alloc_trace(struct kmem_cache *s,
 {
 	void *ret = kmem_cache_alloc(s, flags);
 
-	kasan_kmalloc(s, ret, size, flags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 	return ret;
 }
 
@@ -455,7 +455,7 @@ kmem_cache_alloc_node_trace(struct kmem_cache *s,
 {
 	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
 
-	kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
 #endif /* CONFIG_TRACING */
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index c3bd5209da38..55deff17a4d9 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -474,20 +474,22 @@ struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
 	return (void *)object + cache->kasan_info.free_meta_offset;
 }
 
-void kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
+void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 {
 	struct kasan_alloc_meta *alloc_info;
 
 	if (!(cache->flags & SLAB_KASAN))
-		return;
+		return (void *)object;
 
 	alloc_info = get_alloc_info(cache, object);
 	__memset(alloc_info, 0, sizeof(*alloc_info));
+
+	return (void *)object;
 }
 
-void kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
+void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
 {
-	kasan_kmalloc(cache, object, cache->object_size, flags);
+	return kasan_kmalloc(cache, object, cache->object_size, flags);
 }
 
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
@@ -528,7 +530,7 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
-void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
+void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 		   gfp_t flags)
 {
 	unsigned long redzone_start;
@@ -538,7 +540,7 @@ void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 		quarantine_reduce();
 
 	if (unlikely(object == NULL))
-		return;
+		return NULL;
 
 	redzone_start = round_up((unsigned long)(object + size),
 				KASAN_SHADOW_SCALE_SIZE);
@@ -551,10 +553,12 @@ void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 
 	if (cache->flags & SLAB_KASAN)
 		set_track(&get_alloc_info(cache, object)->alloc_track, flags);
+
+	return (void *)object;
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
-void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 {
 	struct page *page;
 	unsigned long redzone_start;
@@ -564,7 +568,7 @@ void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 		quarantine_reduce();
 
 	if (unlikely(ptr == NULL))
-		return;
+		return NULL;
 
 	page = virt_to_page(ptr);
 	redzone_start = round_up((unsigned long)(ptr + size),
@@ -574,21 +578,23 @@ void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 	kasan_unpoison_shadow(ptr, size);
 	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_PAGE_REDZONE);
+
+	return (void *)ptr;
 }
 
-void kasan_krealloc(const void *object, size_t size, gfp_t flags)
+void *kasan_krealloc(const void *object, size_t size, gfp_t flags)
 {
 	struct page *page;
 
 	if (unlikely(object == ZERO_SIZE_PTR))
-		return;
+		return ZERO_SIZE_PTR;
 
 	page = virt_to_head_page(object);
 
 	if (unlikely(!PageSlab(page)))
-		kasan_kmalloc_large(object, size, flags);
+		return kasan_kmalloc_large(object, size, flags);
 	else
-		kasan_kmalloc(page->slab_cache, object, size, flags);
+		return kasan_kmalloc(page->slab_cache, object, size, flags);
 }
 
 void kasan_poison_kfree(void *ptr, unsigned long ip)
diff --git a/mm/slab.c b/mm/slab.c
index 2a5654bb3b3f..26f60a22e5e0 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3551,7 +3551,7 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *ret = slab_alloc(cachep, flags, _RET_IP_);
 
-	kasan_slab_alloc(cachep, ret, flags);
+	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc(_RET_IP_, ret,
 			       cachep->object_size, cachep->size, flags);
 
@@ -3617,7 +3617,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 
 	ret = slab_alloc(cachep, flags, _RET_IP_);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(_RET_IP_, ret,
 		      size, cachep->size, flags);
 	return ret;
@@ -3641,7 +3641,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
-	kasan_slab_alloc(cachep, ret, flags);
+	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
@@ -3660,7 +3660,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 
 	ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, cachep->size,
 			   flags, nodeid);
@@ -3681,7 +3681,7 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
 	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 
 	return ret;
 }
@@ -3719,7 +3719,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 		return cachep;
 	ret = slab_alloc(cachep, flags, caller);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(caller, ret,
 		      size, cachep->size, flags);
 
diff --git a/mm/slab.h b/mm/slab.h
index 58c6c1c2a78e..4190c24ef0e9 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -441,7 +441,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 
 		kmemleak_alloc_recursive(object, s->object_size, 1,
 					 s->flags, flags);
-		kasan_slab_alloc(s, object, flags);
+		p[i] = kasan_slab_alloc(s, object, flags);
 	}
 
 	if (memcg_kmem_enabled())
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7eb8dc136c1c..5f3504e26d4c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1204,7 +1204,7 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	page = alloc_pages(flags, order);
 	ret = page ? page_address(page) : NULL;
 	kmemleak_alloc(ret, size, 1, flags);
-	kasan_kmalloc_large(ret, size, flags);
+	ret = kasan_kmalloc_large(ret, size, flags);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order);
@@ -1482,7 +1482,7 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
 		ks = ksize(p);
 
 	if (ks >= new_size) {
-		kasan_krealloc((void *)p, new_size, flags);
+		p = kasan_krealloc((void *)p, new_size, flags);
 		return (void *)p;
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index e3629cd7aff1..fdd4a86aa882 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1372,10 +1372,10 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
  */
-static inline void kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
+static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 {
 	kmemleak_alloc(ptr, size, 1, flags);
-	kasan_kmalloc_large(ptr, size, flags);
+	return kasan_kmalloc_large(ptr, size, flags);
 }
 
 static __always_inline void kfree_hook(void *x)
@@ -2768,7 +2768,7 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, gfpflags, _RET_IP_);
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
-	kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
@@ -2796,7 +2796,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
 
-	kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
@@ -3784,7 +3784,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
 
-	kasan_kmalloc(s, ret, size, flags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
@@ -3801,8 +3801,7 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	if (page)
 		ptr = page_address(page);
 
-	kmalloc_large_node_hook(ptr, size, flags);
-	return ptr;
+	return kmalloc_large_node_hook(ptr, size, flags);
 }
 
 void *__kmalloc_node(size_t size, gfp_t flags, int node)
@@ -3829,7 +3828,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
 
-	kasan_kmalloc(s, ret, size, flags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
-- 
2.19.1.930.g4563a0d9d0-goog


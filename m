Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04E8ECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81F21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T01NHfFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B81F21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeITAes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:34:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46669 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbeITAeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:34:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so6856834wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYNjgVaE7A2cOoLGxcvbQWfG/q900XUOt7RdX7lhCCU=;
        b=T01NHfFlVkQZHHDgnxHieD4LDft4LK+JzNa0vrAX1ojeO2AYK1kRyI67/V4+YMyt3b
         /+OBQJ6d8ax74Bnu0czJ8xVJRMrx+Gz4u1AlDGlYGxUUTfFTBoxF8GQc70NV+7wZcSix
         s4tnlXkqQKvEMCiCSZFuaDzIJTQfQsn5yS79mFwUvjOVimKUKIp+o3Z+xthXwN09Emww
         KXArHznN2EbbNcWQzGi4ayzkKBJiE/TtCqRccn1Wb6K+OJ/5Epz+uwMvOzKB3eHl1SXc
         nGpIUV9TXN3UMcC5oui3WivR9V1YpTATlbKoovdXtpu07LnujTZkyg88dbCol6OzRjLm
         Gtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYNjgVaE7A2cOoLGxcvbQWfG/q900XUOt7RdX7lhCCU=;
        b=XcDPWYSetWt8B6mxpk7Y0DhFSDn9iAZKd0WEDGSDe6ghF5k6zJb4U051S1TsS0VJ9T
         bd6hv+8VlSvt80g5O9nbela9jdhIOR6OW5o1+OYO87+iaE1/AguIb36PZ8fF1u1XlgBt
         493LZPaDjJxdqcuOrYn93XfR3BPRQ+A685l2A12b3VUfizNku/KP1oN8NNa2zyA99+m3
         Q2GLxYG9xxgdGnyZ+ya0Vx5N99ifj7/IXbYRvTksQtmjN9lHvz0pszYJPUtbUG2rUoQb
         RDWHP350H4oXh3iGYF77NeVuh2DEe1rVdFuPdetTnAZMS1tXtPBD7a6QqpAi6NzEaq12
         iS7Q==
X-Gm-Message-State: APzg51ABa5v4GYy0Qlkze2AnmJdKkZQ54xRkZ/QXk7BS+RPGYQhJ0BI8
        1cpvecIjcwtSgF7PZ+4kin/94g==
X-Google-Smtp-Source: ANB0VdbL37ih7gC3E61AjUqZEYA5SsJw2v5gqQdb6Pt7RN7phYrmGsbE4QzbCzQPUwN4LFBqwg7d5w==
X-Received: by 2002:a5d:54cb:: with SMTP id x11-v6mr31452787wrv.150.1537383329271;
        Wed, 19 Sep 2018 11:55:29 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id b10-v6sm8510065wmc.28.2018.09.19.11.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 11:55:28 -0700 (PDT)
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
Subject: [PATCH v8 16/20] kasan: add hooks implementation for tag-based mode
Date:   Wed, 19 Sep 2018 20:54:55 +0200
Message-Id: <d3f5102da9792370158ed02203d8066dd5e07ff7.1537383101.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <cover.1537383101.git.andreyknvl@google.com>
References: <cover.1537383101.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds tag-based KASAN specific hooks implementation and
adjusts common generic and tag-based KASAN ones.

1. When a new slab cache is created, tag-based KASAN rounds up the size of
   the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).

2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
   memory, that corresponds to this object to this tag, and embeds this
   tag value into the top byte of the returned pointer.

3. On each kfree tag-based KASAN poisons the shadow memory with a random
   tag to allow detection of use-after-free bugs.

The rest of the logic of the hook implementation is very much similar to
the one provided by generic KASAN. Tag-based KASAN saves allocation and
free stack metadata to the slab object the same way generic KASAN does.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 118 ++++++++++++++++++++++++++++++++++++++--------
 mm/kasan/kasan.h  |   8 ++++
 mm/kasan/tags.c   |  48 +++++++++++++++++++
 3 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7134e75447ff..d368095feb6c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -140,6 +140,13 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
 {
 	void *shadow_start, *shadow_end;
 
+	/*
+	 * Perform shadow offset calculation based on untagged address, as
+	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
+	 * addresses to this function.
+	 */
+	address = reset_tag(address);
+
 	shadow_start = kasan_mem_to_shadow(address);
 	shadow_end = kasan_mem_to_shadow(address + size);
 
@@ -148,11 +155,24 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
 
 void kasan_unpoison_shadow(const void *address, size_t size)
 {
-	kasan_poison_shadow(address, size, 0);
+	u8 tag = get_tag(address);
+
+	/*
+	 * Perform shadow offset calculation based on untagged address, as
+	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
+	 * addresses to this function.
+	 */
+	address = reset_tag(address);
+
+	kasan_poison_shadow(address, size, tag);
 
 	if (size & KASAN_SHADOW_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
-		*shadow = size & KASAN_SHADOW_MASK;
+
+		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+			*shadow = tag;
+		else
+			*shadow = size & KASAN_SHADOW_MASK;
 	}
 }
 
@@ -200,8 +220,9 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
-	if (likely(!PageHighMem(page)))
-		kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
+	if (unlikely(PageHighMem(page)))
+		return;
+	kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
 }
 
 void kasan_free_pages(struct page *page, unsigned int order)
@@ -218,6 +239,9 @@ void kasan_free_pages(struct page *page, unsigned int order)
  */
 static inline unsigned int optimal_redzone(unsigned int object_size)
 {
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+		return 0;
+
 	return
 		object_size <= 64        - 16   ? 16 :
 		object_size <= 128       - 32   ? 32 :
@@ -232,6 +256,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags)
 {
 	unsigned int orig_size = *size;
+	unsigned int redzone_size;
 	int redzone_adjust;
 
 	/* Add alloc meta. */
@@ -239,20 +264,20 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	*size += sizeof(struct kasan_alloc_meta);
 
 	/* Add free meta. */
-	if (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
-	    cache->object_size < sizeof(struct kasan_free_meta)) {
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+	    (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
+	     cache->object_size < sizeof(struct kasan_free_meta))) {
 		cache->kasan_info.free_meta_offset = *size;
 		*size += sizeof(struct kasan_free_meta);
 	}
-	redzone_adjust = optimal_redzone(cache->object_size) -
-		(*size - cache->object_size);
 
+	redzone_size = optimal_redzone(cache->object_size);
+	redzone_adjust = redzone_size -	(*size - cache->object_size);
 	if (redzone_adjust > 0)
 		*size += redzone_adjust;
 
 	*size = min_t(unsigned int, KMALLOC_MAX_SIZE,
-			max(*size, cache->object_size +
-					optimal_redzone(cache->object_size)));
+			max(*size, cache->object_size + redzone_size));
 
 	/*
 	 * If the metadata doesn't fit, don't enable KASAN at all.
@@ -265,6 +290,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 	}
 
+	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
+
 	*flags |= SLAB_KASAN;
 }
 
@@ -319,6 +346,28 @@ void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 	alloc_info = get_alloc_info(cache, object);
 	__memset(alloc_info, 0, sizeof(*alloc_info));
 
+	/*
+	 * Since it's desirable to only call object contructors ones during
+	 * slab allocation, we preassign tags to all such objects.
+	 * Also preassign tags for SLAB_TYPESAFE_BY_RCU slabs to avoid
+	 * use-after-free reports.
+	 * For SLAB allocator we can't preassign tags randomly since the
+	 * freelist is stored as an array of indexes instead of a linked
+	 * list. Assign tags based on objects indexes, so that objects that
+	 * are next to each other get different tags.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
+			(cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)) {
+#ifdef CONFIG_SLAB
+		struct page *page = virt_to_page(object);
+		u8 tag = (u8)obj_to_index(cache, page, (void *)object);
+#else
+		u8 tag = random_tag();
+#endif
+
+		object = set_tag(object, tag);
+	}
+
 	return (void *)object;
 }
 
@@ -327,15 +376,30 @@ void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
 	return kasan_kmalloc(cache, object, cache->object_size, flags);
 }
 
+static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
+{
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		return shadow_byte < 0 ||
+			shadow_byte >= KASAN_SHADOW_SCALE_SIZE;
+	else
+		return tag != (u8)shadow_byte;
+}
+
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 			      unsigned long ip, bool quarantine)
 {
 	s8 shadow_byte;
+	u8 tag;
+	void *tagged_object;
 	unsigned long rounded_up_size;
 
+	tag = get_tag(object);
+	tagged_object = object;
+	object = reset_tag(object);
+
 	if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
 	    object)) {
-		kasan_report_invalid_free(object, ip);
+		kasan_report_invalid_free(tagged_object, ip);
 		return true;
 	}
 
@@ -344,20 +408,22 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 		return false;
 
 	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
-	if (shadow_byte < 0 || shadow_byte >= KASAN_SHADOW_SCALE_SIZE) {
-		kasan_report_invalid_free(object, ip);
+	if (shadow_invalid(tag, shadow_byte)) {
+		kasan_report_invalid_free(tagged_object, ip);
 		return true;
 	}
 
 	rounded_up_size = round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE);
 	kasan_poison_shadow(object, rounded_up_size, KASAN_KMALLOC_FREE);
 
-	if (!quarantine || unlikely(!(cache->flags & SLAB_KASAN)))
+	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
+			unlikely(!(cache->flags & SLAB_KASAN)))
 		return false;
 
 	set_track(&get_alloc_info(cache, object)->free_track, GFP_NOWAIT);
 	quarantine_put(get_free_info(cache, object), cache);
-	return true;
+
+	return IS_ENABLED(CONFIG_KASAN_GENERIC);
 }
 
 bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
@@ -370,6 +436,7 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
+	u8 tag;
 
 	if (gfpflags_allow_blocking(flags))
 		quarantine_reduce();
@@ -382,14 +449,27 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_SHADOW_SCALE_SIZE);
 
-	kasan_unpoison_shadow(object, size);
+	/* See the comment in kasan_init_slab_obj regarding preassigned tags */
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
+			(cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU)) {
+#ifdef CONFIG_SLAB
+		struct page *page = virt_to_page(object);
+
+		tag = (u8)obj_to_index(cache, page, (void *)object);
+#else
+		tag = get_tag(object);
+#endif
+	} else
+		tag = random_tag();
+
+	kasan_unpoison_shadow(set_tag(object, tag), size);
 	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
 		set_track(&get_alloc_info(cache, object)->alloc_track, flags);
 
-	return (void *)object;
+	return set_tag(object, tag);
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
@@ -439,7 +519,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 	page = virt_to_head_page(ptr);
 
 	if (unlikely(!PageSlab(page))) {
-		if (ptr != page_address(page)) {
+		if (reset_tag(ptr) != page_address(page)) {
 			kasan_report_invalid_free(ptr, ip);
 			return;
 		}
@@ -452,7 +532,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 
 void kasan_kfree_large(void *ptr, unsigned long ip)
 {
-	if (ptr != page_address(virt_to_head_page(ptr)))
+	if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
 	/* The object will be poisoned by page_alloc. */
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a2533b890248..a3db6b8efe7a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -12,10 +12,18 @@
 #define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
 #define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
 
+#ifdef CONFIG_KASAN_GENERIC
 #define KASAN_FREE_PAGE         0xFF  /* page was freed */
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
 #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
 #define KASAN_KMALLOC_FREE      0xFB  /* object was freed (kmem_cache_free/kfree) */
+#else
+#define KASAN_FREE_PAGE         KASAN_TAG_INVALID
+#define KASAN_PAGE_REDZONE      KASAN_TAG_INVALID
+#define KASAN_KMALLOC_REDZONE   KASAN_TAG_INVALID
+#define KASAN_KMALLOC_FREE      KASAN_TAG_INVALID
+#endif
+
 #define KASAN_GLOBAL_REDZONE    0xFA  /* redzone for global variable */
 
 /*
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 700323946867..a3cca11e4fed 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -78,15 +78,60 @@ void *kasan_reset_tag(const void *addr)
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
+	u8 tag;
+	u8 *shadow_first, *shadow_last, *shadow;
+	void *untagged_addr;
+
+	if (unlikely(size == 0))
+		return;
+
+	tag = get_tag((const void *)addr);
+
+	/*
+	 * Ignore accesses for pointers tagged with 0xff (native kernel
+	 * pointer tag) to suppress false positives caused by kmap.
+	 *
+	 * Some kernel code was written to account for archs that don't keep
+	 * high memory mapped all the time, but rather map and unmap particular
+	 * pages when needed. Instead of storing a pointer to the kernel memory,
+	 * this code saves the address of the page structure and offset within
+	 * that page for later use. Those pages are then mapped and unmapped
+	 * with kmap/kunmap when necessary and virt_to_page is used to get the
+	 * virtual address of the page. For arm64 (that keeps the high memory
+	 * mapped all the time), kmap is turned into a page_address call.
+
+	 * The issue is that with use of the page_address + virt_to_page
+	 * sequence the top byte value of the original pointer gets lost (gets
+	 * set to KASAN_TAG_KERNEL (0xFF)).
+	 */
+	if (tag == KASAN_TAG_KERNEL)
+		return;
+
+	untagged_addr = reset_tag((const void *)addr);
+	if (unlikely(untagged_addr <
+			kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
+		kasan_report(addr, size, write, ret_ip);
+		return;
+	}
+	shadow_first = kasan_mem_to_shadow(untagged_addr);
+	shadow_last = kasan_mem_to_shadow(untagged_addr + size - 1);
+	for (shadow = shadow_first; shadow <= shadow_last; shadow++) {
+		if (*shadow != tag) {
+			kasan_report(addr, size, write, ret_ip);
+			return;
+		}
+	}
 }
 
 #define DEFINE_HWASAN_LOAD_STORE(size)					\
 	void __hwasan_load##size##_noabort(unsigned long addr)		\
 	{								\
+		check_memory_region(addr, size, false, _RET_IP_);	\
 	}								\
 	EXPORT_SYMBOL(__hwasan_load##size##_noabort);			\
 	void __hwasan_store##size##_noabort(unsigned long addr)		\
 	{								\
+		check_memory_region(addr, size, true, _RET_IP_);	\
 	}								\
 	EXPORT_SYMBOL(__hwasan_store##size##_noabort)
 
@@ -98,15 +143,18 @@ DEFINE_HWASAN_LOAD_STORE(16);
 
 void __hwasan_loadN_noabort(unsigned long addr, unsigned long size)
 {
+	check_memory_region(addr, size, false, _RET_IP_);
 }
 EXPORT_SYMBOL(__hwasan_loadN_noabort);
 
 void __hwasan_storeN_noabort(unsigned long addr, unsigned long size)
 {
+	check_memory_region(addr, size, true, _RET_IP_);
 }
 EXPORT_SYMBOL(__hwasan_storeN_noabort);
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
 {
+	kasan_poison_shadow((void *)addr, size, tag);
 }
 EXPORT_SYMBOL(__hwasan_tag_memory);
-- 
2.19.0.397.gdd90340f6a-goog


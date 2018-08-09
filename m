Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F3BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DA821EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qu6lSut+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DA821EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeHIVsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 17:48:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37077 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeHIVry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 17:47:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so6090241wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJ6q8PjPYcBwwEzFrC4nHyiwSQq7tYGhjlgVJlHyoQY=;
        b=qu6lSut+Tppg+jb4FypHvldSjPebTikzUuxLhQxjJWN+Rzv5jjaLu+4sLWEumdtMuo
         HYYljfxmbqPexcU05ecpIHnxaKv1B+VmTXv1URG97dq4ac5aFWD0Ak3hZZ5T2S3k8oGK
         R5QjT+nNQpVZzj2a9pgnletyBN0Vp6jZrfpS6zR1/ZoNq9dptRMR0f7H7Gh9z8iDXTem
         vjmV9QVZ1OpZcafwI9f2N5sgTLginRccYjSno5Emsu5/XOzwkZ2FvLYXtXgb4yQW7XUl
         qNqSyYoykgM3sEZsRVCpfvpbYGNH5R7MO6nNfA/XVKLFOdXzwIkVZ1raXIzeH+x+KyIn
         ezLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJ6q8PjPYcBwwEzFrC4nHyiwSQq7tYGhjlgVJlHyoQY=;
        b=SHBdVSHyXEn1l7+uB9OWgyadgMCyhcwLieer1aBiSGiuxz7Qwb5ZqQC1dF7BZT8T58
         F2/D4tVWxwWEGtgZCE5LJci+aJR2LKR07UI+W0i8SnUfiWTpmItR1l5aswHx8qjcVG3g
         dV22yKI4a8jjCT3qEur1GSI/jnI1X0dLPeUfxOST/5VvArWCgk4MS7w1rN++q4sxodI4
         Matd5g5jMghjCgxSxh/nDj1YAG6jcdg9/400ZUkTFCcaig3cZI7gK1Q1dyo2SMnzlHiN
         9WYSgKhMuAN0aDruBYhhMZPH9KssSU+C/1tWSumLXi/MrEKcnNIAlQYhXJZ5fjHZxHhA
         F3UQ==
X-Gm-Message-State: AOUpUlGHZV9WbS+ZVU4mXjDXjhJi7HURRf/7PjDaP+j3KCht2vljxgrL
        f21qz3UjQkyuaU3HzI0yjQh5ag==
X-Google-Smtp-Source: AA+uWPzhM4NLx/ciSlWc45Gb41TTLEfQblnVo/0/nPYFyHekUHUJCDN42hqwXxXnom/Kul8tfyXEvA==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr2142157wrr.280.1533842497944;
        Thu, 09 Aug 2018 12:21:37 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id o14-v6sm14738797wmd.35.2018.08.09.12.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 12:21:37 -0700 (PDT)
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
Subject: [PATCH v5 14/18] khwasan: add hooks implementation
Date:   Thu,  9 Aug 2018 21:21:06 +0200
Message-Id: <80bdd0848efe56424cd70258d8f7c1b271ad2e22.1533842385.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds KHWASAN specific hooks implementation and adjusts
common KASAN and KHWASAN ones.

1. When a new slab cache is created, KHWASAN rounds up the size of the
   objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).

2. On each kmalloc KHWASAN generates a random tag, sets the shadow memory,
   that corresponds to this object to this tag, and embeds this tag value
   into the top byte of the returned pointer.

3. On each kfree KHWASAN poisons the shadow memory with a random tag to
   allow detection of use-after-free bugs.

The rest of the logic of the hook implementation is very much similar to
the one provided by KASAN. KHWASAN saves allocation and free stack metadata
to the slab object the same was KASAN does this.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c  | 82 +++++++++++++++++++++++++++++++++++-----------
 mm/kasan/kasan.h   |  8 +++++
 mm/kasan/khwasan.c | 40 ++++++++++++++++++++++
 3 files changed, 111 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index bed8e13c6e1d..938229b26f3a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -140,6 +140,9 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
 {
 	void *shadow_start, *shadow_end;
 
+	/* Perform shadow offset calculation based on untagged address */
+	address = reset_tag(address);
+
 	shadow_start = kasan_mem_to_shadow(address);
 	shadow_end = kasan_mem_to_shadow(address + size);
 
@@ -148,11 +151,20 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
 
 void kasan_unpoison_shadow(const void *address, size_t size)
 {
-	kasan_poison_shadow(address, size, 0);
+	u8 tag = get_tag(address);
+
+	/* Perform shadow offset calculation based on untagged address */
+	address = reset_tag(address);
+
+	kasan_poison_shadow(address, size, tag);
 
 	if (size & KASAN_SHADOW_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
-		*shadow = size & KASAN_SHADOW_MASK;
+
+		if (IS_ENABLED(CONFIG_KASAN_HW))
+			*shadow = tag;
+		else
+			*shadow = size & KASAN_SHADOW_MASK;
 	}
 }
 
@@ -200,8 +212,9 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
-	if (likely(!PageHighMem(page)))
-		kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
+	if (unlikely(PageHighMem(page)))
+		return;
+	kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
 }
 
 void kasan_free_pages(struct page *page, unsigned int order)
@@ -235,6 +248,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags)
 {
 	unsigned int orig_size = *size;
+	unsigned int redzone_size = 0;
 	int redzone_adjust;
 
 	/* Add alloc meta. */
@@ -242,20 +256,20 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
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
@@ -268,6 +282,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 		return;
 	}
 
+	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
+
 	*flags |= SLAB_KASAN;
 }
 
@@ -328,15 +344,30 @@ void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
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
 
@@ -345,20 +376,22 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
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
@@ -371,6 +404,7 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
+	u8 tag;
 
 	if (gfpflags_allow_blocking(flags))
 		quarantine_reduce();
@@ -383,14 +417,24 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_SHADOW_SCALE_SIZE);
 
-	kasan_unpoison_shadow(object, size);
+	/*
+	 * Objects with contructors and objects from SLAB_TYPESAFE_BY_RCU slabs
+	 * have tags preassigned and are already tagged.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN_HW) &&
+			(cache->ctor || cache->flags & SLAB_TYPESAFE_BY_RCU))
+		tag = get_tag(object);
+	else
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
 
@@ -440,7 +484,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 	page = virt_to_head_page(ptr);
 
 	if (unlikely(!PageSlab(page))) {
-		if (ptr != page_address(page)) {
+		if (reset_tag(ptr) != page_address(page)) {
 			kasan_report_invalid_free(ptr, ip);
 			return;
 		}
@@ -453,7 +497,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 
 void kasan_kfree_large(void *ptr, unsigned long ip)
 {
-	if (ptr != page_address(virt_to_head_page(ptr)))
+	if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
 	/* The object will be poisoned by page_alloc. */
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d60859d26be7..6f4f2ebf5f57 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -12,10 +12,18 @@
 #define KHWASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
 #define KHWASAN_TAG_MAX		0xFD /* maximum value for random tags */
 
+#ifdef CONFIG_KASAN_GENERIC
 #define KASAN_FREE_PAGE         0xFF  /* page was freed */
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
 #define KASAN_KMALLOC_REDZONE   0xFC  /* redzone inside slub object */
 #define KASAN_KMALLOC_FREE      0xFB  /* object was freed (kmem_cache_free/kfree) */
+#else
+#define KASAN_FREE_PAGE         KHWASAN_TAG_INVALID
+#define KASAN_PAGE_REDZONE      KHWASAN_TAG_INVALID
+#define KASAN_KMALLOC_REDZONE   KHWASAN_TAG_INVALID
+#define KASAN_KMALLOC_FREE      KHWASAN_TAG_INVALID
+#endif
+
 #define KASAN_GLOBAL_REDZONE    0xFA  /* redzone for global variable */
 
 /*
diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
index 9d91bf3c8246..6b1309278e39 100644
--- a/mm/kasan/khwasan.c
+++ b/mm/kasan/khwasan.c
@@ -106,15 +106,52 @@ void *khwasan_preset_slab_tag(struct kmem_cache *cache, unsigned int idx,
 void check_memory_region(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip)
 {
+	u8 tag;
+	u8 *shadow_first, *shadow_last, *shadow;
+	void *untagged_addr;
+
+	tag = get_tag((const void *)addr);
+
+	/* Ignore accesses for pointers tagged with 0xff (native kernel
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
+	 * set to KHWASAN_TAG_KERNEL (0xFF).
+	 */
+	if (tag == KHWASAN_TAG_KERNEL)
+		return;
+
+	untagged_addr = reset_tag((const void *)addr);
+	shadow_first = kasan_mem_to_shadow(untagged_addr);
+	shadow_last = kasan_mem_to_shadow(untagged_addr + size - 1);
+
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
 
@@ -126,15 +163,18 @@ DEFINE_HWASAN_LOAD_STORE(16);
 
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
2.18.0.597.ga71716f1ad-goog


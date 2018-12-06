Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D78C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29965208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2D25hFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29965208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeLFM0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:26:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34687 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbeLFMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so326933wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJ+U9N4tqltdeWL7oxARVkOoswN2PjjxOCfLHWSAnPk=;
        b=m2D25hFrHk+uO36rvOq4/Ol9GKyuxG7XDF4ZkpDX5W8/7eDdj06hB0AKfend8ZmE/8
         YYSwXXJGTrsoDf6ahrcVCoYEtAeRV37i6U+j+r7jy9HF4lGWPkQLIGQlf3+VMNgr3ymT
         wZk9dHFSsKqAja23gea4iejuSS8Snzfn36+3kSALpa6Lr+eqW3we0xkoRqiwqgGMwj5s
         MOWVmFIyA+qIUc/K2UCiapeFUfq95mp24Aqida26TgydMVJeC7Wsgcv7sTqpAHAxsimT
         2VrkBFAbPYHDSl5p5CNUG3XHr+1BAhgeY/gRalHphFA7UOcz/jTHnmsreBsV0BhId/qW
         auCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJ+U9N4tqltdeWL7oxARVkOoswN2PjjxOCfLHWSAnPk=;
        b=OVcdqBgpgvG9Hk2wXIS4mgy8QPjFWH/aJ0vsKnSncDYltzQFU3VfzBQPMZh6VtiD3V
         FIym/CGm7GN3f2ZDJA6tKXP/t8r7pYapoXfmkvdEg3j3CnOYyOlVpodYDRJB1Ji5fOiv
         Bfoom9tb6BW7KBR7Tpy5exAmkcwdnLLDhPQibS0F22tRYoGyPHwiB3Qhw8pGN7VO3KeJ
         Xe96CMo9rAk1IUbFMoZtzsw0KI7BJRAuWwlyK0zPjS7wwwQwTN1mfsL54CNmkbHHkDgq
         eVWpa9yhEXrlBcDQ7spc7eN/YHwhGUXPW4huBxgqr0XnPBfFf282any0+LMFOss54VKR
         kcOQ==
X-Gm-Message-State: AA+aEWY6cZr5WM0ViuOU6wq7PkBfd4QCP+SJAorySnh+sxOQkgrfoTOt
        qw5rptH7197ndqkquNpIMV7hug==
X-Google-Smtp-Source: AFSGD/VlGE+6PF29ssIsFVXzfKxekeQMXwms0kU+kR+9n1ojPpYXGpTFO+O6eR43lym5cBNik7mtnw==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr24250114wrp.21.1544099119535;
        Thu, 06 Dec 2018 04:25:19 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:18 -0800 (PST)
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
Subject: [PATCH v13 19/25] kasan: add hooks implementation for tag-based mode
Date:   Thu,  6 Dec 2018 13:24:37 +0100
Message-Id: <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
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

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
 mm/kasan/kasan.h  |   8 ++++
 mm/kasan/tags.c   |  48 +++++++++++++++++++
 3 files changed, 153 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7134e75447ff..27f0cae336c9 100644
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
 
@@ -309,6 +336,32 @@ void kasan_poison_object_data(struct kmem_cache *cache, void *object)
 			KASAN_KMALLOC_REDZONE);
 }
 
+/*
+ * Since it's desirable to only call object contructors once during slab
+ * allocation, we preassign tags to all such objects. Also preassign tags for
+ * SLAB_TYPESAFE_BY_RCU slabs to avoid use-after-free reports.
+ * For SLAB allocator we can't preassign tags randomly since the freelist is
+ * stored as an array of indexes instead of a linked list. Assign tags based
+ * on objects indexes, so that objects that are next to each other get
+ * different tags.
+ * After a tag is assigned, the object always gets allocated with the same tag.
+ * The reason is that we can't change tags for objects with constructors on
+ * reallocation (even for non-SLAB_TYPESAFE_BY_RCU), because the constructor
+ * code can save the pointer to the object somewhere (e.g. in the object
+ * itself). Then if we retag it, the old saved pointer will become invalid.
+ */
+static u8 assign_tag(struct kmem_cache *cache, const void *object, bool new)
+{
+	if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
+		return new ? KASAN_TAG_KERNEL : random_tag();
+
+#ifdef CONFIG_SLAB
+	return (u8)obj_to_index(cache, virt_to_page(object), (void *)object);
+#else
+	return new ? random_tag() : get_tag(object);
+#endif
+}
+
 void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 {
 	struct kasan_alloc_meta *alloc_info;
@@ -319,6 +372,9 @@ void *kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 	alloc_info = get_alloc_info(cache, object);
 	__memset(alloc_info, 0, sizeof(*alloc_info));
 
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+		object = set_tag(object, assign_tag(cache, object, true));
+
 	return (void *)object;
 }
 
@@ -327,15 +383,30 @@ void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
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
 
@@ -344,20 +415,22 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
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
@@ -370,6 +443,7 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
+	u8 tag;
 
 	if (gfpflags_allow_blocking(flags))
 		quarantine_reduce();
@@ -382,14 +456,18 @@ void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_SHADOW_SCALE_SIZE);
 
-	kasan_unpoison_shadow(object, size);
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+		tag = assign_tag(cache, object, false);
+
+	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
+	kasan_unpoison_shadow(set_tag(object, tag), size);
 	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
 		set_track(&get_alloc_info(cache, object)->alloc_track, flags);
 
-	return (void *)object;
+	return set_tag(object, tag);
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
@@ -439,7 +517,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 	page = virt_to_head_page(ptr);
 
 	if (unlikely(!PageSlab(page))) {
-		if (ptr != page_address(page)) {
+		if (reset_tag(ptr) != page_address(page)) {
 			kasan_report_invalid_free(ptr, ip);
 			return;
 		}
@@ -452,7 +530,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 
 void kasan_kfree_large(void *ptr, unsigned long ip)
 {
-	if (ptr != page_address(virt_to_head_page(ptr)))
+	if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
 	/* The object will be poisoned by page_alloc. */
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 82a23b23ff93..ea51b2d898ec 100644
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
index 1c4e7ce2e6fe..1d1b79350e28 100644
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
2.20.0.rc1.387.gf8505762e3-goog


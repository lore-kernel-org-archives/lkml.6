Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CE0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC7526AFD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q95t2VTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC7526AFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965287AbeFZNQw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:16:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44892 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935575AbeFZNQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:16:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id p12-v6so15589724wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2zUTOAqF1fN5e7AIv8pN3lcl+xHq66RqyUEHWszeZTI=;
        b=q95t2VTtCnD2dS4yjtLLagTYWA7B3edVC+BIByndEgLfeyh5SIc/tAtn10oIZp/9GG
         x0T02n8BQtHJ9OjFEB0MU63lbZ4Y/m+2qwzENJ6FXVZUYY24uHFYtpGx4viEcOF0eAfA
         ssNRHg8pqEOyudRZn1TtRPeDkS/VeZTGM0bPb08Ld8ogc5Av0wwQ3bwizihJxGOXgOXz
         X5AK5SY5FZkY14/voMbAGuWF5TDEsDZ+svqhj2tcoVxI9yhwturmkYrCr9sGBIChebUe
         3UixsrZ4MjCSDoLmI+tcSGNwiVTFPSZGOO7Y1StNIj3+xQ4rjSDWscafk2IfC7FpoxuH
         uBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2zUTOAqF1fN5e7AIv8pN3lcl+xHq66RqyUEHWszeZTI=;
        b=fgPWOq7S/VwR/xnrNtV64QX9ffbL5REVVqz0UL2w/CLYQmymQ45ZTCphIzHUrNgtPs
         T06RqANtFZxvkCWzhyIPrmprngKC2bVcNJFy9lwK1/IBZa7xJwQG1YEWY/dtUTU1UERv
         Ljlb3NZY012bwRg58Y64gjkwOJbJ+z5nNo3P4CH5QlzpT/cgf3WEQdAa8rgDpTi9+cFA
         IfDpoUJpzlLCUned2ySPDuUbAnSeBXKg9rYcqOLcZHPptPUvQwonIsm9kt/FNnOK8tXt
         DOgIsRsAiX74gyyAIVu7m9TO3U5ZSHaF+s3Y9h6L+yz3pxyBrPF/8405zfkG7DaX67sT
         x5tQ==
X-Gm-Message-State: APt69E2wCplSDzMSdMXMZilJr7Tw1il4aE14r21LOPtFgVT/iBmguERK
        CoNY1w01wWKjkMsGFSVd1saY6w==
X-Google-Smtp-Source: AAOMgpclahDHIP9jwkDiwxeX9boCdYqDV8afAD5sC03gyl2ySyize5dIBXmvVp4Sh920XhuY8/IOjg==
X-Received: by 2002:adf:9d18:: with SMTP id k24-v6mr1562298wre.29.1530018960844;
        Tue, 26 Jun 2018 06:16:00 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id w15-v6sm2162639wrn.25.2018.06.26.06.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 06:15:59 -0700 (PDT)
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
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 15/17] khwasan, mm, arm64: tag non slab memory allocated via pagealloc
Date:   Tue, 26 Jun 2018 15:15:25 +0200
Message-Id: <d2891451b51c6ba246f44383228ec13bc9206931.1530018818.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <cover.1530018818.git.andreyknvl@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KWHASAN doesn't check memory accesses through pointers tagged with 0xff.
When page_address is used to get pointer to memory that corresponds to
some page, the tag of the resulting pointer gets set to 0xff, even though
the allocated memory might have been tagged differently.

For slab pages it's impossible to recover the correct tag to return from
page_address, since the page might contain multiple slab objects tagged
with different values, and we can't know in advance which one of them is
going to get accessed. For non slab pages however, we can recover the tag
in page_address, since the whole page was marked with the same tag.

This patch adds tagging to non slab memory allocated with pagealloc. To
set the tag of the pointer returned from page_address, the tag gets stored
to page->flags when the memory gets allocated.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h   | 10 ++++++++++
 include/linux/mm.h                | 29 +++++++++++++++++++++++++++++
 include/linux/page-flags-layout.h | 10 ++++++++++
 mm/cma.c                          | 11 +++++++++++
 mm/kasan/common.c                 | 15 +++++++++++++--
 mm/page_alloc.c                   |  1 +
 6 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e9e054dfb1fc..3352a65b8312 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -305,7 +305,17 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
 #define __page_to_voff(kaddr)	(((u64)(kaddr) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
 
+#ifndef CONFIG_KASAN_HW
 #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
+#else
+#define page_to_virt(page)	({					\
+	unsigned long __addr =						\
+		((__page_to_voff(page)) | PAGE_OFFSET);			\
+	__addr = KASAN_SET_TAG(__addr, page_kasan_tag(page));		\
+	((void *)__addr);						\
+})
+#endif
+
 #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
 
 #define _virt_addr_valid(kaddr)	pfn_valid((((u64)(kaddr) & ~PAGE_OFFSET) \
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..46afadf4f48c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -784,6 +784,7 @@ int finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_PGOFF		(SECTIONS_PGOFF - NODES_WIDTH)
 #define ZONES_PGOFF		(NODES_PGOFF - ZONES_WIDTH)
 #define LAST_CPUPID_PGOFF	(ZONES_PGOFF - LAST_CPUPID_WIDTH)
+#define KASAN_TAG_PGOFF		(LAST_CPUPID_PGOFF - KASAN_TAG_WIDTH)
 
 /*
  * Define the bit shifts to access each section.  For non-existent
@@ -794,6 +795,7 @@ int finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_PGSHIFT		(NODES_PGOFF * (NODES_WIDTH != 0))
 #define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_WIDTH != 0))
 #define LAST_CPUPID_PGSHIFT	(LAST_CPUPID_PGOFF * (LAST_CPUPID_WIDTH != 0))
+#define KASAN_TAG_PGSHIFT	(KASAN_TAG_PGOFF * (KASAN_TAG_WIDTH != 0))
 
 /* NODE:ZONE or SECTION:ZONE is used to ID a zone for the buddy allocator */
 #ifdef NODE_NOT_IN_PAGE_FLAGS
@@ -816,6 +818,7 @@ int finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_MASK		((1UL << NODES_WIDTH) - 1)
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define LAST_CPUPID_MASK	((1UL << LAST_CPUPID_SHIFT) - 1)
+#define KASAN_TAG_MASK		((1UL << KASAN_TAG_WIDTH) - 1)
 #define ZONEID_MASK		((1UL << ZONEID_SHIFT) - 1)
 
 static inline enum zone_type page_zonenum(const struct page *page)
@@ -1070,6 +1073,32 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_KASAN_HW
+static inline u8 page_kasan_tag(const struct page *page)
+{
+	return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
+}
+
+static inline void page_kasan_tag_set(struct page *page, u8 tag)
+{
+	page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
+	page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+}
+
+static inline void page_kasan_tag_reset(struct page *page)
+{
+	page_kasan_tag_set(page, 0xff);
+}
+#else
+static inline u8 page_kasan_tag(const struct page *page)
+{
+	return 0xff;
+}
+
+static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
+static inline void page_kasan_tag_reset(struct page *page) { }
+#endif
+
 static inline struct zone *page_zone(const struct page *page)
 {
 	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 7ec86bf31ce4..8dbad17664c2 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -82,6 +82,16 @@
 #define LAST_CPUPID_WIDTH 0
 #endif
 
+#ifdef CONFIG_KASAN_HW
+#define KASAN_TAG_WIDTH 8
+#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH+LAST_CPUPID_WIDTH+KASAN_TAG_WIDTH \
+	> BITS_PER_LONG - NR_PAGEFLAGS
+#error "KASAN: not enough bits in page flags for tag"
+#endif
+#else
+#define KASAN_TAG_WIDTH 0
+#endif
+
 /*
  * We are going to use the flags for the page to node mapping if its in
  * there.  This includes the case where there is no node, so it is implicit.
diff --git a/mm/cma.c b/mm/cma.c
index 5809bbe360d7..fdad7ad0d9c4 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -407,6 +407,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	unsigned long pfn = -1;
 	unsigned long start = 0;
 	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
+	size_t i;
 	struct page *page = NULL;
 	int ret = -ENOMEM;
 
@@ -466,6 +467,16 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 
 	trace_cma_alloc(pfn, page, count, align);
 
+	/*
+	 * CMA can allocate multiple page blocks, which results in different
+	 * blocks being marked with different tags. Reset the tags to ignore
+	 * those page blocks.
+	 */
+	if (page) {
+		for (i = 0; i < count; i++)
+			page_kasan_tag_reset(page + i);
+	}
+
 	if (ret && !(gfp_mask & __GFP_NOWARN)) {
 		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
 			__func__, count, ret);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1e96ca050c75..6cf7dec0b765 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -212,8 +212,15 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
+	u8 tag;
+	unsigned long i;
+
 	if (unlikely(PageHighMem(page)))
 		return;
+
+	tag = random_tag();
+	for (i = 0; i < (1 << order); i++)
+		page_kasan_tag_set(page + i, tag);
 	kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
 }
 
@@ -311,6 +318,10 @@ struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
 
 void kasan_poison_slab(struct page *page)
 {
+	unsigned long i;
+
+	for (i = 0; i < (1 << compound_order(page)); i++)
+		page_kasan_tag_reset(page + i);
 	kasan_poison_shadow(page_address(page),
 			PAGE_SIZE << compound_order(page),
 			KASAN_KMALLOC_REDZONE);
@@ -483,7 +494,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 	page = virt_to_head_page(ptr);
 
 	if (unlikely(!PageSlab(page))) {
-		if (reset_tag(ptr) != page_address(page)) {
+		if (ptr != page_address(page)) {
 			kasan_report_invalid_free(ptr, ip);
 			return;
 		}
@@ -496,7 +507,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 
 void kasan_kfree_large(void *ptr, unsigned long ip)
 {
-	if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
+	if (ptr != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
 	/* The object will be poisoned by page_alloc. */
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..266e86323d73 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1176,6 +1176,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	init_page_count(page);
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
+	page_kasan_tag_reset(page);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.18.0.rc2.346.g013aa6912e-goog


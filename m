Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62020862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaZcvmI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E62020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeH2Pc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:32:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54309 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbeH2PcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so4939655wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOQLXIfZsQqSVQUxeIhnGNQSnIjX11Dj2Kz0Wy/GlMc=;
        b=TaZcvmI0t1XFHEh6yOlxuZw05ltSwTYH4y2haKbNdn63CoUCzRt6VcwIqTDxNGL66A
         GxKmJ6FhmLfN0zt6eC4DnrrCu0SjZFE2t9xoGzQFDm6maNps6Z7dZ0baKBn7LUpK1G1H
         O01pK5A/HKL4rtlqDa0fkBjop51hE4findPDL1M/OdmsupWe4crxxtc+EDm2JIw6WWoI
         WKUF67a7gkfI/+QYir8h6LyNt5LtsIV4cKYnUPkTe1dOx+tlYYTsL7cxds1xuolc++Kp
         /HbkOdy965OxZlviklRmvThGhn+lu8ELFpL9/y1dehcGyHjOzHRpBB2b3xM+I3HZuWbp
         v0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOQLXIfZsQqSVQUxeIhnGNQSnIjX11Dj2Kz0Wy/GlMc=;
        b=Yam8xH9647zWs5ETRDYU9IS2Mm7jH5FbZrB/+zPzk+Xn+kuqUn2WidPqt6AYgAUl8W
         MjFNA0krYHYn0IQR+DvyWcqyPsdH0roz0emxLG3GgHTT5H2lt6EcxeX13MDH78S+/hVm
         mz5J5ptxl6aY9FnhwB0yjv8DTpqTsjZBnL7jmDq+NwKFSYyMp3U35bGdfT94Yw76N7sw
         wVsyYbZBh3d25OHOyNd3ZFvUT8Xg4TnVi1mYGopiS/K4/i6rK5N2lW9Ju3Hs/vs4P0ue
         gDDnOsFJ/6YsjTX4CnrHv2x4DUwW1FpzLDm51rQLJ6zJr04991ydBUvzkRFgqAsy2P1q
         Z6Qg==
X-Gm-Message-State: APzg51DKLHTpe5bi4sJYHA53cojjcrg2Wwhv5BQMG18+6lH5pW6Utnjk
        FOmC1Y1IdyG4IjLdOZbvDljWPA==
X-Google-Smtp-Source: ANB0VdZtQ5/7G9QQ7MUik7zJ4qXfPY1KcSVwoBTA9GmRMM+L4+4n4J7u33BYwOaHbNL4MdJFu7wVeA==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr4103692wmi.28.1535542554046;
        Wed, 29 Aug 2018 04:35:54 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:53 -0700 (PDT)
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
Subject: [PATCH v6 16/18] khwasan, mm, arm64: tag non slab memory allocated via pagealloc
Date:   Wed, 29 Aug 2018 13:35:20 +0200
Message-Id: <db103bdc2109396af0c6007f1669ebbbb63b872b.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 mm/kasan/common.c                 | 17 +++++++++++++++--
 mm/page_alloc.c                   |  1 +
 6 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f5e2953b7009..ea7f928aba31 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -312,7 +312,17 @@ static inline void *phys_to_virt(phys_addr_t x)
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
index a61ebe8ad4ca..a1e7c590d925 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -804,6 +804,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_PGOFF		(SECTIONS_PGOFF - NODES_WIDTH)
 #define ZONES_PGOFF		(NODES_PGOFF - ZONES_WIDTH)
 #define LAST_CPUPID_PGOFF	(ZONES_PGOFF - LAST_CPUPID_WIDTH)
+#define KASAN_TAG_PGOFF		(LAST_CPUPID_PGOFF - KASAN_TAG_WIDTH)
 
 /*
  * Define the bit shifts to access each section.  For non-existent
@@ -814,6 +815,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_PGSHIFT		(NODES_PGOFF * (NODES_WIDTH != 0))
 #define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_WIDTH != 0))
 #define LAST_CPUPID_PGSHIFT	(LAST_CPUPID_PGOFF * (LAST_CPUPID_WIDTH != 0))
+#define KASAN_TAG_PGSHIFT	(KASAN_TAG_PGOFF * (KASAN_TAG_WIDTH != 0))
 
 /* NODE:ZONE or SECTION:ZONE is used to ID a zone for the buddy allocator */
 #ifdef NODE_NOT_IN_PAGE_FLAGS
@@ -836,6 +838,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_MASK		((1UL << NODES_WIDTH) - 1)
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define LAST_CPUPID_MASK	((1UL << LAST_CPUPID_SHIFT) - 1)
+#define KASAN_TAG_MASK		((1UL << KASAN_TAG_WIDTH) - 1)
 #define ZONEID_MASK		((1UL << ZONEID_SHIFT) - 1)
 
 static inline enum zone_type page_zonenum(const struct page *page)
@@ -1081,6 +1084,32 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
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
index 4cb76121a3ab..c7b39dd3b4f6 100644
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
 	if (ret && !no_warn) {
 		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
 			__func__, count, ret);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 938229b26f3a..e5648f4218eb 100644
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
 
@@ -311,6 +318,12 @@ struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
 
 void kasan_poison_slab(struct page *page)
 {
+	unsigned long i;
+
+	if (IS_ENABLED(CONFIG_SLAB))
+		page->s_mem = reset_tag(page->s_mem);
+	for (i = 0; i < (1 << compound_order(page)); i++)
+		page_kasan_tag_reset(page + i);
 	kasan_poison_shadow(page_address(page),
 			PAGE_SIZE << compound_order(page),
 			KASAN_KMALLOC_REDZONE);
@@ -484,7 +497,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 	page = virt_to_head_page(ptr);
 
 	if (unlikely(!PageSlab(page))) {
-		if (reset_tag(ptr) != page_address(page)) {
+		if (ptr != page_address(page)) {
 			kasan_report_invalid_free(ptr, ip);
 			return;
 		}
@@ -497,7 +510,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 
 void kasan_kfree_large(void *ptr, unsigned long ip)
 {
-	if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
+	if (ptr != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
 	/* The object will be poisoned by page_alloc. */
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e75865d58ba7..eb5627f89853 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1177,6 +1177,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	init_page_count(page);
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
+	page_kasan_tag_reset(page);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog


Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524235647; cv=none;
        d=google.com; s=arc-20160816;
        b=BC797rrg03hrurCZAkC5inKw+RPnTirhdcXlcDokwT0hGRpJHjKaaUMKZvt+PlUnLC
         Ymzm7HZHMSyYN2Fm+HmshWX6W3jDkJpsXt0tkWh2IXl1iQ+8BRfgHIID7CAqHzCRTV99
         Lx61JRGZHODPfzEM2f4lNEy8zyeC80x8k6PdonBLQ3gKWqOiJYjWBLPuyzO5OPZE8JGa
         6O2YX0rHp8nhFhCGLbUI7uw82A2+rk1g48/ls1SAJRicSOqdH+Mvi2Mt9kQDMtU+r+rm
         nG7PhtSn0c9PZ7qwApm21aBeI/ce/k11U19CE6lcrllNyzYd/AKJcTb7hPW0vmXBBNCP
         ECIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NYgnMiutBU6cFV5TfEY1cFc/lyGcnYq2FRs8DG2ZhQ8=;
        b=DYGalphWsAyxoQtF03rWzC/fhBZOqInEr5k3PvY8XvsFXXqJ/HnEy/nTtUxssmUeGi
         q5YJYqLeBr/7gBF1nU8J3V2SFC13HgCXZNz+y0tuMQ58nRde0pcZyIQ4ePBz44drmM9W
         oXp5dI81JEpAZqy9ebbxO3SVxzLRJHNYLJJxniZpBqGX9mZziXP90b1gCa3lpPBr2e5q
         4jU3Ea/VbNyzcyNYwnTDTCBcR2lIajyfxOK2osnV5CQRsDYxvaVTEQOjvg8sbKgwKVfG
         6ko16zPYyvzQq5sS3XINy3tNqNSW3LLX7/Svp3NnvYOeRj77OpLiOGbupym2RFXSJ/IF
         vYfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aCAkMnoJ;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aCAkMnoJ;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49sNp8KdyfpcDX5Ae5YG4gvR0Q6B+N8nhuw8tOPuS2go1htvjbLYYU65iv2d3K/pPY8fqKylg==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	"GitAuthor : Andrey Konovalov" <andreyknvl@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>,
	Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>,
	Mark Brand <markbrand@google.com>
Subject: [RFC PATCH v3 14/15] khwasan, mm, arm64: tag non slab memory allocated via pagealloc
Date: Fri, 20 Apr 2018 16:46:52 +0200
Message-Id: <131e678b42a1f3f0b890cc26465cf7a480fbb508.1524235387.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <cover.1524235387.git.andreyknvl@google.com>
References: <cover.1524235387.git.andreyknvl@google.com>
In-Reply-To: <cover.1524235387.git.andreyknvl@google.com>
References: <cover.1524235387.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598276918544170926?=
X-GMAIL-MSGID: =?utf-8?q?1598276918544170926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
 arch/arm64/include/asm/memory.h   | 11 +++++++++++
 include/linux/mm.h                | 29 +++++++++++++++++++++++++++++
 include/linux/page-flags-layout.h | 10 ++++++++++
 mm/cma.c                          |  1 +
 mm/kasan/common.c                 | 14 ++++++++++++--
 mm/page_alloc.c                   |  1 +
 6 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f206273469b5..9ec78a44c5ff 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -304,7 +304,18 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
 #define __page_to_voff(kaddr)	(((u64)(kaddr) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
 
+#ifndef CONFIG_KASAN_HW
 #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
+#else
+#define page_to_virt(page)	({					\
+	unsigned long __addr =						\
+		((__page_to_voff(page)) | PAGE_OFFSET);			\
+	if (!PageSlab((struct page *)page))				\
+		__addr = KASAN_SET_TAG(__addr, page_kasan_tag(page));	\
+	((void *)__addr);						\
+})
+#endif
+
 #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
 
 #define _virt_addr_valid(kaddr)	pfn_valid((((u64)(kaddr) & ~PAGE_OFFSET) \
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ac1f06a4be6..d6d596824803 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -770,6 +770,7 @@ int finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_PGOFF		(SECTIONS_PGOFF - NODES_WIDTH)
 #define ZONES_PGOFF		(NODES_PGOFF - ZONES_WIDTH)
 #define LAST_CPUPID_PGOFF	(ZONES_PGOFF - LAST_CPUPID_WIDTH)
+#define KASAN_TAG_PGOFF		(LAST_CPUPID_PGOFF - KASAN_TAG_WIDTH)
 
 /*
  * Define the bit shifts to access each section.  For non-existent
@@ -780,6 +781,7 @@ int finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_PGSHIFT		(NODES_PGOFF * (NODES_WIDTH != 0))
 #define ZONES_PGSHIFT		(ZONES_PGOFF * (ZONES_WIDTH != 0))
 #define LAST_CPUPID_PGSHIFT	(LAST_CPUPID_PGOFF * (LAST_CPUPID_WIDTH != 0))
+#define KASAN_TAG_PGSHIFT	(KASAN_TAG_PGOFF * (KASAN_TAG_WIDTH != 0))
 
 /* NODE:ZONE or SECTION:ZONE is used to ID a zone for the buddy allocator */
 #ifdef NODE_NOT_IN_PAGE_FLAGS
@@ -802,6 +804,7 @@ int finish_mkwrite_fault(struct vm_fault *vmf);
 #define NODES_MASK		((1UL << NODES_WIDTH) - 1)
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define LAST_CPUPID_MASK	((1UL << LAST_CPUPID_SHIFT) - 1)
+#define KASAN_TAG_MASK		((1UL << KASAN_TAG_WIDTH) - 1)
 #define ZONEID_MASK		((1UL << ZONEID_SHIFT) - 1)
 
 static inline enum zone_type page_zonenum(const struct page *page)
@@ -1021,6 +1024,32 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
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
index aa40e6c7b042..f657db289bba 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -526,6 +526,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	}
 
 	trace_cma_alloc(pfn, page, count, align);
+	page_kasan_tag_reset(page);
 
 	if (ret && !(gfp_mask & __GFP_NOWARN)) {
 		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 0654bf97257b..8d8a982d4490 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -207,8 +207,17 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
 
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
+#ifdef CONFIG_KASAN_GENERIC
 	if (likely(!PageHighMem(page)))
 		kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
+#else
+	if (!PageSlab(page)) {
+		u8 tag = random_tag();
+		kasan_poison_shadow(page_address(page), PAGE_SIZE << order,
+					tag);
+		page_kasan_tag_set(page, tag);
+	}
+#endif
 }
 
 void kasan_free_pages(struct page *page, unsigned int order)
@@ -433,6 +442,7 @@ void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 #else
 	tag = random_tag();
 	kasan_poison_shadow(ptr, redzone_start - (unsigned long)ptr, tag);
+	page_kasan_tag_set(page, tag);
 #endif
 	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_PAGE_REDZONE);
@@ -462,7 +472,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 	page = virt_to_head_page(ptr);
 
 	if (unlikely(!PageSlab(page))) {
-		if (reset_tag(ptr) != page_address(page)) {
+		if (ptr != page_address(page)) {
 			kasan_report_invalid_free(ptr, ip);
 			return;
 		}
@@ -475,7 +485,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
 
 void kasan_kfree_large(void *ptr, unsigned long ip)
 {
-	if (reset_tag(ptr) != page_address(virt_to_head_page(ptr)))
+	if (ptr != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
 	/* The object will be poisoned by page_alloc. */
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 905db9d7962f..54df9c852c6e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1179,6 +1179,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	init_page_count(page);
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
+	page_kasan_tag_reset(page);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.0.484.g0c8726318c-goog

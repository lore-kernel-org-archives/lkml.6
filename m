Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218121-2-4212486470212865557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rosk.us-asciisv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218120; b=DRu5Kojc5AFiEuyPfGBKj21FeNAhVdtKaj3ZalgcUERrVFM
    XhrV+uFZkHHRKMFuRjxf/LhCP3LcWYdFEnlAxIPyJu+k/XQCZ/C4i+TPr41E+CXH
    F6Hk1OsWAlKTXlX46hKXWqlyHJ6DhXKlVrm9k9PATB6LAX8O129w4xJlZ2ro0Wzq
    UhLVhttbbmgK3XTb7/sY/6IG/ZqeiXRzEvDFBfytgseIfzo1JjSP6xMzVICKc4iw
    5oIKlSZejxKrTxeC1doUfLBPiUA5fPNTwZJ/+Dps8dbhAj0+LVUbV7TvUTSMNNdd
    MVjLLTHDmD9Ccs6s6Xn8GBWk665Gg0w1IhC5+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218120; bh=XBcYJKVauNp2p566j93g+tmRDs
    6lRysnWI2b+njzzWc=; b=BfxElhg6XKXiwwPi9/SAXunnH/Grj/bUuzAyYBZWw3
    RNL1wQkpIiPSbHKRfMU3LJrUZDOLdyMM1vIkaGyFP9ldtznRDOnsqALJUwLecUUu
    HLKfTq2Wz41R8+PazY8vLVlv1a1x1hfWvEhU7Rc7BCs3v0qmjYYpKYj758djjVFX
    6rTm4I4cGd/BycEO7k6Jul2J5ebyoh3gN7MUvZ5zJbZ9Xvj0xYP82Ku0g2TR7PmL
    WZT+SPwF6lbc4en2DMYzjGA7yw8sTQk90YOMKR1x2VKyIxmX4JN8nZvX2gvDlTnV
    40oxOIaKKsB5rq4JoMsnwtTGlZGZiNmABIDmKaF9spJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935467AbeBUNBZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:01:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935449AbeBUNBT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:01:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>,
        Alexander Potapenko <glider@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Hansen <devtimhansen@gmail.com>,
        Vegard Nossum <vegardno@ifi.uio.no>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 080/167] kmemcheck: stop using GFP_NOTRACK and SLAB_NOTRACK
Date: Wed, 21 Feb 2018 13:48:11 +0100
Message-Id: <20180221124528.810682785@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>

commit 75f296d93bcebcfe375884ddac79e30263a31766 upstream.

Convert all allocations that used a NOTRACK flag to stop using it.

Link: http://lkml.kernel.org/r/20171007030159.22241-3-alexander.levin@verizon.com
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Hansen <devtimhansen@gmail.com>
Cc: Vegard Nossum <vegardno@ifi.uio.no>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/include/asm/pgalloc.h       |    2 +-
 arch/arm64/include/asm/pgalloc.h     |    2 +-
 arch/powerpc/include/asm/pgalloc.h   |    2 +-
 arch/sh/kernel/dwarf.c               |    4 ++--
 arch/sh/kernel/process.c             |    2 +-
 arch/sparc/mm/init_64.c              |    4 ++--
 arch/unicore32/include/asm/pgalloc.h |    2 +-
 arch/x86/kernel/espfix_64.c          |    2 +-
 arch/x86/mm/init.c                   |    3 +--
 arch/x86/mm/init_64.c                |    2 +-
 arch/x86/mm/pageattr.c               |   10 +++++-----
 arch/x86/mm/pgtable.c                |    2 +-
 arch/x86/platform/efi/efi_64.c       |    2 +-
 crypto/xor.c                         |    7 +------
 include/linux/thread_info.h          |    5 ++---
 init/do_mounts.c                     |    3 +--
 kernel/fork.c                        |   12 ++++++------
 kernel/signal.c                      |    3 +--
 mm/kmemcheck.c                       |    2 +-
 mm/slab.c                            |    2 +-
 mm/slab.h                            |    5 ++---
 mm/slab_common.c                     |    2 +-
 mm/slub.c                            |    4 +---
 23 files changed, 36 insertions(+), 48 deletions(-)

--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -57,7 +57,7 @@ static inline void pud_populate(struct m
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
+#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 
 static inline void clean_pte_table(pte_t *pte)
 {
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -26,7 +26,7 @@
 
 #define check_pgt_cache()		do { } while (0)
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
+#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
 #if CONFIG_PGTABLE_LEVELS > 2
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -18,7 +18,7 @@ static inline gfp_t pgtable_gfp_flags(st
 }
 #endif /* MODULE */
 
-#define PGALLOC_GFP (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
+#define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
 
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgalloc.h>
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -1172,11 +1172,11 @@ static int __init dwarf_unwinder_init(vo
 
 	dwarf_frame_cachep = kmem_cache_create("dwarf_frames",
 			sizeof(struct dwarf_frame), 0,
-			SLAB_PANIC | SLAB_HWCACHE_ALIGN | SLAB_NOTRACK, NULL);
+			SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
 
 	dwarf_reg_cachep = kmem_cache_create("dwarf_regs",
 			sizeof(struct dwarf_reg), 0,
-			SLAB_PANIC | SLAB_HWCACHE_ALIGN | SLAB_NOTRACK, NULL);
+			SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
 
 	dwarf_frame_pool = mempool_create_slab_pool(DWARF_FRAME_MIN_REQ,
 						    dwarf_frame_cachep);
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -59,7 +59,7 @@ void arch_task_cache_init(void)
 
 	task_xstate_cachep = kmem_cache_create("task_xstate", xstate_size,
 					       __alignof__(union thread_xstate),
-					       SLAB_PANIC | SLAB_NOTRACK, NULL);
+					       SLAB_PANIC, NULL);
 }
 
 #ifdef CONFIG_SH_FPU_EMU
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2934,7 +2934,7 @@ void __flush_tlb_all(void)
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 			    unsigned long address)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
+	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	pte_t *pte = NULL;
 
 	if (page)
@@ -2946,7 +2946,7 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 pgtable_t pte_alloc_one(struct mm_struct *mm,
 			unsigned long address)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
+	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page)
 		return NULL;
 	if (!pgtable_page_ctor(page)) {
--- a/arch/unicore32/include/asm/pgalloc.h
+++ b/arch/unicore32/include/asm/pgalloc.h
@@ -28,7 +28,7 @@ extern void free_pgd_slow(struct mm_stru
 #define pgd_alloc(mm)			get_pgd_slow(mm)
 #define pgd_free(mm, pgd)		free_pgd_slow(mm, pgd)
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
+#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 
 /*
  * Allocate one PTE table.
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -57,7 +57,7 @@
 # error "Need more virtual address space for the ESPFIX hack"
 #endif
 
-#define PGALLOC_GFP (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
+#define PGALLOC_GFP (GFP_KERNEL | __GFP_ZERO)
 
 /* This contains the *bottom* address of the espfix stack */
 DEFINE_PER_CPU_READ_MOSTLY(unsigned long, espfix_stack);
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -93,8 +93,7 @@ __ref void *alloc_low_pages(unsigned int
 		unsigned int order;
 
 		order = get_order((unsigned long)num << PAGE_SHIFT);
-		return (void *)__get_free_pages(GFP_ATOMIC | __GFP_NOTRACK |
-						__GFP_ZERO, order);
+		return (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
 	}
 
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -184,7 +184,7 @@ static __ref void *spp_getpage(void)
 	void *ptr;
 
 	if (after_bootmem)
-		ptr = (void *) get_zeroed_page(GFP_ATOMIC | __GFP_NOTRACK);
+		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
 	else
 		ptr = alloc_bootmem_pages(PAGE_SIZE);
 
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -753,7 +753,7 @@ static int split_large_page(struct cpa_d
 
 	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
-	base = alloc_pages(GFP_KERNEL | __GFP_NOTRACK, 0);
+	base = alloc_pages(GFP_KERNEL, 0);
 	if (!debug_pagealloc_enabled())
 		spin_lock(&cpa_lock);
 	if (!base)
@@ -904,7 +904,7 @@ static void unmap_pud_range(p4d_t *p4d,
 
 static int alloc_pte_page(pmd_t *pmd)
 {
-	pte_t *pte = (pte_t *)get_zeroed_page(GFP_KERNEL | __GFP_NOTRACK);
+	pte_t *pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
 	if (!pte)
 		return -1;
 
@@ -914,7 +914,7 @@ static int alloc_pte_page(pmd_t *pmd)
 
 static int alloc_pmd_page(pud_t *pud)
 {
-	pmd_t *pmd = (pmd_t *)get_zeroed_page(GFP_KERNEL | __GFP_NOTRACK);
+	pmd_t *pmd = (pmd_t *)get_zeroed_page(GFP_KERNEL);
 	if (!pmd)
 		return -1;
 
@@ -1120,7 +1120,7 @@ static int populate_pgd(struct cpa_data
 	pgd_entry = cpa->pgd + pgd_index(addr);
 
 	if (pgd_none(*pgd_entry)) {
-		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL | __GFP_NOTRACK);
+		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
 		if (!p4d)
 			return -1;
 
@@ -1132,7 +1132,7 @@ static int populate_pgd(struct cpa_data
 	 */
 	p4d = p4d_offset(pgd_entry, addr);
 	if (p4d_none(*p4d)) {
-		pud = (pud_t *)get_zeroed_page(GFP_KERNEL | __GFP_NOTRACK);
+		pud = (pud_t *)get_zeroed_page(GFP_KERNEL);
 		if (!pud)
 			return -1;
 
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -7,7 +7,7 @@
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
 
-#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_NOTRACK | __GFP_ZERO)
+#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
 
 #ifdef CONFIG_HIGHPTE
 #define PGALLOC_USER_GFP __GFP_HIGHMEM
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -211,7 +211,7 @@ int __init efi_alloc_page_tables(void)
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
-	gfp_mask = GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO;
+	gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
 	if (!efi_pgd)
 		return -ENOMEM;
--- a/crypto/xor.c
+++ b/crypto/xor.c
@@ -122,12 +122,7 @@ calibrate_xor_blocks(void)
 		goto out;
 	}
 
-	/*
-	 * Note: Since the memory is not actually used for _anything_ but to
-	 * test the XOR speed, we don't really want kmemcheck to warn about
-	 * reading uninitialized bytes here.
-	 */
-	b1 = (void *) __get_free_pages(GFP_KERNEL | __GFP_NOTRACK, 2);
+	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
 	if (!b1) {
 		printk(KERN_WARNING "xor: Yikes!  No memory available.\n");
 		return -ENOMEM;
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -44,10 +44,9 @@ enum {
 #endif
 
 #if IS_ENABLED(CONFIG_DEBUG_STACK_USAGE) || IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)
-# define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_NOTRACK | \
-				 __GFP_ZERO)
+# define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO)
 #else
-# define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_NOTRACK)
+# define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT)
 #endif
 
 /*
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -380,8 +380,7 @@ static int __init do_mount_root(char *na
 
 void __init mount_block_root(char *name, int flags)
 {
-	struct page *page = alloc_page(GFP_KERNEL |
-					__GFP_NOTRACK_FALSE_POSITIVE);
+	struct page *page = alloc_page(GFP_KERNEL);
 	char *fs_names = page_address(page);
 	char *p;
 #ifdef CONFIG_BLOCK
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -469,7 +469,7 @@ void __init fork_init(void)
 	/* create a slab on which task_structs can be allocated */
 	task_struct_cachep = kmem_cache_create("task_struct",
 			arch_task_struct_size, align,
-			SLAB_PANIC|SLAB_NOTRACK|SLAB_ACCOUNT, NULL);
+			SLAB_PANIC|SLAB_ACCOUNT, NULL);
 #endif
 
 	/* do the arch specific task caches init */
@@ -2208,18 +2208,18 @@ void __init proc_caches_init(void)
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
-			SLAB_NOTRACK|SLAB_ACCOUNT, sighand_ctor);
+			SLAB_ACCOUNT, sighand_ctor);
 	signal_cachep = kmem_cache_create("signal_cache",
 			sizeof(struct signal_struct), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_NOTRACK|SLAB_ACCOUNT,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 	files_cachep = kmem_cache_create("files_cache",
 			sizeof(struct files_struct), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_NOTRACK|SLAB_ACCOUNT,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 	fs_cachep = kmem_cache_create("fs_cache",
 			sizeof(struct fs_struct), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_NOTRACK|SLAB_ACCOUNT,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 	/*
 	 * FIXME! The "sizeof(struct mm_struct)" currently includes the
@@ -2230,7 +2230,7 @@ void __init proc_caches_init(void)
 	 */
 	mm_cachep = kmem_cache_create("mm_struct",
 			sizeof(struct mm_struct), ARCH_MIN_MMSTRUCT_ALIGN,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_NOTRACK|SLAB_ACCOUNT,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
 	mmap_init();
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1038,8 +1038,7 @@ static int __send_signal(int sig, struct
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC | __GFP_NOTRACK_FALSE_POSITIVE,
-		override_rlimit);
+	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
 		switch ((unsigned long) info) {
--- a/mm/kmemcheck.c
+++ b/mm/kmemcheck.c
@@ -18,7 +18,7 @@ void kmemcheck_alloc_shadow(struct page
 	 * With kmemcheck enabled, we need to allocate a memory area for the
 	 * shadow bits as well.
 	 */
-	shadow = alloc_pages_node(node, flags | __GFP_NOTRACK, order);
+	shadow = alloc_pages_node(node, flags, order);
 	if (!shadow) {
 		if (printk_ratelimit())
 			pr_err("kmemcheck: failed to allocate shadow bitmap\n");
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1412,7 +1412,7 @@ static struct page *kmem_getpages(struct
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		flags |= __GFP_RECLAIMABLE;
 
-	page = __alloc_pages_node(nodeid, flags | __GFP_NOTRACK, cachep->gfporder);
+	page = __alloc_pages_node(nodeid, flags, cachep->gfporder);
 	if (!page) {
 		slab_out_of_memory(cachep, flags, nodeid);
 		return NULL;
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -141,10 +141,10 @@ static inline unsigned long kmem_cache_f
 #if defined(CONFIG_SLAB)
 #define SLAB_CACHE_FLAGS (SLAB_MEM_SPREAD | SLAB_NOLEAKTRACE | \
 			  SLAB_RECLAIM_ACCOUNT | SLAB_TEMPORARY | \
-			  SLAB_NOTRACK | SLAB_ACCOUNT)
+			  SLAB_ACCOUNT)
 #elif defined(CONFIG_SLUB)
 #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
-			  SLAB_TEMPORARY | SLAB_NOTRACK | SLAB_ACCOUNT)
+			  SLAB_TEMPORARY | SLAB_ACCOUNT)
 #else
 #define SLAB_CACHE_FLAGS (0)
 #endif
@@ -163,7 +163,6 @@ static inline unsigned long kmem_cache_f
 			      SLAB_NOLEAKTRACE | \
 			      SLAB_RECLAIM_ACCOUNT | \
 			      SLAB_TEMPORARY | \
-			      SLAB_NOTRACK | \
 			      SLAB_ACCOUNT)
 
 int __kmem_cache_shutdown(struct kmem_cache *);
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -44,7 +44,7 @@ static DECLARE_WORK(slab_caches_to_rcu_d
 		SLAB_FAILSLAB | SLAB_KASAN)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
-			 SLAB_NOTRACK | SLAB_ACCOUNT)
+			 SLAB_ACCOUNT)
 
 /*
  * Merge control. If this is set then no merging of slab caches will occur.
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1434,8 +1434,6 @@ static inline struct page *alloc_slab_pa
 	struct page *page;
 	int order = oo_order(oo);
 
-	flags |= __GFP_NOTRACK;
-
 	if (node == NUMA_NO_NODE)
 		page = alloc_pages(flags, order);
 	else
@@ -3772,7 +3770,7 @@ static void *kmalloc_large_node(size_t s
 	struct page *page;
 	void *ptr = NULL;
 
-	flags |= __GFP_COMP | __GFP_NOTRACK;
+	flags |= __GFP_COMP;
 	page = alloc_pages_node(node, flags, get_order(size));
 	if (page)
 		ptr = page_address(page);

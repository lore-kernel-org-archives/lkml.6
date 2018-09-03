Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB43C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAB520862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAB520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeICTW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:22:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:22:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83F2Fpu3340797
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 08:02:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83F2Fq03340793;
        Mon, 3 Sep 2018 08:02:15 -0700
Date:   Mon, 3 Sep 2018 08:02:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-fdc0269e8958a1ec95b8ac685c1d372c24c60faa@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, jgross@suse.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, jgross@suse.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180828074026.820-15-jgross@suse.com>
References: <20180828074026.820-15-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Move the Xen-only pv_mmu_ops under
 the PARAVIRT_XXL umbrella
Git-Commit-ID: fdc0269e8958a1ec95b8ac685c1d372c24c60faa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fdc0269e8958a1ec95b8ac685c1d372c24c60faa
Gitweb:     https://git.kernel.org/tip/fdc0269e8958a1ec95b8ac685c1d372c24c60faa
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:25 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:37 +0200

x86/paravirt: Move the Xen-only pv_mmu_ops under the PARAVIRT_XXL umbrella

Most of the paravirt ops defined in pv_mmu_ops are for Xen PV guests
only. Define them only if CONFIG_PARAVIRT_XXL is set.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-15-jgross@suse.com

---
 arch/x86/include/asm/fixmap.h         |   2 +-
 arch/x86/include/asm/mmu_context.h    |   4 +-
 arch/x86/include/asm/paravirt.h       | 125 +++++++++++++++++-----------------
 arch/x86/include/asm/paravirt_types.h |  33 ++++-----
 arch/x86/include/asm/pgalloc.h        |   2 +-
 arch/x86/include/asm/pgtable.h        |   7 +-
 arch/x86/include/asm/special_insns.h  |  11 +--
 arch/x86/kernel/asm-offsets.c         |   4 +-
 arch/x86/kernel/head_64.S             |   4 +-
 arch/x86/kernel/paravirt.c            |  15 ++--
 arch/x86/kernel/paravirt_patch_32.c   |   4 +-
 arch/x86/kernel/paravirt_patch_64.c   |   4 +-
 12 files changed, 103 insertions(+), 112 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index e203169931c7..ac80e7eadc3a 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -152,7 +152,7 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
 void native_set_fixmap(enum fixed_addresses idx,
 		       phys_addr_t phys, pgprot_t flags);
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 static inline void __set_fixmap(enum fixed_addresses idx,
 				phys_addr_t phys, pgprot_t flags)
 {
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index eeeb9289c764..0ca50611e8ce 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -16,12 +16,12 @@
 
 extern atomic64_t last_mm_ctx_id;
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
 }
-#endif	/* !CONFIG_PARAVIRT */
+#endif	/* !CONFIG_PARAVIRT_XXL */
 
 #ifdef CONFIG_PERF_EVENTS
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 512433c56c33..63ab58dc5b73 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,6 +17,62 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
+static inline unsigned long long paravirt_sched_clock(void)
+{
+	return PVOP_CALL0(unsigned long long, time.sched_clock);
+}
+
+struct static_key;
+extern struct static_key paravirt_steal_enabled;
+extern struct static_key paravirt_steal_rq_enabled;
+
+static inline u64 paravirt_steal_clock(int cpu)
+{
+	return PVOP_CALL1(u64, time.steal_clock, cpu);
+}
+
+/* The paravirtualized I/O functions */
+static inline void slow_down_io(void)
+{
+	pv_ops.cpu.io_delay();
+#ifdef REALLY_SLOW_IO
+	pv_ops.cpu.io_delay();
+	pv_ops.cpu.io_delay();
+	pv_ops.cpu.io_delay();
+#endif
+}
+
+static inline void __flush_tlb(void)
+{
+	PVOP_VCALL0(mmu.flush_tlb_user);
+}
+
+static inline void __flush_tlb_global(void)
+{
+	PVOP_VCALL0(mmu.flush_tlb_kernel);
+}
+
+static inline void __flush_tlb_one_user(unsigned long addr)
+{
+	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
+}
+
+static inline void flush_tlb_others(const struct cpumask *cpumask,
+				    const struct flush_tlb_info *info)
+{
+	PVOP_VCALL2(mmu.flush_tlb_others, cpumask, info);
+}
+
+static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
+}
+
+static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
+{
+	PVOP_VCALL1(mmu.exit_mmap, mm);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -52,7 +108,6 @@ static inline void write_cr0(unsigned long x)
 {
 	PVOP_VCALL1(cpu.write_cr0, x);
 }
-#endif
 
 static inline unsigned long read_cr2(void)
 {
@@ -74,7 +129,6 @@ static inline void write_cr3(unsigned long x)
 	PVOP_VCALL1(mmu.write_cr3, x);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
 static inline void __write_cr4(unsigned long x)
 {
 	PVOP_VCALL1(cpu.write_cr4, x);
@@ -172,23 +226,7 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
 	*p = paravirt_read_msr_safe(msr, &err);
 	return err;
 }
-#endif
 
-static inline unsigned long long paravirt_sched_clock(void)
-{
-	return PVOP_CALL0(unsigned long long, time.sched_clock);
-}
-
-struct static_key;
-extern struct static_key paravirt_steal_enabled;
-extern struct static_key paravirt_steal_rq_enabled;
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return PVOP_CALL1(u64, time.steal_clock, cpu);
-}
-
-#ifdef CONFIG_PARAVIRT_XXL
 static inline unsigned long long paravirt_read_pmc(int counter)
 {
 	return PVOP_CALL1(u64, cpu.read_pmc, counter);
@@ -267,18 +305,6 @@ static inline void set_iopl_mask(unsigned mask)
 {
 	PVOP_VCALL1(cpu.set_iopl_mask, mask);
 }
-#endif
-
-/* The paravirtualized I/O functions */
-static inline void slow_down_io(void)
-{
-	pv_ops.cpu.io_delay();
-#ifdef REALLY_SLOW_IO
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
-#endif
-}
 
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
@@ -292,35 +318,6 @@ static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 	PVOP_VCALL2(mmu.dup_mmap, oldmm, mm);
 }
 
-static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
-{
-	PVOP_VCALL1(mmu.exit_mmap, mm);
-}
-
-static inline void __flush_tlb(void)
-{
-	PVOP_VCALL0(mmu.flush_tlb_user);
-}
-static inline void __flush_tlb_global(void)
-{
-	PVOP_VCALL0(mmu.flush_tlb_kernel);
-}
-static inline void __flush_tlb_one_user(unsigned long addr)
-{
-	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
-}
-
-static inline void flush_tlb_others(const struct cpumask *cpumask,
-				    const struct flush_tlb_info *info)
-{
-	PVOP_VCALL2(mmu.flush_tlb_others, cpumask, info);
-}
-
-static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
-}
-
 static inline int paravirt_pgd_alloc(struct mm_struct *mm)
 {
 	return PVOP_CALL1(int, mmu.pgd_alloc, mm);
@@ -623,7 +620,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 }
 #endif	/* CONFIG_X86_PAE */
 
-#ifdef CONFIG_PARAVIRT_XXL
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
 static inline void arch_start_context_switch(struct task_struct *prev)
 {
@@ -634,7 +630,6 @@ static inline void arch_end_context_switch(struct task_struct *next)
 {
 	PVOP_VCALL1(cpu.end_context_switch, next);
 }
-#endif
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void)
@@ -657,6 +652,7 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 {
 	pv_ops.mmu.set_fixmap(idx, phys, flags);
 }
+#endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 
@@ -948,15 +944,20 @@ extern void default_banner(void);
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
+#endif /* !CONFIG_PARAVIRT */
+
 #ifndef __ASSEMBLY__
+#ifndef CONFIG_PARAVIRT_XXL
 static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 					  struct mm_struct *mm)
 {
 }
+#endif
 
+#ifndef CONFIG_PARAVIRT
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 }
+#endif
 #endif /* __ASSEMBLY__ */
-#endif /* !CONFIG_PARAVIRT */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f582093b52dd..a0094aaf073e 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -91,13 +91,14 @@ struct pv_init_ops {
 			  unsigned long addr, unsigned len);
 } __no_randomize_layout;
 
-
+#ifdef CONFIG_PARAVIRT_XXL
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
 	void (*enter)(void);
 	void (*leave)(void);
 	void (*flush)(void);
 } __no_randomize_layout;
+#endif
 
 struct pv_time_ops {
 	unsigned long long (*sched_clock)(void);
@@ -205,31 +206,30 @@ struct pv_irq_ops {
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
+	/* TLB operations */
+	void (*flush_tlb_user)(void);
+	void (*flush_tlb_kernel)(void);
+	void (*flush_tlb_one_user)(unsigned long addr);
+	void (*flush_tlb_others)(const struct cpumask *cpus,
+				 const struct flush_tlb_info *info);
+
+	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
+
+	/* Hook for intercepting the destruction of an mm_struct. */
+	void (*exit_mmap)(struct mm_struct *mm);
+
+#ifdef CONFIG_PARAVIRT_XXL
 	unsigned long (*read_cr2)(void);
 	void (*write_cr2)(unsigned long);
 
 	unsigned long (*read_cr3)(void);
 	void (*write_cr3)(unsigned long);
 
-	/*
-	 * Hooks for intercepting the creation/use/destruction of an
-	 * mm_struct.
-	 */
+	/* Hooks for intercepting the creation/use of an mm_struct. */
 	void (*activate_mm)(struct mm_struct *prev,
 			    struct mm_struct *next);
 	void (*dup_mmap)(struct mm_struct *oldmm,
 			 struct mm_struct *mm);
-	void (*exit_mmap)(struct mm_struct *mm);
-
-
-	/* TLB operations */
-	void (*flush_tlb_user)(void);
-	void (*flush_tlb_kernel)(void);
-	void (*flush_tlb_one_user)(unsigned long addr);
-	void (*flush_tlb_others)(const struct cpumask *cpus,
-				 const struct flush_tlb_info *info);
-
-	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
 
 	/* Hooks for allocating and freeing a pagetable top-level */
 	int  (*pgd_alloc)(struct mm_struct *mm);
@@ -304,6 +304,7 @@ struct pv_mmu_ops {
 	   an mfn.  We can tell which is which from the index. */
 	void (*set_fixmap)(unsigned /* enum fixed_addresses */ idx,
 			   phys_addr_t phys, pgprot_t flags);
+#endif
 } __no_randomize_layout;
 
 struct arch_spinlock;
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index fbd578daa66e..ec7f43327033 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -8,7 +8,7 @@
 
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
 #define paravirt_pgd_alloc(mm)	__paravirt_pgd_alloc(mm)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5bb0fe3b7e00..7b0489ca027a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -55,9 +55,9 @@ extern struct mm_struct *pgd_page_get_mm(struct page *page);
 
 extern pmdval_t early_pmd_flags;
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
-#else  /* !CONFIG_PARAVIRT */
+#else  /* !CONFIG_PARAVIRT_XXL */
 #define set_pte(ptep, pte)		native_set_pte(ptep, pte)
 #define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
 
@@ -111,9 +111,6 @@ extern pmdval_t early_pmd_flags;
 #define pte_val(x)	native_pte_val(x)
 #define __pte(x)	native_make_pte(x)
 
-#endif	/* CONFIG_PARAVIRT */
-
-#ifndef CONFIG_PARAVIRT_XXL
 #define arch_end_context_switch(prev)	do {} while(0)
 #endif	/* CONFIG_PARAVIRT_XXL */
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2aa6ce4bf159..43c029cdc3fe 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -141,11 +141,10 @@ static inline unsigned long __read_cr4(void)
 	return native_read_cr4();
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
-#endif
+#else
 
-#ifndef CONFIG_PARAVIRT_XXL
 static inline unsigned long read_cr0(void)
 {
 	return native_read_cr0();
@@ -155,9 +154,7 @@ static inline void write_cr0(unsigned long x)
 {
 	native_write_cr0(x);
 }
-#endif
 
-#ifndef CONFIG_PARAVIRT
 static inline unsigned long read_cr2(void)
 {
 	return native_read_cr2();
@@ -181,9 +178,7 @@ static inline void write_cr3(unsigned long x)
 {
 	native_write_cr3(x);
 }
-#endif
 
-#ifndef CONFIG_PARAVIRT_XXL
 static inline void __write_cr4(unsigned long x)
 {
 	native_write_cr4(x);
@@ -213,7 +208,7 @@ static inline void load_gs_index(unsigned selector)
 
 #endif
 
-#endif/* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_XXL */
 
 static inline void clflush(volatile void *__p)
 {
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 28e7572ff74d..fc02c3cf238f 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -64,13 +64,11 @@ void common(void) {
 	OFFSET(IA32_RT_SIGFRAME_sigcontext, rt_sigframe_ia32, uc.uc_mcontext);
 #endif
 
-#ifdef CONFIG_PARAVIRT
-	BLANK();
 #ifdef CONFIG_PARAVIRT_XXL
+	BLANK();
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
-#endif
 	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
 #endif
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index a5bd72a0ee1a..827bca2c2782 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -25,14 +25,12 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/asm-offsets.h>
 #include <asm/paravirt.h>
 #define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
 #else
 #define GET_CR2_INTO(reg) movq %cr2, reg
-#endif
-#ifndef CONFIG_PARAVIRT_XXL
 #define INTERRUPT_RETURN iretq
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5e8226335eac..bbf006fe78d7 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -384,11 +384,6 @@ struct paravirt_patch_template pv_ops = {
 #endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
-	.mmu.read_cr2		= native_read_cr2,
-	.mmu.write_cr2		= native_write_cr2,
-	.mmu.read_cr3		= __native_read_cr3,
-	.mmu.write_cr3		= native_write_cr3,
-
 	.mmu.flush_tlb_user	= native_flush_tlb,
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
@@ -396,6 +391,14 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.tlb_remove_table	=
 			(void (*)(struct mmu_gather *, void *))tlb_remove_page,
 
+	.mmu.exit_mmap		= paravirt_nop,
+
+#ifdef CONFIG_PARAVIRT_XXL
+	.mmu.read_cr2		= native_read_cr2,
+	.mmu.write_cr2		= native_write_cr2,
+	.mmu.read_cr3		= __native_read_cr3,
+	.mmu.write_cr3		= native_write_cr3,
+
 	.mmu.pgd_alloc		= __paravirt_pgd_alloc,
 	.mmu.pgd_free		= paravirt_nop,
 
@@ -448,7 +451,6 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.make_pgd		= PTE_IDENT,
 
 	.mmu.dup_mmap		= paravirt_nop,
-	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.activate_mm	= paravirt_nop,
 
 	.mmu.lazy_mode = {
@@ -458,6 +460,7 @@ struct paravirt_patch_template pv_ops = {
 	},
 
 	.mmu.set_fixmap		= native_set_fixmap,
+#endif /* CONFIG_PARAVIRT_XXL */
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 	/* Lock ops. */
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 1d44705c6528..d460cbcabcfe 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -7,10 +7,10 @@ DEF_NATIVE(irq, irq_enable, "sti");
 DEF_NATIVE(irq, restore_fl, "push %eax; popf");
 DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
 DEF_NATIVE(cpu, iret, "iret");
-#endif
 DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
+#endif
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
@@ -49,10 +49,10 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(irq, restore_fl);
 		PATCH_SITE(irq, save_fl);
 		PATCH_SITE(cpu, iret);
-#endif
 		PATCH_SITE(mmu, read_cr2);
 		PATCH_SITE(mmu, read_cr3);
 		PATCH_SITE(mmu, write_cr3);
+#endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(lock.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index b00937963a0f..5ad5bcda9dc6 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -8,11 +8,9 @@ DEF_NATIVE(irq, irq_disable, "cli");
 DEF_NATIVE(irq, irq_enable, "sti");
 DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
 DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
-#endif
 DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
 DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
 DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
-#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(cpu, wbinvd, "wbinvd");
 
 DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
@@ -61,10 +59,10 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(cpu, usergs_sysret64);
 		PATCH_SITE(cpu, swapgs);
 		PATCH_SITE(cpu, wbinvd);
-#endif
 		PATCH_SITE(mmu, read_cr2);
 		PATCH_SITE(mmu, read_cr3);
 		PATCH_SITE(mmu, write_cr3);
+#endif
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(lock.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {

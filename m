Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3936EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15E220843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15E220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeICTVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:21:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:21:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83F13Tu3340677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 08:01:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83F13WW3340674;
        Mon, 3 Sep 2018 08:01:03 -0700
Date:   Mon, 3 Sep 2018 08:01:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-9bad5658ea710f45e4ee68b88a01cfe1839d8b00@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        jgross@suse.com, linux-kernel@vger.kernel.org
Reply-To: jgross@suse.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180828074026.820-13-jgross@suse.com>
References: <20180828074026.820-13-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Move the Xen-only pv_cpu_ops under
 the PARAVIRT_XXL umbrella
Git-Commit-ID: 9bad5658ea710f45e4ee68b88a01cfe1839d8b00
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

Commit-ID:  9bad5658ea710f45e4ee68b88a01cfe1839d8b00
Gitweb:     https://git.kernel.org/tip/9bad5658ea710f45e4ee68b88a01cfe1839d8b00
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:36 +0200

x86/paravirt: Move the Xen-only pv_cpu_ops under the PARAVIRT_XXL umbrella

Most of the paravirt ops defined in pv_cpu_ops are for Xen PV guests
only. Define them only if CONFIG_PARAVIRT_XXL is set.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-13-jgross@suse.com

---
 arch/x86/include/asm/debugreg.h       |  2 +-
 arch/x86/include/asm/desc.h           |  4 ++--
 arch/x86/include/asm/irqflags.h       | 16 +++++++++++-----
 arch/x86/include/asm/msr.h            |  4 ++--
 arch/x86/include/asm/paravirt.h       | 19 +++++++++++++++++--
 arch/x86/include/asm/paravirt_types.h |  5 ++++-
 arch/x86/include/asm/pgtable.h        |  6 ++++--
 arch/x86/include/asm/processor.h      |  4 ++--
 arch/x86/include/asm/special_insns.h  |  9 +++++++--
 arch/x86/kernel/asm-offsets.c         |  2 ++
 arch/x86/kernel/asm-offsets_64.c      |  2 ++
 arch/x86/kernel/cpu/common.c          |  2 +-
 arch/x86/kernel/head_64.S             |  2 ++
 arch/x86/kernel/paravirt.c            | 13 ++++++++++++-
 arch/x86/kernel/paravirt_patch_32.c   |  4 ++++
 arch/x86/kernel/paravirt_patch_64.c   |  6 +++++-
 16 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 4505ac2735ad..9e5ca30738e5 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -8,7 +8,7 @@
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 /*
  * These special macros can be used to get or set a debugging register
  */
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 13c5ee878a47..68a99d2a5f33 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -108,7 +108,7 @@ static inline int desc_empty(const void *ptr)
 	return !(desc[0] | desc[1]);
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
 #define load_TR_desc()				native_load_tr_desc()
@@ -134,7 +134,7 @@ static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
 {
 }
-#endif	/* CONFIG_PARAVIRT */
+#endif	/* CONFIG_PARAVIRT_XXL */
 
 #define store_ldt(ldt) asm("sldt %0" : "=m"(ldt))
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 088b0e751b3e..025a1986170c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -122,6 +122,16 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #define ENABLE_INTERRUPTS(x)	sti
 #define DISABLE_INTERRUPTS(x)	cli
 
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_DEBUG_ENTRY
+#define SAVE_FLAGS(x)		pushfq; popq %rax
+#endif
+#endif
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
+#ifndef CONFIG_PARAVIRT_XXL
+#ifdef __ASSEMBLY__
 #ifdef CONFIG_X86_64
 #define SWAPGS	swapgs
 /*
@@ -143,16 +153,12 @@ static inline notrace unsigned long arch_local_irq_save(void)
 	swapgs;					\
 	sysretl
 
-#ifdef CONFIG_DEBUG_ENTRY
-#define SAVE_FLAGS(x)		pushfq; popq %rax
-#endif
 #else
 #define INTERRUPT_RETURN		iret
 #endif
 
-
 #endif /* __ASSEMBLY__ */
-#endif /* CONFIG_PARAVIRT */
+#endif /* CONFIG_PARAVIRT_XXL */
 
 #ifndef __ASSEMBLY__
 static inline int arch_irqs_disabled_flags(unsigned long flags)
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 04addd6e0a4a..91e4cf189914 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -242,7 +242,7 @@ static inline unsigned long long native_read_pmc(int counter)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
 #include <linux/errno.h>
@@ -305,7 +305,7 @@ do {							\
 
 #define rdpmcl(counter, val) ((val) = native_read_pmc(counter))
 
-#endif	/* !CONFIG_PARAVIRT */
+#endif	/* !CONFIG_PARAVIRT_XXL */
 
 /*
  * 64-bit version of wrmsr_safe():
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dbaedf1ed622..686a68004b5f 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,6 +17,7 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
+#ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
 	PVOP_VCALL1(cpu.load_sp0, sp0);
@@ -51,6 +52,7 @@ static inline void write_cr0(unsigned long x)
 {
 	PVOP_VCALL1(cpu.write_cr0, x);
 }
+#endif
 
 static inline unsigned long read_cr2(void)
 {
@@ -72,6 +74,7 @@ static inline void write_cr3(unsigned long x)
 	PVOP_VCALL1(mmu.write_cr3, x);
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 static inline void __write_cr4(unsigned long x)
 {
 	PVOP_VCALL1(cpu.write_cr4, x);
@@ -88,6 +91,7 @@ static inline void write_cr8(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr8, x);
 }
 #endif
+#endif
 
 static inline void arch_safe_halt(void)
 {
@@ -99,14 +103,13 @@ static inline void halt(void)
 	PVOP_VCALL0(irq.halt);
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 static inline void wbinvd(void)
 {
 	PVOP_VCALL0(cpu.wbinvd);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
-#endif
 
 static inline u64 paravirt_read_msr(unsigned msr)
 {
@@ -171,6 +174,7 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
 	*p = paravirt_read_msr_safe(msr, &err);
 	return err;
 }
+#endif
 
 static inline unsigned long long paravirt_sched_clock(void)
 {
@@ -186,6 +190,7 @@ static inline u64 paravirt_steal_clock(int cpu)
 	return PVOP_CALL1(u64, time.steal_clock, cpu);
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 static inline unsigned long long paravirt_read_pmc(int counter)
 {
 	return PVOP_CALL1(u64, cpu.read_pmc, counter);
@@ -230,6 +235,7 @@ static inline unsigned long paravirt_store_tr(void)
 {
 	return PVOP_CALL0(unsigned long, cpu.store_tr);
 }
+
 #define store_tr(tr)	((tr) = paravirt_store_tr())
 static inline void load_TLS(struct thread_struct *t, unsigned cpu)
 {
@@ -263,6 +269,7 @@ static inline void set_iopl_mask(unsigned mask)
 {
 	PVOP_VCALL1(cpu.set_iopl_mask, mask);
 }
+#endif
 
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
@@ -618,6 +625,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 }
 #endif	/* CONFIG_X86_PAE */
 
+#ifdef CONFIG_PARAVIRT_XXL
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
 static inline void arch_start_context_switch(struct task_struct *prev)
 {
@@ -628,6 +636,7 @@ static inline void arch_end_context_switch(struct task_struct *next)
 {
 	PVOP_VCALL1(cpu.end_context_switch, next);
 }
+#endif
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void)
@@ -870,10 +879,12 @@ extern void default_banner(void);
 #define PARA_INDIRECT(addr)	*%cs:addr
 #endif
 
+#ifdef CONFIG_PARAVIRT_XXL
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(PV_CPU_iret),				\
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_ops+PV_CPU_iret);)
+#endif
 
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(PV_IRQ_irq_disable),			\
@@ -890,6 +901,7 @@ extern void default_banner(void);
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #ifdef CONFIG_X86_64
+#ifdef CONFIG_PARAVIRT_XXL
 /*
  * If swapgs is used while the userspace stack is still current,
  * there's no way to call a pvop.  The PV replacement *must* be
@@ -909,15 +921,18 @@ extern void default_banner(void);
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_ops+PV_CPU_swapgs);		\
 		 )
+#endif
 
 #define GET_CR2_INTO_RAX				\
 	ANNOTATE_RETPOLINE_SAFE;				\
 	call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);
 
+#ifdef CONFIG_PARAVIRT_XXL
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
+#endif
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 5bfed396c6b4..ad87379b2332 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -106,6 +106,9 @@ struct pv_time_ops {
 
 struct pv_cpu_ops {
 	/* hooks for various privileged instructions */
+	void (*io_delay)(void);
+
+#ifdef CONFIG_PARAVIRT_XXL
 	unsigned long (*get_debugreg)(int regno);
 	void (*set_debugreg)(int regno, unsigned long value);
 
@@ -143,7 +146,6 @@ struct pv_cpu_ops {
 	void (*set_iopl_mask)(unsigned mask);
 
 	void (*wbinvd)(void);
-	void (*io_delay)(void);
 
 	/* cpuid emulation, mostly so that caps bits can be disabled */
 	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
@@ -178,6 +180,7 @@ struct pv_cpu_ops {
 
 	void (*start_context_switch)(struct task_struct *prev);
 	void (*end_context_switch)(struct task_struct *next);
+#endif
 } __no_randomize_layout;
 
 struct pv_irq_ops {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e4ffa565a69f..5bb0fe3b7e00 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -111,10 +111,12 @@ extern pmdval_t early_pmd_flags;
 #define pte_val(x)	native_pte_val(x)
 #define __pte(x)	native_make_pte(x)
 
-#define arch_end_context_switch(prev)	do {} while(0)
-
 #endif	/* CONFIG_PARAVIRT */
 
+#ifndef CONFIG_PARAVIRT_XXL
+#define arch_end_context_switch(prev)	do {} while(0)
+#endif	/* CONFIG_PARAVIRT_XXL */
+
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d53c54b842da..a47d3c84631d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -578,7 +578,7 @@ static inline bool on_thread_stack(void)
 			       current_stack_pointer) < THREAD_SIZE;
 }
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
 #define __cpuid			native_cpuid
@@ -589,7 +589,7 @@ static inline void load_sp0(unsigned long sp0)
 }
 
 #define set_iopl_mask native_set_iopl_mask
-#endif /* CONFIG_PARAVIRT */
+#endif /* CONFIG_PARAVIRT_XXL */
 
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 317fc59b512c..2aa6ce4bf159 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -143,8 +143,9 @@ static inline unsigned long __read_cr4(void)
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
-#else
+#endif
 
+#ifndef CONFIG_PARAVIRT_XXL
 static inline unsigned long read_cr0(void)
 {
 	return native_read_cr0();
@@ -154,7 +155,9 @@ static inline void write_cr0(unsigned long x)
 {
 	native_write_cr0(x);
 }
+#endif
 
+#ifndef CONFIG_PARAVIRT
 static inline unsigned long read_cr2(void)
 {
 	return native_read_cr2();
@@ -178,7 +181,9 @@ static inline void write_cr3(unsigned long x)
 {
 	native_write_cr3(x);
 }
+#endif
 
+#ifndef CONFIG_PARAVIRT_XXL
 static inline void __write_cr4(unsigned long x)
 {
 	native_write_cr4(x);
@@ -208,7 +213,7 @@ static inline void load_gs_index(unsigned selector)
 
 #endif
 
-#endif/* CONFIG_PARAVIRT */
+#endif/* CONFIG_PARAVIRT_XXL */
 
 static inline void clflush(volatile void *__p)
 {
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 37e323f3d8c9..0fe233d98d17 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -68,7 +68,9 @@ void common(void) {
 	BLANK();
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
+#ifdef CONFIG_PARAVIRT_XXL
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
+#endif
 	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
 #endif
 
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 3384b03e717f..2a15d420a84d 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -21,9 +21,11 @@ static char syscalls_ia32[] = {
 int main(void)
 {
 #ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
 	       cpu.usergs_sysret64);
 	OFFSET(PV_CPU_swapgs, paravirt_patch_template, cpu.swapgs);
+#endif
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c4da9c23a96c..d45cd5e0fb11 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1240,7 +1240,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	 * ESPFIX issue, we can change this.
 	 */
 #ifdef CONFIG_X86_32
-# ifdef CONFIG_PARAVIRT
+# ifdef CONFIG_PARAVIRT_XXL
 	do {
 		extern void native_iret(void);
 		if (pv_ops.cpu.iret == native_iret)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 15ebc2fc166e..a5bd72a0ee1a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -31,6 +31,8 @@
 #define GET_CR2_INTO(reg) GET_CR2_INTO_RAX ; movq %rax, reg
 #else
 #define GET_CR2_INTO(reg) movq %cr2, reg
+#endif
+#ifndef CONFIG_PARAVIRT_XXL
 #define INTERRUPT_RETURN iretq
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ce0e28506942..1d5f40cc872a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -101,6 +101,7 @@ static unsigned paravirt_patch_call(void *insnbuf, const void *target,
 	return 5;
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 static unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 				   unsigned long addr, unsigned len)
 {
@@ -119,6 +120,7 @@ static unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 
 	return 5;
 }
+#endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
@@ -150,10 +152,12 @@ unsigned paravirt_patch_default(u8 type, void *insnbuf,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
+#ifdef CONFIG_PARAVIRT_XXL
 	else if (type == PARAVIRT_PATCH(cpu.iret) ||
 		 type == PARAVIRT_PATCH(cpu.usergs_sysret64))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insnbuf, opfunc, addr, len);
+#endif
 	else
 		/* Otherwise call the function. */
 		ret = paravirt_patch_call(insnbuf, opfunc, addr, len);
@@ -262,6 +266,7 @@ void paravirt_flush_lazy_mmu(void)
 	preempt_enable();
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 void paravirt_start_context_switch(struct task_struct *prev)
 {
 	BUG_ON(preemptible());
@@ -282,6 +287,7 @@ void paravirt_end_context_switch(struct task_struct *next)
 	if (test_and_clear_ti_thread_flag(task_thread_info(next), TIF_LAZY_MMU_UPDATES))
 		arch_enter_lazy_mmu_mode();
 }
+#endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 {
@@ -320,6 +326,9 @@ struct paravirt_patch_template pv_ops = {
 	.time.steal_clock	= native_steal_clock,
 
 	/* Cpu ops. */
+	.cpu.io_delay		= native_io_delay,
+
+#ifdef CONFIG_PARAVIRT_XXL
 	.cpu.cpuid		= native_cpuid,
 	.cpu.get_debugreg	= native_get_debugreg,
 	.cpu.set_debugreg	= native_set_debugreg,
@@ -361,10 +370,10 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.swapgs		= native_swapgs,
 
 	.cpu.set_iopl_mask	= native_set_iopl_mask,
-	.cpu.io_delay		= native_io_delay,
 
 	.cpu.start_context_switch	= paravirt_nop,
 	.cpu.end_context_switch		= paravirt_nop,
+#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Irq ops. */
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
@@ -464,10 +473,12 @@ struct paravirt_patch_template pv_ops = {
 #endif
 };
 
+#ifdef CONFIG_PARAVIRT_XXL
 /* At this point, native_get/set_debugreg has real function entries */
 NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
+#endif
 
 EXPORT_SYMBOL_GPL(pv_ops);
 EXPORT_SYMBOL_GPL(pv_info);
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 026fa43e9261..5a20aa56efc0 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -5,7 +5,9 @@ DEF_NATIVE(irq, irq_disable, "cli");
 DEF_NATIVE(irq, irq_enable, "sti");
 DEF_NATIVE(irq, restore_fl, "push %eax; popf");
 DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
+#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(cpu, iret, "iret");
+#endif
 DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
@@ -45,7 +47,9 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(irq, irq_enable);
 		PATCH_SITE(irq, restore_fl);
 		PATCH_SITE(irq, save_fl);
+#ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(cpu, iret);
+#endif
 		PATCH_SITE(mmu, read_cr2);
 		PATCH_SITE(mmu, read_cr3);
 		PATCH_SITE(mmu, write_cr3);
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 582e893728e8..461aba038ada 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -10,10 +10,12 @@ DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
 DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
 DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
 DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
+#ifdef CONFIG_PARAVIRT_XXL
 DEF_NATIVE(cpu, wbinvd, "wbinvd");
 
 DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
 DEF_NATIVE(cpu, swapgs, "swapgs");
+#endif
 
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
@@ -53,12 +55,14 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 		PATCH_SITE(irq, save_fl);
 		PATCH_SITE(irq, irq_enable);
 		PATCH_SITE(irq, irq_disable);
+#ifdef CONFIG_PARAVIRT_XXL
 		PATCH_SITE(cpu, usergs_sysret64);
 		PATCH_SITE(cpu, swapgs);
+		PATCH_SITE(cpu, wbinvd);
+#endif
 		PATCH_SITE(mmu, read_cr2);
 		PATCH_SITE(mmu, read_cr3);
 		PATCH_SITE(mmu, write_cr3);
-		PATCH_SITE(cpu, wbinvd);
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(lock.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {

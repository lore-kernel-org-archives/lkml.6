Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D5C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CEC2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 08:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To5e+L/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CEC2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJTREM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 13:04:12 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46051 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeJTREM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 13:04:12 -0400
Received: by mail-wr1-f42.google.com with SMTP id f17-v6so7977369wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yIAm/j9PhmJvuNbiQsXwnMICu1ByUdYYQ3hH15oyggE=;
        b=To5e+L/OhU+qeX9dtgUGGqtJJJ2xeGjS3re/mF7DZlYHkOAgVSwShXuNSeK+2X8CVi
         QVHe7z8GUOElOdtN8aZugn3KG2sFoq5RPdv9ucCT+wrA/kusg2kQfRbsCDLVGpo32lE6
         nZ4C4zOYrPQGHmg872x3cva9NOypmuAggpwYY+TP30j4E/BRldvucJrN1qYTIy0HAJSD
         GFI0HWzciPPQDD92t9ci0cIxoSouU438pQ3J1IZysNP4IChn28abJAI8H6eF7ZAzygL5
         nC1QtJK96ZJQTtx84pa8dYiFeg/6eNXzb0/VvKfZXKcx5NU0A7Ph9HDWiNvXHpvKSUdb
         pN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=yIAm/j9PhmJvuNbiQsXwnMICu1ByUdYYQ3hH15oyggE=;
        b=pRdR+2qOTjD5OeEeZU+JFJlpbfXp3uT1TjG+KYwV8NYNJU32p1YUe2FLA0nuOU3rVm
         ExUkqq62NwXABMrwXE/R4QAh2nw0J37NFTYwuNHD2bk7FwPkciLyLtyw+HYltzFpPGV7
         u0vU9w04UfvGGWaGpe50M8uRNjpKVMWx3T8DtVBmaWXaxq7kbsl4bVYtSdoN0RRYHiNW
         lI/AKiv8lUadsjjiywP9E3n2YRSVFb52GMjxYpEAO0Ju5xvAOQcdGirpAihAmemV0xnx
         rO/V+vL2adNgneWYFrYM8NBB8eTrPpr03GsH9sdsvUrn59h2XulH7VE97d37AGxiIsJO
         25sw==
X-Gm-Message-State: ABuFfohuiPE7uKBfbUBvINf1p7W1reasA5UwtiZPJJOqePcEQGVcevH3
        Rgm2vLBTG+v4pbBfy1y2nfs=
X-Google-Smtp-Source: ACcGV6320/enTpUgNy+EuRsJ/dhiELmIlHlWvZK1vyCoC8wiaMYQY/MZJrB71zjI91diW0HyAjMDLw==
X-Received: by 2002:a5d:4d4b:: with SMTP id a11-v6mr39084324wru.40.1540025668382;
        Sat, 20 Oct 2018 01:54:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r2-v6sm14967079wrq.1.2018.10.20.01.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 01:54:27 -0700 (PDT)
Date:   Sat, 20 Oct 2018 10:54:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20181020085425.GA29087@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 485734f3fc77c1eb77ffe138c027b9a4bf0178f3 x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit kernels

It's 4 misc fixes, 3 build warning fixes and 3 comment fixes.

In hindsight I'd have left out the 3 comment fixes to make the pull 
request look less scary at such a late point in the cycle. :-/

 Thanks,

	Ingo

------------------>
Andy Lutomirski (1):
      x86/entry/64: Further improve paranoid_entry comments

Christoph Hellwig (1):
      x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit kernels

Dave Hansen (1):
      x86/entry: Add some paranoid entry/exit CR3 handling comments

Jan Kiszka (1):
      x86/entry/32: Clear the CS high bits

Nathan Chancellor (2):
      x86/time: Correct the attribute on jiffies' definition
      x86/boot: Add -Wno-pointer-sign to KBUILD_CFLAGS

Peter Zijlstra (2):
      x86/tsc: Force inlining of cyc2ns bits
      x86/percpu: Fix this_cpu_read()

Sebastian Andrzej Siewior (2):
      x86/fpu: Remove second definition of fpu in __fpu__restore_sig()
      x86/fpu: Fix i486 + no387 boot crash by only saving FPU registers on context switch if there is an FPU


 arch/x86/boot/compressed/Makefile   |  1 +
 arch/x86/entry/entry_32.S           | 13 +++++++------
 arch/x86/entry/entry_64.S           | 13 +++++++++++++
 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/include/asm/percpu.h       |  8 ++++----
 arch/x86/kernel/fpu/signal.c        |  1 -
 arch/x86/kernel/pci-swiotlb.c       |  2 --
 arch/x86/kernel/time.c              |  2 +-
 arch/x86/kernel/tsc.c               |  6 +++---
 9 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 28764dacf018..466f66c8a7f8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -37,6 +37,7 @@ KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
+KBUILD_CFLAGS += -Wno-pointer-sign
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2767c625a52c..fbbf1ba57ec6 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -389,6 +389,13 @@
 	 * that register for the time this macro runs
 	 */
 
+	/*
+	 * The high bits of the CS dword (__csh) are used for
+	 * CS_FROM_ENTRY_STACK and CS_FROM_USER_CR3. Clear them in case
+	 * hardware didn't do this for us.
+	 */
+	andl	$(0x0000ffff), PT_CS(%esp)
+
 	/* Are we on the entry stack? Bail out if not! */
 	movl	PER_CPU_VAR(cpu_entry_area), %ecx
 	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
@@ -407,12 +414,6 @@
 	/* Load top of task-stack into %edi */
 	movl	TSS_entry2task_stack(%edi), %edi
 
-	/*
-	 * Clear unused upper bits of the dword containing the word-sized CS
-	 * slot in pt_regs in case hardware didn't clear it for us.
-	 */
-	andl	$(0x0000ffff), PT_CS(%esp)
-
 	/* Special case - entry from kernel mode via entry stack */
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %ecx		# mix EFLAGS and CS
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..f95dcb209fdf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1187,6 +1187,16 @@ ENTRY(paranoid_entry)
 	xorl	%ebx, %ebx
 
 1:
+	/*
+	 * Always stash CR3 in %r14.  This value will be restored,
+	 * verbatim, at exit.  Needed if paranoid_entry interrupted
+	 * another entry that already switched to the user CR3 value
+	 * but has not yet returned to userspace.
+	 *
+	 * This is also why CS (stashed in the "iret frame" by the
+	 * hardware at entry) can not be used: this may be a return
+	 * to kernel code, but with a user CR3 value.
+	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
@@ -1211,11 +1221,13 @@ ENTRY(paranoid_exit)
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
+	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	SWAPGS_UNSAFE_STACK
 	jmp	.Lparanoid_exit_restore
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
+	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
@@ -1626,6 +1638,7 @@ end_repeat_nmi:
 	movq	$-1, %rsi
 	call	do_nmi
 
+	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
 	testl	%ebx, %ebx			/* swapgs needed? */
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index a38bf5a1e37a..69dcdf195b61 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -528,7 +528,7 @@ static inline void fpregs_activate(struct fpu *fpu)
 static inline void
 switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
-	if (old_fpu->initialized) {
+	if (static_cpu_has(X86_FEATURE_FPU) && old_fpu->initialized) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
 			old_fpu->last_cpu = -1;
 		else
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e9202a0de8f0..1a19d11cfbbd 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -185,22 +185,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(1)",%0"		\
+		asm volatile(op "b "__percpu_arg(1)",%0"\
 		    : "=q" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(1)",%0"		\
+		asm volatile(op "w "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(1)",%0"		\
+		asm volatile(op "l "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(1)",%0"		\
+		asm volatile(op "q "__percpu_arg(1)",%0"\
 		    : "=r" (pfo_ret__)			\
 		    : "m" (var));			\
 		break;					\
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 23f1691670b6..61a949d84dfa 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -314,7 +314,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * thread's fpu state, reconstruct fxstate from the fsave
 		 * header. Validate and sanitize the copied state.
 		 */
-		struct fpu *fpu = &tsk->thread.fpu;
 		struct user_i387_ia32_struct env;
 		int err = 0;
 
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 661583662430..71c0b01d93b1 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_override,
 int __init pci_swiotlb_detect_4gb(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-#ifdef CONFIG_X86_64
 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
 		swiotlb = 1;
-#endif
 
 	/*
 	 * If SME is active then swiotlb will be set to 1 so that bounce
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index be01328eb755..fddaefc51fb6 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -25,7 +25,7 @@
 #include <asm/time.h>
 
 #ifdef CONFIG_X86_64
-__visible volatile unsigned long jiffies __cacheline_aligned = INITIAL_JIFFIES;
+__visible volatile unsigned long jiffies __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 #endif
 
 unsigned long profile_pc(struct pt_regs *regs)
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index b52bd2b6cdb4..6d5dc5dabfd7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -58,7 +58,7 @@ struct cyc2ns {
 
 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);
 
-void cyc2ns_read_begin(struct cyc2ns_data *data)
+void __always_inline cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 	int seq, idx;
 
@@ -75,7 +75,7 @@ void cyc2ns_read_begin(struct cyc2ns_data *data)
 	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
 }
 
-void cyc2ns_read_end(void)
+void __always_inline cyc2ns_read_end(void)
 {
 	preempt_enable_notrace();
 }
@@ -104,7 +104,7 @@ void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+static __always_inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
 	unsigned long long ns;

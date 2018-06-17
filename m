Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE09C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29C208AF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="d3Hq+XtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C29C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757002AbeFQAeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:34:18 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35735 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756937AbeFQAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:34:16 -0400
Received: by mail-qk0-f196.google.com with SMTP id d130-v6so7662709qkc.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=K1tBY0VMfQmahb8LltTsZ7nU3tNuyNCfdGxayZhRCgQ=;
        b=d3Hq+XtURhaIxSmWFiX1S8dILuarsPvOcuryoTQq0Uzg/pGR5Lk18knWTq/ZLw3uOC
         Ke7n10bL0rCdvT+9Ucl8A+8QRFwwYpf3WyGfGgEmbMrKEYoBsUFLl3bUOQViUlgyVSjv
         wEPEqS8REZXpQYUWJAzqEQrdAI6bCej0L3YJpbEs3O7jQ7uyf2ydr/QHesK8WWC4SbRq
         tJ9S8vXDqxKAILQLzfTgZNBPOeve4K9GtUbKIhB+vw+YKxR91bmlSpf6vJ398W1FJtCi
         R1DLNemA1XCN8xaxtDs51UmytRyNbcv4YIrzrHnWqLAh6uSdwDz1zzk26ErpeO+HAaoM
         DhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K1tBY0VMfQmahb8LltTsZ7nU3tNuyNCfdGxayZhRCgQ=;
        b=QDCxLemkeZZOZNNj8zsjK9qPOuXLBnvyVsQrMwtbZ8YosXoIUQj6LmeSmcoP9+ndxB
         DZwZomF5WIEtmj+NhxSTk+FTtJU2CZsiZOOD2/VShSyZpaZbcetPFCh/tTZYOws+MOMh
         1EP14WiJsvdwGpCJKNscwmBihP5z8S3hJdxf8XzfJtHZZYV+0IOLXuRtmpfQpgSIqnUt
         P00EhaO0+n6/9DFWtkF/c3G/tquRJjbNrZFy5ncTT95Mdro34wIOmVHZKF3G2BpQvpKj
         SH8rlqWtAL2bMSwMh1syC/cL5VZy32856IFdrjAOQTpBsxKKAVSIHPiFmNqi8ttb4gqZ
         Q7jg==
X-Gm-Message-State: APt69E0cVhkg+s6Msin+PZQdq0veRWsmZv5OmCjMjNTRyXBLRLxjJMEW
        JBbJodNRg/TO/Qlx2FM3jotyvaAliyM=
X-Google-Smtp-Source: ADUXVKKwFZLiVRx1HlxlfonlLT37+5gvuhFf/tMxf9FyBHPnRfG8rWitlGWQ267hMJv6o/18jwdT8w==
X-Received: by 2002:a37:5705:: with SMTP id l5-v6mr6024350qkb.84.1529195655353;
        Sat, 16 Jun 2018 17:34:15 -0700 (PDT)
Received: from localhost.localdomain (96-86-104-61-static.hfc.comcastbusiness.net. [96.86.104.61])
        by smtp.gmail.com with ESMTPSA id a62-v6sm10824438qka.11.2018.06.16.17.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Jun 2018 17:34:14 -0700 (PDT)
From:   Keno Fischer <keno@juliacomputing.com>
X-Google-Original-From: Keno Fischer <keno@alumni.harvard.edu>
To:     linux-kernel@vger.kernel.org
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0 per-thread
Date:   Sat, 16 Jun 2018 20:33:02 -0400
Message-Id: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
X-Mailer: git-send-email 2.8.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keno Fischer <keno@juliacomputing.com>

The rr (http://rr-project.org/) debugger provides user space
record-and-replay functionality by carefully controlling the process
environment in order to ensure completely deterministic execution
of recorded traces. The recently added ARCH_SET_CPUID arch_prctl
allows rr to move traces across (Intel) machines, by allowing cpuid
invocations to be reliably recorded and replayed. This works very
well, with one catch: It is currently not possible to replay a
recording from a machine supporting a smaller set of XCR0 state
components on one supporting a larger set. This is because the
value of XCR0 is obersevable in userspace (either by explicit
xgetbv or by looking at the result of xsave) and since glibc
does oberseve this value, replay divergence is almost immediate.
I also suspect that people intrested in process (or container)
live-migration may eventually care about this if a migration happens
in between a userspace xsave and a corresponding xrstor.

We encounter this problem quite frequently since most of our users
are using pre-Skylake systems (and thus don't support the AVX512
state components), while we recently upgraded our main development
machines to Skylake.

This patch attempts to provide a way disable XCR0 state components
on a per-thread basis, such that rr may use this feature to emulate
the recording machine's XCR0 for the replayed process.

We do this by providing a new ARCH_SET_XCR0 arch_prctl that takes
as its argument the desired XCR0 value. The system call fails if:
 - XSAVE is not available
 - The user attempts to enable a state component that would not regularly
   be enabled by the kernel.
 - The value of XCR0 is illegal (in the sense that setting it would
   cause a fault).
 - Any state component being disabled is not in its initial state.

The last restriction is debatable, but it seemed sensible to me,
since it means the kernel need not be in the business of trying to
maintain the disabled state components when the ordinary xsave/xrestor
will no longer save/restore them.

The patch does not currently provide a corresponding ARCH_GET_XCR0,
since the `xgetbv` instruction fulfills this purpose. However, we
may want to provide this for consistency. It may also be useful (and
perhaps more useful) to provide a mechanism to obtain the kernel's
XCR0 (i.e. the upper bound on which bits are allowed to be set through
this interface).

On the kernel side, this value is stored as a mask, rather than a value
to set. The thought behind this was to be defensive about new state
components being added but forgetting to update the validity check
in the arch_prctl. However, getting this wrong in either direction
is probably bad (e.g. if Intel added an AVX1024 extension that always
required AVX512, then this would be the wrong way to be defensive about
it), so I'd appreciate some advice on which would be preferred.

Please take this patch as an RFC that I hope is sufficient to enable
discussion about this feature, rather than a complete patch.
In particular, this patch is missing:
 - Cleanup
 - A selftest exercising all the corner cases
 - There's code sharing opportunities with KVM (which has to provide
   similar functionality for virtual machines modifying XCR0), which
   I did not take advantage of in this patch to keep the changes local.
   A full patch would probably involve some refactoring there.

There is one remaining TODO in the code, which has to do with the
xcomp_bv xsave header. The `xrstors` instructions requires that
no bits in this headers field be set that are not active in XCR0.
However, this unfortunately means that changing the value of XCR0
can change the layout of the compacted xsave area, which so far the
kernel does not do anywhere else (except for some handling in the
KVM context). For my use case, it would be sufficient to simply disallow
any value of XCR0 with "holes" in it, that would change the layout
to anything other than a strict prefix, but I would appreciate
hearing any alternative solutions you may have.

Please also let me know if I missed a fundamental way in which this
causes a problem. I realize that this is a very sensitive part of
the kernel code. Since this patch changes XCR0, any xsave/xrestor or any
use of XCR0-enabled features in kernel space, not guarded by
kernel_fpu_begin() (which I modified for this patch set), would cause
a problem. I don't have a sufficiently wide view of the kernel
to know if there are any such uses, so please let me know if I missed
something.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 arch/x86/include/asm/fpu/xstate.h  |   1 +
 arch/x86/include/asm/processor.h   |   2 +
 arch/x86/include/asm/thread_info.h |   5 +-
 arch/x86/include/uapi/asm/prctl.h  |   2 +
 arch/x86/kernel/fpu/core.c         |  10 ++-
 arch/x86/kernel/fpu/xstate.c       |   3 +-
 arch/x86/kernel/process.c          | 125 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/process_64.c       |  16 ++---
 8 files changed, 152 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 48581988d78c..d8e5547ec5b6 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -47,6 +47,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
 
 void fpu__xstate_clear_all_cpu_caps(void);
 void *get_xsave_addr(struct xregs_state *xsave, int xstate);
+int xfeature_size(int xfeature_nr);
 const void *get_xsave_field_ptr(int xstate_field);
 int using_compacted_format(void);
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index e28add6b791f..60d54731af66 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -479,6 +479,8 @@ struct thread_struct {
 	unsigned long           debugreg6;
 	/* Keep track of the exact dr7 value set by the user */
 	unsigned long           ptrace_dr7;
+	/* Keeps track of which XCR0 bits the used wants masked out */
+	unsigned long           xcr0_mask;
 	/* Fault info: */
 	unsigned long		cr2;
 	unsigned long		trap_nr;
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2ff2a30a264f..e5f928f8ef93 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -86,6 +86,7 @@ struct thread_info {
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
+#define TIF_MASKXCR0		14	/* XCR0 is maked in this thread */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
@@ -113,6 +114,7 @@ struct thread_info {
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
+#define _TIF_MASKXCR0		(1 << TIF_MASKXCR0)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
@@ -146,7 +148,8 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
+	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|         \
+	 _TIF_SSBD|_TIF_MASKXCR0)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..5a31a8420baa 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,8 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012
 
+#define ARCH_SET_XCR0       0x1021
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f92a6593de1e..e8e4150319f8 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -101,6 +101,8 @@ void __kernel_fpu_begin(void)
 	kernel_fpu_disable();
 
 	if (fpu->initialized) {
+		if (unlikely(test_thread_flag(TIF_MASKXCR0)))
+			xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
 		/*
 		 * Ignore return value -- we don't care if reg state
 		 * is clobbered.
@@ -116,9 +118,15 @@ void __kernel_fpu_end(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 
-	if (fpu->initialized)
+	if (fpu->initialized) {
 		copy_kernel_to_fpregs(&fpu->state);
 
+		if (unlikely(test_thread_flag(TIF_MASKXCR0))) {
+			xsetbv(XCR_XFEATURE_ENABLED_MASK,
+				   xfeatures_mask & ~current->thread.xcr0_mask);
+		}
+	}
+
 	kernel_fpu_enable();
 }
 EXPORT_SYMBOL(__kernel_fpu_end);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7642d3..cb9a9e57feae 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -454,7 +454,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	return ebx;
 }
 
-static int xfeature_size(int xfeature_nr)
+int xfeature_size(int xfeature_nr)
 {
 	u32 eax, ebx, ecx, edx;
 
@@ -462,6 +462,7 @@ static int xfeature_size(int xfeature_nr)
 	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
 	return eax;
 }
+EXPORT_SYMBOL_GPL(xfeature_size);
 
 /*
  * 'XSAVES' implies two different things:
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 30ca2d1a9231..4a774602d34a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -244,6 +244,55 @@ static int set_cpuid_mode(struct task_struct *task, unsigned long cpuid_enabled)
 	return 0;
 }
 
+static void change_xcr0_mask(unsigned long prev_mask, unsigned long next_mask)
+{
+	unsigned long deactivated_features = next_mask & ~prev_mask;
+
+	if (deactivated_features) {
+		/*
+		 * Clear any state components that were active before,
+		 * but are not active now (xrstor would not touch
+		 * it otherwise, exposing the previous values).
+		 */
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+		__copy_kernel_to_fpregs(&init_fpstate, deactivated_features);
+	}
+
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask & ~next_mask);
+}
+
+void reset_xcr0_mask(void)
+{
+	preempt_disable();
+	if (test_and_clear_thread_flag(TIF_MASKXCR0)) {
+		current->thread.xcr0_mask = 0;
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+	}
+	preempt_enable();
+}
+
+void set_xcr0_mask(unsigned long mask)
+{
+	if (mask == 0) {
+		reset_xcr0_mask();
+	} else {
+		struct xregs_state *xsave = &current->thread.fpu.state.xsave;
+
+		preempt_disable();
+
+		change_xcr0_mask(current->thread.xcr0_mask, mask);
+
+		xsave->header.xfeatures = xsave->header.xfeatures & ~mask;
+		/* TODO: We may have to compress the xstate here */
+		xsave->header.xcomp_bv = xsave->header.xcomp_bv & ~mask;
+
+		set_thread_flag(TIF_MASKXCR0);
+		current->thread.xcr0_mask = mask;
+
+		preempt_enable();
+	}
+}
+
 /*
  * Called immediately after a successful exec.
  */
@@ -252,6 +301,8 @@ void arch_setup_new_exec(void)
 	/* If cpuid was previously disabled for this task, re-enable it. */
 	if (test_thread_flag(TIF_NOCPUID))
 		enable_cpuid();
+	if (test_thread_flag(TIF_MASKXCR0))
+		reset_xcr0_mask();
 }
 
 static inline void switch_to_bitmap(struct tss_struct *tss,
@@ -455,6 +506,10 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 
 	if ((tifp ^ tifn) & _TIF_SSBD)
 		__speculative_store_bypass_update(tifn);
+
+	if ((tifp | tifn) & _TIF_MASKXCR0 &&
+	    prev->xcr0_mask != next->xcr0_mask)
+		change_xcr0_mask(prev->xcr0_mask, next->xcr0_mask);
 }
 
 /*
@@ -783,14 +838,80 @@ unsigned long get_wchan(struct task_struct *p)
 	return ret;
 }
 
+static int xcr0_is_legal(unsigned long xcr0)
+{
+	// Conservatively disallow anything above bit 9,
+	// to avoid accidentally allowing the disabling of
+	// new features without updating these checks
+	if (xcr0 & ~((1 << 10) - 1))
+		return 0;
+	if (!(xcr0 & XFEATURE_MASK_FP))
+		return 0;
+	if ((xcr0 & XFEATURE_MASK_YMM) && !(xcr0 & XFEATURE_MASK_SSE))
+		return 0;
+	if ((!(xcr0 & XFEATURE_MASK_BNDREGS)) !=
+	    (!(xcr0 & XFEATURE_MASK_BNDCSR)))
+		return 0;
+	if (xcr0 & XFEATURE_MASK_AVX512) {
+		if (!(xcr0 & XFEATURE_MASK_YMM))
+			return 0;
+		if ((xcr0 & XFEATURE_MASK_AVX512) != XFEATURE_MASK_AVX512)
+			return 0;
+	}
+	return 1;
+}
+
+static int xstate_is_initial(unsigned long mask)
+{
+	int i, j;
+	unsigned long max_bit = __ffs(mask);
+
+	for (i = 0; i < max_bit; ++i) {
+		if (mask & (1 << i)) {
+			char *xfeature_addr = (char *)get_xsave_addr(
+					&current->thread.fpu.state.xsave,
+					1 << i);
+			unsigned long feature_size = xfeature_size(i);
+
+			for (j = 0; j < feature_size; ++j) {
+				if (xfeature_addr[j] != 0)
+					return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 long do_arch_prctl_common(struct task_struct *task, int option,
-			  unsigned long cpuid_enabled)
+			  unsigned long arg2)
 {
 	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
-		return set_cpuid_mode(task, cpuid_enabled);
+		return set_cpuid_mode(task, arg2);
+	case ARCH_SET_XCR0: {
+		unsigned long mask = xfeatures_mask & ~arg2;
+
+		if (!use_xsave())
+			return -ENODEV;
+
+		if (arg2 & ~xfeatures_mask)
+			return -ENODEV;
+
+		if (!xcr0_is_legal(arg2))
+			return -EINVAL;
+
+		/*
+		 * We require that any state components being disabled by
+		 * this prctl be currently in their initial state.
+		 */
+		if (!xstate_is_initial(mask))
+			return -EPERM;
+
+		set_xcr0_mask(mask);
+		return 0;
+	}
 	}
 
 	return -EINVAL;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 12bb445fb98d..d220d93f5ffa 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -469,6 +469,15 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	load_seg_legacy(prev->gsindex, prev->gsbase,
 			next->gsindex, next->gsbase, GS);
 
+	/*
+	 * Now maybe reload the debug registers and handle I/O bitmaps.
+	 * N.B.: This may change XCR0 and must thus happen before,
+	 * `switch_fpu_finish`.
+	 */
+	if (unlikely(task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT ||
+		     task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV))
+		__switch_to_xtra(prev_p, next_p, tss);
+
 	switch_fpu_finish(next_fpu, cpu);
 
 	/*
@@ -480,13 +489,6 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Reload sp0. */
 	update_sp0(next_p);
 
-	/*
-	 * Now maybe reload the debug registers and handle I/O bitmaps
-	 */
-	if (unlikely(task_thread_info(next_p)->flags & _TIF_WORK_CTXSW_NEXT ||
-		     task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW_PREV))
-		__switch_to_xtra(prev_p, next_p, tss);
-
 #ifdef CONFIG_XEN_PV
 	/*
 	 * On Xen PV, IOPL bits in pt_regs->flags have no effect, and
-- 
2.14.1


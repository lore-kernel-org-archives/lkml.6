Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146574-1526318279-2-12806059804871019020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526318279; b=aXoiX/RZ0yFxLuObU+FSHE0XEasi2pHSpB1EHzg28jxRWLWVwE
    hnNxwupdct/2/QwpHGyfFBJJagqnqjf4Hu5c8Ee5b5cPQe8GNsp4784DdYMw4xTN
    rwIlFnSc7G5QV3sVXkh/eJsbzZqvbLl/pr2LUgFImyPJC0t5d4pZKxoONkVXk+Hn
    JwKTUH/UhNE9DFuDHaXyUwo6dz15yDAucm2K7lLuQL/NgsCJ4mSDPhM8ZovJY+ef
    dRL4AhFt7buDt28fig3m0ukBXQxkyv9zOSgPkwErAC2lqVgatKVY5ExSC6pmi6OW
    e8kYpr2H4x6phS46HthFxAgXlWBUNZXbzaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526318279; bh=
    PHngfP9eriLpTGm3sS12Vaa3vwsW2kPmRa6YFhSizqU=; b=IKGdNbQMnOnDX0om
    0FT/V1BtoYAa7hNwb6RKrPcNS3Uj8HdkUGr5askwTIVskYZpNPiCBgjQmK2Db8b8
    dWguUP1a0sKQNYnsc0x2KP913L13YsjStgcvzK/Yd7QQQBVlhDojZF3B2IEfd4tH
    l8PnnbSxmn4YeyRx7UpwGK70xOpS1r0JJxMbUF1cEWjApfC0vFqGLePtmNoyNwk4
    mU1s3MtNCoJeZFeE7JdfVBaF59f7FY3gigyXB+QaKHy0pfbWgehPaQWhwzJWrUxO
    xfWcQ4xVb4krJSUvGCJyB0d44JJ5NK3t9f/3lQspQZ7ewi+XhEGw9hMCHU4CTtZh
    ps313A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMcwhXx+BIHjaJa5otCN5fUidA44m7mfe0c9xzRLZBozclERGVZ+YBDAVGRDXDMsz0uPkIuQldOtBMOjgCVH/F8KuaGqyv8QnwqKHFy8lpjulSdL1Buo
    g75XK/fB15wC1FMMCpdmkQlz5jdajNlwyaxpxitPzRo2Gr2tw1UWIgt6lKBuSnR30dBnruBylyO4JgzftCJHFYjw2L/X4o6tYLjUWn0JIe7k/iWEZ7rDNgEb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=kReFUWGeICIn0JJdUo4A:9
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=FUarYpL4UH3yWsho8X8J:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeENRRz (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 13:17:55 -0400
Received: from foss.arm.com ([217.140.101.70]:46980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752588AbeENRPb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 13:15:31 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH 06/11] powerpc: Remove unused task argument from prctl functions
Date: Mon, 14 May 2018 18:14:22 +0100
Message-Id: <1526318067-4964-7-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some powerpc-specific prctl backends take a task argument that is
redundant, since the only thing ever passed is "current".

This patch gets rid of the redundant arguments.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/processor.h | 16 ++++++++--------
 arch/powerpc/kernel/process.c        | 30 +++++++++++++++---------------
 kernel/sys.c                         | 12 ++++++------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c4b36a4..313dec1 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -407,17 +407,17 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
 /* Get/set floating-point exception mode */
-#define GET_FPEXC_CTL(tsk, adr) get_fpexc_mode((tsk), (adr))
-#define SET_FPEXC_CTL(tsk, val) set_fpexc_mode((tsk), (val))
+#define GET_FPEXC_CTL(adr) get_fpexc_mode((adr))
+#define SET_FPEXC_CTL(val) set_fpexc_mode((val))
 
-extern int get_fpexc_mode(struct task_struct *tsk, unsigned long adr);
-extern int set_fpexc_mode(struct task_struct *tsk, unsigned int val);
+extern int get_fpexc_mode(unsigned long adr);
+extern int set_fpexc_mode(unsigned int val);
 
-#define GET_ENDIAN(tsk, adr) get_endian((tsk), (adr))
-#define SET_ENDIAN(tsk, val) set_endian((tsk), (val))
+#define GET_ENDIAN(adr) get_endian((adr))
+#define SET_ENDIAN(val) set_endian((val))
 
-extern int get_endian(struct task_struct *tsk, unsigned long adr);
-extern int set_endian(struct task_struct *tsk, unsigned int val);
+extern int get_endian(unsigned long adr);
+extern int set_endian(unsigned int val);
 
 #define GET_UNALIGN_CTL(tsk, adr)	get_unalign_ctl((tsk), (adr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13..0fcb2f5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1896,9 +1896,9 @@ EXPORT_SYMBOL(start_thread);
 #define PR_FP_ALL_EXCEPT (PR_FP_EXC_DIV | PR_FP_EXC_OVF | PR_FP_EXC_UND \
 		| PR_FP_EXC_RES | PR_FP_EXC_INV)
 
-int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
+int set_fpexc_mode(unsigned int val)
 {
-	struct pt_regs *regs = tsk->thread.regs;
+	struct pt_regs *regs = current->thread.regs;
 
 	/* This is a bit hairy.  If we are an SPE enabled  processor
 	 * (have embedded fp) we store the IEEE exception enable flags in
@@ -1919,8 +1919,8 @@ int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
 			 * anyway to restore the prctl settings from
 			 * the saved environment.
 			 */
-			tsk->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
-			tsk->thread.fpexc_mode = val &
+			current->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
+			current->thread.fpexc_mode = val &
 				(PR_FP_EXC_SW_ENABLE | PR_FP_ALL_EXCEPT);
 			return 0;
 		} else {
@@ -1938,18 +1938,18 @@ int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
 	 * them does not change anything */
 	if (val > PR_FP_EXC_PRECISE)
 		return -EINVAL;
-	tsk->thread.fpexc_mode = __pack_fe01(val);
+	current->thread.fpexc_mode = __pack_fe01(val);
 	if (regs != NULL && (regs->msr & MSR_FP) != 0)
 		regs->msr = (regs->msr & ~(MSR_FE0|MSR_FE1))
-			| tsk->thread.fpexc_mode;
+			| current->thread.fpexc_mode;
 	return 0;
 }
 
-int get_fpexc_mode(struct task_struct *tsk, unsigned long adr)
+int get_fpexc_mode(unsigned long adr)
 {
 	unsigned int val;
 
-	if (tsk->thread.fpexc_mode & PR_FP_EXC_SW_ENABLE)
+	if (current->thread.fpexc_mode & PR_FP_EXC_SW_ENABLE)
 #ifdef CONFIG_SPE
 		if (cpu_has_feature(CPU_FTR_SPE)) {
 			/*
@@ -1964,21 +1964,21 @@ int get_fpexc_mode(struct task_struct *tsk, unsigned long adr)
 			 * anyway to restore the prctl settings from
 			 * the saved environment.
 			 */
-			tsk->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
-			val = tsk->thread.fpexc_mode;
+			current->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
+			val = current->thread.fpexc_mode;
 		} else
 			return -EINVAL;
 #else
 		return -EINVAL;
 #endif
 	else
-		val = __unpack_fe01(tsk->thread.fpexc_mode);
+		val = __unpack_fe01(current->thread.fpexc_mode);
 	return put_user(val, (unsigned int __user *) adr);
 }
 
-int set_endian(struct task_struct *tsk, unsigned int val)
+int set_endian(unsigned int val)
 {
-	struct pt_regs *regs = tsk->thread.regs;
+	struct pt_regs *regs = current->thread.regs;
 
 	if ((val == PR_ENDIAN_LITTLE && !cpu_has_feature(CPU_FTR_REAL_LE)) ||
 	    (val == PR_ENDIAN_PPC_LITTLE && !cpu_has_feature(CPU_FTR_PPC_LE)))
@@ -1997,9 +1997,9 @@ int set_endian(struct task_struct *tsk, unsigned int val)
 	return 0;
 }
 
-int get_endian(struct task_struct *tsk, unsigned long adr)
+int get_endian(unsigned long adr)
 {
-	struct pt_regs *regs = tsk->thread.regs;
+	struct pt_regs *regs = current->thread.regs;
 	unsigned int val;
 
 	if (!cpu_has_feature(CPU_FTR_PPC_LE) &&
diff --git a/kernel/sys.c b/kernel/sys.c
index 994b5711..44e1c47 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -90,10 +90,10 @@
 # define GET_FPEXC_CTL(a, b)	(-EINVAL)
 #endif
 #ifndef GET_ENDIAN
-# define GET_ENDIAN(a, b)	(-EINVAL)
+# define GET_ENDIAN(b)		(-EINVAL)
 #endif
 #ifndef SET_ENDIAN
-# define SET_ENDIAN(a, b)	(-EINVAL)
+# define SET_ENDIAN(b)		(-EINVAL)
 #endif
 
 /*
@@ -2265,10 +2265,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = GET_FPEMU_CTL(me, arg2);
 		break;
 	case PR_SET_FPEXC:
-		error = SET_FPEXC_CTL(me, arg2);
+		error = SET_FPEXC_CTL(arg2);
 		break;
 	case PR_GET_FPEXC:
-		error = GET_FPEXC_CTL(me, arg2);
+		error = GET_FPEXC_CTL(arg2);
 		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
@@ -2291,10 +2291,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EFAULT;
 		break;
 	case PR_GET_ENDIAN:
-		error = GET_ENDIAN(me, arg2);
+		error = GET_ENDIAN(arg2);
 		break;
 	case PR_SET_ENDIAN:
-		error = SET_ENDIAN(me, arg2);
+		error = SET_ENDIAN(arg2);
 		break;
 	case PR_GET_SECCOMP:
 		error = prctl_get_seccomp();
-- 
2.1.4

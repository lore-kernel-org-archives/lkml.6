Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEAC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C31720645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C31720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJHRHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:07:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41367 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeJHRHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:07:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989u1sZ559941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:56:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989u15J559938;
        Mon, 8 Oct 2018 02:56:01 -0700
Date:   Mon, 8 Oct 2018 02:56:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-e696c231bebf5f17fe0c5e465c01511320668054@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, dvlasenk@redhat.com,
        brgerst@gmail.com, torvalds@linux-foundation.org, luto@kernel.org,
        mingo@kernel.org, bp@alien8.de, riel@surriel.com,
        chang.seok.bae@intel.com, ravi.v.shankar@intel.com,
        dave.hansen@linux.intel.com, luto@amacapital.net,
        linux-kernel@vger.kernel.org, markus.t.metzger@intel.com,
        peterz@infradead.org
Reply-To: dvlasenk@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          luto@kernel.org, torvalds@linux-foundation.org,
          brgerst@gmail.com, riel@surriel.com, bp@alien8.de,
          mingo@kernel.org, chang.seok.bae@intel.com,
          ravi.v.shankar@intel.com, dave.hansen@linux.intel.com,
          luto@amacapital.net, markus.t.metzger@intel.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <1537312139-5580-4-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-4-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/fsgsbase/64: Make ptrace use the new FS/GS base
 helpers
Git-Commit-ID: e696c231bebf5f17fe0c5e465c01511320668054
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

Commit-ID:  e696c231bebf5f17fe0c5e465c01511320668054
Gitweb:     https://git.kernel.org/tip/e696c231bebf5f17fe0c5e465c01511320668054
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Tue, 18 Sep 2018 16:08:54 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:08 +0200

x86/fsgsbase/64: Make ptrace use the new FS/GS base helpers

Use the new FS/GS base helper functions in <asm/fsgsbase.h> in the platform
specific ptrace implementation of the following APIs:

  PTRACE_ARCH_PRCTL,
  PTRACE_SETREG,
  PTRACE_GETREG,
  etc.

The fsgsbase code is more abstracted out this way and the FS/GS-update
mechanism will be easier to change this way.

[ mingo: Wrote new changelog. ]

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537312139-5580-4-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h |  3 ---
 arch/x86/kernel/process_64.c    | 49 +++++++++--------------------------------
 arch/x86/kernel/ptrace.c        | 27 +++++++----------------
 3 files changed, 18 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 1ab465ee23fe..5e9cbcce318a 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -8,9 +8,6 @@
 
 #include <asm/msr-index.h>
 
-unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-				     unsigned short selector);
-
 /*
  * Read/write a task's fsbase or gsbase. This returns the value that
  * the FS/GS base would have (if the task were to be resumed). These
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 2a53ff8d1baf..e5fb0c3dee4d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -287,8 +287,8 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
-unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-				     unsigned short selector)
+static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+					    unsigned short selector)
 {
 	unsigned short idx = selector >> 3;
 	unsigned long base;
@@ -751,54 +751,25 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
-	int doit = task == current;
-	int cpu;
 
 	switch (option) {
-	case ARCH_SET_GS:
-		if (arg2 >= TASK_SIZE_MAX)
-			return -EPERM;
-		cpu = get_cpu();
-		task->thread.gsindex = 0;
-		task->thread.gsbase = arg2;
-		if (doit) {
-			load_gs_index(0);
-			ret = wrmsrl_safe(MSR_KERNEL_GS_BASE, arg2);
-		}
-		put_cpu();
+	case ARCH_SET_GS: {
+		ret = x86_gsbase_write_task(task, arg2);
 		break;
-	case ARCH_SET_FS:
-		/* Not strictly needed for fs, but do it for symmetry
-		   with gs */
-		if (arg2 >= TASK_SIZE_MAX)
-			return -EPERM;
-		cpu = get_cpu();
-		task->thread.fsindex = 0;
-		task->thread.fsbase = arg2;
-		if (doit) {
-			/* set the selector to 0 to not confuse __switch_to */
-			loadsegment(fs, 0);
-			ret = wrmsrl_safe(MSR_FS_BASE, arg2);
-		}
-		put_cpu();
+	}
+	case ARCH_SET_FS: {
+		ret = x86_fsbase_write_task(task, arg2);
 		break;
+	}
 	case ARCH_GET_FS: {
-		unsigned long base;
+		unsigned long base = x86_fsbase_read_task(task);
 
-		if (doit)
-			rdmsrl(MSR_FS_BASE, base);
-		else
-			base = task->thread.fsbase;
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
 	case ARCH_GET_GS: {
-		unsigned long base;
+		unsigned long base = x86_gsbase_read_task(task);
 
-		if (doit)
-			rdmsrl(MSR_KERNEL_GS_BASE, base);
-		else
-			base = task->thread.gsbase;
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index fbde2a7ce377..d8f49c7384a3 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -397,12 +397,11 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		/*
-		 * When changing the segment base, use do_arch_prctl_64
-		 * to set either thread.fs or thread.fsindex and the
-		 * corresponding GDT slot.
+		 * When changing the FS base, use the same
+		 * mechanism as for do_arch_prctl_64().
 		 */
 		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+			return x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
 		/*
@@ -411,7 +410,7 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+			return x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
@@ -435,20 +434,10 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 		return get_flags(task);
 
 #ifdef CONFIG_X86_64
-	case offsetof(struct user_regs_struct, fs_base): {
-		if (task->thread.fsindex == 0)
-			return task->thread.fsbase;
-		else
-			return x86_fsgsbase_read_task(task,
-						      task->thread.fsindex);
-	}
-	case offsetof(struct user_regs_struct, gs_base): {
-		if (task->thread.gsindex == 0)
-			return task->thread.gsbase;
-		else
-			return x86_fsgsbase_read_task(task,
-						      task->thread.gsindex);
-	}
+	case offsetof(struct user_regs_struct, fs_base):
+		return x86_fsbase_read_task(task);
+	case offsetof(struct user_regs_struct, gs_base):
+		return x86_gsbase_read_task(task);
 #endif
 	}
 

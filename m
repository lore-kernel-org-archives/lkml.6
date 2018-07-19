Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90DCECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A0620673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A0620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeGTAMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:12:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeGTAMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:12:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNPiG42453142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:25:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNPh9g2453137;
        Thu, 19 Jul 2018 16:25:43 -0700
Date:   Thu, 19 Jul 2018 16:25:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-252e1a0526304f0f3f6888fc09e81cb220f957f3@git.kernel.org>
Cc:     bp@alien8.de, aarcange@redhat.com, dvlasenk@redhat.com,
        gregkh@linuxfoundation.org, peterz@infradead.org, luto@kernel.org,
        will.deacon@arm.com, pavel@ucw.cz, hpa@zytor.com,
        boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, eduval@amazon.com, jgross@suse.com,
        tglx@linutronix.de, llong@redhat.com, brgerst@gmail.com,
        David.Laight@aculab.com, jkosina@suse.cz, jpoimboe@redhat.com,
        jroedel@suse.de, mingo@kernel.org, dhgutteridge@sympatico.ca,
        dave.hansen@intel.com
Reply-To: dave.hansen@intel.com, dhgutteridge@sympatico.ca,
          mingo@kernel.org, jpoimboe@redhat.com, jroedel@suse.de,
          David.Laight@aculab.com, jkosina@suse.cz, brgerst@gmail.com,
          llong@redhat.com, tglx@linutronix.de, jgross@suse.com,
          eduval@amazon.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          boris.ostrovsky@oracle.com, pavel@ucw.cz, will.deacon@arm.com,
          luto@kernel.org, peterz@infradead.org,
          gregkh@linuxfoundation.org, dvlasenk@redhat.com,
          aarcange@redhat.com, bp@alien8.de
In-Reply-To: <1531906876-13451-15-git-send-email-joro@8bytes.org>
References: <1531906876-13451-15-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry: Rename update_sp0 to update_task_stack
Git-Commit-ID: 252e1a0526304f0f3f6888fc09e81cb220f957f3
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

Commit-ID:  252e1a0526304f0f3f6888fc09e81cb220f957f3
Gitweb:     https://git.kernel.org/tip/252e1a0526304f0f3f6888fc09e81cb220f957f3
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:40 +0200

x86/entry: Rename update_sp0 to update_task_stack

The function does not update sp0 anymore but updates makes the task-stack
visible for entry code. This is by either writing it to sp1 or by doing a
hypercall. Rename the function to get rid of the misleading name.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-15-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/switch_to.h | 2 +-
 arch/x86/kernel/process_32.c     | 2 +-
 arch/x86/kernel/process_64.c     | 2 +-
 arch/x86/kernel/vm86_32.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 8bc2f70b452e..36bd243843d6 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -87,7 +87,7 @@ static inline void refresh_sysenter_cs(struct thread_struct *thread)
 #endif
 
 /* This is used when switching tasks or entering/exiting vm86 mode. */
-static inline void update_sp0(struct task_struct *task)
+static inline void update_task_stack(struct task_struct *task)
 {
 	/* sp0 always points to the entry trampoline stack, which is constant: */
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0ae659de21eb..2924fd447e61 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -285,7 +285,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * current_thread_info().  Refresh the SYSENTER configuration in
 	 * case prev or next is vm86.
 	 */
-	update_sp0(next_p);
+	update_task_stack(next_p);
 	refresh_sysenter_cs(next);
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 12bb445fb98d..476e3ddf8890 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -478,7 +478,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
 
 	/* Reload sp0. */
-	update_sp0(next_p);
+	update_task_stack(next_p);
 
 	/*
 	 * Now maybe reload the debug registers and handle I/O bitmaps
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 9d0b5af7db91..1c03e4aa6474 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -149,7 +149,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	preempt_disable();
 	tsk->thread.sp0 = vm86->saved_sp0;
 	tsk->thread.sysenter_cs = __KERNEL_CS;
-	update_sp0(tsk);
+	update_task_stack(tsk);
 	refresh_sysenter_cs(&tsk->thread);
 	vm86->saved_sp0 = 0;
 	preempt_enable();
@@ -374,7 +374,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 		refresh_sysenter_cs(&tsk->thread);
 	}
 
-	update_sp0(tsk);
+	update_task_stack(tsk);
 	preempt_enable();
 
 	if (vm86->flags & VM86_SCREEN_BITMAP)

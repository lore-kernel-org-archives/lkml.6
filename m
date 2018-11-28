Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D002AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961D52081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961D52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeK2BfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:35:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2BfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:35:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEWU5T2323752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:32:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEWUPh2323748;
        Wed, 28 Nov 2018 06:32:30 -0800
Date:   Wed, 28 Nov 2018 06:32:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-46f7ecb1e7359f183f5bbd1e08b90e10e52164f9@git.kernel.org>
Cc:     ak@linux.intel.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, asit.k.mallick@intel.com, jcm@redhat.com,
        hpa@zytor.com, thomas.lendacky@amd.com, keescook@chromium.org,
        jpoimboe@redhat.com, longman9394@gmail.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        luto@kernel.org, david.c.stewart@intel.com, dwmw@amazon.co.uk,
        tglx@linutronix.de, aarcange@redhat.com,
        tim.c.chen@linux.intel.com, mingo@kernel.org, peterz@infradead.org,
        casey.schaufler@intel.com, dave.hansen@intel.com
Reply-To: gregkh@linuxfoundation.org, luto@kernel.org,
          torvalds@linux-foundation.org, longman9394@gmail.com,
          dwmw@amazon.co.uk, david.c.stewart@intel.com,
          tim.c.chen@linux.intel.com, aarcange@redhat.com,
          tglx@linutronix.de, dave.hansen@intel.com,
          casey.schaufler@intel.com, peterz@infradead.org,
          mingo@kernel.org, jkosina@suse.cz, ak@linux.intel.com,
          jcm@redhat.com, asit.k.mallick@intel.com, arjan@linux.intel.com,
          linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
          hpa@zytor.com, jpoimboe@redhat.com, keescook@chromium.org
In-Reply-To: <20181125185005.559149393@linutronix.de>
References: <20181125185005.559149393@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] ptrace: Remove unused ptrace_may_access_sched() and
 MODE_IBRS
Git-Commit-ID: 46f7ecb1e7359f183f5bbd1e08b90e10e52164f9
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

Commit-ID:  46f7ecb1e7359f183f5bbd1e08b90e10e52164f9
Gitweb:     https://git.kernel.org/tip/46f7ecb1e7359f183f5bbd1e08b90e10e52164f9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:50 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:11 +0100

ptrace: Remove unused ptrace_may_access_sched() and MODE_IBRS

The IBPB control code in x86 removed the usage. Remove the functionality
which was introduced for this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185005.559149393@linutronix.de


---
 include/linux/ptrace.h | 17 -----------------
 kernel/ptrace.c        | 10 ----------
 2 files changed, 27 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 6c2ffed907f5..de20ede2c5c8 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -64,15 +64,12 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
 #define PTRACE_MODE_NOAUDIT	0x04
 #define PTRACE_MODE_FSCREDS	0x08
 #define PTRACE_MODE_REALCREDS	0x10
-#define PTRACE_MODE_SCHED	0x20
-#define PTRACE_MODE_IBPB	0x40
 
 /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
 #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCREDS)
 #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_REALCREDS)
-#define PTRACE_MODE_SPEC_IBPB (PTRACE_MODE_ATTACH_REALCREDS | PTRACE_MODE_IBPB)
 
 /**
  * ptrace_may_access - check whether the caller is permitted to access
@@ -90,20 +87,6 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
  */
 extern bool ptrace_may_access(struct task_struct *task, unsigned int mode);
 
-/**
- * ptrace_may_access - check whether the caller is permitted to access
- * a target task.
- * @task: target task
- * @mode: selects type of access and caller credentials
- *
- * Returns true on success, false on denial.
- *
- * Similar to ptrace_may_access(). Only to be called from context switch
- * code. Does not call into audit and the regular LSM hooks due to locking
- * constraints.
- */
-extern bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode);
-
 static inline int ptrace_reparented(struct task_struct *child)
 {
 	return !same_thread_group(child->real_parent, child->parent);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 80b34dffdfb9..c2cee9db5204 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -261,9 +261,6 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 
 static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 {
-	if (mode & PTRACE_MODE_SCHED)
-		return false;
-
 	if (mode & PTRACE_MODE_NOAUDIT)
 		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
 	else
@@ -331,16 +328,9 @@ ok:
 	     !ptrace_has_cap(mm->user_ns, mode)))
 	    return -EPERM;
 
-	if (mode & PTRACE_MODE_SCHED)
-		return 0;
 	return security_ptrace_access_check(task, mode);
 }
 
-bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
-{
-	return __ptrace_may_access(task, mode | PTRACE_MODE_SCHED);
-}
-
 bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	int err;

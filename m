Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA872146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M757qr0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA872146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeLDLFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeLDLFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68FD2087F;
        Tue,  4 Dec 2018 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921533;
        bh=shU/AQRdgrlv1/qtYhDPuji0CIutP1gLLBSK3JC3QMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M757qr0SAkq8TGG1X7YED+6WmIqxNQjiBhceulbStZRUN/haqWUnfwhBcapLVVss9
         nqvqYSo8k9WJSwBzXq6fMN5j0wgZZugxQYKMho6T5o/eWdUlxdc5mLwGnlr7396RPV
         JhcKrS2+KZigcwfRRdHvK8WAG5jR6UvfV1bl2kGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 101/146] ptrace: Remove unused ptrace_may_access_sched() and MODE_IBRS
Date:   Tue,  4 Dec 2018 11:49:47 +0100
Message-Id: <20181204103730.884011797@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit 46f7ecb1e7359f183f5bbd1e08b90e10e52164f9 upstream

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ptrace.h |   17 -----------------
 kernel/ptrace.c        |   10 ----------
 2 files changed, 27 deletions(-)

--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -64,15 +64,12 @@ extern void exit_ptrace(struct task_stru
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
@@ -90,20 +87,6 @@ extern void exit_ptrace(struct task_stru
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
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -261,9 +261,6 @@ static int ptrace_check_attach(struct ta
 
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



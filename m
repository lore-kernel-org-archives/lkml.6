Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF85C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844322085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844322085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJHRLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:11:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHRLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:11:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989xrdB560593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:59:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989xq6X560590;
        Mon, 8 Oct 2018 02:59:52 -0700
Date:   Mon, 8 Oct 2018 02:59:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-ec3a94188df7d28b374868d9a2a0face910e62ab@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        riel@surriel.com, mingo@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        torvalds@linux-foundation.org, hpa@zytor.com, bp@alien8.de,
        ravi.v.shankar@intel.com, markus.t.metzger@intel.com
Reply-To: peterz@infradead.org, dvlasenk@redhat.com,
          linux-kernel@vger.kernel.org, brgerst@gmail.com,
          dave.hansen@linux.intel.com, riel@surriel.com, mingo@kernel.org,
          tglx@linutronix.de, luto@kernel.org, ravi.v.shankar@intel.com,
          bp@alien8.de, hpa@zytor.com, markus.t.metzger@intel.com,
          chang.seok.bae@intel.com, torvalds@linux-foundation.org
In-Reply-To: <1537312139-5580-2-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-2-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/fsgsbase/64: Clean up various details
Git-Commit-ID: ec3a94188df7d28b374868d9a2a0face910e62ab
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

Commit-ID:  ec3a94188df7d28b374868d9a2a0face910e62ab
Gitweb:     https://git.kernel.org/tip/ec3a94188df7d28b374868d9a2a0face910e62ab
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 8 Oct 2018 10:41:59 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:45:04 +0200

x86/fsgsbase/64: Clean up various details

So:

 - use 'extern' consistently for APIs

 - fix weird header guard

 - clarify code comments

 - reorder APIs by type

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/1537312139-5580-2-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vgetcpu.c   |  1 +
 arch/x86/include/asm/fsgsbase.h | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index edd214f5264d..f86ab0ae1777 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -14,6 +14,7 @@ notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 {
 	vdso_read_cpunode(cpu, node);
+
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 5e9cbcce318a..eb377b6e9eed 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_FSGSBASE_H
-#define _ASM_FSGSBASE_H 1
+#define _ASM_FSGSBASE_H
 
 #ifndef __ASSEMBLY__
 
@@ -9,14 +9,15 @@
 #include <asm/msr-index.h>
 
 /*
- * Read/write a task's fsbase or gsbase. This returns the value that
+ * Read/write a task's FSBASE or GSBASE. This returns the value that
  * the FS/GS base would have (if the task were to be resumed). These
- * work on current or on a different non-running task.
+ * work on the current task or on a non-running (typically stopped
+ * ptrace child) task.
  */
-unsigned long x86_fsbase_read_task(struct task_struct *task);
-unsigned long x86_gsbase_read_task(struct task_struct *task);
-int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
-int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
+extern unsigned long x86_fsbase_read_task(struct task_struct *task);
+extern unsigned long x86_gsbase_read_task(struct task_struct *task);
+extern int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
+extern int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
 
 /* Helper functions for reading/writing FS/GS base */
 
@@ -25,20 +26,21 @@ static inline unsigned long x86_fsbase_read_cpu(void)
 	unsigned long fsbase;
 
 	rdmsrl(MSR_FS_BASE, fsbase);
+
 	return fsbase;
 }
 
-void x86_fsbase_write_cpu(unsigned long fsbase);
-
 static inline unsigned long x86_gsbase_read_cpu_inactive(void)
 {
 	unsigned long gsbase;
 
 	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+
 	return gsbase;
 }
 
-void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
+extern void x86_fsbase_write_cpu(unsigned long fsbase);
+extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 

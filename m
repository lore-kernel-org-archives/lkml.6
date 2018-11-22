Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D57C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3316820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393899AbeKVUtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:49:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390426AbeKVUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:49:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMA9sWt3743618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:09:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMA9svG3743615;
        Thu, 22 Nov 2018 02:09:54 -0800
Date:   Thu, 22 Nov 2018 02:09:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-0ed32f1aa66ee758e6c8164f549f7ff9d399a20e@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        luto@kernel.org, yu-cheng.yu@intel.com, riel@surriel.com
Reply-To: dave.hansen@linux.intel.com, bp@alien8.de, tglx@linutronix.de,
          hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com,
          peterz@infradead.org, luto@kernel.org, riel@surriel.com
In-Reply-To: <078f5b8ae6e8c79ff8ee7345b5c476c45003e5ac.1542841400.git.luto@kernel.org>
References: <078f5b8ae6e8c79ff8ee7345b5c476c45003e5ac.1542841400.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Remove sw_error_code
Git-Commit-ID: 0ed32f1aa66ee758e6c8164f549f7ff9d399a20e
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

Commit-ID:  0ed32f1aa66ee758e6c8164f549f7ff9d399a20e
Gitweb:     https://git.kernel.org/tip/0ed32f1aa66ee758e6c8164f549f7ff9d399a20e
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 21 Nov 2018 15:11:22 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:22:59 +0100

x86/fault: Remove sw_error_code

All of the fault handling code now corrently checks user_mode(regs)
as needed, and nothing depends on the X86_PF_USER bit being munged.
Get rid of the sw_error code and use hw_error_code everywhere.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/078f5b8ae6e8c79ff8ee7345b5c476c45003e5ac.1542841400.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 50 +++++++++++---------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b898a38093a3..82881bc5feef 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1217,7 +1217,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 			unsigned long hw_error_code,
 			unsigned long address)
 {
-	unsigned long sw_error_code;
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
@@ -1262,13 +1261,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
-	/*
-	 * hw_error_code is literally the "page fault error code" passed to
-	 * the kernel directly from the hardware.  But, we will shortly be
-	 * modifying it in software, so give it a new name.
-	 */
-	sw_error_code = hw_error_code;
-
 	/*
 	 * It's safe to allow irq's after cr2 has been saved and the
 	 * vmalloc fault has been handled.
@@ -1278,26 +1270,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	if (user_mode(regs)) {
 		local_irq_enable();
-		/*
-		 * Up to this point, X86_PF_USER set in hw_error_code
-		 * indicated a user-mode access.  But, after this,
-		 * X86_PF_USER in sw_error_code will indicate either
-		 * that, *or* an implicit kernel(supervisor)-mode access
-		 * which originated from user mode.
-		 */
-		if (!(hw_error_code & X86_PF_USER)) {
-			/*
-			 * The CPU was in user mode, but the CPU says
-			 * the fault was not a user-mode access.
-			 * Must be an implicit kernel-mode access,
-			 * which we do not expect to happen in the
-			 * user address space.
-			 */
-			pr_warn_once("kernel-mode error from user-mode: %lx\n",
-					hw_error_code);
-
-			sw_error_code |= X86_PF_USER;
-		}
 		flags |= FAULT_FLAG_USER;
 	} else {
 		if (regs->flags & X86_EFLAGS_IF)
@@ -1306,9 +1278,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (sw_error_code & X86_PF_WRITE)
+	if (hw_error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-	if (sw_error_code & X86_PF_INSTR)
+	if (hw_error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 #ifdef CONFIG_X86_64
@@ -1321,7 +1293,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * The vsyscall page does not have a "real" VMA, so do this
 	 * emulation before we go searching for VMAs.
 	 */
-	if ((sw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
+	if ((hw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
 		if (emulate_vsyscall(regs, address))
 			return;
 	}
@@ -1345,7 +1317,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, sw_error_code, address);
+			bad_area_nosemaphore(regs, hw_error_code, address);
 			return;
 		}
 retry:
@@ -1361,17 +1333,17 @@ retry:
 
 	vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
-		bad_area(regs, sw_error_code, address);
+		bad_area(regs, hw_error_code, address);
 		return;
 	}
 	if (likely(vma->vm_start <= address))
 		goto good_area;
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, sw_error_code, address);
+		bad_area(regs, hw_error_code, address);
 		return;
 	}
 	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, sw_error_code, address);
+		bad_area(regs, hw_error_code, address);
 		return;
 	}
 
@@ -1380,8 +1352,8 @@ retry:
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(sw_error_code, vma))) {
-		bad_area_access_error(regs, sw_error_code, address, vma);
+	if (unlikely(access_error(hw_error_code, vma))) {
+		bad_area_access_error(regs, hw_error_code, address, vma);
 		return;
 	}
 
@@ -1420,13 +1392,13 @@ good_area:
 			return;
 
 		/* Not returning to user mode? Handle exceptions or die: */
-		no_context(regs, sw_error_code, address, SIGBUS, BUS_ADRERR);
+		no_context(regs, hw_error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
 
 	up_read(&mm->mmap_sem);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mm_fault_error(regs, sw_error_code, address, fault);
+		mm_fault_error(regs, hw_error_code, address, fault);
 		return;
 	}
 

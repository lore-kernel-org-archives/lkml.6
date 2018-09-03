Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D737C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F83620652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F83620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeICRit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:38:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43071 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeICRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:38:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83DI7Wt3313830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 06:18:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83DI73T3313827;
        Mon, 3 Sep 2018 06:18:07 -0700
Date:   Mon, 3 Sep 2018 06:18:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-81fd9c18444ed1199b5a6f6776a395292d4256fb@git.kernel.org>
Cc:     hpa@zytor.com, keescook@chromium.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.vnet.ibm.com, tglx@linutronix.de,
        jannh@google.com, luto@kernel.org, mhiramat@kernel.org,
        mingo@kernel.org, viro@zeniv.linux.org.uk
Reply-To: naveen.n.rao@linux.vnet.ibm.com, tglx@linutronix.de,
          bp@alien8.de, davem@davemloft.net,
          anil.s.keshavamurthy@intel.com, hpa@zytor.com,
          keescook@chromium.org, linux-kernel@vger.kernel.org,
          viro@zeniv.linux.org.uk, mingo@kernel.org, mhiramat@kernel.org,
          jannh@google.com, luto@kernel.org
In-Reply-To: <20180828201421.157735-6-jannh@google.com>
References: <20180828201421.157735-6-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/fault: Plumb error code and fault address
 through to fault handlers
Git-Commit-ID: 81fd9c18444ed1199b5a6f6776a395292d4256fb
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

Commit-ID:  81fd9c18444ed1199b5a6f6776a395292d4256fb
Gitweb:     https://git.kernel.org/tip/81fd9c18444ed1199b5a6f6776a395292d4256fb
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 22:14:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 15:12:09 +0200

x86/fault: Plumb error code and fault address through to fault handlers

This is preparation for looking at trap number and fault address in the
handlers for uaccess errors. No functional change.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org
Cc: dvyukov@google.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180828201421.157735-6-jannh@google.com

---
 arch/x86/include/asm/extable.h   |  3 ++-
 arch/x86/include/asm/ptrace.h    |  2 ++
 arch/x86/kernel/cpu/mcheck/mce.c |  2 +-
 arch/x86/kernel/traps.c          |  6 ++---
 arch/x86/mm/extable.c            | 50 ++++++++++++++++++++++++++++------------
 arch/x86/mm/fault.c              |  2 +-
 6 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index f9c3a5d502f4..d8c2198d543b 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -29,7 +29,8 @@ struct pt_regs;
 		(b)->handler = (tmp).handler - (delta);		\
 	} while (0)
 
-extern int fixup_exception(struct pt_regs *regs, int trapnr);
+extern int fixup_exception(struct pt_regs *regs, int trapnr,
+			   unsigned long error_code, unsigned long fault_addr);
 extern int fixup_bug(struct pt_regs *regs, int trapnr);
 extern bool ex_has_fault_handler(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..5e58a74bfd3a 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -37,8 +37,10 @@ struct pt_regs {
 	unsigned short __esh;
 	unsigned short fs;
 	unsigned short __fsh;
+	/* On interrupt, gs and __gsh store the vector number. */
 	unsigned short gs;
 	unsigned short __gsh;
+	/* On interrupt, this is the error code. */
 	unsigned long orig_ax;
 	unsigned long ip;
 	unsigned short cs;
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 953b3ce92dcc..ef8fd1f2ede0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1315,7 +1315,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 		local_irq_disable();
 		ist_end_non_atomic();
 	} else {
-		if (!fixup_exception(regs, X86_TRAP_MC))
+		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, NULL);
 	}
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bf9ab1aaa175..16c95cb90496 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -206,7 +206,7 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 	}
 
 	if (!user_mode(regs)) {
-		if (fixup_exception(regs, trapnr))
+		if (fixup_exception(regs, trapnr, error_code, 0))
 			return 0;
 
 		tsk->thread.error_code = error_code;
@@ -551,7 +551,7 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	tsk = current;
 	if (!user_mode(regs)) {
-		if (fixup_exception(regs, X86_TRAP_GP))
+		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
 
 		tsk->thread.error_code = error_code;
@@ -848,7 +848,7 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 	cond_local_irq_enable(regs);
 
 	if (!user_mode(regs)) {
-		if (fixup_exception(regs, trapnr))
+		if (fixup_exception(regs, trapnr, error_code, 0))
 			return;
 
 		task->thread.error_code = error_code;
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 0b8b5d889eec..856fa409c536 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -8,7 +8,8 @@
 #include <asm/kdebug.h>
 
 typedef bool (*ex_handler_t)(const struct exception_table_entry *,
-			    struct pt_regs *, int);
+			    struct pt_regs *, int, unsigned long,
+			    unsigned long);
 
 static inline unsigned long
 ex_fixup_addr(const struct exception_table_entry *x)
@@ -22,7 +23,9 @@ ex_fixup_handler(const struct exception_table_entry *x)
 }
 
 __visible bool ex_handler_default(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr)
+				  struct pt_regs *regs, int trapnr,
+				  unsigned long error_code,
+				  unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
@@ -30,7 +33,9 @@ __visible bool ex_handler_default(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL(ex_handler_default);
 
 __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
-				struct pt_regs *regs, int trapnr)
+				struct pt_regs *regs, int trapnr,
+				unsigned long error_code,
+				unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	regs->ax = trapnr;
@@ -43,7 +48,9 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
  * result of a refcount inc/dec/add/sub.
  */
 __visible bool ex_handler_refcount(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr)
+				   struct pt_regs *regs, int trapnr,
+				   unsigned long error_code,
+				   unsigned long fault_addr)
 {
 	/* First unconditionally saturate the refcount. */
 	*(int *)regs->cx = INT_MIN / 2;
@@ -96,7 +103,9 @@ EXPORT_SYMBOL(ex_handler_refcount);
  * out all the FPU registers) if we can't restore from the task's FPU state.
  */
 __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs, int trapnr)
+				    struct pt_regs *regs, int trapnr,
+				    unsigned long error_code,
+				    unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 
@@ -109,7 +118,9 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
 __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr)
+				  struct pt_regs *regs, int trapnr,
+				  unsigned long error_code,
+				  unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
@@ -117,7 +128,9 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL(ex_handler_uaccess);
 
 __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
-			      struct pt_regs *regs, int trapnr)
+			      struct pt_regs *regs, int trapnr,
+			      unsigned long error_code,
+			      unsigned long fault_addr)
 {
 	/* Special hack for uaccess_err */
 	current->thread.uaccess_err = 1;
@@ -127,7 +140,9 @@ __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL(ex_handler_ext);
 
 __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr)
+				       struct pt_regs *regs, int trapnr,
+				       unsigned long error_code,
+				       unsigned long fault_addr)
 {
 	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pF)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
@@ -142,7 +157,9 @@ __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup
 EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 
 __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr)
+				       struct pt_regs *regs, int trapnr,
+				       unsigned long error_code,
+				       unsigned long fault_addr)
 {
 	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pF)\n",
 			 (unsigned int)regs->cx, (unsigned int)regs->dx,
@@ -156,12 +173,14 @@ __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup
 EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
 
 __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr)
+				   struct pt_regs *regs, int trapnr,
+				   unsigned long error_code,
+				   unsigned long fault_addr)
 {
 	if (static_cpu_has(X86_BUG_NULL_SEG))
 		asm volatile ("mov %0, %%fs" : : "rm" (__USER_DS));
 	asm volatile ("mov %0, %%fs" : : "rm" (0));
-	return ex_handler_default(fixup, regs, trapnr);
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_clear_fs);
 
@@ -178,7 +197,8 @@ __visible bool ex_has_fault_handler(unsigned long ip)
 	return handler == ex_handler_fault;
 }
 
-int fixup_exception(struct pt_regs *regs, int trapnr)
+int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
+		    unsigned long fault_addr)
 {
 	const struct exception_table_entry *e;
 	ex_handler_t handler;
@@ -202,7 +222,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr)
 		return 0;
 
 	handler = ex_fixup_handler(e);
-	return handler(e, regs, trapnr);
+	return handler(e, regs, trapnr, error_code, fault_addr);
 }
 
 extern unsigned int early_recursion_flag;
@@ -238,9 +258,9 @@ void __init early_fixup_exception(struct pt_regs *regs, int trapnr)
 	 * result in a hard-to-debug panic.
 	 *
 	 * Keep in mind that not all vectors actually get here.  Early
-	 * fage faults, for example, are special.
+	 * page faults, for example, are special.
 	 */
-	if (fixup_exception(regs, trapnr))
+	if (fixup_exception(regs, trapnr, regs->orig_ax, 0))
 		return;
 
 	if (fixup_bug(regs, trapnr))
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d99edb2d567b..cf16dfec2734 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -711,7 +711,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	int sig;
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF)) {
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
 		/*
 		 * Any interrupt that takes a fault gets the fixup. This makes
 		 * the below recursive fault logic only apply to a faults from

Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A06C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4D020891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6P2lH6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4D020891
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeH2AIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:08:11 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:48554 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeH2AIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:08:10 -0400
Received: by mail-ua1-f73.google.com with SMTP id k3-v6so1104302uao.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6+wvh3gVbSvK20MuHN7PGHkeMC0u12Pexty0kPvC+5c=;
        b=i6P2lH6cRMg/nPPP2HoSq+Nt896dyGVJjO/d1PpB1gwTmka5O605Pjo/T1rKQb9mD8
         NpT9yaFAV4IooOrhfKbPeHMSWPJRqFMS04pFVhFVE1r8HBb9/TfSGqYQ5uhyEMnLY3dK
         HYRNfdQmWS5SjjXKEJUQooaOT4MQU994iwnO+zt4kzcChsGiKuHq22DadiXtW+oLml+l
         KOIOB6MgyAOS39uKtIxnfebYkOrf9LTiIFSuVpvtY6MWSsmFOfdy5rWLNHkF9lINkihG
         REbCuGc9/nXxf3eEgxgG+nfLsD3Mx5FjAQLDXXt+2zNuP7/5AO+4riXtpeB1afvrFu9p
         xIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6+wvh3gVbSvK20MuHN7PGHkeMC0u12Pexty0kPvC+5c=;
        b=EcyWGeN03tQ4GWkJvBSNU1SnGCirjK012k/r3kLOmu8Ts/frMF7mtOuN8ix2K6IpQi
         CZscfaeNDra14oQVyYXny2WkkbuGYtfV5O/FF9l2EHUWRJV1KIhFPhBs64CIVqvUsAfE
         Lma8qlx331kD2zIlzQJNfLMlqB3l8P2VuyPSNSrao+G9kS5hOXQK6Fh3UeDvN1ecCyjO
         VpA7ThBLB0WRC102+RCTQJ8IckCXjkEJhX6eQzuD0NDeICBDfqSNjAEvT4fD+X0/VbaQ
         wGYG5AMAW+Vat/9IXnEtzeUP4IxUpXJ+VKIK5AvE29Wp2/g+74rQgqo+saTEe1Y9Kq3l
         3q0A==
X-Gm-Message-State: APzg51C3VaC7nu4QQfmtuOjdDC5DUqwXO95tNw/6t+YLWhVSmIYvN9zU
        xMnh/PGqYbFqAEnBYj09cjHKUyfzsw==
X-Google-Smtp-Source: ANB0Vdaob1DTxV0/APqUNaVRs4TOscb/p1BPKyuykGRMvaQxbeCGxbT15tlqo7IW4JImjIyuSRFMj0R0yQ==
X-Received: by 2002:a1f:848:: with SMTP id 69-v6mr1460384vki.82.1535487294840;
 Tue, 28 Aug 2018 13:14:54 -0700 (PDT)
Date:   Tue, 28 Aug 2018 22:14:19 +0200
In-Reply-To: <20180828201421.157735-1-jannh@google.com>
Message-Id: <20180828201421.157735-6-jannh@google.com>
Mime-Version: 1.0
References: <20180828201421.157735-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v3 5/7] x86: plumb error code and fault address through to
 fault handlers
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for looking at trap number and fault address in the
handlers for uaccess errors.
This patch should not change any behavior.

Signed-off-by: Jann Horn <jannh@google.com>
---
v3:
 - really plumb the error code through to the handlers (Andy)

 arch/x86/include/asm/extable.h   |  3 +-
 arch/x86/include/asm/ptrace.h    |  2 ++
 arch/x86/kernel/cpu/mcheck/mce.c |  2 +-
 arch/x86/kernel/traps.c          |  6 ++--
 arch/x86/mm/extable.c            | 50 ++++++++++++++++++++++----------
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
index 6de1fd3d0097..6c68d4947a8f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -37,8 +37,10 @@ struct pt_regs {
 	unsigned short __esh;
 	unsigned short fs;
 	unsigned short __fsh;
+/* On interrupt, gs and __gsh store the vector number. */
 	unsigned short gs;
 	unsigned short __gsh;
+/* On interrupt, this is the error code. */
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
index bcdaae1d5bf5..840833469551 100644
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
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog


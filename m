Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ECEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E064A208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNYPbYNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E064A208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeH0Wp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:45:56 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:33797 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeH0Wpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:45:55 -0400
Received: by mail-yb0-f201.google.com with SMTP id d11-v6so20519ybj.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9Et7hJI7CQsj8qb35UZt57eCeU2Kw4/9DHEuhsRKrY=;
        b=ZNYPbYNP8nV6iZBtRHlDcHcyQvjI71ZqSJzynqPcDzkMwsvtbWd2wF6LfAYc3VpMCF
         kyBaueWB21eH04exrCvmx0EMkALhrzpQ9asG90b8JUYYXs+fkCKnq3cMRND6PxhXgSNH
         rmqKX+1PLSBW2wdnsgRza+58s1k0by4VPYu0AWGMMHz/93fDZM9E3MkHwNNZAUvWY/jB
         mZ4dSpjAXYHfNXFDpOYrKctyR6HpIrpOoYM60m5ia9GxvOBpIlDv8u6gxIMciVMBIzYq
         bJlIBrJ7DjhN5uIdiATUeBlV9Zu0CKksOewy89JSzmaz8+obMAzg4d3FBFbQwcJ3hMdE
         wFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9Et7hJI7CQsj8qb35UZt57eCeU2Kw4/9DHEuhsRKrY=;
        b=tcZ5GSiMeckStS28lqfVu2k6Ne5VUoivk46DI67gezTGQlOUnOxCowGZiiJBBBIcGS
         f799eY+EisgU+Yz9EEpuuiB7ec5bjbCavIFyJHSlMy7cueGKpQeeqY6wvxYh7spDlx3f
         9BLF6bjiLvsFL6y2g7hZHZPJMvZv8sToUYD9B+huqRCJbhpcUSmyHDNzHfFyxCpy+kW5
         BhQd5uIJfC26xp6tuXoRxhkyyFsPu66xNRRsCbIw228JUh2fynH/CPyHpP1X90zr9YGG
         1Sez826zhnlM9MPkTQ0xNi4Kzo/GgLDfAlWfb7eDOst8hJ+artW5BO3lW5YKzsgNBNXv
         Z6Gw==
X-Gm-Message-State: APzg51AZh7AJgUi92lK4W79kxdQ6e9C5x0Jq69hvIU3P+tr5iaL3DsMI
        HhCMw0Hd0KC7S9wiVU3PcK5yL2khaw==
X-Google-Smtp-Source: ANB0VdYqyWxd4JbspT+CKYyxCWAbVRE/zl+m234pplr5wHzQym8dRRRAUlpyZoLQtITEfaKmx8vWSGaCFg==
X-Received: by 2002:a0d:e0c6:: with SMTP id j189-v6mr9548ywe.80.1535396285822;
 Mon, 27 Aug 2018 11:58:05 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:56:29 +0200
In-Reply-To: <20180827185631.163506-1-jannh@google.com>
Message-Id: <20180827185631.163506-6-jannh@google.com>
Mime-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH v2 5/7] x86: plumb error code and fault address through to
 fault handlers
From:   Jann Horn <jannh@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, dvyukov@google.com,
        linux-edac@vger.kernel.org
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
 arch/x86/include/asm/extable.h   |  3 ++-
 arch/x86/include/asm/ptrace.h    |  2 ++
 arch/x86/kernel/cpu/mcheck/mce.c |  2 +-
 arch/x86/kernel/traps.c          |  6 ++---
 arch/x86/mm/extable.c            | 40 ++++++++++++++++++++------------
 arch/x86/mm/fault.c              |  2 +-
 6 files changed, 34 insertions(+), 21 deletions(-)

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
index 4b767284b7f5..e822d706d8c8 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1347,7 +1347,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
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
index 0b8b5d889eec..4110cca93a08 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -8,7 +8,7 @@
 #include <asm/kdebug.h>
 
 typedef bool (*ex_handler_t)(const struct exception_table_entry *,
-			    struct pt_regs *, int);
+			    struct pt_regs *, int, unsigned long);
 
 static inline unsigned long
 ex_fixup_addr(const struct exception_table_entry *x)
@@ -22,7 +22,8 @@ ex_fixup_handler(const struct exception_table_entry *x)
 }
 
 __visible bool ex_handler_default(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr)
+				  struct pt_regs *regs, int trapnr,
+				  unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
@@ -30,7 +31,8 @@ __visible bool ex_handler_default(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL(ex_handler_default);
 
 __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
-				struct pt_regs *regs, int trapnr)
+				struct pt_regs *regs, int trapnr,
+				unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	regs->ax = trapnr;
@@ -43,7 +45,8 @@ EXPORT_SYMBOL_GPL(ex_handler_fault);
  * result of a refcount inc/dec/add/sub.
  */
 __visible bool ex_handler_refcount(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr)
+				   struct pt_regs *regs, int trapnr,
+				   unsigned long fault_addr)
 {
 	/* First unconditionally saturate the refcount. */
 	*(int *)regs->cx = INT_MIN / 2;
@@ -96,7 +99,8 @@ EXPORT_SYMBOL(ex_handler_refcount);
  * out all the FPU registers) if we can't restore from the task's FPU state.
  */
 __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs, int trapnr)
+				    struct pt_regs *regs, int trapnr,
+				    unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 
@@ -109,7 +113,8 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
 __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
-				  struct pt_regs *regs, int trapnr)
+				  struct pt_regs *regs, int trapnr,
+				  unsigned long fault_addr)
 {
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
@@ -117,7 +122,8 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL(ex_handler_uaccess);
 
 __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
-			      struct pt_regs *regs, int trapnr)
+			      struct pt_regs *regs, int trapnr,
+			      unsigned long fault_addr)
 {
 	/* Special hack for uaccess_err */
 	current->thread.uaccess_err = 1;
@@ -127,7 +133,8 @@ __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
 EXPORT_SYMBOL(ex_handler_ext);
 
 __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr)
+				       struct pt_regs *regs, int trapnr,
+				       unsigned long fault_addr)
 {
 	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pF)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
@@ -142,7 +149,8 @@ __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup
 EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 
 __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
-				       struct pt_regs *regs, int trapnr)
+				       struct pt_regs *regs, int trapnr,
+				       unsigned long fault_addr)
 {
 	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pF)\n",
 			 (unsigned int)regs->cx, (unsigned int)regs->dx,
@@ -156,12 +164,13 @@ __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup
 EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
 
 __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
-				   struct pt_regs *regs, int trapnr)
+				   struct pt_regs *regs, int trapnr,
+				   unsigned long fault_addr)
 {
 	if (static_cpu_has(X86_BUG_NULL_SEG))
 		asm volatile ("mov %0, %%fs" : : "rm" (__USER_DS));
 	asm volatile ("mov %0, %%fs" : : "rm" (0));
-	return ex_handler_default(fixup, regs, trapnr);
+	return ex_handler_default(fixup, regs, trapnr, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_clear_fs);
 
@@ -178,7 +187,8 @@ __visible bool ex_has_fault_handler(unsigned long ip)
 	return handler == ex_handler_fault;
 }
 
-int fixup_exception(struct pt_regs *regs, int trapnr)
+int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
+		    unsigned long fault_addr)
 {
 	const struct exception_table_entry *e;
 	ex_handler_t handler;
@@ -202,7 +212,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr)
 		return 0;
 
 	handler = ex_fixup_handler(e);
-	return handler(e, regs, trapnr);
+	return handler(e, regs, trapnr, fault_addr);
 }
 
 extern unsigned int early_recursion_flag;
@@ -238,9 +248,9 @@ void __init early_fixup_exception(struct pt_regs *regs, int trapnr)
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
index 2254a30533b9..60f1678dc3d7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -706,7 +706,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	int sig;
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF)) {
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
 		/*
 		 * Any interrupt that takes a fault gets the fixup. This makes
 		 * the below recursive fault logic only apply to a faults from
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog


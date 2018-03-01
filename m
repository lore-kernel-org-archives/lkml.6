Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909023-2-5764941526950946147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909023; b=I0py24UvAsdRMqcI9jVbfOoH7zzkDBJe7vwcQ+fYhYB7avE
    Epc0N2vVps9PHQWI2yDyhoq5tMf1GhMXvGE5QSYGHSkMkUhKvch3ZdL2K5aEJ7pq
    s4Y4HRXNsgDlynPtGaO9zHoVBGA1l6H9EfPy8fKbjk+QYT+4OaQmcBdqctdAl3O7
    K+tCagFP3gZXNm3DW277HAoZEg3UkVrkoI4K5MPvancPKNE12c+aKTl6kUCbPHp8
    GdKv+Z53R5vjP4Vlf8Ax0teKIa3QPo6e14GRu8Ka8DAEREDd4YvaNBv5wc70baZi
    mBxsLirr6mUjwsAhpmy6BEJAGtLbv51HYIKfP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909023;
    bh=5TmZ3GA7LvmXHit8kAa24HeUaVa3IsIu64SOGOdKiTk=; b=k48YFPf7uJX3
    AhDREcnirR9MHTRx78V7v9QUsoCcXbADNmoXWnm7rIBCAdtSLsdvYh/qrneRH4v/
    /5mnrl5hfN/wLP05NoR4yikAyJrevPyo+vsP9ZkIYqkHVIbvNL3kxZKHvqXFO76Y
    QoiLkcV+h8A3azBTriSM1XrB5PjaK30KxXARML54VcjDVUOv0TVUuj30AJVMa92S
    O5Y0/pES6Tp5K70gGlQLPehSH479oaIENY2ScXOhCnZnq8BT2izVwdTwyxIz3O1l
    AwX8Jdms+mZzMA4A+zJWZ5oHPPgon1LHUQJqHYQuJxZhDqxevAjfZ1W+AvdUNmRS
    JVZ6pMcPYw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=T2+3o9bm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AQXMWh3L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=T2+3o9bm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AQXMWh3L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030588AbeCAM4n (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:56:43 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46423 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030577AbeCAM4j (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:56:39 -0500
X-Google-Smtp-Source: AG47ELshHXS8LSmIqn1xR93SccwtESrHmZDe9YqcSf26CiTlYcecd6YWVY2MrPydeENFTQhhokLDdg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Dave Martin <Dave.Martin@arm.com>, Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 11/45] arm64: syscallno is secretly an int, make it official
Date: Thu,  1 Mar 2018 20:53:48 +0800
Message-Id: <1519908862-11425-12-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Martin <Dave.Martin@arm.com>

commit 35d0e6fb4d upstream.

The upper 32 bits of the syscallno field in thread_struct are
handled inconsistently, being sometimes zero extended and sometimes
sign-extended.  In fact, only the lower 32 bits seem to have any
real significance for the behaviour of the code: it's been OK to
handle the upper bits inconsistently because they don't matter.

Currently, the only place I can find where those bits are
significant is in calling trace_sys_enter(), which may be
unintentional: for example, if a compat tracer attempts to cancel a
syscall by passing -1 to (COMPAT_)PTRACE_SET_SYSCALL at the
syscall-enter-stop, it will be traced as syscall 4294967295
rather than -1 as might be expected (and as occurs for a native
tracer doing the same thing).  Elsewhere, reads of syscallno cast
it to an int or truncate it.

There's also a conspicuous amount of code and casting to bodge
around the fact that although semantically an int, syscallno is
stored as a u64.

Let's not pretend any more.

In order to preserve the stp x instruction that stores the syscall
number in entry.S, this patch special-cases the layout of struct
pt_regs for big endian so that the newly 32-bit syscallno field
maps onto the low bits of the stored value.  This is not beautiful,
but benchmarking of the getpid syscall on Juno suggests indicates a
minor slowdown if the stp is split into an stp x and stp w.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/include/asm/ptrace.h    |  9 ++++++++-
 arch/arm64/kernel/entry.S          | 34 +++++++++++++++++-----------------
 arch/arm64/kernel/ptrace.c         |  2 +-
 arch/arm64/kernel/signal.c         |  6 +++---
 arch/arm64/kernel/signal32.c       |  2 +-
 arch/arm64/kernel/traps.c          |  2 +-
 7 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5917147..f5cdda6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -130,7 +130,7 @@ struct thread_struct {
 static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 {
 	memset(regs, 0, sizeof(*regs));
-	regs->syscallno = ~0UL;
+	regs->syscallno = ~0;
 	regs->pc = pc;
 }
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index ada08b5..7721d7a 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -116,7 +116,14 @@ struct pt_regs {
 		};
 	};
 	u64 orig_x0;
-	u64 syscallno;
+#ifdef __AARCH64EB__
+	u32 unused2;
+	s32 syscallno;
+#else
+	s32 syscallno;
+	u32 unused2;
+#endif
+
 	u64 orig_addr_limit;
 	u64 unused;	// maintain 16 byte alignment
 };
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6915697..48c41ff 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -116,8 +116,8 @@
 	 * Set syscallno to -1 by default (overridden later if real syscall).
 	 */
 	.if	\el == 0
-	mvn	x21, xzr
-	str	x21, [sp, #S_SYSCALLNO]
+	mvn	w21, wzr
+	str	w21, [sp, #S_SYSCALLNO]
 	.endif
 
 	/*
@@ -232,8 +232,9 @@ alternative_else_nop_endif
  *
  * x7 is reserved for the system call number in 32-bit mode.
  */
-sc_nr	.req	x25		// number of system calls
-scno	.req	x26		// syscall number
+wsc_nr	.req	w25		// number of system calls
+wscno	.req	w26		// syscall number
+xscno	.req	x26		// syscall number (zero-extended)
 stbl	.req	x27		// syscall table pointer
 tsk	.req	x28		// current thread_info
 
@@ -519,8 +520,8 @@ el0_svc_compat:
 	 * AArch32 syscall handling
 	 */
 	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
-	uxtw	scno, w7			// syscall number in w7 (r7)
-	mov     sc_nr, #__NR_compat_syscalls
+	mov	wscno, w7			// syscall number in w7 (r7)
+	mov     wsc_nr, #__NR_compat_syscalls
 	b	el0_svc_naked
 
 	.align	6
@@ -741,19 +742,19 @@ ENDPROC(ret_from_fork)
 	.align	6
 el0_svc:
 	adrp	stbl, sys_call_table		// load syscall table pointer
-	uxtw	scno, w8			// syscall number in w8
-	mov	sc_nr, #__NR_syscalls
+	mov	wscno, w8			// syscall number in w8
+	mov	wsc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
-	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
+	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
 	enable_dbg_and_irq
 	ct_user_exit 1
 
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
 	tst	x16, #_TIF_SYSCALL_WORK
 	b.ne	__sys_trace
-	cmp     scno, sc_nr                     // check upper syscall limit
+	cmp     wscno, wsc_nr			// check upper syscall limit
 	b.hs	ni_sys
-	ldr	x16, [stbl, scno, lsl #3]	// address in the syscall table
+	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 	b	ret_fast_syscall
 ni_sys:
@@ -767,24 +768,23 @@ ENDPROC(el0_svc)
 	 * switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	mov	w0, #-1				// set default errno for
-	cmp     scno, x0			// user-issued syscall(-1)
+	cmp     wscno, #-1			// user-issued syscall(-1)?
 	b.ne	1f
-	mov	x0, #-ENOSYS
+	mov	x0, #-ENOSYS			// set default errno if so
 	str	x0, [sp, #S_X0]
 1:	mov	x0, sp
 	bl	syscall_trace_enter
 	cmp	w0, #-1				// skip the syscall?
 	b.eq	__sys_trace_return_skipped
-	uxtw	scno, w0			// syscall number (possibly new)
+	mov	wscno, w0			// syscall number (possibly new)
 	mov	x1, sp				// pointer to regs
-	cmp	scno, sc_nr			// check upper syscall limit
+	cmp	wscno, wsc_nr			// check upper syscall limit
 	b.hs	__ni_sys_trace
 	ldp	x0, x1, [sp]			// restore the syscall args
 	ldp	x2, x3, [sp, #S_X2]
 	ldp	x4, x5, [sp, #S_X4]
 	ldp	x6, x7, [sp, #S_X6]
-	ldr	x16, [stbl, scno, lsl #3]	// address in the syscall table
+	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 
 __sys_trace_return:
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8eedeef..193c621 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1346,7 +1346,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	if (dir == PTRACE_SYSCALL_EXIT)
 		tracehook_report_syscall_exit(regs, 0);
 	else if (tracehook_report_syscall_entry(regs))
-		regs->syscallno = ~0UL;
+		regs->syscallno = ~0;
 
 	regs->regs[regno] = saved_reg;
 }
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 404dd67..fd7eba8 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -113,7 +113,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	/*
 	 * Avoid sys_rt_sigreturn() restarting.
 	 */
-	regs->syscallno = ~0UL;
+	regs->syscallno = ~0;
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 
@@ -332,7 +332,7 @@ static void do_signal(struct pt_regs *regs)
 {
 	unsigned long continue_addr = 0, restart_addr = 0;
 	int retval = 0;
-	int syscall = (int)regs->syscallno;
+	int syscall = regs->syscallno;
 	struct ksignal ksig;
 
 	/*
@@ -346,7 +346,7 @@ static void do_signal(struct pt_regs *regs)
 		/*
 		 * Avoid additional syscall restarting via ret_to_user.
 		 */
-		regs->syscallno = ~0UL;
+		regs->syscallno = ~0;
 
 		/*
 		 * Prepare for system call restart. We do this here so that a
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b7063de..1effea2 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -354,7 +354,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	/*
 	 * Avoid compat_sys_sigreturn() restarting.
 	 */
-	regs->syscallno = ~0UL;
+	regs->syscallno = ~0;
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c743d1f..59f80b0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -541,7 +541,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 
 	if (show_unhandled_signals_ratelimited()) {
 		pr_info("%s[%d]: syscall %d\n", current->comm,
-			task_pid_nr(current), (int)regs->syscallno);
+			task_pid_nr(current), regs->syscallno);
 		dump_instr("", regs);
 		if (user_mode(regs))
 			__show_regs(regs);
-- 
2.7.4

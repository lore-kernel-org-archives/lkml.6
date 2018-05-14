Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-536383-1526291484-2-2068299881868243311
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526291484; b=VGlZlWVgiLnATcg7uXZbV6ZAzTy5lJBZXPRuxPBUequMVIcOAs
    3MpRfErAjz01dZVR415/JAk69mdXNAuspZRw9jU3oaZ2ubcYiTBwl/IVXjb4h7vo
    vcJtbdCJoYWmPsO6NnwQ7BtZY9ui24qU2QjQgWXdM9g8MIHyKtN7dLkFlfu4DJkn
    tefTMeyqq49wOeGKnyoBOoRiHkfA9wnWYay7QTmtE7qjVFWv/tJ8LmUhtpSJDraG
    zMvD/rR4yQM+FlLY6aEzXuRdxCY1eX0wiWJEH9+jfWOKkaom5NdTATV3jQNx4LOM
    ljq7ab7F4sjpsk7AWt/vrwJCU5LjhFHX1AIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526291484; bh=
    CKEP7v0rtC9Bph/8/ynLmj/1DNV2upqBtveLaiCC7Es=; b=Dwa3IPkBdVqn437X
    xEqChc1r8IzAfHZCEWbcw6xhWWWpcF51Zgb63OiyJ0URibqKDhmyiZ9Asnr21ZAw
    187vqcyg8DChr4kLyZkKxXO+YVlNxyMMiudYb2dGxftyGzJCMyZi2xFzWcs40s2X
    Y2eRmnzJJ82Cs4I7bmuCIE4S6uXkdHjEEu3PwYdp4jYFFdq5Sa56alZsuNgQQCPx
    Zuu07clcsXVMUAOZHWBO586WcQZyVGVDFvaYw2jrMZaE0BgxUQJwMjkXJn7gdlgO
    r4tTMpf1lPVed3hBwDPVM14KP8qot4IDVliU0nZaJWqm1z/2Uqmz2/mn59Pj+j1A
    mN9EZA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHDGpu/1oVY4RzfEKH0NR68msUFxkAyOY1oFd06Z1Q0ZeWr4y0hMrpywig1dqpqxNa8c2fuJFZKjVd25gnN9jnoz6mS2IR6/ZBCApLxVRZDlc1HWmGY
    LCHBQnVawcra0boYFJEIyqZv6A4jxPbKa2garEok8EyXnuiUsKxnk7yslh/Nb/u+dpRNpxaZyBbUWtjIYr0vAqSCyZTS2mncI0TMkn8NezBEwUI+k3pi06/f
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=ERfQCzku_s5weI16kDQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeENJvU (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 05:51:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752556AbeENJrq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 05:47:46 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 09/18] arm64: convert syscall trace logic to C
Date: Mon, 14 May 2018 10:46:31 +0100
Message-Id: <20180514094640.27569-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently syscall tracing is a tricky assembly state machine, which can
be rather difficult to follow, and even harder to modify. Before we
start fiddling with it for pt_regs syscalls, let's convert it to C.

This is not intended to have any functional change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S   | 53 ++----------------------------------------
 arch/arm64/kernel/syscall.c | 56 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d6e057500eaf..5c60369b52fc 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -866,24 +866,6 @@ el0_error_naked:
 	b	ret_to_user
 ENDPROC(el0_error)
 
-
-/*
- * This is the fast syscall return path.  We do as little as possible here,
- * and this includes saving x0 back into the kernel stack.
- */
-ret_fast_syscall:
-	disable_daif
-	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
-	and	x2, x1, #_TIF_SYSCALL_WORK
-	cbnz	x2, ret_fast_syscall_trace
-	and	x2, x1, #_TIF_WORK_MASK
-	cbnz	x2, work_pending
-	enable_step_tsk x1, x2
-	kernel_exit 0
-ret_fast_syscall_trace:
-	enable_daif
-	b	__sys_trace_return_skipped	// we already saved x0
-
 /*
  * Ok, we need to do extra processing, enter the slow path.
  */
@@ -939,44 +921,13 @@ alternative_else_nop_endif
 #endif
 
 el0_svc_naked:					// compat entry point
-	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
-	enable_daif
-	ct_user_exit 1
-
-	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
-	b.ne	__sys_trace
 	mov	x0, sp
 	mov	w1, wscno
 	mov	w2, wsc_nr
 	mov	x3, stbl
-	bl	invoke_syscall
-	b	ret_fast_syscall
-ENDPROC(el0_svc)
-
-	/*
-	 * This is the really slow path.  We're going to be doing context
-	 * switches, and waiting for our parent to respond.
-	 */
-__sys_trace:
-	cmp     wscno, #NO_SYSCALL		// user-issued syscall(-1)?
-	b.ne	1f
-	mov	x0, #-ENOSYS			// set default errno if so
-	str	x0, [sp, #S_X0]
-1:	mov	x0, sp
-	bl	syscall_trace_enter
-	cmp	w0, #NO_SYSCALL			// skip the syscall?
-	b.eq	__sys_trace_return_skipped
-
-	mov	x0, sp
-	mov	w1, wscno
-	mov w2, wsc_nr
-	mov	x3, stbl
-	bl	invoke_syscall
-
-__sys_trace_return_skipped:
-	mov	x0, sp
-	bl	syscall_trace_exit
+	bl	el0_svc_common
 	b	ret_to_user
+ENDPROC(el0_svc)
 
 	.popsection				// .entry.text
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 58d7569f47df..5df857e32b48 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/compiler.h>
+#include <linux/context_tracking.h>
 #include <linux/nospec.h>
 #include <linux/ptrace.h>
 
+#include <asm/daifflags.h>
+#include <asm/thread_info.h>
+
 long do_ni_syscall(struct pt_regs *regs);
 
 typedef long (*syscall_fn_t)(unsigned long, unsigned long,
@@ -16,8 +21,8 @@ static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
 				   regs->regs[4], regs->regs[5]);
 }
 
-asmlinkage void invoke_syscall(struct pt_regs *regs, int scno, int sc_nr,
-			       syscall_fn_t syscall_table[])
+static void invoke_syscall(struct pt_regs *regs, int scno, int sc_nr,
+			   syscall_fn_t syscall_table[])
 {
 	if (scno < sc_nr) {
 		syscall_fn_t syscall_fn;
@@ -27,3 +32,50 @@ asmlinkage void invoke_syscall(struct pt_regs *regs, int scno, int sc_nr,
 		regs->regs[0] = do_ni_syscall(regs);
 	}
 }
+
+static inline bool has_syscall_work(unsigned long flags)
+{
+	return unlikely(flags & _TIF_SYSCALL_WORK);
+}
+
+int syscall_trace_enter(struct pt_regs *regs);
+void syscall_trace_exit(struct pt_regs *regs);
+
+asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
+			       syscall_fn_t syscall_table[])
+{
+	unsigned long flags = current_thread_info()->flags;
+
+	regs->orig_x0 = regs->regs[0];
+	regs->syscallno = scno;
+
+	local_daif_restore(DAIF_PROCCTX);
+	user_exit();
+
+	if (has_syscall_work(flags)) {
+		/* set default errno for user-issued syscall(-1) */
+		if (scno == NO_SYSCALL)
+			regs->regs[0] = -ENOSYS;
+		scno = syscall_trace_enter(regs);
+		if (scno == NO_SYSCALL)
+			goto trace_exit;
+	}
+
+	invoke_syscall(regs, scno, sc_nr, syscall_table);
+
+	/*
+	 * The tracing status may have changed under our feet, so we have to
+	 * check again. However, if we were tracing entry, then we always trace
+	 * exit regardless, as the old entry assembly did.
+	 */
+	if (!has_syscall_work(flags)) {
+		local_daif_mask();
+		flags = current_thread_info()->flags;
+		if (!has_syscall_work(flags))
+			return;
+		local_daif_restore(DAIF_PROCCTX);
+	}
+
+trace_exit:
+	syscall_trace_exit(regs);
+}
-- 
2.11.0

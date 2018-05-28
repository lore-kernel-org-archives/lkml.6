Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527490998-2-16762081112786321537
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527490997; b=L5JKLCAzM9Rp7s2otHm+u8vRmuqKB72vrSXH2/gIsaI32cb9/y
    qhWqzJvT6pT0569GhGt50/60mp6LrnNHyh2Q7I+r9fx2FiSSKircFtWwISR8vT4D
    2ctZienbtq6X+WPsRV53EdzEmmwc37oQI6LDzSuox8dFDDd3eGU8Y8X7GjTMKcPz
    p5ynJQGfFGkYfMkMluxwJWHJMWYlhYMtADz9aQjVXIhpaEdrl9EONMRq6eXZ3DxS
    AoYXUtKYH2syXvh11oMdbaPKSxiegXn1IC6t5XIDnYbUP7noUgNXCim/iQCmJNXh
    Vf7K5HJk/AaDj+VrejkMwdaoVNeF/bELzlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527490997;
    bh=/mE0ZB0IrHWtcau2C3SAoR6wdD0GkjhWX5xXdDnzWP4=; b=lzqOeIPcSpmS
    NcG5IQIatrREqtXc/1hEJX9FQrrBfA/pbLpthK63d/G3O4CQv4TZU/q5S84r+klK
    I9dBbnjrqE5fkeFjseT5VsElZTxmECRsRLxqiLchK93f6dHK+SiVDFwZwcMfDv9Z
    qVgyu4t9MYuBN6zhwxjhZh4a9coP6G4LntE2wQhrcudRK/LxZpzx2o2Dr9nNHMHv
    GB03LvpV3NrZHZ2EZkfnhwoaCpqyJXcd6EVMW/CzJde/qAXUzI/X266YTgSDIpY/
    82tStstuel5UxIb5lwE+2dA+W2MD0icgVAiFU1NVyLWF1S04hU6ezMjamjg6HC/8
    JZWA4ZX9bQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cMGknDtp header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cMGknDtp header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDjfLkeFDDcJFkgVEavUjkLHAhkYLhw35X2BLyYuGxcCrRuI5iRHuCvwcqky5oqXkb7b35aIfwvaB37T/oRF6B7iOXD2aMFtrQDj4B8NP39hKWvmydYi
    ZPoR4jixKn1EnsS8cG1iUKp4io2vNvpWBDS77O9mtDKmgf3mYfiE6CwK7/g1iClvmbwwbhTJeGNl3HSJ3vB5+G7MlTXhSZxxIQLwZ4ooIxQvkiw+KTNSTIHH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=nu_MgGW0l7XEZc3UTzIA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeE1HDQ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753664AbeE1HDP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:03:15 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org
Subject: [PATCH -tip v4 07/27] powerpc/kprobes: Remove jprobe powerpc implementation
Date: Mon, 28 May 2018 16:02:49 +0900
Message-Id: <152749096922.15132.3313828076631102433.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/powerpc. This also reverts commits
related __is_active_jprobe() function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/powerpc/include/asm/kprobes.h             |    2 -
 arch/powerpc/kernel/kprobes-ftrace.c           |   15 -------
 arch/powerpc/kernel/kprobes.c                  |   54 ------------------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 ++---------------
 4 files changed, 5 insertions(+), 105 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 9f3be5c8a4a3..674036db558b 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -88,7 +88,6 @@ struct prev_kprobe {
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_saved_msr;
-	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
 };
 
@@ -104,7 +103,6 @@ extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
 #ifdef CONFIG_KPROBES_ON_FTRACE
-extern int __is_active_jprobe(unsigned long addr);
 extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 			   struct kprobe_ctlblk *kcb);
 #else
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 7a1f99f1b47f..1b316331c2d9 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -25,21 +25,6 @@
 #include <linux/preempt.h>
 #include <linux/ftrace.h>
 
-/*
- * This is called from ftrace code after invoking registered handlers to
- * disambiguate regs->nip changes done by jprobes and livepatch. We check if
- * there is an active jprobe at the provided address (mcount location).
- */
-int __is_active_jprobe(unsigned long addr)
-{
-	if (!preemptible()) {
-		struct kprobe *p = raw_cpu_read(current_kprobe);
-		return (p && (unsigned long)p->addr == addr) ? 1 : 0;
-	}
-
-	return 0;
-}
-
 static nokprobe_inline
 int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index e4c5bf33970b..600678fce0a8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -611,60 +611,6 @@ unsigned long arch_deref_entry_point(void *entry)
 }
 NOKPROBE_SYMBOL(arch_deref_entry_point);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
-
-	/* setup return addr to the jprobe handler routine */
-	regs->nip = arch_deref_entry_point(jp->entry);
-#ifdef PPC64_ELF_ABI_v2
-	regs->gpr[12] = (unsigned long)jp->entry;
-#elif defined(PPC64_ELF_ABI_v1)
-	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
-#endif
-
-	/*
-	 * jprobes use jprobe_return() which skips the normal return
-	 * path of the function, and this messes up the accounting of the
-	 * function graph tracer.
-	 *
-	 * Pause function graph tracing while performing the jprobe function.
-	 */
-	pause_graph_tracing();
-
-	return 1;
-}
-NOKPROBE_SYMBOL(setjmp_pre_handler);
-
-void __used jprobe_return(void)
-{
-	asm volatile("jprobe_return_trap:\n"
-		     "trap\n"
-		     ::: "memory");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
-		pr_debug("longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
-				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
-		return 0;
-	}
-
-	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
-	/* It's OK to start function graph tracing again */
-	unpause_graph_tracing();
-	preempt_enable_no_resched();
-	return 1;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..4e84a713e80a 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -99,39 +99,13 @@ ftrace_call:
 	bl	ftrace_stub
 	nop
 
-	/* Load the possibly modified NIP */
-	ld	r15, _NIP(r1)
-
+	/* Load ctr with the possibly modified NIP */
+	ld	r3, _NIP(r1)
+	mtctr	r3
 #ifdef CONFIG_LIVEPATCH
-	cmpd	r14, r15	/* has NIP been altered? */
+	cmpd	r14, r3		/* has NIP been altered? */
 #endif
 
-#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_KPROBES_ON_FTRACE)
-	/* NIP has not been altered, skip over further checks */
-	beq	1f
-
-	/* Check if there is an active jprobe on us */
-	subi	r3, r14, 4
-	bl	__is_active_jprobe
-	nop
-
-	/*
-	 * If r3 == 1, then this is a kprobe/jprobe.
-	 * else, this is livepatched function.
-	 *
-	 * The conditional branch for livepatch_handler below will use the
-	 * result of this comparison. For kprobe/jprobe, we just need to branch to
-	 * the new NIP, not call livepatch_handler. The branch below is bne, so we
-	 * want CR0[EQ] to be true if this is a kprobe/jprobe. Which means we want
-	 * CR0[EQ] = (r3 == 1).
-	 */
-	cmpdi	r3, 1
-1:
-#endif
-
-	/* Load CTR with the possibly modified NIP */
-	mtctr	r15
-
 	/* Restore gprs */
 	REST_GPR(0,r1)
 	REST_10GPRS(2,r1)
@@ -149,10 +123,7 @@ ftrace_call:
 	addi r1, r1, SWITCH_FRAME_SIZE
 
 #ifdef CONFIG_LIVEPATCH
-        /*
-	 * Based on the cmpd or cmpdi above, if the NIP was altered and we're
-	 * not on a kprobe/jprobe, then handle livepatch.
-	 */
+        /* Based on the cmpd above, if the NIP was altered handle livepatch */
 	bne-	livepatch_handler
 #endif
 

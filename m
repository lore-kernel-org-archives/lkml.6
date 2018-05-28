Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527490874-2-15946221964391326467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527490874; b=I7mlss1RR9QckL/gflSztxSmcD9v4uuFd5gryyenZxw5B3OxNa
    Kb1Si9WhTcrZWE1N7P2b9LsHeQ1bRVPIi/uwbvByfzkUEkb0NmJkQsqSeuIIOjZg
    lMXbDosPT0rqMgPR+QSGY87aiZAKrYC1ao10LE2eJPIwlVc14nQNP5f2qvLPFkl+
    D5X4TTSCrlTR/B1PslkzCX2mhZuJR1bCIEPXcmpkYr7r/vTpdZALRSiiEKmO9X1G
    +fDxcv3TgXhfcLMAY8ehq3LPnKRDVl/LO7HAphCEBOx0cEgZTpT/OiCwxY5jOZB1
    7ma4Y1JWMLAAhw9b+4595wEDd0Re7KZ4KSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527490874;
    bh=UFAg6FEHt428so/FzEzPPrk5bSOpDgB16rrOE5lnLHI=; b=GjlvmyL4LzQG
    sfX920gkKHUI/gmQVYK8PzhRXcj5ZBlvmoVMZU0k//LmO5LPnDub4cLD4h2WKjB0
    I3ZdsmnmnumErzsHU6p09vpDDU0DvxR90nLfoG3Fax8MJXTM/Wuv88nowpOIC/eg
    JiD9vjqUMmncpo6YcjSrMa6wZFewaEDx2XITJMsjWP8hAixO+MiO8vnlq8uXZZyu
    8h+ABwjvxv13r2Ogeo2geqBvON6irR3gvsFgYBTj6Uuck2Uu24+j8XieLSZYLafd
    etSQwenL6BGmA5xnKHaNjMQi0SUfBmQhkSNiPX+T1vtHEyT4/7OIMpCFQiyGKOfj
    m2svbiKdqw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=u+gOmb0X header.a=rsa-sha256
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=u+gOmb0X header.a=rsa-sha256
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
X-CM-Envelope: MS4wfAIuG9dGnzfTIsyXIOswTXAINa93ecGsgHTqkqOI55ghUB2i4llNOgfh94CjWBovw+xVHGxCm5jjZJswpg21haxwGW4H0Rdx3rWDaoWrZhmhuxRLA/06
    8XNPUA4EecXHbXZu8mXFeLKygliuOGqZ5HjdL1GsbH3sRWivtZZ3kxTwHQ5CtXD2eThYhfLzD24eGotFX+jz5Gsclc8w7teCq1MfBqs231DAnlHBhNHJRvwB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=XIhNERdXnhqi_lJYgg8A:9 a=nNaG7iS6SkR_Fg3B:21
    a=S-XkvzucTmh3Itil:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeE1HBL (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753415AbeE1HBK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:01:10 -0400
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
Subject: [PATCH -tip v4 03/27] kprobes/x86: Remove jprobe implementation
Date: Mon, 28 May 2018 16:00:44 +0900
Message-Id: <152749084456.15132.1510513501798498714.stgit@devbox>
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
from arch/x86.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/kprobes.h |    3 -
 arch/x86/kernel/kprobes/core.c |   96 +---------------------------------------
 2 files changed, 3 insertions(+), 96 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 367d99cff426..06782c2efa04 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -111,9 +111,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_old_flags;
 	unsigned long kprobe_saved_flags;
-	unsigned long *jprobe_saved_sp;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6f4d42377fe5..1b2d1acba810 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -66,8 +66,6 @@
 
 #include "common.h"
 
-void jprobe_return_end(void);
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -690,10 +688,9 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			/*
 			 * If we have no pre-handler or it returned 0, we
 			 * continue with normal processing.  If we have a
-			 * pre-handler and it returned non-zero, it prepped
-			 * for calling the break_handler below on re-entry
-			 * for jprobe processing, so get out doing nothing
-			 * more here.
+			 * pre-handler and it returned non-zero, that means
+			 * user handler setup registers to exit to another
+			 * instruction, we must skip the single stepping.
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs))
 				setup_singlestep(p, regs, kcb, 0);
@@ -1083,93 +1080,6 @@ int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
 }
 NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	unsigned long addr;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_sp = stack_addr(regs);
-	addr = (unsigned long)(kcb->jprobe_saved_sp);
-
-	/*
-	 * As Linus pointed out, gcc assumes that the callee
-	 * owns the argument space and could overwrite it, e.g.
-	 * tailcall optimization. So, to be absolutely safe
-	 * we also save and restore enough stack bytes to cover
-	 * the argument area.
-	 * Use __memcpy() to avoid KASAN stack out-of-bounds reports as we copy
-	 * raw stack chunk with redzones:
-	 */
-	__memcpy(kcb->jprobes_stack, (kprobe_opcode_t *)addr, MIN_STACK_SIZE(addr));
-	regs->ip = (unsigned long)(jp->entry);
-
-	/*
-	 * jprobes use jprobe_return() which skips the normal return
-	 * path of the function, and this messes up the accounting of the
-	 * function graph tracer to get messed up.
-	 *
-	 * Pause function graph tracing while performing the jprobe function.
-	 */
-	pause_graph_tracing();
-	return 1;
-}
-NOKPROBE_SYMBOL(setjmp_pre_handler);
-
-void jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	/* Unpoison stack redzones in the frames we are going to jump over. */
-	kasan_unpoison_stack_above_sp_to(kcb->jprobe_saved_sp);
-
-	asm volatile (
-#ifdef CONFIG_X86_64
-			"       xchg   %%rbx,%%rsp	\n"
-#else
-			"       xchgl   %%ebx,%%esp	\n"
-#endif
-			"       int3			\n"
-			"       .globl jprobe_return_end\n"
-			"       jprobe_return_end:	\n"
-			"       nop			\n"::"b"
-			(kcb->jprobe_saved_sp):"memory");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-NOKPROBE_SYMBOL(jprobe_return_end);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	u8 *addr = (u8 *) (regs->ip - 1);
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	void *saved_sp = kcb->jprobe_saved_sp;
-
-	if ((addr > (u8 *) jprobe_return) &&
-	    (addr < (u8 *) jprobe_return_end)) {
-		if (stack_addr(regs) != saved_sp) {
-			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
-			printk(KERN_ERR
-			       "current sp %p does not match saved sp %p\n",
-			       stack_addr(regs), saved_sp);
-			printk(KERN_ERR "Saved registers for jprobe %p\n", jp);
-			show_regs(saved_regs);
-			printk(KERN_ERR "Current registers\n");
-			show_regs(regs);
-			BUG();
-		}
-		/* It's OK to start function graph tracing again */
-		unpause_graph_tracing();
-		*regs = kcb->jprobe_saved_regs;
-		__memcpy(saved_sp, kcb->jprobes_stack, MIN_STACK_SIZE(saved_sp));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	bool is_in_entry_trampoline_section = false;

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127658-2-14450345775351635207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127658; b=LufeM8f4V/n8FzMCEA1/Yb3kHrb0f5oa34wQSph5OkJeu3zaZr
    9l+pEzg1gTEOov3I+SntGg9Zc+6PX/G3SztPS0u7Tp49vS2AvBdAx/is0aaw5LjN
    +uV0kMLaNW0mZjUsMDdg5d5B5fFQ2vel5ssnh3bRMnbF1U3Rxek701P4JBv0WyVW
    socda44+Ok3Xap28QWCoQ1QwGJryc5Xs8W8IegQ7LwiUoZ7kQI0Uj26xRFNORE1A
    icgtELUbRGfyShpZx4DzsKJcHnJZuujhUj1zzTaRpMOSuXRpoQo8H5Y6zNDWBLYe
    wI0PL0tC3iYuHSDvIL0RTBcBm+MbPtu8CyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127658;
    bh=JWQjFGX/zVtkq1lmsJw6B00gawB7MEhAcGApAXDua2o=; b=Q5TOsk/khHpf
    l05eCGtH3kzdAmB+uNMnfCh5af31mLtEHC0vrMnJLdVr349osqaBBP8jFqIrwfKD
    LQJzSlMz+OKVMsSKToCmQoJlWZ0LRE0/xBMAwtaVkySjcyfs3dUqe3mLDyidbQZ6
    TRQYr6EGYsfO8npFRDVRauNq30cQQJ+0hplAs9SCzF9m5lVga+j54aZLg91Zi+ST
    X1ZJ2LNAc5p2rUfVUMzOsJ43ldKMnGhGytVIsF3BCP78o46+YLE1tIk2g02Wv3SQ
    9193HWCRMn2WhsUICGWneU+6tzbhvOUvw1aOnCh0c+aXWiXsT5A1d8Ml5D4KKaEz
    Pe72747I1w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=vPg6CASp header.a=rsa-sha256
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
      header.i=@kernel.org header.b=vPg6CASp header.a=rsa-sha256
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
X-CM-Envelope: MS4wfEje+AOnjnXNrZ0P5Ls+LTvClMSKqJ1D+DD/7QiVBauv1MGjPLIkkjnWdLNdkqrERAfGGlYEQnWJevZb+Ukq4nEYzLt8EBP02ZWFXVwP5JYe96/O0IUk
    dEyUo8HzpHE2UI/nXeUpFYEU5TN2hry2g6hVU+M7GUWza3Xn/1QiuHaHp/mGOIaI2H4Nzob2T4a6TS45gapXnB+7JSVzsmf0NiBGJcDWnpbn5U5PsioRjFx6
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=hAG5_4vcAAAA:8 a=tfqqxshhv4CrWzKj9C8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=8Bh8Pg2EFav9IBZ9i9Tn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbeFDPyP (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeFDPyP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:54:15 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [RFC PATCH -tip v5 11/27] sh: kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:53:51 +0900
Message-Id: <152812763085.10068.16638990246121050854.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
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
from arch/sh.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/kprobes.h |    4 ---
 arch/sh/kernel/kprobes.c      |   51 -----------------------------------------
 2 files changed, 55 deletions(-)

diff --git a/arch/sh/include/asm/kprobes.h b/arch/sh/include/asm/kprobes.h
index 85d8bcaa8493..6171682f7798 100644
--- a/arch/sh/include/asm/kprobes.h
+++ b/arch/sh/include/asm/kprobes.h
@@ -27,7 +27,6 @@ struct kprobe;
 
 void arch_remove_kprobe(struct kprobe *);
 void kretprobe_trampoline(void);
-void jprobe_return_end(void);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
@@ -43,9 +42,6 @@ struct prev_kprobe {
 /* per-cpu kprobe control block */
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
-	unsigned long jprobe_saved_r15;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 52a5e11247d1..2b5e58873b96 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -523,57 +523,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	unsigned long addr;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_r15 = regs->regs[15];
-	addr = kcb->jprobe_saved_r15;
-
-	/*
-	 * TBD: As Linus pointed out, gcc assumes that the callee
-	 * owns the argument space and could overwrite it, e.g.
-	 * tailcall optimization. So, to be absolutely safe
-	 * we also save and restore enough stack bytes to cover
-	 * the argument area.
-	 */
-	memcpy(kcb->jprobes_stack, (kprobe_opcode_t *) addr,
-	       MIN_STACK_SIZE(addr));
-
-	regs->pc = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	asm volatile ("trapa #0x3a\n\t" "jprobe_return_end:\n\t" "nop\n\t");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long stack_addr = kcb->jprobe_saved_r15;
-	u8 *addr = (u8 *)regs->pc;
-
-	if ((addr >= (u8 *)jprobe_return) &&
-	    (addr <= (u8 *)jprobe_return_end)) {
-		*regs = kcb->jprobe_saved_regs;
-
-		memcpy((kprobe_opcode_t *)stack_addr, kcb->jprobes_stack,
-		       MIN_STACK_SIZE(stack_addr));
-
-		kcb->kprobe_status = KPROBE_HIT_SS;
-		preempt_enable_no_resched();
-		return 1;
-	}
-
-	return 0;
-}
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *)&kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler

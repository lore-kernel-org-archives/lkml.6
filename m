Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127512-2-4169549204360160982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127512; b=LJ1qrFlTIqgwpxlDj0k/yHMaLkyklrKTPwvrzVgXcFxiRzSepg
    Z6FSrHiYO3Wyj+nXyxFuxDoz+oKHBc523bZJwI04tUQ6samWZxssvpGgmkC3EnPM
    VxogId63PsTPErIuNqYTBI3JPPouhfyM+ZpC5M2JeVE706qCh+R0wyPRldcdBRX/
    8QOiyZNuO844LQoIfr3EFC5QgcJ2kGVOy6+lQnzIlLAuZIaEMrtpV9b6BrAtRW0A
    8wqv4Y5dAbK4ULFlTCkERJEsuU72ZWLjOXPM8QUXd8nbngTtX3sCRE+PPXdJ04z8
    bwb9NSn713zno5wbp9Kvdlg0VP0IB5t2wZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127512;
    bh=3IiGTZNi3s9m7BKUEQdQZjUtCNRJKJ+zL0c4MFvTSnE=; b=fohCG9s1DdjA
    q69NAGbxBT6KbGQE7h/ASF4h5BG7HbUPycYWcCFZeUFR+wYDINufVYLbULuX1w3P
    8BXZHr4rMxocw+smnjyczJ6r20EEUou/KXpENV6BDiM03iUN2vVhz+QmYsQrEWpU
    dKB4gSYoxxolq64S67NbiHz+MtOw6JwM81lLPm/7B5ea6yOcjN56xjUtdkQArkBK
    4Gd1WcyWLPTS2F19dFdotsf2btQqCEdfrsiVUX+4MU2e52bk8VPoCdlYjcDymOpn
    s2j+gyTaKthw5W7uKv0f3nBxTUbQloXI/kAiCWZGA7rqEB1BDrnyS9iJul2aL3pf
    1YreWtxGkw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Ysy92JBG header.a=rsa-sha256
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Ysy92JBG header.a=rsa-sha256
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
X-CM-Envelope: MS4wfHyOwyHZjI/DMjoNDgd4HyLqU2N2MlsI9gRfKNDG11UP1hgPVjZpmHTuff+LbjSBTw/bUZP3i/myXT33wgUmccFuyAeSTDJizCZKQQ0r8QloVMVGCo9D
    1hcEZxsJHJFDKHfKqP4YJAcUSzBWwZ0kGB7zTnOVoAx8X+Eatu43Prbv4aKKZI0pFyYv4wNvSwlRd5S900kHRWp/IXrZFZmDD3RqDNq5ZISdMRmPTuZt4HE0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=ETQ_ECji3JOGjVEKxJ8A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeFDPvt (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbeFDPvs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:51:48 -0400
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH -tip v5 06/27] arm64: kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:51:24 +0900
Message-Id: <152812748464.10068.10380156315388629319.stgit@devbox>
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
from arch/arm64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/kprobes.h   |    1 -
 arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 6deb8d726041..d5a44cf859e9 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -48,7 +48,6 @@ struct kprobe_ctlblk {
 	unsigned long saved_irqflag;
 	struct prev_kprobe prev_kprobe;
 	struct kprobe_step_ctx ss_ctx;
-	struct pt_regs jprobe_saved_regs;
 };
 
 void arch_remove_kprobe(struct kprobe *);
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d9804011..3ca2351109a6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,74 +465,6 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 	return DBG_HOOK_HANDLED;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	/*
-	 * Since we can't be sure where in the stack frame "stacked"
-	 * pass-by-value arguments are stored we just don't try to
-	 * duplicate any of the stack. Do not use jprobes on functions that
-	 * use more than 64 bytes (after padding each to an 8 byte boundary)
-	 * of arguments, or pass individual arguments larger than 16 bytes.
-	 */
-
-	instruction_pointer_set(regs, (unsigned long) jp->entry);
-	preempt_disable();
-	pause_graph_tracing();
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	/*
-	 * Jprobe handler return by entering break exception,
-	 * encoded same as kprobe, but with following conditions
-	 * -a special PC to identify it from the other kprobes.
-	 * -restore stack addr to original saved pt_regs
-	 */
-	asm volatile("				mov sp, %0	\n"
-		     "jprobe_return_break:	brk %1		\n"
-		     :
-		     : "r" (kcb->jprobe_saved_regs.sp),
-		       "I" (BRK64_ESR_KPROBES)
-		     : "memory");
-
-	unreachable();
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	long stack_addr = kcb->jprobe_saved_regs.sp;
-	long orig_sp = kernel_stack_pointer(regs);
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	extern const char jprobe_return_break[];
-
-	if (instruction_pointer(regs) != (u64) jprobe_return_break)
-		return 0;
-
-	if (orig_sp != stack_addr) {
-		struct pt_regs *saved_regs =
-		    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
-		pr_err("current sp %lx does not match saved sp %lx\n",
-		       orig_sp, stack_addr);
-		pr_err("Saved registers for jprobe %p\n", jp);
-		__show_regs(saved_regs);
-		pr_err("Current registers\n");
-		__show_regs(regs);
-		BUG();
-	}
-	unpause_graph_tracing();
-	*regs = kcb->jprobe_saved_regs;
-	preempt_enable_no_resched();
-	return 1;
-}
-
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
 	if ((addr >= (unsigned long)__kprobes_text_start &&

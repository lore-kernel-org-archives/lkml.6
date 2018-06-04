Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127600-2-11644509472067939860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127599; b=hr7aQVrb7SixB2AHGEbhiddUGln1jefFnmFHhPhquwpokFrsz+
    vZ8g7UhNhO2Be1jpQOPb1q+0v8sXjIVpk6+dKtP10ELMz9X6Tri6J/B5NWAupskn
    wT9YWufWWz+k0lVMPPFos/ELVoKydVI5wli5hw6/42xY/1R2VbQcPaN3beUeoUtn
    vGHV1rg1+s0zOeBhZdqlrJYazA2smNI4/MpNykLkdqqZMSEfatYZR+QjLta3w11T
    9jx+POxg26sA3DvAlR+l/JPnDuoqnQhOMGZ6i7pjqHbHQdDq7Um+hIidbYP4HVjS
    M4XNpprVbapu8tM9Z4d9rpypCcoCvmFlg++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127599;
    bh=A5xStgDOe7ojxKNV06rFsCKfCHvk8Xil0NZuWBlSDYE=; b=OvKqGQrDI3GG
    S6cIew91c33xqRBVN34mOxOxSBhae2JSu5hiTylFAWrxaWRnxIqNU73MvhmuQRNA
    D4MJWdvH/Qr1n2vSDSkb41K5xbq7PIZ4mBRT25m7eGPfDF09ue8jFfGVQQIclV/K
    85xOJN2WW0oxx/D7J6E5rEz/xmq2tvfoSfREQdQQ7SPuQj+IiSAVqj7c9qPvTCpB
    Cc9cE9jN+tyw+5Sdm/ikouFL0O3NTk5OL56f2Aih4SZZeUmjOGwG4m4wRKKBxpUL
    oAzYOIcxCMQLtDQLDMaiyvLfviztTEz7llLZBXmQI0lHnWomHLjhsNQqzW9Zg6nT
    ONwc0416eg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=KDG3bRCS header.a=rsa-sha256
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
      header.i=@kernel.org header.b=KDG3bRCS header.a=rsa-sha256
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
X-CM-Envelope: MS4wfOmc2DOaSPX4XdeTqMu/BJXSQJ02G0vPNJHPL0g6vK1StN5lBaRkzViT+PLN9ioG9WRRCKXCt8/RpyrlGDXQXUucwV3RzcBa0x1iU7P5PCKIocH/kJKD
    KiTkbS71o3BrHZWhEId3UfY+AJ0O14NnPghjMgZo7dJjDVCS5RHammVoVpoMHsllmv+ey8UnFWCoa/4asaOtFh/sUmM5oyrWSDfenCbsSiME8q8WDbTQ/gKs
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8 a=Ahc1vw_NPD4h5qREHWgA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeFDPxR (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeFDPxQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:53:16 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH -tip v5 09/27] MIPS: kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:52:52 +0900
Message-Id: <152812757230.10068.6282345214798526578.stgit@devbox>
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
from arch/mips.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/kprobes.h |   13 -----------
 arch/mips/kernel/kprobes.c      |   45 ---------------------------------------
 2 files changed, 58 deletions(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index ad1a99948f27..a72dfbf1babb 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -68,16 +68,6 @@ struct prev_kprobe {
 	unsigned long saved_epc;
 };
 
-#define MAX_JPROBES_STACK_SIZE 128
-#define MAX_JPROBES_STACK_ADDR \
-	(((unsigned long)current_thread_info()) + THREAD_SIZE - 32 - sizeof(struct pt_regs))
-
-#define MIN_JPROBES_STACK_SIZE(ADDR)					\
-	((((ADDR) + MAX_JPROBES_STACK_SIZE) > MAX_JPROBES_STACK_ADDR)	\
-		? MAX_JPROBES_STACK_ADDR - (ADDR)			\
-		: MAX_JPROBES_STACK_SIZE)
-
-
 #define SKIP_DELAYSLOT 0x0001
 
 /* per-cpu kprobe control block */
@@ -86,12 +76,9 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_old_SR;
 	unsigned long kprobe_saved_SR;
 	unsigned long kprobe_saved_epc;
-	unsigned long jprobe_saved_sp;
-	struct pt_regs jprobe_saved_regs;
 	/* Per-thread fields, used while emulating branches */
 	unsigned long flags;
 	unsigned long target_epc;
-	u8 jprobes_stack[MAX_JPROBES_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index f5c8bce70db2..efdcd0b1ce12 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -468,51 +468,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	kcb->jprobe_saved_regs = *regs;
-	kcb->jprobe_saved_sp = regs->regs[29];
-
-	memcpy(kcb->jprobes_stack, (void *)kcb->jprobe_saved_sp,
-	       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-
-	regs->cp0_epc = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-/* Defined in the inline asm below. */
-void jprobe_return_end(void);
-
-void __kprobes jprobe_return(void)
-{
-	/* Assembler quirk necessitates this '0,code' business.	 */
-	asm volatile(
-		"break 0,%0\n\t"
-		".globl jprobe_return_end\n"
-		"jprobe_return_end:\n"
-		: : "n" (BRK_KPROBE_BP) : "memory");
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (regs->cp0_epc >= (unsigned long)jprobe_return &&
-	    regs->cp0_epc <= (unsigned long)jprobe_return_end) {
-		*regs = kcb->jprobe_saved_regs;
-		memcpy((void *)kcb->jprobe_saved_sp, kcb->jprobes_stack,
-		       MIN_JPROBES_STACK_SIZE(kcb->jprobe_saved_sp));
-		preempt_enable_no_resched();
-
-		return 1;
-	}
-	return 0;
-}
-
 /*
  * Function return probe trampoline:
  *	- init_kprobes() establishes a probepoint here

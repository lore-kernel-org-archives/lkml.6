Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127452-5-11597230113846851956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127452; b=RMuiowgM4+GhnDxDLoqCqprGGu0Qt4cRAQG8HYPxAK2vV14PiC
    6o2RBUVyMZcn1zH7CR1ZguM0cQLkHWeIWiqZoA8gVnog0HHLLVoKwLYDTxKqA+/m
    1HwAr422vul1VLRuxA9SylOR1+w+bO8IzDy9KA8bLROn/CxRuGy7P5aS/LahO1be
    X3ODuqpVUo1GdmIHuuliNUIs9yp6UoPVmbfwUk0ledeYcGyxZXEB5fixarM3qNU9
    93a2Baum+HplCZUZCiSfQ3+lB21aub7k63yvfnk0swoFJ/NxKH3s2cAbOuMr3ohg
    pPNWOgvHAtmef/dfTCBPM3Zmmkf+nVWlvOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127452;
    bh=AE2OBWBIE6jwPWmze3/UaXShXD13cSxzYcMgpbZuKwg=; b=H09OrxVlN77D
    +nouPdE0Z+avVhC8UfcSzhjiVvz6pv0xZ8xVveaS+yzoMmu1EOABHVez7accteTC
    0VPtUVsisLp10EpWU2lEI1YoJQw5x6694L8PK+KSXHbaarzUYq0CBaJ2/FHPCIUK
    5LNvSp6m9T8yb4rBaKyVkSYs4rGAHJX/3HYzRxD+xRN7Wlizrr7TtRqRAJmIdGVW
    FNdER3VHjlo3FB5bL3Wte7vW+wSThA65t2ksY2B4yvvS4BP2m+MesRtvu///nwlP
    ceUOap5NZlf9wetn4C0/yLQAIfjzwiilYja7kwq+eZQ/DMcCfXKiI4NX+J8w1HNr
    tiWWvx9ttA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=aGUjP3xY header.a=rsa-sha256
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
      header.i=@kernel.org header.b=aGUjP3xY header.a=rsa-sha256
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
X-CM-Envelope: MS4wfO0BntBVaSo4HMNNp2u11MmaqCvNFiDV0pBZO7qkD0UgIsVhmkwWTyv8+0N0EF5Ucfg5naPZqZ0van5mLwLRZcB2o6p3s9jlYEWIy8y0jP2Ej85EDJ+7
    wVseqa6WS5dFsw9ZhBuY6X0D/mN2aiU+JavzbzOdjfvWeBQwqBYeMYBrjo95NocPtlsj+fnVVblUDsgcyUTFS4l70ejrPOqz5uvsuuqURKVe/iIdG9y9xf5n
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=JfrnYn6hAAAA:8 a=ch7q7--6MBsdxLFZNGQA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeFDPuv (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeFDPuu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:50:50 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: [RFC PATCH -tip v5 04/27] ARC: kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:50:26 +0900
Message-Id: <152812742672.10068.6794442189016791113.stgit@devbox>
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
from arch/arc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/include/asm/kprobes.h |    2 --
 arch/arc/kernel/kprobes.c      |   38 ++------------------------------------
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/arc/include/asm/kprobes.h b/arch/arc/include/asm/kprobes.h
index 2e52d18e6bc7..2c1b479d5aea 100644
--- a/arch/arc/include/asm/kprobes.h
+++ b/arch/arc/include/asm/kprobes.h
@@ -45,8 +45,6 @@ struct prev_kprobe {
 
 struct kprobe_ctlblk {
 	unsigned int kprobe_status;
-	struct pt_regs jprobe_saved_regs;
-	char jprobes_stack[MAX_STACK_SIZE];
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 42b05046fad9..7811a6bbe8f0 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -225,10 +225,8 @@ int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 
 		/* If we have no pre-handler or it returned 0, we continue with
 		 * normal processing. If we have a pre-handler and it returned
-		 * non-zero - which is expected from setjmp_pre_handler for
-		 * jprobe, we return without single stepping and leave that to
-		 * the break-handler which is invoked by a kprobe from
-		 * jprobe_return
+		 * non-zero - which means user handler setup registers to exit
+		 * to another instruction, we must skip the single stepping.
 		 */
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
 			setup_singlestep(p, regs);
@@ -386,38 +384,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long sp_addr = regs->sp;
-
-	kcb->jprobe_saved_regs = *regs;
-	memcpy(kcb->jprobes_stack, (void *)sp_addr, MIN_STACK_SIZE(sp_addr));
-	regs->ret = (unsigned long)(jp->entry);
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	__asm__ __volatile__("unimp_s");
-	return;
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long sp_addr;
-
-	*regs = kcb->jprobe_saved_regs;
-	sp_addr = regs->sp;
-	memcpy((void *)sp_addr, kcb->jprobes_stack, MIN_STACK_SIZE(sp_addr));
-	preempt_enable_no_resched();
-
-	return 1;
-}
-
 static void __used kretprobe_trampoline_holder(void)
 {
 	__asm__ __volatile__(".global kretprobe_trampoline\n"

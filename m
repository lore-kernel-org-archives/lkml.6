Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127629-2-16571235127325755957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127629; b=R78cUIVUPVubSnNwPU4ZAHPaP2WDSp5BOoMOcW9nVAPUIoHOtQ
    +tOBZ+/6hMb0grWpd25jISjiPmJroDbvK/Ng0BBOD6b1Umd7jH94iJTL7rUWXvB4
    ft7+fypxSM9E2/PR0tI/uu22zkQ5/o2cL4hWaA+v2DrdMGd7n4vfr3EVeFJd1W6u
    41vsrC6mTBOdkl4hqTHeDx4DuLwXamWKtMdqCCf8fSjA/kIAgRSs6BdWM79+/z/O
    Ifhl/cXDMU3rYw9p9voM2RyYRYun7c//jUQkITyntpsNALAAzJmILHIhXzVyJ7+f
    AYOFfB4khm1mt2mEWI8PeF+/qmywIdy+HDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127629;
    bh=PMmIeAVovJFUqEob54pQNd2/8RZkWXtH4GaRwdf1lG4=; b=SIZbbANX5BfK
    ZLXkSCFD2pEJcTbnxQOYnf8n+EeQGS/KEfRVK4182Mqp24KJN/chFwrliQBWRt0s
    RH+k6HhU3IZC9udQQOaASdbZWrsprOZHUsPahfXupSmxbFg08jruZ55jaYkkXC0S
    iXw6KmbAZXJf0Ox97Ck2nzJuhtJnsjy110dtoLCeklUcHS9wNdhTonxlm0JLZZvk
    v8TiOo+8+1fCh+R9R5lprKtgrn6ORMlqBAiZyJypM8fpzKDN3CrqGg3/17xzqcJ0
    PTJGhmdvR7EYpCWbKfkZ3WX0wOGyv4AdTjmAPE6Tkf2qqL9SVA2QI0kv3kZM3gXh
    qx/qppFUrQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=T0qO1jrj header.a=rsa-sha256
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
      header.i=@kernel.org header.b=T0qO1jrj header.a=rsa-sha256
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
X-CM-Envelope: MS4wfLJEz95nQKlfqh2TQWik3HnC7lC14YivzaUwhPrdpFRFx1LtTJWN5GtDNO8ZhLwpUGBa894rKcKQCygf/qcgMfPcRF0DiBgZDMcWo0Bs364dgXiA7vq9
    u0YocRT5m8hyVpLelggAdbDP6KI1OwQsiNOgovwJRpfMD/2gredgCoF/vqAjF9pqenOZzd1vX6Sg82gjXRKt70PZA89mB3lU0XyfLj8KwVbsZ/kK0y0tCBZR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EMZZQjxb8AIeVhpNRCEA:9
    a=ArWOdi8MGLwHQDh4:21 a=F5kMpptV1d0Zcg3W:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeFDPxq (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbeFDPxq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:53:46 -0400
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
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [RFC PATCH -tip v5 10/27] s390/kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:53:21 +0900
Message-Id: <152812760168.10068.2235377345946129423.stgit@devbox>
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
from arch/s390.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/kprobes.h |    2 -
 arch/s390/kernel/kprobes.c      |   59 +--------------------------------------
 2 files changed, 2 insertions(+), 59 deletions(-)

diff --git a/arch/s390/include/asm/kprobes.h b/arch/s390/include/asm/kprobes.h
index 13de80cf741c..b106aa29bf55 100644
--- a/arch/s390/include/asm/kprobes.h
+++ b/arch/s390/include/asm/kprobes.h
@@ -68,8 +68,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_saved_imask;
 	unsigned long kprobe_saved_ctl[3];
 	struct prev_kprobe prev_kprobe;
-	struct pt_regs jprobe_saved_regs;
-	kprobe_opcode_t jprobes_stack[MAX_STACK_SIZE];
 };
 
 void arch_remove_kprobe(struct kprobe *p);
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 60f60afa645c..0967de19f53d 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -321,9 +321,8 @@ static int kprobe_handler(struct pt_regs *regs)
 			 * If we have no pre-handler or it returned 0, we
 			 * continue with single stepping. If we have a
 			 * pre-handler and it returned non-zero, it prepped
-			 * for calling the break_handler below on re-entry
-			 * for jprobe processing, so get out doing nothing
-			 * more here.
+			 * for changing execution path, so get out doing
+			 * nothing more here.
 			 */
 			push_kprobe(kcb, p);
 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
@@ -661,60 +660,6 @@ int kprobe_exceptions_notify(struct notifier_block *self,
 }
 NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long stack;
-
-	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
-
-	/* setup return addr to the jprobe handler routine */
-	regs->psw.addr = (unsigned long) jp->entry;
-	regs->psw.mask &= ~(PSW_MASK_IO | PSW_MASK_EXT);
-
-	/* r15 is the stack pointer */
-	stack = (unsigned long) regs->gprs[15];
-
-	memcpy(kcb->jprobes_stack, (void *) stack, MIN_STACK_SIZE(stack));
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
-	asm volatile(".word 0x0002");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	unsigned long stack;
-
-	/* It's OK to start function graph tracing again */
-	unpause_graph_tracing();
-
-	stack = (unsigned long) kcb->jprobe_saved_regs.gprs[15];
-
-	/* Put the regs back */
-	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
-	/* put the stack back */
-	memcpy((void *) stack, kcb->jprobes_stack, MIN_STACK_SIZE(stack));
-	preempt_enable_no_resched();
-	return 1;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 static struct kprobe trampoline = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler

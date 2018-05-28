Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527491092-5-12482626706601685907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491092; b=KmLO+bR5fomcoNiWIE1MM26jxwbXLSK4oFjlil3fnusKWkrZ8m
    5wEqGKgQeshssBAwh5JtqlkPzOR7hA6LZa2nDI4nLSu13crhel7dvB4Ml+oBM5JB
    TDd/p7H5JnGfVUFlkFHSUQrdJ05ShyhnFD+YonUv+svlk1qRYGKcZqOiQ/cup65M
    hbXuB+wb0kQeguv+RSft8G4ufrCn2VhbwEtOqSc27cPoQ/dlKtrNYYQQzq92++U6
    vq4aBpDnHXRAzudw/MS1yRw9hoNAE1IdJdePnFKxdbhExdjcxeNGeUewstULdwRO
    of1pnvG45BDkk0UI4TeTuoxiDW6tKpz+i4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491092;
    bh=88F6bC8yxno6Q/IUIwdWCfX/9G3O5g/TtlXYibUjLGs=; b=Rv5/nVtuEPaV
    SCb1G1VGSmEm6Y1gpEKbEddYgszSrrJR3hmwiW5UkpOJc7wPAf4ouycvBV3/bBT/
    eINKIC/L6/dZE64p7ec5gU+8lCeD5VMC+SDvDSg3QeTaAf4O51nwatQb19PzR9oU
    JxZZxsgvhRwreTkqkdj2jOSW3XFGJ/ok9xMKScEziMabhWvLQBhL/QCOvtwNPu0A
    cmN6tvBzGWstwABKye0aDPRyCFkGzcxGUkfIPION7S75R7YW89Gst3KvJafHCDH5
    INYXXuoQoX4F0o5mLxzkDNYyrZO3fFtziUwTqyUJtKsrsFDLeRJ+yQGwkdNvWMJH
    VwMmSey/hA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=YRhUI4mQ header.a=rsa-sha256
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=YRhUI4mQ header.a=rsa-sha256
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
X-CM-Envelope: MS4wfEp3aU7kE/k1kNNKEuh9tCzcnTFvt9GX59zBOsX2sf82LboT+potxzEhefm9dYfrLXkZCC5J0vqSLbQdpJaHr4h5DwBmbxNBj2vGdyDpvTN64eg4FpCQ
    sOFDWtg58g21F0wVU4z3xxzEvvT16mkfocLHhSLRf1DaY+1K5ec5hGf1eOWwkTkhVsFURtJ0tjVwdkPrc/rdgIL3YGqBGUWxcILLHvuGUT8v7rZDN+w/oSt+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=EMZZQjxb8AIeVhpNRCEA:9 a=Kty-GkjW1yLAjTgr:21
    a=EufYG1L75R47ABg4:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753735AbeE1HEt (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753657AbeE1HEt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:04:49 -0400
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
Subject: [PATCH -tip v4 10/27] s390/kprobes: Remove jprobe implementation
Date: Mon, 28 May 2018 16:04:22 +0900
Message-Id: <152749106264.15132.4817637767737065092.stgit@devbox>
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
from arch/s390.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527490904-2-9763279002326451767
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527490903; b=A24812y82sZxhh2UlgkJwI3Yp1Aq1gZuWduAyUmc55hl4wt8pR
    PwVUiCDmbwaAaM4gftkRNQE5l4caccFg9jfFBRFheszgV89jrryO7ERgkKANm+Ux
    LbW0YGTB0q53pDwB8QoL6ZUoPuSQauNJP9ApzJnXzuGG3+poDZKiuOC7ZE23lp9+
    MELNskF9QO0ZR3s9VjgpAkBRJ/JJCz4HpTP3QwHwmRSqoTYDt+wl9zKos5vuCoSB
    MyKCd0WtYxTljsg12iNQjzPNJ/ogvuEeK7NdZD0fYbslo3LcIkGuNaM4C7IH9S/O
    CY2VEelG1R0rUBWG2WhQwMJY2zMigiParu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527490903;
    bh=RI2NdZVOHazjLT9gP9naaGKrfn+9lYQJEu1GB+Pelqg=; b=BEbCmYpxbhMS
    CMfb//JMxNQGVwyU01F1Xw8SvzSJTScyPtn1fvijMDlwK3gyktbWh/9EqINUdj0y
    Q5Hik2T22WKvp9v//4U5eEDON8cZ/MccFC3JBLF2Ex+2jrfttKJaRM4Ta423cNo8
    c1KNWBPvsKT1MaLGWasB129xmg2Rr43cflvxarHMMbhAM0VY9c5z4JxPekTVlGem
    7W3J6EVUj/Vf8znt/hpAg79KBhdQfByONZhqkNrE5qklXVmgLIKcPcL4Cwt4XRg8
    pyE8R3hnuCA/ze7SV0RIprLoRotLZ66beAtP5GWC8qTWYn53ZNCDy0WLN0Xx3TEZ
    X4YllevbqQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Ky3rMlc1 header.a=rsa-sha256
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Ky3rMlc1 header.a=rsa-sha256
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
X-CM-Envelope: MS4wfPH82z+iAy/gnYCw8XOuJX2L8p2rEDZqEwc/3cawmzkARp2BktIxNIQqUqRv/3+uxHMwWoKLvQO1X482lfMOALNXzvF115Oi0IIJIMsz+mPnLk4ti9P1
    aCHiFWgc9Gmaoy2caMwOQlHX1vwuZiW52e7bNcvnCYPOVIkix3BzCm78uDSY58F333VfHeQYBC+me+Q/xNWyopFks9MS0ZEErU+5XTfzifuTIdOv1rJpL0X6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ch7q7--6MBsdxLFZNGQA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753600AbeE1HBm (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753582AbeE1HBl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:01:41 -0400
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
Subject: [PATCH -tip v4 04/27] ARC: kprobes: Remove jprobe implementation
Date: Mon, 28 May 2018 16:01:15 +0900
Message-Id: <152749087559.15132.13324630797438139628.stgit@devbox>
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
from arch/arc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

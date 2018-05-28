Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527491153-2-5195222408796514654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491153; b=YQVRC4+JCoMJOlrWpIxsAYtS8bgH0cgljf7xNZWVwLj5mAjjx1
    MgF1/3ibjoTiRlk4hf502ouGAh+q3IMIkdhswKmvaQSp/XIEOXCszf4iN9v09fCJ
    bo1v5u2u4lSP4jJ4N0fjNQ5cKogzyD+7Sa2fELPj700qsY1vxPRjaNz5N0eOsowT
    HExH+e30nraYjUSxbjE0wnSHpRvJ6YANRYef3URjhetngnXfDOQIMFLG9/VkjAda
    CEIXBoaZEOmvHNi9/Vf7tyQuJ11Xc7jBH+PmLGvqeGoqsh9cb9zGYztcRDHHtwby
    H6qipM/1GvE+dAPK+QNK717XOjEXNDTe14sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491153;
    bh=81KD4uRbm7kEYN5Gm2gXnUDPa3rnSfVq/fYCxxU33JE=; b=JlgyV3PsKLkH
    tQQL1944jLzadwFpp9kIjjXNSBsX5XV8eghrAtqa/QTsM1Y9246m+0WsA9LQrYKM
    sSs8q2PIpbOQanNtM19L5MJp5w/6nt0p4wKm6dWYb9xVp0fptW7PB5O97mMGuPm7
    m4ZjgyBuVE4ytg/6pgo0Mw4tjOrA/WifN/MF8bcgQo30XlC1MDs8S9Y25Hv7Mr/S
    vhn2oWFWNfVkEEv3tMF+qxBz3OtP8N2J+yLedruFaYW207rrwzp9F9GdLT5pTMGJ
    vGyvBLVdwzgVsJjhakuLA4U8vOARKDmBCzFuU0cPJnml28Xk32cd3GOVdI50zFHt
    lnN5Yj1Phw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=LxxML6cC header.a=rsa-sha256
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
      header.i=@kernel.org header.b=LxxML6cC header.a=rsa-sha256
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
X-CM-Envelope: MS4wfHOLIJDz0j36OoKO9LWn+EKpCf6nufk0S2pG7O7/n0rRlecHGPZWBZ5gBWi0h0TmCID5G6u/LXY2UzrI6YrBI0a2kBM/f1/7xL/B2KaXEbw/GGYI5QmC
    gkXZR/DGvuAun/0KJYj8K37AciIu9bnS5ntLp5Zz4TEvLyKMf2L6AVPENCeGhO6B3tCCg4en3Ad57feetaxc0TCFbXaw3s5R11+odHXCneCFAZwExI0FsAcd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=xovFcui46dSD-l7nkwAA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeE1HFw (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753645AbeE1HFv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:05:51 -0400
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
Subject: [PATCH -tip v4 12/27] sparc64: kprobes: Remove jprobe implementation
Date: Mon, 28 May 2018 16:05:25 +0900
Message-Id: <152749112496.15132.2606036082593246054.stgit@devbox>
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
from arch/sparc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/sparc/include/asm/kprobes.h |    1 -
 arch/sparc/kernel/kprobes.c      |   47 --------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index 3704490b4488..bfcaa6326c20 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -44,7 +44,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_orig_tnpc;
 	unsigned long kprobe_orig_tstate_pil;
-	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index ab4ba4347941..f555711da8f1 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -441,53 +441,6 @@ asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
 	exception_exit(prev_state);
 }
 
-/* Jprobes support.  */
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	memcpy(&(kcb->jprobe_saved_regs), regs, sizeof(*regs));
-
-	regs->tpc  = (unsigned long) jp->entry;
-	regs->tnpc = ((unsigned long) jp->entry) + 0x4UL;
-	regs->tstate |= TSTATE_PIL;
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	register unsigned long orig_fp asm("g1");
-
-	orig_fp = kcb->jprobe_saved_regs.u_regs[UREG_FP];
-	__asm__ __volatile__("\n"
-"1:	cmp		%%sp, %0\n\t"
-	"blu,a,pt	%%xcc, 1b\n\t"
-	" restore\n\t"
-	".globl		jprobe_return_trap_instruction\n"
-"jprobe_return_trap_instruction:\n\t"
-	"ta		0x70"
-	: /* no outputs */
-	: "r" (orig_fp));
-}
-
-extern void jprobe_return_trap_instruction(void);
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	u32 *addr = (u32 *) regs->tpc;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (addr == (u32 *) jprobe_return_trap_instruction) {
-		memcpy(regs, &(kcb->jprobe_saved_regs), sizeof(*regs));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-
 /* The value stored in the return address register is actually 2
  * instructions before where the callee will return to.
  * Sequences usually look something like this

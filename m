Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127745-2-18026224327833086086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127745; b=UiT3yVUvFQLGWX5tA+hdY/fF0LWXhaRKOwpEgLFDWKiFVSCYRI
    vXrDTDPLct98aKKzE1Psj8UOqI1n539yPwwhuRnbb3tPgbCyXFCTk0RUOKA7c4Jv
    3PeaehKFugArRJQQ7HAISdBPiulh74bL/W/7i9AhwifH1NgCPQHED1ZzSWN1FdHA
    +ZPDKEgvwNhTCXDb4LsLeImHodeksup8X6jIDRda1flAix5LzmclPvZ/Cg71ylDi
    Zr0om6e2tDcTz9QFwp82DHUIJMUNixWm3KHx4Uv1pU04+IeoX/B3LaJj7Q1u8jbO
    44h4DCI5E4i4YG9wkkSONdJq1sYi+Tm5VXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127745;
    bh=6nvVZAMz+XaWf7mW5VA4z5/gqfNTsasc71PaBplIsGE=; b=MThufQJX6mxB
    IDaxuy+e6ZN9/dASHAPDB0hegPaMuuY/MRRWsMS/UI6xOI9B7xTP6ec6Q5+I1Ala
    5jAlcEuVrOga15QMR1MW5Pzm4dmlArTpn4ph+Ng2LXL39jxqbYt4Sfi8+pLDJ9r2
    8jTcgtyo64fe9mJu/IyhGzz/+9fHMd8LM+IgRDoG21LtJOr726pQDt3PlR92BQBL
    8mm9pqqmiC6cmwPR0kDdwgeqC/G1U86g93p/yQfn2pfTSmcDCLY0n+6rL1Wbugo/
    jYoxSSyFlo16P9gxAoRq0Ce1cHISNWzmjIWC0E2oialWhnokF+FQxhm1tMHCaRaD
    Sw0d2PT4ug==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=PV3TKOnn header.a=rsa-sha256
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
      header.i=@kernel.org header.b=PV3TKOnn header.a=rsa-sha256
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
X-CM-Envelope: MS4wfBarG85Tqn114MuULRjeWBCIqhNN8QqDPx+Q4JH1Q4O2hqxHXeMbOUbf4LSLP61L7lR6oRrJTMLoFhNTecopJGRG2/rVJmFSskiPJGF4313Hf6F6Eq3M
    RSwuhy4y6NTLc1qn3FKRVrTbB7raDg7ZamCN82u/5OeTWKxF7FlIr3tTxzDP9s8iL1o2t1HmjmyNHhOZ+s3Wquc2gvbuBa3/PLBDyBfSAcjze8PXd3U+OABh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=7tsTmkapxaCtXbMtdzkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=NdAtdrkLVvyUPsUoGJp4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeFDPzn (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbeFDPzl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:55:41 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH -tip v5 14/27] kprobes/x86: Don't call ->break_handler() in x86 kprobes
Date: Tue,  5 Jun 2018 00:55:17 +0900
Message-Id: <152812771749.10068.4237461434465028276.stgit@devbox>
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

Don't call ->break_handler() and remove break_handler
related code since that was only used by jprobe which
got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/kprobes.h   |    2 +-
 arch/x86/kernel/kprobes/common.h |   10 ----------
 arch/x86/kernel/kprobes/core.c   |    7 -------
 arch/x86/kernel/kprobes/ftrace.c |   16 ++--------------
 4 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 06782c2efa04..c8cec1b39b88 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -78,7 +78,7 @@ struct arch_specific_insn {
 	 * boostable = true: This instruction has been boosted: we have
 	 * added a relative jump after the instruction copy in insn,
 	 * so no single-step and fixup are needed (unless there's
-	 * a post_handler or break_handler).
+	 * a post_handler).
 	 */
 	bool boostable;
 	bool if_modifier;
diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index ae38dccf0c8f..2b949f4fd4d8 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -105,14 +105,4 @@ static inline unsigned long __recover_optprobed_insn(kprobe_opcode_t *buf, unsig
 }
 #endif
 
-#ifdef CONFIG_KPROBES_ON_FTRACE
-extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-			   struct kprobe_ctlblk *kcb);
-#else
-static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-				  struct kprobe_ctlblk *kcb)
-{
-	return 0;
-}
-#endif
 #endif
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 1b2d1acba810..0ac16a0d93e5 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -709,13 +709,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		regs->ip = (unsigned long)addr;
 		preempt_enable_no_resched();
 		return 1;
-	} else if (kprobe_running()) {
-		p = __this_cpu_read(current_kprobe);
-		if (p->break_handler && p->break_handler(p, regs)) {
-			if (!skip_singlestep(p, regs, kcb))
-				setup_singlestep(p, regs, kcb, 0);
-			return 1;
-		}
 	} /* else: not a kprobe fault; let the kernel handle it */
 
 	preempt_enable_no_resched();
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 8dc0161cec8f..c8696f2a583f 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -26,7 +26,7 @@
 #include "common.h"
 
 static nokprobe_inline
-void __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+void skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		      struct kprobe_ctlblk *kcb, unsigned long orig_ip)
 {
 	/*
@@ -43,18 +43,6 @@ void __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		regs->ip = orig_ip;
 }
 
-int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		    struct kprobe_ctlblk *kcb)
-{
-	if (kprobe_ftrace(p)) {
-		__skip_singlestep(p, regs, kcb, 0);
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(skip_singlestep);
-
 /* Ftrace callback handler for kprobes -- called under preepmt disabed */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
@@ -80,7 +68,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
-			__skip_singlestep(p, regs, kcb, orig_ip);
+			skip_singlestep(p, regs, kcb, orig_ip);
 			preempt_enable_no_resched();
 		}
 		/*

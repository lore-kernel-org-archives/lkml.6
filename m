Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527491215-2-2482606704528494861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491215; b=S/l3TWaH/c0WYTcBrYuDd7nfic+S8FXTP6l4xbk6/VqXUD6k9f
    riawuwoG6ugxqwIKM7CeaZNZ6g/hBoiU6ImEuGBBQ3yzwFd41+C+lvabO/AW8h7U
    cv/S7/BDIrYNCSnHqM/UnHaTOLzk611xLHoYNGQcLZ8+N8g8dsokWebQ/L4sv06G
    AYAZ8HgJmB4F6ppAU/SMNG3AxQs2IPo2aOULzeAt0PqjONH/rot8eVHIX0Kz7dXR
    Y0b7THjUbLN41A6FH12kCizh4fvBMRvnBW0K7M8a+y8Kn6eja1pu6/461H3zEfzh
    TCRD64rpvMosSw4pxZdMkH9kiMkLyy7GNyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491215;
    bh=740rPhq/KV1LVzpppY17+e9pgUK6C+fSzj5vFBVBG10=; b=Hg4O0bb4KQ5j
    OgBY5PTPt2hX0K8HOZPMAbr4dHFdK6cn9oBO7FMzoHjUeioQewtnEGsLNgMuv73j
    NTaPuh8A1Ci71N4PAuEOr65sjqJCduv5cQm5Oa0pia6EWYiu1bvNRrsF3ud+wei9
    89pmhlILkZpvIFCcGd3mLlqomBtJ18SboHqXuZ0Nt28o5g/I9MWVo5n2gFE6XYDR
    mhof6+p8CcGW+kqlhiHyE0M0BwPLY8DvRIRpU5BK1vnIuWahZPr3MjwnMG0vshpf
    Y9eUZPJP21wcZw6Wc8UNBsjG9IZeoN67ZuPw9oFv7Y62388iVuilvQoqbrARRKnc
    oJMbc+TpoA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=p50329I2 header.a=rsa-sha256
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=p50329I2 header.a=rsa-sha256
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
X-CM-Envelope: MS4wfIAIAf8kJqXzqq03/GwHFvKcR6S9VMfeZ6pz4PY4NslbkqwPhPxjZdvi1VpdRKC3jA85heH+6LN8EZd5qxhMwiM/svQTbXT625eFHyiAjrRim8VgUiYG
    V7I0ukBNnyitANkAFyy3Pd53+BnUNQE3TqJF6fqrfJsR9OCghyBioWVsYWOX6uqcb75DDl9tzXCl7udCM5AJ7XbBE+EQGNQ5qVwt5Y3bBlRP83nYOvhMQ7Fi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=7tsTmkapxaCtXbMtdzkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeE1HGy (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753484AbeE1HGx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:06:53 -0400
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
Subject: [PATCH -tip v4 14/27] kprobes/x86: Don't call ->break_handler() in x86 kprobes
Date: Mon, 28 May 2018 16:06:27 +0900
Message-Id: <152749118700.15132.7596723824971269356.stgit@devbox>
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

Don't call ->break_handler() and remove break_handler
related code since that was only used by jprobe which
got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

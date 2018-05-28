Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527491374-2-10744627130581731882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491374; b=T/Z2ZY62Xdf2xyDcfqVYVVYEtSbNqgDXAChytQQIy8xyyoyr9f
    pJwmFevnU4wAHkCQ+RHQY6Up4kUlXhEN40DF8hIt1bmvfEb7ea4QNsG85emVuywq
    6VUJzHpMCjUKo+R2Du/J/iaxZ8vKrqcsjVZloU4eNLXsRCOfpq0qZoXLOY71PdTh
    ldsjc5YgEcIJUTpC0KT+2dF4hGJFzRqVIREjlVVCFyZpztyWjLtw/ryztyUdaylb
    S2ggX8q0yxe8HNmGcRcQpDWgLTM8I+CSHi9+XOSLUjimnbXLdTYNU0O9F8o/Dhyc
    usaG2yyhnKMV6r00OqJW7nlE+he0Y4pYKWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491374;
    bh=8AJI9LawfqgW7mcEgUzLn/Rfd1+28MRcbH8ZeLEq2S0=; b=hY/1CM8U23sk
    2KYjVv5zPb44/Mfg1up5tyt+EDu3pw4ZQ7tKykmWflzZ2dJPvHs1mc5yvCHG5Dvi
    tTSFYpZvHZdoIaQ03JmITO9eszqvPHlUNk2LtQSlwSw/GkNdHXo3fEnIDxY76Noc
    arton4oq7d96Rqexc9WeSczBr75x55136obEl7apGds4vZxAxvQQwDPnMzu5pvw2
    yva46azObpb5HbsZiRQZrdSgXHvJr22q4ENkWT9fgP/+9wV0GdSc9Rex27VujXXR
    AIb9GkmcVZnYwwhWQStpKow1Sq1IqpB6Y5M8RVBsflKPD4AfgIzZsVjnXd1T4rdT
    x0x7OX+Qbg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=fSC20RjZ header.a=rsa-sha256
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
      header.i=@kernel.org header.b=fSC20RjZ header.a=rsa-sha256
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
X-CM-Envelope: MS4wfCfaChCHXm2RalQdwfXwmGMDYU+pgj9WbMIskyt2UNEOmH0JYZpqGy1ECV3SLc9zxQho+ELR/MxAux72aAQ9hTPlBmYKBMmHwSMHDMEJAo6SguoTAWmP
    i91dYUAMPMy5OLdbXO+8aVB83ducQy+/tTJxyavOsM07ODKQDOsvXsFJkC4YcKWnYlUfeO28yVhaGmAWLIVV4kAjLgXtjYl/T8jI4xDux4qBPCl/V+bdvJGe
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=vQqmB3E4GQfW7Bs5r6wA:9 a=tJgELwuPVEwycBlX:21
    a=PxT3qhjPceE5B1qf:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeE1HJb (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753654AbeE1HJ3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:09:29 -0400
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
Subject: [PATCH -tip v4 19/27] ia64: kprobes: Don't call the ->break_handler() in ia64 kprobes code
Date: Mon, 28 May 2018 16:09:02 +0900
Message-Id: <152749134269.15132.4248763357482446430.stgit@devbox>
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

Don't call the ->break_handler() from the ia64 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/ia64/include/uapi/asm/break.h |    1 -
 arch/ia64/kernel/kprobes.c         |   10 ----------
 2 files changed, 11 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/break.h b/arch/ia64/include/uapi/asm/break.h
index 5d742bcb0018..4ca110f0a94b 100644
--- a/arch/ia64/include/uapi/asm/break.h
+++ b/arch/ia64/include/uapi/asm/break.h
@@ -14,7 +14,6 @@
  */
 #define __IA64_BREAK_KDB		0x80100
 #define __IA64_BREAK_KPROBE		0x81000 /* .. 0x81fff */
-#define __IA64_BREAK_JPROBE		0x82000
 
 /*
  * OS-specific break numbers:
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 823e4bd03a18..74c8524e6309 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -817,14 +817,6 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 			prepare_ss(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
-		} else if (args->err == __IA64_BREAK_JPROBE) {
-			/*
-			 * jprobe instrumented function just completed
-			 */
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				goto ss_probe;
-			}
 		} else if (!is_ia64_break_inst(regs)) {
 			/* The breakpoint instruction was removed by
 			 * another cpu right after we hit, no further
@@ -867,7 +859,6 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 		 */
 		return 1;
 
-ss_probe:
 #if !defined(CONFIG_PREEMPT)
 	if (p->ainsn.inst_flag == INST_FLAG_BOOSTABLE && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
@@ -990,7 +981,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	case DIE_BREAK:
 		/* err is break number from ia64_bad_break() */
 		if ((args->err >> 12) == (__IA64_BREAK_KPROBE >> 12)
-			|| args->err == __IA64_BREAK_JPROBE
 			|| args->err == 0)
 			if (pre_kprobes_handler(args))
 				ret = NOTIFY_STOP;

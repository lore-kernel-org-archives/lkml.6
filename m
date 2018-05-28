Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133372-1527491559-2-13100123493762816253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491559; b=d6Cr/U4ZyWEqh+fwNggHvaXB4M2yViJaDqJQaK2qrVhlZQhKAA
    CNnUBIbnUyNW7/VSQ9xatlPQNOHLx759ko5DrKO47eaG8hMfwXpmUAUw87NMljfB
    c9ez2jSTGcT9iY8QezSWibX/u3kFFtRIl4qRQUMUxE4dxWAZoyju3sKjFIYEbRnn
    1HUoE7JpErWAwIkV0SNyDgz1T4w+o6eYnS60GGeCMeyiOumZxR46VAW7aQCIvZh1
    fpgsyZCS8KUMby1PfEQZX7jZvNL0bwmLEi0AS//F11VYoSBN3KJrfQLwc7+vAETY
    gYoPC1Ye1s4tgIPcyXZVL9cmKK+pdKiHYLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491559;
    bh=nCVehLb0u0vum+qAJG8klHvjZMZzwJUwP17aAzobzsQ=; b=PVRhwuYdRV7/
    ztTtUNGrRyxCzF0/MiSq4y7EwPgYimZC/g2vn9DtSN01H9GTyPiT4wJx/qs0OBJ8
    NhbdiPTUDUDjENvPzNTvbTCBQTlBtqy1nt/QsD+iXSpdHrE6Gl8uIpOY5aghMNZg
    bNIYd5oEf1yJiOii4jihtAgCxXCrBVwvTwwcK68zx9UE9FgPBuiguUsg96LXjmVq
    MiasgB2nnOeihLm+xiRrI+tttGxwLorPTaDuYi/oQW3cYvRE5u94SbpefZizdc+W
    kmQawi1lmsyw2rNgrM9xzCIXT6pAO1DgofzsPGpd5ah/mav4CUgEBxMVzJpX8uvj
    uEOXTEXIdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=d5vcue23 header.a=rsa-sha256
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=d5vcue23 header.a=rsa-sha256
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
X-CM-Envelope: MS4wfJLKFKEE5Pu3LKKZguBKeYEonURsW2EWoDel8myZobywEC49Ke+VMwghyjlbc0gVHnOjQp1P1QI/Q10Q9dpzu1Qg6FecPtVUJ7Ux8ZHsczgVQgH3Htl7
    ilA1C58z25pEfChhi21z0o2d+cY19eFCol/o3NLCze8JS++YmajVs4oFU9+rqHPRIIN457p2iNZBDt4K9LtAoPxfuWSetGZKkhPKBOukxDbJlU/ldKNVkn55
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=-hBiZIJ-AFPZEXo8xSIA:9 a=arirgmxYCIbmtYuz:21
    a=nhjtAAH3ILW8Er3Q:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbeE1HMg (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753839AbeE1HMf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:12:35 -0400
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
Subject: [PATCH -tip v4 25/27] x86: kprobes: Do not disable preempt on int3 path
Date: Mon, 28 May 2018 16:12:09 +0900
Message-Id: <152749152918.15132.3522241227611599185.stgit@devbox>
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

Since int3 and debug exception(for singlestep) are run with
IRQ disabled and while running single stepping we drop IF
from regs->flags, that path must not be preemptible. So we
can remove the preempt disable/enable calls from that path.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---
 Changes in v3:
  - Split user-side changes to another patch
 Changes in v2:
  - Include user-side changes.
---
 Documentation/kprobes.txt      |   11 +++++------
 arch/x86/kernel/kprobes/core.c |   18 ++++--------------
 arch/x86/kernel/kprobes/opt.c  |    1 -
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 907a3017c0f2..3e9e99ea751b 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -566,12 +566,11 @@ the same handler) may run concurrently on different CPUs.
 Kprobes does not use mutexes or allocate memory except during
 registration and unregistration.
 
-Probe handlers are run with preemption disabled.  Depending on the
-architecture and optimization state, handlers may also run with
-interrupts disabled (e.g., kretprobe handlers and optimized kprobe
-handlers run without interrupt disabled on x86/x86-64).  In any case,
-your handler should not yield the CPU (e.g., by attempting to acquire
-a semaphore).
+Probe handlers are run with preemption disabled or interrupt disabled,
+which depends on the architecture and optimization state.  (e.g.,
+kretprobe handlers and optimized kprobe handlers run without interrupt
+disabled on x86/x86-64).  In any case, your handler should not yield
+the CPU (e.g., by attempting to acquire a semaphore, or waiting I/O).
 
 Since a return probe is implemented by replacing the return
 address with the trampoline's address, stack backtraces and calls
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 814e26b7c8a2..f7104b256de7 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -594,7 +594,6 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		 * stepping.
 		 */
 		regs->ip = (unsigned long)p->ainsn.insn;
-		preempt_enable_no_resched();
 		return;
 	}
 #endif
@@ -667,12 +666,10 @@ int kprobe_int3_handler(struct pt_regs *regs)
 
 	addr = (kprobe_opcode_t *)(regs->ip - sizeof(kprobe_opcode_t));
 	/*
-	 * We don't want to be preempted for the entire
-	 * duration of kprobe processing. We conditionally
-	 * re-enable preemption at the end of this function,
-	 * and also in reenter_kprobe() and setup_singlestep().
+	 * We don't want to be preempted for the entire duration of kprobe
+	 * processing. Since int3 and debug trap disables irqs and we clear
+	 * IF while singlestepping, it must be no preemptible.
 	 */
-	preempt_disable();
 
 	kcb = get_kprobe_ctlblk();
 	p = get_kprobe(addr);
@@ -694,10 +691,8 @@ int kprobe_int3_handler(struct pt_regs *regs)
 			 */
 			if (!p->pre_handler || !p->pre_handler(p, regs))
 				setup_singlestep(p, regs, kcb, 0);
-			else {
+			else
 				reset_current_kprobe();
-				preempt_enable_no_resched();
-			}
 			return 1;
 		}
 	} else if (*addr != BREAKPOINT_INSTRUCTION) {
@@ -711,11 +706,9 @@ int kprobe_int3_handler(struct pt_regs *regs)
 		 * the original instruction.
 		 */
 		regs->ip = (unsigned long)addr;
-		preempt_enable_no_resched();
 		return 1;
 	} /* else: not a kprobe fault; let the kernel handle it */
 
-	preempt_enable_no_resched();
 	return 0;
 }
 NOKPROBE_SYMBOL(kprobe_int3_handler);
@@ -966,8 +959,6 @@ int kprobe_debug_handler(struct pt_regs *regs)
 	}
 	reset_current_kprobe();
 out:
-	preempt_enable_no_resched();
-
 	/*
 	 * if somebody else is singlestepping across a probe point, flags
 	 * will have TF set, in which case, continue the remaining processing
@@ -1014,7 +1005,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 			restore_previous_kprobe(kcb);
 		else
 			reset_current_kprobe();
-		preempt_enable_no_resched();
 	} else if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
 		   kcb->kprobe_status == KPROBE_HIT_SSDONE) {
 		/*
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 203d398802a3..eaf02f2e7300 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -491,7 +491,6 @@ int setup_detour_execution(struct kprobe *p, struct pt_regs *regs, int reenter)
 		regs->ip = (unsigned long)op->optinsn.insn + TMPL_END_IDX;
 		if (!reenter)
 			reset_current_kprobe();
-		preempt_enable_no_resched();
 		return 1;
 	}
 	return 0;

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1799621-1528128069-2-15217941417730577684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528128066; b=GFr47GAJFUsk8HMM6lVFGa7qoJqrJx+HAz12LGgSriPGkb3d5R
    O8Kx67sPm3ULuL/Aiw9ynrfvMwTPPlrt1JaD5zXAIZlwtQDiLRVkNRhZJBpprM7u
    OcH6/gD/AWthbpVKkbLWCkNNqPtXlvvTqNWCtg2YElNSrejmQdqjCz7SJa/0iwdK
    704/J2WpvzvCpoYI3FT+ETUjaqZClJTEF3Sy5V0o0/+vIx+jn4Zi4arnr5hD56dl
    TfM4IKP7DX7w+1nV7WTRHBVCyjfmgXnHr+7+Quj7vf/6MwfZMZ50iXiKfoRNgRFT
    FzVyP8NEE/WpV4QCnIRzDny6EwkAOIlc9HuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528128066;
    bh=j82VHXTWqMzWbJSn/Jn589mvnv90PeR8itSdhxyA+V0=; b=YVHe7kcsC7DW
    WeDp4gR1EILYIHpboCD71GOgJle/EjWQ5D4HbwCM1wxa7l65W3Y5mMbTbYWo0FuC
    Obc3o9vTEHZrk/b8SaAykyEFfyS3Qgq0PW7OUZatt/g4BQUBplFNR03SDMBVQaWl
    MUbEgyoKmwKys1O67PzLZm4fhYdJo0zg0ooKfcNbWahKz3WsehUHgYv+9Qu1okGf
    DaeJaC/RByhD0F89ggU8SVb0J/DoxpIh9JGvrq/Qk4A/yZ1yvYVYtvEQayqi5D4L
    ESkHvoBKVbku1kADPxERvvITz8dEv2UchL8eGyL328VJSDBMAEEHbZunmIs4S5xc
    oGDUflPf3w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=gWd0HuSV header.a=rsa-sha256
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
      header.i=@kernel.org header.b=gWd0HuSV header.a=rsa-sha256
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
X-CM-Envelope: MS4wfDeQYxXIAgu2Fu9FDLELvJ1o41iyoaMffIZtTUiQvREuxYAnpzuY2H3vaMqFEm9NSAPC/vLlHWmlW1aYgxlXOcjtpSjPjsxoosdIXfdbtBpp1k2EgODN
    /0Da8qo61sTVhmfZ4SDH7zgfNvXhDrHQhv71+xGIh2Htza46qsdsLXMsthvt4Ct4176rMhK0lYowWxJsEfKLZweqrIfqZZ76zcG9lzkSyOHjN+xnAhEFPp5N
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=-hBiZIJ-AFPZEXo8xSIA:9
    a=2pDkew4tWJbP7ZNF:21 a=nwEXgU1Br4nvSGCw:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=NdAtdrkLVvyUPsUoGJp4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeFDQBF (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 12:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeFDQBE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 12:01:04 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH -tip v5 25/27] kprobes/x86: Do not disable preempt on int3 path
Date: Tue,  5 Jun 2018 01:00:40 +0900
Message-Id: <152812804056.10068.8800452578206202063.stgit@devbox>
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

Since int3 and debug exception(for singlestep) are run with
IRQ disabled and while running single stepping we drop IF
from regs->flags, that path must not be preemptible. So we
can remove the preempt disable/enable calls from that path.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
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

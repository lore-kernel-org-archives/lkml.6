Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127861-2-10805032424931291461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127861; b=OwBzYDfRAzAKKSwC8nvaZnXrGfgpYPjVwcnJk6j13SiN7V4aSH
    zBixALw+2hKT1/PTwO9LVO1Gzhk6xCQ0Nh8B2dT/g/fNZdoTPHnVzYaZaPmUSlG5
    L4+PSGCGhCJMSBeE1DSObQ7vA1WJhj55JhVQvCuYpa8bYcHInbNvBluNWp7y69wf
    xDBuok4OKlYyzFj3HOSP7oouMtRUIt7FN4HEIY4rhQn8qMRlRYDPkXxZiksp5xXG
    7t25UXc9ym6HfiyNMglX40SnsbvRjpvJSNBjL0Y4avM720UUR8sLXmbMCPZpc5HL
    XvNquUJb13xwD/5o4CBlbJsZiAUJMwLBJ0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127861;
    bh=6dl3TLz2FSqgT0M6pzGwhOaqYgxmlopytiNbPH7XboI=; b=gFMjsVnKi+CC
    +bpuk2sdsnQ0kzNf0tTZzXuiPquNhWV7mtPxS90bH3mMugYacMm33PxRn7gUJvpO
    bYLnSWqoc+mNnbts87eqxgHEQ24O/J67kV/It2Wjx+KpGyfcbk39VbAobLXSZSuY
    R+2tUBn1mb/+xDIyiw9pj92D8mfsiarQSmqn5oqUOgna6s6Bqub/FYb5sQUZZG24
    zh3Oy9S92019R5olQ+E391O3kjD8AJtx51nW/83tqSeSv6GoMaXvAfHozCw7GjRW
    2naN8aeadvz/qVHlZ/zQ6y2o3QGDlC8M/jNxRaiWpYYSb4lSDnmRKRVFYih0ynM0
    gkASrCcMlw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=m7MznG3Y header.a=rsa-sha256
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
      header.i=@kernel.org header.b=m7MznG3Y header.a=rsa-sha256
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
X-CM-Envelope: MS4wfDLkPo8PHjDDHSm4TOrKNhHXsmw1OnYMympI3vWBkSA1LneTO7CFOCSlnj9taSOEkdOLXmohnJ3YgJsUAu5WtG1VxgS67eoRrsQXOUGWcR7lm3KDBZm3
    u6d+sFO7URDHfWH3QG94mgN9iUFUWFVD7PS3fj/QJYBsxp8r+3ifcWqtqfFCPbc+3y+YDr6xjev8rlCXb3gYEX1hhUVw2Njt8H2SsEiZL2WZhfS6NWwyYMcV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=VnNF1IyMAAAA:8
    a=voM4FWlXAAAA:8 a=XuV0cmIIvQowHyT0FY0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=FUarYpL4UH3yWsho8X8J:22 a=HvKuF1_PTVFglORKqfwH:22
    a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeFDP5i (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeFDP5i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:57:38 -0400
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
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the ->break_handler() in arm kprobes code
Date: Tue,  5 Jun 2018 00:57:13 +0900
Message-Id: <152812783350.10068.4690566636762511152.stgit@devbox>
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

Don't call the ->break_handler() from the arm kprobes code,
because it was only used by jprobes which got removed.

This also makes skip_singlestep() a static function since
only ftrace-kprobe.c is using this function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/kprobes.h   |   10 ----------
 arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
 arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
 3 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 674036db558b..785c464b6588 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -102,16 +102,6 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
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
 #else
 static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
 static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 1b316331c2d9..3869b0e5d5c7 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -26,8 +26,8 @@
 #include <linux/ftrace.h>
 
 static nokprobe_inline
-int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
+int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+		    struct kprobe_ctlblk *kcb, unsigned long orig_nip)
 {
 	/*
 	 * Emulate singlestep (and also recover regs->nip)
@@ -44,16 +44,6 @@ int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 	return 1;
 }
 
-int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		    struct kprobe_ctlblk *kcb)
-{
-	if (kprobe_ftrace(p))
-		return __skip_singlestep(p, regs, kcb, 0);
-	else
-		return 0;
-}
-NOKPROBE_SYMBOL(skip_singlestep);
-
 /* Ftrace callback handler for kprobes */
 void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
@@ -82,7 +72,7 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs))
-			__skip_singlestep(p, regs, kcb, orig_nip);
+			skip_singlestep(p, regs, kcb, orig_nip);
 		else {
 			/*
 			 * If pre_handler returns !0, it sets regs->nip and
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 600678fce0a8..f06747e2e70d 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -317,25 +317,17 @@ int kprobe_handler(struct pt_regs *regs)
 			}
 			prepare_singlestep(p, regs);
 			return 1;
-		} else {
-			if (*addr != BREAKPOINT_INSTRUCTION) {
-				/* If trap variant, then it belongs not to us */
-				kprobe_opcode_t cur_insn = *addr;
-				if (is_trap(cur_insn))
-		       			goto no_kprobe;
-				/* The breakpoint instruction was removed by
-				 * another cpu right after we hit, no further
-				 * handling of this interrupt is appropriate
-				 */
-				ret = 1;
+		} else if (*addr != BREAKPOINT_INSTRUCTION) {
+			/* If trap variant, then it belongs not to us */
+			kprobe_opcode_t cur_insn = *addr;
+
+			if (is_trap(cur_insn))
 				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				if (!skip_singlestep(p, regs, kcb))
-					goto ss_probe;
-				ret = 1;
-			}
+			/* The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -350,7 +342,7 @@ int kprobe_handler(struct pt_regs *regs)
 			 */
 			kprobe_opcode_t cur_insn = *addr;
 			if (is_trap(cur_insn))
-		       		goto no_kprobe;
+				goto no_kprobe;
 			/*
 			 * The breakpoint instruction was removed right
 			 * after we hit it.  Another cpu has removed
@@ -370,7 +362,6 @@ int kprobe_handler(struct pt_regs *regs)
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
-ss_probe:
 	if (p->ainsn.boostable >= 0) {
 		ret = try_to_emulate(p, regs);
 

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127714-2-16382834038155006147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127714; b=GDVXBEQpA8KGbEqH0lOxu6mwZ0DlirzdJAej7SCKsyrNp6Dzm1
    GsyF7u4WN6Al3sbo8Ie1Hw+sZgdTXdwj+dmZ5auhiFXDipT0uoHR1F+lDRiMbo71
    CuEtXVXDNXDL5IAKRBAn2UchoivzBQmfoOJQI/tsfKvgr+XMUAtdmRiJgz1MgIC6
    m3/ZzkUHO/q4FeTnrDRjB9ZAiRg7FoqBVdHltCbygIL7EG6vGfhuKlnAaqMAm5aZ
    evMc8RiNrIvlO8EPbBh4Piio10eUaxZNQFhiepu59SELPK/kisdEJYM3pKwnwigJ
    UIn9Mp9/RgciufbTxRv+brxcoTG27gEu/9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127714;
    bh=uWThnsWZ4lybIR1rg0AA6bO9rMCcf+ABqrweQavHuQU=; b=k3ApvaB6kAVB
    r+/MI0S1ETBtL5gwEpteKKS7nUTZ0/TYPFBWI9N7jxUqJKse890jzQMfcho41mZq
    s0zYLdycg3CSfYorJpSRGHTpgqBqWMVCUEF9GE5rqWutpzglUCdRJ9yJzKkgtvSb
    jXeb0SXTCXHv5uYMDIeGslYKXYtCvpqv0gvkoJwUsC2UHdc+qOncIzbX73o53U59
    9bpXyadKXFi1y8MJNseORMbapTfYrb35y3cjAmf/1Z60Q3WQ137Znyi5pyiAbunW
    23jkIihHYXotKt62l1EbZ+43C7OzyrIksf5A9YI//XGlqHYZQ0xQCQhsx+7VgJAk
    7Qm8JNsa6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Kp5usfJF header.a=rsa-sha256
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
      header.i=@kernel.org header.b=Kp5usfJF header.a=rsa-sha256
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
X-CM-Envelope: MS4wfJVFOn21VSK4NINEFnb+ySyA5XxunOP5XHEF0B8/taLgTe28l6TILIjJMijdQdZgMpB1QbjwB8mVbaWGBhKBn1+j5qcVeDbWiH8g3D0efue8CGG8XlrW
    lHNyTmVN5VzxRZmwAMOF/5LLF8G5+IzaHz0Ky8F2Dr986ktEIeEnXfa0IDPUMqAxbxlYS+MXYcebDm1kd2CVvZZHao4pd2tNl+75Gx5pb/QLhzVE4ZnotBxa
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=Yu1cahSTSsYnR66kQmkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeFDPzN (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeFDPzM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:55:12 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH -tip v5 13/27] kprobes: Don't check the ->break_handler() in generic kprobes code
Date: Tue,  5 Jun 2018 00:54:49 +0900
Message-Id: <152812768890.10068.10235293822737888531.stgit@devbox>
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

Don't check the ->break_handler() from the core kprobes code,
because it was only used by jprobes which got removed.

( In followup patches we'll remove the remaining calls in low level
  arch handlers as well and remove the callback altogether. )

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/kprobes.txt |    2 +-
 kernel/kprobes.c          |   39 +++++----------------------------------
 2 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 5ae80baf3921..907a3017c0f2 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -262,7 +262,7 @@ is optimized, that modification is ignored.  Thus, if you want to
 tweak the kernel's execution path, you need to suppress optimization,
 using one of the following techniques:
 
-- Specify an empty function for the kprobe's post_handler or break_handler.
+- Specify an empty function for the kprobe's post_handler.
 
 or
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 69de130595f7..536ab451e96d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -627,8 +627,8 @@ static void optimize_kprobe(struct kprobe *p)
 	    (kprobe_disabled(p) || kprobes_all_disarmed))
 		return;
 
-	/* Both of break_handler and post_handler are not supported. */
-	if (p->break_handler || p->post_handler)
+	/* kprobes with post_handler can not be optimized */
+	if (p->post_handler)
 		return;
 
 	op = container_of(p, struct optimized_kprobe, kp);
@@ -1116,20 +1116,6 @@ static int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(aggr_fault_handler);
 
-static int aggr_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe *cur = __this_cpu_read(kprobe_instance);
-	int ret = 0;
-
-	if (cur && cur->break_handler) {
-		if (cur->break_handler(cur, regs))
-			ret = 1;
-	}
-	reset_kprobe_instance();
-	return ret;
-}
-NOKPROBE_SYMBOL(aggr_break_handler);
-
 /* Walks the list and increments nmissed count for multiprobe case */
 void kprobes_inc_nmissed_count(struct kprobe *p)
 {
@@ -1270,24 +1256,15 @@ static void cleanup_rp_inst(struct kretprobe *rp)
 }
 NOKPROBE_SYMBOL(cleanup_rp_inst);
 
-/*
-* Add the new probe to ap->list. Fail if this is the
-* second break_handler at the address
-*/
+/* Add the new probe to ap->list */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	BUG_ON(kprobe_gone(ap) || kprobe_gone(p));
 
-	if (p->break_handler || p->post_handler)
+	if (p->post_handler)
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
-	if (p->break_handler) {
-		if (ap->break_handler)
-			return -EEXIST;
-		list_add_tail_rcu(&p->list, &ap->list);
-		ap->break_handler = aggr_break_handler;
-	} else
-		list_add_rcu(&p->list, &ap->list);
+	list_add_rcu(&p->list, &ap->list);
 	if (p->post_handler && !ap->post_handler)
 		ap->post_handler = aggr_post_handler;
 
@@ -1310,8 +1287,6 @@ static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 	/* We don't care the kprobe which has gone. */
 	if (p->post_handler && !kprobe_gone(p))
 		ap->post_handler = aggr_post_handler;
-	if (p->break_handler && !kprobe_gone(p))
-		ap->break_handler = aggr_break_handler;
 
 	INIT_LIST_HEAD(&ap->list);
 	INIT_HLIST_NODE(&ap->hlist);
@@ -1706,8 +1681,6 @@ static int __unregister_kprobe_top(struct kprobe *p)
 		goto disarmed;
 	else {
 		/* If disabling probe has special handlers, update aggrprobe */
-		if (p->break_handler && !kprobe_gone(p))
-			ap->break_handler = NULL;
 		if (p->post_handler && !kprobe_gone(p)) {
 			list_for_each_entry_rcu(list_p, &ap->list, list) {
 				if ((list_p != p) && (list_p->post_handler))
@@ -1911,7 +1884,6 @@ int register_kretprobe(struct kretprobe *rp)
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
-	rp->kp.break_handler = NULL;
 
 	/* Pre-allocate memory for max kretprobe instances */
 	if (rp->maxactive <= 0) {
@@ -2034,7 +2006,6 @@ static void kill_kprobe(struct kprobe *p)
 		list_for_each_entry_rcu(kp, &p->list, list)
 			kp->flags |= KPROBE_FLAG_GONE;
 		p->post_handler = NULL;
-		p->break_handler = NULL;
 		kill_optimized_kprobe(p);
 	}
 	/*

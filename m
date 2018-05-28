Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133372-1527491184-2-5487661791243275780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527491184; b=O245QYnasaCjI/cv7ObgK9ynMB2A92TNuBl96+N33dOeUAFBU9
    iN73J/XG6718guM5Zb/S+KoyXzVXyr7gGq0eHr2v8qYWDvrrAoUcF2xuo7puTTx7
    Iwqvx5/GyUUQfGZNwxelc8UP2lvx4J7I1LU+Hx93Bf5/DCziObTLNRN5a3tbK/jn
    veEIsFG9S1hSz6TyakpXNxpFlRYF35aFX1Sf1atXQv/OMZW8endXCsT5p7kZsbHp
    W1pg0Zk+anG0xRulebbBGf6Bs55YYYmZ2nMv30QBChRcpoJT6v5SqJowO0do2HDb
    MhAThXLowAO+JrI1m4m4QT51EdlhNbtjcX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527491184;
    bh=uWThnsWZ4lybIR1rg0AA6bO9rMCcf+ABqrweQavHuQU=; b=Q1r9oET/xlMQ
    Qmx8t/6j8bnJbCbS1kea8FbuOz4TxlEimoJsvT0RkTWfhULrJkQZYsy2K+HuBvPc
    2LLBRXo1AwkwfMS5tYoi3g0KUSVSQtc9pnYKc3lOdyOLrUKru2x2hNgnDIHe8JmP
    ncDW9neI+30xDgbTXC64gv7o0i2JnV4awUsh5WyMFKuyrZLIa1lQ0uPdEouJs8/W
    9qhoRzimszaSaUazi04bi1nYZqtWnDPQn/jszN6h31aFEqQOoHTH424Hyb5JZ1y7
    ApiNlw/yB3Kh/KvP+1zx/ZhCoe1cj4wjIDbax22PaL/B/+lG5u7zHS5IHRnD+HkE
    YWDleMnF5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SAOCK2Om header.a=rsa-sha256
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=SAOCK2Om header.a=rsa-sha256
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
X-CM-Envelope: MS4wfLsOtVf6QHJWb/T80VnChvCbBcxwcJR//3EBkOxE7E2rvDqgItz7s5SGTqzVNbdDFM5JtV7a3+LeGlC27cxN9xf1InMlk/rbdGGshPPnPMG8PkKsCyC6
    uooxE8bwoeJGQYTre0jLALznU+XO3SYs+yXokiJJiGbMkTcauy4Woc1iMq89UvGTdkOEkiyqzW3LwTt9/UruMKpq2GFILUvQBPx6/b3Msni7HHw+WzBao+tn
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Yu1cahSTSsYnR66kQmkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeE1HGX (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753599AbeE1HGW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:06:22 -0400
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
Subject: [PATCH -tip v4 13/27] kprobes: Don't check the ->break_handler() in generic kprobes code
Date: Mon, 28 May 2018 16:05:56 +0900
Message-Id: <152749115603.15132.13295364754611981707.stgit@devbox>
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

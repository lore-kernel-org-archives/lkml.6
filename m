Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127396-2-2285097303987842737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127396; b=nq9+PbV9DfKrsCZEDBkw6vIt9GZVtt3ZTgq7PZlBbQtVvNr+ow
    h9Ynceub/ItlCPueDxl+oXIfUkqadX5SwzhdLJs2A4mvdvUy9JFPnj5NL/wmNvzM
    yeJZqOqvo2DlGGuMOfDh404a16zHuo+/QADrBWygn4VBlDygZX1pJMkPYymr2VvX
    +fpudNtcBEpDdFkVaNVCRA0G2DRQhFsqUgKFNvDXPamye8+nOvv1DZhnb5BpHH+U
    cctpJ2cIIpdYD6jCLkm25ud1FvVZM+l9Iu5r3+POmM2dgnI3IdOkoJpCxWSV78WF
    u+XXOYTywsBz31nczGhBx2oJmh/gOOArTUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127396;
    bh=SBnEBSK0F7+leHqhobGcBanS1gNG0j6Ulg704TmeeXQ=; b=K3hYKUKGX7Eg
    1ZZSLVah6fdpub5dSuNhcOX3xUDGY1cieFP8I9pUB5ez/rLIwjadueTLqG87vQpi
    KY1rd74fuxbik5M1FaCj5yeI0CxtZXX/VKBpwF32g4j1NCc9ocqxP9/O+4rXRkQR
    uOVFCAlVxGaahsPvOvkGQjueXR68S5rumZctpwNYGwO13voe2bK5gyGIYFQ3HGNq
    GKD97gRF8mKrqR38bTIV+daJkCg1nLKcp6DyiNxEP/1vL8tbdsLVgeBSgh1J88H2
    msNBKHxHuHn4jhsComqh5HVi0AtfmhPCK3z+c6+Ks0QjvEG4nbf/16/En9iNijt1
    bSEXaDWE3w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HNKS6t0n header.a=rsa-sha256
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
      header.i=@kernel.org header.b=HNKS6t0n header.a=rsa-sha256
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
X-CM-Envelope: MS4wfENdOABWKg17yOClciVRjdzcJ+eU/ZRMud/6OsCon7TcPs85ofkbOVr/A42fu0HXTRvnj5t9b2wFGlEnS0adCBo6Irte3tb0eHOxU1pogZbkfxiC9JSV
    GzdwJKTMMno2NJ6ZTHk5X13OTGx3OPLwAgoY88rv2YbkK0TdisJWZ5fW08qTr08Z268D9tZLLLvywgmoXuWgC2zxM1NqcUVEolCCDnfYXdMYq53IqNGY0iUO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=Q4F1TQyLRCIcDEXpKH0A:9 a=LwnH9Lt4Efn2LYPn:21
    a=0fY6pjcGkOaDNjlR:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeFDPtx (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeFDPtx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:49:53 -0400
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
Subject: [RFC PATCH -tip v5 02/27] kprobes: Remove jprobe API implementation
Date: Tue,  5 Jun 2018 00:49:29 +0900
Message-Id: <152812736902.10068.14590197723889941377.stgit@devbox>
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

Remove jprobe API implementations and test cases for
those APIs which is no more used.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Cleanup lib/Kconfig.debug description too.
 Changes in v3:
  - Remove test cases.
---
 include/linux/kprobes.h |    3 --
 kernel/kprobes.c        |   78 +--------------------------------------
 kernel/test_kprobes.c   |   94 -----------------------------------------------
 lib/Kconfig.debug       |    2 +
 4 files changed, 2 insertions(+), 175 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9440a2fc8893..b520baa65682 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -389,9 +389,6 @@ int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
 void unregister_kprobes(struct kprobe **kps, int num);
-int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
-int longjmp_break_handler(struct kprobe *, struct pt_regs *);
-void jprobe_return(void);
 unsigned long arch_deref_entry_point(void *);
 
 int register_kretprobe(struct kretprobe *rp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ea619021d901..69de130595f7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1272,7 +1272,7 @@ NOKPROBE_SYMBOL(cleanup_rp_inst);
 
 /*
 * Add the new probe to ap->list. Fail if this is the
-* second jprobe at the address - two jprobes can't coexist
+* second break_handler at the address
 */
 static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
@@ -1812,77 +1812,6 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 	return (unsigned long)entry;
 }
 
-#if 0
-int register_jprobes(struct jprobe **jps, int num)
-{
-	int ret = 0, i;
-
-	if (num <= 0)
-		return -EINVAL;
-
-	for (i = 0; i < num; i++) {
-		ret = register_jprobe(jps[i]);
-
-		if (ret < 0) {
-			if (i > 0)
-				unregister_jprobes(jps, i);
-			break;
-		}
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(register_jprobes);
-
-int register_jprobe(struct jprobe *jp)
-{
-	unsigned long addr, offset;
-	struct kprobe *kp = &jp->kp;
-
-	/*
-	 * Verify probepoint as well as the jprobe handler are
-	 * valid function entry points.
-	 */
-	addr = arch_deref_entry_point(jp->entry);
-
-	if (kallsyms_lookup_size_offset(addr, NULL, &offset) && offset == 0 &&
-	    kprobe_on_func_entry(kp->addr, kp->symbol_name, kp->offset)) {
-		kp->pre_handler = setjmp_pre_handler;
-		kp->break_handler = longjmp_break_handler;
-		return register_kprobe(kp);
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(register_jprobe);
-
-void unregister_jprobe(struct jprobe *jp)
-{
-	unregister_jprobes(&jp, 1);
-}
-EXPORT_SYMBOL_GPL(unregister_jprobe);
-
-void unregister_jprobes(struct jprobe **jps, int num)
-{
-	int i;
-
-	if (num <= 0)
-		return;
-	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
-		if (__unregister_kprobe_top(&jps[i]->kp) < 0)
-			jps[i]->kp.addr = NULL;
-	mutex_unlock(&kprobe_mutex);
-
-	synchronize_sched();
-	for (i = 0; i < num; i++) {
-		if (jps[i]->kp.addr)
-			__unregister_kprobe_bottom(&jps[i]->kp);
-	}
-}
-EXPORT_SYMBOL_GPL(unregister_jprobes);
-#endif
-
 #ifdef CONFIG_KRETPROBES
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
@@ -2329,8 +2258,6 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 
 	if (p->pre_handler == pre_handler_kretprobe)
 		kprobe_type = "r";
-	else if (p->pre_handler == setjmp_pre_handler)
-		kprobe_type = "j";
 	else
 		kprobe_type = "k";
 
@@ -2637,6 +2564,3 @@ late_initcall(debugfs_kprobe_init);
 #endif /* CONFIG_DEBUG_FS */
 
 module_init(init_kprobes);
-
-/* defined in arch/.../kernel/kprobes.c */
-EXPORT_SYMBOL_GPL(jprobe_return);
diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
index dd53e354f630..7bca480151b0 100644
--- a/kernel/test_kprobes.c
+++ b/kernel/test_kprobes.c
@@ -162,90 +162,6 @@ static int test_kprobes(void)
 
 }
 
-#if 0
-static u32 jph_val;
-
-static u32 j_kprobe_target(u32 value)
-{
-	if (preemptible()) {
-		handler_errors++;
-		pr_err("jprobe-handler is preemptible\n");
-	}
-	if (value != rand1) {
-		handler_errors++;
-		pr_err("incorrect value in jprobe handler\n");
-	}
-
-	jph_val = rand1;
-	jprobe_return();
-	return 0;
-}
-
-static struct jprobe jp = {
-	.entry		= j_kprobe_target,
-	.kp.symbol_name = "kprobe_target"
-};
-
-static int test_jprobe(void)
-{
-	int ret;
-
-	ret = register_jprobe(&jp);
-	if (ret < 0) {
-		pr_err("register_jprobe returned %d\n", ret);
-		return ret;
-	}
-
-	ret = target(rand1);
-	unregister_jprobe(&jp);
-	if (jph_val == 0) {
-		pr_err("jprobe handler not called\n");
-		handler_errors++;
-	}
-
-	return 0;
-}
-
-static struct jprobe jp2 = {
-	.entry          = j_kprobe_target,
-	.kp.symbol_name = "kprobe_target2"
-};
-
-static int test_jprobes(void)
-{
-	int ret;
-	struct jprobe *jps[2] = {&jp, &jp2};
-
-	/* addr and flags should be cleard for reusing kprobe. */
-	jp.kp.addr = NULL;
-	jp.kp.flags = 0;
-	ret = register_jprobes(jps, 2);
-	if (ret < 0) {
-		pr_err("register_jprobes returned %d\n", ret);
-		return ret;
-	}
-
-	jph_val = 0;
-	ret = target(rand1);
-	if (jph_val == 0) {
-		pr_err("jprobe handler not called\n");
-		handler_errors++;
-	}
-
-	jph_val = 0;
-	ret = target2(rand1);
-	if (jph_val == 0) {
-		pr_err("jprobe handler2 not called\n");
-		handler_errors++;
-	}
-	unregister_jprobes(jps, 2);
-
-	return 0;
-}
-#else
-#define test_jprobe() (0)
-#define test_jprobes() (0)
-#endif
 #ifdef CONFIG_KRETPROBES
 static u32 krph_val;
 
@@ -383,16 +299,6 @@ int init_test_probes(void)
 	if (ret < 0)
 		errors++;
 
-	num_tests++;
-	ret = test_jprobe();
-	if (ret < 0)
-		errors++;
-
-	num_tests++;
-	ret = test_jprobes();
-	if (ret < 0)
-		errors++;
-
 #ifdef CONFIG_KRETPROBES
 	num_tests++;
 	ret = test_kretprobe();
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b734cd1..02c289e29e6d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1698,7 +1698,7 @@ config KPROBES_SANITY_TEST
 	default n
 	help
 	  This option provides for testing basic kprobes functionality on
-	  boot. A sample kprobe, jprobe and kretprobe are inserted and
+	  boot. Samples of kprobe and kretprobe are inserted and
 	  verified for functionality.
 
 	  Say N if you are unsure.

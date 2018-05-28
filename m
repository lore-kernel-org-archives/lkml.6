Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-99051-1527490842-2-13693541607921208978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527490842; b=WfBfndJhqRJz1uN2UfYZ1QTe6e+S2oQjkPXX0ejNFxzHLxNNa2
    vBahp9b+iWFDW9sCa+i9aIaaqJGVFvozmjkRANl9cqZWSzrr6GXMhvjdpLljmyAb
    thlhV3KJ94tGg3P3jfCV3R0jsBQBW2ji4LLRpJFLv7TB1iWXNobMFlKeRMfuq3Aq
    S5TtjSjD0yREDsqdLBkiXCMGi6zIFlZhWOuVeDWlfyW9K8LLC2oG04fDE/vLfcgJ
    hAm3cC4Q6OHVWHoMZCpCAXulmw1+rzYWFQns5vjpWC2U0spPPmIkazT6bH+56s8n
    hGALfR3On6vKnymJAH3SsRorz+LGx0XuJM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527490842;
    bh=SBnEBSK0F7+leHqhobGcBanS1gNG0j6Ulg704TmeeXQ=; b=f8BIJhmumcjg
    j9z6V5nHgMvEKEbn+mpHXt4ANJExhcWxZOzZxkaPRHzC05HG4k0i6fKsM+kO+VFK
    qt2WivqKjVO3VpcpPfHlHSIefapGJP/VPMdoYz8gv7icZFf6CpdY/BXnPG3OiEtv
    xZqePOXInw1kV5xjG83XZhFN6COtBf5PW3rPW7GWqhPmmj97AAIigX1uSfjORn7O
    TwI01DGFb3sR0B9gDL1SXljqN+qMPxFpFcnT1tIdEF9LLOTwHjaIQDDApHqAZzgm
    WibNsUcM/ffuom1IAY1Pq7I1ZcOHfipZkdO8gw7+bJmLGLwVAyr8vDGr2D6VVPUZ
    L4YORhUGCw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=zidPIrB/ header.a=rsa-sha256
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
      header.i=@kernel.org header.b=zidPIrB/ header.a=rsa-sha256
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
X-CM-Envelope: MS4wfGeaCp6Gmlnf8ZyJyXITJ992k2UNJqETe7dfEMUsvShRFrjLspaJ2U4DSjkMQsc/PC7EGIBuiaBCzLlM5FXmPNFWmgxC2748pXSWhnl2En74ajzVYYYq
    asi699kOoHu0uNdLsLrmd1olO3tx9kj2GQ7tD+fPZBcY7d9k51dnukFmEhYlyBAOb42fNNSZelA4P4XI5A/WXuSs2OuUE2xOA1A3ePA8m+Q4+OaEa7Xonk1x
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Q4F1TQyLRCIcDEXpKH0A:9 a=LwnH9Lt4Efn2LYPn:21
    a=0fY6pjcGkOaDNjlR:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbeE1HAl (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 03:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753663AbeE1HAj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:00:39 -0400
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
Subject: [PATCH -tip v4 02/27] kprobes: Remove jprobe API implementation
Date: Mon, 28 May 2018 16:00:13 +0900
Message-Id: <152749081351.15132.10476552425076318218.stgit@devbox>
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

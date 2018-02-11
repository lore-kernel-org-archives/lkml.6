Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326480-2-18220419510480026466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326480; b=hdxRDeTFMu7PdwwS2fVv1XH0IZghFdTVZB3Hur1H80u1CD2
    6LsPvcahnK1dflJIjKNW/xcjUHeYbJZaLXmCXfCVuZIKtn1Os09QKRjCjLUGD3og
    lXDak20RjBbBXV6spIZHn37IbBl6CieKo0/5ygXxAV/CLTB1SSXKIh3jnRAlT4Tz
    7rjHzhfR7ZK4wqWmzj+WV44L5U2uNZo2mzPcWtPHrRIQysOu2BxP11lau7bSHLem
    3dhCjZT6hEZzLOQwKFJd1vxxgm/6/2zCec1A6iKIe304yz3qjd/desTq953iXfdy
    +yH0ea7pDbWiI8v3MuGNgSSerG2qiBIfS9Zt7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326480; bh=nhIEFjNwdCdSdNSBJCI
    7cESucAuIG5uR+lsguDlyT0A=; b=hQlWYNSUw+xH+HIi0mpcXU1PFlqhr+VqJF8
    w1nCI4TmH2F/NOpybW0ANqTdkaE2OmiHbOovdePvPxiJkcu7mF7NwNwpr7EV7TwT
    cg54GRbyKmxQh4WhG7BFWL11MLBU+78kn/3plPc5urw0Nopg4IjqT2LgvzWmZdZ+
    a6guOsOhsJIiK14RbOa7C34cnWuJtEShKtRmYBoXHuKDvJnQHbtZ3g7jN+rqRhsw
    RcDlXMiiN2xy7jEE4jMrTEETrFcA1cdpfVVfn2PyQttsW/3diol0VDH47CsWL20h
    J44H5JoAdOrQoO1qmRFM1M9eXEDJfbIu279abH6570DP+V02zXQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeBKFVD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:21:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932090AbeBKFSI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Peter Zijlstra" <peterz@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Brian Gerst" <brgerst@gmail.com>, bp@suse.de,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Zhou Chengming" <zhouchengming1@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.741744715@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 062/136] kprobes, x86/alternatives: Use text_mutex to
 protect smp_alt_modules
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zhou Chengming <zhouchengming1@huawei.com>

commit e846d13958066828a9483d862cc8370a72fadbb6 upstream.

We use alternatives_text_reserved() to check if the address is in
the fixed pieces of alternative reserved, but the problem is that
we don't hold the smp_alt mutex when call this function. So the list
traversal may encounter a deleted list_head if another path is doing
alternatives_smp_module_del().

One solution is that we can hold smp_alt mutex before call this
function, but the difficult point is that the callers of this
functions, arch_prepare_kprobe() and arch_prepare_optimized_kprobe(),
are called inside the text_mutex. So we must hold smp_alt mutex
before we go into these arch dependent code. But we can't now,
the smp_alt mutex is the arch dependent part, only x86 has it.
Maybe we can export another arch dependent callback to solve this.

But there is a simpler way to handle this problem. We can reuse the
text_mutex to protect smp_alt_modules instead of using another mutex.
And all the arch dependent checks of kprobes are inside the text_mutex,
so it's safe now.

Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@suse.de
Fixes: 2cfa197 "ftrace/alternatives: Introducing *_text_reserved functions"
Link: http://lkml.kernel.org/r/1509585501-79466-1-git-send-email-zhouchengming1@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/alternative.c | 26 +++++++++++++-------------
 kernel/extable.c              |  2 ++
 2 files changed, 15 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -409,7 +409,6 @@ static void alternatives_smp_lock(const
 {
 	const s32 *poff;
 
-	mutex_lock(&text_mutex);
 	for (poff = start; poff < end; poff++) {
 		u8 *ptr = (u8 *)poff + *poff;
 
@@ -419,7 +418,6 @@ static void alternatives_smp_lock(const
 		if (*ptr == 0x3e)
 			text_poke(ptr, ((unsigned char []){0xf0}), 1);
 	}
-	mutex_unlock(&text_mutex);
 }
 
 static void alternatives_smp_unlock(const s32 *start, const s32 *end,
@@ -427,7 +425,6 @@ static void alternatives_smp_unlock(cons
 {
 	const s32 *poff;
 
-	mutex_lock(&text_mutex);
 	for (poff = start; poff < end; poff++) {
 		u8 *ptr = (u8 *)poff + *poff;
 
@@ -437,7 +434,6 @@ static void alternatives_smp_unlock(cons
 		if (*ptr == 0xf0)
 			text_poke(ptr, ((unsigned char []){0x3E}), 1);
 	}
-	mutex_unlock(&text_mutex);
 }
 
 struct smp_alt_module {
@@ -456,8 +452,7 @@ struct smp_alt_module {
 	struct list_head next;
 };
 static LIST_HEAD(smp_alt_modules);
-static DEFINE_MUTEX(smp_alt);
-static bool uniproc_patched = false;	/* protected by smp_alt */
+static bool uniproc_patched = false;	/* protected by text_mutex */
 
 void __init_or_module alternatives_smp_module_add(struct module *mod,
 						  char *name,
@@ -466,7 +461,7 @@ void __init_or_module alternatives_smp_m
 {
 	struct smp_alt_module *smp;
 
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
 	if (!uniproc_patched)
 		goto unlock;
 
@@ -493,14 +488,14 @@ void __init_or_module alternatives_smp_m
 smp_unlock:
 	alternatives_smp_unlock(locks, locks_end, text, text_end);
 unlock:
-	mutex_unlock(&smp_alt);
+	mutex_unlock(&text_mutex);
 }
 
 void __init_or_module alternatives_smp_module_del(struct module *mod)
 {
 	struct smp_alt_module *item;
 
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
 	list_for_each_entry(item, &smp_alt_modules, next) {
 		if (mod != item->mod)
 			continue;
@@ -508,7 +503,7 @@ void __init_or_module alternatives_smp_m
 		kfree(item);
 		break;
 	}
-	mutex_unlock(&smp_alt);
+	mutex_unlock(&text_mutex);
 }
 
 void alternatives_enable_smp(void)
@@ -518,7 +513,7 @@ void alternatives_enable_smp(void)
 	/* Why bother if there are no other CPUs? */
 	BUG_ON(num_possible_cpus() == 1);
 
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
 
 	if (uniproc_patched) {
 		pr_info("switching to SMP code\n");
@@ -530,10 +525,13 @@ void alternatives_enable_smp(void)
 					      mod->text, mod->text_end);
 		uniproc_patched = false;
 	}
-	mutex_unlock(&smp_alt);
+	mutex_unlock(&text_mutex);
 }
 
-/* Return 1 if the address range is reserved for smp-alternatives */
+/*
+ * Return 1 if the address range is reserved for SMP-alternatives.
+ * Must hold text_mutex.
+ */
 int alternatives_text_reserved(void *start, void *end)
 {
 	struct smp_alt_module *mod;
@@ -541,6 +539,8 @@ int alternatives_text_reserved(void *sta
 	u8 *text_start = start;
 	u8 *text_end = end;
 
+	lockdep_assert_held(&text_mutex);
+
 	list_for_each_entry(mod, &smp_alt_modules, next) {
 		if (mod->text > text_end || mod->text_end < text_start)
 			continue;
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -28,6 +28,8 @@
  * mutex protecting text section modification (dynamic code patching).
  * some users need to sleep (allocating memory...) while they hold this lock.
  *
+ * Note: Also protects SMP-alternatives modification on x86.
+ *
  * NOT exported to modules - patching kernel text is a really delicate matter.
  */
 DEFINE_MUTEX(text_mutex);

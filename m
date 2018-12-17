Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF6AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4E22133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbeLQSTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:19:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43277 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeLQSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:19:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIItXw2560769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:18:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIItvv2560766;
        Mon, 17 Dec 2018 10:18:55 -0800
Date:   Mon, 17 Dec 2018 10:18:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-fb1a59fae8baa3f3c69b72a87ff94fc4fa5683ec@git.kernel.org>
Cc:     anil.s.keshavamurthy@intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, yhs@fb.com,
        davem@davemloft.net, hpa@zytor.com, bp@alien8.de,
        righi.andrea@gmail.com, mhiramat@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org
Reply-To: davem@davemloft.net, tglx@linutronix.de, yhs@fb.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          anil.s.keshavamurthy@intel.com, luto@kernel.org,
          naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, righi.andrea@gmail.com, mhiramat@kernel.org,
          hpa@zytor.com, bp@alien8.de
In-Reply-To: <154503485491.26176.15823229545155174796.stgit@devbox>
References: <154503485491.26176.15823229545155174796.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Blacklist symbols in arch-defined
 prohibited area
Git-Commit-ID: fb1a59fae8baa3f3c69b72a87ff94fc4fa5683ec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fb1a59fae8baa3f3c69b72a87ff94fc4fa5683ec
Gitweb:     https://git.kernel.org/tip/fb1a59fae8baa3f3c69b72a87ff94fc4fa5683ec
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Mon, 17 Dec 2018 17:20:55 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 17:48:38 +0100

kprobes: Blacklist symbols in arch-defined prohibited area

Blacklist symbols in arch-defined probe-prohibited areas.
With this change, user can see all symbols which are prohibited
to probe in debugfs.

All archtectures which have custom prohibit areas should define
its own arch_populate_kprobe_blacklist() function, but unless that,
all symbols marked __kprobes are blacklisted.

Reported-by: Andrea Righi <righi.andrea@gmail.com>
Tested-by: Andrea Righi <righi.andrea@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lkml.kernel.org/r/154503485491.26176.15823229545155174796.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kprobes.h |  3 +++
 kernel/kprobes.c        | 67 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e909413e4e38..5da8a1de2187 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -242,10 +242,13 @@ extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
+extern int arch_populate_kprobe_blacklist(void);
 extern bool arch_kprobe_on_func_entry(unsigned long offset);
 extern bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
+extern int kprobe_add_ksym_blacklist(unsigned long entry);
+extern int kprobe_add_area_blacklist(unsigned long start, unsigned long end);
 
 struct kprobe_insn_cache {
 	struct mutex mutex;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 90e98e233647..90569aec0f24 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2093,6 +2093,47 @@ void dump_kprobe(struct kprobe *kp)
 }
 NOKPROBE_SYMBOL(dump_kprobe);
 
+int kprobe_add_ksym_blacklist(unsigned long entry)
+{
+	struct kprobe_blacklist_entry *ent;
+	unsigned long offset = 0, size = 0;
+
+	if (!kernel_text_address(entry) ||
+	    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		return -EINVAL;
+
+	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return -ENOMEM;
+	ent->start_addr = entry;
+	ent->end_addr = entry + size;
+	INIT_LIST_HEAD(&ent->list);
+	list_add_tail(&ent->list, &kprobe_blacklist);
+
+	return (int)size;
+}
+
+/* Add all symbols in given area into kprobe blacklist */
+int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
+{
+	unsigned long entry;
+	int ret = 0;
+
+	for (entry = start; entry < end; entry += ret) {
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)	/* In case of alias symbol */
+			ret = 1;
+	}
+	return 0;
+}
+
+int __init __weak arch_populate_kprobe_blacklist(void)
+{
+	return 0;
+}
+
 /*
  * Lookup and populate the kprobe_blacklist.
  *
@@ -2104,26 +2145,24 @@ NOKPROBE_SYMBOL(dump_kprobe);
 static int __init populate_kprobe_blacklist(unsigned long *start,
 					     unsigned long *end)
 {
+	unsigned long entry;
 	unsigned long *iter;
-	struct kprobe_blacklist_entry *ent;
-	unsigned long entry, offset = 0, size = 0;
+	int ret;
 
 	for (iter = start; iter < end; iter++) {
 		entry = arch_deref_entry_point((void *)*iter);
-
-		if (!kernel_text_address(entry) ||
-		    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		ret = kprobe_add_ksym_blacklist(entry);
+		if (ret == -EINVAL)
 			continue;
-
-		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
-		if (!ent)
-			return -ENOMEM;
-		ent->start_addr = entry;
-		ent->end_addr = entry + size;
-		INIT_LIST_HEAD(&ent->list);
-		list_add_tail(&ent->list, &kprobe_blacklist);
+		if (ret < 0)
+			return ret;
 	}
-	return 0;
+
+	/* Symbols in __kprobes_text are blacklisted */
+	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
+					(unsigned long)__kprobes_text_end);
+
+	return ret ? : arch_populate_kprobe_blacklist();
 }
 
 /* Module notifier call back, checking kprobes on the module */

Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EEFC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C05218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C05218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeHRPHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:07:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41573 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHRPHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:07:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBxqKx1291812
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:59:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBxqkC1291809;
        Sat, 18 Aug 2018 04:59:52 -0700
Date:   Sat, 18 Aug 2018 04:59:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-d83212d5dd6761625fe87cc23016bbaa47303271@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, peterz@infradead.org, acme@redhat.com,
        mingo@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, joro@8bytes.org,
        ak@linux.intel.com, hpa@zytor.com, jolsa@redhat.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, jolsa@redhat.com, hpa@zytor.com,
          joro@8bytes.org, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          luto@kernel.org, mingo@kernel.org, peterz@infradead.org,
          acme@redhat.com, dave.hansen@linux.intel.com
In-Reply-To: <1528289651-4113-3-git-send-email-adrian.hunter@intel.com>
References: <1528289651-4113-3-git-send-email-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kallsyms, x86: Export addresses of PTI entry
 trampolines
Git-Commit-ID: d83212d5dd6761625fe87cc23016bbaa47303271
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

Commit-ID:  d83212d5dd6761625fe87cc23016bbaa47303271
Gitweb:     https://git.kernel.org/tip/d83212d5dd6761625fe87cc23016bbaa47303271
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Wed, 6 Jun 2018 15:54:10 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 14 Aug 2018 19:12:29 -0300

kallsyms, x86: Export addresses of PTI entry trampolines

Currently, the addresses of PTI entry trampolines are not exported to
user space. Kernel profiling tools need these addresses to identify the
kernel code, so add a symbol and address for each CPU's PTI entry
trampoline.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1528289651-4113-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/mm/cpu_entry_area.c | 23 +++++++++++++++++++++++
 kernel/kallsyms.c            | 28 +++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index b45f5aaefd74..fab49fd5190f 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -2,6 +2,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
+#include <linux/kallsyms.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/pgtable.h>
@@ -150,6 +151,28 @@ static void __init setup_cpu_entry_area(int cpu)
 	percpu_setup_debug_store(cpu);
 }
 
+#ifdef CONFIG_X86_64
+int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		     char *name)
+{
+	unsigned int cpu, ncpu = 0;
+
+	if (symnum >= num_possible_cpus())
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		if (ncpu++ >= symnum)
+			break;
+	}
+
+	*value = (unsigned long)&get_cpu_entry_area(cpu)->entry_trampoline;
+	*type = 't';
+	strlcpy(name, "__entry_SYSCALL_64_trampoline", KSYM_NAME_LEN);
+
+	return 0;
+}
+#endif
+
 static __init void setup_cpu_entry_area_ptes(void)
 {
 #ifdef CONFIG_X86_32
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aa31aa07f2ef..02a0b01380d8 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -432,6 +432,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
 struct kallsym_iter {
 	loff_t pos;
+	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
 	unsigned long value;
@@ -443,9 +444,29 @@ struct kallsym_iter {
 	int show_value;
 };
 
+int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
+			    char *type, char *name)
+{
+	return -EINVAL;
+}
+
+static int get_ksymbol_arch(struct kallsym_iter *iter)
+{
+	int ret = arch_get_kallsym(iter->pos - kallsyms_num_syms,
+				   &iter->value, &iter->type,
+				   iter->name);
+
+	if (ret < 0) {
+		iter->pos_arch_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int get_ksymbol_mod(struct kallsym_iter *iter)
 {
-	int ret = module_get_kallsym(iter->pos - kallsyms_num_syms,
+	int ret = module_get_kallsym(iter->pos - iter->pos_arch_end,
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
@@ -501,6 +522,7 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	iter->nameoff = get_symbol_offset(new_pos);
 	iter->pos = new_pos;
 	if (new_pos == 0) {
+		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
 	}
@@ -515,6 +537,10 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
+	if ((!iter->pos_arch_end || iter->pos_arch_end > pos) &&
+	    get_ksymbol_arch(iter))
+		return 1;
+
 	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
 	    get_ksymbol_mod(iter))
 		return 1;

Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4D206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F4D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407605AbeKWI25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:28:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404865AbeKWI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:28:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLkXpA3947088
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:46:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLkX6B3947082;
        Thu, 22 Nov 2018 13:46:33 -0800
Date:   Thu, 22 Nov 2018 13:46:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-352940ececaca58536a7fc4ff6b41d181156fd65@git.kernel.org>
Cc:     xiaochen.shen@intel.com, sherry.hurwitz@amd.com,
        babu.moger@amd.com, akpm@linux-foundation.org, corbet@lwn.net,
        qianyue.zj@alibaba-inc.com, arnd@arndb.de,
        mchehab+samsung@kernel.org, mingo@kernel.org,
        chang.seok.bae@intel.com, mingo@redhat.com, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, jpoimboe@redhat.com,
        peterz@infradead.org, Thomas.Lendacky@amd.com, dwmw2@infradead.org,
        vkuznets@redhat.com, pbonzini@redhat.com, Babu.Moger@amd.com,
        tglx@linutronix.de, rian@alum.mit.edu, rafael@kernel.org,
        dima@arista.com, reinette.chatre@intel.com, fenghua.yu@intel.com,
        puwen@hygon.cn, luto@kernel.org, kirill.shutemov@linux.intel.com,
        davem@davemloft.net, brijesh.singh@amd.com,
        linux-kernel@vger.kernel.org, jannh@google.com,
        suravee.suthikulpanit@amd.com, tony.luck@intel.com,
        jroedel@suse.de, linux-doc@vger.kernel.org, hpa@zytor.com,
        bp@suse.de, gregkh@linuxfoundation.org
Reply-To: davem@davemloft.net, brijesh.singh@amd.com,
          kirill.shutemov@linux.intel.com, luto@kernel.org, puwen@hygon.cn,
          fenghua.yu@intel.com, reinette.chatre@intel.com, dima@arista.com,
          rafael@kernel.org, rian@alum.mit.edu, gregkh@linuxfoundation.org,
          bp@suse.de, hpa@zytor.com, linux-doc@vger.kernel.org,
          jroedel@suse.de, tony.luck@intel.com,
          suravee.suthikulpanit@amd.com, linux-kernel@vger.kernel.org,
          jannh@google.com, mingo@kernel.org, mchehab+samsung@kernel.org,
          arnd@arndb.de, qianyue.zj@alibaba-inc.com, corbet@lwn.net,
          akpm@linux-foundation.org, babu.moger@amd.com,
          sherry.hurwitz@amd.com, xiaochen.shen@intel.com,
          tglx@linutronix.de, pbonzini@redhat.com, Babu.Moger@amd.com,
          vkuznets@redhat.com, dwmw2@infradead.org,
          Thomas.Lendacky@amd.com, peterz@infradead.org,
          jpoimboe@redhat.com, pombredanne@nexb.com,
          kstewart@linuxfoundation.org, chang.seok.bae@intel.com,
          mingo@redhat.com
In-Reply-To: <20181121202811.4492-3-babu.moger@amd.com>
References: <20181121202811.4492-3-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Rename the RDT functions and
 definitions
Git-Commit-ID: 352940ececaca58536a7fc4ff6b41d181156fd65
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

Commit-ID:  352940ececaca58536a7fc4ff6b41d181156fd65
Gitweb:     https://git.kernel.org/tip/352940ececaca58536a7fc4ff6b41d181156fd65
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:27 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:18 +0100

x86/resctrl: Rename the RDT functions and definitions

As AMD is starting to support RESCTRL features, rename the RDT functions
and definitions to more generic names.

Replace "intel_rdt" with "resctrl" where applicable.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: <qianyue.zj@alibaba-inc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Rian Hunter <rian@alum.mit.edu>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <xiaochen.shen@intel.com>
Link: https://lkml.kernel.org/r/20181121202811.4492-3-babu.moger@amd.com
---
 arch/x86/include/asm/resctrl_sched.h   | 24 ++++++++++++------------
 arch/x86/kernel/cpu/resctrl/core.c     | 28 ++++++++++++++--------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 11 ++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
 arch/x86/kernel/process_32.c           |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 7 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index 9acb06b6f81e..6e082697a613 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_SCHED_H
-#define _ASM_X86_INTEL_RDT_SCHED_H
+#ifndef _ASM_X86_RESCTRL_SCHED_H
+#define _ASM_X86_RESCTRL_SCHED_H
 
 #ifdef CONFIG_INTEL_RDT
 
@@ -10,7 +10,7 @@
 #define IA32_PQR_ASSOC	0x0c8f
 
 /**
- * struct intel_pqr_state - State cache for the PQR MSR
+ * struct resctrl_pqr_state - State cache for the PQR MSR
  * @cur_rmid:		The cached Resource Monitoring ID
  * @cur_closid:	The cached Class Of Service ID
  * @default_rmid:	The user assigned Resource Monitoring ID
@@ -24,21 +24,21 @@
  * The cache also helps to avoid pointless updates if the value does
  * not change.
  */
-struct intel_pqr_state {
+struct resctrl_pqr_state {
 	u32			cur_rmid;
 	u32			cur_closid;
 	u32			default_rmid;
 	u32			default_closid;
 };
 
-DECLARE_PER_CPU(struct intel_pqr_state, pqr_state);
+DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 
 /*
- * __intel_rdt_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
+ * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
  * Following considerations are made so that this has minimal impact
  * on scheduler hot path:
@@ -51,9 +51,9 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  *   simple as possible.
  * Must be called with preemption disabled.
  */
-static void __intel_rdt_sched_in(void)
+static void __resctrl_sched_in(void)
 {
-	struct intel_pqr_state *state = this_cpu_ptr(&pqr_state);
+	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = state->default_closid;
 	u32 rmid = state->default_rmid;
 
@@ -78,16 +78,16 @@ static void __intel_rdt_sched_in(void)
 	}
 }
 
-static inline void intel_rdt_sched_in(void)
+static inline void resctrl_sched_in(void)
 {
 	if (static_branch_likely(&rdt_enable_key))
-		__intel_rdt_sched_in();
+		__resctrl_sched_in();
 }
 
 #else
 
-static inline void intel_rdt_sched_in(void) {}
+static inline void resctrl_sched_in(void) {}
 
 #endif /* CONFIG_INTEL_RDT */
 
-#endif /* _ASM_X86_INTEL_RDT_SCHED_H */
+#endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 27c4316bb691..0cf890ae0de2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,7 +22,7 @@
  * Software Developer Manual June 2016, volume 3, section 17.17.
  */
 
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt)	"resctrl: " fmt
 
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -40,12 +40,12 @@
 DEFINE_MUTEX(rdtgroup_mutex);
 
 /*
- * The cached intel_pqr_state is strictly per CPU and can never be
+ * The cached resctrl_pqr_state is strictly per CPU and can never be
  * updated from a remote CPU. Functions which modify the state
  * are called with interrupts disabled and no preemption, which
  * is sufficient for the protection.
  */
-DEFINE_PER_CPU(struct intel_pqr_state, pqr_state);
+DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 /*
  * Used to store the max resource name width and max resource data width
@@ -639,7 +639,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 static void clear_closid_rmid(int cpu)
 {
-	struct intel_pqr_state *state = this_cpu_ptr(&pqr_state);
+	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 
 	state->default_closid = 0;
 	state->default_rmid = 0;
@@ -648,7 +648,7 @@ static void clear_closid_rmid(int cpu)
 	wrmsr(IA32_PQR_ASSOC, 0, 0);
 }
 
-static int intel_rdt_online_cpu(unsigned int cpu)
+static int resctrl_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
 
@@ -674,7 +674,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 	}
 }
 
-static int intel_rdt_offline_cpu(unsigned int cpu)
+static int resctrl_offline_cpu(unsigned int cpu)
 {
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -866,7 +866,7 @@ static __init bool get_rdt_resources(void)
 
 static enum cpuhp_state rdt_online;
 
-static int __init intel_rdt_late_init(void)
+static int __init resctrl_late_init(void)
 {
 	struct rdt_resource *r;
 	int state, ret;
@@ -877,8 +877,8 @@ static int __init intel_rdt_late_init(void)
 	rdt_init_padding();
 
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
-				  "x86/rdt/cat:online:",
-				  intel_rdt_online_cpu, intel_rdt_offline_cpu);
+				  "x86/resctrl/cat:online:",
+				  resctrl_online_cpu, resctrl_offline_cpu);
 	if (state < 0)
 		return state;
 
@@ -890,20 +890,20 @@ static int __init intel_rdt_late_init(void)
 	rdt_online = state;
 
 	for_each_alloc_capable_rdt_resource(r)
-		pr_info("Intel RDT %s allocation detected\n", r->name);
+		pr_info("%s allocation detected\n", r->name);
 
 	for_each_mon_capable_rdt_resource(r)
-		pr_info("Intel RDT %s monitoring detected\n", r->name);
+		pr_info("%s monitoring detected\n", r->name);
 
 	return 0;
 }
 
-late_initcall(intel_rdt_late_init);
+late_initcall(resctrl_late_init);
 
-static void __exit intel_rdt_exit(void)
+static void __exit resctrl_exit(void)
 {
 	cpuhp_remove_state(rdt_online);
 	rdtgroup_exit();
 }
 
-__exitcall(intel_rdt_exit);
+__exitcall(resctrl_exit);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1b36709591d8..eeaee05522b5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -69,7 +69,7 @@ struct rmid_read {
 	u64			val;
 };
 
-extern unsigned int intel_cqm_threshold;
+extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d492d4c0e8cc..ebf408db8191 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -73,7 +73,7 @@ unsigned int rdt_mon_features;
  * This is the threshold cache occupancy at which we will consider an
  * RMID available for re-allocation.
  */
-unsigned int intel_cqm_threshold;
+unsigned int resctrl_cqm_threshold;
 
 static inline struct rmid_entry *__rmid_entry(u32 rmid)
 {
@@ -107,7 +107,7 @@ static bool rmid_dirty(struct rmid_entry *entry)
 {
 	u64 val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
 
-	return val >= intel_cqm_threshold;
+	return val >= resctrl_cqm_threshold;
 }
 
 /*
@@ -187,7 +187,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
 			val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
-			if (val <= intel_cqm_threshold)
+			if (val <= resctrl_cqm_threshold)
 				continue;
 		}
 
@@ -625,6 +625,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
+	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
 	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
@@ -637,10 +638,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	intel_cqm_threshold = boot_cpu_data.x86_cache_size * 1024 / r->num_rmid;
+	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
 
 	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	intel_cqm_threshold /= r->mon_scale;
+	resctrl_cqm_threshold /= r->mon_scale;
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f5a76ca43f0f..2bf1f3227afa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -298,7 +298,7 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
 }
 
 /*
- * This is safe against intel_rdt_sched_in() called from __switch_to()
+ * This is safe against resctrl_sched_in() called from __switch_to()
  * because __switch_to() is executed with interrupts disabled. A local call
  * from update_closid_rmid() is proteced against __switch_to() because
  * preemption is disabled.
@@ -317,7 +317,7 @@ static void update_cpu_closid_rmid(void *info)
 	 * executing task might have its own closid selected. Just reuse
 	 * the context switch code.
 	 */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 }
 
 /*
@@ -542,7 +542,7 @@ static void move_myself(struct callback_head *head)
 
 	preempt_disable();
 	/* update PQR_ASSOC MSR to make resource group go into effect */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 	preempt_enable();
 
 	kfree(callback);
@@ -926,7 +926,7 @@ static int max_threshold_occ_show(struct kernfs_open_file *of,
 {
 	struct rdt_resource *r = of->kn->parent->priv;
 
-	seq_printf(seq, "%u\n", intel_cqm_threshold * r->mon_scale);
+	seq_printf(seq, "%u\n", resctrl_cqm_threshold * r->mon_scale);
 
 	return 0;
 }
@@ -945,7 +945,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
 
-	intel_cqm_threshold = bytes / r->mon_scale;
+	resctrl_cqm_threshold = bytes / r->mon_scale;
 
 	return nbytes;
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index d16207e7d1e5..dc4d92764d1a 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -302,7 +302,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 
 	/* Load the Intel cache allocation PQR MSR. */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 
 	return prev_p;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 8f23562687fb..67f7f5b0b6b7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -664,7 +664,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	}
 
 	/* Load the Intel cache allocation PQR MSR. */
-	intel_rdt_sched_in();
+	resctrl_sched_in();
 
 	return prev_p;
 }

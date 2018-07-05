Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3DFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD26724007
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlAUJFHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD26724007
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeGENUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:20:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37711 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753625AbeGENUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:20:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id h20-v6so5425016pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h/cxoC9hMMICfY7e8ACQvTPGQS0p52NGdN0OCeXd4Jo=;
        b=UlAUJFHZpZP+OG/MKKpiejMWuuT99Q9uV54ac1yyzw8XcXXIPQAJgkcjq+P2NbgIi+
         KP+t+gq5AIuW799IZANMATCFvsYSo6tyo/Y+s2mtrbFZb402ypAF4VbdSYWdAGGwNvGj
         M2s6Y9+BAUl5htUhUZph78d0FC4pfeQsSURhQvqAT6Md7eOUdTZ09UnmnO187a8iIs8j
         oBmZjdCNWMuSyXdamoVGxJ+d5oxNMxe0gjq1t82n5d2mmDgPUyf79qL+m74zeDlfAnG9
         /XraFFjts873h9T26o2GKrmtXjaICFjhG06BzWXKU3MhVvsYPJ1XwEjxnbPMbNpgzsXO
         6aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h/cxoC9hMMICfY7e8ACQvTPGQS0p52NGdN0OCeXd4Jo=;
        b=rlZdH+pnOIXZKC1QiOTNM+BJzScJxbLggOsILEWV+sNgk4gVyjwIKEueR3mbK0GT0o
         Ihil55RL8+kEI3cFodlMfSZFQ1449XTP/liIwem4Ro8G5ffrY4BkEprVip95wSSJ3r2E
         oqmCJOcRLLNBcoiX1bTMzkyt+2XMUzyRVpsHZfk2z2tsRaNFbRKBQnmrjnAsoSescDp7
         pm1Uod/JA6FhzghooyvT8Y/1tY5ftx/Lhhh/RB0vJU3Nqe9G19nYogOi2URWW3LPzZ9+
         lvaa+J7zfWrslQKeLDtGaRNiJQ9G34WVSgU4MBa7GH6J9+MJH4CJt3/mL97cTWTsx/gw
         dsEQ==
X-Gm-Message-State: APt69E16G65277N46orT5plnVyWp4bhZ90EZ5XgMAdi9D/vTByAIBMDE
        PJHplMcCNPooOSilf+8J/y8=
X-Google-Smtp-Source: AAOMgpcNsYITIEtzOaBgyDyp4J+hDyT0l8ix0sEQvwlrkEbhFBo/sygBz2MH7NEJU6r+1NOcEhGaNg==
X-Received: by 2002:a65:654d:: with SMTP id a13-v6mr985753pgw.132.1530796840761;
        Thu, 05 Jul 2018 06:20:40 -0700 (PDT)
Received: from dest.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id b1-v6sm1150111pfa.181.2018.07.05.06.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:20:39 -0700 (PDT)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v12 1/2] Reorganize the oom report in dump_header
Date:   Thu,  5 Jul 2018 21:20:28 +0800
Message-Id: <1530796829-4539-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

OOM report contains several sections. The first one is the allocation
context that has triggered the OOM. Then we have cpuset context
followed by the stack trace of the OOM path. Followed by the oom
eligible tasks and the information about the chosen oom victim.

One thing that makes parsing more awkward than necessary is that we do
not have a single and easily parsable line about the oom context. This
patch is reorganizing the oom report to
1) who invoked oom and what was the allocation request
        [  126.168182] panic invoked oom-killer: gfp_mask=0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0

2) OOM stack trace
        [  126.169806] CPU: 23 PID: 8668 Comm: panic Not tainted 4.18.0-rc3+ #42
        [  126.170494] Hardware name: Inspur SA5212M4/YZMB-00370-107, BIOS 4.1.10 11/14/2016
        [  126.171197] Call Trace:
        [  126.171901]  dump_stack+0x5a/0x73
        [  126.172593]  dump_header+0x58/0x2dc
        [  126.173294]  oom_kill_process+0x228/0x420
        [  126.173999]  ? oom_badness+0x2a/0x130
        [  126.174705]  out_of_memory+0x11a/0x4a0
        [  126.175415]  __alloc_pages_slowpath+0x7cc/0xa1e
        [  126.176128]  ? __alloc_pages_slowpath+0x194/0xa1e
        [  126.176853]  ? page_counter_try_charge+0x54/0xc0
        [  126.177580]  __alloc_pages_nodemask+0x277/0x290
        [  126.178319]  alloc_pages_vma+0x73/0x180
        [  126.179058]  do_anonymous_page+0xed/0x5a0
        [  126.179825]  __handle_mm_fault+0xbb3/0xe70
        [  126.180566]  handle_mm_fault+0xfa/0x210
        [  126.181313]  __do_page_fault+0x233/0x4c0
        [  126.182063]  do_page_fault+0x32/0x140
        [  126.182812]  ? page_fault+0x8/0x30
        [  126.183560]  page_fault+0x1e/0x30

3) oom context (contrains and the chosen victim).
        [  126.190619] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,task=panic,pid=10235,uid=    0

An admin can easily get the full oom context at a single line which
makes parsing much easier.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
Changes since v11:
- move the array of const char oom_constraint_text to oom_kill.c
- add the cpuset information in the one line output.

Changes since v10:
- divide the patch v8 into two parts. One part is to add the array of const char and put enum
  oom_constaint into oom.h; the other adds a new func to print the missing information for the system-
  wide oom report.

Changes since v9:
- divide the patch v8 into two parts. One part is to move enum oom_constraint into memcontrol.h; the
  other refactors the output info in the dump_header.
- replace orgin_memcg and kill_memcg with oom_memcg and task_memcg resptively.

Changes since v8:
- add the constraint in the oom_control structure.
- put enum oom_constraint and constraint array into the oom.h file.
- simplify the description for mem_cgroup_print_oom_context.

Changes since v7:
- add the constraint parameter to dump_header and oom_kill_process.
- remove the static char array in the mem_cgroup_print_oom_context, and
  invoke pr_cont_cgroup_path to print memcg' name.
- combine the patchset v6 into one.

Changes since v6:
- divide the patch v5 into two parts. One part is to add an array of const char and
  put enum oom_constraint into the memcontrol.h; the other refactors the output
  in the dump_header.
- limit the memory usage for the static char array by using NAME_MAX in the mem_cgroup_print_oom_context.
- eliminate the spurious spaces in the oom's output and fix the spelling of "constrain".

Changes since v5:
- add an array of const char for each constraint.
- replace all of the pr_cont with a single line print of the pr_info.
- put enum oom_constraint into the memcontrol.c file for printing oom constraint.

Changes since v4:
- rename the helper's name to mem_cgroup_print_oom_context.
- rename the mem_cgroup_print_oom_info to mem_cgroup_print_oom_meminfo.
- add the constrain info in the dump_header.

Changes since v3:
- rename the helper's name to mem_cgroup_print_oom_memcg_name.
- add the rcu lock held to the helper.
- remove the print info of memcg's name in mem_cgroup_print_oom_info.

Changes since v2:
- add the mem_cgroup_print_memcg_name helper to print the memcg's
  name which contains the task that will be killed by the oom-killer.

Changes since v1:
- replace adding mem_cgroup_print_oom_info with printing the memcg's
  name only.

 include/linux/oom.h    | 10 ++++++++++
 kernel/cgroup/cpuset.c |  4 ++--
 mm/oom_kill.c          | 36 ++++++++++++++++++++----------------
 mm/page_alloc.c        |  4 ++--
 4 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 6adac113e96d..3e5e01619bc8 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -15,6 +15,13 @@ struct notifier_block;
 struct mem_cgroup;
 struct task_struct;
 
+enum oom_constraint {
+	CONSTRAINT_NONE,
+	CONSTRAINT_CPUSET,
+	CONSTRAINT_MEMORY_POLICY,
+	CONSTRAINT_MEMCG,
+};
+
 /*
  * Details of the page allocation that triggered the oom killer that are used to
  * determine what should be killed.
@@ -42,6 +49,9 @@ struct oom_control {
 	unsigned long totalpages;
 	struct task_struct *chosen;
 	unsigned long chosen_points;
+
+	/* Used to print the constraint info. */
+	enum oom_constraint constraint;
 };
 
 extern struct mutex oom_lock;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 266f10cb7222..5d5baddb05c3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2666,9 +2666,9 @@ void cpuset_print_current_mems_allowed(void)
 	rcu_read_lock();
 
 	cgrp = task_cs(current)->css.cgroup;
-	pr_info("%s cpuset=", current->comm);
+	pr_cont(",cpuset=");
 	pr_cont_cgroup_name(cgrp);
-	pr_cont(" mems_allowed=%*pbl\n",
+	pr_cont(",mems_allowed=%*pbl",
 		nodemask_pr_args(&current->mems_allowed));
 
 	rcu_read_unlock();
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e77bc51..c38f224b0d9e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -237,11 +237,11 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
 	return points > 0 ? points : 1;
 }
 
-enum oom_constraint {
-	CONSTRAINT_NONE,
-	CONSTRAINT_CPUSET,
-	CONSTRAINT_MEMORY_POLICY,
-	CONSTRAINT_MEMCG,
+static const char * const oom_constraint_text[] = {
+	[CONSTRAINT_NONE] = "CONSTRAINT_NONE",
+	[CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
+	[CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
+	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
 };
 
 /*
@@ -421,15 +421,20 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 
 static void dump_header(struct oom_control *oc, struct task_struct *p)
 {
-	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n",
-		current->comm, oc->gfp_mask, &oc->gfp_mask,
-		nodemask_pr_args(oc->nodemask), oc->order,
+	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
+		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
 			current->signal->oom_score_adj);
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
 		pr_warn("COMPACTION is disabled!!!\n");
 
-	cpuset_print_current_mems_allowed();
 	dump_stack();
+
+	/* one line summary of the oom killer context. */
+	pr_info("oom-kill:constraint=%s,nodemask=%*pbl,task=%s,pid=%5d,uid=%5d",
+			oom_constraint_text[oc->constraint],
+			nodemask_pr_args(oc->nodemask),
+			p->comm, p->pid, from_kuid(&init_user_ns, task_uid(p)));
+	cpuset_print_current_mems_allowed();
 	if (is_memcg_oom(oc))
 		mem_cgroup_print_oom_info(oc->memcg, p);
 	else {
@@ -973,8 +978,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 /*
  * Determines whether the kernel must panic because of the panic_on_oom sysctl.
  */
-static void check_panic_on_oom(struct oom_control *oc,
-			       enum oom_constraint constraint)
+static void check_panic_on_oom(struct oom_control *oc)
 {
 	if (likely(!sysctl_panic_on_oom))
 		return;
@@ -984,7 +988,7 @@ static void check_panic_on_oom(struct oom_control *oc,
 		 * does not panic for cpuset, mempolicy, or memcg allocation
 		 * failures.
 		 */
-		if (constraint != CONSTRAINT_NONE)
+		if (oc->constraint != CONSTRAINT_NONE)
 			return;
 	}
 	/* Do not panic for oom kills triggered by sysrq */
@@ -1021,8 +1025,8 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed = 0;
-	enum oom_constraint constraint = CONSTRAINT_NONE;
 
+	oc->constraint = CONSTRAINT_NONE;
 	if (oom_killer_disabled)
 		return false;
 
@@ -1057,10 +1061,10 @@ bool out_of_memory(struct oom_control *oc)
 	 * Check if there were limitations on the allocation (only relevant for
 	 * NUMA and memcg) that may require different handling.
 	 */
-	constraint = constrained_alloc(oc);
-	if (constraint != CONSTRAINT_MEMORY_POLICY)
+	oc->constraint = constrained_alloc(oc);
+	if (oc->constraint != CONSTRAINT_MEMORY_POLICY)
 		oc->nodemask = NULL;
-	check_panic_on_oom(oc, constraint);
+	check_panic_on_oom(oc);
 
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
 	    current->mm && !oom_unkillable_task(current, NULL, oc->nodemask) &&
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..d3de563782c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3416,13 +3416,13 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	pr_warn("%s: %pV, mode:%#x(%pGg), nodemask=%*pbl\n",
+	pr_warn("%s: %pV,mode:%#x(%pGg),nodemask=%*pbl",
 			current->comm, &vaf, gfp_mask, &gfp_mask,
 			nodemask_pr_args(nodemask));
 	va_end(args);
 
 	cpuset_print_current_mems_allowed();
-
+	pr_cont("\n");
 	dump_stack();
 	warn_alloc_show_mem(gfp_mask, nodemask);
 }
-- 
2.14.1


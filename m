Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8939ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1C220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQuIFQ+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1C220C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGQLiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:38:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42127 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbeGQLiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:38:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id f4-v6so307386plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZdyFYavJmcZk9bMPt4b76/bdG3TwmXm1wHCXCeqIC3o=;
        b=WQuIFQ+aEIG7LlQ3f9l+wn9Msg2vzzVdv8SfEyXhx4ml+4eGR0cWALelnjiWqf7teO
         uNO5WgwiR54RRstuvRjmD2P0twN9Zn+h+B/ZCgSdvK+rQn1xTiDkPyFfZcw9yAYTunmi
         zXxigOCyEDUy8nW9jCh/tEiEYvhIDT/Tk+5SWv20gzXH2H8rZfT9zVkzuem5txvAxYI4
         NdVVf1aUM85Dfyp/BMNLUDL0oyoW1KUtjdQYF45V8DB96NTReRSRCSVXZ4ANBmwFlrra
         H7Wl9Sk59qQG9kkpEki7Mxf0fzGUwYk9GQULLkxh9VEY695jy1o5AK+oY4iQy9DRY7+q
         yXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZdyFYavJmcZk9bMPt4b76/bdG3TwmXm1wHCXCeqIC3o=;
        b=pKz53kiz7CLiMdI2izRE622khVv691o/hFQk7icndOaY6dCwCjhGm5iX4fpwTuFDNy
         WIUU5ZlV67LX5P8q+jDIE9C5n8QfT97XXfKPM+H+iyqQq1gAImpQXWfyXSxD78c1GwWN
         lApcusLCfT2d6hGViwor/V0BRx//2AlPHqrl7q/vgKuUdoSeBlygPPJIIxOF7zje5vHr
         Zskqism03J5zRwaYZMdCiVJo3uFwbJO3obSFTjUa2EnCeeGwKUuasSYGwq9aNyPryibo
         jEywx2yj/RkvffluDxq3n5js7ASXobL+6CsUy6P7QJ0gINjbMYAWU3ZyjwIiE7OQFMIa
         AwzQ==
X-Gm-Message-State: AOUpUlHIM9Oy0CxPXJ+L8AxO8GerVrEyZk0K3lEurMBN39gdo2nt9jUv
        +BFzbc+GW7R4oqVokGV4G1L3SQ==
X-Google-Smtp-Source: AAOMgpdeV5qsoE1o9nWF/D72Y1OCoPDqyQ45lvx8tHrj/jGz+NWHuqhtksES9EtYB7DOFL/JOa0jiQ==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3-v6mr1163737plo.111.1531825561357;
        Tue, 17 Jul 2018 04:06:01 -0700 (PDT)
Received: from dest.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id y12-v6sm1371324pfe.139.2018.07.17.04.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 04:06:00 -0700 (PDT)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v14 1/2] Reorganize the oom report in dump_header
Date:   Tue, 17 Jul 2018 19:05:47 +0800
Message-Id: <1531825548-27761-1-git-send-email-ufo19890607@gmail.com>
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
	[  131.751307] panic invoked oom-killer: gfp_mask=0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0

2) OOM stack trace
	[  131.752399] CPU: 16 PID: 8581 Comm: panic Not tainted 4.18.0-rc5+ #48
	[  131.753154] Hardware name: Inspur SA5212M4/YZMB-00370-107, BIOS 4.1.10 11/14/2016
	[  131.753806] Call Trace:
	[  131.754473]  dump_stack+0x5a/0x73
	[  131.755129]  dump_header+0x53/0x2dc
	[  131.755775]  oom_kill_process+0x228/0x420
	[  131.756430]  ? oom_badness+0x2a/0x130
	[  131.757063]  out_of_memory+0x11a/0x4a0
	[  131.757710]  __alloc_pages_slowpath+0x7cc/0xa1e
	[  131.758392]  ? apic_timer_interrupt+0xa/0x20
	[  131.759040]  __alloc_pages_nodemask+0x277/0x290
	[  131.759710]  alloc_pages_vma+0x73/0x180
	[  131.760388]  do_anonymous_page+0xed/0x5a0
	[  131.761067]  __handle_mm_fault+0xbb3/0xe70
	[  131.761749]  handle_mm_fault+0xfa/0x210
	[  131.762457]  __do_page_fault+0x233/0x4c0
	[  131.763136]  do_page_fault+0x32/0x140
	[  131.763832]  ? page_fault+0x8/0x30
	[  131.764523]  page_fault+0x1e/0x30

3) oom context (contrains and the chosen victim).
	[  131.771164] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,task=panic,pid=8608,uid=0

An admin can easily get the full oom context at a single line which
makes parsing much easier.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
Changes since v13:
- remove the spaces for printing pid and uid.

Changes since v12:
- print the cpuset and memory allocation information after oom victim comm, pid.

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
 mm/oom_kill.c          | 37 +++++++++++++++++++++----------------
 mm/page_alloc.c        |  4 ++--
 4 files changed, 35 insertions(+), 20 deletions(-)

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
index 266f10cb7222..9510a5b32eaf 100644
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
index 84081e77bc51..4e18b69fd464 100644
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
@@ -421,15 +421,21 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 
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
+	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
+			oom_constraint_text[oc->constraint],
+			nodemask_pr_args(oc->nodemask));
+	cpuset_print_current_mems_allowed();
+	pr_cont(",task=%s,pid=%d,uid=%d\n", p->comm, p->pid,
+		from_kuid(&init_user_ns, task_uid(p)));
 	if (is_memcg_oom(oc))
 		mem_cgroup_print_oom_info(oc->memcg, p);
 	else {
@@ -973,8 +979,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 /*
  * Determines whether the kernel must panic because of the panic_on_oom sysctl.
  */
-static void check_panic_on_oom(struct oom_control *oc,
-			       enum oom_constraint constraint)
+static void check_panic_on_oom(struct oom_control *oc)
 {
 	if (likely(!sysctl_panic_on_oom))
 		return;
@@ -984,7 +989,7 @@ static void check_panic_on_oom(struct oom_control *oc,
 		 * does not panic for cpuset, mempolicy, or memcg allocation
 		 * failures.
 		 */
-		if (constraint != CONSTRAINT_NONE)
+		if (oc->constraint != CONSTRAINT_NONE)
 			return;
 	}
 	/* Do not panic for oom kills triggered by sysrq */
@@ -1021,8 +1026,8 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed = 0;
-	enum oom_constraint constraint = CONSTRAINT_NONE;
 
+	oc->constraint = CONSTRAINT_NONE;
 	if (oom_killer_disabled)
 		return false;
 
@@ -1057,10 +1062,10 @@ bool out_of_memory(struct oom_control *oc)
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
index a790ef4be74e..892f51e630c8 100644
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


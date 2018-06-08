Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XoObMIF6GlspfQAAmS7hNA
	; Fri, 08 Jun 2018 12:50:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1238C608BA; Fri,  8 Jun 2018 12:50:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPzzIm7t"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0DDEC607E4;
	Fri,  8 Jun 2018 12:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DDEC607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeFHMuF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:50:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38281 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeFHMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:50:02 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so6357436pgf.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6aUjBf1uxPrOfVFrNQ6efcQuNFTDyZ/lUXkrmm0t7Y0=;
        b=CPzzIm7tRLg+blUH/5FJfxe10dZhFgdZvYIuevNjQZOv7tf3I3U0ghY1mn10xZFsrh
         1I8MkyZjg3Vh88WQngy6ffOpwmQtyag+naaVv983QXyJNhCk6JK5dqGq+B4nYGdNkFBI
         8P2RQrzoHCIaGb1HAJMkFRBtLqD/HvJ6L6Wm2xzsvFovAEcKZWz3mLM2joIvXMcLYj6U
         H9vslvd+EDgR+YYj8jxvT9MNWLNH5KeCG3b/WMxE4xVyqTzZc4v5OO60Tk0JxIAxvVuR
         0iw/DJKxvzlwwfv0FrHblBFTgqi2iiIcsTXdA8RcNKXHwK0T8vToKq/FxVkQ7ASvSuGZ
         pgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6aUjBf1uxPrOfVFrNQ6efcQuNFTDyZ/lUXkrmm0t7Y0=;
        b=cxuO0ekom/LQtEA9V3gZzfKme0EMcdyLyC3C9mtxituf4hq6W5pffjRhFx5a20wuCp
         coBiN0a4XoEbypy57lAa8OlEbavFbBJyt/xL+xbcDSCdZpAlkq9gHF1L96P23ZY/mfgr
         OQ/UEsRJkIpZrPvaNztGsQh2iMqrMoFxSyEgPvhhEpJ8744gfvTjZVrlvo5ioRxnx4Kh
         0QCznNba32IqLApviEOJfxh040t2fF/Wmk0uBxZHQKKplQ6IPI0EcFcTUZ2kuJ8B5N/H
         RTonodtJF+G3bOy7d0P4lptWxOUeeFhElSxEgxEndha1zzaZLB5z/5hRja/r0NctJku+
         WaDQ==
X-Gm-Message-State: APt69E3AXsrnlCLKOPmXBCNu5TIiWAUsrio70e7zhVbJUHaqBhlvpbcG
        jTPBeI+NpQVmD8Pec/hIUeY=
X-Google-Smtp-Source: ADUXVKKmDckw3GSwwyC4nL69xh3JaZnQZ5VOk4qCaOHl+5E11LlOZRmtQ3bfVq9CsJTj/Ds777E+OA==
X-Received: by 2002:a63:7a03:: with SMTP id v3-v6mr5083232pgc.285.1528462201316;
        Fri, 08 Jun 2018 05:50:01 -0700 (PDT)
Received: from dest.didichuxing.com ([13.94.31.177])
        by smtp.gmail.com with ESMTPSA id h8-v6sm72530396pgq.56.2018.06.08.05.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 05:50:00 -0700 (PDT)
From: ufo19890607@gmail.com
To: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, yuzhoujian@didichuxing.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH v8 1/1] Refactor part of the oom report in dump_header
Date: Fri,  8 Jun 2018 20:49:38 +0800
Message-Id: <1528462178-29250-2-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1528462178-29250-1-git-send-email-ufo19890607@gmail.com>
References: <1528462178-29250-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ufo19890607 <ufo19890607@gmail.com>

The dump_header does not print the memcg's name when the system
oom happened, so users cannot locate the certain container which
contains the task that has been killed by the oom killer.

I follow the advices of David Rientjes and Michal Hocko, and refactor
part of the oom report. After this patch, users can get the memcg's 
path from the oom report and check the certain container more quickly.

Below is the part of the oom report in the dmesg
...
[  142.158316] panic cpuset=/ mems_allowed=0-1
[  142.158983] CPU: 15 PID: 8682 Comm: panic Not tainted 4.17.0-rc6+ #13
[  142.159659] Hardware name: Inspur SA5212M4/YZMB-00370-107, BIOS 4.1.10 11/14/2016
[  142.160342] Call Trace:
[  142.161037]  dump_stack+0x78/0xb3
[  142.161734]  dump_header+0x7d/0x334
[  142.162433]  oom_kill_process+0x228/0x490
[  142.163126]  ? oom_badness+0x2a/0x130
[  142.163821]  out_of_memory+0xf0/0x280
[  142.164532]  __alloc_pages_slowpath+0x711/0xa07
[  142.165241]  __alloc_pages_nodemask+0x23f/0x260
[  142.165947]  alloc_pages_vma+0x73/0x180
[  142.166665]  do_anonymous_page+0xed/0x4e0
[  142.167388]  __handle_mm_fault+0xbd2/0xe00
[  142.168114]  handle_mm_fault+0x116/0x250
[  142.168841]  __do_page_fault+0x233/0x4d0
[  142.169567]  do_page_fault+0x32/0x130
[  142.170303]  ? page_fault+0x8/0x30
[  142.171036]  page_fault+0x1e/0x30
[  142.171764] RIP: 0033:0x7f403000a860
[  142.172517] RSP: 002b:00007ffc9f745c28 EFLAGS: 00010206
[  142.173268] RAX: 00007f3f6fd7d000 RBX: 0000000000000000 RCX: 00007f3f7f5cd000
[  142.174040] RDX: 00007f3fafd7d000 RSI: 0000000000000000 RDI: 00007f3f6fd7d000
[  142.174806] RBP: 00007ffc9f745c50 R08: ffffffffffffffff R09: 0000000000000000
[  142.175623] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000400490
[  142.176542] R13: 00007ffc9f745d30 R14: 0000000000000000 R15: 0000000000000000
[  142.177709] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),origin_memcg=(null),kill_memcg=/test/test1/test2,task=panic,pid= 8622,uid=    0
...

Changes since v7:
- add the constraint parameter to dump_header and oom_kill_process.
- remove the static char array in the mem_cgroup_print_oom_context, and
invoke pr_cont_cgroup_path to print memcg' name.
- combine the patchset v6 into one.

Changes since v6:
- divide the patch v5 into two parts. One part is to add an array of const char and
put enum oom_constraint into the memcontrol.h; the other is will refactor the output
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

Signed-off-by: ufo19890607 <ufo19890607@gmail.com>
---
 include/linux/memcontrol.h | 29 ++++++++++++++++++++++++++---
 mm/memcontrol.c            | 43 ++++++++++++++++++++++++++++++++-----------
 mm/oom_kill.c              | 26 +++++++++++---------------
 3 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4f52ec755725..034c0db2623d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -70,6 +70,20 @@ struct mem_cgroup_reclaim_cookie {
 	unsigned int generation;
 };
 
+enum oom_constraint {
+	CONSTRAINT_NONE,
+	CONSTRAINT_CPUSET,
+	CONSTRAINT_MEMORY_POLICY,
+	CONSTRAINT_MEMCG,
+};
+
+static const char * const oom_constraint_text[] = {
+	[CONSTRAINT_NONE] = "CONSTRAINT_NONE",
+	[CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
+	[CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
+	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
+};
+
 #ifdef CONFIG_MEMCG
 
 #define MEM_CGROUP_ID_SHIFT	16
@@ -490,8 +504,11 @@ void mem_cgroup_handle_over_high(void);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
-				struct task_struct *p);
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
+		struct task_struct *p, enum oom_constraint constraint,
+		nodemask_t *nodemask);
+
+void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
 
 static inline void mem_cgroup_oom_enable(void)
 {
@@ -885,7 +902,13 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 }
 
 static inline void
-mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
+mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p,
+			enum oom_constraint constraint, nodemask_t *nodemask)
+{
+}
+
+static inline void
+mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1e64d60ed02..bb5a16bf7fe2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1119,32 +1119,53 @@ static const char *const memcg1_stat_names[] = {
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
 /**
- * mem_cgroup_print_oom_info: Print OOM information relevant to memory controller.
- * @memcg: The memory cgroup that went over limit
+ * mem_cgroup_print_oom_context: Print OOM context information relevant to
+ * memory controller, which includes allocation constraint, nodemask, origin
+ * memcg that has reached its limit, kill memcg that contains the killed
+ * process, killed process's command, pid and uid.
+ * @memcg: The origin memory cgroup that went over limit
  * @p: Task that is going to be killed
+ * @constraint: The allocation constraint
+ * @nodemask: The allocation nodemask
  *
  * NOTE: @memcg and @p's mem_cgroup can be different when hierarchy is
  * enabled
  */
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p,
+		enum oom_constraint constraint, nodemask_t *nodemask)
 {
-	struct mem_cgroup *iter;
-	unsigned int i;
+	struct cgroup *origin_cgrp, *kill_cgrp;
 
 	rcu_read_lock();
 
+	pr_info("oom-kill:constraint=%s,nodemask=%*pbl,origin_memcg=",
+	    oom_constraint_text[constraint], nodemask_pr_args(nodemask));
+
+	if (memcg)
+		pr_cont_cgroup_path(memcg->css.cgroup);
+	else
+		pr_cont("(null)");
+
 	if (p) {
-		pr_info("Task in ");
+		pr_cont(",kill_memcg=");
 		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
-		pr_cont(" killed as a result of limit of ");
-	} else {
-		pr_info("Memory limit reached of cgroup ");
+		pr_cont(",task=%s,pid=%5d,uid=%5d",
+		    p->comm, p->pid, from_kuid(&init_user_ns, task_uid(p)));
 	}
-
-	pr_cont_cgroup_path(memcg->css.cgroup);
 	pr_cont("\n");
 
 	rcu_read_unlock();
+}
+
+/**
+ * mem_cgroup_print_oom_info: Print OOM memory information relevant to
+ * memory controller.
+ * @memcg: The memory cgroup that went over limit
+ */
+void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+	unsigned int i;
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->memory)),
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 6694348b27e9..c4744e2ecd65 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -237,13 +237,6 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
 	return points > 0 ? points : 1;
 }
 
-enum oom_constraint {
-	CONSTRAINT_NONE,
-	CONSTRAINT_CPUSET,
-	CONSTRAINT_MEMORY_POLICY,
-	CONSTRAINT_MEMCG,
-};
-
 /*
  * Determine the type of allocation constraint.
  */
@@ -419,7 +412,8 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 	rcu_read_unlock();
 }
 
-static void dump_header(struct oom_control *oc, struct task_struct *p)
+static void dump_header(struct oom_control *oc, struct task_struct *p,
+		enum oom_constraint constraint)
 {
 	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n",
 		current->comm, oc->gfp_mask, &oc->gfp_mask,
@@ -430,8 +424,9 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 
 	cpuset_print_current_mems_allowed();
 	dump_stack();
+	mem_cgroup_print_oom_context(oc->memcg, p, constraint, oc->nodemask);
 	if (is_memcg_oom(oc))
-		mem_cgroup_print_oom_info(oc->memcg, p);
+		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
@@ -835,7 +830,8 @@ static bool task_will_free_mem(struct task_struct *task)
 	return ret;
 }
 
-static void oom_kill_process(struct oom_control *oc, const char *message)
+static void oom_kill_process(struct oom_control *oc, enum oom_constraint constraint,
+		const char *message)
 {
 	struct task_struct *p = oc->chosen;
 	unsigned int points = oc->chosen_points;
@@ -864,7 +860,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	task_unlock(p);
 
 	if (__ratelimit(&oom_rs))
-		dump_header(oc, p);
+		dump_header(oc, p, constraint);
 
 	pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
 		message, task_pid_nr(p), p->comm, points);
@@ -990,7 +986,7 @@ static void check_panic_on_oom(struct oom_control *oc,
 	/* Do not panic for oom kills triggered by sysrq */
 	if (is_sysrq_oom(oc))
 		return;
-	dump_header(oc, NULL);
+	dump_header(oc, NULL, constraint);
 	panic("Out of memory: %s panic_on_oom is enabled\n",
 		sysctl_panic_on_oom == 2 ? "compulsory" : "system-wide");
 }
@@ -1067,18 +1063,18 @@ bool out_of_memory(struct oom_control *oc)
 	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
 		get_task_struct(current);
 		oc->chosen = current;
-		oom_kill_process(oc, "Out of memory (oom_kill_allocating_task)");
+		oom_kill_process(oc, constraint, "Out of memory (oom_kill_allocating_task)");
 		return true;
 	}
 
 	select_bad_process(oc);
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
-		dump_header(oc, NULL);
+		dump_header(oc, NULL, constraint);
 		panic("Out of memory and no killable processes...\n");
 	}
 	if (oc->chosen && oc->chosen != (void *)-1UL) {
-		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
+		oom_kill_process(oc, constraint, !is_memcg_oom(oc) ? "Out of memory" :
 				 "Memory cgroup out of memory");
 		/*
 		 * Give the killed process a good chance to exit before trying
-- 
2.14.1

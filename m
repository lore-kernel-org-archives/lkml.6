Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5933FC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB93520897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="NrBxwEr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB93520897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeH1VQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:16:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40571 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeH1VQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:16:18 -0400
Received: by mail-yb0-f193.google.com with SMTP id f4-v6so898477ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n0TG+nvGzK++u9l0wi0N7XTfSpc/rPU78L+tO2mOeyI=;
        b=NrBxwEr/3IEvJyyyBQVGfMzRTknogbIfTXQAwsMfkkv1/+YBfY2MvsTEteRXHcyXTW
         kXXLnTFLXd4oV8JErR4UyYPbNvGe7mt0Yqt8GVz6ahO9KLLVloQaccxOujHP+HfFOppm
         cO6+1vYcA+QVqxDcQE7oGv87vauxzE/MZkC6fv4Tm4tuOlgOHB5Qm3xU1cMmIc5ZSN35
         /muhhCz51qC+HKwYCY+y1YXKonbJI6t2U+P9/E8hoBPiCd2N1VlH0U9/fbMyrW+/z2yS
         IoY0IzvWV6xRZ1KALO72GIMvIuIXavdv3vffRf0lDTDcTENvcRrFVMSiO2S96UejBG1d
         h1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n0TG+nvGzK++u9l0wi0N7XTfSpc/rPU78L+tO2mOeyI=;
        b=WastgtfiLthnrLPyNTwZuSACg0cvolbOUz7PzbsW0tFJadZm8P8NP5GZ+s2oKGJJNB
         ur2yvkdkWKj9e+08yN5Ls2yc2bO/iXug+AUqNB5N19t7uxF6wG59ArXekm0nGKoqpY0J
         XBvQw8wU0T2Zo2voXKQAuq9Ber/vIavcH/n3FnbyC0Aq2Fn2M47mcq87b19qfGMOSYQL
         AUKgyGCZ8pFasOOxe/K7vGPQ981w31S8SqevoKX34vQBilPs8YpRWmY7N965aFe4DtL2
         +H+uuAaJ9daTq/JxBbkFcDI5i6yG3lXzIAHBjoWM8RmF8TGysvO+7x1Uk4MxLNoSl25S
         0yJA==
X-Gm-Message-State: APzg51AUEb22ktGOTBJmpLK0BglyrYi/4eVHNZXHfGn1t+UT42ZU0fDl
        erSUvXI0U023IfZ0dw5ZKsTALQ==
X-Google-Smtp-Source: ANB0VdbU7J2KdBp3Grug8sFQOT0N30S9S/mghQQP7rROSAAQGDVyCMm4VZa922llHuxPV6wUAae88w==
X-Received: by 2002:a25:61d5:: with SMTP id v204-v6mr1364177ybb.97.1535477017722;
        Tue, 28 Aug 2018 10:23:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:de86])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1521496ywt.105.2018.08.28.10.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 10:23:36 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 9/9] psi: cgroup support
Date:   Tue, 28 Aug 2018 13:22:58 -0400
Message-Id: <20180828172258.3185-10-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828172258.3185-1-hannes@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system that executes multiple cgrouped jobs and independent
workloads, we don't just care about the health of the overall system,
but also that of individual jobs, so that we can ensure individual job
health, fairness between jobs, or prioritize some jobs over others.

This patch implements pressure stall tracking for cgroups. In kernels
with CONFIG_PSI=y, cgroup2 groups will have cpu.pressure,
memory.pressure, and io.pressure files that track aggregate pressure
stall times for only the tasks inside the cgroup.

v3:
- fix copy-paste indentation screwups

v4:
- propagate psi_disabled checks outward
- factor out iterate_groups()

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/accounting/psi.txt        |   9 ++
 Documentation/admin-guide/cgroup-v2.rst |  18 ++++
 include/linux/cgroup-defs.h             |   4 +
 include/linux/cgroup.h                  |  15 +++
 include/linux/psi.h                     |  25 +++++
 init/Kconfig                            |   4 +
 kernel/cgroup/cgroup.c                  |  45 ++++++++-
 kernel/sched/psi.c                      | 118 ++++++++++++++++++++++--
 8 files changed, 228 insertions(+), 10 deletions(-)

diff --git a/Documentation/accounting/psi.txt b/Documentation/accounting/psi.txt
index 51e7ef14142e..e051810d5127 100644
--- a/Documentation/accounting/psi.txt
+++ b/Documentation/accounting/psi.txt
@@ -62,3 +62,12 @@ well as medium and long term trends. The total absolute stall time is
 tracked and exported as well, to allow detection of latency spikes
 which wouldn't necessarily make a dent in the time averages, or to
 average trends over custom time frames.
+
+Cgroup2 interface
+=================
+
+In a system with a CONFIG_CGROUP=y kernel and the cgroup2 filesystem
+mounted, pressure stall information is also tracked for tasks grouped
+into cgroups. Each subdirectory in the cgroupfs mountpoint contains
+cpu.pressure, memory.pressure, and io.pressure files; the format is
+the same as the /proc/pressure/ files.
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8a2c52d5c53b..02cb308ea400 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -963,6 +963,12 @@ All time durations are in microseconds.
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
 
+  cpu.pressure
+	A read-only nested-key file which exists on non-root cgroups.
+
+	Shows pressure stall information for CPU. See
+	Documentation/accounting/psi.txt for details.
+
 
 Memory
 ------
@@ -1250,6 +1256,12 @@ PAGE_SIZE multiple when read back.
 	higher than the limit for an extended period of time.  This
 	reduces the impact on the workload and memory management.
 
+  memory.pressure
+	A read-only nested-key file which exists on non-root cgroups.
+
+	Shows pressure stall information for memory. See
+	Documentation/accounting/psi.txt for details.
+
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
@@ -1385,6 +1397,12 @@ IO Interface Files
 
 	  8:16 rbps=2097152 wbps=max riops=max wiops=max
 
+  io.pressure
+	A read-only nested-key file which exists on non-root cgroups.
+
+	Shows pressure stall information for IO. See
+	Documentation/accounting/psi.txt for details.
+
 
 Writeback
 ~~~~~~~~~
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c0e68f903011..f4be871ca169 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -20,6 +20,7 @@
 #include <linux/u64_stats_sync.h>
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/psi_types.h>
 
 #ifdef CONFIG_CGROUPS
 
@@ -435,6 +436,9 @@ struct cgroup {
 	/* used to schedule release agent */
 	struct work_struct release_agent_work;
 
+	/* used to track pressure stalls */
+	struct psi_group psi;
+
 	/* used to store eBPF programs */
 	struct cgroup_bpf bpf;
 
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c9fdf6f57913..7b667a89704b 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -627,6 +627,11 @@ static inline void pr_cont_cgroup_path(struct cgroup *cgrp)
 	pr_cont_kernfs_path(cgrp->kn);
 }
 
+static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
+{
+	return &cgrp->psi;
+}
+
 static inline void cgroup_init_kthreadd(void)
 {
 	/*
@@ -680,6 +685,16 @@ static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
 	return NULL;
 }
 
+static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
+{
+	return NULL;
+}
+
+static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
+{
+	return NULL;
+}
+
 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 					       struct cgroup *ancestor)
 {
diff --git a/include/linux/psi.h b/include/linux/psi.h
index b0daf050de58..8e0725aac0aa 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -4,6 +4,9 @@
 #include <linux/psi_types.h>
 #include <linux/sched.h>
 
+struct seq_file;
+struct css_set;
+
 #ifdef CONFIG_PSI
 
 extern bool psi_disabled;
@@ -16,6 +19,14 @@ void psi_memstall_tick(struct task_struct *task, int cpu);
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
+int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
+
+#ifdef CONFIG_CGROUPS
+int psi_cgroup_alloc(struct cgroup *cgrp);
+void psi_cgroup_free(struct cgroup *cgrp);
+void cgroup_move_task(struct task_struct *p, struct css_set *to);
+#endif
+
 #else /* CONFIG_PSI */
 
 static inline void psi_init(void) {}
@@ -23,6 +34,20 @@ static inline void psi_init(void) {}
 static inline void psi_memstall_enter(unsigned long *flags) {}
 static inline void psi_memstall_leave(unsigned long *flags) {}
 
+#ifdef CONFIG_CGROUPS
+static inline int psi_cgroup_alloc(struct cgroup *cgrp)
+{
+	return 0;
+}
+static inline void psi_cgroup_free(struct cgroup *cgrp)
+{
+}
+static inline void cgroup_move_task(struct task_struct *p, struct css_set *to)
+{
+	rcu_assign_pointer(p->cgroups, to);
+}
+#endif
+
 #endif /* CONFIG_PSI */
 
 #endif /* _LINUX_PSI_H */
diff --git a/init/Kconfig b/init/Kconfig
index 98d59bc268df..7506dcd81d1c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -466,6 +466,10 @@ config PSI
 	  the share of walltime in which some or all tasks in the system are
 	  delayed due to contention of the respective resource.
 
+	  In kernels with cgroup support, cgroups (cgroup2 only) will
+	  have cpu.pressure, memory.pressure, and io.pressure files,
+	  which aggregate pressure stalls for the grouped tasks only.
+
 	  For more details see Documentation/accounting/psi.txt.
 
 	  Say N if unsure.
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 077370bf8964..ba7d3e1e3970 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -55,6 +55,7 @@
 #include <linux/nsproxy.h>
 #include <linux/file.h>
 #include <linux/sched/cputime.h>
+#include <linux/psi.h>
 #include <net/sock.h>
 
 #define CREATE_TRACE_POINTS
@@ -829,7 +830,7 @@ static void css_set_move_task(struct task_struct *task,
 		 */
 		WARN_ON_ONCE(task->flags & PF_EXITING);
 
-		rcu_assign_pointer(task->cgroups, to_cset);
+		cgroup_move_task(task, to_cset);
 		list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg_tasks :
 							     &to_cset->tasks);
 	}
@@ -3406,6 +3407,21 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
+#ifdef CONFIG_PSI
+static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
+{
+	return psi_show(seq, &seq_css(seq)->cgroup->psi, PSI_IO);
+}
+static int cgroup_memory_pressure_show(struct seq_file *seq, void *v)
+{
+	return psi_show(seq, &seq_css(seq)->cgroup->psi, PSI_MEM);
+}
+static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
+{
+	return psi_show(seq, &seq_css(seq)->cgroup->psi, PSI_CPU);
+}
+#endif
+
 static int cgroup_file_open(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of->kn->priv;
@@ -4534,6 +4550,23 @@ static struct cftype cgroup_base_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_stat_show,
 	},
+#ifdef CONFIG_PSI
+	{
+		.name = "io.pressure",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cgroup_io_pressure_show,
+	},
+	{
+		.name = "memory.pressure",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cgroup_memory_pressure_show,
+	},
+	{
+		.name = "cpu.pressure",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cgroup_cpu_pressure_show,
+	},
+#endif
 	{ }	/* terminate */
 };
 
@@ -4594,6 +4627,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			 */
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
+			psi_cgroup_free(cgrp);
 			if (cgroup_on_dfl(cgrp))
 				cgroup_rstat_exit(cgrp);
 			kfree(cgrp);
@@ -4850,10 +4884,15 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	cgrp->self.parent = &parent->self;
 	cgrp->root = root;
 	cgrp->level = level;
-	ret = cgroup_bpf_inherit(cgrp);
+
+	ret = psi_cgroup_alloc(cgrp);
 	if (ret)
 		goto out_idr_free;
 
+	ret = cgroup_bpf_inherit(cgrp);
+	if (ret)
+		goto out_psi_free;
+
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		cgrp->ancestor_ids[tcgrp->level] = tcgrp->id;
 
@@ -4891,6 +4930,8 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 
 	return cgrp;
 
+out_psi_free:
+	psi_cgroup_free(cgrp);
 out_idr_free:
 	cgroup_idr_remove(&root->cgroup_idr, cgrp->id);
 out_stat_exit:
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 92489e66840b..84127de49193 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -466,9 +466,35 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		schedule_delayed_work(&group->clock_work, PSI_FREQ);
 }
 
+static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+{
+#ifdef CONFIG_CGROUPS
+	struct cgroup *cgroup = NULL;
+
+	if (!*iter)
+		cgroup = task->cgroups->dfl_cgrp;
+	else if (*iter == &psi_system)
+		return NULL;
+	else
+		cgroup = cgroup_parent(*iter);
+
+	if (cgroup && cgroup_parent(cgroup)) {
+		*iter = cgroup;
+		return cgroup_psi(cgroup);
+	}
+#else
+	if (*iter)
+		return NULL;
+#endif
+	*iter = &psi_system;
+	return &psi_system;
+}
+
 void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
+	struct psi_group *group;
+	void *iter = NULL;
 
 	if (!task->pid)
 		return;
@@ -485,17 +511,23 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	task->psi_flags &= ~clear;
 	task->psi_flags |= set;
 
-	psi_group_change(&psi_system, cpu, clear, set);
+	while ((group = iterate_groups(task, &iter)))
+		psi_group_change(group, cpu, clear, set);
 }
 
 void psi_memstall_tick(struct task_struct *task, int cpu)
 {
-	struct psi_group_cpu *groupc;
+	struct psi_group *group;
+	void *iter = NULL;
 
-	groupc = per_cpu_ptr(psi_system.pcpu, cpu);
-	write_seqcount_begin(&groupc->seq);
-	record_times(groupc, cpu, true);
-	write_seqcount_end(&groupc->seq);
+	while ((group = iterate_groups(task, &iter))) {
+		struct psi_group_cpu *groupc;
+
+		groupc = per_cpu_ptr(group->pcpu, cpu);
+		write_seqcount_begin(&groupc->seq);
+		record_times(groupc, cpu, true);
+		write_seqcount_end(&groupc->seq);
+	}
 }
 
 /**
@@ -558,8 +590,78 @@ void psi_memstall_leave(unsigned long *flags)
 	rq_unlock_irq(rq, &rf);
 }
 
-static int psi_show(struct seq_file *m, struct psi_group *group,
-		    enum psi_res res)
+#ifdef CONFIG_CGROUPS
+int psi_cgroup_alloc(struct cgroup *cgroup)
+{
+	if (psi_disabled)
+		return 0;
+
+	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
+	if (!cgroup->psi.pcpu)
+		return -ENOMEM;
+	group_init(&cgroup->psi);
+	return 0;
+}
+
+void psi_cgroup_free(struct cgroup *cgroup)
+{
+	if (psi_disabled)
+		return;
+
+	cancel_delayed_work_sync(&cgroup->psi.clock_work);
+	free_percpu(cgroup->psi.pcpu);
+}
+
+/**
+ * cgroup_move_task - move task to a different cgroup
+ * @task: the task
+ * @to: the target css_set
+ *
+ * Move task to a new cgroup and safely migrate its associated stall
+ * state between the different groups.
+ *
+ * This function acquires the task's rq lock to lock out concurrent
+ * changes to the task's scheduling state and - in case the task is
+ * running - concurrent changes to its stall state.
+ */
+void cgroup_move_task(struct task_struct *task, struct css_set *to)
+{
+	bool move_psi = !psi_disabled;
+	unsigned int task_flags = 0;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (move_psi) {
+		rq = task_rq_lock(task, &rf);
+
+		if (task_on_rq_queued(task))
+			task_flags = TSK_RUNNING;
+		else if (task->in_iowait)
+			task_flags = TSK_IOWAIT;
+
+		if (task->flags & PF_MEMSTALL)
+			task_flags |= TSK_MEMSTALL;
+
+		if (task_flags)
+			psi_task_change(task, task_flags, 0);
+	}
+
+	/*
+	 * Lame to do this here, but the scheduler cannot be locked
+	 * from the outside, so we move cgroups from inside sched/.
+	 */
+	rcu_assign_pointer(task->cgroups, to);
+
+	if (move_psi) {
+		if (task_flags)
+			psi_task_change(task, 0, task_flags);
+
+		task_rq_unlock(rq, task, &rf);
+	}
+}
+#endif /* CONFIG_CGROUPS */
+
+int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
 	int full;
 
-- 
2.18.0


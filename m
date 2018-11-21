Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB73820685
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE+70IAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB73820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbeKUWEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:04:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38555 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbeKUWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:04:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so5146358plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 03:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ylCHwBAJTmPIaOdxe6D4qpf2xk7cxDYmrUoJdcdixoc=;
        b=dE+70IALVpR1aU8LFaUxI3u+s7wupMAQa3upaWdKnXgbxVyFfxyKO//GRnBuegoZ2Y
         RzbauJitgakVMQAezGHkgD+KFKpz1s+CJS2ltSbksoxKCx1wsYd8HAo22mXzK5329dcc
         BiJNqqCZ9X+jZYsetmrUjx1nJdsr5tzxoUlWPyYEljRnCGmuAxQ4fWyVUoG2yjIdQzLu
         BoMW2qY/deUCW2t4y6lqscI2ZDppauzhIAwiNz/DDlTfPXplzT6wnNzvg7L1/a2nZh7n
         UETEshCdL/CxujxniADeidHs34S5/Wg/0do6o98t/J92hGSAcgK0joD2dfjnHImykACG
         Znlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ylCHwBAJTmPIaOdxe6D4qpf2xk7cxDYmrUoJdcdixoc=;
        b=Cz4iIzUII0Wxmic0zGujciUThddVB7zsTONoyc7tR+dYdp4LhUR7MtDSqJN35UiDKS
         LMTiWKURaEfQqLtnpDuviSSk/m1be2RWrR9y63mU32bFrIwnAvemn6QMp5+9tltTysaT
         HdmsIe2guRzrEupxM9iFwoGEz4ia4FtkYvykkATGS7TyFWsuDGA3ABC2ezukyUzVFnLs
         Dlh36ON70zBSiz6+kGXZYjgkyCo6qOlkSVg3yyDMyQIiCaNvZQdPAh/WMNPWGljWOCv3
         LQagBz4yWXUhVUElzADpslA5V9gaV1aYIOXlsy+3WBZ7YsNzZEG1onAYFlptD00lz13r
         e/0w==
X-Gm-Message-State: AA+aEWaVywVHgbFss2SN4xhGjvBjy2n5FjwaTdxxEIOzSUNtINjKyUeV
        1a2+xBbW7nxRI66ncu4cIdI=
X-Google-Smtp-Source: AFSGD/X350H88Q9Ed+EhlgoJgCIhKwnZEyF/GbEwylyRO1QpNSss3ZPhNMQ3CMjm2TM68Mw5R/gfqA==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr5569991pgi.217.1542799817296;
        Wed, 21 Nov 2018 03:30:17 -0800 (PST)
Received: from dest.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id t13sm90753952pgr.42.2018.11.21.03.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:30:16 -0800 (PST)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v15 2/2] Add oom victim's memcg to the oom context information
Date:   Wed, 21 Nov 2018 19:29:59 +0800
Message-Id: <1542799799-36184-2-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1542799799-36184-1-git-send-email-ufo19890607@gmail.com>
References: <1542799799-36184-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

The current oom report doesn't display victim's memcg context during the
global OOM situation. While this information is not strictly needed, it
can be really helpful for containerized environments to locate which
container has lost a process. Now that we have a single line for the oom
context, we can trivially add both the oom memcg (this can be either
global_oom or a specific memcg which hits its hard limits) and task_memcg
which is the victim's memcg.

Below is the single line output in the oom report after this patch.
- global oom context information:
oom-kill:constraint=<constraint>,nodemask=<nodemask>,cpuset=<cpuset>,mems_allowed=<mems_allowed>,global_oom,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>
- memcg oom context information:
oom-kill:constraint=<constraint>,nodemask=<nodemask>,cpuset=<cpuset>,mems_allowed=<mems_allowed>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 include/linux/memcontrol.h | 11 +++++++++--
 mm/memcontrol.c            | 33 ++++++++++++++++++++-------------
 mm/oom_kill.c              |  3 ++-
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7ab2120..83ae11c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -526,9 +526,11 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
 				struct task_struct *p);
 
+void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
+
 static inline void mem_cgroup_enter_user_fault(void)
 {
 	WARN_ON(current->in_user_fault);
@@ -970,7 +972,12 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 }
 
 static inline void
-mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
+mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p)
+{
+}
+
+static inline void
+mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6e1469b..b860dd4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1293,32 +1293,39 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
 /**
- * mem_cgroup_print_oom_info: Print OOM information relevant to memory controller.
+ * mem_cgroup_print_oom_context: Print OOM information relevant to
+ * memory controller.
  * @memcg: The memory cgroup that went over limit
  * @p: Task that is going to be killed
  *
  * NOTE: @memcg and @p's mem_cgroup can be different when hierarchy is
  * enabled
  */
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p)
 {
-	struct mem_cgroup *iter;
-	unsigned int i;
-
 	rcu_read_lock();
 
+	if (memcg) {
+		pr_info(",oom_memcg=");
+		pr_cont_cgroup_path(memcg->css.cgroup);
+	} else
+		pr_info(",global_oom");
 	if (p) {
-		pr_info("Task in ");
+		pr_cont(",task_memcg=");
 		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
-		pr_cont(" killed as a result of limit of ");
-	} else {
-		pr_info("Memory limit reached of cgroup ");
 	}
-
-	pr_cont_cgroup_path(memcg->css.cgroup);
-	pr_cont("\n");
-
 	rcu_read_unlock();
+}
+
+/**
+ * mem_cgroup_print_oom_meminfo: Print OOM memory information relevant to
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
index 2c686d2..6fd1ead 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -435,6 +435,7 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 			oom_constraint_text[oc->constraint],
 			nodemask_pr_args(oc->nodemask));
 	cpuset_print_current_mems_allowed();
+	mem_cgroup_print_oom_context(oc->memcg, victim);
 	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm, victim->pid,
 		from_kuid(&init_user_ns, task_uid(victim)));
 }
@@ -449,7 +450,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 
 	dump_stack();
 	if (is_memcg_oom(oc))
-		mem_cgroup_print_oom_info(oc->memcg, p);
+		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
-- 
1.8.3.1


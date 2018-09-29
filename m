Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B3C64E94
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9378720880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxX8PwFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9378720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI2TfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:35:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39578 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbeI2TfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:35:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so2513524pgv.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7aJM82zfDXbiOcRrgJDAzcz0Qx7Ks6G9pLA2RN6nvQ=;
        b=gxX8PwFcMAxqyFVcN7lJ/A0J6U4xNaGhMLk/c20gNLXdygIJNuYHYL+0bYT/9RbvaF
         0eMP6Zw/4jR+D2tJ9FAga4rnPVshTPnARvrGpIxiiHwEQ3+4VNmkNpK5PE5JoV47pSTd
         GUEJdJOvw7r4pOmo4MuVOsvM0U9pvAoytScu2URJ6JSThb3VAkSUCWt7g9gECL4m0R6k
         +4eWQwNfWwkg9Irotje3aKfyCic2Q4PbgHefFl5rvrYk4uCchqtLmCWwCUZGihaH6K5v
         HfSPxa2ikKj/UOnauYttp0fR3I2aRFPkwyHH6aFdWiizDWFt0lE+XHzx9DnpiHD+I+Mn
         YbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7aJM82zfDXbiOcRrgJDAzcz0Qx7Ks6G9pLA2RN6nvQ=;
        b=Y/y6O3bCJrzW88UfaKyRiSeYvNwtn4up/6bwK5BFpHq22L3MofLeS6Qes9ev0AccNt
         UtdO9e+5Ez4luNKvB+zT1KeeZp9h/og32/JwpdKYLbwO7r7JOshf5CQfaC5rDND3OwGP
         21p5ucjG3llhR7mWhcWMd9Ivdjt8qbUGLYtjme6lyeelAwpsXAYTW219/4m0Xgt7Kohr
         fswXjC5RoL3vD7BTxj9p/S4Yp4Gn4TcPyVROdjIzBI7I8u+tsWzcaGUvfNXnacQ1CggK
         5us3iFR7y5MmlD4lKwqu7uNlfzShUrJ8lMX3PqYKefKBNkcQrxzi8vc+aED1Km5Ty8vU
         iNFw==
X-Gm-Message-State: ABuFfohfkuk8iHBMOmUKSiK9HG8KDwyBK/yf6NleuPzQo+/rvQh6/5nZ
        LcP7K8V3wLtOu55D47BgkBM=
X-Google-Smtp-Source: ACcGV62YU2w79037fKcfAKd1eYixeAwwwSl97N5XwzGHe+i87XbI+Tss5mtL3QJNUffik6EmbD1KZQ==
X-Received: by 2002:a63:525c:: with SMTP id s28-v6mr2899730pgl.78.1538226414064;
        Sat, 29 Sep 2018 06:06:54 -0700 (PDT)
Received: from dest.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p4-v6sm13828267pgs.75.2018.09.29.06.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 06:06:53 -0700 (PDT)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v15 2/2] Add oom victim's memcg to the oom context information
Date:   Sat, 29 Sep 2018 21:06:27 +0800
Message-Id: <1538226387-16600-2-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538226387-16600-1-git-send-email-ufo19890607@gmail.com>
References: <1538226387-16600-1-git-send-email-ufo19890607@gmail.com>
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
 mm/memcontrol.c            | 32 ++++++++++++++++++++------------
 mm/oom_kill.c              |  3 ++-
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 652f602..3adf70a 100644
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
index e79cb59..a7b4ada 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1293,32 +1293,40 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 
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
+		pr_cont(",oom_memcg=");
+		pr_cont_cgroup_path(memcg->css.cgroup);
+	} else
+		pr_cont(",global_oom");
 	if (p) {
-		pr_info("Task in ");
+		pr_cont(",task_memcg=");
 		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
-		pr_cont(" killed as a result of limit of ");
-	} else {
-		pr_info("Memory limit reached of cgroup ");
 	}
 
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
index 0935fca..820bc87 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -438,7 +438,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 
 	dump_stack();
 	if (is_memcg_oom(oc))
-		mem_cgroup_print_oom_info(oc->memcg, p);
+		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
@@ -455,6 +455,7 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 			oom_constraint_text[oc->constraint],
 			nodemask_pr_args(oc->nodemask));
 	cpuset_print_current_mems_allowed();
+	mem_cgroup_print_oom_context(oc->memcg, victim);
 	pr_cont(",task=%s,pid=%d,uid=%d\n", victim->comm, victim->pid,
 		from_kuid(&init_user_ns, task_uid(victim)));
 }
-- 
1.8.3.1


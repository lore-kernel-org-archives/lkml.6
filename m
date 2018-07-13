Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9217B2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD9TmxyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9217B2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeGMMKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:10:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39212 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbeGMMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:10:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id s21-v6so22541008pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iY9vtiCUoNjcIBjXS93SLPG9IVxANB8ZjhPGf1wvAus=;
        b=MD9TmxyS2dy8NaW3NtsgHBLYhFW1s8xB21vKONdou5jH8tsZrTOuQvKq5fbr4UR50r
         IC0HM48WybX2UiVhoY1GH3zX+f94c1YEZVHTmoIVylOu3a9m/gFaofrfQ/NQApZQPh5V
         Uh0149TFFmoqS6Fwp/k/8fuDxnfMafYOHoqD2WQqHirkh00HKrXbXALXaXTcseHejFtg
         m2puR+MysOiwNImeTnSikWdbywZkgrIy0qVPMrCKBloehqGq/ARX1/MBTqcO/uO2ahYh
         A69Z/TKOoTs8Iz6B0DhVdnG9yNhT33357U1Uy8jVLTrc4m7+BrcFgyP8M0Pcvui4ksb9
         L8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iY9vtiCUoNjcIBjXS93SLPG9IVxANB8ZjhPGf1wvAus=;
        b=EfPDtf+aMTlujTxjAHM5CaKQf437UaEEfHULWgHIomlZvi3/vPMYYQCPm/Qe0hC0Ag
         f3V2W4euAcu0YLxc+BPnn2+zmythMlZOTl8QEAis/sEq/vTtuEULPZvcIOcqbla28N1j
         ytCYjfjJoPZRNxNdZSyR4gMhQwO7xks1wb0I7O0Ghz44h2DkwvBHHrE/no3yEEuGjbhT
         t9ZOzHL9e0LoxqlTYhAk0CZmEDg6C+KTAojU0OMbmLfZvr4Dy+FT5C4+zWLKJ0QQs3BJ
         2tH+gnWJZ5F5MugocAiFlmyhjYn9N5LVQJpgnvv/dAfrpkD1MYj9ztBivZHsndz8DzxO
         w0Wg==
X-Gm-Message-State: AOUpUlFke4UKxKE3Rc1X8I73aCnzWml2YummtHg5VOgzwXLni3QAvk35
        MnyXjHG6JoQ/KFEIG8uiH0Y=
X-Google-Smtp-Source: AAOMgpdnUm64OvF+WH0mfMN5fcUDjwOpSU5BSCM5lb3/v3koGuxkKIh0hkFkXlf5GDZfUsSoUoTtcg==
X-Received: by 2002:a65:608c:: with SMTP id t12-v6mr5938950pgu.159.1531482963736;
        Fri, 13 Jul 2018 04:56:03 -0700 (PDT)
Received: from dest.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id z8-v6sm3650447pfe.163.2018.07.13.04.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:56:02 -0700 (PDT)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v13 2/2] Add oom victim's memcg to the oom context information
Date:   Fri, 13 Jul 2018 19:55:52 +0800
Message-Id: <1531482952-4595-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
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
Changes since v12
- print cpuset information before memcg info.

 include/linux/memcontrol.h | 14 +++++++++++---
 mm/memcontrol.c            | 36 ++++++++++++++++++++++--------------
 mm/oom_kill.c              |  3 ++-
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..96a73f989101 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -491,8 +491,10 @@ void mem_cgroup_handle_over_high(void);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
-				struct task_struct *p);
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
+		struct task_struct *p);
+
+void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
 
 static inline void mem_cgroup_oom_enable(void)
 {
@@ -903,7 +905,13 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 }
 
 static inline void
-mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
+mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
+				struct task_struct *p)
+{
+}
+
+static inline void
+mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6f0d5ef320a..18deea974cfd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1119,32 +1119,40 @@ static const char *const memcg1_stat_names[] = {
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
 /**
- * mem_cgroup_print_oom_info: Print OOM information relevant to memory controller.
- * @memcg: The memory cgroup that went over limit
+ * mem_cgroup_print_oom_context: Print OOM context information relevant to
+ * memory controller.
+ * @memcg: The origin memory cgroup that went over limit
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
+	struct cgroup *origin_cgrp, *kill_cgrp;
 
 	rcu_read_lock();
-
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
index 531b2c86d4db..7fbd389ea779 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -434,10 +434,11 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 			oom_constraint_text[oc->constraint],
 			nodemask_pr_args(oc->nodemask));
 	cpuset_print_current_mems_allowed();
+	mem_cgroup_print_oom_context(oc->memcg, p);
 	pr_cont(",task=%s,pid=%5d,uid=%5d\n", p->comm, p->pid,
 		from_kuid(&init_user_ns, task_uid(p)));
 	if (is_memcg_oom(oc))
-		mem_cgroup_print_oom_info(oc->memcg, p);
+		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
-- 
2.14.1


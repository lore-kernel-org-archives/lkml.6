Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3970C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6517024865
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBL+ij0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6517024865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeF3QjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 12:39:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36620 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbeF3QjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 12:39:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so5590883pfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ASszBtraV4O+cPzTqyDB0NneVp9cVHuGuI+Sa1Q5PgI=;
        b=IBL+ij0+qnFX7rmIVvgLcl3L9m5LLYAoBrRz1BDvMzRn8icE91Q16Nh6xU0wiOnCTH
         It8ZHckOuYWP16T7Ipjrelz028wTlqbOcXCDojb9ssoIP3fYX9mWjJaQED2ydhfyKdK/
         8TMBtOkqqDoWoF6gYTAsi2Z0XGAnEIVVhK17alWr1wXtdRkFlC/sXgQY8KCbPaVtSld1
         8JOemaVurxrqNpMv6wlEeQWUwG6yWgpJLXwUFrfzFE6bzBVH8r+K1iTZMgdLYoHpQkyk
         TKP1Y6Kr5+huNvH/khlpaqTxRL8Vu7LQlBiCTQlKJL7BRZobw/WD3i25I0whT0omIDoQ
         g3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ASszBtraV4O+cPzTqyDB0NneVp9cVHuGuI+Sa1Q5PgI=;
        b=gUYODMsz5Y2ux9uorVPm30/YWSrO8aHHPQZ+62pUnjbUJ+Ygyg4N7fdhuKsvo7iBEJ
         yvpGERsC/CvSNUE5IT9IYq5XM2p2oIWiGRqhbeDYiWQYHD/OdIawSeMWneoWfn/HvVFz
         DzePfcZgoF24dh1h0Mi/7L0KK79z6NpDsKtRQkiq337RETu8CL3uF7Yd+KGhpd4By1wN
         +2XVh21O/4BUUkMfA3SSLv0jGxZkYuMZx3HBo9cPdNK9nAivs6jT/3ZNsaai2Re96yc/
         AVtgYQdHcm1OWjqC1d4nITVtBjLOLNNgV2TSvNIe3UWm85x0EV2YsfmxiRlehnN6oi7j
         Cu1Q==
X-Gm-Message-State: APt69E2bzM7wCaaZaPeTjcbkeifwJ/xuK+635GFAAHkpIKP0iUgGFPUt
        CiSRpXGMgLA8iThtjEjBAb8=
X-Google-Smtp-Source: AAOMgpfe5EN+Yi49GQKFutDIkqI0xBoE3237AsUDoyO1dXTC9fNcg1KApcdrkIn0cxXuRe/YsPL18Q==
X-Received: by 2002:a62:569c:: with SMTP id h28-v6mr14895992pfj.201.1530376757084;
        Sat, 30 Jun 2018 09:39:17 -0700 (PDT)
Received: from dest.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id b65-v6sm21473158pfg.34.2018.06.30.09.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 09:39:16 -0700 (PDT)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v11 2/2] Add the missing information in dump_header
Date:   Sun,  1 Jul 2018 00:38:59 +0800
Message-Id: <1530376739-20459-2-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

Add a new func mem_cgroup_print_oom_context to print missing information
for the system-wide oom report which includes the oom memcg that has
reached its limit, task memcg that contains the killed task.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 include/linux/memcontrol.h | 15 ++++++++++++---
 mm/memcontrol.c            | 36 ++++++++++++++++++++++--------------
 mm/oom_kill.c              | 10 ++++++----
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..90855880bca2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -28,6 +28,7 @@
 #include <linux/eventfd.h>
 #include <linux/mm.h>
 #include <linux/vmstat.h>
+#include <linux/oom.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
 
@@ -491,8 +492,10 @@ void mem_cgroup_handle_over_high(void);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
-				struct task_struct *p);
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
+		struct task_struct *p);
+
+void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
 
 static inline void mem_cgroup_oom_enable(void)
 {
@@ -903,7 +906,13 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
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
index f9b08e455fd1..e990c45d2e7d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -424,12 +424,14 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	dump_stack();
 
 	/* one line summary of the oom killer context. */
-	pr_info("oom-kill:constraint=%s,nodemask=%*pbl,task=%s,pid=%5d,uid=%5d",
+	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
 			oom_constraint_text[oc->constraint],
-			nodemask_pr_args(oc->nodemask),
-			p->comm, p->pid, from_kuid(&init_user_ns, task_uid(p)));
+			nodemask_pr_args(oc->nodemask));
+	mem_cgroup_print_oom_context(oc->memcg, p);
+	pr_cont(",task=%s,pid=%5d,uid=%5d\n", p->comm, p->pid,
+			from_kuid(&init_user_ns, task_uid(p)));
 	if (is_memcg_oom(oc))
-		mem_cgroup_print_oom_info(oc->memcg, p);
+		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
-- 
2.14.1


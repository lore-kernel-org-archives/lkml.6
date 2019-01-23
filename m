Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F59C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BDF20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFqb7u3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfAWJrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:47:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44202 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfAWJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:47:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so893870plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cWiVUTF0OwClSBMFB+3K+yYSU4xFabUAUmOW0CNVwr4=;
        b=kFqb7u3V7aVUgjSzC7NFxFBuHXfWy60O9qzmNlMuc5ZJbo4XUqDedjv1czl9pPQUAA
         y7oRu18CWZ77PkDYH9mYBhsP43IR3i5zpU+/GJlmQfwupLeypxZ5/gli3L+pUJjbdSfB
         znhgmTIqamwfQsB/RdBUwE3kBIvmWhHlwVL/K8dkXybwsRAlg3cDH5Qi3FLfr/bBwgi8
         02yTZc129rJBGFl8MgYBQHGQABMgAz0+68NQDFnYpD4DdF84x7ZctRh6JK1KzUxfiZGx
         b43zSLKLVOnfnNSJkJAUX4rS50P0pm9Zg62yq7gM3q5+vTDKOe0nQgzDlBbNtEkzdTF3
         S7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cWiVUTF0OwClSBMFB+3K+yYSU4xFabUAUmOW0CNVwr4=;
        b=Him2t8NJo5s0457Btf+gCSjx6MmWKTUUHlYeHVrdgiyVUvr8J+AMVXXpEvhkTgHFkt
         SZuQW8WVUCqRKY0HfvuLb0MtAQCTFcr+HSfHcd3taPVWa87oFv9Ilv8LoPtOzFVSSEkO
         XVXguZnUl6OQXJlNI/eMahN9PoUHEaZpBlZ4BQBHbr5aowSdnwetc2nS6sf06wPpANQ5
         Yv3/wV2vTkngT51s4HmIMdEyMFGStiHQ0B71rR8+qI0qC5hmt2nNgQcnfITdesaL29kX
         w+w8BlsHCXCf+Dw3ctkGIjQXyZqTtp1nJb4NWRLMGfUvFpsNOychJDrtZ0qSSokgTQu0
         ro/w==
X-Gm-Message-State: AJcUukd5Kzp/a+f3Af1ObRODzQ8Rf4Yr1/ZcPdA8cjvFFiXK/K6omYcZ
        By3C+yjqDIU4xfiqr9RlDIw=
X-Google-Smtp-Source: ALg8bN7jI7zazJa2pi8KKuxkqhWECCVUJxYogqpdwbejEMrcBuCnkYn2YHXGTYETPj6dF54Vgm4S4g==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr1586204plb.52.1548236830764;
        Wed, 23 Jan 2019 01:47:10 -0800 (PST)
Received: from dest.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id u87sm46745521pfi.2.2019.01.23.01.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 01:47:10 -0800 (PST)
From:   ufo19890607@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, yun.wang@linux.alibaba.com,
        yuzhoujian@didichuxing.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/debug: Show intergroup and hierarchy sum wait time of a task group
Date:   Wed, 23 Jan 2019 17:46:56 +0800
Message-Id: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

We can monitor the sum wait time of a task group since 'commit 3d6c50c27bd6
("sched/debug: Show the sum wait time of a task group")'. However this
wait_sum just represents the confilct between different task groups, since
it is simply sum the wait time of task_group's cfs_rq. And we still cannot
evaluate the conflict between all the tasks within hierarchy of this group,
so the hierarchy wait time is still needed.

Thus we introduce hierarchy wait_sum which summarizes the total wait sum of
all the tasks in the hierarchy of a group.

The 'cpu.stat' is modified to show the statistic, like:

	nr_periods 0
	nr_throttled 0
	throttled_time 0
	intergroup wait_sum 2842251984
	hierarchy wait_sum 6389509389332798

From now on we can monitor both the wait_sum of intergroup and hierarchy,
which will inevitably help a system administrator know how intense the CPU
competition is within a task group and between different task groups. We
can calculate the wait rate of a task group based on hierarchy wait_sum and
cpuacct.usage.

For example:
	X% = (current_wait_sum - last_wait_sum) / ((current_usage -
last_usage) + (current_wait_sum - last_wait_sum))

That means the task group paid X percentage of time on runqueue waiting
for the CPU.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 kernel/sched/core.c  | 11 +++++++----
 kernel/sched/fair.c  | 17 +++++++++++++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee77636..172e6fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6760,13 +6760,16 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
 
 	if (schedstat_enabled() && tg != &root_task_group) {
-		u64 ws = 0;
+		u64 inter_ws = 0, hierarchy_ws = 0;
 		int i;
 
-		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+		for_each_possible_cpu(i) {
+			inter_ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+			hierarchy_ws += tg->cfs_rq[i]->hierarchy_wait_sum;
+		}
 
-		seq_printf(sf, "wait_sum %llu\n", ws);
+		seq_printf(sf, "intergroup wait_sum %llu\n", inter_ws);
+		seq_printf(sf, "hierarchy wait_sum %llu\n", hierarchy_ws);
 	}
 
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2ff4b6..35e89ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -858,6 +858,19 @@ static void update_curr_fair(struct rq *rq)
 }
 
 static inline void
+update_hierarchy_wait_sum(struct sched_entity *se,
+			u64 delta_wait)
+{
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		if (cfs_rq->tg != &root_task_group)
+			__schedstat_add(cfs_rq->hierarchy_wait_sum,
+					delta_wait);
+	}
+}
+
+static inline void
 update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	struct task_struct *p;
@@ -880,6 +893,7 @@ static void update_curr_fair(struct rq *rq)
 			return;
 		}
 		trace_sched_stat_wait(p, delta);
+		update_hierarchy_wait_sum(se, delta);
 	}
 
 	__schedstat_set(se->statistics.wait_max,
@@ -10273,6 +10287,9 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifndef CONFIG_64BIT
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
 #endif
+#ifdef CONFIG_SCHEDSTATS
+	cfs_rq->hierarchy_wait_sum = 0;
+#endif
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d27c1a5..c01ab99 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -496,6 +496,9 @@ struct cfs_rq {
 #ifndef CONFIG_64BIT
 	u64			min_vruntime_copy;
 #endif
+#ifdef CONFIG_SCHEDSTATS
+	u64			hierarchy_wait_sum;
+#endif
 
 	struct rb_root_cached	tasks_timeline;
 
-- 
1.8.3.1


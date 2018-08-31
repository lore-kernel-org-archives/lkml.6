Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8EAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37312083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orPO+qf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37312083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeHaF7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:33 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43322 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeHaF7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id l189-v6so4517084ywb.10;
        Thu, 30 Aug 2018 18:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RK66jqDs7zDL0RJHQV7q3eA8Ukkwh4hDqWR/Q1DdJY0=;
        b=orPO+qf94fuPLJTM/hYqiXUZ/su2V1Eu4AasGCvyWZGso0y0tteuEgoOf/OSsPviFV
         0xSCToZkfY7U9/f0s1NHyO2o25iCA7FsWJkQEXynqnct7jNgr1Yw8AyGkyUAPMHvHMgZ
         yrXPsVAQGVU3ioNgUDm+7CrgOtRwKefCN4hJtPc0nf9JZG1ckWCzWYicryKam/3zn+oG
         4gtqgsM5kMYitS2Me/XHM+jQcbH5pSOqYESvXHj75SuSgJS+gMonhMCxMAk20Ve38OtP
         dDoYzxfPF/uaTwtCCG4mBnlC86k+yOluoMYjuGDAC3ijIX9eAbWjylOmGPN0I38Dues4
         EDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RK66jqDs7zDL0RJHQV7q3eA8Ukkwh4hDqWR/Q1DdJY0=;
        b=gEJRO1WtLkbpqAIL/bM1HJjUJtR39bcjNKBF1av2dcLt9juw0gYVUu8xoYeyYFolcA
         cMQGsL0XjG7WPZEMojVJQYAmIjNF+JeDRt7gmhKlS3eOkOUPqWix3/uu0QY5WaNpKzyj
         8lN3xSVvZa0w6Bcrwqk+VLI3VKg4HXay5vj4hoLjcuua+CFqaCHcMzp6QgE7JeTPfign
         zFJPIaymqYdcaJne93vPXpOaAifILpxtH6aip2QbaC3u7CnlAGQSFzCHZsNPXbkYfyAh
         rY8c8RuUd3ilvOuWR0dBFclA8TsaepJrkVZ/mrn9eskdfZ6Rsew8E7isA52Iv/aHGRT6
         9YBA==
X-Gm-Message-State: APzg51CZWvotcZhTyRZuB+ex5/Z6DPgvXYgZrlildptGJak42R+A+q8d
        WVSGq6S/oK0sS5Wi+q4Hh+I=
X-Google-Smtp-Source: ANB0VdaoSsamAdbYLz14RQmfhKAsNdXwFEaSOH0iJujWQFNehDPNse5KOCKD2VE/Wyo9trtcYV5zlQ==
X-Received: by 2002:a81:2b55:: with SMTP id r82-v6mr5609720ywr.234.1535680468950;
        Thu, 30 Aug 2018 18:54:28 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:28 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 15/15] blkcg: add average latency tracking to blk-cgroup
Date:   Thu, 30 Aug 2018 21:53:56 -0400
Message-Id: <20180831015356.69796-16-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Latency is an important metric to understanding whether or not you're
receiving adequate service from your block devices. blk-iolatency
demonstrates the utility of such information.

This patch introduces a moving average to track latency to blk-cgroup.
The value can be found in all non-root cgroups in io.stat. A bio's
latency is counted and propagated up to, but excluding, the root cgroup.
It uses a minimum window of 1s and windows only elapse with active bios.
A single value is contributed to the moving average from each window.
The percpu stats are long running, thus each interval requires
calculating the delta between the previous read and current read.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst |   6 +-
 block/bio.c                             |   3 +
 block/blk-cgroup.c                      | 117 +++++++++++++++++++++++-
 include/linux/blk-cgroup.h              |   9 ++
 4 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 2dc8f95077aa..1cdc0e4279c5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1521,9 +1521,9 @@ IO Latency Interface Files
 
 	  avg_lat
 		This is an exponential moving average with a decay rate of 1/exp
-		bound by the sampling interval.  The decay rate interval can be
-		calculated by multiplying the win value in io.stat by the
-		corresponding number of samples based on the win value.
+		every 12 samples, with a sampling rate of 1s.  Only IO activity
+		can elapse a window and idle periods extend the most recent
+		window.
 
 	  win
 		The sampling window size in milliseconds.  This is the minimum
diff --git a/block/bio.c b/block/bio.c
index a0b816811e7d..2739e6f5acb7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1720,6 +1720,9 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
+	if (bio->bi_blkg && bio->bi_blkg->parent)
+		blkg_record_latency(bio);
+
 	if (bio->bi_disk)
 		rq_qos_done_bio(bio->bi_disk->queue, bio);
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1eaf097e38b0..b720ca629eea 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -17,6 +17,7 @@
 #include <linux/ioprio.h>
 #include <linux/kdev_t.h>
 #include <linux/module.h>
+#include <linux/sched/loadavg.h>
 #include <linux/sched/signal.h>
 #include <linux/err.h>
 #include <linux/blkdev.h>
@@ -32,6 +33,18 @@
 
 #define MAX_KEY_LEN 100
 
+/*
+ * This constant is used to fake the fixed-point moving average calculation
+ * just like load average for blkg->lat_avg.  The call to CALC_LOAD folds
+ * (FIXED_1 (2048) - exp_factor) * new_sample into lat_avg.  The sampling
+ * window size is fixed to 1s, so BLKCG_EXP_12s is the corresponding value
+ * to create a 1/exp decay rate every 12s when windows elapse immediately.
+ * Note, windows only elapse with IO activity and idle periods extend the
+ * most recent window.
+ */
+#define BLKG_EXP_12s 1884
+#define BLKG_STAT_WIN_SIZE NSEC_PER_SEC
+
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
  * blkcg_pol_register_mutex nests outside of it and synchronizes entire
@@ -72,6 +85,9 @@ static void blkg_free(struct blkcg_gq *blkg)
 	if (!blkg)
 		return;
 
+	if (blkg->rq_stat)
+		free_percpu(blkg->rq_stat);
+
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
@@ -120,7 +136,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 				   gfp_t gfp_mask)
 {
 	struct blkcg_gq *blkg;
-	int i;
+	int i, cpu;
 
 	/* alloc and init base part */
 	blkg = kzalloc_node(sizeof(*blkg), gfp_mask, q->node);
@@ -159,6 +175,20 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 		pd->plid = i;
 	}
 
+	/* init rq_stats */
+	blkg->rq_stat = __alloc_percpu_gfp(sizeof(struct blk_rq_stat),
+					   __alignof__(struct blk_rq_stat),
+					   gfp_mask);
+	if (!blkg->rq_stat)
+		goto err_free;
+	for_each_possible_cpu(cpu) {
+		struct blk_rq_stat *s;
+		s = per_cpu_ptr(blkg->rq_stat, cpu);
+		blk_rq_stat_init(s);
+	}
+	blk_rq_stat_init(&blkg->last_rq_stat);
+	atomic64_set(&blkg->win_start, ktime_to_ns(ktime_get()));
+
 	return blkg;
 
 err_free:
@@ -981,7 +1011,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		const char *dname;
 		char *buf;
 		struct blkg_rwstat rwstat;
-		u64 rbytes, wbytes, rios, wios, dbytes, dios;
+		u64 rbytes, wbytes, rios, wios, dbytes, dios, avg_lat;
 		size_t size = seq_get_buf(sf, &buf), off = 0;
 		int i;
 		bool has_stats = false;
@@ -1012,14 +1042,16 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		wios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_WRITE]);
 		dios = atomic64_read(&rwstat.aux_cnt[BLKG_RWSTAT_DISCARD]);
 
+		avg_lat = div64_u64(blkg->lat_avg, NSEC_PER_USEC);
+
 		spin_unlock_irq(blkg->q->queue_lock);
 
 		if (rbytes || wbytes || rios || wios) {
 			has_stats = true;
 			off += scnprintf(buf+off, size-off,
-					 "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
-					 rbytes, wbytes, rios, wios,
-					 dbytes, dios);
+				 "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu avg_lat=%llu",
+				 rbytes, wbytes, rios, wios, dbytes, dios,
+				 avg_lat);
 		}
 
 		if (!blkcg_debug_stats)
@@ -1638,6 +1670,81 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
 
+/*
+ * This aggregates the latency of all bios under this cgroup and then
+ * advances the moving average window.  A window contributes a single
+ * value to the moving average regardless of how many IOs occurred.
+ */
+static void blkg_aggregate_latency(struct blkcg_gq *blkg)
+{
+	struct blk_rq_stat rq_stat;
+	struct blk_rq_stat *last_rq_stat;
+	u64 mean;
+	int cpu;
+
+	blk_rq_stat_init(&rq_stat);
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+		struct blk_rq_stat *s;
+		s = per_cpu_ptr(blkg->rq_stat, cpu);
+		blk_rq_stat_sum(&rq_stat, s);
+	}
+	preempt_enable();
+
+	last_rq_stat = &blkg->last_rq_stat;
+
+	mean = div64_u64(rq_stat.nr_samples * rq_stat.mean -
+			 last_rq_stat->nr_samples * last_rq_stat->mean,
+			 rq_stat.nr_samples - last_rq_stat->nr_samples);
+	CALC_LOAD(blkg->lat_avg, BLKG_EXP_12s, mean);
+	blkg->last_rq_stat = rq_stat;
+}
+
+/**
+ * blkg_record_latency - records the latency of a bio
+ * @bio: bio of interest
+ *
+ * This records the latency of a bio in all nodes up to root, excluding root.
+ */
+void blkg_record_latency(struct bio *bio)
+{
+	u64 now = ktime_to_ns(ktime_get());
+	u64 start = bio_issue_time(&bio->bi_issue);
+	u64 win_start, req_time;
+	struct blkcg_gq *blkg;
+	struct blk_rq_stat *rq_stat;
+	bool issue_as_root = bio_issue_as_root_blkg(bio);
+
+	blkg = bio->bi_blkg;
+	if (!blkg)
+		return;
+
+	/*
+	 * Have to do this so we are truncated to the correct time that our
+	 * issue is truncated to.
+	 */
+	now = __bio_issue_time(now);
+
+	if (now <= start || issue_as_root)
+		return;
+
+	req_time = now - start;
+
+	while (blkg && blkg->parent) {
+		rq_stat = get_cpu_ptr(blkg->rq_stat);
+		blk_rq_stat_add(rq_stat, req_time);
+		put_cpu_ptr(rq_stat);
+
+		win_start = atomic64_read(&blkg->win_start);
+		if (now > win_start && (now - win_start) >= BLKG_STAT_WIN_SIZE)
+			if (atomic64_cmpxchg(&blkg->win_start,
+					     win_start, now) == win_start)
+				blkg_aggregate_latency(blkg);
+
+		blkg = blkg->parent;
+	}
+}
+
 /*
  * Scale the accumulated delay based on how long it has been since we updated
  * the delay.  We only call this when we are adding delay, in case it's been a
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 0134cdd270b8..215af051f876 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -136,6 +136,11 @@ struct blkcg_gq {
 
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
 
+	struct blk_rq_stat __percpu	*rq_stat;
+	struct blk_rq_stat		last_rq_stat;
+	atomic64_t			win_start;
+	u64				lat_avg;
+
 	struct rcu_head			rcu_head;
 
 	atomic_t			use_delay;
@@ -895,6 +900,8 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 	}
 }
 
+void blkg_record_latency(struct bio *bio);
+
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
@@ -917,6 +924,8 @@ struct blkcg_policy {
 
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
 
+static inline void blkg_record_latency(struct bio *bio) {}
+
 static inline void blkcg_maybe_throttle_current(void) { }
 static inline bool blk_cgroup_congested(void) { return false; }
 
-- 
2.17.1


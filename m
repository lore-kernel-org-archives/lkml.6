Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0B8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975F1208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niRqbS99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975F1208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeHBIFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:05:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37686 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeHBIFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so625183pgq.4;
        Wed, 01 Aug 2018 23:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JOSA//K2rEGXGF2sdyELw4rp9DOX1E/cuAljqEMaCE4=;
        b=niRqbS99Ub8HGb1hoViiRhPNwyphgsbouxiOTeTL1C2jZRKkgqPbWahnLY9oG7LHpg
         a7ODIm4gHUTPo4foSTaEfhODlB34aHbFGdjvt0ko3EhoR/OW4hOqnUu0RKSyfpRSAOWN
         Ll7Po40+FfHhp0IPTM9Xzg6ZkNahm4NSwJdNVjeVHDACB9Pdrnkz/3JlUCbzIsnZRwic
         b+5zPw7uW/F1F6g/4t7m6VDWMWO3ZxdIO5iwz3/eiURN48n7ywa4a9T8dc8u41Hhlhdv
         SSaQkB4YHTK5IMgEZL0NFYec1q244oBNPKeh/y0v7T4i6s3PyjtQMe2DOXUzVV3G9ZQK
         MOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JOSA//K2rEGXGF2sdyELw4rp9DOX1E/cuAljqEMaCE4=;
        b=eBWsNde5iGwJBu16YbWQtJNkrfsR4nHcw29dBxWkIkFFV3QufW3vm2/oq3EaWTMhoZ
         YMSSdDvzBMJ/UtmlxYUpJWora6NtZMSQpgQPVmuCUHUOIxegIIMaT6752nAqnD0q1V3m
         U4I/RvEo1Eah4B8VChIfbSQwGF3haq1vLPJ2XsXFTjtno2Znnn2xhRd+KucZxBT29bTN
         Mw0rx8TSXTkKyJT5ptgpbYMuW6ZPsF88yBkBYG5ECQjtGFZ7uxYKXZWPMSwg5/pZOIQO
         8npJOywjjjWF0qHgT5cxSkf9mOIcZv3Ar6srR/gk21jNKuHkUjGNRPGEEj3vn0wjEjRZ
         9vXg==
X-Gm-Message-State: AOUpUlGJ6H6tHXu5Q68U4965X1GkUAdjZA/supM198XX8Dj44xr0oW8T
        Ixgwh9f6WttmlroQd6JlLjg=
X-Google-Smtp-Source: AAOMgpdxwSMsAybq9jeTRCP8Z7ti8k5wwnnA1wLyawbLBisyls30Px2xGZ6nsc2cbQS0isbEYVMjHw==
X-Received: by 2002:a65:550d:: with SMTP id f13-v6mr1436565pgr.340.1533190570478;
        Wed, 01 Aug 2018 23:16:10 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.4])
        by smtp.gmail.com with ESMTPSA id r19-v6sm1185677pgo.68.2018.08.01.23.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:16:09 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH v3] block: make iolatency avg_lat exponentially decay
Date:   Wed,  1 Aug 2018 23:15:41 -0700
Message-Id: <20180802061541.49173-1-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Currently, avg_lat is calculated by accumulating the mean of every
window in a long running cumulative average. As time goes on, the metric
becomes less and less useful due to the accumulated history.

This patch reuses the same calculation done in load averages to make the
avg_lat metric more lively. Unlike load averages, the avg only advances
when a window elapses (due to an io). Idle periods extend the most
recent window. Bucketing is used to limit the history of avg_lat by
binding it to the window size. So, the window range for 1/exp (decay
rate) is [1 min, 2.5 min) when windows elapse immediately.

The current sample window size is exposed in the debug info to enable
calculation of the window range.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 21 +++++----
 block/blk-iolatency.c                   | 60 ++++++++++++++++++-------
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3afe10fa82bc..1746131bc9cb 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1474,11 +1474,9 @@ So the ideal way to configure this is to set io.latency in groups A, B, and C.
 Generally you do not want to set a value lower than the latency your device
 supports.  Experiment to find the value that works best for your workload.
 Start at higher than the expected latency for your device and watch the
-total_lat_avg value in io.stat for your workload group to get an idea of the
-latency you see during normal operation.  Use this value as a basis for your
-real setting, setting at 10-15% higher than the value in io.stat.
-Experimentation is key here because total_lat_avg is a running total, so is the
-"statistics" portion of "lies, damned lies, and statistics."
+avg_lat value in io.stat for your workload group to get an idea of the
+latency you see during normal operation.  Use the avg_lat value as a basis for
+your real setting, setting at 10-15% higher than the value in io.stat.
 
 How IO Latency Throttling Works
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1522,10 +1520,15 @@ IO Latency Interface Files
 		This is the current queue depth for the group.
 
 	  avg_lat
-		The running average IO latency for this group in microseconds.
-		Running average is generally flawed, but will give an
-		administrator a general idea of the overall latency they can
-		expect for their workload on the given disk.
+		This is an exponential moving average with a decay rate of 1/exp
+		bound by the sampling interval.  The decay rate interval can be
+		calculated by multiplying the win value in io.stat by the
+		corresponding number of samples based on the win value.
+
+	  win
+		The sampling window size in milliseconds.  This is the minimum
+		duration of time between evaluation events.  Windows only elapse
+		with IO activity.  Idle periods extend the most recent window.
 
 PID
 ---
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index b0dc4fc64b3e..19923f8a029d 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -69,6 +69,7 @@
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/memcontrol.h>
+#include <linux/sched/loadavg.h>
 #include <linux/sched/signal.h>
 #include <trace/events/block.h>
 #include "blk-rq-qos.h"
@@ -126,8 +127,7 @@ struct iolatency_grp {
 	u64 cur_win_nsec;
 
 	/* total running average of our io latency. */
-	u64 total_lat_avg;
-	u64 total_lat_nr;
+	u64 lat_avg;
 
 	/* Our current number of IO's for the last summation. */
 	u64 nr_samples;
@@ -135,6 +135,28 @@ struct iolatency_grp {
 	struct child_latency_info child_lat;
 };
 
+#define BLKIOLATENCY_MIN_WIN_SIZE (100 * NSEC_PER_MSEC)
+#define BLKIOLATENCY_MAX_WIN_SIZE NSEC_PER_SEC
+/*
+ * These are the constants used to fake the fixed-point moving average
+ * calculation just like load average.  The call to CALC_LOAD folds
+ * (FIXED_1 (2048) - exp_factor) * new_sample into lat_avg.  The sampling
+ * window size is bucketed to try to approximately calculate average
+ * latency such that 1/exp (decay rate) is [1 min, 2.5 min) when windows
+ * elapse immediately.  Note, windows only elapse with IO activity.  Idle
+ * periods extend the most recent window.
+ */
+#define BLKIOLATENCY_NR_EXP_FACTORS 5
+#define BLKIOLATENCY_EXP_BUCKET_SIZE (BLKIOLATENCY_MAX_WIN_SIZE / \
+				      (BLKIOLATENCY_NR_EXP_FACTORS - 1))
+static const u64 iolatency_exp_factors[BLKIOLATENCY_NR_EXP_FACTORS] = {
+	2045, // exp(1/600) - 600 samples
+	2039, // exp(1/240) - 240 samples
+	2031, // exp(1/120) - 120 samples
+	2023, // exp(1/80)  - 80 samples
+	2014, // exp(1/60)  - 60 samples
+};
+
 static inline struct iolatency_grp *pd_to_lat(struct blkg_policy_data *pd)
 {
 	return pd ? container_of(pd, struct iolatency_grp, pd) : NULL;
@@ -462,7 +484,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	struct child_latency_info *lat_info;
 	struct blk_rq_stat stat;
 	unsigned long flags;
-	int cpu;
+	int cpu, exp_idx;
 
 	blk_rq_stat_init(&stat);
 	preempt_disable();
@@ -480,11 +502,17 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 
 	lat_info = &parent->child_lat;
 
-	iolat->total_lat_avg =
-		div64_u64((iolat->total_lat_avg * iolat->total_lat_nr) +
-			  stat.mean, iolat->total_lat_nr + 1);
-
-	iolat->total_lat_nr++;
+	/*
+	 * CALC_LOAD takes in a number stored in fixed point representation.
+	 * Because we are using this for IO time in ns, the values stored
+	 * are significantly larger than the FIXED_1 denominator (2048).
+	 * Therefore, rounding errors in the calculation are negligible and
+	 * can be ignored.
+	 */
+	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
+			div64_u64(iolat->cur_win_nsec,
+				  BLKIOLATENCY_EXP_BUCKET_SIZE));
+	CALC_LOAD(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);
 
 	/* Everything is ok and we don't need to adjust the scale. */
 	if (stat.mean <= iolat->min_lat_nsec &&
@@ -700,8 +728,9 @@ static void iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
 	u64 oldval = iolat->min_lat_nsec;
 
 	iolat->min_lat_nsec = val;
-	iolat->cur_win_nsec = max_t(u64, val << 4, 100 * NSEC_PER_MSEC);
-	iolat->cur_win_nsec = min_t(u64, iolat->cur_win_nsec, NSEC_PER_SEC);
+	iolat->cur_win_nsec = max_t(u64, val << 4, BLKIOLATENCY_MIN_WIN_SIZE);
+	iolat->cur_win_nsec = min_t(u64, iolat->cur_win_nsec,
+				    BLKIOLATENCY_MAX_WIN_SIZE);
 
 	if (!oldval && val)
 		atomic_inc(&blkiolat->enabled);
@@ -810,14 +839,15 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 				size_t size)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
-	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
+	unsigned long long avg_lat = div64_u64(iolat->lat_avg, NSEC_PER_USEC);
+	unsigned long long cur_win = div64_u64(iolat->cur_win_nsec, NSEC_PER_MSEC);
 
 	if (iolat->rq_depth.max_depth == UINT_MAX)
-		return scnprintf(buf, size, " depth=max avg_lat=%llu",
-				 avg_lat);
+		return scnprintf(buf, size, " depth=max avg_lat=%llu win=%llu",
+				 avg_lat, cur_win);
 
-	return scnprintf(buf, size, " depth=%u avg_lat=%llu",
-			 iolat->rq_depth.max_depth, avg_lat);
+	return scnprintf(buf, size, " depth=%u avg_lat=%llu win=%llu",
+			 iolat->rq_depth.max_depth, avg_lat, cur_win);
 }
 
 
-- 
2.17.1


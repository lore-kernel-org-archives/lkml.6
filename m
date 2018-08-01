Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD51CC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB5F20851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf7afCuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB5F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbeHACI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 22:08:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45756 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732830AbeHACIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 22:08:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so6893501pfo.12;
        Tue, 31 Jul 2018 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y6qHMZX6InMqnLS5F7AIDGCFVFBew0YtvVZCMSv9UcQ=;
        b=Rf7afCuwTFJNZH6toNezGzT7/wioXeVpKGaw7sZiUjlj3boft9ycZn7+RuPenGUv2X
         FDpdNguODG2zcUq913wvmc1Ywup/wO4u8/j/X5rmuVsA7mijRlKpCKS2a+P/Vmj4pwnS
         CFiwTMlphyRxwiHrMR4/RFk5lEbw7hQuhSRCxhgz6SwDbHsEjn3OcOn5XqS5akL0dCgA
         QNVO1BA0PrkgiAbSaKkBrC+0GxRxM14mjxQTQwytGE+GL6/MgIrb2bsqwqI4qFgIqbZd
         enn1C08cCIqFOyoiQdw/kWO5s1cjJV2d4uRNUKqE1qyfXhwenj4wSaZGhENJh4nnZldB
         G6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y6qHMZX6InMqnLS5F7AIDGCFVFBew0YtvVZCMSv9UcQ=;
        b=W9sGRJhfLy6jfk6s0tBLWoc0GRnk0oL/up2QHvvFLCKcvBh7+YztfTzrCGZx72CUX3
         vs8m8Ouohdb3bbkfOdbIJlZVB18zYTNt229ws/FXG6R9/YRgvNw1qUpxTeVPsIOvGCHq
         vrg7L/zumXWPR1kY//l72/VHI+tijHSvJ/kqG5wR2s44H/Rys+Hzjm12/XYcuJtKFofg
         IK6/tqTRK7kY7HGZFVP/m2yObqXsLzu69TnKCfCqozMu2Echi7RaGNpEfDALNcWsH+El
         9p6R0a9ivP/o5/5ee8Q2LSgdYxbk93+Xr/yWBdcSbklnqdVI3B1MSWLYtFdDg6HSaL+9
         ee/w==
X-Gm-Message-State: AOUpUlFWfEFTpgRW5xfMyu/Hm+1zNG9zqpRmeuqkNhPEAZ5pljeOCqJ6
        zzaxGhcRVPuhnNtzB2Hv/Vg=
X-Google-Smtp-Source: AAOMgpesUjdkqTCfcJw5pphYEM5ps9ZCz6wBrXEyJjGSnShBaakc4RwJgtXy/lCrbbWZlgSdP/zDfQ==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr24086802pfj.175.1533083165422;
        Tue, 31 Jul 2018 17:26:05 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.3])
        by smtp.gmail.com with ESMTPSA id q65-v6sm26337357pfj.127.2018.07.31.17.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 17:26:04 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH v2] block: make iolatency avg_lat exponentially decay
Date:   Tue, 31 Jul 2018 17:25:59 -0700
Message-Id: <20180801002559.36261-1-dennisszhou@gmail.com>
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
---
 block/blk-iolatency.c | 55 +++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index bb59b2929e0d..2a6bb7e31dda 100644
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
@@ -127,7 +128,6 @@ struct iolatency_grp {
 
 	/* total running average of our io latency. */
 	u64 total_lat_avg;
-	u64 total_lat_nr;
 
 	/* Our current number of IO's for the last summation. */
 	u64 nr_samples;
@@ -135,6 +135,27 @@ struct iolatency_grp {
 	struct child_latency_info child_lat;
 };
 
+#define BLKIOLATENCY_MIN_WIN_SIZE (100 * NSEC_PER_MSEC)
+#define BLKIOLATENCY_MAX_WIN_SIZE NSEC_PER_SEC
+/*
+ * These are the constants used to fake the fixed-point moving average
+ * calculation just like load average. The call to CALC_LOAD folds
+ * (FIXED_1 (2048) - exp_factor) * new_sample into total_lat_avg.
+ * The sampling window size is bucketed to try to approximately calculate
+ * average latency such that 1/exp (decay rate) is [1 min, 2.5 min) when
+ * windows elapse immediately.
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
@@ -462,7 +483,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	struct child_latency_info *lat_info;
 	struct blk_rq_stat stat;
 	unsigned long flags;
-	int cpu;
+	int cpu, exp_idx;
 
 	blk_rq_stat_init(&stat);
 	preempt_disable();
@@ -480,11 +501,17 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 
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
+			iolat->cur_win_nsec / BLKIOLATENCY_EXP_BUCKET_SIZE);
+	CALC_LOAD(iolat->total_lat_avg, iolatency_exp_factors[exp_idx],
+		  stat.mean);
 
 	/* Everything is ok and we don't need to adjust the scale. */
 	if (stat.mean <= iolat->min_lat_nsec &&
@@ -700,8 +727,9 @@ static void iolatency_set_min_lat_nsec(struct blkcg_gq *blkg, u64 val)
 	u64 oldval = iolat->min_lat_nsec;
 
 	iolat->min_lat_nsec = val;
-	iolat->cur_win_nsec = max_t(u64, val << 4, 100 * NSEC_PER_MSEC);
-	iolat->cur_win_nsec = min_t(u64, iolat->cur_win_nsec, NSEC_PER_SEC);
+	iolat->cur_win_nsec = max_t(u64, val << 4, BLKIOLATENCY_MIN_WIN_SIZE);
+	iolat->cur_win_nsec = min_t(u64, iolat->cur_win_nsec,
+				    BLKIOLATENCY_MAX_WIN_SIZE);
 
 	if (!oldval && val)
 		atomic_inc(&blkiolat->enabled);
@@ -811,13 +839,14 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
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


Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E96C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681820859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+w4gOfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391794AbfAPJna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:43:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38741 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391777AbfAPJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:43:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so1251731wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IF8O5IB660i5uISr2+XWnKBaqatYQfBFmBwhpEAXDiM=;
        b=B+w4gOfSUmQtZBFsM9IOmNkQO7DxVOMJyoV+4sBrlbm9rsCUJNAEzXtwr+Xu7H306r
         aGJOXOcC3i5MTCSupFRmglXycFAP41w2nHWTU2VlnyA9vEBWY3Aq6DlULyszojdEO3ex
         xSc2wnF7RHLAjAsSM7qUDBwIivPfvQ6ymnFvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IF8O5IB660i5uISr2+XWnKBaqatYQfBFmBwhpEAXDiM=;
        b=QjSmQCFfp2OVKfnlEkZJNTilQYwHmGLYYPQlolYi3jeTGoreALotbs3Cx3bdNB/bI4
         pXMPHA3b4zsHxMvSkCzIQw757CUOSJUyFm3PIKxzrp/OcRbNr4FzgWhQjyZGQxPDCQLK
         bGiuEHiX/nq1KJg7GDpPJqsXFOF4Gj3JxF83yI4PNjxqjN12yaoZjV5mPb3D+XhLnaIu
         Yu3j5NbN+JJsdlKKJpfexeJ800NnX0rXwhVNZBveAsGsWGAb08fKnWe0NNCs9jCAKrIV
         JFx1WafNBW78n3KXcF8OE1h2N+JyEY02QNQzQoCcOecPbiQWfCBhOAQnMTrA6K/mThDG
         hwrw==
X-Gm-Message-State: AJcUukd6HC5mC0ZQSzpFqWKPl6Ou+31rsEjxM9hGhRaeQ21PIyT8cdB/
        ItV4uj47QUiNYDb/YG9LfDt9484XC1lStg==
X-Google-Smtp-Source: ALg8bN6SMGOFIXXCsN/IDHM/xpAJ0Uz8mtSrOiJqPUXZ9ynkwZPbM2SCOwPDiQPEhg1xxxgXkKFY6w==
X-Received: by 2002:a1c:9d57:: with SMTP id g84mr6899437wme.16.1547631805375;
        Wed, 16 Jan 2019 01:43:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:596d:a8c4:e914:fdde])
        by smtp.gmail.com with ESMTPSA id k19sm115996304wre.5.2019.01.16.01.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 01:43:24 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v8 3/3] sched/pelt: skip updating util_est when utilization is higher than cpu's capacity
Date:   Wed, 16 Jan 2019 10:43:11 +0100
Message-Id: <1547631791-16018-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
References: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

util_est is mainly meant to be a lower-bound for tasks utilization.
That's why task_util_est() returns the actual util_avg when it's higher
than the estimated utilization.

With new invaraince signal and without any special check on samples
collection, if a task is limited because of thermal capping for
example, we could end up overestimating its utilization and thus
perhaps generating an unwanted frequency spike when the capping is
relaxed... and (even worst) it will take some more activations for the
estimated utilization to converge back to the actual utilization.

Since we cannot easily know if there is idle time in a CPU when a task
completes an activation with a utilization higher then the CPU capacity,
we skip the sampling when utilization is higher than cpu's capacity.

Suggested-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 14 +++++++++-----
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9332863..2262c8a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3639,6 +3639,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 {
 	long last_ewma_diff;
 	struct util_est ue;
+	int cpu;
 
 	if (!sched_feat(UTIL_EST))
 		return;
@@ -3673,6 +3674,14 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 		return;
 
 	/*
+	 * To avoid overestimation of actual task utilization, skip updates if
+	 * we cannot grant there is idle time in this CPU.
+	 */
+	cpu = cpu_of(rq_of(cfs_rq));
+	if (task_util(p) > capacity_orig_of(cpu))
+		return;
+
+	/*
 	 * Update Task's estimated utilization
 	 *
 	 * When *p completes an activation we can consolidate another sample
@@ -5541,11 +5550,6 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
-static unsigned long capacity_orig_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig;
-}
-
 static unsigned long cpu_avg_load_per_task(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c506ea..455745e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2230,6 +2230,13 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 # define arch_scale_freq_invariant()	false
 #endif
 
+#ifdef CONFIG_SMP
+static inline unsigned long capacity_orig_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig;
+}
+#endif
+
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
 /**
  * enum schedutil_type - CPU utilization type
-- 
2.7.4


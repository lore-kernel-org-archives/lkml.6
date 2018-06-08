Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1QA8MstxGluIPAAAmS7hNA
	; Fri, 08 Jun 2018 12:10:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CBFCD608BA; Fri,  8 Jun 2018 12:10:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dU1Piiot"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2798E60290;
	Fri,  8 Jun 2018 12:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2798E60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeFHMKf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38275 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbeFHMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so3287347wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gUNOi+06UjqIu3kZ8NcmOFtpA+W+JZqfpkKfqG940N0=;
        b=dU1PiiotISxwH0ggnI0s9vTAO0eAhEgbarb6Cnz2QFt0T1NY/2Urm0UHgQmKaj2KQ6
         py0rdflU/NpFecvQ2yYJRYS5sdg+VeTK/1PBnSV8SzsYaqdJXna3f/DCzU/k2tR7TgVv
         BHm09w4tVGE91+93NyJxJTssysMTBjZT7YgbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gUNOi+06UjqIu3kZ8NcmOFtpA+W+JZqfpkKfqG940N0=;
        b=rUZBteAr5v+U8qwKU/EV+D3SGyiJl6wyJgwFbIGO6s/y0+ZsKGtrRB8lfJj9zneg++
         2KD2vqbJIYHJNBTE4UiliMTHc3g8RazzcjU+cbBoy7ORYu5MuwJKCYgYTopIX96UNi23
         A9x+N5eKpB+tk+IxbyXFPOTWBl66E19LKLK1TZpeQY8TBY7ulzzVHOwSue3z00FkUIjT
         xigbA4v3WAKJe541nZqnhyHRAZgwmSxDLostLh/21VcO2iXcfuVvbti/CsL7rFRlg1R2
         TIV+A9UiIaXHBGu65zGv4hp4dAdL84USkhC4NvO34Uq3nZzcF4gN+3897jSA15AamLan
         jGtA==
X-Gm-Message-State: APt69E0yuzXBuVnsMIlCbEDUc9/WqAtg8V4RtS8vXdR5G7b/EDB8J54c
        wUKEGNF9R6SQz9BqLNxsT28m6g==
X-Google-Smtp-Source: ADUXVKJh42LEFfcvPpJsoUr+zxct/6swpWFdaJG3l8+RRbMOw/arJyWV2S+0nqZhM1b3Gz+FoL5ELQ==
X-Received: by 2002:a1c:1701:: with SMTP id 1-v6mr1327240wmx.38.1528459829981;
        Fri, 08 Jun 2018 05:10:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:29 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v6 06/11] cpufreq/schedutil: use dl utilization tracking
Date: Fri,  8 Jun 2018 14:09:49 +0200
Message-Id: <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have both the dl class bandwidth requirement and the dl class
utilization, we can detect when CPU is fully used so we should run at max.
Otherwise, we keep using the dl bandwidth requirement to define the
utilization of the CPU

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 24 +++++++++++++++---------
 kernel/sched/sched.h             |  7 ++++++-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 32f97fb..25cee59 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long		bw_dl;
 	unsigned long		util_rt;
 	unsigned long		max;
 
@@ -179,6 +180,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->bw_dl    = cpu_bw_dl(rq);
 	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
@@ -190,20 +192,24 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	if (rq->rt.rt_nr_running)
 		return sg_cpu->max;
 
-	util = sg_cpu->util_dl;
-	util += sg_cpu->util_cfs;
+	util = sg_cpu->util_cfs;
 	util += sg_cpu->util_rt;
 
+	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
+		return sg_cpu->max;
+
 	/*
-	 * Utilization required by DEADLINE must always be granted while, for
-	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
-	 * gracefully reduce the frequency when no tasks show up for longer
+	 * As there is still idle time on the CPU, we need to compute the
+	 * utilization level of the CPU.
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
 	 * periods of time.
-	 *
-	 * Ideally we would like to set util_dl as min/guaranteed freq and
-	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
-	 * ready for such an interface. So, we only do the latter for now.
 	 */
+
+	/* Add DL bandwidth requirement */
+	util += sg_cpu->bw_dl;
+
 	return min(sg_cpu->max, util);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4526ba6..bc4305f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2192,11 +2192,16 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-static inline unsigned long cpu_util_dl(struct rq *rq)
+static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
 }
 
+static inline unsigned long cpu_util_dl(struct rq *rq)
+{
+	return READ_ONCE(rq->avg_dl.util_avg);
+}
+
 static inline unsigned long cpu_util_cfs(struct rq *rq)
 {
 	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
-- 
2.7.4

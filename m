Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id U8GXGUNyGlu9PwAAmS7hNA
	; Fri, 08 Jun 2018 12:10:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3E668607A4; Fri,  8 Jun 2018 12:10:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGcXzz8+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D09260290;
	Fri,  8 Jun 2018 12:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D09260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeFHMKk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42985 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeFHMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so13151965wrk.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwoWBjC6wKOoRZe0zFWtP5iX3jFqmWoF+0Wz0wG8mrA=;
        b=BGcXzz8+TlqcQkjoQdCEtUV1YfujY8fKZo9uS+xfo0uPDncMZfEOcp+ywO0BdkV6+j
         nb58WAYAtMVv6JwQZ6ZIJv/8c9BL5P/F+9vmPUS33zRndfiwRAB1W2tPkrCcdvC5Ydzp
         lv9j/yk9ZaCd4phqGjDaftohNuODiYInQIJmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwoWBjC6wKOoRZe0zFWtP5iX3jFqmWoF+0Wz0wG8mrA=;
        b=rIwpWz4CQDKUw6t7HojBUONBxOv485LvsVdFshKOYZ/YYtsJqhV62GiOlnrTXDZqyn
         xYzjKLaE4l2yN9m5csFQUpPlw/GaGMxhUZVABsZlIR+r+fiIB/yBlP0xDSaHk7vd4sN3
         x/Q44SlJ/39wYYqOoGDjZQdgNj63GpoyQDD/vscrW4DVreq3rjCPqPkE+m1kIUnvx011
         acAVw/QcDX6tzLMS+V+szrebe/M+VUDcW+hcrsAZd8v/5Do1b+61TZ9nc9U0UckdyfDt
         /10vzScvfrc1mRnTNS5r6TlQ65XKdN/hTLx07SbMc016rra3p+KSD1dFzJukD9uOa2GQ
         peVQ==
X-Gm-Message-State: APt69E34fzR+GH+T4plpMIaCyj5Cv9L0Do1GiK3O8rByEcKc3EeJ6I7m
        LH86L47Xwno8ccc9oILIVRp6Yg==
X-Google-Smtp-Source: ADUXVKIgAZ0T85Z+2ULN8AHVM+sFboPhwg/iDSlmHoK66JZZICVv4hV6X8RnUImCLDFA+Zy5yYnc3g==
X-Received: by 2002:adf:a851:: with SMTP id l75-v6mr4699300wrc.140.1528459834084;
        Fri, 08 Jun 2018 05:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:33 -0700 (PDT)
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
Subject: [PATCH v6 08/11] cpufreq/schedutil: take into account interrupt
Date: Fri,  8 Jun 2018 14:09:51 +0200
Message-Id: <1528459794-13066-9-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time spent under interrupt can be significant but it is not reflected
in the utilization of CPU when deciding to choose an OPP. Now that we have
access to this metric, schedutil can take it into account when selecting
the OPP for a CPU.
rqs utilization don't see the time spend under interrupt context and report
their value in the normal context time window. We need to compensate this when
adding interrupt utilization

The CPU utilization is :
  irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg

A test with iperf on hikey (octo arm64) gives:
iperf -c server_address -r -t 5

w/o patch		w/ patch
Tx 276 Mbits/sec        304 Mbits/sec +10%
Rx 299 Mbits/sec        328 Mbits/sec +09%

8 iterations
stdev is lower than 1%
Only WFI idle state is enable (shallowest diel state)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 25 +++++++++++++++++++++----
 kernel/sched/sched.h             | 13 +++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 25cee59..092c310 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -58,6 +58,7 @@ struct sugov_cpu {
 	unsigned long		util_dl;
 	unsigned long		bw_dl;
 	unsigned long		util_rt;
+	unsigned long		util_irq;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -182,21 +183,30 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->util_dl  = cpu_util_dl(rq);
 	sg_cpu->bw_dl    = cpu_bw_dl(rq);
 	sg_cpu->util_rt  = cpu_util_rt(rq);
+	sg_cpu->util_irq = cpu_util_irq(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
+	unsigned long util, max = sg_cpu->max;
 
 	if (rq->rt.rt_nr_running)
 		return sg_cpu->max;
 
+	if (unlikely(sg_cpu->util_irq >= max))
+		return max;
+
+	/* Sum rq utilization */
 	util = sg_cpu->util_cfs;
 	util += sg_cpu->util_rt;
 
-	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
-		return sg_cpu->max;
:confirm b9
+	/*
+	 * Interrupt time is not seen by rqs utilization so we can compare
+	 * them with the CPU capacity
+	 */
+	if ((util + sg_cpu->util_dl) >= max)
+		return max;
 
 	/*
 	 * As there is still idle time on the CPU, we need to compute the
@@ -207,10 +217,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * periods of time.
 	 */
 
+	/* Weight rqs utilization to normal context window */
+	util *= (max - sg_cpu->util_irq);
+	util /= max;
+
+	/* Add interrupt utilization */
+	util += sg_cpu->util_irq;
+
 	/* Add DL bandwidth requirement */
 	util += sg_cpu->bw_dl;
 
-	return min(sg_cpu->max, util);
+	return min(max, util);
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b534a43..873b567 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2221,4 +2221,17 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return rq->avg_rt.util_avg;
 }
+
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+static inline unsigned long cpu_util_irq(struct rq *rq)
+{
+	return rq->avg_irq.util_avg;
+}
+#else
+static inline unsigned long cpu_util_irq(struct rq *rq)
+{
+	return 0;
+}
+
+#endif
 #endif
-- 
2.7.4

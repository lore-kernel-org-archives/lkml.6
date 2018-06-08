Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V8GXGUNyGlu9PwAAmS7hNA
	; Fri, 08 Jun 2018 12:11:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 29CCC607E4; Fri,  8 Jun 2018 12:11:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxldxOz+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F50E605A5;
	Fri,  8 Jun 2018 12:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F50E605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeFHMKs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44369 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbeFHMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id x4-v6so5016902wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=58hdi6z7ZlZyTvSIm6ukRmd6PdHbk/qiy6BqniuQYhU=;
        b=GxldxOz+1lbh48KaJ2SSUoO/92Mu8xpihJzxMwSv1MCwYocOsUphm/mCAEo4yIaNzQ
         hSCd3DjHx4K/c+BTdNiJmwQsnkWDeTfP10nIcpRWCOd11/SWjm/QWk70st1/VmI6/et4
         IRaad6tHSgLkyPzKKtGCA7csljFugLYsY3jRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=58hdi6z7ZlZyTvSIm6ukRmd6PdHbk/qiy6BqniuQYhU=;
        b=XHhSbRX/0djnTsqwZdahszNbztjU+INEUlVWduq581gwq97z7dKJfI0aSoeubhwiD6
         BwA91Nzvqi9bPudXehK57MRV6BiaHaVCPVCL2J0utP59331S6vb5GS7b06JhDbQjhEUj
         Bs3Szr5jb1VkLfoBP1L25E8Hd4MkGHLvsFGp+tpgWgabiUajhRgS+VS/tn7s7YePln8C
         yhA6G9WPKRmnDMAsBINjdhUTtR1ONw+lKQThDLIvRg8w4urLWv9HWi1OoG3GWFjyTPrR
         8ugzCX001pw3j4NBSvk5e3yyF2WfCwDFYxbgR9CKuXdaWVIwGZ39sLEEAd5+npgvGKox
         tzpQ==
X-Gm-Message-State: APt69E0Q/KT9/kNCCf1HpaH01zs3o1veC0Edt44FktvtRoINR8Rj0DFp
        aI3EZ3YWqa2/FjKmcR2UxZeYRw==
X-Google-Smtp-Source: ADUXVKIqae/gqDjKxs8uR6AHNieebqnUwnFJg99nerlWoUyugCoi3OQzfLIHspwy8XSXqLcLwWz8ZA==
X-Received: by 2002:adf:b60d:: with SMTP id f13-v6mr4673161wre.186.1528459840661;
        Fri, 08 Jun 2018 05:10:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:40 -0700 (PDT)
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
Subject: [PATCH v6 10/11] sched: remove rt_avg code
Date: Fri,  8 Jun 2018 14:09:53 +0200
Message-Id: <1528459794-13066-11-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt_avg is no more used anywhere so we can remove all related code

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 26 --------------------------
 kernel/sched/fair.c  |  2 --
 kernel/sched/sched.h | 17 -----------------
 3 files changed, 45 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab58288..213d277 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -650,23 +650,6 @@ bool sched_can_stop_tick(struct rq *rq)
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
-
-void sched_avg_update(struct rq *rq)
-{
-	s64 period = sched_avg_period();
-
-	while ((s64)(rq_clock(rq) - rq->age_stamp) > period) {
-		/*
-		 * Inline assembly required to prevent the compiler
-		 * optimising this loop into a divmod call.
-		 * See __iter_div_u64_rem() for another example of this.
-		 */
-		asm("" : "+rm" (rq->age_stamp));
-		rq->age_stamp += period;
-		rq->rt_avg /= 2;
-	}
-}
-
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_RT_GROUP_SCHED) || (defined(CONFIG_FAIR_GROUP_SCHED) && \
@@ -5710,13 +5693,6 @@ void set_rq_offline(struct rq *rq)
 	}
 }
 
-static void set_cpu_rq_start_time(unsigned int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	rq->age_stamp = sched_clock_cpu(cpu);
-}
-
 /*
  * used to mark begin/end of suspend/resume:
  */
@@ -5834,7 +5810,6 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
-	set_cpu_rq_start_time(cpu);
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -6102,7 +6077,6 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
-	set_cpu_rq_start_time(smp_processor_id());
 #endif
 	init_sched_fair_class();
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fefd71b..3594692 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5323,8 +5323,6 @@ static void cpu_load_update(struct rq *this_rq, unsigned long this_load,
 
 		this_rq->cpu_load[i] = (old_load * (scale - 1) + new_load) >> i;
 	}
-
-	sched_avg_update(this_rq);
 }
 
 /* Used instead of source_load when we know the type == 0 */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 873b567..1faab06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -846,8 +846,6 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
-	u64			rt_avg;
-	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
@@ -1712,11 +1710,6 @@ extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-static inline u64 sched_avg_period(void)
-{
-	return (u64)sysctl_sched_time_avg * NSEC_PER_MSEC / 2;
-}
-
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
@@ -1753,8 +1746,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 #endif
 
 #ifdef CONFIG_SMP
-extern void sched_avg_update(struct rq *rq);
-
 #ifndef arch_scale_cpu_capacity
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
@@ -1765,12 +1756,6 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
-
-static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
-{
-	rq->rt_avg += rt_delta * arch_scale_freq_capacity(cpu_of(rq));
-	sched_avg_update(rq);
-}
 #else
 #ifndef arch_scale_cpu_capacity
 static __always_inline
@@ -1779,8 +1764,6 @@ unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
-static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
-static inline void sched_avg_update(struct rq *rq) { }
 #endif
 
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
-- 
2.7.4

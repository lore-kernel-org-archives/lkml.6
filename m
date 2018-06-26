Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6622BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEEB26BB3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D50XeQYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEEB26BB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935871AbeFZNx3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:53:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41974 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935437AbeFZNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:53:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so17345088wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ln7vsS0dfsTTzXFg4JBDtoiAgEs1GAAAga1CPUIRcMk=;
        b=D50XeQYzkbwpfjRimneloVYeY3Wr839MYDRsdaqFNpUAobnm4Pud9VscMUm6NAZsZx
         ZniIC33Oq/wt7AyLbmZScNHtQzbz+xQBc1dvJOBciGgZgOzyLU8Du+PePS3CbiMLtOaL
         b85byEfmWwxxnGgBJY61v4jccdF/Hzi/2+ruc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ln7vsS0dfsTTzXFg4JBDtoiAgEs1GAAAga1CPUIRcMk=;
        b=B1O1cpx3p43N1+3nBxMdynMHqq5hDYw5km/Y2PKzJTKELRET1LCfZkLCBPLJ9Jc1Zu
         x/3vuVfECOAzaq1x0hUGesOR3esWzvwSkoVMXDnFsjH68xbv/DBgAM++CAwaVIFGBlms
         ZBBgaphztyh5Ym4yZ8vHzFeLGJPfbPc4X9kFWhwQ1dhZ35OdwHDtanmnb0TiSH9UtSWp
         LBq43ZIBTM/2eZKqf9nvzhKe/Yf+PgwJpS6gCK5CRRlq+8oJVvK3wx18TWPTCNUIH7rQ
         dkHEWqBbIMokji1J2yshaEM+YoBO+iKzAwTQfuHbnK/dsyKIe+G8rtf4BaAquYU+xXXQ
         zXng==
X-Gm-Message-State: APt69E2SSkErruz9XsdVDfMynWQbb3ndBD+pHNU3NHaqzF0hrNAiFig5
        BhoNVKZ22Dvp1vTO1uIfoUO51g==
X-Google-Smtp-Source: AAOMgpeUmm0g+Oo0ho5UmZh2KRcSSkrw8mxPxqa3r/ABYG7GA253CLszfk+CnoKIPUmhZynHhSl6dg==
X-Received: by 2002:adf:99ea:: with SMTP id y97-v6mr1571971wrb.215.1530021205827;
        Tue, 26 Jun 2018 06:53:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9d92:4c1a:6154:250c])
        by smtp.gmail.com with ESMTPSA id 189-v6sm2855835wmd.17.2018.06.26.06.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 06:53:25 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     patrick.bellasi@arm.com, viresh.kumar@linaro.org,
        tglx@linutronix.de, efault@gmx.de, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: [PATCH v2] sched/rt: fix call to cpufreq_update_util
Date:   Tue, 26 Jun 2018 15:53:22 +0200
Message-Id: <1530021202-21695-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAKfTPtDXdo16gTPUf8RwXDuESTdn09c2W7J0YCCYjCxg8uuh6A@mail.gmail.com>
References: <CAKfTPtDXdo16gTPUf8RwXDuESTdn09c2W7J0YCCYjCxg8uuh6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
schedutil governor uses rq->rt.rt_nr_running to detect whether a RT task is
currently running on the CPU and to set frequency to max if necessary.

cpufreq_update_util() is called in enqueue/dequeue_top_rt_rq() but
rq->rt.rt_nr_running has not been updated yet when dequeue_top_rt_rq() is
called so schedutil still considers that a RT task is running when the
last task is dequeued. The update of rq->rt.rt_nr_running happens later
in dequeue_rt_stack().

In fact, we can take advantage of the sequence that the dequeue then
re-enqueue rt entities when a rt task is enqueued or dequeued;
As a result enqueue_top_rt_rq() is always called when a task is
enqueued or dequeued and also when groups are throttled or unthrottled.
The only place that not use enqueue_top_rt_rq() is when root rt_rq is
throttled.

Fixes: 8f111bc357aa ('cpufreq/schedutil: Rewrite CPUFREQ_RT support')
Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/rt.c                | 16 ++++++++++------
 kernel/sched/sched.h             |  5 +++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3cde464..c907fde 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -192,7 +192,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	if (rq->rt.rt_nr_running)
+	if (rt_rq_is_runnable(&rq->rt))
 		return sg_cpu->max;
 
 	/*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 47556b0..5725670 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -508,8 +508,11 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 
 	rt_se = rt_rq->tg->rt_se[cpu];
 
-	if (!rt_se)
+	if (!rt_se) {
 		dequeue_top_rt_rq(rt_rq);
+		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
+	}
 	else if (on_rt_rq(rt_se))
 		dequeue_rt_entity(rt_se, 0);
 }
@@ -1001,8 +1004,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 	sub_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 0;
 
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1014,11 +1015,14 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 
 	if (rt_rq->rt_queued)
 		return;
-	if (rt_rq_throttled(rt_rq) || !rt_rq->rt_nr_running)
+
+	if (rt_rq_throttled(rt_rq))
 		return;
 
-	add_nr_running(rq, rt_rq->rt_nr_running);
-	rt_rq->rt_queued = 1;
+	if (rt_rq->rt_nr_running) {
+		add_nr_running(rq, rt_rq->rt_nr_running);
+		rt_rq->rt_queued = 1;
+	}
 
 	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6601baf..27ddec3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -609,6 +609,11 @@ struct rt_rq {
 #endif
 };
 
+static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
+{
+	return rt_rq->rt_queued && rt_rq->rt_nr_running;
+}
+
 /* Deadline class' related fields in a runqueue */
 struct dl_rq {
 	/* runqueue is an rbtree, ordered by deadline */
-- 
2.7.4


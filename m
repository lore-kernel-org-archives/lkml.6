Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F4ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F62150F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkiVgrlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363F62150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbeIVCMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:12:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34340 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVCMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:12:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id e25so3240861edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBT/fEhN+iK9xfbVhJ2VOtFJooJUqV6iapJnSxHZaZA=;
        b=fkiVgrlG5m6YY+qSww1Z1vX+XkeRlJsr56Ah4ytUlzqDr03So6rnPn2AwQe42g1tOy
         CDHQxy2HeONKKg/QU/h+0XRAQhtJ1RihbYGAbMN6ThS2upqGtMcyZ3scqhQVzLjGB3ok
         /6C6H20sYuEX4+zHEdO/RA9mcCVm18BGUZMTh/NibQK9c/qYiDoqxFKTEsTZlMlWuoNi
         SINGiKdYx7N0I+8VvmJSl93y2ALXW7sngbY9QRuOHryKYGvHh0ZrPbVHHCNSq/PWyhzA
         ldD7Lh2A4cZucF/CuMlzyEaR3d071eWhsetUvFINaW6NnNHJGO3aeJ/ajvdq/KcHvqtc
         oljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBT/fEhN+iK9xfbVhJ2VOtFJooJUqV6iapJnSxHZaZA=;
        b=RzrVGe0C1iEHndmbD9DbatkKtrCll6jBt7HyonTJugkHREx+IrXln21LSsLI/21+6s
         TYFzmqjzBpmtpjRvY9Pt9X7STwYI3WAZJ09pImTqcPmCqWitIrh4wl6mBJpmsQ7RKlNl
         VubxXf9AIn4j44vgATEQ9XZzyItpCV/A4YjcZdGI7SKOJ2M+J94Wdp+31pMyzKhaAMoi
         5AzLJivxOy8xUSF+9PV//r9vNoPIKAwC40gVzhzUGrHQNUBRhwjBYsiLw/8A8miiW/0L
         ZIXq9TaqAllncBRljKDy1plupnWp2hOlW7lu9UsqxRtqe1690mF3YSC7KmkUogTwTnIw
         ajJw==
X-Gm-Message-State: APzg51D6vm/iudWkO4yIsvyvTijhcqH4GpCEKAyYVCYjQ2Iw8Y/D0MyA
        EVSnvckymsFuReYW/wXXIi4=
X-Google-Smtp-Source: ANB0Vdb0aE/A/2VWlZwhPQTaNPDEPMKNyBvHiLjs/La8YxvL6GUoNSG4hL9cOZgsoT5l3mbLdUItkQ==
X-Received: by 2002:a50:d798:: with SMTP id w24-v6mr14592409edi.19.1537561335520;
        Fri, 21 Sep 2018 13:22:15 -0700 (PDT)
Received: from GANOO-Loonix.attlocal.net (1c-3e-84-ee-f8-f9.wlan.lsu.edu. [167.96.58.102])
        by smtp.gmail.com with ESMTPSA id d23-v6sm2123620eds.47.2018.09.21.13.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:22:14 -0700 (PDT)
From:   PierceGriffiths <pierceagriffiths@gmail.com>
Cc:     pierceagriffiths@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scheduler: conditional statement cleanup
Date:   Fri, 21 Sep 2018 15:22:03 -0500
Message-Id: <20180921202205.11769-1-pierceagriffiths@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierce Griffiths <pierceagriffiths@gmail.com>

*Condense ssequential if statements into a single if statement when they
share an outcome
*Eliminate a jump instruction by replacing a goto with a return
*Eliminate an unnecessary local variable
*Replace "if(function or boolean expression) return true else return false"
with "return (function or boolean expression);"
*Remove null pointer checks before calls to kfree on the grounds that
kfree(NULL) results in a no-op

Signed-off-by: Pierce Griffiths <pierceagriffiths@gmail.com>
---
Please tell me if I've made any mistakes in the submission process,
this is the first time I've submitted a patch to the Linux kernel.

 kernel/sched/core.c    |  8 ++------
 kernel/sched/cpufreq.c |  5 +----
 kernel/sched/cpupri.c  | 22 ++++++++--------------
 kernel/sched/rt.c      | 31 ++++++++++++-------------------
 4 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc9897f62..443a1f235cfd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -617,12 +617,8 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * If there are more than one RR tasks, we need the tick to effect the
 	 * actual RR behaviour.
 	 */
-	if (rq->rt.rr_nr_running) {
-		if (rq->rt.rr_nr_running == 1)
-			return true;
-		else
-			return false;
-	}
+	if (rq->rt.rr_nr_running)
+		return rq->rt.rr_nr_running == 1;
 
 	/*
 	 * If there's no RR tasks, but FIFO tasks, we can skip the tick, no
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 5e54cbcae673..a8fd4bd68954 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -34,10 +34,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 			void (*func)(struct update_util_data *data, u64 time,
 				     unsigned int flags))
 {
-	if (WARN_ON(!data || !func))
-		return;
-
-	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
+	if (WARN_ON(!data || !func || per_cpu(cpufreq_update_util_data, cpu)))
 		return;
 
 	data->func = func;
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index daaadf939ccb..152c133e8247 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -29,20 +29,16 @@
 #include "sched.h"
 
 /* Convert between a 140 based task->prio, and our 102 based cpupri */
-static int convert_prio(int prio)
+static int convert_prio(const int prio)
 {
-	int cpupri;
-
 	if (prio == CPUPRI_INVALID)
-		cpupri = CPUPRI_INVALID;
+		return CPUPRI_INVALID;
 	else if (prio == MAX_PRIO)
-		cpupri = CPUPRI_IDLE;
+		return CPUPRI_IDLE;
 	else if (prio >= MAX_RT_PRIO)
-		cpupri = CPUPRI_NORMAL;
+		return CPUPRI_NORMAL;
 	else
-		cpupri = MAX_RT_PRIO - prio + 1;
-
-	return cpupri;
+		return MAX_RT_PRIO - prio + 1;
 }
 
 /**
@@ -95,10 +91,8 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
 		smp_rmb();
 
 		/* Need to do the rmb for every iteration */
-		if (skip)
-			continue;
-
-		if (cpumask_any_and(&p->cpus_allowed, vec->mask) >= nr_cpu_ids)
+		if (skip || cpumask_any_and(&p->cpus_allowed, vec->mask)
+				>= nr_cpu_ids)
 			continue;
 
 		if (lowest_mask) {
@@ -222,7 +216,7 @@ int cpupri_init(struct cpupri *cp)
 	return 0;
 
 cleanup:
-	for (i--; i >= 0; i--)
+	while (--i >= 0)
 		free_cpumask_var(cp->pri_to_cpu[i].mask);
 	return -ENOMEM;
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..acf1b94669ad 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -142,10 +142,12 @@ void free_rt_sched_group(struct task_group *tg)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
 
 	for_each_possible_cpu(i) {
-		if (tg->rt_rq)
-			kfree(tg->rt_rq[i]);
-		if (tg->rt_se)
-			kfree(tg->rt_se[i]);
+		/* Don't need to check if tg->rt_rq[i]
+		 * or tg->rt_se[i] are NULL, since kfree(NULL)
+		 * simply performs no operation
+		 */
+		kfree(tg->rt_rq[i]);
+		kfree(tg->rt_se[i]);
 	}
 
 	kfree(tg->rt_rq);
@@ -1015,10 +1017,7 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 
 	BUG_ON(&rq->rt != rt_rq);
 
-	if (rt_rq->rt_queued)
-		return;
-
-	if (rt_rq_throttled(rt_rq))
+	if (rt_rq->rt_queued || rt_rq_throttled(rt_rq))
 		return;
 
 	if (rt_rq->rt_nr_running) {
@@ -1211,10 +1210,7 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
  */
 static inline bool move_entity(unsigned int flags)
 {
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
-		return false;
-
-	return true;
+	return !((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) == DEQUEUE_SAVE)
 }
 
 static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_array *array)
@@ -1393,7 +1389,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 
 	/* For anything but wake ups, just return the task_cpu */
 	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
-		goto out;
+		return cpu;
 
 	rq = cpu_rq(cpu);
 
@@ -1437,7 +1433,6 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	}
 	rcu_read_unlock();
 
-out:
 	return cpu;
 }
 
@@ -2518,12 +2513,10 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	/*
 	 * Disallowing the root group RT runtime is BAD, it would disallow the
 	 * kernel creating (and or operating) RT threads.
+	 *
+	 * No period doesn't make any sense.
 	 */
-	if (tg == &root_task_group && rt_runtime == 0)
-		return -EINVAL;
-
-	/* No period doesn't make any sense. */
-	if (rt_period == 0)
+	if ((tg == &root_task_group && !rt_runtime) || !rt_period)
 		return -EINVAL;
 
 	mutex_lock(&rt_constraints_mutex);
-- 
2.19.0


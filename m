Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019872081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNIiq1g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019872081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeKHWx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:53:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45426 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeKHWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:53:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so8919451pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8V/ZJ14scYMXRzfZf0OkqJcMiULqs7POoBh75VwKK1c=;
        b=bNIiq1g+/d1AkPZFmBplx0vFD7AX5ax8xQReLJaNIP5A/y48h7fXPB8laAFhU1hdZS
         d8mUQraG7zduHFKyFi176V+Bqbbn0b8X+B1OAejmYqKlyryu6fI+vbXmCblku+/GVDE7
         +dsJTONTfLDA2VMr6CNSvQSvK4aXGdlN8g42IhAxvSQfw1YNoAp6g8B0JAivmDeyHfNe
         fES+WuYHN4UsowIMuRxMouJCvv/vW4wi70wfpvF8eYWmCgdtlStK5QNpKdR4azV0p0ZI
         hLh4eCBfHwQ5U+xvCxReU0wnAsS7dZEjX/3c2CuGvkx5VUA6bAXMYz5Se5EAG0fpbhK9
         jkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8V/ZJ14scYMXRzfZf0OkqJcMiULqs7POoBh75VwKK1c=;
        b=lEE7KEiWbmf9O0KL5SAJGbWEPCy6oDeGTNbOhAMSSuIrgHV1WjINf16pCL2rkkn8LU
         MY+wB1mqWrDHjtTNDGBZA1otpxKDW5quee8luDYPmC3nu25xf58tr4qfJOimo+E/UKmb
         +8LPjP4xe0/8VC0qeXQ5KNSZYGTV05u752fxcd2sID/ZSsELTfQpEVRc6BwE2bxvAkFP
         CV4kfZGJ8TUWYoJGzJW1cd2BsWQj5/RMg6SVZh7lJJAX8tzx7i/q0yIvyYAHvdKZ/044
         jXB2fFyq5mU3sI47+NfjRzYA+B+TcxY6+B6YkHQbCF1UPOIfQWcwac/dASWOVGSTBs66
         SQLA==
X-Gm-Message-State: AGRZ1gKa3lccONU5KZeJRJfImJ9dqrCpXfukIb9LshzvxD732Rwg8sEl
        YSYXJ3p60f9ATI7rUZe1ICTVC7HG8N8=
X-Google-Smtp-Source: AJdET5eS4xTNbyS6QciFw05SueOYYW7QEKV/CX9mlOk33KKk0e8fbzPCzZW/Kv7NY+7IrgAZrqBj7w==
X-Received: by 2002:a62:8208:: with SMTP id w8-v6mr4493399pfd.150.1541683077475;
        Thu, 08 Nov 2018 05:17:57 -0800 (PST)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id d24-v6sm7902778pfe.40.2018.11.08.05.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 05:17:57 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt: Introduce prio_lower() helper for comparing RT task prority
Date:   Thu,  8 Nov 2018 21:17:33 +0800
Message-Id: <20181108131733.45720-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a value to represent the priority of the RT task. But a smaller
value corresponds to a higher priority. If there are two RT task A and B,
their priorities are prio_a and prio_b, respectively. If prio_a is larger
than prio_b, which means that the priority of RT task A is lower than RT
task B. It may seem a bit strange.

In rt.c, there are many if condition of priority comparison. We need to
think carefully about which priority is higher because of this opposite
logic when read those code. So we introduce prio_lower() helper for
comparing RT task prority, which can make code more readable.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/rt.c | 54 ++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9aa3287ce301..4808684607b9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -101,6 +101,15 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
 }
 
+/**
+ * prio_lower(a, b) returns true if the priority a is
+ * lower than the priority b, otherwise return false.
+ */
+static inline bool prio_lower(int a, int b)
+{
+	return a > b;
+}
+
 #ifdef CONFIG_RT_GROUP_SCHED
 static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 {
@@ -262,7 +271,7 @@ static void pull_rt_task(struct rq *this_rq);
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
-	return rq->rt.highest_prio.curr > prev->prio;
+	return prio_lower(rq->rt.highest_prio.curr, prev->prio);
 }
 
 static inline int rt_overloaded(struct rq *rq)
@@ -377,7 +386,7 @@ static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
 	plist_add(&p->pushable_tasks, &rq->rt.pushable_tasks);
 
 	/* Update the highest prio pushable task */
-	if (p->prio < rq->rt.highest_prio.next)
+	if (prio_lower(rq->rt.highest_prio.next, p->prio))
 		rq->rt.highest_prio.next = p->prio;
 }
 
@@ -498,7 +507,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 		else if (!on_rt_rq(rt_se))
 			enqueue_rt_entity(rt_se, 0);
 
-		if (rt_rq->highest_prio.curr < curr->prio)
+		if (prio_lower(curr->prio, rt_rq->highest_prio.curr))
 			resched_curr(rq);
 	}
 }
@@ -1044,7 +1053,7 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 	if (&rq->rt != rt_rq)
 		return;
 #endif
-	if (rq->online && prio < prev_prio)
+	if (rq->online && prio_lower(prev_prio, prio))
 		cpupri_set(&rq->rd->cpupri, rq->cpu, prio);
 }
 
@@ -1079,7 +1088,7 @@ inc_rt_prio(struct rt_rq *rt_rq, int prio)
 {
 	int prev_prio = rt_rq->highest_prio.curr;
 
-	if (prio < prev_prio)
+	if (prio_lower(prev_prio, prio))
 		rt_rq->highest_prio.curr = prio;
 
 	inc_rt_prio_smp(rt_rq, prio, prev_prio);
@@ -1092,7 +1101,7 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 
 	if (rt_rq->rt_nr_running) {
 
-		WARN_ON(prio < prev_prio);
+		WARN_ON(prio_lower(prev_prio, prio));
 
 		/*
 		 * This may have been our highest task, and therefore
@@ -1424,7 +1433,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 	 */
 	if (curr && unlikely(rt_task(curr)) &&
 	    (curr->nr_cpus_allowed < 2 ||
-	     curr->prio <= p->prio)) {
+	     !prio_lower(curr->prio, p->prio))) {
 		int target = find_lowest_rq(p);
 
 		/*
@@ -1432,7 +1441,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
 		 * not running a lower priority task.
 		 */
 		if (target != -1 &&
-		    p->prio < cpu_rq(target)->rt.highest_prio.curr)
+		    prio_lower(cpu_rq(target)->rt.highest_prio.curr, p->prio))
 			cpu = target;
 	}
 	rcu_read_unlock();
@@ -1475,7 +1484,7 @@ static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
  */
 static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	if (prio_lower(rq->curr->prio, p->prio)) {
 		resched_curr(rq);
 		return;
 	}
@@ -1732,7 +1741,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 
 		lowest_rq = cpu_rq(cpu);
 
-		if (lowest_rq->rt.highest_prio.curr <= task->prio) {
+		if (!prio_lower(lowest_rq->rt.highest_prio.curr, task->prio)) {
 			/*
 			 * Target rq has tasks of equal or higher priority,
 			 * retrying does not release any lock and is unlikely
@@ -1763,7 +1772,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		}
 
 		/* If this rq is still suitable use it. */
-		if (lowest_rq->rt.highest_prio.curr > task->prio)
+		if (prio_lower(lowest_rq->rt.highest_prio.curr, task->prio))
 			break;
 
 		/* try again */
@@ -1823,7 +1832,7 @@ static int push_rt_task(struct rq *rq)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(prio_lower(rq->curr->prio, next_task->prio))) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2100,8 +2109,8 @@ static void pull_rt_task(struct rq *this_rq)
 		 * logically higher, the src_rq will push this task away.
 		 * And if its going logically lower, we do not care
 		 */
-		if (src_rq->rt.highest_prio.next >=
-		    this_rq->rt.highest_prio.curr)
+		if (!prio_lower(this_rq->rt.highest_prio.curr,
+				src_rq->rt.highest_prio.next))
 			continue;
 
 		/*
@@ -2121,7 +2130,7 @@ static void pull_rt_task(struct rq *this_rq)
 		 * Do we have an RT task that preempts
 		 * the to-be-scheduled task?
 		 */
-		if (p && (p->prio < this_rq->rt.highest_prio.curr)) {
+		if (p && prio_lower(this_rq->rt.highest_prio.curr, p->prio)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!task_on_rq_queued(p));
 
@@ -2133,7 +2142,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (prio_lower(src_rq->curr->prio, p->prio))
 				goto skip;
 
 			resched = true;
@@ -2167,7 +2176,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	    p->nr_cpus_allowed > 1 &&
 	    (dl_task(rq->curr) || rt_task(rq->curr)) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     rq->curr->prio <= p->prio))
+	     !prio_lower(rq->curr->prio, p->prio)))
 		push_rt_tasks(rq);
 }
 
@@ -2242,7 +2251,8 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (prio_lower(rq->curr->prio, p->prio) &&
+		    cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2263,18 +2273,18 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * If our priority decreases while running, we
 		 * may need to pull tasks to this runqueue.
 		 */
-		if (oldprio < p->prio)
+		if (prio_lower(p->prio, oldprio))
 			rt_queue_pull_task(rq);
 
 		/*
 		 * If there's a higher priority task waiting to run
 		 * then reschedule.
 		 */
-		if (p->prio > rq->rt.highest_prio.curr)
+		if (prio_lower(p->prio, rq->rt.highest_prio.curr))
 			resched_curr(rq);
 #else
 		/* For UP simply resched on drop of prio */
-		if (oldprio < p->prio)
+		if (prio_lower(p->prio, oldprio))
 			resched_curr(rq);
 #endif /* CONFIG_SMP */
 	} else {
@@ -2283,7 +2293,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (prio_lower(rq->curr->prio, p->prio))
 			resched_curr(rq);
 	}
 }
-- 
2.17.1


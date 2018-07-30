Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2645B1625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8E720857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqV82ha+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8E720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbeG3Tcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:32:48 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37118 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeG3Tcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:32:47 -0400
Received: by mail-wr1-f46.google.com with SMTP id q10-v6so13832506wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=g3Fkqx9ToXgzu3qIFwiEKQD3qnol5qi/F3xjC2PBess=;
        b=fqV82ha+flvRYpeCm9DcrdnQ6G1s1aAw2X+pibK1XysfsMInhefwq94SG45S7DMV4u
         yt86+3sR9I0+1LVlcTkFWtI9lYXvQhTQv84u8NqcT3ToKwMvReU87CRFlZcHn/IoZp3y
         kpNAppJT1qiW6VPMa1R0ezkaVqNSp1OzHhg2G56kQ2rUB0QdfxS5ssYliNvSALtMjY6O
         Wiabgg5Q/xLw/OMA7juN2Gnf0DjvlnKtVaP61DCE8Iv4U+mSRyC+zlAR2XK5KtB/8gZO
         iFXf6UGHCSZGHwpT1fP5Pu/TAgIZFb+sgGUw9LYCfp1n/iwPOazkHfRO8kOY87mUKUwV
         oq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=g3Fkqx9ToXgzu3qIFwiEKQD3qnol5qi/F3xjC2PBess=;
        b=OCuIpQYftIS2MVgzeOiNdgA7dwvaVOyxmvU5/uJ56WXwVDTg8n7bm2vMV2GpaTCshi
         j1TExsSymUxGtKB4NuSZE0+nkyzKX0VZoXT0gzLaa4/aJP8K8LlV7z/LkduzmZGWNQL8
         LK2dwkHhzwhi3W07nnq8dGvVGXgWNdZLBk9fCstBBtUQ6OTSGvDrikQeepXU+APjyyJL
         OCwul5PIRxGU90prcPAs1AfFxa8rG71wYZox4S7mIWF1O1Qjqr48+/Q9c6G013DiYDPl
         1LwqVtQE3K8XWp4rC2XmGF8zLWxwRZmoqxCDA1vPCAbH4nxkHwSkOMiOu7350YsRc7Xr
         8AqQ==
X-Gm-Message-State: AOUpUlEe0fYa5geiWUsm2uiG0Mv6bdEOsRJjrEA4J/PGXU7Vhsza/Je6
        p50sMiSopgw4mN04Oejefm0=
X-Google-Smtp-Source: AAOMgpfaAb3qS9P605SNug7YMCs8EKvZUJlDcu1S6HkeZqEiEeCM1VmXuwu8m6SeXD7vjpM3ELrS9w==
X-Received: by 2002:adf:ec41:: with SMTP id w1-v6mr18501520wrn.128.1532973398419;
        Mon, 30 Jul 2018 10:56:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x184-v6sm206068wmg.24.2018.07.30.10.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:56:37 -0700 (PDT)
Date:   Mon, 30 Jul 2018 19:56:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20180730175635.GA2954@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: f3d133ee0a17d5694c6f21873eec9863e11fa423 sched/rt: Restore rt_runtime after disabling RT_RUNTIME_SHARE

Misc fixes:

 - a deadline scheduler related bug fix which triggered a kernel warning
 - an RT_RUNTIME_SHARE fix
 - a stop_machine preemption fix
 - a potential NULL dereference fix in sched_domain_debug_one()

 Thanks,

	Ingo

------------------>
Daniel Bristot de Oliveira (1):
      sched/deadline: Update rq_clock of later_rq when pushing a task

Hailong Liu (1):
      sched/rt: Restore rt_runtime after disabling RT_RUNTIME_SHARE

Isaac J. Manjarres (1):
      stop_machine: Disable preemption after queueing stopper threads

Yi Wang (1):
      sched/topology: Check variable group before dereferencing it


 kernel/sched/deadline.c |  8 +++++++-
 kernel/sched/rt.c       |  2 ++
 kernel/sched/topology.c |  2 +-
 kernel/stop_machine.c   | 10 +++++++++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 10c7b51c0d1f..b5fbdde6afa9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2090,8 +2090,14 @@ static int push_dl_task(struct rq *rq)
 	sub_rq_bw(&next_task->dl, &rq->dl);
 	set_task_cpu(next_task, later_rq->cpu);
 	add_rq_bw(&next_task->dl, &later_rq->dl);
+
+	/*
+	 * Update the later_rq clock here, because the clock is used
+	 * by the cpufreq_update_util() inside __add_running_bw().
+	 */
+	update_rq_clock(later_rq);
 	add_running_bw(&next_task->dl, &later_rq->dl);
-	activate_task(later_rq, next_task, 0);
+	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
 	ret = 1;
 
 	resched_curr(later_rq);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 572567078b60..eaaec8364f96 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -836,6 +836,8 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		 * can be time-consuming. Try to avoid it when possible.
 		 */
 		raw_spin_lock(&rt_rq->rt_runtime_lock);
+		if (!sched_feat(RT_RUNTIME_SHARE) && rt_rq->rt_runtime != RUNTIME_INF)
+			rt_rq->rt_runtime = rt_b->rt_runtime;
 		skip = !rt_rq->rt_time && !rt_rq->rt_nr_running;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 		if (skip)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a831427bc7..56a0fed30c0a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -47,7 +47,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 	if (!cpumask_test_cpu(cpu, sched_domain_span(sd))) {
 		printk(KERN_ERR "ERROR: domain->span does not contain CPU%d\n", cpu);
 	}
-	if (!cpumask_test_cpu(cpu, sched_group_span(group))) {
+	if (group && !cpumask_test_cpu(cpu, sched_group_span(group))) {
 		printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
 	}
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 1ff523dae6e2..e190d1ef3a23 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -260,6 +260,15 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	err = 0;
 	__cpu_stop_queue_work(stopper1, work1, &wakeq);
 	__cpu_stop_queue_work(stopper2, work2, &wakeq);
+	/*
+	 * The waking up of stopper threads has to happen
+	 * in the same scheduling context as the queueing.
+	 * Otherwise, there is a possibility of one of the
+	 * above stoppers being woken up by another CPU,
+	 * and preempting us. This will cause us to n ot
+	 * wake up the other stopper forever.
+	 */
+	preempt_disable();
 unlock:
 	raw_spin_unlock(&stopper2->lock);
 	raw_spin_unlock_irq(&stopper1->lock);
@@ -271,7 +280,6 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	}
 
 	if (!err) {
-		preempt_disable();
 		wake_up_q(&wakeq);
 		preempt_enable();
 	}

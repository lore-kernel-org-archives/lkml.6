Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2054ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8205C206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd9U0oc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8205C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeIOSji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:39:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55150 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeIOSji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:39:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id c14-v6so4754733wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TS8i43bcwpRa36NotChKmxqJUKcEQvUeQbp3fUgkKzQ=;
        b=hd9U0oc7MG8RWRqR1P5kR/56ImgDEZ8mIdYzNcP8faEyBL4gMa4maMS+Hx3Rh3gQD7
         pnKADyKbhmglsl6MIyYS2B+2w8rdM1YgGla0uRSu/LR8JLMSuKqVmt8x9Mh6PirKLiVA
         nH6CT980dMlmRGpJ94cbc+uFLl7O9GetqdrJEHLkNt6GT0h9MfK19t9u4kjadFN7pvpn
         Vhn2uGQej+pMa7tEtd8wRvDhMGx/A9wnuF0y1a31gD/KZfyytQAR+7wPNAKGK9mW+CBq
         Ynav+YUz2gAaghgsVG5h6TQmcbXXRDJzqVwyUlrH+QvTRhs0oTVfCCOBNHF7RdbMTMGK
         tu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=TS8i43bcwpRa36NotChKmxqJUKcEQvUeQbp3fUgkKzQ=;
        b=IvPW/gipaW9rWxMtWJhaPN21CQ+AEaPDwp5MoFM/uWKvNm1HnyjpQ20WWsQb9qSzMG
         oyhXqALobfVs1wRfCOTTRW4CQptQHAUAS5rXFkjGMaVmD2HfEiSsK4kbOPmyCIn+LYW+
         JI5Y00+5mJ9VX7mH8BosNmcv48cQoZGy7GREAds+yTdRp1H5QqQlxgagKEjfYoNqYphy
         xKRPWW4nmKneOech4kyZnSNU4OsdE1LK3Buoscl0BP7DT7qsTAkVVvi2u9jvNqZi8HSE
         95a5hpXTfLIR7aqYjZMXqz0hC/qS9dtlx3dXzziaeW1ozGNDNqpWO1iAUkmw19UiMGJt
         quAQ==
X-Gm-Message-State: APzg51BelQ9YFxyB7e1zfaOjjqfdKrZlPp4Ve6rc3Oq7FiBQyF8C9kxc
        j15NirvzW8JBGKM713cBeed9trXZ
X-Google-Smtp-Source: ANB0VdYLE026Zlg7GpI6ACKAFi7Prj2r7hB5nJ1+oh4P25NLWWqusdcto+BG5NkUvLkiHdEvlFunrg==
X-Received: by 2002:a1c:1314:: with SMTP id 20-v6mr5660221wmt.55.1537017637213;
        Sat, 15 Sep 2018 06:20:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 139-v6sm2705837wmp.4.2018.09.15.06.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 06:20:36 -0700 (PDT)
Date:   Sat, 15 Sep 2018 15:20:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20180915132034.GA126875@gmail.com>
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

   # HEAD: 882a78a9f39f5535b209b4aa0a1741e35b8c67fb sched/fair: Fix kernel-doc notation warning

Misc fixes: various scheduler metrics corner case fixes, a sched_features deadlock fix, and a 
topology fix for certain NUMA systems.

 Thanks,

	Ingo

------------------>
Jiada Wang (1):
      sched/debug: Fix potential deadlock when writing to sched_features

Randy Dunlap (1):
      sched/fair: Fix kernel-doc notation warning

Srikar Dronamraju (1):
      sched/topology: Set correct NUMA topology type

Steve Muckle (1):
      sched/fair: Fix vruntime_normalized() for remote non-migration wakeup

Vincent Guittot (3):
      sched/pelt: Fix update_blocked_averages() for RT and DL classes
      sched/fair: Fix scale_rt_capacity() for SMT
      sched/fair: Fix load_balance redo for !imbalance


 kernel/sched/debug.c    |  6 ++++--
 kernel/sched/fair.c     | 26 +++++++++++++++++---------
 kernel/sched/topology.c |  5 +----
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 60caf1fb94e0..6383aa6a60ca 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -89,12 +89,12 @@ struct static_key sched_feat_keys[__SCHED_FEAT_NR] = {
 
 static void sched_feat_disable(int i)
 {
-	static_key_disable(&sched_feat_keys[i]);
+	static_key_disable_cpuslocked(&sched_feat_keys[i]);
 }
 
 static void sched_feat_enable(int i)
 {
-	static_key_enable(&sched_feat_keys[i]);
+	static_key_enable_cpuslocked(&sched_feat_keys[i]);
 }
 #else
 static void sched_feat_disable(int i) { };
@@ -146,9 +146,11 @@ sched_feat_write(struct file *filp, const char __user *ubuf,
 
 	/* Ensure the static_key remains in a consistent state */
 	inode = file_inode(filp);
+	cpus_read_lock();
 	inode_lock(inode);
 	ret = sched_feat_set(cmp);
 	inode_unlock(inode);
+	cpus_read_unlock();
 	if (ret < 0)
 		return ret;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..f808ddf2a868 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3362,6 +3362,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * attach_entity_load_avg - attach this entity to its cfs_rq load avg
  * @cfs_rq: cfs_rq to attach to
  * @se: sched_entity to attach
+ * @flags: migration hints
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.
@@ -7263,6 +7264,7 @@ static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
+	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
 
@@ -7299,8 +7301,10 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7365,13 +7369,16 @@ static inline void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
+	const struct sched_class *curr_class;
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
@@ -7482,10 +7489,10 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 	return load_idx;
 }
 
-static unsigned long scale_rt_capacity(int cpu)
+static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long max = arch_scale_cpu_capacity(sd, cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -7507,7 +7514,7 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = scale_rt_capacity(cpu);
+	unsigned long capacity = scale_rt_capacity(sd, cpu);
 	struct sched_group *sdg = sd->groups;
 
 	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
@@ -8269,7 +8276,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
 	calculate_imbalance(env, &sds);
-	return sds.busiest;
+	return env->imbalance ? sds.busiest : NULL;
 
 out_balanced:
 	env->imbalance = 0;
@@ -9638,7 +9645,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+	if (!se->sum_exec_runtime ||
+	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
 	return false;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed30c0a..505a41c42b96 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1295,7 +1295,7 @@ static void init_numa_topology_type(void)
 
 	n = sched_max_numa_distance;
 
-	if (sched_domains_numa_levels <= 1) {
+	if (sched_domains_numa_levels <= 2) {
 		sched_numa_topology_type = NUMA_DIRECT;
 		return;
 	}
@@ -1380,9 +1380,6 @@ void sched_init_numa(void)
 			break;
 	}
 
-	if (!level)
-		return;
-
 	/*
 	 * 'level' contains the number of unique distances
 	 *

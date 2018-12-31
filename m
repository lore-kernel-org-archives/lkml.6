Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B9621019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546268314;
	bh=QNRR7mUYdWtyNondrKOrfdQ3wwpJF6/asvNWoUpBAbE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fgORzCY4Y3ioPqJ/CgPRm1nTUXVBHswOgQvNyT1lEtIscQyAeaoXhPfHwg8vC0qU2
	 uTWgJySCpcnPDXTy1HWrXgKDVyRYP85dqmcZfNp2oKN/HFmGvnul6IzRujsGmZ5qH2
	 BoPrKXF+8qnAlclxAXaqVT1Yz4iVs7+VFg3OkxpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeLaO6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 09:58:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33390 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeLaO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 09:58:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so26703466wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=87p4ezP6YjxP/6VQz9vlXCNa3XIbAyRg3Cg8e+LS1NA=;
        b=Wg4n/wghy5Ag6tWB81lVe+v+cVZykuIaBYPEd1yIJ1o6k7nZwuSuQ0cPG7jIh5GjaZ
         JX7NwaOHxi0Tny65hKJW/JjLTGauuj+7/jpvLEDKNSZa+tk3yLYbrAJTa2LsJ0gZMJw5
         cLYQN1ixXL94l1ukZwWgGvPqCXjrCnoFNXZ9v0u+oftg8FPq1U7LDCoPEsum5thQ6O97
         5NKX4B/dNXTWlZAQPcjtFjmWqATDtlsfnyyQUemi/VcCGhYwWaWqCBeKb+kPPhlRZBlz
         usxpZ1ffrGKs07FJj+HTyytIZpVSC+YvuL8uhQoGbtOdcIIBqCZjNYEJaebcCyWf70A3
         Mz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=87p4ezP6YjxP/6VQz9vlXCNa3XIbAyRg3Cg8e+LS1NA=;
        b=iIOBysyuMadlKRy1J2cp0Q97BU//yvVL6DR7qm7GVB001KE84wWGMfTZR77MF7OcLY
         mn9H38Tve4MIScoyYA7dn3VLb6hTqor0AinK3qRwVjB8OzIY3/p+a75h2ziYT6fJ2oDb
         j1SD3clT/lkdgimBOGNDIas8VmbEw9DVKI72PVbwCrfaV6ecoA2fm+Le7/uTmpGfE70+
         7oi6ch5tKW3vy0QZFYsYrk0OOaDpN27Ynmk5ZcK/RSiGT7zIXDY9nLQ6igjiUnM9t2Xg
         izmJhW2xmxqeUMJFepD5Wqn4g/eySLmU+unoq1ESAbZVUs+nDPk2XBI/j5VwBi04ohgf
         wxlw==
X-Gm-Message-State: AJcUukfaDCxC+vdj5OxGzT+IGbqsWSex5A6bttyywADgfYcGiEVo6Qjm
        CNcWukZXysJqLe6mVNRtpcs=
X-Google-Smtp-Source: ALg8bN5I+DkzWV8kue6hFTAg+UarbYmPnSCxXAOtTTAroT2X5fNDDG1CwbVVW3c1JYZfrpMmKC9NSw==
X-Received: by 2002:adf:f009:: with SMTP id j9mr32750884wro.170.1546268310083;
        Mon, 31 Dec 2018 06:58:30 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w18sm31352479wru.54.2018.12.31.06.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 06:58:29 -0800 (PST)
Date:   Mon, 31 Dec 2018 15:58:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20181231145827.GA83750@gmail.com>
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

   # HEAD: c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c

This is a revert for a lockup in cgroups-intense workloads - the real 
fixes will come later.

Happy new year,

	Ingo

------------------>
Linus Torvalds (1):
      sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c


 kernel/sched/fair.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d1907506318a..6483834f1278 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -352,10 +352,9 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 }
 
-/* Iterate thr' all leaf cfs_rq's on a runqueue */
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
-	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
-				 leaf_cfs_rq_list)
+/* Iterate through all leaf cfs_rq's on a runqueue: */
+#define for_each_leaf_cfs_rq(rq, cfs_rq) \
+	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
 
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
@@ -447,8 +446,8 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 }
 
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
-		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
+#define for_each_leaf_cfs_rq(rq, cfs_rq)	\
+		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
@@ -7647,27 +7646,10 @@ static inline bool others_have_blocked(struct rq *rq)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-	if (cfs_rq->load.weight)
-		return false;
-
-	if (cfs_rq->avg.load_sum)
-		return false;
-
-	if (cfs_rq->avg.util_sum)
-		return false;
-
-	if (cfs_rq->avg.runnable_load_sum)
-		return false;
-
-	return true;
-}
-
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
@@ -7679,7 +7661,7 @@ static void update_blocked_averages(int cpu)
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+	for_each_leaf_cfs_rq(rq, cfs_rq) {
 		struct sched_entity *se;
 
 		/* throttled entities do not contribute to load */
@@ -7694,13 +7676,6 @@ static void update_blocked_averages(int cpu)
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
-		/*
-		 * There can be a lot of idle CPU cgroups.  Don't let fully
-		 * decayed cfs_rqs linger on the list.
-		 */
-		if (cfs_rq_is_decayed(cfs_rq))
-			list_del_leaf_cfs_rq(cfs_rq);
-
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
@@ -10570,10 +10545,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
+	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }

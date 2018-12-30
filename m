Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CF2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D72120855
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546173082;
	bh=8pTCAoRnt8S7HrQuC6gG75by8JEcfK4EFYqwmtU8+FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j24bcQb2Xe9w3HRB+6gq1/hdwPp63Sy8R0gCLJgu1iFjWiEI71VaNGTo3SyFmO3Zc
	 wORG0CK0gJwqXeuYbAIYLxtTDsvDyT7IsHWtcazqmo3XVo+po0vUdOtTNipmWFbSqk
	 SAZU4nZEapI8d0z8pStUNmGT0DkFz5RXYVv8qcVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeL3MbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 07:31:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41465 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeL3MbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 07:31:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so24587104wrs.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 04:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YfBTsleZJvSk290gRhaTuj5wkeRjt3sAoiYA+5MeCFo=;
        b=HWeZeXBaSNUFNpk7XLopWx1WyNLoJpb6esUqI1F2rTylJqbU7h7VZcSbkJQkEE8aak
         OAMdB2uNc57qA8OSQAJ9/9FQmliIz47oUW889KJwkCJVRAj6jgSgdBWycEXWXNH5WhN6
         mn3MkOiaQsoupMnJGJM4H7BQtvJwiudvizoUciM8M0x4cGFLSUVOA+JRA7Po+YVqK4ZZ
         z+7h93+8wlOEs2klqhdh+d7gBbKFuOZAzjF8hw7Mf+eaTy4AVNIyHb+trw0RiMink2HW
         VNuGrcnxmIzZwsj1+Y5geeEFzB0layou/jsVnEOmQynCDDdj20boj/ZeH51zbcCoJ9HA
         ZJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YfBTsleZJvSk290gRhaTuj5wkeRjt3sAoiYA+5MeCFo=;
        b=BMD1V0haHHaIljygZoOfdNOQSZElnKFVr53rzmSyArmVxz5V3KudAi0YBo5cI46lqP
         e1tcs3RHPFWTF8NTah01IwIwcJ0S8lT7fITuy7zm4wdD47j/WJBrnAeg97Eiw8Ilfl07
         totmqaki0N1JtEVYzFw+4V3gbh7SLmL4771ie69dC6YR2JdYC3LwE105zdUHNSZ45wAI
         Bdff3pgPcr2XgAuCQDwKk79VBajWYXwyF512/kSVXHH3o5Mi3Ui2uuXS4N+MvP5m2/UC
         T88u+GzYayHfiGzJ4OB+Gf1r9gKbKDpI75jazDO58XztV27u5En2XLv6G2vSqHEZLk4I
         yIwg==
X-Gm-Message-State: AJcUukfnBaYx0W0eAy9awbIm2TDr2edFqvj6eIzf3VcT/JR9CATTtNQl
        +cKMUpzEj6IlLUtIgQIyMq0=
X-Google-Smtp-Source: ALg8bN7zAXVCUUMlplYoM/PztkHxGoDpMe/bYja8lQl29Td2JmC8VdeW2wFSrRKIOm/To+vZBa2PUA==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr31544623wrm.218.1546173078129;
        Sun, 30 Dec 2018 04:31:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 126sm25687471wmd.1.2018.12.30.04.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 04:31:17 -0800 (PST)
Date:   Sun, 30 Dec 2018 13:31:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xie XiuQi <xiexiuqi@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject:  [PATCH] sched: Fix infinite loop in update_blocked_averages() by
 reverting a9e7f6544b9c
Message-ID: <20181230123115.GB17231@gmail.com>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181230120435.GA17231@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230120435.GA17231@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
> 
> > > Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> > > Cc: Bin Li <huawei.libin@huawei.com>
> > > Cc: <stable@vger.kernel.org>        [4.10+]
> > > Fixes: 9c2791f936ef (sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list)
> > 
> > If it only happens in update_blocked_averages(), the del leaf has been added by:
> > a9e7f6544b9c (sched/fair: Fix O(nr_cgroups) in load balance path)
> 
> So I think until we are confident in the proposed fixes, how about 
> applying Linus's patch that reverts a9e7f6544b9c and simplifies the list 
> manipulation?
> 
> That way we can re-introduce the O(nr_cgroups) optimization without 
> pressure.
> 
> I'll prepare a commit for sched/urgent that does this, please holler if 
> any of you disagrees!

I've applied the patch below to tip:sched/urgent and I'll push it out if 
all goes well in testing:

  1e2adc76e619: ("sched: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")

I've preemptively added the Tested-by tags of the gents who found and 
analyzed this bug:

  Tested-by: Zhipeng Xie <xiezhipeng1@huawei.com>
  Tested-by: Sargun Dhillon <sargun@sargun.me>

... in the assumption that you'll do the testing of Linus's fix to make 
sure it's all good!

[ Will probably update the commit with acks and any other feedback before
  sending it to Linus tomorrow-ish. We don't want to end 2018 with a
  known scheduler bug in the upstream tree! ;-) ]

Thanks,

	Ingo

===========================>
From 1e2adc76e61924cdfd9dc50c728044d0fbbade27 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Dec 2018 13:46:17 -0800
Subject: [PATCH] sched: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c

Zhipeng Xie, Xie XiuQi and Sargun Dhillon reported lockups in the
scheduler under high loads, starting at around the v4.18 time frame,
and Zhipeng Xie tracked it down to bugs in the rq->leaf_cfs_rq_list
manipulation.

Do a (manual) revert of:

  a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")

It turns out that the list_del_leaf_cfs_rq() introduced by this commit
is a surprising property that was not considered in followup commits
such as:

  9c2791f936ef ("sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list")

As Vincent Guittot explains:

 "I think that there is a bigger problem with commit a9e7f6544b9c and
  cfs_rq throttling:

  Let take the example of the following topology TG2 --> TG1 --> root:

   1) The 1st time a task is enqueued, we will add TG2 cfs_rq then TG1
      cfs_rq to leaf_cfs_rq_list and we are sure to do the whole branch in
      one path because it has never been used and can't be throttled so
      tmp_alone_branch will point to leaf_cfs_rq_list at the end.

   2) Then TG1 is throttled

   3) and we add TG3 as a new child of TG1.

   4) The 1st enqueue of a task on TG3 will add TG3 cfs_rq just before TG1
      cfs_rq and tmp_alone_branch will stay  on rq->leaf_cfs_rq_list.

  With commit a9e7f6544b9c, we can del a cfs_rq from rq->leaf_cfs_rq_list.
  So if the load of TG1 cfs_rq becomes NULL before step 2) above, TG1
  cfs_rq is removed from the list.
  Then at step 4), TG3 cfs_rq is added at the beginning of rq->leaf_cfs_rq_list
  but tmp_alone_branch still points to TG3 cfs_rq because its throttled
  parent can't be enqueued when the lock is released.
  tmp_alone_branch doesn't point to rq->leaf_cfs_rq_list whereas it should.

  So if TG3 cfs_rq is removed or destroyed before tmp_alone_branch
  points on another TG cfs_rq, the next TG cfs_rq that will be added,
  will be linked outside rq->leaf_cfs_rq_list - which is bad.

  In addition, we can break the ordering of the cfs_rq in
  rq->leaf_cfs_rq_list but this ordering is used to update and
  propagate the update from leaf down to root."

Instead of trying to work through all these cases and trying to reproduce
the very high loads that produced the lockup to begin with, simplify
the code temporarily by reverting a9e7f6544b9c - which change was clearly
not thought through completely.

This (hopefully) gives us a kernel that doesn't lock up so people
can continue to enjoy their holidays without worrying about regressions. ;-)

[ mingo: Wrote changelog, fixed weird spelling in code comment while at it. ]

Analyzed-by: Xie XiuQi <xiexiuqi@huawei.com>
Analyzed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Reported-by: Sargun Dhillon <sargun@sargun.me>
Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
Tested-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Tested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org> # v4.13+
Cc: Bin Li <huawei.libin@huawei.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
Link: http://lkml.kernel.org/r/1545879866-27809-1-git-send-email-xiexiuqi@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
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

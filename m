Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11999C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6E02086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="o06I+BDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6E02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeK0DCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:02:01 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36527 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeK0DCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:02:00 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so18114976qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V42z0qJgdnwUPv+HS4SpkdUqUaqky7CY6cO/uNfm3SU=;
        b=o06I+BDa/BTsP6r/jiO214owL83CDPwVWmHGiiKHjeaXYiSX2GYYbOLtuXybAII8Z9
         x3K4EwiScEkG2PQcpEmLU3v6h0VBJbKB1RIa0jY6/OTSrtu/G9cLzQk++V7bbuhXvHPS
         +QeSU9PWZ4SI3C5zOgOdZp0QV6HRo5NxDeSpJCp35EyUSVwFQlj1zmkDcoP/6wyPQdaP
         ZnmBTUlR7iADtRtXUzv2bofX4MRxNx9zZQQ/EvM+v+uT7RsWV3JD9QNbGkvAk6M/Gb9k
         I1B6VvwDrRBsh6AIUcTuIr3qnRyrgeITxgCgu+roHJuOIYrInBSqpnFd37tu/1po9uVe
         EAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V42z0qJgdnwUPv+HS4SpkdUqUaqky7CY6cO/uNfm3SU=;
        b=BJvp+3mDyXKaz8G7a3m2bup57GB6vK43v+OHHypJm3KtsLxApS2Knx8x5gnLKRbI7V
         cEedWsI283uSt/3/CWOCEyGh3Jw7CVoyY5KmOdabeoSkHRVcOTVW4ply5oe8sl0NV5a8
         mdY1MebvnpEtEwjsFIlcUhL152Qry1HfzL6S4xSvdsPxDaDFWJirLDykg6n2e2I3LOWk
         U/OF9nWSPCT9ClXsCIWwoqkJ3AUHQ8+1pZdqTEm5T2H4Zzvgv5FiF9itkxki3FyrCiyk
         VSBVkm2+Y1c3zpK9e7UzjOydf+YudMT5BvUxwdzPUZRWGLvqPtpEfHUTtQvm2e4SVP9/
         pgOg==
X-Gm-Message-State: AGRZ1gJOg+ytW59S7VRZcIgFEFxMC0rv48SIamnj77cUBJHlfl3oxVT9
        VVQmLRtS1ATPISr6peDBhMkPTw==
X-Google-Smtp-Source: AJdET5d0rI9E12wu5z9nHEzHdwXjl/Lhnf5OD/egeKDCy3c/UsXfY9X/K5sDqvFTkntNfKQvLScIzw==
X-Received: by 2002:ac8:47c2:: with SMTP id d2mr26660258qtr.311.1543248447153;
        Mon, 26 Nov 2018 08:07:27 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id v32sm598310qta.37.2018.11.26.08.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:07:26 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:07:24 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: Hackbench pipes regression bisected to PSI
Message-ID: <20181126160724.GA21268@cmpxchg.org>
References: <20181126133420.GN23260@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126133420.GN23260@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Mon, Nov 26, 2018 at 01:34:20PM +0000, Mel Gorman wrote:
> Hi Johannes,
> 
> PSI is a great idea but it does have overhead and if enabled by Kconfig
> then it incurs a hit whether the user is aware of the feature or not. I
> think enabling by default is unnecessary as it should only be enabled if
> the information is being consumed. While the Kconfig exists, it's all or
> nothing if distributions want to have the feature available.

Yes, let's make this easier to pick and choose. Obviously I'd rather
you shipped it default-disabled than not at all.

> I've included a bisection report below showing a 6-10% regression on a
> single socket skylake machine. Would you mind doing one or all of the
> following to fix it please?
> 
> a) disable it by default
> b) put psi_disable behind a static branch to move the overhead to zero
>    if it's disabled
> c) optionally enable/disable at runtime (least important as at a glance,
>    this may be problematic)

For a) I'd suggest we do what we do in other places that face this
vendor kernel trade-off (NUMA balancing comes to mind): one option to
build the feature, one option to set whether the default is on or off.

And b) is pretty straight-forward, let's do that too.

c) is not possible, as we need the complete task counts to calculate
pressure, and maintaining those counts are where the sched cost is.

> Last good/First bad commit
> ==========================
> Last good commit: eb414681d5a07d28d2ff90dc05f69ec6b232ebd2
> First bad commit: 2ce7135adc9ad081aa3c49744144376ac74fea60
> From 2ce7135adc9ad081aa3c49744144376ac74fea60 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 26 Oct 2018 15:06:31 -0700
> Subject: [PATCH] psi: cgroup support
> On a system that executes multiple cgrouped jobs and independent
> workloads, we don't just care about the health of the overall system, but
> also that of individual jobs, so that we can ensure individual job health,
> fairness between jobs, or prioritize some jobs over others.
> This patch implements pressure stall tracking for cgroups.  In kernels
> with CONFIG_PSI=y, cgroup2 groups will have cpu.pressure, memory.pressure,
> and io.pressure files that track aggregate pressure stall times for only
> the tasks inside the cgroup.

It's curious that the cgroup support patch is the offender, not the
psi patch itself (that adds some cost as per the hackbench results,
but not as much). What kind of cgroup setup does this code run in?

Anyway, how about the following?

From 6ae33455b8083fc9f5d5fbfe971f70253b0dbacd Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 26 Nov 2018 09:39:23 -0500
Subject: [PATCH] psi: make disabling/enabling easier for vendor kernels

Mel Gorman reports a hackbench regression with psi that would prohibit
shipping the suse kernel with it default-enabled, but he'd still like
users to be able to opt in at little to no cost to others.

With the current combination of CONFIG_PSI and the psi_disabled bool
set from the commandline, this is a challenge. Do the following things
to make it easier:

1. Add a config option CONFIG_PSI_DEFAULT_ENABLED that allows distros
   to enable CONFIG_PSI in their kernel, but leaving the feature
   disabled unless a user requests it at boot-time.

   To avoid double negatives, rename psi_disabled= to psi_enable=.

2. Make psi_disabled a static branch to eliminate any branch costs
   when the feature is disabled.

Reported-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi.h  |  3 ++-
 init/Kconfig         |  9 +++++++++
 kernel/sched/psi.c   | 30 +++++++++++++++++++++---------
 kernel/sched/stats.h |  8 ++++----
 4 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 8e0725aac0aa..7006008d5b72 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_PSI_H
 #define _LINUX_PSI_H
 
+#include <linux/jump_label.h>
 #include <linux/psi_types.h>
 #include <linux/sched.h>
 
@@ -9,7 +10,7 @@ struct css_set;
 
 #ifdef CONFIG_PSI
 
-extern bool psi_disabled;
+extern struct static_key_false psi_disabled;
 
 void psi_init(void);
 
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..cf5b5a0dcbc2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -509,6 +509,15 @@ config PSI
 
 	  Say N if unsure.
 
+config PSI_DEFAULT_DISABLED
+	bool "Require boot parameter to enable pressure stall information tracking"
+	default n
+	depends on PSI
+	help
+	  If set, pressure stall information tracking will be disabled
+	  per default but can be enabled through passing psi_enable=1
+	  on the kernel commandline during boot.
+
 endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 3d7355d7c3e3..9da0af3cd898 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -136,8 +136,18 @@
 
 static int psi_bug __read_mostly;
 
-bool psi_disabled __read_mostly;
-core_param(psi_disabled, psi_disabled, bool, 0644);
+DEFINE_STATIC_KEY_FALSE(psi_disabled);
+
+#ifdef CONFIG_PSI_DEFAULT_DISABLED
+bool psi_enable;
+#else
+bool psi_enable = true;
+#endif
+static int __init parse_psi_enable(char *str)
+{
+	return kstrtobool(str, &psi_enable) == 0;
+}
+__setup("psi_enable=", parse_psi_enable);
 
 /* Running averages - we need to be higher-res than loadavg */
 #define PSI_FREQ	(2*HZ+1)	/* 2 sec intervals */
@@ -169,8 +179,10 @@ static void group_init(struct psi_group *group)
 
 void __init psi_init(void)
 {
-	if (psi_disabled)
+	if (!psi_enable) {
+		static_branch_enable(&psi_disabled);
 		return;
+	}
 
 	psi_period = jiffies_to_nsecs(PSI_FREQ);
 	group_init(&psi_system);
@@ -549,7 +561,7 @@ void psi_memstall_enter(unsigned long *flags)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	*flags = current->flags & PF_MEMSTALL;
@@ -579,7 +591,7 @@ void psi_memstall_leave(unsigned long *flags)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (*flags)
@@ -600,7 +612,7 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return 0;
 
 	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
@@ -612,7 +624,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 
 void psi_cgroup_free(struct cgroup *cgroup)
 {
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi.clock_work);
@@ -637,7 +649,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (psi_disabled) {
+	if (static_branch_likely(&psi_disabled)) {
 		/*
 		 * Lame to do this here, but the scheduler cannot be locked
 		 * from the outside, so we move cgroups from inside sched/.
@@ -673,7 +685,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
 	int full;
 
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return -EOPNOTSUPP;
 
 	update_stats(group);
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 4904c4677000..aa0de240fb41 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -66,7 +66,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 {
 	int clear = 0, set = TSK_RUNNING;
 
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (!wakeup || p->sched_psi_wake_requeue) {
@@ -86,7 +86,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
 	int clear = TSK_RUNNING, set = 0;
 
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (!sleep) {
@@ -102,7 +102,7 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
 {
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return;
 	/*
 	 * Is the task being migrated during a wakeup? Make sure to
@@ -128,7 +128,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 
 static inline void psi_task_tick(struct rq *rq)
 {
-	if (psi_disabled)
+	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (unlikely(rq->curr->flags & PF_MEMSTALL))
-- 
2.19.1


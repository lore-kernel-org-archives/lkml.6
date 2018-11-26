Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A759920865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="a7WrLXI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A759920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeK0E1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:27:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43923 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0E1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:27:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so18491574qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwAPOPc7SH+xZxSLgsaPPJRDJBMUNGpWpFldkeS4ViM=;
        b=a7WrLXI0EXM/DllRcS+Jw/86XfSxkgZslAh/Zm8e462/D3BtOgxUqAfuzOwkLpYA8a
         BIvWfM5fkYzs3zYEDO20Ag0HrOS21L+eFLnFFn2rdWkuRQq8P97Et/HUX4h3NxG3Alt+
         k07cuoIxLbns9phfnQ1+BrzyAyLWMQXEVk83MulEtlxy8WjIMoErP0Y+22BzXszazq1t
         DtBPV4BJRWeu/zV+FPHdlgK1cYJRX9Tx61X70dxP1Z3SiZ471SrhhYPtWEvplxXkGRuZ
         Rn/6pI2lXjRRRPBZbjQKEPOmTz0ghTc0e3okYEHeO0NC85SrwFIzo5vzMhiEkiNeulJ1
         V5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwAPOPc7SH+xZxSLgsaPPJRDJBMUNGpWpFldkeS4ViM=;
        b=KxKnuVomD/ieZzrjcEhkhCQszN5J1IHfrviGwiXFc6laQs3n1/j7DzVsC1D026dxRM
         xZxPQ5/quHv3Td9UzXd14DlEu5JqeWZAitrSPgm+6Op9lyHponjS+LhQ62tSzQbaB/fm
         /zQrFmVoOqldO+h7WbSO9RuAO22YKUTzWk0HcJUcIwgq6e+whSWNDlmyDqNKsSuHrKPY
         v+Lcugvs3XFcf5NJ2kuN1bm1LCQ3fW0W5uRNN7lQN3/6E2mbVvF/69n842X8sXlDhVNd
         PdzscrjRHOTB6OkhoTgJbybAql+carpr27SehPgoVKFukm9Cxtk5xW2xJxs//vgXU/SV
         EjVg==
X-Gm-Message-State: AA+aEWZWJqaJTO6VcYr3DqW2zxbiF8GR6Wvwc1K88UzF+PXzrjXRX1ZZ
        qBecPymS4vMAKR7GVNVv2djBemfpnCo=
X-Google-Smtp-Source: AFSGD/XQlHDE4cPICTGfk37Ftb209DFJy/+1Q4wR/vWQhKM2HFAD4Drq7FGqOwFb+INQp9PhntL0NA==
X-Received: by 2002:a0c:c404:: with SMTP id r4mr27641025qvi.131.1543253540949;
        Mon, 26 Nov 2018 09:32:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:2bd1])
        by smtp.gmail.com with ESMTPSA id d198sm404259qkc.47.2018.11.26.09.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 09:32:19 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:32:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: Hackbench pipes regression bisected to PSI
Message-ID: <20181126173218.GA22640@cmpxchg.org>
References: <20181126133420.GN23260@techsingularity.net>
 <20181126160724.GA21268@cmpxchg.org>
 <20181126165446.GQ23260@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126165446.GQ23260@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:54:47PM +0000, Mel Gorman wrote:
> On Mon, Nov 26, 2018 at 11:07:24AM -0500, Johannes Weiner wrote:
> > @@ -509,6 +509,15 @@ config PSI
> >  
> >  	  Say N if unsure.
> >  
> > +config PSI_DEFAULT_DISABLED
> > +	bool "Require boot parameter to enable pressure stall information tracking"
> > +	default n
> > +	depends on PSI
> > +	help
> > +	  If set, pressure stall information tracking will be disabled
> > +	  per default but can be enabled through passing psi_enable=1
> > +	  on the kernel commandline during boot.
> > +
> >  endmenu # "CPU/Task time and stats accounting"
> >  
> 
> Should this default y on the basis that someone only wants the feature if
> they are aware of it? This is not that important as CONFIG_PSI is disabled
> by default and it's up to distribution maintainers to use their brain.

I went with the NUMA balancing example again here, which defaults to
enabling the feature at boot time. IMO that makes sense, as somebody
would presumably first read through the PSI help text, then decide y
on that before being asked the second question. A "yes, but
<stipulations>" for vendor kernels seems more appropriate than
requiring a double yes for other users to simply get the feature.

> > @@ -136,8 +136,18 @@
> >  
> >  static int psi_bug __read_mostly;
> >  
> > -bool psi_disabled __read_mostly;
> > -core_param(psi_disabled, psi_disabled, bool, 0644);
> > +DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > +
> > +#ifdef CONFIG_PSI_DEFAULT_DISABLED
> > +bool psi_enable;
> > +#else
> > +bool psi_enable = true;
> > +#endif
> > +static int __init parse_psi_enable(char *str)
> > +{
> > +	return kstrtobool(str, &psi_enable) == 0;
> > +}
> > +__setup("psi_enable=", parse_psi_enable);
> >  
> 
> Bit late to notice but this switch should be in
> Documentation/admin-guide/kernel-parameters.txt. If you really want to
> match the automatic numa balancing switch then it also should be
> psi=[enable|disable] instead of psi_enable=[1|0]

Done and done, thanks. Updated patch:

---

From 694ae3d82da06ca57bfaa775140941ac5e8f2e37 Mon Sep 17 00:00:00 2001
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

   To avoid double negatives, rename psi_disabled= to psi=.

2. Make psi_disabled a static branch to eliminate any branch costs
   when the feature is disabled.

Reported-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 include/linux/psi.h                           |  3 +-
 init/Kconfig                                  |  9 ++++++
 kernel/sched/psi.c                            | 30 +++++++++++++------
 kernel/sched/stats.h                          |  8 ++---
 5 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 19f4423e70d9..8760a343c6d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3504,6 +3504,10 @@
 			before loading.
 			See Documentation/blockdev/ramdisk.txt.
 
+	psi=		[KNL] Enable or disable pressure stall information
+			tracking.
+			Format: <bool>
+
 	psmouse.proto=	[HW,MOUSE] Highest PS2 mouse protocol extension to
 			probe for; one of (bare|imps|exps|lifebook|any).
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
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
index 3d7355d7c3e3..fe24de3fbc93 100644
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
+static int __init setup_psi(char *str)
+{
+	return kstrtobool(str, &psi_enable) == 0;
+}
+__setup("psi=", setup_psi);
 
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


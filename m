Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501FD2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="VLACtApG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfAGUqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:46:31 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38723 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:46:30 -0500
Received: by mail-yw1-f68.google.com with SMTP id d190so688967ywb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WiLEH9UKULomRoI1uMUJXIwyngJx0Il7D2y3H2U/gUE=;
        b=VLACtApGM8XXik7MgefOuRMYF6eHAuND9s0IUrfEznH0jUjrVJDIMRprEwe3LlMYMv
         SrXSWrY4ThZzeZLfYnAhns/z081nlFXPw4XFIzCXaKZ+Rd8RuiarCpkih/fZ/tdFLkQQ
         C6/M50zLKLOzSDHuk3RHQSEILEP7hmMBlu5U6ohQDXKTq/K59ZJpJhCTbCa8YKB7e6UN
         elWwGMjxrj4LZCG1lbwqyl27zPXbKc/5QPPh9JtJpBifucNF6WfMlPJKrL0rf537WNev
         JSE2KwWmfJMAxvQN1TLxDpjiDPi/7NQOA+fuNZ3wH3N1jiziyvreW87KtlCC1KRztjG/
         ky/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WiLEH9UKULomRoI1uMUJXIwyngJx0Il7D2y3H2U/gUE=;
        b=HTV9/YTgHkwy/ZhfGMLRWrBMfIlD46haBwDpNf/0N2k9ii1isJ+J5Rz+DmIwMAeX8B
         TbtKzZUmpr5alh2gRD+XTckPPEMnG8qAagU4xwKgjwiCHBOU7t2V904oeSOFjwZeIpn1
         00d+3J28Xu8YbDwfSUfjfA9e1kno8Yy7m+GtcOfcvDAIWhX1os7vcSwdHWQlCxSIS6bp
         R4VUlrkluutzVVQ4TnMOCGqVfAWzrfLC98O4CC8T24CGCZv298aSNqebfqKl0IWEIhgZ
         NsUOmgTWiLMQZgi4ygEtLEBBHrFWTHMDNVcVakoMsG5BS+PbFlpOy3QEyPFp89Pd0arV
         WRTg==
X-Gm-Message-State: AA+aEWb+fquT7Wl+/qkWJQPNLqyqWIAbUiK0KpkLhae702WOJ3hWnMLs
        8DhDK/03ICkHTZXtARqpOHqRBg==
X-Google-Smtp-Source: AFSGD/XRaVkogM2pXbDaPUuKYwg8lnQTNx7zyBcfSWiYrKF6iuDVPPtIrQrykvcmqtAJhPgXvy/F1A==
X-Received: by 2002:a0d:fbc2:: with SMTP id l185mr60138916ywf.43.1546893989375;
        Mon, 07 Jan 2019 12:46:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:2190])
        by smtp.gmail.com with ESMTPSA id f62sm21865199ywd.68.2019.01.07.12.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 12:46:28 -0800 (PST)
Date:   Mon, 7 Jan 2019 15:46:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: possible deadlock in __wake_up_common_lock
Message-ID: <20190107204627.GA25526@cmpxchg.org>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190107095217.GB2861@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107095217.GB2861@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:52:17AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 02, 2019 at 01:51:01PM +0100, Vlastimil Babka wrote:
> > > -> #3 (&base->lock){-.-.}:
> > >         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> > >         _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
> > >         lock_timer_base+0xbb/0x2b0 kernel/time/timer.c:937
> > >         __mod_timer kernel/time/timer.c:1009 [inline]
> > >         mod_timer kernel/time/timer.c:1101 [inline]
> > >         add_timer+0x895/0x1490 kernel/time/timer.c:1137
> > >         __queue_delayed_work+0x249/0x380 kernel/workqueue.c:1533
> > >         queue_delayed_work_on+0x1a2/0x1f0 kernel/workqueue.c:1558
> > >         queue_delayed_work include/linux/workqueue.h:527 [inline]
> > >         schedule_delayed_work include/linux/workqueue.h:628 [inline]
> > >         psi_group_change kernel/sched/psi.c:485 [inline]
> > >         psi_task_change+0x3f1/0x5f0 kernel/sched/psi.c:534
> > >         psi_enqueue kernel/sched/stats.h:82 [inline]
> > >         enqueue_task kernel/sched/core.c:727 [inline]
> > >         activate_task+0x21a/0x430 kernel/sched/core.c:751
> > >         wake_up_new_task+0x527/0xd20 kernel/sched/core.c:2423
> > >         _do_fork+0x33b/0x11d0 kernel/fork.c:2247
> > >         kernel_thread+0x34/0x40 kernel/fork.c:2281
> > >         rest_init+0x28/0x372 init/main.c:409
> > >         arch_call_rest_init+0xe/0x1b
> > >         start_kernel+0x873/0x8ae init/main.c:741
> > >         x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
> > >         x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
> > >         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
> 
> That thing is fairly new; I don't think we used to have this dependency
> prior to PSI.
> 
> Johannes, can we move that mod_timer out from under rq->lock? At worst
> we can use an irq_work to self-ipi.

Hm, so the splat says this:

wakeups take the pi lock
pi lock holders take the rq lock
rq lock holders take the timer base lock (thanks psi)
timer base lock holders take the zone lock (thanks kasan)
problem: now a zone lock holder wakes up kswapd

right? And we can break the chain from the VM or from psi.

I cannot say one is clearly cleaner than the other, though. With kasan
allocating from inside the basic timer code, those locks leak out from
kernel/* and contaminate the VM locking anyway.

Do you think the rq->lock -> base->lock ordering is likely to cause
issues elsewhere?

Something like this below seems to pass the smoke test. If we want to
go ahead with that, I'd test it properly and send it with a sign-off.

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 2cf422db5d18..42e287139c31 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_PSI_TYPES_H
 #define _LINUX_PSI_TYPES_H
 
+#include <linux/irq_work.h>
 #include <linux/seqlock.h>
 #include <linux/types.h>
 
@@ -77,6 +78,7 @@ struct psi_group {
 	u64 last_update;
 	u64 next_update;
 	struct delayed_work clock_work;
+	struct irq_work clock_reviver;
 
 	/* Total stall times and sampled pressure averages */
 	u64 total[NR_PSI_STATES - 1];
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index f39958321293..9654de009250 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -165,6 +165,7 @@ static struct psi_group psi_system = {
 };
 
 static void psi_update_work(struct work_struct *work);
+static void psi_revive_clock(struct irq_work *work);
 
 static void group_init(struct psi_group *group)
 {
@@ -177,6 +178,7 @@ static void group_init(struct psi_group *group)
 	group->last_update = now;
 	group->next_update = now + psi_period;
 	INIT_DELAYED_WORK(&group->clock_work, psi_update_work);
+	init_irq_work(&group->clock_reviver, psi_revive_clock);
 	mutex_init(&group->stat_lock);
 }
 
@@ -399,6 +401,14 @@ static void psi_update_work(struct work_struct *work)
 	}
 }
 
+static void psi_revive_clock(struct irq_work *work)
+{
+	struct psi_group *group;
+
+	group = container_of(work, struct psi_group, clock_reviver);
+	schedule_delayed_work(&group->clock_work, PSI_FREQ);
+}
+
 static void record_times(struct psi_group_cpu *groupc, int cpu,
 			 bool memstall_tick)
 {
@@ -484,8 +494,14 @@ static void psi_group_change(struct psi_group *group, int cpu,
 
 	write_seqcount_end(&groupc->seq);
 
+	/*
+	 * We cannot modify workqueues or timers with the rq lock held
+	 * here. If the clock has stopped due to a lack of activity in
+	 * the past and needs reviving, go through an IPI to wake it
+	 * back up. In most cases, the work should already be pending.
+	 */
 	if (!delayed_work_pending(&group->clock_work))
-		schedule_delayed_work(&group->clock_work, PSI_FREQ);
+		irq_work_queue(&group->clock_reviver);
 }
 
 static struct psi_group *iterate_groups(struct task_struct *task, void **iter)

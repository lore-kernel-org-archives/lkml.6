Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB905C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CB22147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPizOp+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CB22147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHXK1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:27:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43310 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbeHXK1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:27:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so6538571wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=81v6UpEO0Oh1hU3LECqdvR5z0yh4KjR95I6b0S9apJo=;
        b=XPizOp+sy4F5PhrwjEA8ut/Ebh+aOzz6geQIPwmEW6fVwBT6oGDJHtztkuLSRikznb
         UbXEQe7xT3OfakClfT4mtzwG/PNRHuXL5eckBh8oeydWSISl+yYmEw5RbUkvtZGJGG3i
         8TffyEj7MZOWibdVeaIb0iMx2X9WRmymcFoivabF5TJZY9zQq/I5Z98qzGef6e3vwBDU
         9z0I+/hmYQec8pBgqtUCH0lc5wOSY7Mbvi9EIvgA00YFbQgFaX27Um48Laj16/U27+cS
         G/2bK1RsQdlXfYE3MX8TvPpG+GsdpMHlz3Dhs1LHq3XwI7ByH7gCmrXtibDpOUFrXDgK
         oasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=81v6UpEO0Oh1hU3LECqdvR5z0yh4KjR95I6b0S9apJo=;
        b=JPgeZoI1jCvf0bXMBjqA9+grKXi4eu3xaMVcDSDCpn3bSNQ+T+qMRo6C0R0v5W30Bo
         S84rvmVRCHg91ghK/RwSgv2QupXu09hBVJ/1cBXQERj1KB7FqaBz1S5v6qxFhvwwYn3O
         ArbE/m4xpem94wiXjuPnk65WkYjaZbNVt6v8YrFm3QzD7nA2VbQz15y6MLeYIS1UWArk
         h+gvjDLNLgpx1gBJw6MsHBfkEjlJXGDfcczUHLQyWXGurJXxB77iOsKpzfwylT4j/x24
         pNUHVUFN9BJnjmZVspkp/VzfjoYN0F1EYOHCDnqb0nWT+rPw1YiqoJC4azg0ty4X30RD
         7bjQ==
X-Gm-Message-State: APzg51Buwy1IsK0YXeaFOqNJuLDfitqkvEyHhYZqIhV2XZFturX6lUv7
        3TrlJKcoMcpeltWkiV6N3IY=
X-Google-Smtp-Source: ANB0Vdb9ir2+y/+LtD07z8i2mQBLkX9AR8Q5oX2NfnHDmwmKVh5xEX092XTj4C5LA5b3/ki5v9BpVA==
X-Received: by 2002:adf:fa4d:: with SMTP id y13-v6mr303992wrr.155.1535093663693;
        Thu, 23 Aug 2018 23:54:23 -0700 (PDT)
Received: from localhost.localdomain ([151.36.95.19])
        by smtp.gmail.com with ESMTPSA id b2-v6sm625733wmh.3.2018.08.23.23.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 23:54:23 -0700 (PDT)
Date:   Fri, 24 Aug 2018 08:54:19 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Miguel de Dios <migueldedios@google.com>,
        Steve Muckle <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching
 from fair
Message-ID: <20180824065419.GB24860@localhost.localdomain>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b27b2354-cbfe-7c16-bdc1-d88ed3be90bd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/18 18:52, Dietmar Eggemann wrote:
> Hi,
> 
> On 08/21/2018 01:54 AM, Miguel de Dios wrote:
> > On 08/17/2018 11:27 AM, Steve Muckle wrote:
> > > From: John Dias <joaodias@google.com>
> > > 
> > > When rt_mutex_setprio changes a task's scheduling class to RT,
> > > we're seeing cases where the task's vruntime is not updated
> > > correctly upon return to the fair class.
> > > Specifically, the following is being observed:
> > > - task is deactivated while still in the fair class
> > > - task is boosted to RT via rt_mutex_setprio, which changes
> > >    the task to RT and calls check_class_changed.
> > > - check_class_changed leads to detach_task_cfs_rq, at which point
> > >    the vruntime_normalized check sees that the task's state is
> > > TASK_WAKING,
> > >    which results in skipping the subtraction of the rq's min_vruntime
> > >    from the task's vruntime
> > > - later, when the prio is deboosted and the task is moved back
> > >    to the fair class, the fair rq's min_vruntime is added to
> > >    the task's vruntime, even though it wasn't subtracted earlier.
> > > The immediate result is inflation of the task's vruntime, giving
> > > it lower priority (starving it if there's enough available work).
> > > The longer-term effect is inflation of all vruntimes because the
> > > task's vruntime becomes the rq's min_vruntime when the higher
> > > priority tasks go idle. That leads to a vicious cycle, where
> > > the vruntime inflation repeatedly doubled.
> > > 
> > > The change here is to detect when vruntime_normalized is being
> > > called when the task is waking but is waking in another class,
> > > and to conclude that this is a case where vruntime has not
> > > been normalized.
> > > 
> > > Signed-off-by: John Dias <joaodias@google.com>
> > > Signed-off-by: Steve Muckle <smuckle@google.com>
> > > ---
> > >   kernel/sched/fair.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index b39fb596f6c1..14011d7929d8 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct
> > > task_struct *p)
> > >        * - A task which has been woken up by try_to_wake_up() and
> > >        *   waiting for actually being woken up by sched_ttwu_pending().
> > >        */
> > > -    if (!se->sum_exec_runtime || p->state == TASK_WAKING)
> > > +    if (!se->sum_exec_runtime ||
> > > +        (p->state == TASK_WAKING && p->sched_class ==
> > > &fair_sched_class))
> > >           return true;
> > >       return false;
> > The normalization of vruntime used to exist in task_waking but it was
> > removed and the normalization was moved into migrate_task_rq_fair. The
> > reasoning being that task_waking_fair was only hit when a task is queued
> > onto a different core and migrate_task_rq_fair should do the same work.
> > 
> > However, we're finding that there's one case which migrate_task_rq_fair
> > doesn't hit: that being the case where rt_mutex_setprio changes a task's
> > scheduling class to RT when its scheduled out. The task never hits
> > migrate_task_rq_fair because it is switched to RT and migrates as an RT
> > task. Because of this we're getting an unbounded addition of
> > min_vruntime when the task is re-attached to the CFS runqueue when it
> > loses the inherited priority. The patch above works because now the
> > kernel specifically checks for this case and normalizes accordingly.
> > 
> > Here's the patch I was talking about:
> > https://lore.kernel.org/patchwork/patch/677689/. In our testing we were
> > seeing vruntimes nearly double every time after rt_mutex_setprio boosts
> > the task to RT.
> > 
> > Signed-off-by: Miguel de Dios <migueldedios@google.com>
> > Tested-by: Miguel de Dios <migueldedios@google.com>
> 
> I tried to catch this issue on my Arm64 Juno board using pi_test (and a
> slightly adapted pip_test (usleep_val = 1500 and keep low as cfs)) from
> rt-tests but wasn't able to do so.
> 
> # pi_stress --inversions=1 --duration=1 --groups=1 --sched id=low,policy=cfs
> 
> Starting PI Stress Test
> Number of thread groups: 1
> Duration of test run: 1 seconds
> Number of inversions per group: 1
>      Admin thread SCHED_FIFO priority 4
> 1 groups of 3 threads will be created
>       High thread SCHED_FIFO priority 3
>        Med thread SCHED_FIFO priority 2
>        Low thread SCHED_OTHER nice 0
> 
> # ./pip_stress
> 
> In both cases, the cfs task entering  rt_mutex_setprio() is queued, so
> dequeue_task_fair()->dequeue_entity(), which subtracts cfs_rq->min_vruntime
> from se->vruntime, is called on it before it gets the rt prio.
> 
> Maybe it requires a very specific use of the pthread library to provoke this
> issue by making sure that the cfs tasks really blocks/sleeps?

Maybe one could play with rt-app to recreate such specific use case?

https://github.com/scheduler-tools/rt-app/blob/master/doc/tutorial.txt#L459

Best,

- Juri

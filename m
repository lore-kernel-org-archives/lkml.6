Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF4820821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaLTaE/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF4820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeLJQdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:33:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39116 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:33:36 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so9234735iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nW5mHAMxRJK905Cqwk3WaIQNzhJUtTOgPn1bRUQHJOA=;
        b=WaLTaE/3/4gIj67A5h1Medap+EitqCFbgtxy8NxZcc14jgm8rplN9IJwFe7r9Lhg4g
         /4Rt4DM9dRF700tQEJRg6hFOmWezaSh3VU6UPTmFo0r+Vrr+GdvYkC6WoK4/tyYpOuS8
         9/Ys/XIgMJCv0X1EiGmTCDFaiFyyYWZ15MRY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW5mHAMxRJK905Cqwk3WaIQNzhJUtTOgPn1bRUQHJOA=;
        b=HZOs7II2XDWW9McWwdhXfCo1dgJeuhA/6TqZ9jVv3gdRSAuxMeq0f/EoYB+POCQx++
         HJb+s5PPt2/Wx+he2Y20hDa6B5+BbOgF8z7MNt5gzJqxwR1TIYNq712jMy3T+Q5ogIk7
         pcDbZrbjGP34LU7Yl2+Chg/maLKVUHFHMeEdPVLZxpOf24j8ryjLF7HL+mLaozwoDYWM
         Ksbif/0yFXAcjCt8/7ftkPq9HbMWAHhPqXyRMXI2ohFF3KzOxyUL0zZ0siwx5rA9QFhl
         +v17eC783KAk2E/CQW90cixVxKIK7rEQRLFUF40uhJ4PbCQMt7QyBdkNo5SDR7oakXNr
         D3uQ==
X-Gm-Message-State: AA+aEWYq3FYiy1p6UZPXks14hzOlwZjbt8UBqmAERVvOmO24ByNHCLnn
        Lcy2+M1Y3Rs3Hu4XZ1fu3r4LRPl00h98CyqPS+GBEQ==
X-Google-Smtp-Source: AFSGD/V/0+VEOLJQ+QWrv7samOPDPQjsiEvYLAIpd+nhv49PmVcnvZ+M90z0dXm6VKZWWm711XEfvgDRM3En6HMTA4M=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr9916537ioh.294.1544459614470;
 Mon, 10 Dec 2018 08:33:34 -0800 (PST)
MIME-Version: 1.0
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <CAKfTPtBuAsbF2r8wSigM=ckpKCqj0hcHbi+y3ZAaC7dqYcFY2g@mail.gmail.com> <df0197ac-d4eb-437e-1176-dbc9b23a94bb@oracle.com>
In-Reply-To: <df0197ac-d4eb-437e-1176-dbc9b23a94bb@oracle.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Dec 2018 17:33:22 +0100
Message-ID: <CAKfTPtBh59Wt3+JiZ168WRAZ+AEsS+-GTqXzeUZTKQPcDAJ73g@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] steal tasks to improve CPU utilization
To:     steven.sistare@oracle.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra.mazumdar@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Rik van Riel <riel@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 17:29, Steven Sistare <steven.sistare@oracle.com> wrote:
>
> On 12/10/2018 11:10 AM, Vincent Guittot wrote:
> > Hi Steven,
> >
> > On Thu, 6 Dec 2018 at 22:38, Steve Sistare <steven.sistare@oracle.com> wrote:
> >>
> >> When a CPU has no more CFS tasks to run, and idle_balance() fails to
> >> find a task, then attempt to steal a task from an overloaded CPU in the
> >> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
> >> identify candidates.  To minimize search time, steal the first migratable
> >> task that is found when the bitmap is traversed.  For fairness, search
> >> for migratable tasks on an overloaded CPU in order of next to run.
> >>
> >> This simple stealing yields a higher CPU utilization than idle_balance()
> >> alone, because the search is cheap, so it may be called every time the CPU
> >> is about to go idle.  idle_balance() does more work because it searches
> >> widely for the busiest queue, so to limit its CPU consumption, it declines
> >> to search if the system is too busy.  Simple stealing does not offload the
> >> globally busiest queue, but it is much better than running nothing at all.
> >>
> >> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
> >> reduce cache contention vs the usual bitmap when many threads concurrently
> >> set, clear, and visit elements.
> >>
> >> Patch 1 defines the sparsemask type and its operations.
> >>
> >> Patches 2, 3, and 4 implement the bitmap of overloaded CPUs.
> >>
> >> Patches 5 and 6 refactor existing code for a cleaner merge of later
> >>   patches.
> >>
> >> Patches 7 and 8 implement task stealing using the overloaded CPUs bitmap.
> >>
> >> Patch 9 disables stealing on systems with more than 2 NUMA nodes for the
> >> time being because of performance regressions that are not due to stealing
> >> per-se.  See the patch description for details.
> >>
> >> Patch 10 adds schedstats for comparing the new behavior to the old, and
> >>   provided as a convenience for developers only, not for integration.
> >>
> >> The patch series is based on kernel 4.20.0-rc1.  It compiles, boots, and
> >> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
> >> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
> >> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
> >> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
> >> bandwidth control were tested.
> >>
> >> Stealing improves utilization with only a modest CPU overhead in scheduler
> >> code.  In the following experiment, hackbench is run with varying numbers
> >> of groups (40 tasks per group), and the delta in /proc/schedstat is shown
> >> for each run, averaged per CPU, augmented with these non-standard stats:
> >>
> >>   %find - percent of time spent in old and new functions that search for
> >>     idle CPUs and tasks to steal and set the overloaded CPUs bitmap.
> >>
> >>   steal - number of times a task is stolen from another CPU.
> >>
> >> X6-2: 1 socket * 10 cores * 2 hyperthreads = 20 CPUs
> >> Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz
> >> hackbench <grps> process 100000
> >> sched_wakeup_granularity_ns=15000000
> >>
> >>   baseline
> >>   grps  time  %busy  slice   sched   idle     wake %find  steal
> >>   1    8.084  75.02   0.10  105476  46291    59183  0.31      0
> >>   2   13.892  85.33   0.10  190225  70958   119264  0.45      0
> >>   3   19.668  89.04   0.10  263896  87047   176850  0.49      0
> >>   4   25.279  91.28   0.10  322171  94691   227474  0.51      0
> >>   8   47.832  94.86   0.09  630636 144141   486322  0.56      0
> >>
> >>   new
> >>   grps  time  %busy  slice   sched   idle     wake %find  steal  %speedup
> >>   1    5.938  96.80   0.24   31255   7190    24061  0.63   7433  36.1
> >>   2   11.491  99.23   0.16   74097   4578    69512  0.84  19463  20.9
> >>   3   16.987  99.66   0.15  115824   1985   113826  0.77  24707  15.8
> >>   4   22.504  99.80   0.14  167188   2385   164786  0.75  29353  12.3
> >>   8   44.441  99.86   0.11  389153   1616   387401  0.67  38190   7.6
> >>
> >> Elapsed time improves by 8 to 36%, and CPU busy utilization is up
> >> by 5 to 22% hitting 99% for 2 or more groups (80 or more tasks).
> >> The cost is at most 0.4% more find time.
> >
> > I have run some hackbench tests on my hikey arm64 octo cores with your
> > patchset. My original intent was to send a tested-by but I have some
> > performances regressions.
> > This hikey is the smp one and not the asymetric hikey960 that Valentin
> > used for his tests
> > The sched domain topology is
> > domain-0: span=0-3 level=MC  and domain-0: span=4-7 level=MC
> > domain-1: span=0-7 level=DIE
> >
> > I have run 12 times hackbench -g $j -P -l 2000 with j equals to 1 2 3 4 8
> >
> > grps  time
> > 1      1.396
> > 2      2.699
> > 3      3.617
> > 4      4.498
> > 8      7.721
> >
> > Then after disabling STEAL in sched_feature with echo NO_STEAL >
> > /sys/kernel/debug/sched_features , the results become:
> > grps  time
> > 1      1.217
> > 2      1.973
> > 3      2.855
> > 4      3.932
> > 8      7.674
> >
> > I haven't looked in details about some possible reasons of such
> > difference yet and haven't collected the stats that you added with
> > patch 10.
> > Have you got a script to collect and post process them ?
> >
> > Regards,
> > Vincent
>
> Thanks Vincent.  What is the value of /proc/sys/kernel/sched_wakeup_granularity_ns?

it's 4000000

> Try 15000000.  Your 8-core system is heavily overloaded with 40 * groups tasks,
> and I suspect preemptions are killing performance.

ok. I'm going to run the tests with the proposed value

>
> I have a python script to post-process schedstat files, but it does many things
> and is large and I am not ready to share it.  I can write a short bash script if
> that would help.

It was mainly in case you wanted the figures of these statistics

Vincent

>
> - Steve

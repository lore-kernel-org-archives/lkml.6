Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD67C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6342075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcwI9z6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6342075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJYVQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:16:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37609 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJYVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:16:38 -0400
Received: by mail-io1-f67.google.com with SMTP id k17-v6so5378179ioc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDa+1Xev8mK/UE5YQ7OSw5/2pjRZ0a77gVkoT20CZhc=;
        b=KcwI9z6RIpetC5oYYT2Idr+vX1TXNSqWCEWGZxUMj6P4Rjg9yEeQQI1UAQQInEdMXL
         0Z2Uf4yipBSM1gXwXsUKFYI6RuvPy3O+TALXlQfHMMbdgkZJrKqQtOKIDQUIK1x5uBT8
         TmWq8WuudWhDPIO83Yl/yGOnDXnqS9vzUrv9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDa+1Xev8mK/UE5YQ7OSw5/2pjRZ0a77gVkoT20CZhc=;
        b=NSYWYFuZvr5p8zMZv4LgNvuNOc97qA8Aaf6ULQocubEFzi/1VWR9hlKMDycvdlUIUi
         pA07Q3RQC1jPUgnlZA+oAqIjB3Xs9cBe36cGmUvEPyTCJDLHjS6sPzOb0VAToqnvABmo
         pJodmqfu/ee8bmIAiN8c2A1tYScAgFL9qECJtPF6lms1Yx5AFk4nwihsVIR6V8SWQrGK
         gK7FDmT9nNsWzdii9hmFDON1ZrQPrEb1na/gT2ZjRGCaAwQb+yKl6oS9CZYqt1e6evQl
         uEYnVby916pyPy9l9JHmutNHKx1Y7gh4zIisI+xWLnGUZ47m+++XdPMGRCgluKWhq3b3
         g36g==
X-Gm-Message-State: AGRZ1gKMgbXrXoIXykBqHYui3jBwzAWDeylkYQ7wP8fxL/ti4Ef8jjXD
        Bi9ILHO8ZltoFUlOZnvMDwVHt4M0z8iMZQZvjU0YCg==
X-Google-Smtp-Source: AJdET5eqTVCHNX5jMLxgbgEFyuFSAna+7l6CSM21fVMNbUoPVoiX6zJyQTm+RAR+g4mwZ4YgxIO0el55zdDn4iL1B98=
X-Received: by 2002:a6b:ea13:: with SMTP id m19-v6mr781793ioc.18.1540471440687;
 Thu, 25 Oct 2018 05:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <CAKfTPtCUZfaz-ZT0N8ko3daeaBmjgYH-KQpQdt0EBfkaK9uVvw@mail.gmail.com> <89a6c01e-c911-04ed-b434-9f93f90da66c@oracle.com>
In-Reply-To: <89a6c01e-c911-04ed-b434-9f93f90da66c@oracle.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Oct 2018 14:43:49 +0200
Message-ID: <CAKfTPtDeMd4iN+WksK8+Pr-OhthEXPnkV2CRDG0KDyxTS6agJA@mail.gmail.com>
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     steven.sistare@oracle.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        subhra.mazumdar@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        Rohit Jain <rohit.k.jain@oracle.com>,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Rik van Riel <riel@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 at 13:29, Steven Sistare <steven.sistare@oracle.com> wrote:
>
> On 10/25/2018 3:50 AM, Vincent Guittot wrote:
> > Hi Steve,
> >
> > On Mon, 22 Oct 2018 at 17:10, Steve Sistare <steven.sistare@oracle.com> wrote:
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
> >> The patch series is based on kernel 4.19.0-rc7.  It compiles, boots, and
> >> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
> >> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
> >> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
> >> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
> >> bandwidth control were tested.
> >>
> >> Stealing imprroves utilization with only a modest CPU overhead in scheduler
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
> >
> > Why do you mention this sched_wakeup_granularity_ns value ?
> > It is something that you changed for you tests ?
> > The comment for this tunable says that default value is 1ms *
> > ilog(ncpus) = 4ms for 20CPUs
>
> I changed it for the test, and I explain why a few paragraphs later.
> The value matches the one set by tuned.service, for those running it.

ok. I haven't noticed that later explanation.

You said " Note: for all hackbench runs, sched_wakeup_granularity_ns
is set to 15 msec.  Otherwise, preemptions increase at higher loads and
distort the comparison between baseline and new."

What do you mean exactly by distort ?

>
> - Steve
>
> >
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
> >>

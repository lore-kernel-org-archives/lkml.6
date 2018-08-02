Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B85C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E242152B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6ufResr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E242152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbeHBRGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:06:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55540 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbeHBRGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:06:04 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so3831906itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1n3sDUslzZ6X2g+rkhrQpKK0k/eC+y+UnuwFA9MzfAU=;
        b=F6ufResriS8rx0a19xEMwohNXhXKZuW0W3LCkWTEJbV3VUOtjbLce7Bt8QPKMdpN9V
         1VVJ2nijYmIQU9xF7oELtkgh1e4kQBARBRkfU6rbkd/vigVm03dveIsK+6thZQuK4awU
         7dHDd4bHQdPOMe/AhacnIt2P+yvGPzxykB5AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1n3sDUslzZ6X2g+rkhrQpKK0k/eC+y+UnuwFA9MzfAU=;
        b=FNuotYS17wqlkQF/zsm45n4nNpPm6e2F73GBE1sXU2zyscLypdaLr9pleZypAdr50w
         jSnnpktGJeXbj+UhQQQ6tf6qhZv7AeUIxW1QX27VclDw+9ryUcQ45v890F2xkJhUzKVw
         PCTjMUXIqowjJA9FfjC+vTP7x8hHGh0m5iBoRBkUdEbtflG1B9O98E0ZGWRzfk/pBue2
         j0LqFJWC36ZTwLFd3I/2UHeaofDYVMyBv2s415T+CUvJa+OvXFi28x8lbX60tObM+WlU
         Vmxn0KGjXZo/sro8G5xnHZiRQbe9fhsv4RhyCq6S33+4wI7uRVTJJr8stKlzW6BR5y8H
         w9GA==
X-Gm-Message-State: AOUpUlF3HQouXa+HuxC/+o3EQ+1/udDFmxG7wIo4OJSASlD0bnwjOgTt
        HxGdZ3DPo/nNUnFigoFwP9Qdp7Nea6BdeUtKMug++g==
X-Google-Smtp-Source: AAOMgpfJaOg/6orVPJBXc/9nOAWoxrToU2Ur1PuDPgglbNjJ8kV6EVUG0Yk+ydk9Dpu6sVg5UWBJuWfG8wtibOPIX/A=
X-Received: by 2002:a02:634f:: with SMTP id j76-v6mr2796102jac.101.1533222866912;
 Thu, 02 Aug 2018 08:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com> <20180802122629.GU2476@hirez.programming.kicks-ass.net>
 <20180802130337.uf6tlac2hg4nkbwr@queper01-lin> <20180802130801.GL2494@hirez.programming.kicks-ass.net>
 <20180802131849.mqpt5lbtcqrxbwig@queper01-lin> <CAKfTPtDcoySXK0fBkDNy4wp1vsRxmiuAGT3CDZBh6Vnwyep2BA@mail.gmail.com>
 <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin>
In-Reply-To: <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Aug 2018 17:14:15 +0200
Message-ID: <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com,
        "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 at 16:14, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Thursday 02 Aug 2018 at 15:48:01 (+0200), Vincent Guittot wrote:
> > On Thu, 2 Aug 2018 at 15:19, Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > On Thursday 02 Aug 2018 at 15:08:01 (+0200), Peter Zijlstra wrote:
> > > > On Thu, Aug 02, 2018 at 02:03:38PM +0100, Quentin Perret wrote:
> > > > > On Thursday 02 Aug 2018 at 14:26:29 (+0200), Peter Zijlstra wrote:
> > > > > > On Tue, Jul 24, 2018 at 01:25:16PM +0100, Quentin Perret wrote:
> > > > > > > @@ -5100,8 +5118,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > > > >                 update_cfs_group(se);
> > > > > > >         }
> > > > > > >
> > > > > > > -       if (!se)
> > > > > > > +       if (!se) {
> > > > > > >                 add_nr_running(rq, 1);
> > > > > > > +               /*
> > > > > > > +                * The utilization of a new task is 'wrong' so wait for it
> > > > > > > +                * to build some utilization history before trying to detect
> > > > > > > +                * the overutilized flag.
> > > > > > > +                */
> > > > > > > +               if (flags & ENQUEUE_WAKEUP)
> > > > > > > +                       update_overutilized_status(rq);
> > > > > > > +
> > > > > > > +       }
> > > > > > >
> > > > > > >         hrtick_update(rq);
> > > > > > >  }
> > > > > >
> > > > > > That is a somewhat dodgy hack. There is no guarantee what so ever that
> > > > > > when the task wakes next its history is any better. The comment doesn't
> > > > > > reflect this I feel.
> > > > >
> > > > > AFAICT the main use-case here is to avoid re-enabling the load balance
> > > > > and ruining all the task placement because of a tiny task. I don't
> > > > > really see how we can do that differently ...
> > > >
> > > > Sure I realize that.. but it doesn't completely avoid it. Suppose this
> > > > new task instantly blocks and wakes up again. Then its util signal will
> > > > be exactly what you didn't want but we'll account it and cause the above
> > > > scenario you wanted to avoid.
> > >
> > > That is true. ... I also realize now that this patch was written long
> > > before util_est, and that also has an impact here, especially in the
> > > scenario you described where the task blocks. So any wake-up after the
> > > first enqueue will risk to overutilize the system, even if the task
> > > blocked for ages.
> > >
> > > Hmm ...
> >
> > Does a init value set to 0 for util_avg for newly created task can
> > help in EAS in this case ?
> > Current initial value is computed to prevent packing newly created
> > tasks on same CPUs because it hurts performance of some benches. In
> > fact it somehow assumes that newly created task will use significant
> > part of the remaining capacity of a CPU and want to spread tasks. In
> > EAS case, it seems that it prefer to assume that  newly created task
> > are small and we can pack them and wait a bit to make sure the new
> > task will be a big task and will overload the CPU
>
> Good point, setting the util_avg to 0 for new tasks should help
> filtering out those tiny tasks too. And that would match with the idea
> of letting tasks build their history before looking at their util_avg ...
>
> But there is one difference w.r.t frequency selection. The current code
> won't mark the system overutilized, but will let sugov raise the
> frequency when a new task is enqueued. So in case of a fork bomb, we

If the initial value of util_avg is 0, we should not have any impact
on the util_avg of the cfs rq on which the task is attached, isn't it
? so this should not impact both the over utilization state and the
frequency selected by sugov or I'm missing something ?
Then, select_task_rq_fair is called for a new task but util_avg is
still 0 at that time in the current code so you will have consistent
util_avg of the new task before and after calling
find_energy_efficient_cpu

> sort of fallback on the existing mainline strategy for both task
> placement (because forkees don't go in find_energy_efficient_cpu) and
> frequency selection. And I would argue this is the right thing to do
> since EAS can't really help in this case.
>
> Thoughts ?
>
> Thanks,
> Quentin

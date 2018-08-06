Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC1DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73935219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7Ghd6c1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73935219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeHFKs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:48:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52612 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:48:58 -0400
Received: by mail-it0-f66.google.com with SMTP id d9-v6so16355238itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Eh8uQ6hjH2y+bt0YUYUSoPDTb6XTQykoNqasZos9/k=;
        b=d7Ghd6c19fxCsvaJLL+lK32vHMxJ/jpF84SkwA/wZ/EWO2pOhouDLJBkIGdEMynPr5
         /8MC3LeY0Vv2FaYyZ9Jr6biHR2gcGbpjApNcj5BeVmSv75brAVTGnzXe6l5ewLALwNEM
         QTX0dgdrEA8EqY1OgcqT5clOb7Qo3r5oYQ34U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Eh8uQ6hjH2y+bt0YUYUSoPDTb6XTQykoNqasZos9/k=;
        b=gMvV2YF80Ec4QoIbUXCVW1laj5v9gdy/ncKVz5bXP1mm6mIy7kHT2WetRERCYaRbJE
         /txh7hXAOPCaymh9TAPfkKZ7hcLltrRGenYvSz2zBaelCrFH/WkX+LQrPksLuq5uZuQQ
         plswpJyqt7z5CY1T+mB+Gt7ZZ3KakeTFz2kLCg/D40tdGdoUtWv4NRBuANcRUkIAYI1c
         k0gQeKCY2TeVL6PiGpbygqUUSgsEosTkYDSsjakg81DSLcny1utHdfkLge3RKCPUvhNT
         yXIUwT1XmAh033o7AxFGrmvLzQm4y9E2V8OImM3efdcB/NZBWYwtZfi6V4OXm977HK88
         uWDw==
X-Gm-Message-State: AOUpUlEs8XcNSiSDIIDk4lxuGln44LiC3WBCTChUIiELuypJj6bqPs3e
        RHuXCcAcFo7nCfab13rFR3dd0a+JFRm1v1DmXuMVxQ==
X-Google-Smtp-Source: AAOMgpeeZ0POloW0pBRUUZONYnYkoMCVV+QOBC7wqq1DpriLHp19bjvB+mMJme6OyCtnrCKg4cFeJypij6gpKRlOlnA=
X-Received: by 2002:a02:634f:: with SMTP id j76-v6mr11823465jac.101.1533544857879;
 Mon, 06 Aug 2018 01:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180802153035.vjtmqwdwujvt7ojs@queper01-lin> <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin> <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin> <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin> <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin> <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin>
In-Reply-To: <20180803155547.sxlhxpmhwcoappit@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Aug 2018 10:40:46 +0200
Message-ID: <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
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

On Fri, 3 Aug 2018 at 17:55, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 03 Aug 2018 at 15:49:24 (+0200), Vincent Guittot wrote:
> > On Fri, 3 Aug 2018 at 10:18, Quentin Perret <quentin.perret@arm.com> wrote:
> > >
> > > On Friday 03 Aug 2018 at 09:48:47 (+0200), Vincent Guittot wrote:
> > > > On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
> > > > I'm not really concerned about re-enabling load balance but more that
> > > > the effort of packing of tasks in few cpus/clusters that EAS tries to
> > > > do can be broken for every new task.
> > >
> > > Well, re-enabling load balance immediately would break the nice placement
> > > that EAS found, because it would shuffle all tasks around and break the
> > > packing strategy. Letting that sole new task go in find_idlest_cpu()
> >
> > Sorry I was not clear in my explanation. Re enabling load balance
> > would be a problem of course. I wanted to say that there is few chance
> > that this will re-enable the load balance immediately and break EAS
> > and I'm not worried by this case. But i'm only concerned by the new
> > task being put outside EAS policy.
> >
> > For example, if you run on hikey960 the simple script below, which
> > can't really be seen as a fork bomb IMHO, you will see threads
> > scheduled on big cores every 0.5 seconds whereas everything should be
> > packed on little core
>
> I guess that also depends on what's running on the little cores, but I
> see your point.

In my case, the system was idle and nothing else than this script was running

>
> I think we're discussing two different things right now:
>     1. Should forkees go in find_energy_efficient_cpu() ?
>     2. Should forkees have 0 of initial util_avg when EAS is enabled ?

It's the same topic: How EAS should consider a newly created task ?

For now, we let the "performance" mode selects a CPU. This CPU will
most probably be worst CPU from a EAS pov because it's the idlest CPU
in the idlest group which is the opposite of what EAS tries to do

The current behavior is :
For every new task, the cpu selection is done assuming it's a heavy
task with the max possible load_avg,  and it looks for the idlest cpu.
This means that if the system is lightly loaded, scheduler will select
most probably a idle big core.
The utilization of this new task is then set to half of the remaining
capacity of the selected CPU which means that the idlest you are, the
biggest the task will be initialized to. This can easily be half a big
core which can be bigger than the max capacity of a little like on
hikey960. Then, util_est  will keep track of this value for a while
which will make this task like a big one.

>
> For 1, that would mean all forkees go on prev_cpu. I can see how that
> can be more energy-efficient in some use-cases (the one you described
> for example), but that also has drawbacks. Placing the task on a big
> CPU can have an energy cost, but that should also help the task build
> it's utilization faster, which is what we want to make smart decisions

With current  behavior, little task are seen as big for a long time
which is not really help the task to build its utilization faster
IMHO.

> with EAS. Also, it isn't always true that going on the little CPUs is
> more energy efficient, only the Energy Model can tell. There is just no

selecting big or Little is not the problem here. The problem is that
we don't use Energy Model so we will most probably do the wrong
choice. Nevertheless,  putting a task on big is clearly the wrong
choice  in the case I mentioned above " shell script on hikey960".

> perfect solution, so I'm still not fully decided on that one ...
>
> For 2, I'm a little bit more reluctant, because that has more
> implications ... That could probably harm some fairly standard use
> cases (an simple app-launch for example). Enqueueing something new on a
> CPU would go unnoticed, which might be fine for a very small task, but
> probably a major issue if the task is actually big. I'd be more
> comfortable with 2 only if we also speed-up the PELT half-life TBH ...
>
> Is there a 3 that I missed ?

Having something in the middle like taking into account load and/org
utilization of the parent in order to mitigate big task starting with
small utilization and small task starting with big utilization.
It's probably not perfect because big tasks can create small ones and
the opposite but if there are already big tasks, assuming that the new
one is also a big one should have less power impact as we are already
consuming power for the current bigs. At the opposite, if little are
running, assuming that new task is little will not harm the power
consumption unnecessarily.

My main concern is that by making no choice, you clearly make the most
power consumption choice which is a bit awkward for a policy that
wants to minimize power consumption.

Regards,
Vincent
>
> Thanks,
> Quentin

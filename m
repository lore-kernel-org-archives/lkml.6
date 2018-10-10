Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767A5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C32204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDNcoxtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C32204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJJQL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:11:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41274 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeJJQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:11:26 -0400
Received: by mail-io1-f66.google.com with SMTP id q4-v6so3291743iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AObbxNd0OdSi+1w+ILy5OzESNhontvK25MsKd41jHZ8=;
        b=SDNcoxtEStl9Xq22Yo3sbRgTebsNjLJuGMqlwHoekupkt6vnq8NJofgIlr2xfzqEBD
         Ev0s7JqnwWUbvTTJ5ae2Ze+BpsVe2+2kK1xJ1XDR8esX1kPSNNWAj+z5ImP3pIEZ9K/p
         OyiCa5IM7//Sc3dn7aEAdImj1tYGySafQ7W8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AObbxNd0OdSi+1w+ILy5OzESNhontvK25MsKd41jHZ8=;
        b=cPlMGNpzN0fxUlcssJT264nT//h7iUs3aAw5M6jLkxZTqjo/0p2El6b2jkdZwv+ArZ
         1PZEN3LaQSxLK+RXMuWKcKWXNKI0TFSjhB/GHB441D19KP3/XnPoyUDa6X2QgDxkOKxf
         t1PtJlEh1eDNL/nirkjonpfxVbcCMmfSFnWxQbl6gH0Vz6i8XLmcHGKLL+iM7JP3FiMF
         jW8FIzm+YJADWUUKdzsE6UT5nOjTrNnmLq8+1bsy47TCR7otbXpUy9mzy003Zc5Vnl2K
         mZ9rvZT+4JwTiRzoLwc1NrOqisvq0p+PP7K1xCBKyXT8VtI9wk0mU+tVHq970dFzbKkm
         SKnA==
X-Gm-Message-State: ABuFfojt5pdknTxiandbGzGuRU9oUI9Hh0rU1W54PkFD/Yv1aevKtMQZ
        6AXrY4G6F51h/GkYv9mDP5J804xJlh+SVFvKCPSrHXmzsnE=
X-Google-Smtp-Source: ACcGV622H6L6dVzvJ106LZe4peLMPXFvI6Ou6WQNLnWtJIh+dcPckAx9GJPHh5pDEYf2jrIBt7N6n4yCYIljOq//dfQ=
X-Received: by 2002:a6b:254:: with SMTP id 81-v6mr16129592ioc.183.1539161416113;
 Wed, 10 Oct 2018 01:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
In-Reply-To: <20181010082933.4ful4dzk7rkijcwu@queper01-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 10 Oct 2018 10:50:05 +0200
Message-ID: <CAKfTPtA1sgf77xLUPr74iEEb+W8PGCMCkgu+Kw8xM_Jxx7_hjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 at 10:29, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Thara,
>
> On Wednesday 10 Oct 2018 at 08:17:51 (+0200), Ingo Molnar wrote:
> >
> > * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> >
> > > Thermal governors can respond to an overheat event for a cpu by
> > > capping the cpu's maximum possible frequency. This in turn
> > > means that the maximum available compute capacity of the
> > > cpu is restricted. But today in linux kernel, in event of maximum
> > > frequency capping of a cpu, the maximum available compute
> > > capacity of the cpu is not adjusted at all. In other words, scheduler
> > > is unware maximum cpu capacity restrictions placed due to thermal
> > > activity. This patch series attempts to address this issue.
> > > The benefits identified are better task placement among available
> > > cpus in event of overheating which in turn leads to better
> > > performance numbers.
> > >
> > > The delta between the maximum possible capacity of a cpu and
> > > maximum available capacity of a cpu due to thermal event can
> > > be considered as thermal pressure. Instantaneous thermal pressure
> > > is hard to record and can sometime be erroneous as there can be mismatch
> > > between the actual capping of capacity and scheduler recording it.
> > > Thus solution is to have a weighted average per cpu value for thermal
> > > pressure over time. The weight reflects the amount of time the cpu has
> > > spent at a capped maximum frequency. To accumulate, average and
> > > appropriately decay thermal pressure, this patch series uses pelt
> > > signals and reuses the available framework that does a similar
> > > bookkeeping of rt/dl task utilization.
> > >
> > > Regarding testing, basic build, boot and sanity testing have been
> > > performed on hikey960 mainline kernel with debian file system.
> > > Further aobench (An occlusion renderer for benchmarking realworld
> > > floating point performance) showed the following results on hikey960
> > > with debain.
> > >
> > >                                         Result          Standard        Standard
> > >                                         (Time secs)     Error           Deviation
> > > Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> > > Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> >
> > Wow, +13% speedup, impressive! We definitely want this outcome.
> >
> > I'm wondering what happens if we do not track and decay the thermal load at all at the PELT
> > level, but instantaneously decrease/increase effective CPU capacity in reaction to thermal
> > events we receive from the CPU.
>
> +1, it's not that obvious (to me at least) that averaging the thermal
> pressure over time is necessarily what we want. Say the thermal governor
> caps a CPU and 'removes' 70% of its capacity, it will take forever for
> the PELT signal to ramp-up to that level before the scheduler can react.
> And the other way around, if you release the cap, it'll take a while
> before we actually start using the newly available capacity. I can also
> imagine how reacting too fast can be counter-productive, but I guess
> having numbers and/or use-cases to show that would be great :-)

The problem with reflecting directly the capping is that it happens
far more often than the pace at which cpu_capacity_orig is updated in
the scheduler. This means that at the moment when scheduler uses the
value, it might not be correct anymore. Then, this value are also used
when building the sched_domain and setting max_cpu_capacity which
would also implies the rebuilt the sched_domain topology ...

The pace of changing the capping is to fast to reflect that in the
whole scheduler topology

>
> Thara, have you tried to experiment with a simpler implementation as
> suggested by Ingo ?
>
> Also, assuming that we do want to average things, do we actually want to
> tie the thermal ramp-up time to the PELT half life ? That provides
> nice maths properties wrt the other signals, but it's not obvious to me
> that this thermal 'constant' should be the same on all platforms. Or
> maybe it should ?

The main interest of using PELT signal is that thermal pressure will
evolve at the same pace as other signals used in the scheduler. With
thermal pressure, we have the exact same problem as with RT tasks. The
thermal will cap the max frequency which will cap the utilization of
the tasks running on the CPU

>
> Thanks,
> Quentin
>
> >
> > You describe the averaging as:
> >
> > > Instantaneous thermal pressure is hard to record and can sometime be erroneous as there can
> > > be mismatch between the actual capping of capacity and scheduler recording it.
> >
> > Not sure I follow the argument here: are there bogus thermal throttling events? If so then
> > they are hopefully not frequent enough and should average out over time even if we follow
> > it instantly.
> >
> > I.e. what is 'can sometimes be erroneous', exactly?
> >
> > Thanks,
> >
> >       Ingo

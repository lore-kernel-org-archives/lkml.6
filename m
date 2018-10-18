Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B792DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559972145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559972145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJRPIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:08:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45335 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeJRPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:08:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so23162190oig.12;
        Thu, 18 Oct 2018 00:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roC9j8EstnfLJ2Q2aL3Vsdf6fGvhGS6j/JlIz5Wrufs=;
        b=eqz59VyWha/c9aFfh3fF1vm2sDLjEW2IhZSaWaLH+r4m1js0n57GH9AMmHPcAQmB1D
         E7UGXxLvuiVFU6yf0FKrPXXohQTZ3hhN+mVMJLawgSWG87gZobIrKkJE8jXXuI1JWtPu
         Tuf29ryannWinfoJ59eExjuqWf7y0BnGWKjQDuwhjOrGIUudmjP7TkDIrFHxFQ1hTCG3
         FI4kjrx5ULgm5BJiohAq+/OXBe16T3o4xo1N1d8Df5juPziYRSGNSFJfzmPU23w6iq0r
         hb3GWE1GU52T8jKyTjZ7KOikGUkiZXL6q1DG12Il4CQmlikaPPyQEb7Tj+k8NZKnOG0o
         Ul2A==
X-Gm-Message-State: ABuFfogHt2kK+tEfkpDo6LyeAhMv5rZD/uruPeKQ5lP4x0qF1Ew8R+0x
        Bqf8DMDlyZcE4ag9xIxDKZtlnyCPWy6MMS0ZKKw=
X-Google-Smtp-Source: ACcGV60L5/21wuILvbH9oPBqlBsUmF2/KOiTwyASXSlXjFkMDZq9aqF7gpN4XdqpV+w2/d/VypYSWEvKGkNuph2G1wk=
X-Received: by 2002:aca:e24f:: with SMTP id z76-v6mr16376439oig.95.1539846520247;
 Thu, 18 Oct 2018 00:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
 <20181016073305.GA64994@gmail.com> <5BC76181.90105@linaro.org> <20181018064849.GA42813@gmail.com>
In-Reply-To: <20181018064849.GA42813@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Oct 2018 09:08:25 +0200
Message-ID: <CAJZ5v0g=CnAv6HC6H68ub0KbO8Z8Fx4BtW=mjfEshNsnNX407w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 8:48 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> > On 10/16/2018 03:33 AM, Ingo Molnar wrote:
> > >
> > > * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > >
> > >>>> Regarding testing, basic build, boot and sanity testing have been
> > >>>> performed on hikey960 mainline kernel with debian file system.
> > >>>> Further aobench (An occlusion renderer for benchmarking realworld
> > >>>> floating point performance) showed the following results on hikey960
> > >>>> with debain.
> > >>>>
> > >>>>                                         Result          Standard        Standard
> > >>>>                                         (Time secs)     Error           Deviation
> > >>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> > >>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> > >>>
> > >>> Wow, +13% speedup, impressive! We definitely want this outcome.
> > >>>
> > >>> I'm wondering what happens if we do not track and decay the thermal
> > >>> load at all at the PELT level, but instantaneously decrease/increase
> > >>> effective CPU capacity in reaction to thermal events we receive from
> > >>> the CPU.
> > >>
> > >> The problem with instantaneous update is that sometimes thermal events
> > >> happen at a much faster pace than cpu_capacity is updated in the
> > >> scheduler. This means that at the moment when scheduler uses the
> > >> value, it might not be correct anymore.
> > >
> > > Let me offer a different interpretation: if we average throttling events
> > > then we create a 'smooth' average of 'true CPU capacity' that doesn't
> > > fluctuate much. This allows more stable yet asymmetric task placement if
> > > the thermal characteristics of the different cores is different
> > > (asymmetric). This, compared to instantaneous updates, would reduce
> > > unnecessary task migrations between cores.
> > >
> > > Is that accurate?
> >
> > Yes. I think it is accurate. I will also add that if we don't average
> > throttling events, we will miss the events that occur in between load
> > balancing(LB) period.
>
> Yeah, so I'd definitely suggest to not integrate this averaging into
> pelt.c in the fashion presented, because:
>
>  - This couples your thermal throttling averaging to the PELT decay
>    half-time AFAICS, which would break the other user every time the
>    decay is changed/tuned.
>
>  - The boolean flag that changes behavior in pelt.c is not particularly
>    clean either and complicates the code.
>
>  - Instead maybe factor out a decaying average library into
>    kernel/sched/avg.h perhaps (if this truly improves the code), and use
>    those methods both in pelt.c and any future thermal.c - and maybe
>    other places where we do decaying averages.
>
>  - But simple decaying averages are not that complex either, so I think
>    your original solution of open coding it is probably fine as well.
>
> Furthermore, any logic introduced by thermal.c and the resulting change
> to load-balancing behavior would have to be in perfect sync with cpufreq
> governor actions - one mechanism should not work against the other.

Right, that really is required.

> The only long term maintainable solution is to move all high level
> cpufreq logic and policy handling code into kernel/sched/cpufreq*.c,
> which has been done to a fair degree already in the past ~2 years - but
> it's unclear to me to what extent this is true for thermal throttling
> policy currently: there might be more governor surgery and code
> reshuffling required?

It doesn't cover thermal management directly ATM.

The EAS work kind of hopes to make a connection in there by adding a
common energy model to underlie both the performance scaling and
thermal management, but it doesn't change the thermal decision making
part AFAICS.

So it is fair to say that additional governor surgery and code
reshuffling will be required IMO.

Thanks,
Rafael

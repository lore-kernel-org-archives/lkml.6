Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD524C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD392177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548753390;
	bh=vrXI8yHrxIkrM4N7wZLhAILXWwaN8p6nDDiwC+SRHiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xtvp3JLEwbg2e/ImIygoopop9B1+6s0uib0Av/XXfWZ+Y+vzPBQvhGqdMEceVh+Mt
	 KeUNNc1e6eI6rDD+bl/UxhS1msxfS8i3m4q/FCgTvvcCW2/kn3iaoWsUxcF0m9pSjD
	 N156GuN6o3ohhaHa5yHNGEStAk5+mTsmNnZUwZOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfA2JQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:16:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34155 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2JQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:16:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so17291332otk.1;
        Tue, 29 Jan 2019 01:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5X5QKK2tBiAEW1D1siDTuE5MYQmrLG2VxxWhkSDspks=;
        b=TI9fOqt5A3ep37cuAmVHs0j8x4Qt2EUDEr92C7pxn9cwkB20U3Xld5mBLYI4T03SXA
         lL2t52haDsdQniXH+3FJCS22U2/+AExv+Ssd78S/ED7F/NicfF0EAO3EWrqrQbdjticU
         4Z0m1qTghJ7MjraYpJE6Tq0fRfZOtk8HoQ+/9dPDQGH5U/TuPf7YXQaPqAVvYWSMHCdy
         /RFPvFCJF3eJ8aAYf15+BgV3Gh8oyYPPgrECcc2MEI6hBJvpUUrNf0ikYp8cn87/8VVM
         afkdxjVvluk0F6H2/1LaDTsFl1+AOac2zqLuXL5KfWOZg76KfYxpuxzn2J/YB9YyW1k4
         U6nA==
X-Gm-Message-State: AJcUukesqdoYGrLn/rgLsZRRpfu6WowKE59Qb6WRyaS63PTuvJz62PnC
        O8SGYpq5njzjPCrNKFRsfQ255NKcB+5D3D5G07o=
X-Google-Smtp-Source: ALg8bN7hyQ7/Ox2CxWM0Hd7ERn0UPiwP8r1Uvgl3jrhGKhe4DHXQQWf7o66DBFRPsjAQrD1gPaqYp3uOp822jWG17W0=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr18406170otn.200.1548753387615;
 Tue, 29 Jan 2019 01:16:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7> <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
 <CAHLCerMAY8ZZRap4RQictmPkjhmk8gjKxRoS4o2ObP9jdv+FAQ@mail.gmail.com> <20190129070938.lqhejdu4ilra65ow@vireshk-i7>
In-Reply-To: <20190129070938.lqhejdu4ilra65ow@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jan 2019 10:16:15 +0100
Message-ID: <CAJZ5v0iXv3yLtGqti1OLbh-7LF1hZyvW+HTTG5mVFmEJ8a1SAA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 8:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-01-19, 11:50, Amit Kucheria wrote:
> > On Tue, Jan 29, 2019 at 11:16 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > On Tue, Jan 29, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 29-01-19, 10:25, Amit Kucheria wrote:
> > > > > All cpufreq drivers do similar things to register as a cooling device.
> > > > > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > > > > to register the cooling device on their behalf. This allows us to get
> > > > > rid of duplicated code in the drivers.
> > > > >
> > > > > In order to allow this, we add a struct thermal_cooling_device pointer
> > > > > to struct cpufreq_policy so that drivers don't need to store it in a
> > > > > private data structure.
> > > > >
> > > > > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > > > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > ---
> > > > >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> > > > >  include/linux/cpufreq.h   |  9 +++++++++
> > > > >  2 files changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > index e35a886e00bc..0f9b50d3ee91 100644
> > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > @@ -19,6 +19,7 @@
> > > > >
> > > > >  #include <linux/cpu.h>
> > > > >  #include <linux/cpufreq.h>
> > > > > +#include <linux/cpu_cooling.h>
> > > > >  #include <linux/delay.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/init.h>
> > > > > @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
> > > > >       if (cpufreq_driver->ready)
> > > > >               cpufreq_driver->ready(policy);
> > > > >
> > > > > +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> > > > > +     if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> > > > > +             policy->cdev = of_cpufreq_cooling_register(policy);
> > > > > +#endif
> > > >
> > > > I am not sure if Rafael wanted it this way but maybe something like this:
> > > >
> > > >         if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> > > >             cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
> > > >                 policy->cdev = of_cpufreq_cooling_register(policy);
> > > >
> > > > We never wanted ifdef hackery to be in there :)
> > >
> > > OK, that makes more sense. Should I just send out a fixup patch or the
> > > entire series?
>
> Single patch should be fine I believe.
>
> > FWIW, I checked drivers/cpufreq and drivers/thermal before converting
> > over and there is a mixed use of #if IS_ENABLED and if(IS_ENABLED).
> >
> > Perhaps we should clean it up?
>
> No objections from me on that.

Generally speaking, though, "if (IS_ENABLED(SYMBOL))" can only be used
if all of the symbols in the conditional branch are defined regardless
of whether or not SYMBOL itself is defined, so careful there.

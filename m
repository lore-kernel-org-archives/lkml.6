Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17880C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6BE20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548753210;
	bh=8dQJ39Qe6z1zQ2+fMzLdCH8kWMcupAo1/qGjcL523l0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uNK9dObx35faMs25zvz1YFP88rLH5hc0VtQByCwcJ6UXCg60s8jtaqvug2WXjw2d4
	 d6S9dSlVEPctsEoSCY9E0VzCWwzxz4VSw4q1OH5/Lo73+k28ONqflX3/aZxjaxrz/b
	 ThQzIVGkNeg3fRohFPqdYW5rLUUVyPu9SEUGcHCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfA2JN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:13:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38202 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2JN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:13:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id e12so17266496otl.5;
        Tue, 29 Jan 2019 01:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GUniQntzzZbkjZJqErsG9HvsQo//LjD7QjxdWEzWBg=;
        b=ogPOiqQxXSeWrU3NjU2Fvw/uQ3/7ErUIAAg3RpEsMVwteI7+YzlKBpm2DzxWsS5GxR
         fUNu1rbBUWRNUoWatgEDiaqgabT3zBCce9DPuNdmEjJ4/D1ZwVOg7Gma3ftkryHDK+/5
         CBb3Xx0fWQXHJUcoU8zszBPLTtuDgJLGudrHukLtAxdPT1vBxrUW8NQOMLEaqWFoRZOE
         EUf4DjKHXLlsYfwy64n5DsU69BjDYy5XnT39EY6BCdDbVMiX9QONqFGM2Wr3/lilLoLI
         vcvvVbolByKjcXg88vCCCbQFF/Jt2tA8FDSuyK8zDau2hhgH0vfRiYTH37vx3Ck7a5L3
         NlFQ==
X-Gm-Message-State: AJcUukcF7cqaQLrI+ha13Wgj0QVUjBB8m15SwGjaeEIcq9UCksUciQxH
        UgD4ARo/jUdw0xew7utkdVQPCEjbloe5Obtzffw=
X-Google-Smtp-Source: ALg8bN5o+nljS0TUqxHT+VMjjGrf8DK6j3i1eECw1cVDlUNmvyNUgen0UMLoDmrrYtJB0txLTlfm1SUwPazfUwgBbO8=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr19790804oti.258.1548753208127;
 Tue, 29 Jan 2019 01:13:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7> <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
In-Reply-To: <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jan 2019 10:13:15 +0100
Message-ID: <CAJZ5v0hs2Af9DJoxiyMmFt7R5nYbGOCqgG5cvPOL8yrQXN-ZUw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 6:46 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Tue, Jan 29, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 29-01-19, 10:25, Amit Kucheria wrote:
> > > All cpufreq drivers do similar things to register as a cooling device.
> > > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > > to register the cooling device on their behalf. This allows us to get
> > > rid of duplicated code in the drivers.
> > >
> > > In order to allow this, we add a struct thermal_cooling_device pointer
> > > to struct cpufreq_policy so that drivers don't need to store it in a
> > > private data structure.
> > >
> > > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> > >  include/linux/cpufreq.h   |  9 +++++++++
> > >  2 files changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index e35a886e00bc..0f9b50d3ee91 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -19,6 +19,7 @@
> > >
> > >  #include <linux/cpu.h>
> > >  #include <linux/cpufreq.h>
> > > +#include <linux/cpu_cooling.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/device.h>
> > >  #include <linux/init.h>
> > > @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
> > >       if (cpufreq_driver->ready)
> > >               cpufreq_driver->ready(policy);
> > >
> > > +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> > > +     if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> > > +             policy->cdev = of_cpufreq_cooling_register(policy);
> > > +#endif
> >
> > I am not sure if Rafael wanted it this way but maybe something like this:
> >
> >         if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
> >             cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
> >                 policy->cdev = of_cpufreq_cooling_register(policy);
> >
> > We never wanted ifdef hackery to be in there :)
>
> OK, that makes more sense. Should I just send out a fixup patch or the
> entire series?

Just a fixup patch, please.

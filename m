Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E040C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03AD2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzKLYuJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfA2GUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:20:16 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35677 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfA2GUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:20:15 -0500
Received: by mail-ua1-f65.google.com with SMTP id d2so6469746ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 22:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wkFrcpsH8vjnkt+YHK0343FnxE8nm4ndTlDY14pPeo=;
        b=PzKLYuJECQl8uW3GlH8caYRhkVOacJWltOLHe5gZryayHeYuf7bayT2WtFWUV2mRce
         z1evoYruiOcILgP7wmrTO764Zt4DVf2tlsC/8ucKSMoqd18BNEVYXwXoLnXGI5WA4SJZ
         EX8787G0fAdHC0yg0AySwj5tkFMpYBkCeKUi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wkFrcpsH8vjnkt+YHK0343FnxE8nm4ndTlDY14pPeo=;
        b=QrOOHTd2iHfVu5x6RaYWezkn7c2YLgaHerfp+gRZ6v3AhQhsXWPtEEF07vZJ+BVNtY
         /fHJfFX9eueJTInauzyrGyaISVLPO4cFXzhxxdCkjut9NgZqWvUTnVAHeCR7jcO2N2Fi
         +RgkJxeyDtU/BMzXCS4BIFYgQGwnjAaq671EnN3yHvFaz5E1NOuf85uKA6pnJWyXB9qF
         nVb8QvlUTbKNqyB1C2G4XqUwmBd7jPbTx8sKuEOTCnB/LlOEwjbIoYpbvWIzVxEb6biK
         Muh7RKYYQAEN/F2YRCvqZSdvZZ2nOFZbUZ43/I3LMHSHj3uZLdFLnJ7HM2Brl2vz928J
         aklw==
X-Gm-Message-State: AJcUukcJLGgNUxHLU70NyUvbp7vf0YdPHA4PWQ0sA9Z1cpa6CYQOTIGA
        6AEI1E1aQlgjUs1UG5BP/gIWIyNxSJJKHnZc04f2gg==
X-Google-Smtp-Source: ALg8bN7FcTGEOOFrdbjHYb3dyb4dqCTGgwrWRzdQ5AebSUoTqgU9f74ZhXm8tcz4WSOhapasFcUCbhnOJDv4pLM/Rno=
X-Received: by 2002:ab0:26cb:: with SMTP id b11mr10050153uap.112.1548742814354;
 Mon, 28 Jan 2019 22:20:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7> <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
In-Reply-To: <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 29 Jan 2019 11:50:03 +0530
Message-ID: <CAHLCerMAY8ZZRap4RQictmPkjhmk8gjKxRoS4o2ObP9jdv+FAQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:16 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
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

FWIW, I checked drivers/cpufreq and drivers/thermal before converting
over and there is a mixed use of #if IS_ENABLED and if(IS_ENABLED).

Perhaps we should clean it up?

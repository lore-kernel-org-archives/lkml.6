Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A475BC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D4218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548416732;
	bh=JI+AfpCxsprQpY/aWJtY9T3GNDpHgw6OMJH5OU5Q8yc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2lDo3CeC53sT3KGOUWhn9vm2nyfegTxE9YQjf25C+2dMY5YzWC72QUIgMXkSRPaCq
	 Sgr9DjDkA1Lhec1bbPEm9x8b/GXjxNqzV0xTG6Wt7zLhQgR+vIW/sFcGbkidbUFftU
	 /SUpwbWltV77jM2S2RuzxCDmr8FhVY1cWVSAu1Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfAYLpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:45:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36804 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAYLpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:45:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so8260851otk.3;
        Fri, 25 Jan 2019 03:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4Cp6HDwBhrK740eAcs5gva9lGThOBIN7jzLKKpLtX4=;
        b=k5SS5bI7kz8UAjQtYQVzXWPWUfS7fvtmEa5082FTWzTsn2CKWdV5nrvAOwxFrYEWmZ
         4n2wjC9E2geIv8BMofrWw1ZqCIHphkm3BCYmH4ruycRjXmYX0OIX3WB9Hc3GT3Cauz1j
         r2aY78HwtLENzxHbzot4ZWaNeGSe2yy+8NhC4oQZAUU2I/Cc58889ki+IOFBqzqi7b0H
         q3qUnNI1qjPYAmpKNY6McCZkyyq3+4no9iCJvDYS6nWawCe/tCFt4cwJ0G5Hi1QMgp4P
         ofxPvgzZYPBmyG3E/70UOJhFmRezjcx1ArFOvv8rH2joTWhYANgVeNHF8KGS2KTQzTcz
         3EWw==
X-Gm-Message-State: AJcUukcDtaSt5oHVfTUK8Fw4kF1G05niMwtKto8xjt1XW2w7iiDM05U5
        NipfydfHhqsHU/2L7mbm/xvk+a9Dbvp2f0MvnQA=
X-Google-Smtp-Source: ALg8bN4v6TW/CvU0FupX2lBVTg4LbLOW16ZLTDh4sOAvid9nKmBWuv19gxN+OfNMeUKQmrfNTdmC4kv4lwAB7bTd+uo=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr7897682otl.343.1548416729065;
 Fri, 25 Jan 2019 03:45:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548398851.git.amit.kucheria@linaro.org>
 <73e091e2d56d9fa6eb94feaed9fc2be30bf6da20.1548398851.git.amit.kucheria@linaro.org>
 <20190125103152.7svjfmowgigznipm@vireshk-i7>
In-Reply-To: <20190125103152.7svjfmowgigznipm@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Jan 2019 12:45:17 +0100
Message-ID: <CAJZ5v0gA07-MKvXKH690wRF0cE3AAP3kLHtLRJpiT1Dmrs_beA@mail.gmail.com>
Subject: Re: [PATCHv3 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-01-19, 12:32, Amit Kucheria wrote:
> > All cpufreq drivers do similar things to register as a cooling device.
> > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > to register the cooling device on their behalf. This allows us to get
> > rid of duplicated code in the drivers.
> >
> > In order to allow this, we add a struct thermal_cooling_device pointer
> > to struct cpufreq_policy so that drivers don't need to store it in a
> > private data structure.
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/cpufreq/cpufreq.c |  6 ++++++
> >  include/linux/cpufreq.h   | 21 +++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..cf1be057caf4 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1318,6 +1318,9 @@ static int cpufreq_online(unsigned int cpu)
> >       if (cpufreq_driver->ready)
> >               cpufreq_driver->ready(policy);
> >
> > +     if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> > +             register_cooling_device(policy);
> > +
> >       pr_debug("initialization complete\n");
> >
> >       return 0;
> > @@ -1405,6 +1408,9 @@ static int cpufreq_offline(unsigned int cpu)
> >               goto unlock;
> >       }
> >
> > +     if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> > +             unregister_cooling_device(policy);
> > +
> >       if (cpufreq_driver->stop_cpu)
> >               cpufreq_driver->stop_cpu(policy);
> >
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index bd7fbd6a4478..c7eb59b8ce94 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -13,6 +13,7 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/cpu_cooling.h>
> >  #include <linux/completion.h>
> >  #include <linux/kobject.h>
> >  #include <linux/notifier.h>
> > @@ -151,6 +152,9 @@ struct cpufreq_policy {
> >
> >       /* For cpufreq driver's internal use */
> >       void                    *driver_data;
> > +
> > +     /* Pointer to the cooling device if used for thermal mitigation */
> > +     struct thermal_cooling_device *cdev;
> >  };
> >
> >  /* Only for ACPI */
> > @@ -386,6 +390,12 @@ struct cpufreq_driver {
> >   */
> >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> >
> > +/*
> > + * Set by drivers that want the core to automatically register the cpufreq
> > + * driver as a thermal cooling device.
> > + */
> > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> > +
> >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> >
> > @@ -415,6 +425,17 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> >                       policy->cpuinfo.max_freq);
> >  }
> >
> > +static inline void register_cooling_device(struct cpufreq_policy *policy)
> > +{
> > +     policy->cdev = of_cpufreq_cooling_register(policy);
> > +}
> > +
> > +static inline void unregister_cooling_device(struct cpufreq_policy *policy)
> > +{
> > +     cpufreq_cooling_unregister(policy->cdev);
> > +     policy->cdev = NULL;
> > +}
>
> I thought that we discussed over chat that you wouldn't add any
> wrapper routines. How do you see these getting used ? I will suggest
> that this should be open coded in the core itself.

Agreed.

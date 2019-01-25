Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEDFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CB2218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9J3S2BF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfAYMSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:18:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42095 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:18:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so10377884qtq.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzaFCXWgo3dTEQrWt7ngxsPNftIjpavsByW7Uw5Vi1k=;
        b=f9J3S2BFjh2Nzq2Shygsvmddpa/wsH9+pkyeiH0YXx6MpQ8ijq5vbS4yDNZG2Sts73
         Te/bfl2uO5xLrTmHUOAf5ENRvL7W3alPADjOugj6Z1gWImAya2didHAjZehy1tb5ox2z
         5nLBPcw8nvxefpOfIm/WYQHUB1/dTqxyptz6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzaFCXWgo3dTEQrWt7ngxsPNftIjpavsByW7Uw5Vi1k=;
        b=Qq5j+XEo2hft8+DM5ODEA2AgBhyhXcJ3uMjtuIV+x325ZBHbx5EinTDNj6sS9VEiLv
         TLfrqRARTS/HUNkGlu7UShBxOaJsMLhQsyKfF3g1dEX3DLXZzrzrOSxc2owPjgJP+qwn
         goTNC1aurjNW5HcAtWYh1vUmEsjX/PiyWFGmni/oGtIvLh0u5sv+2CA1bmWxw9XuM2/d
         bz2IytwSzjsybx27qj1ePirTYiLB/mXka1HEdziwsETsmrW2f4DggNuG/jikym7CJoxj
         pJev5VvW7yeePbKZqqE2T1f7ZshBCzz/LBE4ezLJ/n+IvxgX8x/2+i64BuO7RFgqEU2q
         jL7g==
X-Gm-Message-State: AJcUukeBaEmsaMJoDazLKWAJ2AJTywjKxXcIJVVMSAAGeXUq2AyC1mSN
        +YwuG1pgWZd6Uin6INftfxUoITCb6TZSorWW5oeYiQ==
X-Google-Smtp-Source: ALg8bN52I6pgMY1Kgs6UVFvxCqDPSsRZ8tWdiTVNxcxxEsKJaUF4IrOFvxSYoh0Wmhns3mVMWwPhzCWezCwC2VIJoKY=
X-Received: by 2002:aed:3861:: with SMTP id j88mr10946617qte.31.1548418699099;
 Fri, 25 Jan 2019 04:18:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548398851.git.amit.kucheria@linaro.org>
 <73e091e2d56d9fa6eb94feaed9fc2be30bf6da20.1548398851.git.amit.kucheria@linaro.org>
 <20190125103152.7svjfmowgigznipm@vireshk-i7>
In-Reply-To: <20190125103152.7svjfmowgigznipm@vireshk-i7>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 25 Jan 2019 17:48:08 +0530
Message-ID: <CAP245DWMXSC+omrdrhy1_ZCXqY490kQ9jr1BnbpHXFrujW34YQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Jan 25, 2019 at 4:01 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

Aah, I understood your earlier comment and the chat to mean that we
could get rid of the #ifdefs. I didn't catch on to the fact you wanted
to get rid of the wrapper routines itself. My bad.

Will respin.

Regards,
Amit

Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B3AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB32320989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mv6yoaXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfA2FqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:46:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40316 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfA2FqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:46:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so21004921qtf.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSQeS3OXHYnGtW1DMMGaDY9H9lWAyOYI7/V2LTUdWjs=;
        b=Mv6yoaXcXkdtzMAkc4Z/NDQZo8yIylpgneWz7dbLF/cCtvS5HGfJqJO5VIeCHXwj8R
         civNrigONbuTrMngLj8vDhBUe3nd7z888Lgcb7JelXDhg3E0gc69/fO9n7oM8N4IXEf9
         yJtpVcB2ccWk4KMjp8Vrm8+tbQp4znlqXp2Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSQeS3OXHYnGtW1DMMGaDY9H9lWAyOYI7/V2LTUdWjs=;
        b=tTaLNsF3TKKgZn5D572vMAeAp33UYXIo1edQoQtAdgo2lZM5/5sOa5etgWq9NQJEsQ
         LaQIUpmG9ruSB4bRUMWKBbkstLGtexmFcS/ZzN7e1wn5CRRnzMZjQI1lusuPsVUMEmWJ
         5nHe8Tv8wAjQooPnx+h8ZUBoFvX8Kh3TesFgYAZeKjtDobYLvCLOLw+7+nFKC1qAumus
         gN+Ia5ezv1phXk01RE4H/CQ3/1nA/rFtDoLnnUJxFBHriUgNFaA8yHrIFF4En7ZQjVjg
         MRqxuEYLE30i/S+ABHPs5q3ev1HDc7ulI8SNlzoKkfIFPBdOM3hSh4IhiAVCO/1qUYoU
         B9kQ==
X-Gm-Message-State: AJcUukeqWP6kP0m1CgQ9arZ4PeeXP1DF4ou+gciN7kcpYywZf/EvPnPa
        Zn4iH8fU+qNZA9Xxztl3iOwUCP/f0qIjR2nwjQVtQA==
X-Google-Smtp-Source: ALg8bN41k854mma57ysOQpWfQV6EHg1Cl9/4B4XAxKufsPfwWCFLqar1PuyohCIrP6MRYfSgIWO3Uwbc+jN/VtjV36s=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr24507932qts.144.1548740781438;
 Mon, 28 Jan 2019 21:46:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7>
In-Reply-To: <20190129053618.laa6nscfvlmhhkb5@vireshk-i7>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 29 Jan 2019 11:16:10 +0530
Message-ID: <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
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

On Tue, Jan 29, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-01-19, 10:25, Amit Kucheria wrote:
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
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> >  include/linux/cpufreq.h   |  9 +++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..0f9b50d3ee91 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -19,6 +19,7 @@
> >
> >  #include <linux/cpu.h>
> >  #include <linux/cpufreq.h>
> > +#include <linux/cpu_cooling.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
> >       if (cpufreq_driver->ready)
> >               cpufreq_driver->ready(policy);
> >
> > +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> > +     if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> > +             policy->cdev = of_cpufreq_cooling_register(policy);
> > +#endif
>
> I am not sure if Rafael wanted it this way but maybe something like this:
>
>         if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
>             cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
>                 policy->cdev = of_cpufreq_cooling_register(policy);
>
> We never wanted ifdef hackery to be in there :)

OK, that makes more sense. Should I just send out a fixup patch or the
entire series?

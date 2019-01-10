Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ED8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535F02173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EY1cxcFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfAJJDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:03:44 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37273 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfAJJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:03:43 -0500
Received: by mail-vs1-f65.google.com with SMTP id n13so6562071vsk.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cq/LJE+M2szGt0iqQyBFymvPRV2Wpa+Cosev17WtFYw=;
        b=EY1cxcFTAfs7Ai9Pnyl+8lbFw2ccyvPu2LW3zAMhb5anwaqjci4JNKHgSNKyNRP1yr
         QpGz/2//c9va1ms0ai93dzZhrKqNdDvh2GDsMl/QfxE/FSPDaEEgsDLkrutu571CPn8E
         FYAZTPNBvR9VMJ2blC5O/lJ/avoJGl62V2M1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq/LJE+M2szGt0iqQyBFymvPRV2Wpa+Cosev17WtFYw=;
        b=gFrypE2zgdE08oT6boP3ks4asoOT+RLcHIdFu9pWKsZh7ChVy8eZD0TXS1STQnbx3b
         0/dS3k3J1aaWvPO/uYki+/yMonVsZnlfyf5kMIljol3A0QuerZu5RUpYKe3DI2edYPJB
         Fjl496BBy9fTElCDMpOYdA7nH/2TSQ0lvM8zU3BaiVjcsY6I3ivz5YzWC5rS7mRTl4dg
         +HZ+MIrOV8M6AZdrmD4aLqgYRy5sLJAVOMGAuQS+1ywN0waetY+TLruDi56gS01dlWlZ
         bE1SmdDpVryWmU5DyKhO7dCK0/SXhq2UVD4C03MJiGZuLEnZ78ygz0OGEOuBPjlU4QVE
         id4A==
X-Gm-Message-State: AJcUukd1qR/KTXVjGBy5oLalArOgxaE5Ocro19yc2SxVTWadDN1xin1X
        6pQZ4LfP+/HKzLhnzed9VlvE+C0UHzQ+fB+Er5CnYA==
X-Google-Smtp-Source: ALg8bN4pzqMeB0IOSuC+roawxU1Zi4G+SKG9EQiaaJntXQ1Mds1d4KevZDeyxrZnPyqlmwXyfHCSZyeCMNJbP1+IfgE=
X-Received: by 2002:a67:e0d4:: with SMTP id m20mr3970609vsl.182.1547111022238;
 Thu, 10 Jan 2019 01:03:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <3c7d0e4a8373e89d6922543ccf56749970de5567.1547078153.git.amit.kucheria@linaro.org>
 <20190110061210.lz5i5wf7wxh22q7c@vireshk-i7>
In-Reply-To: <20190110061210.lz5i5wf7wxh22q7c@vireshk-i7>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 10 Jan 2019 14:33:31 +0530
Message-ID: <CAHLCerPwzJ75Z+AdnrAyV2kY5AV4p5NFbGR1VUEufagGq=2bDw@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] cpufreq: qcom-hw: Register as a cpufreq cooling device
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 10-01-19, 05:30, Amit Kucheria wrote:
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 649dddd72749..1c01311e5927 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/bitfield.h>
> >  #include <linux/cpufreq.h>
> > +#include <linux/cpu_cooling.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -216,7 +217,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> >  static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> >  {
> >       void __iomem *base = policy->driver_data - REG_PERF_STATE;
> > +     struct thermal_cooling_device *cdev = policy->cooldev;
> >
> > +     if (cdev)
> > +             cpufreq_cooling_unregister(cdev);
> >       kfree(policy->freq_table);
> >       devm_iounmap(&global_pdev->dev, base);
> >
> > @@ -238,6 +242,7 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> >       .init           = qcom_cpufreq_hw_cpu_init,
> >       .exit           = qcom_cpufreq_hw_cpu_exit,
> >       .fast_switch    = qcom_cpufreq_hw_fast_switch,
> > +     .ready          = generic_cpufreq_ready,
> >       .name           = "qcom-cpufreq-hw",
> >       .attr           = qcom_cpufreq_hw_attr,
> >  };
>
> I liked the idea of reducing code duplication, but not much the
> implementation. All we were able to get rid of was a call to
> of_cpufreq_cooling_register() and nothing else. Is it worth it ?
>
> Maybe we can add another flag in cpufreq.h:
>
> #define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
>
> and let the core do it all automatically by itself, that will get rid
> of code duplication actually.

I like the idea of a flag. I'll spin something implementing it in the next rev.

> @Rafael: What do you say ?

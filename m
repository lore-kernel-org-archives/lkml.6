Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F80CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7160C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547112756;
	bh=AuHRvUB18fTcqTG1z2dguFQBQnaJJG+1GR/8axSIbwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J9cEHn/NnJhlOzPDu9YzFaiUT9+l6anjjk3i9fPBO/mkgMAnnhS/0tzly8CMjOf6r
	 vMK5VOP885vqrt9UjUo9tw0H6QqyF/u6i5D7fhsAurqgwD/XRkmROmYG01djVuh/0y
	 hcZ46ZTU8dcZJsSv3cOk/t4RvgAxAkJfo6FLrydQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfAJJcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:32:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43114 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfAJJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:32:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so9341159otr.10;
        Thu, 10 Jan 2019 01:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWe8aiOlfHkTiEPAme+y+3DxEA3ueHtWT4PQaYLhd+c=;
        b=uY+GQE2RIkditXJlaTXwUGzjSoMFLwgLIHeKRAml/uUsrTNwGlndM4w9EGZMfaGVqf
         Udcl21jropgOrpS9w/ALZSkbHflqariO6a+zzQav4IOZZHM4pPPoh2iAfe0EqFW7gVIS
         VaqPd7uY2dS4leSUqOVNA38Pyjk1aydSBB148Ye9/BWFaUimLq/518c5atbvKlHiOda2
         LAWEr1uKb/PvtG8H+LLNcPq5RrsuQDBTqhCs+hjvUzkt3CmhugpbqY1ufP+aOtg9/rE2
         e6irbNxrv/eQ9KF9g/Yv4Xo38R86ZxAN/8rsakdo7wHuoSwnQzIH6K/TpvE3yg4DE1p+
         +5EQ==
X-Gm-Message-State: AJcUukdIaBgO1e/5DqNpnOuB++KncoV/l6NcOM3f7XX5bOvpb9UEkQ1V
        wwEpyrMvFd/0//TuQIclB/osM5265AhmND2N6nU=
X-Google-Smtp-Source: ALg8bN6yknZrv+z5LxfvrzW9pjdNiVd0ms9hz5f/t2AYaWcnpiyQyXp8TYi4KCnwvHyqfCj+v7+TjTV4kO7+/q+c/FY=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr6099001otn.200.1547112753154;
 Thu, 10 Jan 2019 01:32:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <3c7d0e4a8373e89d6922543ccf56749970de5567.1547078153.git.amit.kucheria@linaro.org>
 <20190110061210.lz5i5wf7wxh22q7c@vireshk-i7>
In-Reply-To: <20190110061210.lz5i5wf7wxh22q7c@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jan 2019 10:32:19 +0100
Message-ID: <CAJZ5v0hKODG2hT+8iwpX3te1dpbLPuy4=7RrEmAp=aATuEdkhA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] cpufreq: qcom-hw: Register as a cpufreq cooling device
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        bjorn.andersson@linaro.org, Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 7:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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
>
> @Rafael: What do you say ?

Getting rid of code duplication is good, let's do that.

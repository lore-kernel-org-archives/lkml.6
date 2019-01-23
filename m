Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA83C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4120861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548240804;
	bh=+qKiIdIE44PnJoROnYeCboyHBIgzvK2/qhoJ6bYsaLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xKm7pXLQIYjCMWziCL9SlMMIzvqbZLz8FN24QVNslGtdgaU2TgPKqKSURodx/ZKyx
	 jVGL3LD9ZVR4KdqBEd0/f9No6SJQlUSlsciVrE6JtTxEEOE2bMWQC/btx0C+l+47H+
	 srqBG5pxIp3Jg9CxNIZsCUqsASV1eKWnIgDZJcs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfAWKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:53:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35470 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfAWKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:53:22 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so1436996oif.2;
        Wed, 23 Jan 2019 02:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ADTjytmAzenk3tWw3iNskI0WI6s+ySevWLD6P1qk9M=;
        b=geWzdI1LRAaY4a6zpKvb6405o7XfrrKthI6GiiREsxEFDsiVXF/OsigqVfJZ0l1vyv
         KSRJ/fSrMVAj9YKbZyXtjGucqUp4kzkHkJU92SACNcx0sNxl1+EHmdEm8pJeCMLQjGwc
         +VV41yov91L2NkJQ9udAug7mbSu7kZIBPs7Um0KYHvdhr2xweeq42Uk0WtJP3gFMSE3F
         MDvKGQB67rNhphHwHYMJw8er8FbLEC7aPBxbxLhBsb1Wl8/jzsBL2S4R3B2nOJ1cDWoj
         b2Z5U+VrQ/Bl4XiUP/VgYggj4pDzLFD48ynutGJJHfD/dX1RVc2bbMvbguFD0nkEq9MS
         +ggw==
X-Gm-Message-State: AJcUukcLI1ByuVI6unkkfX6t87PYbeGXW+nwcY2wMn69JXuRcuCpQRU9
        y+7WfT2W/kwyhYZYtU/wq19S8MLze/uPPpt6N50=
X-Google-Smtp-Source: ALg8bN7JA5wESjPTsucWGvrSrzYqJGmmufZDZ3ZQKDwcvk5UVLnZ7/iEKDgXyNSOR2VTsrGAxa7b70O2TJwePSAWIZc=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr1111959oia.95.1548240801410;
 Wed, 23 Jan 2019 02:53:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
 <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7> <CAJZ5v0g12U0M3aJOvRgRg3=-6f+2jeG1rT5RjLoSciM0FwFofg@mail.gmail.com>
 <20190123104322.o3whk6rfiaootspn@vireshk-i7> <20190123104403.bl7mdidmvd7c227q@vireshk-i7>
In-Reply-To: <20190123104403.bl7mdidmvd7c227q@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jan 2019 11:53:10 +0100
Message-ID: <CAJZ5v0g0syxsHaLOUa+K7YkR0sf0rHQHOL6ytWg_8nhh16ZZMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-01-19, 16:13, Viresh Kumar wrote:
> > On 23-01-19, 11:39, Rafael J. Wysocki wrote:
> > > On Wed, Jan 23, 2019 at 11:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 21-01-19, 21:10, Amit Kucheria wrote:
> > > > > @@ -151,6 +152,11 @@ struct cpufreq_policy {
> > > > >
> > > > >       /* For cpufreq driver's internal use */
> > > > >       void                    *driver_data;
> > > > > +
> > > > > +#ifdef CONFIG_CPU_THERMAL
> > > > > +     /* Pointer to the cooling device if used for thermal mitigation */
> > > > > +     struct thermal_cooling_device *cdev;
> > > > > +#endif
> > > > >  };
> > > > >
> > > > >  /* Only for ACPI */
> > > > > @@ -386,6 +392,12 @@ struct cpufreq_driver {
> > > > >   */
> > > > >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> > > > >
> > > > > +/*
> > > > > + * Set by drivers that want the core to automatically register the cpufreq
> > > > > + * driver as a thermal cooling device.
> > > > > + */
> > > > > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> > > > > +
> > > > >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> > > > >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> > > > >
> > > > > @@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> > > > >                       policy->cpuinfo.max_freq);
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_CPU_THERMAL
> > > > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {
> > > > > +     policy->cdev = of_cpufreq_cooling_register(policy);
> > > > > +}
> > > > > +
> > > > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
> > > > > +     cpufreq_cooling_unregister(policy->cdev);
> > > > > +     policy->cdev = NULL;
> > > > > +}
> > > > > +#else
> > > > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {}
> > > > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
> > > > > +#endif
> > > >
> > > > The whole ifdef hackery here saves space for a pointer per policy.
> > > > Just get rid of it, it isn't worth it.
> > >
> > > Is struct thermal_cooling_device defined if CONFIG_THERMAL is unset?
> >
> > No and it is defined in thermal.h without any ifdef stuff.
>
> I meant it is always available and doesn't depend on CONFIG_THERMAL.

OK

I guess we can live with an extra unused pointer per policy on
platforms with CONFIG_CPU_THERMAL unset.

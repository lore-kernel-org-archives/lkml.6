Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B72C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0847020861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHsJ2jhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfAWKn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:43:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43913 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfAWKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:43:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so971411plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bz19SppYde9VYVOJqe3AHw5ZOnn7YaLj6WXKEyVlAGk=;
        b=BHsJ2jhkGJd/dHVP5weJiEIQrHH6uFCDaRUWeQlGIpRgC6uccdNJkiWHP9/k/Si0Py
         8jCiLTVTvoMP88gE8UlakTdmKJKLxVeLWBXsiqnOHjzkyDjEFtspgvWLOFzTsOR6bzFA
         ELEWsxb4QUle1p1Z4ggRf1VXgNyrgN4HwDPX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bz19SppYde9VYVOJqe3AHw5ZOnn7YaLj6WXKEyVlAGk=;
        b=WjL0kmyUFx9kirftEa6w5s7oJWevqPxf6UEjaWq5DRpfrdP8G4Tp5M8yQg1lODIfAQ
         qh9pkVQhxjBM1aRaWS/ZbabwzbeK1eDgrR0dMXDJ1w0G9a/Lu4HV6KI1674gDrUKNPED
         6D1qZY5PDo5aR8m8Eg5XV+XI6Z+jQaGx/o5sEtNDGzVqXb1owk7ye7eTAfSnOxjrJquQ
         HyaI3hYQkABmdV7iiaxlKJWwenY3eDacgsI9/IjcfJ6qIcjNaTZZDjA+EVsVnMp9E6mc
         e1k758ZW4UEsml3t3L//YAtswlFgiyhv6oe7R9kq818D0dID468gZmofb/jfVwLy+Pi7
         YU6Q==
X-Gm-Message-State: AJcUukfI9AB9hesqxm/P9+HvGVbmIeMJhHjTDR7euij2rG/r/GnBZvJn
        a9h2MWOEM+ghL1HFHjVl55nGoQ==
X-Google-Smtp-Source: ALg8bN6VazwwomxpTC2Vbwugrf/V37WxAIY9agkwCh+nirDLQ3r0jaGeqrgOblSkWUjAghq9I/8JzQ==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr1753893plp.180.1548240204782;
        Wed, 23 Jan 2019 02:43:24 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id w185sm26666827pfb.135.2019.01.23.02.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:43:24 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:13:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
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
Subject: Re: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Message-ID: <20190123104322.o3whk6rfiaootspn@vireshk-i7>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
 <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7>
 <CAJZ5v0g12U0M3aJOvRgRg3=-6f+2jeG1rT5RjLoSciM0FwFofg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g12U0M3aJOvRgRg3=-6f+2jeG1rT5RjLoSciM0FwFofg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19, 11:39, Rafael J. Wysocki wrote:
> On Wed, Jan 23, 2019 at 11:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-01-19, 21:10, Amit Kucheria wrote:
> > > @@ -151,6 +152,11 @@ struct cpufreq_policy {
> > >
> > >       /* For cpufreq driver's internal use */
> > >       void                    *driver_data;
> > > +
> > > +#ifdef CONFIG_CPU_THERMAL
> > > +     /* Pointer to the cooling device if used for thermal mitigation */
> > > +     struct thermal_cooling_device *cdev;
> > > +#endif
> > >  };
> > >
> > >  /* Only for ACPI */
> > > @@ -386,6 +392,12 @@ struct cpufreq_driver {
> > >   */
> > >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> > >
> > > +/*
> > > + * Set by drivers that want the core to automatically register the cpufreq
> > > + * driver as a thermal cooling device.
> > > + */
> > > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> > > +
> > >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> > >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> > >
> > > @@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> > >                       policy->cpuinfo.max_freq);
> > >  }
> > >
> > > +#ifdef CONFIG_CPU_THERMAL
> > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {
> > > +     policy->cdev = of_cpufreq_cooling_register(policy);
> > > +}
> > > +
> > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
> > > +     cpufreq_cooling_unregister(policy->cdev);
> > > +     policy->cdev = NULL;
> > > +}
> > > +#else
> > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {}
> > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
> > > +#endif
> >
> > The whole ifdef hackery here saves space for a pointer per policy.
> > Just get rid of it, it isn't worth it.
> 
> Is struct thermal_cooling_device defined if CONFIG_THERMAL is unset?

No and it is defined in thermal.h without any ifdef stuff.

-- 
viresh

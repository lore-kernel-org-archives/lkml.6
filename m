Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E4420861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpoYcyLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfAWKoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:44:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfAWKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:44:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so985901pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9pw4RwT4muo1zdh9Ll40k+ETO7F58dzgX5dQSvihvpI=;
        b=DpoYcyLjk52fPCLcIiJaeM0dUVyhxgpiIPooB0FgeITf6Cl5DXI3QNoaFIzuS48xhA
         zC9gEudvvUZpr1srqRI/6U0ncVB/TyXRfm275Vpei53WLBF1JeFInpabBA8ftbuyabth
         cpD9PFSIgn1WntVmlHgJ99mIe7A/uP/q798YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9pw4RwT4muo1zdh9Ll40k+ETO7F58dzgX5dQSvihvpI=;
        b=SpCv7Oz/nteMuMyAuW4SfmOvvnXQtU4l+KSKKraFDetcy+/uX263phyfwKFCIqa1J8
         Kj/MWlon2DTD1qsDZRJRfP/CEo3EXQ0cMEmZBUNV9kJdtJT+WgJBzasuEjXSCY/T6o+2
         F2omoVWwUEBKkMKzEKV/LmK01hq8LS/07iPL+2yrHbt9ZRHrTnRjF1hYf0wlMlsppTJk
         4A0d4TUuMlivVcHRbNMf5I2CPoFwtxi49jynEPqJhtTssho0K4UXQZf5q+1Vehdpa50O
         U/DnaAchUTGLOVXmHxmK+HYWIFSBoBOKa/T40Vo3ZLTWSkc4oAoe7IHp71ort4EF8sPu
         pQNg==
X-Gm-Message-State: AJcUukdwqAGSqj6h89r3s9myFPj3CMtF6iRDkiqTtC64EP/PUe5pJPI7
        7BoWRD3Xd7CqY6hDMIks1vx6Og==
X-Google-Smtp-Source: ALg8bN7Ac29dZxxy0KtFW37iKNKo1LBXAjlEaV+jw3QH2C31B1tQVdwcqd0mIR+U6ZDFkbi5LIwmgg==
X-Received: by 2002:a62:2781:: with SMTP id n123mr1613101pfn.138.1548240245768;
        Wed, 23 Jan 2019 02:44:05 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id k191sm27828803pgd.9.2019.01.23.02.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:44:05 -0800 (PST)
Date:   Wed, 23 Jan 2019 16:14:03 +0530
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
Message-ID: <20190123104403.bl7mdidmvd7c227q@vireshk-i7>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
 <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7>
 <CAJZ5v0g12U0M3aJOvRgRg3=-6f+2jeG1rT5RjLoSciM0FwFofg@mail.gmail.com>
 <20190123104322.o3whk6rfiaootspn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123104322.o3whk6rfiaootspn@vireshk-i7>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19, 16:13, Viresh Kumar wrote:
> On 23-01-19, 11:39, Rafael J. Wysocki wrote:
> > On Wed, Jan 23, 2019 at 11:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 21-01-19, 21:10, Amit Kucheria wrote:
> > > > @@ -151,6 +152,11 @@ struct cpufreq_policy {
> > > >
> > > >       /* For cpufreq driver's internal use */
> > > >       void                    *driver_data;
> > > > +
> > > > +#ifdef CONFIG_CPU_THERMAL
> > > > +     /* Pointer to the cooling device if used for thermal mitigation */
> > > > +     struct thermal_cooling_device *cdev;
> > > > +#endif
> > > >  };
> > > >
> > > >  /* Only for ACPI */
> > > > @@ -386,6 +392,12 @@ struct cpufreq_driver {
> > > >   */
> > > >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> > > >
> > > > +/*
> > > > + * Set by drivers that want the core to automatically register the cpufreq
> > > > + * driver as a thermal cooling device.
> > > > + */
> > > > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> > > > +
> > > >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> > > >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> > > >
> > > > @@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> > > >                       policy->cpuinfo.max_freq);
> > > >  }
> > > >
> > > > +#ifdef CONFIG_CPU_THERMAL
> > > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {
> > > > +     policy->cdev = of_cpufreq_cooling_register(policy);
> > > > +}
> > > > +
> > > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
> > > > +     cpufreq_cooling_unregister(policy->cdev);
> > > > +     policy->cdev = NULL;
> > > > +}
> > > > +#else
> > > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {}
> > > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
> > > > +#endif
> > >
> > > The whole ifdef hackery here saves space for a pointer per policy.
> > > Just get rid of it, it isn't worth it.
> > 
> > Is struct thermal_cooling_device defined if CONFIG_THERMAL is unset?
> 
> No and it is defined in thermal.h without any ifdef stuff.

I meant it is always available and doesn't depend on CONFIG_THERMAL.

-- 
viresh

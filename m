Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA19C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE659218DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549627404;
	bh=9LEWRqAqkXSzSoEFQKq9HPaBNTwyVTpEwMQjDy+PqYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ez0ap+XYBxG+MQZEGozckoLuupQHtm1ExZdYjTc/mcj4M8n06RGv0IytnxTpNrW8c
	 eQqkT0DprAx9qRQtzZ5cwiIYH8wQGVXqZvL1TPZhWbsT95/gl94G01OsZyi3hIJ1T5
	 N4K+VxIZGtiIkM0ONWXTph6scpdGH03AJ10bPRpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBHMDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:03:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38827 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:03:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so5409281otl.5;
        Fri, 08 Feb 2019 04:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33Yc1xgAz4JvrWq/Cec+/bqJtEAgT4g1BZ9fsfhOVE0=;
        b=BPGlTH94sVQvINjcAjJPrEoP1eDZOPx2qlcBJoQKVxSN9RcUe5pmFDTpL55kkFCim4
         Q1l2CsFYzYEd3RT2FKWmYxBxyKVOJz6aI6Ct6+TDMpmarJuGFtyl4Vivzdd4Kwhcd4XD
         wW4OV+mK4W+pSYFHKnhfN60X/Qo2Ubs4mlEOm9d3TqGyOjPUnBIJgUHtsYn7ia79CxoJ
         ty5Gz+7JqFUdutZsNP+XxUK7vlqRS6ASIEwAYC0JDCuxMtGysfMaIHjajas03fS3nh/1
         jScgQwoTKzcqObMRu1VwiArlnsdSQBGaBiALc1jM5Qpprccy/ZDdK04KO59jbQe0cu/6
         vF8w==
X-Gm-Message-State: AHQUAuapl/jrIM9ri8QgEcCXkC9eOZdz2l67cuSSHhmIumo9O/5Gd4kL
        Z/MOIxr+V2uUG8+QwVAeSZYz3rPOOqcPIU8hTeY=
X-Google-Smtp-Source: AHgI3IYPQlK4Dm3B4zcQOt8eKouHiajukfrzyIK2rA91uCuh8wiMXyrTK2vScabaW+mvxeX0hD+rYhkStTukUCCugK8=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr12988335oti.258.1549627401281;
 Fri, 08 Feb 2019 04:03:21 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
 <20190208103133.ysvaroyniuc3k4i5@vireshk-i7> <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
 <20190208113904.GB7913@e107155-lin>
In-Reply-To: <20190208113904.GB7913@e107155-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 13:03:10 +0100
Message-ID: <CAJZ5v0gbh2LDq+6P_CQ+GWOxEdQrRUqQnx7v59hvs2_wwx9=kw@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 12:39 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Feb 08, 2019 at 11:42:20AM +0100, Rafael J. Wysocki wrote:
> > On Fri, Feb 8, 2019 at 11:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 08-02-19, 11:22, Rafael J. Wysocki wrote:
> > > > There are cpufreq driver suspend and resume callbacks, maybe use them?
> > > >
> > > > The driver could do the I2C transactions in its suspend/resume
> > > > callbacks and do nothing in online/offline if those are part of
> > > > system-wide suspend/resume.
> > >
> > > These are per-policy things that we need to do, not sure if driver
> > > suspend/resume is a good place for that. It is more for a case where
> > > CPU 0-3 are in one policy and 4-7 in another. Now 1-7 are
> > > hot-unplugged during system suspend and hotplugged later on. This is
> > > more like complete removal/addition of devices instead of
> > > suspend/resume.
> >
> > No, it isn't.  We don't remove devices on offline.  We migrate stuff
> > away from them and (opportunistically) power them down.
> >
> > If this is system suspend, the driver kind of knows that offline will
> > take place, so it can prepare for it.  Likewise, when online takes
> > place during system-wide resume, it generally is known that this is
> > system-wide resume (there is a flag to indicate that in CPU hotplug),
> > it can be "smart" and avoid accessing suspended devices.  Deferring
> > the frequency set up until the driver resume time should do the trick
> > I suppose.
>
> I agree. The reason we don't see this generally on boot is because all
> the CPUs are brought online before CPUfreq is initialised. While during
> system suspend, we call cpufreq_online which in turn calls ->init in
> the hotplug state machine.
>
> So as Rafael suggests we need to do some trick, but can it be done in
> the core itself ? I may be missing something, but how about the patch
> below:
>
> Regards,
> Sudeep
>
> --
> diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..7d8b0b99f91d 100644
> --- i/drivers/cpufreq/cpufreq.c
> +++ w/drivers/cpufreq/cpufreq.c
> @@ -1241,7 +1241,8 @@ static int cpufreq_online(unsigned int cpu)
>                 policy->max = policy->user_policy.max;
>         }
>
> -       if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> +       if (cpufreq_driver->get && !cpufreq_driver->setpolicy &&
> +           !cpufreq_suspended) {
>                 policy->cur = cpufreq_driver->get(policy->cpu);
>                 if (!policy->cur) {
>                         pr_err("%s: ->get() failed\n", __func__);

It looks like we need to skip the "initial freq check" block below.

Also this doesn't really help the case when the driver ->init() messes
up with things.

> @@ -1702,6 +1703,11 @@ void cpufreq_resume(void)
>                                 pr_err("%s: Failed to start governor for policy: %p\n",
>                                        __func__, policy);
>                 }
> +               policy->cur = cpufreq_driver->get(policy->cpu);
> +               if (!policy->cur) {
> +                       pr_err("%s: ->get() failed\n", __func__);
> +                       goto out_destroy_policy;
> +               }
>         }
>  }
>

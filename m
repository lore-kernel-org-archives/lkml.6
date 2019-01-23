Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C38EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292D020861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERhu3ROP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfAWKwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:52:54 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44886 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfAWKww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:52:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so1746689qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeQwqTaBnBEL+vSJ4Qs4kPJUoeipubfEWM+kHQ4IKmM=;
        b=ERhu3ROPT0izkWP9QUnp9ItKvTxSzUw8kiy/WpDiSb28rOWuCI+5D49pblUkWjM5nQ
         hkw2a1oY1rojec25aL2/e16PhZ9kVn7uNthFOzR8o66KZsY+q63ezRPGOHLAx8wQ6TT7
         VcnZa59Kf09LF/bn4KBJFM9BNMlYm8qrPm8HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeQwqTaBnBEL+vSJ4Qs4kPJUoeipubfEWM+kHQ4IKmM=;
        b=G/Sd7C/sCT3D+nNkHWeUomftAvJ6xUM1U4oxOTElG8LHC0VO9WhAn5bFrVXEenZe4S
         EY9mq+791jKsu9DIeOOl/+h/yBvG3t28Ao2rjhJwS0hoNiCynptP2zAyk4VnJTpm/DIi
         Fa0ii2B7R42YT8vlGCyffgzfFV3y7Pac8HInQ0aUtwDqSts7tpF9D4f5TpYp4pQ45UAc
         2iIjtfnIGJmey1x8qk81yxdeh5XScpa6yG5K5uM3KF4ZLPb6uWYsVYzo6gXK8zWaw+lU
         65JKfxHlm/p14fPEEyFIxT+NARtK96wvMkSPmvgLNyIxQ+OD1F93vAoskRhnb6g98hvP
         Hvvg==
X-Gm-Message-State: AJcUukcM/v9lEYMQMa4BHFd6HQ7bjBr7cIbAarL8ZKe18DsUXcEajoAm
        4yoTpGXu6GO6PJK00W8lfst3aprmyTdfNtQ7lyMnAg==
X-Google-Smtp-Source: ALg8bN7APB0/TQ1hcmag9JsWyBz9CtqTnRuFLDBK1y8c4HEOWE34DjkEx2IpwPAC7bDw4ycv4vzqG7CPUqeGcjQdfvQ=
X-Received: by 2002:ac8:51c3:: with SMTP id d3mr1728856qtn.107.1548240771731;
 Wed, 23 Jan 2019 02:52:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <3f3e38e55c2de4b730fd7c6aa30c125f3a6a8704.1548084260.git.amit.kucheria@linaro.org>
 <20190123103451.ap5vws3kj2ch4uba@vireshk-i7>
In-Reply-To: <20190123103451.ap5vws3kj2ch4uba@vireshk-i7>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 23 Jan 2019 16:22:40 +0530
Message-ID: <CAP245DWTyaOFhS3SYwAmLGpczQo9JR+gsDbGdHAnoxpTWayjgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] thermal: cpu_cooling: Require thermal core to be
 compiled in
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 4:04 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-01-19, 21:10, Amit Kucheria wrote:
> > The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
> > driver to register as a cooling device and cool down the platform by
> > throttling the CPU frequency. In order to be able to auto-register a
> > cpufreq driver as a cooling device from the cpufreq core, we need access
> > to code inside cpu_cooling.c which, in turn, accesses code inside
> > thermal core.
> >
> > CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
> > (e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
> > CONFIG_CPU_FREQ is compiled in. This leads to following error:
> >
> > drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
> > cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
> > drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
> > cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'
> >
> > Given that platforms using CPU_THERMAL usually want it compiled-in so it
> > is available early in boot, make CPU_THERMAL depend on THERMAL being
> > compiled-in instead of allowing it to be a module.
> >
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 30323426902e..58bb7d72dc2b 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -152,6 +152,7 @@ config CPU_THERMAL
> >       bool "generic cpu cooling support"
> >       depends on CPU_FREQ
> >       depends on THERMAL_OF
> > +     depends on THERMAL=y
> >       help
> >         This implements the generic cpu cooling mechanism through frequency
> >         reduction. An ACPI version of this already exists
>
> Please remove all Kconfig crap, which gets fixed with this, as well in
> this patch itself. Like:

OK, I planned to if/when this series was accepted. Will send out a patch.


> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 10bc5c798d17..40f8cc323996 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -40,8 +40,6 @@ config ARM_ARMADA_8K_CPUFREQ
>  config ARM_BIG_LITTLE_CPUFREQ
>         tristate "Generic ARM big LITTLE CPUfreq driver"
>         depends on ARM_CPU_TOPOLOGY && HAVE_CLK
> -       # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> -       depends on !CPU_THERMAL || THERMAL
>         select PM_OPP
>         help
>           This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
>
> --
> viresh

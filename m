Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689E720851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547721008;
	bh=TRToaARbm2lu6CZZJMmUnX72Ic4dJeidAAEMLYSpKPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZU7TVjwaL4806vTAXcK0bnibDk+DV3TIwJ+qnlttNFvdSFBdqnLsh5l0JFbgDdOxb
	 4wYnkWAXQnfzt3Wn8b8/yvHL7QL++Cfj1zimgyguzxCVtg3EOu/E650Kt/WJcPcfXl
	 lAvkukwjd+/ivYIneonIKRPGVnaS3TyqT4rujpR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfAQKaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:30:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46887 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfAQKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:30:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so5706440oif.13;
        Thu, 17 Jan 2019 02:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqqRphGnJzsRzdaLJuldaRmPzGoWSZOWhc9427yChCc=;
        b=WUtYeS39xTmqqdfvHj+XL97g6D/9UKUiZfNjxWaSb6Zo9QLih3dq6Je5kUBuofhR5c
         XymxiHrC3mQY/ur6fc50Cuoc9bO8GCNTa63XsQOTfwizChNATDHlKfaHVEl4Wi+UmxFu
         fBmg45ylhkcSnqAQrTiciiAF+TG114Yi6jPmFy7YlHLUZyKuCbX9EwqN2zJe2swJ0/VY
         B/R5XJddVU89oF95XfkkXz/SYhvomO7USpfzVsT1e6NkpKuu6K3ExuVoJ6Ly50diiSBJ
         7muZY5nb596rSF55sk7xZA64Vp4er/od8VlaOdevA1ApcG6W07ZRkdD3qtP3OVPuJ28k
         Q99w==
X-Gm-Message-State: AJcUukcGJW8X1b01gFiERHCJhbuh24ITw+PMtxnj9pdT/xi/gRfBUeId
        +nVbZQSl1VQIdY/Grq/eQQMHMZKwGSLSkUUT+pE=
X-Google-Smtp-Source: ALg8bN5Pl7GIKi+AiDGRjGctjfB8HID90yS5d/N2wvoKiOq24u5Ay2ooDoEFuWRNrgDdaWEb4MYrNi24M3v/yHQ84AI=
X-Received: by 2002:aca:368a:: with SMTP id d132mr1150780oia.193.1547721003197;
 Thu, 17 Jan 2019 02:30:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7> <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
 <20190117102107.2n5liu325alisxhd@vireshk-i7>
In-Reply-To: <20190117102107.2n5liu325alisxhd@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 11:29:52 +0100
Message-ID: <CAJZ5v0hU_y=PG94_58ELdwUzk9CzvJqiuQ7GjvfFh23KxXj6fQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:21 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-01-19, 11:08, Rafael J. Wysocki wrote:
> > On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > 1. Have following for CONFIG_CPU_FREQ
> > >        depends on !CPU_THERMAL || THERMAL
> >
> > Sorry, but this makes my teeth hurt.
>
> I knew it :)
>
> > >    The platforms which don't need CPU_THERMAL (like x86) should not
> > >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> > >
> > >    @amit: If this gets accepted, please update the Kconfig entries for
> > >    all those drivers to not have above lines anymore.
> > >
> > > - Change CONFIG_THERMAL to bool instead of tristate ?
> > >
> > > - Anything else ?
> >
> > The design in the thermal subsystem seems to be upside-down.
> > Non-modular code should never be made depend on anything only defined
> > in a module.
> >
> > Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?
>
> That causes recursive-dependency issues:
>
> drivers/thermal/Kconfig:5:error: recursive dependency detected!
> drivers/thermal/Kconfig:5:      symbol THERMAL is selected by CPU_THERMAL
> drivers/thermal/Kconfig:16:     symbol CPU_THERMAL depends on THERMAL_OF
> drivers/thermal/Kconfig:70:     symbol THERMAL_OF depends on THERMAL
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
>
> something like this works though:
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 30323426902e..ee9f9f2a795b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -13,6 +13,20 @@ menuconfig THERMAL
>           All platforms with ACPI thermal support can use this driver.
>           If you want this support, you should say Y or M here.
>
> +config CPU_THERMAL
> +       bool "generic cpu cooling support"
> +       depends on CPU_FREQ
> +       select THERMAL_OF
> +       select THERMAL
> +       help
> +         This implements the generic cpu cooling mechanism through frequency
> +         reduction. An ACPI version of this already exists
> +         (drivers/acpi/processor_thermal.c).
> +         This will be useful for platforms using the generic thermal interface
> +         and not the ACPI interface.
> +
> +         If you want this support, you should say Y here.
> +

My sort of educated guess is that it is under the "if THERMAL" so that
it doesn't show up at all when THERMAL is unset.

>  if THERMAL
>
>  config THERMAL_STATISTICS
> @@ -148,19 +162,6 @@ config THERMAL_GOV_POWER_ALLOCATOR
>           Enable this to manage platform thermals by dynamically
>           allocating and limiting power to devices.
>
> -config CPU_THERMAL
> -       bool "generic cpu cooling support"
> -       depends on CPU_FREQ

But what about adding

      depends on THERMAL=y

here as I said in the other message?

> -       depends on THERMAL_OF
> -       help
> -         This implements the generic cpu cooling mechanism through frequency
> -         reduction. An ACPI version of this already exists
> -         (drivers/acpi/processor_thermal.c).
> -         This will be useful for platforms using the generic thermal interface
> -         and not the ACPI interface.
> -
> -         If you want this support, you should say Y here.
> -
>  config CLOCK_THERMAL
>         bool "Generic clock cooling support"
>         depends on COMMON_CLK
>
>
> What about make CONFIG_THERMAL bool instead ? Who wants it to be a module ?
>
> $ git grep "CONFIG_THERMAL=m"
> arch/arm/configs/mini2440_defconfig:CONFIG_THERMAL=m
> arch/arm/configs/omap2plus_defconfig:CONFIG_THERMAL=m
> arch/arm/configs/pxa_defconfig:CONFIG_THERMAL=m
> arch/mips/configs/ip22_defconfig:CONFIG_THERMAL=m
> arch/mips/configs/ip27_defconfig:CONFIG_THERMAL=m
> arch/unicore32/configs/unicore32_defconfig:#CONFIG_THERMAL=m
>
> Not sure if they really want this code out :(

Me neither.

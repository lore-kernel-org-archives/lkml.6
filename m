Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938DC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EEB20874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KfZ0aQnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAEA5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:57:31 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50956 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:57:31 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so4003262iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJbcMAzMM0gOxOcuNJY2v1o1R5h5x0rE+mW8WOZSdIQ=;
        b=KfZ0aQnxC618mVmbwkxM0X0f/s2fJkmHKnKXB/wOGStscTnvVY9cNecv4uV/GLgcSt
         G8LErfTGkiclByJX9K1eWiQRpZipGULJU0y50IokqwZO0gqJAYe40ryf59KRCIERsDHS
         PE81yeH5VVMpYfwVoJ3LR+pAvZKPTsaLU9lDD5GvuB/53tAnvo8aSYHucAnffJmWea3b
         nLtObhtbyjiXvFsAagKTiqGaor14VqK8Bhy9sOdKp/2kdCw4U8khfwfgwYVw9VcLdlYv
         8eurBj/7yAlUTP9yFQ6u08HvYS0ZpCBjxu8UGYYEiTr5QsbsnvQlEbpq/t1HofNM5dfC
         /yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJbcMAzMM0gOxOcuNJY2v1o1R5h5x0rE+mW8WOZSdIQ=;
        b=n1s/LIhGk2c3ndSb+UKmDc2W+pbM9fwgWQJwm/VysTk39pGc0bNjOYVR+Y5f5dNdXS
         17jcSy4dHtf+jP1VqRt61A1tEZaqjsTiKagP+CL8GxWLEuwBaN+OtTDpgKYAr/UqBS/K
         sMf0Om7MsGhtcmA57/W/JLOn6ODJ6eeXFZnVhSXkjiracmDGx+KH8CwSsuLQ6dIZzhFy
         ciW96V9Du+W1vYOMQbnDVz/djD+YjGyXHJ/TcpjsqiBXj/TuxE7u7tNY7XiJhUcHQtBm
         8cNDue0ty50pXudwocSXhuOjGFTct+2CCOUuA+fEFORs1Sn6Ag+CWhNIvJ41goX+bN52
         ma5A==
X-Gm-Message-State: AA+aEWZyuQ8f2hQl0rDkuUkcTfEz5r5Cdl6XzrvsALsSvMjoz+pPWivk
        oC6ejIMFJkN1MZumxB3v5cXEkLHHVBP9HRuEAwOEpg==
X-Google-Smtp-Source: AFSGD/V17DO175DdBcYd0Zl9U4pD+rq/EgK/jAfQbKSS3BlBSQzQaDLVRBPd8K3nQYQciuykxektJaH8DyjBzU8bdg8=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr33588369jak.11.1546649849475;
 Fri, 04 Jan 2019 16:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20181211142253.23747-1-faiz_abbas@ti.com> <20181211142253.23747-3-faiz_abbas@ti.com>
 <CAPDyKFoi+NzS-d8E8oz-h_ab70jY7owwqPXsEoJWnRg6J2zcNA@mail.gmail.com>
 <CAOesGMjXcpY1c0Bpf2tMACVVXNW1W-Gp3HO+yjK8f6dQ-cp5bQ@mail.gmail.com>
 <20190102195626.GA2024@localhost.localdomain> <1d83e4df-78dc-10f6-f0c0-60e84b0e1094@ti.com>
In-Reply-To: <1d83e4df-78dc-10f6-f0c0-60e84b0e1094@ti.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 4 Jan 2019 16:57:17 -0800
Message-ID: <CAOesGMiTmR6t2h1AzkPRWQon3onXKb5db5q6yVix9D5r+ExKfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding
 SDR104/HS200 tuning failures (i929)
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 9:58 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Olof, Eduardo,
>
> On 03/01/19 1:26 AM, Eduardo Valentin wrote:
> > On Wed, Jan 02, 2019 at 10:29:31AM -0800, Olof Johansson wrote:
> >> Hi,
> >>
> >>
> >> On Wed, Dec 12, 2018 at 1:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>
> >>> + Thermal maintainers
> >>>
> >>> On Tue, 11 Dec 2018 at 15:20, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>>>
> >>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> >>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> >>>> unexpected tuning pattern errors. A small failure band may be present
> >>>> in the tuning range which may be missed by the current algorithm.
> >>>> Furthermore, the failure bands vary with temperature leading to
> >>>> different optimum tuning values for different temperatures.
> >>>>
> >>>> As suggested in the related Application Report (SPRACA9B - October 2017
> >>>> - Revised July 2018 [2]), tuning should be done in two stages.
> >>>> In stage 1, assign the optimum ratio in the maximum pass window for the
> >>>> current temperature. In stage 2, if the chosen value is close to the
> >>>> small failure band, move away from it in the appropriate direction.
> >>>>
> >>>> References:
> >>>> [1] http://www.ti.com/lit/pdf/sprz426
> >>>> [2] http://www.ti.com/lit/pdf/SPRACA9
> >>>>
> >>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> ---
> >>>>  drivers/mmc/host/Kconfig      |  2 +
> >>>>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
> >>>>  2 files changed, 91 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>>> index 5fa580cec831..d8f984483ab0 100644
> >>>> --- a/drivers/mmc/host/Kconfig
> >>>> +++ b/drivers/mmc/host/Kconfig
> >>>> @@ -977,6 +977,8 @@ config MMC_SDHCI_XENON
> >>>>  config MMC_SDHCI_OMAP
> >>>>         tristate "TI SDHCI Controller Support"
> >>>>         depends on MMC_SDHCI_PLTFM && OF
> >>>> +       select THERMAL
> >>>> +       select TI_SOC_THERMAL
> >>>>         help
> >>>>           This selects the Secure Digital Host Controller Interface (SDHCI)
> >>>>           support present in TI's DRA7 SOCs. The controller supports
> >>>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> >>>> index f588ab679cb0..b75c55011fcb 100644
> >>>> --- a/drivers/mmc/host/sdhci-omap.c
> >>>> +++ b/drivers/mmc/host/sdhci-omap.c
> >>>> @@ -27,6 +27,7 @@
> >>>>  #include <linux/regulator/consumer.h>
> >>>>  #include <linux/pinctrl/consumer.h>
> >>>>  #include <linux/sys_soc.h>
> >>>> +#include <linux/thermal.h>
> >>>>
> >>>>  #include "sdhci-pltfm.h"
> >>>>
> >>>> @@ -286,15 +287,19 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >>>>         struct sdhci_host *host = mmc_priv(mmc);
> >>>>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>>         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> >>>> +       struct thermal_zone_device *thermal_dev;
> >>>>         struct device *dev = omap_host->dev;
> >>>>         struct mmc_ios *ios = &mmc->ios;
> >>>>         u32 start_window = 0, max_window = 0;
> >>>> +       bool single_point_failure = false;
> >>>>         bool dcrc_was_enabled = false;
> >>>>         u8 cur_match, prev_match = 0;
> >>>>         u32 length = 0, max_len = 0;
> >>>>         u32 phase_delay = 0;
> >>>> +       int temperature;
> >>>>         int ret = 0;
> >>>>         u32 reg;
> >>>> +       int i;
> >>>>
> >>>>         /* clock tuning is not needed for upto 52MHz */
> >>>>         if (ios->clock <= 52000000)
> >>>> @@ -304,6 +309,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >>>>         if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
> >>>>                 return 0;
> >>>>
> >>>> +       thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
> >>>
> >>> I couldn't find a corresponding call to a put function, like
> >>> "thermal_zone_put()" or whatever, which made me realize that the
> >>> thermal zone API is incomplete. Or depending on how you put it, it
> >>> lacks object reference counting, unless I am missing something.
> >>>
> >>> For example, what happens if the thermal zone becomes unregistered
> >>> between this point and when you call thermal_zone_get_temp() a couple
> >>> of line below. I assume it's a known problem, but just wanted to point
> >>> it out.
> >>>
> >
> > Yes, there is no ref counting. Specially because the get zones usages
> > were too specific, and mostly used in application cases that module
> > would not really be removed. Though not a good excuse, still, not very
> > problematic. Now, if the API is getting other usages, then refcounting
> > may be necessary.
> >
> >>>> +       if (IS_ERR(thermal_dev)) {
> >>>> +               dev_err(dev, "Unable to get thermal zone for tuning\n");
> >>>> +               return PTR_ERR(thermal_dev);
> >>>> +       }
> >>>> +
> >>>> +       ret = thermal_zone_get_temp(thermal_dev, &temperature);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>
> >>> [...]
> >>>
> >>> Anyway, I have applied this for next, thanks!
> >>
> >> This is throwing errors on builds of keystone_defconfig in next and mainline:
> >>
> >> http://arm-soc.lixom.net/buildlogs/next/next-20190102/buildall.arm.keystone_defconfig.log.passed
> >>
> >> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
> >>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP [=n] ||
> >> COMPILE_TEST [=n]) && HAS_IOMEM [=y]
> >>   Selected by [y]:
> >>   - MMC_SDHCI_OMAP [=y] && MMC [=y] && MMC_SDHCI_PLTFM [=y] && OF [=y]
> >>
> >> So, thermal depends on ARCH_HAS_BANDGAP, which keystone doesn't provide.
> >>
> >> Selecting a major framework such as THERMAL from a driver config is
> >> likely not the right solution anyway, especially since THERMAL does
> >> provide stubbed out versions of the functions if it's not enabled.
> >
> > Yeah, that seams a bit up-side-down. Can you guys give a bit more of
> > context? Why do you need the cpu thermal zone ? From patch description,
> > looks like you want to have your own zone then apply different tuning
> > values based on temperature (range?). Why do you need to mess up with
> > cpu_thermal zone? Don't you have a bandgap in the mem controller for
> > this application?
> >
>
> Thats correct. We don't have a bandgap in the MMC controller and thus we
> have to use the cpu one to measure temperature.
>
> THERMAL is critical for tuning. The interface is supposed to fail if we
> can't get temperature. So IMO we should ensure that it is present.
>
> I can fix this by "select TI_SOC_THERMAL if ARCH_HAS_BANDGAP" if you
> guys agree.

Building elaborate select statements is usually fragile, once
dependencies for TI_SOC_THERMAL changes you need to come back here to
fixup the select.

Supposedly this driver works on keystone (or does it?), it doesn't
actually need TI_SOC_THERMAL for basic functionality beyond tuning?
Or, at least, it needs to fall back to a reasonable behavior if it's
unavailable on keystone.

Having the driver print a warning and refuse to tune to higher speeds
is a reasonable way to do this, I think. That would carry to all
platforms, i.e. even the ones who have TI_SOC_THERMAL and
ARCH_HAS_BANDGAP, without adding the select.


-Olof

Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A478CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6234F218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeTsRIk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfABT4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:56:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38376 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfABT4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:56:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so14912344plb.5;
        Wed, 02 Jan 2019 11:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3J2PKoNnhuKlbLXczQn3aGMt1Uyj5P+mc2x7Reu84M=;
        b=CeTsRIk/cQdt52ZinWN6hUuMdpGqfAWZ4sarniOPR/I3SMFJfAucdcTkxgeRCeIy9D
         q/OOF9dovnhbBQ/j3FKThPstJs79GF2jGwWwTr10ym6arJbItvqmyvszqkqQ+G4HPium
         duKyNeGWFNUuybAko5KrDvAmJ/8B4xZlfkmJ1OfopJvplB1tMQ9oSRa02yt7tLp41TzW
         k12peCQEb4u4BJIr3Ntft+/rA8id7/rnGsJmT33pJxIMws1tWokx7FIDNlh5pu3bQJmM
         5inWyC1UvAQUhw/fC2FQBkuf1grOCwNcf/L4YjwhT+GFg97/SpSrZbpZBHHvo5U4S6Yf
         AwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3J2PKoNnhuKlbLXczQn3aGMt1Uyj5P+mc2x7Reu84M=;
        b=oEsvNkPvhnDVAmUZ9QYl97UQ4inKHXmwmWks7EV53lRIHLy+tL5rd6vRsf0ivGtG7s
         DuzSF43/NbjkDtLQWWebe2SdrCvWwr9JFtc2kcOc7Jr0eOP74yX8ejAKG7wqwwbBu1g3
         +0oqf3EOescITuFu9Rf+V1rptcGBtz34OfKLxD52nD1TRXGoWI6+owhH69SIgs0GQt4v
         /MqL8EI5WpijBdECvYq3eNMiYDMKjf3T93uXUBDoFdKVZO4H3TE3FJiGt32eN/1jc3Zm
         JB3CaIKx501XHQiu6ORCES2OzOfnsgWKPyLf/BLBIzBpn+NL2WtBmbCXF+lxBGJ925mF
         3oAw==
X-Gm-Message-State: AJcUukcdhkHQMEv1LjChhzbunJ5qufSFiLdWOgQaz0VdW/Zd1oB9/wlT
        s6ttVc8MuGVTZ3pEPzWsaF8=
X-Google-Smtp-Source: ALg8bN7iObezKExgift68/BasBnni/0juC0JVxp8Jz2YwBxyi3VZWNYz/cWwZI/FWx4394K5WeAHgA==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr2006440plg.250.1546458990854;
        Wed, 02 Jan 2019 11:56:30 -0800 (PST)
Received: from localhost.localdomain ([207.86.76.174])
        by smtp.gmail.com with ESMTPSA id y5sm86943418pge.49.2019.01.02.11.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:56:30 -0800 (PST)
Date:   Wed, 2 Jan 2019 11:56:28 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding
 SDR104/HS200 tuning failures (i929)
Message-ID: <20190102195626.GA2024@localhost.localdomain>
References: <20181211142253.23747-1-faiz_abbas@ti.com>
 <20181211142253.23747-3-faiz_abbas@ti.com>
 <CAPDyKFoi+NzS-d8E8oz-h_ab70jY7owwqPXsEoJWnRg6J2zcNA@mail.gmail.com>
 <CAOesGMjXcpY1c0Bpf2tMACVVXNW1W-Gp3HO+yjK8f6dQ-cp5bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjXcpY1c0Bpf2tMACVVXNW1W-Gp3HO+yjK8f6dQ-cp5bQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 10:29:31AM -0800, Olof Johansson wrote:
> Hi,
> 
> 
> On Wed, Dec 12, 2018 at 1:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > + Thermal maintainers
> >
> > On Tue, 11 Dec 2018 at 15:20, Faiz Abbas <faiz_abbas@ti.com> wrote:
> > >
> > > Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> > > (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> > > unexpected tuning pattern errors. A small failure band may be present
> > > in the tuning range which may be missed by the current algorithm.
> > > Furthermore, the failure bands vary with temperature leading to
> > > different optimum tuning values for different temperatures.
> > >
> > > As suggested in the related Application Report (SPRACA9B - October 2017
> > > - Revised July 2018 [2]), tuning should be done in two stages.
> > > In stage 1, assign the optimum ratio in the maximum pass window for the
> > > current temperature. In stage 2, if the chosen value is close to the
> > > small failure band, move away from it in the appropriate direction.
> > >
> > > References:
> > > [1] http://www.ti.com/lit/pdf/sprz426
> > > [2] http://www.ti.com/lit/pdf/SPRACA9
> > >
> > > Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > > ---
> > >  drivers/mmc/host/Kconfig      |  2 +
> > >  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 91 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > > index 5fa580cec831..d8f984483ab0 100644
> > > --- a/drivers/mmc/host/Kconfig
> > > +++ b/drivers/mmc/host/Kconfig
> > > @@ -977,6 +977,8 @@ config MMC_SDHCI_XENON
> > >  config MMC_SDHCI_OMAP
> > >         tristate "TI SDHCI Controller Support"
> > >         depends on MMC_SDHCI_PLTFM && OF
> > > +       select THERMAL
> > > +       select TI_SOC_THERMAL
> > >         help
> > >           This selects the Secure Digital Host Controller Interface (SDHCI)
> > >           support present in TI's DRA7 SOCs. The controller supports
> > > diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> > > index f588ab679cb0..b75c55011fcb 100644
> > > --- a/drivers/mmc/host/sdhci-omap.c
> > > +++ b/drivers/mmc/host/sdhci-omap.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/pinctrl/consumer.h>
> > >  #include <linux/sys_soc.h>
> > > +#include <linux/thermal.h>
> > >
> > >  #include "sdhci-pltfm.h"
> > >
> > > @@ -286,15 +287,19 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > >         struct sdhci_host *host = mmc_priv(mmc);
> > >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > >         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> > > +       struct thermal_zone_device *thermal_dev;
> > >         struct device *dev = omap_host->dev;
> > >         struct mmc_ios *ios = &mmc->ios;
> > >         u32 start_window = 0, max_window = 0;
> > > +       bool single_point_failure = false;
> > >         bool dcrc_was_enabled = false;
> > >         u8 cur_match, prev_match = 0;
> > >         u32 length = 0, max_len = 0;
> > >         u32 phase_delay = 0;
> > > +       int temperature;
> > >         int ret = 0;
> > >         u32 reg;
> > > +       int i;
> > >
> > >         /* clock tuning is not needed for upto 52MHz */
> > >         if (ios->clock <= 52000000)
> > > @@ -304,6 +309,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > >         if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
> > >                 return 0;
> > >
> > > +       thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
> >
> > I couldn't find a corresponding call to a put function, like
> > "thermal_zone_put()" or whatever, which made me realize that the
> > thermal zone API is incomplete. Or depending on how you put it, it
> > lacks object reference counting, unless I am missing something.
> >
> > For example, what happens if the thermal zone becomes unregistered
> > between this point and when you call thermal_zone_get_temp() a couple
> > of line below. I assume it's a known problem, but just wanted to point
> > it out.
> >

Yes, there is no ref counting. Specially because the get zones usages
were too specific, and mostly used in application cases that module
would not really be removed. Though not a good excuse, still, not very
problematic. Now, if the API is getting other usages, then refcounting
may be necessary.

> > > +       if (IS_ERR(thermal_dev)) {
> > > +               dev_err(dev, "Unable to get thermal zone for tuning\n");
> > > +               return PTR_ERR(thermal_dev);
> > > +       }
> > > +
> > > +       ret = thermal_zone_get_temp(thermal_dev, &temperature);
> > > +       if (ret)
> > > +               return ret;
> > > +
> >
> > [...]
> >
> > Anyway, I have applied this for next, thanks!
> 
> This is throwing errors on builds of keystone_defconfig in next and mainline:
> 
> http://arm-soc.lixom.net/buildlogs/next/next-20190102/buildall.arm.keystone_defconfig.log.passed
> 
> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP [=n] ||
> COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>   Selected by [y]:
>   - MMC_SDHCI_OMAP [=y] && MMC [=y] && MMC_SDHCI_PLTFM [=y] && OF [=y]
> 
> So, thermal depends on ARCH_HAS_BANDGAP, which keystone doesn't provide.
> 
> Selecting a major framework such as THERMAL from a driver config is
> likely not the right solution anyway, especially since THERMAL does
> provide stubbed out versions of the functions if it's not enabled.

Yeah, that seams a bit up-side-down. Can you guys give a bit more of
context? Why do you need the cpu thermal zone ? From patch description,
looks like you want to have your own zone then apply different tuning
values based on temperature (range?). Why do you need to mess up with
cpu_thermal zone? Don't you have a bandgap in the mem controller for
this application?

> 
> 
> -Olof

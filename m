Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F12D2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqqWeaGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F12D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeLENuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:50:50 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39608 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeLENuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:50:50 -0500
Received: by mail-vs1-f67.google.com with SMTP id h78so12090642vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIjgt2gx1tQqeMA8Vi3ilc6OUOxgrIK10oepLPMPFWM=;
        b=BqqWeaGlN3ZCkG1PzNZuktgd59BwAFGB44lELKma23Pw18s4noUtChMIjAEFPA6UCn
         awGSge/BJ9VKhAi5VjKtFCB/JSAEZnl3ikLFnwcZtK2teaI7RmnYPD03WtvV+TzsB0rw
         EEHrjpBO7+4MbT7TezqiNEJcr7YN5E1FPuSmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIjgt2gx1tQqeMA8Vi3ilc6OUOxgrIK10oepLPMPFWM=;
        b=apSJLVnDTE5Bua3LAdW/wVm4H1KrNeGhgDSjoxvqOh2oVAqbxWd2Bqc417OPbX3Wn1
         NdCvanPDfYqEgbG55LWQKJ6B6RKldbHyEIkkvvsADPAtibRiFNeGLyW7/oLyV4wB8694
         uMVtxfbk3tGlSH1SBvTMBRh/RNLeeNocsBtmmVi7Fo002EgsPsM+WhUCPgR4vflsWmRM
         lIHO4MKnP5YqeuLY4Oaem9gdOmGqChT1aipAcOPbSRMLYEd/z9t5xaE5zYo/8SPylbrq
         rAKDKmfzzIo66y0xd1YKle/3R0ufgKZKGMo+st5q+ZZJcxzgQQnt4XYdrUWLs1Bz7TJt
         hM6Q==
X-Gm-Message-State: AA+aEWYbwkcSxBvpzhYKgtRg+OD3+nziAmtCGSPIT7cRPYD4D3urnr4t
        KnSVsVPmyc6agT3+Bj05gJLCCGDXpTk/UC35rGNJFA==
X-Google-Smtp-Source: AFSGD/XQWeStv76NT/5hcIHKhpZkP9uNZnINJmzaQQ++YjgJ0JQyNfR38ftLnqHloyR5nper0sSBxTSYxuNwp2O5bUQ=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr10624825vsi.191.1544017848895;
 Wed, 05 Dec 2018 05:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20181129190503.6040-1-faiz_abbas@ti.com> <cb1e8e88-4c9d-741d-79cd-57b03c5e0808@ti.com>
 <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com>
In-Reply-To: <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 14:50:12 +0100
Message-ID: <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Workaround errata regarding SDR104/HS200
 tuning failures (i929)
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Kishon <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi Kishon,
>
> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
> > Hi Faiz,
> >
> > On 30/11/18 12:35 AM, Faiz Abbas wrote:
> >> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> >> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> >> unexpected tuning pattern errors. A small failure band may be present
> >> in the tuning range which may be missed by the current algorithm.
> >> Furthermore, the failure bands vary with temperature leading to
> >> different optimum tuning values for different temperatures.
> >>
> >> As suggested in the related Application Report (SPRACA9B - October 2017
> >> - Revised July 2018 [2]), tuning should be done in two stages.
> >> In stage 1, assign the optimum ratio in the maximum pass window for the
> >> current temperature. In stage 2, if the chosen value is close to the
> >> small failure band, move away from it in the appropriate direction.
> >>
> >> References:
> >> [1] http://www.ti.com/lit/pdf/sprz426
> >> [2] http://www.ti.com/lit/pdf/SPRACA9
> >>
> >> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >> ---
> >>  drivers/mmc/host/Kconfig      |  2 +
> >>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 91 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index 1b58739d9744..6d3553f06f27 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -969,6 +969,8 @@ config MMC_SDHCI_XENON
> >>  config MMC_SDHCI_OMAP
> >>      tristate "TI SDHCI Controller Support"
> >>      depends on MMC_SDHCI_PLTFM && OF
> >> +    select THERMAL
> >> +    select TI_SOC_THERMAL
> >>      help
> >>        This selects the Secure Digital Host Controller Interface (SDHCI)
> >>        support present in TI's DRA7 SOCs. The controller supports
> >> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> >> index b3cb39d0db6f..9ccce7ef3a60 100644
> >> --- a/drivers/mmc/host/sdhci-omap.c
> >> +++ b/drivers/mmc/host/sdhci-omap.c
> >> @@ -27,6 +27,7 @@
> >>  #include <linux/regulator/consumer.h>
> >>  #include <linux/pinctrl/consumer.h>
> >>  #include <linux/sys_soc.h>
> >> +#include <linux/thermal.h>
> >>
> >>  #include "sdhci-pltfm.h"
> >>
> >> @@ -286,14 +287,18 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >>      struct sdhci_host *host = mmc_priv(mmc);
> >>      struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>      struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> >> +    struct thermal_zone_device *thermal_dev;
> >>      struct device *dev = omap_host->dev;
> >>      struct mmc_ios *ios = &mmc->ios;
> >>      u32 start_window = 0, max_window = 0;
> >> +    bool single_point_failure = false;
> >>      u8 cur_match, prev_match = 0;
> >>      u32 length = 0, max_len = 0;
> >>      u32 phase_delay = 0;
> >> +    int temperature;
> >>      int ret = 0;
> >>      u32 reg;
> >> +    int i;
> >>
> >>      /* clock tuning is not needed for upto 52MHz */
> >>      if (ios->clock <= 52000000)
> >> @@ -303,6 +308,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >>      if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
> >>              return 0;
> >>
> >> +    thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
> >> +    if (IS_ERR(thermal_dev)) {
> >> +            dev_err(dev, "Unable to get thermal zone for tuning\n");
> >> +            return PTR_ERR(thermal_dev);
> >> +    }
> >
> > Can't we get thermal zone once during probe?
> >
>
> Tuning is also (ideally) supposed to happen only once per enumeration.
> Also it doesn't make sense to get a thermal zone for lower speed systems
> that won't do tuning.

Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
then keeps the host device runtime resumed until ->remove() is called
on it. I assume you are going to change that, at some point!?

In other words, what will happen to the host device when it becomes
runtime suspended? Is re-tuning needed when it gets runtime resumed,
which is the case for many other sdhci variants?

Depending on the answer, you may want to fetch the thermal zone during
probe. :-)

Kind regards
Uffe

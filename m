Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A07C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A977F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z40oXd6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A977F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeLJPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:25:56 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40519 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeLJPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:25:56 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so6856225vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HF4hfINd4Yhl2TbYXFboHSnZPv2lNGdpqIEXQpMFPOk=;
        b=Z40oXd6BdhjlzNxglv/y1C/RwwEp6uRoS6MRhWlp1ofEwjxw0uK07RuUmOIOPJIgab
         NJhsKu8biKMiPdfUiY3+xyEP5MTcrb3wlgQft04AQv377/dBTXxlEdM71Kx7z9+/W+w2
         IAv3BG8JfaZhgwWnBpDmBcKQWVc4wsXMsmKfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HF4hfINd4Yhl2TbYXFboHSnZPv2lNGdpqIEXQpMFPOk=;
        b=nvfaV/qjBNbDTqLBlm6z+u/cZj84thphKW/enh6jvoRHLRawOLq9gL7pTNrJr2PzQM
         OtRdfL/Af6z40jshb+4RHMLFpZw/s6VgfawX5nyj1nz+KyTNww0MrfRqIljuvdCVYJxx
         6pdEqCRkAeuyrAvjAp1bBTPOsvACS38n/B09iRCwrt4vNAFLCa7BBnqswgKtEGxTu4Ht
         z41bi48jI/BuJNvPf8UYlMk4J+fYFKEiTvVUj2mza3tK5AI/r8N7uEp8RHLjvxmL/kwE
         zleE+uxsclTaYSZEtqMfRz94a2w+UonH1Fakv0wWQUJQXEZx8zvNCzYBkYRCuRJ54K8i
         VKJQ==
X-Gm-Message-State: AA+aEWboS7Kr93oddXjaKbZskmI1HD2rl1PS/Q9zkTNVfkrJPpcFHKoU
        1h7y8ubkbqBW6QRt529UVr0nfVrd6sIV/08EdyEBwo2V4EgUKg==
X-Google-Smtp-Source: AFSGD/VLkFCbog+9JaE5s6T0oO6Qx/mNPiCrn0+r+UguuKKgu4yitGcrQUmr7MN2kqy0e/Vd21lZvIsITzzNb/59yLA=
X-Received: by 2002:a67:b245:: with SMTP id s5mr5640068vsh.200.1544455554691;
 Mon, 10 Dec 2018 07:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20181129190503.6040-1-faiz_abbas@ti.com> <cb1e8e88-4c9d-741d-79cd-57b03c5e0808@ti.com>
 <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com> <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
 <d1ae4e93-4b17-9574-00b1-bfa268cb7574@ti.com> <CAPDyKFrLzEfGKkC3K9znjJUKO1MUjdBpaL0HEtHYOzbAgNO-fg@mail.gmail.com>
 <e19a5c39-028e-8dda-aa0a-3968a213cd47@ti.com>
In-Reply-To: <e19a5c39-028e-8dda-aa0a-3968a213cd47@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Dec 2018 16:25:18 +0100
Message-ID: <CAPDyKFoO7tn1Xdu9ROqRVjZ1SZnzXcxduB97OQtmz2d2E_epUQ@mail.gmail.com>
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

On Mon, 10 Dec 2018 at 15:04, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi,
>
> On 10/12/18 7:15 PM, Ulf Hansson wrote:
> > On Mon, 10 Dec 2018 at 14:23, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>
> >> Hi Uffe,
> >>
> >> On 05/12/18 7:20 PM, Ulf Hansson wrote:
> >>> On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>>>
> >>>> Hi Kishon,
> >>>>
> >>>> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
> >>>>> Hi Faiz,
> >>>>>
> >>>>> On 30/11/18 12:35 AM, Faiz Abbas wrote:
> >>>>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> >>>>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> >>>>>> unexpected tuning pattern errors. A small failure band may be present
> >>>>>> in the tuning range which may be missed by the current algorithm.
> >>>>>> Furthermore, the failure bands vary with temperature leading to
> >>>>>> different optimum tuning values for different temperatures.
> >>>>>>
> >>>>>> As suggested in the related Application Report (SPRACA9B - October 2017
> >>>>>> - Revised July 2018 [2]), tuning should be done in two stages.
> >>>>>> In stage 1, assign the optimum ratio in the maximum pass window for the
> >>>>>> current temperature. In stage 2, if the chosen value is close to the
> >>>>>> small failure band, move away from it in the appropriate direction.
> >>>>>>
> >>>>>> References:
> >>>>>> [1] http://www.ti.com/lit/pdf/sprz426
> >>>>>> [2] http://www.ti.com/lit/pdf/SPRACA9
> >>>>>>
> >>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >>>>>> ---
> ...
> >>>>>
> >>>>> Can't we get thermal zone once during probe?
> >>>>>
> >>>>
> >>>> Tuning is also (ideally) supposed to happen only once per enumeration.
> >>>> Also it doesn't make sense to get a thermal zone for lower speed systems
> >>>> that won't do tuning.
> >>>
> >>> Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
> >>> then keeps the host device runtime resumed until ->remove() is called
> >>> on it. I assume you are going to change that, at some point!?
> >>>
> >>> In other words, what will happen to the host device when it becomes
> >>> runtime suspended? Is re-tuning needed when it gets runtime resumed,
> >>> which is the case for many other sdhci variants?
> >>
> >> There are no plans to support runtime_suspend()/resume() any time in the
> >> near future. If its ok with you, I would like to get this patch in
> >> without any changes. We can change it in case a need for
> >> runtime_suspend()/_resume() does arise.
> >
> > Right, I am okay with that. Due to recent changes to sdhci-omap
> > $subject patch doesn't apply, can you please rebase!?
> >
> > Additionally, I realized that we should fold in patch updating the DT
> > doc for sdhci-omap, adding the property for the thermal zone. I
> > regards to that, I am wondering if "cpu_thermal", is really the
> > correct name of the zone. The point is, I am guessing the zone could
> > change along with the SoCs/platforms.
> >
>
> As you have probably noticed, we are introducing a new driver
> (sdhci_am654) for newer platforms. I don't foresee using sdhci-omap
> driver with any other platforms. In case we do use it, we can add the dt
> property at that point of time and default to "cpu_thermal" to maintain
> dt compatibility.
>
> Will rebase and send v2 if you are ok with above.

I see, but you still need to update the DT doc for sdhci-omap.

Kind regards
Uffe

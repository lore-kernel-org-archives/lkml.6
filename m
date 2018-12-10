Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29264C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69382081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="di6viFkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69382081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeLJQ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:57:15 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41780 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeLJQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:57:15 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so7055676vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rqy/XWWKEnGpSv9mUir2maQLQ4klXSdW1Z/QREnoe0w=;
        b=di6viFkn5qJ8wabC6zdS1fuAuC37NB1dsgZ6p2YVXhELE6e71n2fkV7YpHB8z+3fha
         QcFCwvJPRTeEjSP99W/xe+aUi/F7FkoCjftZ01JO3KJ9V1pT40jH0kv4HrRv28XgOKtb
         nCxGofnEUW/8xVvemfaf2obdVRbHBruZgICkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rqy/XWWKEnGpSv9mUir2maQLQ4klXSdW1Z/QREnoe0w=;
        b=HODmbO9A//ZbczU2wZWAbi8/30hipNITFd/5AfY9cG5/ElQGkdkCGtOdIfohJjBqUY
         0jIcd46u48sPbFB4iMzG+9TYQd9Jjm3sBz0HkcEEx7PboQ2qH/fNE0nxu76aj0qVALTf
         0XUROAclonCQcHNd4A6+DJnTjnqG6FfCGpzjCAojtOXg5z44fX4RoFzfGPzlGB8KQTYj
         lfxM101ow08A/mUPXKhL0NTKS4moMiNrrKypPaStMBY+0HGoiPK0oMHflQwaNwuVXXRw
         jkJq4ee6HghyyQoDZlg8BryekiS6SV1EO4ZqgQj0KMbybjOXZlnvAom0rYM3iNsOsl+1
         riHQ==
X-Gm-Message-State: AA+aEWZSRXy0gpVtsyEWthub3899SmITmPHAbJHY7NuBRh7CjMkh9JAL
        qQpXFbc89sv6iKW7GotY8fFuw3rAvn7cYSg/XZhyqGUmG9o=
X-Google-Smtp-Source: AFSGD/UxmoATam2096bUlm/H3dTSyuVfLKa3F7PfhhjMBg7hfW3uYP2d/e0kMY2dT4l6oJKkLeVLfwNLkOD1Qb19uhs=
X-Received: by 2002:a67:7685:: with SMTP id r127mr5608404vsc.35.1544461033133;
 Mon, 10 Dec 2018 08:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20181129190503.6040-1-faiz_abbas@ti.com> <cb1e8e88-4c9d-741d-79cd-57b03c5e0808@ti.com>
 <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com> <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
 <d1ae4e93-4b17-9574-00b1-bfa268cb7574@ti.com> <CAPDyKFrLzEfGKkC3K9znjJUKO1MUjdBpaL0HEtHYOzbAgNO-fg@mail.gmail.com>
 <e19a5c39-028e-8dda-aa0a-3968a213cd47@ti.com> <CAPDyKFoO7tn1Xdu9ROqRVjZ1SZnzXcxduB97OQtmz2d2E_epUQ@mail.gmail.com>
 <218be2af-8f81-47b4-f782-b774e10642c1@ti.com>
In-Reply-To: <218be2af-8f81-47b4-f782-b774e10642c1@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Dec 2018 17:56:36 +0100
Message-ID: <CAPDyKFou7hSELknyOV-eP+6ROJozwc-7vPBy2Rkb7hSdL37Pqg@mail.gmail.com>
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

On Mon, 10 Dec 2018 at 17:43, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi,
>
> On 10/12/18 8:55 PM, Ulf Hansson wrote:
> > On Mon, 10 Dec 2018 at 15:04, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>
> >> Hi,
> >>
> >> On 10/12/18 7:15 PM, Ulf Hansson wrote:
> >>> On Mon, 10 Dec 2018 at 14:23, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>>>
> >>>> Hi Uffe,
> >>>>
> >>>> On 05/12/18 7:20 PM, Ulf Hansson wrote:
> >>>>> On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>>>>>
> >>>>>> Hi Kishon,
> >>>>>>
> >>>>>> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
> >>>>>>> Hi Faiz,
> >>>>>>>
> >>>>>>> On 30/11/18 12:35 AM, Faiz Abbas wrote:
> >>>>>>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> >>>>>>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> >>>>>>>> unexpected tuning pattern errors. A small failure band may be present
> >>>>>>>> in the tuning range which may be missed by the current algorithm.
> >>>>>>>> Furthermore, the failure bands vary with temperature leading to
> >>>>>>>> different optimum tuning values for different temperatures.
> >>>>>>>>
> >>>>>>>> As suggested in the related Application Report (SPRACA9B - October 2017
> >>>>>>>> - Revised July 2018 [2]), tuning should be done in two stages.
> >>>>>>>> In stage 1, assign the optimum ratio in the maximum pass window for the
> >>>>>>>> current temperature. In stage 2, if the chosen value is close to the
> >>>>>>>> small failure band, move away from it in the appropriate direction.
> >>>>>>>>
> >>>>>>>> References:
> >>>>>>>> [1] http://www.ti.com/lit/pdf/sprz426
> >>>>>>>> [2] http://www.ti.com/lit/pdf/SPRACA9
> >>>>>>>>
> >>>>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >>>>>>>> ---
> >> ...
> >>>>>>>
> >>>>>>> Can't we get thermal zone once during probe?
> >>>>>>>
> >>>>>>
> >>>>>> Tuning is also (ideally) supposed to happen only once per enumeration.
> >>>>>> Also it doesn't make sense to get a thermal zone for lower speed systems
> >>>>>> that won't do tuning.
> >>>>>
> >>>>> Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
> >>>>> then keeps the host device runtime resumed until ->remove() is called
> >>>>> on it. I assume you are going to change that, at some point!?
> >>>>>
> >>>>> In other words, what will happen to the host device when it becomes
> >>>>> runtime suspended? Is re-tuning needed when it gets runtime resumed,
> >>>>> which is the case for many other sdhci variants?
> >>>>
> >>>> There are no plans to support runtime_suspend()/resume() any time in the
> >>>> near future. If its ok with you, I would like to get this patch in
> >>>> without any changes. We can change it in case a need for
> >>>> runtime_suspend()/_resume() does arise.
> >>>
> >>> Right, I am okay with that. Due to recent changes to sdhci-omap
> >>> $subject patch doesn't apply, can you please rebase!?
> >>>
> >>> Additionally, I realized that we should fold in patch updating the DT
> >>> doc for sdhci-omap, adding the property for the thermal zone. I
> >>> regards to that, I am wondering if "cpu_thermal", is really the
> >>> correct name of the zone. The point is, I am guessing the zone could
> >>> change along with the SoCs/platforms.
> >>>
> >>
> >> As you have probably noticed, we are introducing a new driver
> >> (sdhci_am654) for newer platforms. I don't foresee using sdhci-omap
> >> driver with any other platforms. In case we do use it, we can add the dt
> >> property at that point of time and default to "cpu_thermal" to maintain
> >> dt compatibility.
> >>
> >> Will rebase and send v2 if you are ok with above.
> >
> > I see, but you still need to update the DT doc for sdhci-omap.
> >
>
> I didn't get you. There are no changes in dt. What changes should I
> document?

Well, you are fetching a thermal zone using a specific name. It's
quite similar to how we document other resources (pinctrls for
example) that sdhci omap depends on, so that needs to be document too.

Kind regards
Uffe

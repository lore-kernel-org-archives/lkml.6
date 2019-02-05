Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757F82175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPrLLSJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfBEJkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:40:25 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36510 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfBEJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:40:25 -0500
Received: by mail-vk1-f193.google.com with SMTP id 185so638517vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUbbD68Dm2rbFTrJ1ZJ+R3uLQKALFkdWbqo3heo6Xzw=;
        b=EPrLLSJFKOg7JaGRhtkSyBHeo/acfa3gyel5KjAsGlerXfXz8OVU5IcTzCm3+I2duc
         yPrw1wQavGMpdwR68etgw71JOoYoWzpUqcUcva41/0dBOhDML4NBJOqWNVCCOsqwphFQ
         src8rmWtvKZGoBsMZBfpMjZlr6ZGMSBue5lhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUbbD68Dm2rbFTrJ1ZJ+R3uLQKALFkdWbqo3heo6Xzw=;
        b=HlTypnwcbFhe+/KoqRmBYGASlGV0fnvr5eSg9GJYxzNm/FX3Sla1Ryj2QxahxQEErq
         HNaHIRcaqlueR89tmMAtjdGF8zaLZ55ep+KLzVOuKgEyg2jeYQ5cBC+BwyFwxa8WrvUS
         SqoafBWXLfr3+9YB17vq9jmf76U0K179Tbjn/4xfX6J3gZK65Akf3vwT5msrtaFTPfw/
         QNdg4qzBFZ8sD7hPVlTTTihZvXY0p8FH6H+cS0pGSqVWpbrH9y95GV+mki4d9mVYtvPv
         bS8rjEiXuCvn64x0Gap1Nlk3yt0VZ0S0vsCUPdi01lNFV11UjiBYKh4n7YLc+sUi2s4Y
         s7zw==
X-Gm-Message-State: AHQUAubou7iQYPE/+trTMxXMuwUOGJpa1fXvKGV3nVC+TvmAmtE0uGEN
        olbseXn620DGLsH5CMMaGsNit/jd/rwTIgKbPrPO3w==
X-Google-Smtp-Source: AHgI3IbHO3PSU3qDgTSJnVVoEKJNT5+Pu8j1uNBG0k2Z2IBxFOUzci+lNCtTgLYnqoGJfKipauibUz+/JooOouyYfrI=
X-Received: by 2002:a1f:1408:: with SMTP id 8mr361031vku.36.1549359623932;
 Tue, 05 Feb 2019 01:40:23 -0800 (PST)
MIME-Version: 1.0
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
 <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFodySv0A9ESDWwpJU=FQeyZ3FpOG0BMVBPxfgxd3oLWDw@mail.gmail.com> <AM0PR04MB4211C13768DD0D9543B6A59F808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211C13768DD0D9543B6A59F808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Feb 2019 10:39:47 +0100
Message-ID: <CAPDyKFrnUK1_=0okEPTxCjACbOpYuOF9h3oK6pBTXrR9OYje+A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for attach_dev
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > Then attach_dev() can parse the correct "resource id" (e.g.
> > > IMX_SC_R_SDHC_1) from device tree And store it in per-device struct
> > generic_pm_domain_data for later start()/stop() using.
> >
> > I see, thanks for clarifying.
> >
> > Seem like, we have two options to make this work.
> >
> > 1. Let genpd pre-store the index in a the per device generic_pm_domain_data
> > while doing the attach and before calling the
> > ->attach_dev() callback. This would make sense, if we consider this to
> > be a common thing.
> >
> > 2. Provide the index as an additional new in-parameter to the
> > ->attach_dev() callback. This requires a tree wide change as it means
> > we need to update existing code using the ->attach_dev() callback.
> >
> > I would probably try 1) first to see how the code would look like and then fall
> > back to 2). What do you think?
> >
>
> Yes, I agree with you.
> This patch is exactly doing 1.
>
> For your former suggestion:
> " Just assign virt_dev->of_node = of_node_get(dev->of_node), somewhere in
> genpd_dev_pm_attach_by_id() and before calling __genpd_dev_pm_attach().
> Doing that, would mean the genpd provider's ->attach_dev() callback,
> don't have to distinguish between virtual and non-virtual devices"
>
> As this can only solve passing the real device node issue and we still need
> pre-store the index in a the per device generic_pm_domain_data and then
> distinguish if it's multi power domain virtual devices in attach_dev(), so
> I'm not sure if it's still quite necessary to do that way by assigning
> "virt_dev->of_node = of_node_get(dev->of_node) before attach".
> Probably after fully switch to option 2, then we can do it to fully drop the using
> of per device generic_pm_domain_data to make it transparent to attach_dev()
> users.
>
> So now the options may be:
> 1. Pre-store both device node and domain index in generic_pm_domain_data before
>   Calling attach_dev(). This is exactly this patch does.
> 2. Pre-store only domain index in generic_pm_domain_data. For device node, assigning
>   "virt_dev->of_node = of_node_get(dev->of_node) before attach.
> 3. Change attach_dev() to passing domain index and assigning
>   "virt_dev->of_node = of_node_get(dev->of_node) before attach.
>
> Can you please tell what's your prefer?

Apologize for the delay, just realized that you were expecting a reply from me.

To me is sounds like option 2) is the most feasible. Perhaps it's even
a good idea to store the domain index in the struct
generic_pm_domain_data, as it allows it then to be used at any point
later in time, this not only from the ->attach_dev() callback as
option 3) would mean.

So according to my understandings, then your genpd backend driver's
->attach_dev() callback, would use dev_gpd_data() to find out the
domain index for the device in question. Is that sufficient, or is
there anything else that is needed?

[...]

Kind regards
Uffe

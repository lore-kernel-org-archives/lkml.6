Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1325C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980072070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4KedPvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfACVLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:11:14 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44995 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfACVLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:11:13 -0500
Received: by mail-vk1-f195.google.com with SMTP id h128so7535668vkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hqeyzf+7W6OJKBkHwPX/MEzcnEYQPL2tt1pPyw09+Ok=;
        b=c4KedPvBpOtL4aFZmZfBzPULMu4AMzQ/yEazqXx9oCzES0GUwmHvBC+YqV2nD5BGgW
         eictGKWixFb0BZKEWGCgCnxBAtnK+l3XBZoZwKieckV7fVL6zkuLRTgdCUow7nRgSgM/
         zp26t9yUIU2cIRcsftHycstuxfI1Zp8P9y8ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hqeyzf+7W6OJKBkHwPX/MEzcnEYQPL2tt1pPyw09+Ok=;
        b=WuZ36NB75HCVQAFZxnLJyCxuKh5M7dOPPEVxJFcmFHei5t9v0k6E13dDQ/HCP1ECQA
         xq6dScTW/r+NpMTqRHyEdqD/SNV3kTfy7mxtUoVUveu1+YAKNwauoGPYemi3D1OYsi+s
         xi3ErZ7UEsqrP5UsWzOWEfDMLyfvp0tUr6MOoJ69nkr+bb37xTQPvdjRaT83CpM9dg7w
         D2ag1N8EfdE6uA0tc/RDsAyoe0kbm6P0CYjikr+Rr+EaDFJ8g/Zw+Pk2TYDWQlhg7/rM
         /rX9aHrMKKINumnv+xGSslrENIksu9WqKR0kjpbUsI6LHqadGw9YSoZtZbFAP7Qlc8JC
         fzzw==
X-Gm-Message-State: AJcUukfconr9Nok2RYK/HOJJmf38l4NgGGWUZsEy3fHWc2lS//H/eqGA
        v8M1KdQ7HbkDmZJXof1+IhXNeAGPQpLMsgWt5cS+xQ==
X-Google-Smtp-Source: ALg8bN51InTOFv6TS+e6vIGB+OWIrHH6WINWGjkGcIEqUAsUvDR9TwTRlr96YdYaAT8bTVo68X6KO3l1vAlnVmeXWug=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr17320034vkc.52.1546549871867;
 Thu, 03 Jan 2019 13:11:11 -0800 (PST)
MIME-Version: 1.0
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com> <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jan 2019 22:10:35 +0100
Message-ID: <CAPDyKFodySv0A9ESDWwpJU=FQeyZ3FpOG0BMVBPxfgxd3oLWDw@mail.gmail.com>
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

On Wed, 2 Jan 2019 at 17:29, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: Wednesday, January 2, 2019 6:49 PM
> >
> > On Sat, 29 Dec 2018 at 07:43, Aisheng Dong <aisheng.dong@nxp.com> wrote:
> > >
> > > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > > Sent: Friday, December 28, 2018 11:37 PM
> > > >
> > > > On Thu, 27 Dec 2018 at 18:14, Aisheng Dong <aisheng.dong@nxp.com>
> > > > wrote:
> > > > >
> > > > > Currently attach_dev() in power domain infrastructure still does
> > > > > not support multi domains case as the struct device *dev passed
> > > > > down from
> > > > > genpd_dev_pm_attach_by_id() is a virtual PD device, it does not
> > > > > help for parsing the real device information from device tree, e.g.
> > > > > Device/Power IDs, Clocks and it's unware of which real power
> > > > > domain the device should attach.
> > > >
> > > > Thanks for working on this!
> > > >
> > > > I would appreciate if the changelog could clarify the problem a bit.
> > > > Perhaps something along the lines of the below.
> > > >
> > >
> > > Sounds good to me.
> > > I will add them in commit message.
> > > Thanks for the suggestion.
> > >
> > > > "A genpd provider's ->attach_dev() callback may be invoked with a so
> > > > called virtual device, which is created by genpd, at the point when
> > > > a device is being attached to one of its corresponding multiple PM
> > domains.
> > > >
> > > > In these cases, the genpd provider fails to look up any resource, by
> > > > a
> > > > clk_get() for example, for the virtual device in question. This is
> > > > because, the virtual device that was created by genpd, does not have
> > > > the virt_dev->of_node assigned."
> > > >
> > > > >
> > > > > Extend the framework a bit to store the multi PM domains
> > > > > information in per-device struct generic_pm_domain_data, then
> > > > > power domain driver could retrieve it for necessary operations during
> > attach_dev().
> > > > >
> > > > > Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are also
> > > > > introduced to ease the driver operation.
> > > > >
> > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > > ---
> > > > > This patch is a follow-up work of the earlier discussion with Ulf
> > > > > Hansson about the multi PM domains support for the attach_dev()
> > > > > function
> > > > [1].
> > > > > After a bit more thinking, this is a less intrusive implementation
> > > > > with the mininum impact on the exist function definitions and
> > > > > calling
> > > > follows.
> > > > > One known little drawback is that we have to use the device driver
> > > > > private data (device.drvdata) to pass down the multi domains
> > > > > information in a earlier time. However, as multi PD devices are
> > > > > created by domain framework, this seems to be safe to use it in
> > > > > domain core code as device driver is not likely going to use it.
> > > > > Anyway, if any better ideas, please let me know.
> > > > >
> > > > > With the two new APIs, the using can be simply as:
> > > > > static int xxx_attach_dev(struct generic_pm_domain *domain,
> > > > >                           struct device *dev) {
> > > > >         ...
> > > > >         if (genpd_is_mpd_device(dev)) {
> > > > >                 mpd_data = dev_gpd_mpd_data(dev);
> > > > >                 np = mpd_data->parent->of_node;
> > > > >                 idx = mpd_data->index;
> > > > >                 //dts parsing
> > > > >                 ...
> > > > >         }
> > > > >         ...
> > > >
> > > > I think we can make this a lot less complicated. Just assign
> > > > virt_dev->of_node = of_node_get(dev->of_node), somewhere in
> > > > genpd_dev_pm_attach_by_id() and before calling
> > __genpd_dev_pm_attach().
> > > >
> > > > Doing that, would mean the genpd provider's ->attach_dev() callback,
> > > > don't have to distinguish between virtual and non-virtual devices.
> > > > Instead they should be able to look up resources in the same way as
> > > > they did before.
> > > >
> > >
> > > Yes, that seems like a smart way.
> > > But there's still a remain problem that how about the domain index
> > > information needed for attach_dev()?
> > >
> >
> > What do you mean by domain index?
> >
>
> As we're using multi power domains in Devicetree, attach_dev() needs to
> know which power domain the device is going to attach.
> e.g.
> sdhc1: mmc@5b010000 {
>         compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
>         power-domains = <&pd IMX_SC_R_SDHC_0>, <&pd IMX_SC_R_SDHC_1>;   // for test only
>         ...
> };
> Then attach_dev() can parse the correct "resource id" (e.g. IMX_SC_R_SDHC_1) from device tree
> And store it in per-device struct generic_pm_domain_data for later start()/stop() using.

I see, thanks for clarifying.

Seem like, we have two options to make this work.

1. Let genpd pre-store the index in a the per device
generic_pm_domain_data while doing the attach and before calling the
->attach_dev() callback. This would make sense, if we consider this to
be a common thing.

2. Provide the index as an additional new in-parameter to the
->attach_dev() callback. This requires a tree wide change as it means
we need to update existing code using the ->attach_dev() callback.

I would probably try 1) first to see how the code would look like and
then fall back to 2). What do you think?

>
> > The ->attach_dev() is given both the device and the genpd in question as
> > in-parameters. Could you store the domain index as part of your genpd struct?
> > No?
> >
>
> AFAICT no.
> With the only device and the genpd as in-parameters, the ->attach_dev() don't know
> which power domain to to parse from device tree.
> Thus no way to store it in genpd struct.

As stated, you are right!

>
> > If you are talking about using the "power-domains" specifier from the DT node
> > of the device, that should then work, similar to as been done
> > in:
> >
> > drivers/soc/ti/ti_sci_pm_domains.c
> > ti_sci_pd_attach_dev()
> >
>
> TI actually does not use multi PM domains. So they can always parse
> the first power domains to get the correct "resource id" / power id..
>
> wdt: wdt@02250000 {
>         compatible = "ti,keystone-wdt", "ti,davinci-wdt";
>         power-domains = <&k2g_pds 0x22>;
> };
>
> static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
>                                 struct device *dev)
> {
>         ...
>                 // the index is always 0
>         ret = of_parse_phandle_with_args(np, "power-domains",
>                                          "#power-domain-cells", 0, &pd_args);
>         idx = pd_args.args[0];
>         ...
> }
>
> > You may also provide your own xlate callback for your genpd provider, like
> > what is done in drivers/soc/tegra/powergate-bpmp. - if that helps!?
> >
>
> I'm afraid no.
> Per our earlier discussion, we're going to use a single global power domain
> (Tegra is not) and implement the ->attach|detach_dev() callback for the genpd
> and use the regular of_genpd_add_provider_simple().
>
> From within the ->attach_dev(), we could get the OF node for the device that is
> being attached and then parse the power-domain cell containing the "resource id"
> and store that in the per device struct generic_pm_domain_data (we have void pointer
> there for storing these kind of things).
>
> Additionally, we need implement the ->stop() and ->start() callbacks of genpd,
> which is where we "power on/off" devices, rather than using the
> ->power_on|off() callbacks.
>
> Now the problem is current attach_dev() has no idea to parse the correct power domain
> containing the "resource id".
> That's why I stored it in per-device struct generic_pm_domain_data before calling
> attach_dev() in this patch implementation.
>
> Any ideas?

Again, thanks for clarifying!

See my ideas above.

Kind regards
Uffe

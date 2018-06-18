Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06639C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BA120852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ducuUfK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BA120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936896AbeFRJK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:10:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34961 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936860AbeFRJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:10:25 -0400
Received: by mail-qt0-f196.google.com with SMTP id s9-v6so14463073qtg.2;
        Mon, 18 Jun 2018 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLf1GTAx0aRBzI4OvbhHi/zD6Tvpv9gvNnT+MC5Dq5I=;
        b=ducuUfK0A5fXyjSlA6+V19Na0LSiIO04ovvT8iK4byfaQBXDx1tgwQrMSoXvo0fI6I
         lYpcOqhx5aB6UTJ1AuFXkwYK7VSjmYZTZL24vV7iLZavmAludP1zBXCPlbW7RDA+LOmA
         1Bf1hHd7tnOdDx0CfWyJPeio1mZ9YC1mjgfsSxIR6LE662FpBJw6TNeHgyDgi5zSPvhg
         g5XadzH+Lsv+Xd/iwO5r8elMQxecYaVkg7yIoVERdKzhO+WJofrR7QKYJgXemgvGbWFp
         94bQHaql4M3F270PABTUpI3bVWkcgsl+/QHEqjRZGCeTHgnqTjLOCpbh5SretSE+ujsy
         EQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLf1GTAx0aRBzI4OvbhHi/zD6Tvpv9gvNnT+MC5Dq5I=;
        b=Df2sCqbAdXss1V8qONdnrqLvcmf8Ree09toA1KOAZwrns0W2/G9cMC4kybvayhPbde
         I0fdvdWl5kW4W8qOjazTGgwr0twZZEJ8t43pVCxH052Ij+pish3VaNHf1T6I209fDecC
         042xLDb6RHQKuayOSoFrl+Di3+eNtkk2MiVwsEXrJdQcxFavU6P1U7vdxjonaotbf3LE
         r0f+yvD3CXEOXuJflE7Bhg1ddKdEVtmViEPcOCYrASGNaWwm7DEtHOAjhtvi4hZnajAc
         SIBs6e7UB0dMkK3H9G+Z99oy9rIe+/qLkmmAGC+mgrFnB3EhkDB0FDO1tcIVHXDb9Alh
         9diA==
X-Gm-Message-State: APt69E3nuP3/fYyIVqz5jlw7oixO+FdE5hd2TOkV2Piwpy5jnM3K5ESq
        1sL2HcMslMX8FsBVKGsHg/V0SgJ+ur2S5OZTFLA=
X-Google-Smtp-Source: ADUXVKLJm3JjsNOU1dMWp7IqhA/T1vkdwcQCkgGl0FlQXWo2wVaS1Hvn3fcCxySNtWZ06pVFvRH+7FVTnlT4lEMOCbs=
X-Received: by 2002:aed:3f2e:: with SMTP id p43-v6mr10487470qtf.267.1529313024236;
 Mon, 18 Jun 2018 02:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180615151217.29872-1-enric.balletbo@collabora.com> <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
In-Reply-To: <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 18 Jun 2018 11:10:13 +0200
Message-ID: <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on reload.
To:     cwchoi00@gmail.com
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
2018 a les 5:23:
>
> Hi Enric,
>
> 2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@collabora.com>:
> > The opp table is not removed when the driver is unloaded neither when
> > there is an error within probe, so if the driver is reloaded the opp
> > core shows the following warning:
> >
> >   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
> >                200000000, volt: 900000, enabled: 1. New: freq: 200000000,
> >                volt: 900000, enabled: 1
> >   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
> >                400000000, volt: 900000, enabled: 1. New: freq: 400000000,
> >                volt: 900000, enabled: 1
> >   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
> >                666000000, volt: 900000, enabled: 1. New: freq: 666000000,
> >                volt: 900000, enabled: 1
> >   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
> >                800000000, volt: 900000, enabled: 1. New: freq: 800000000,
> >                volt: 900000, enabled: 1
> >   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
> >                928000000, volt: 900000, enabled: 1. New: freq: 928000000,
> >                volt: 900000, enabled: 1
> >
> > This patch fixes the error path in the probe function and adds a .remove
> > function to properly cleanup the opp table on unloading.
> >
> > Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver for rk3399 dmc)
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> > index d5c03e5abe13..e795ad2b3f6b 100644
> > --- a/drivers/devfreq/rk3399_dmc.c
> > +++ b/drivers/devfreq/rk3399_dmc.c
> > @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> >         data->rate = clk_get_rate(data->dmc_clk);
> >
> >         opp = devfreq_recommended_opp(dev, &data->rate, 0);
> > -       if (IS_ERR(opp))
> > -               return PTR_ERR(opp);
> > +       if (IS_ERR(opp)) {
> > +               ret = PTR_ERR(opp);
> > +               goto err_free_opp;
> > +       }
> >
> >         data->rate = dev_pm_opp_get_freq(opp);
> >         data->volt = dev_pm_opp_get_voltage(opp);
> > @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> >                                            &rk3399_devfreq_dmc_profile,
> >                                            DEVFREQ_GOV_SIMPLE_ONDEMAND,
> >                                            &data->ondemand_data);
> > -       if (IS_ERR(data->devfreq))
> > -               return PTR_ERR(data->devfreq);
> > +       if (IS_ERR(data->devfreq)) {
> > +               ret = PTR_ERR(data->devfreq);
> > +               goto err_free_opp;
> > +       }
> > +
> >         devm_devfreq_register_opp_notifier(dev, data->devfreq);
> >
> >         data->dev = dev;
> >         platform_set_drvdata(pdev, data);
> >
> > +       return 0;
>
> It looks strange. Because rk3399_dmcfreq_probe() already include
> 'return 0' when success.
> What is the base commit of this patch?
>

Sorry, I am not sure I understand your question, If I am not answering
below could you rephrase?

So, once the opp table is added we need an error path to free it if an
error occurs later. When the probe returns 0, we need to free the opp
table when we remove the module.

> [snip]
>
> Anyway, if probe fail, device driver have to remove registered OPP table.
> Looks good to me.
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>

Thanks,
 Enric

> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics

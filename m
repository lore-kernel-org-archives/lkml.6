Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85CAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924B3204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMmh17Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924B3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeGQNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:50:45 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41084 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbeGQNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:50:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id e19-v6so778010qtp.8;
        Tue, 17 Jul 2018 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rtv1hRrg3g/EIrEGFxddDbzy0hXXqDACXq4iYKEfH5w=;
        b=mMmh17Nfd7Q7VhhWAqsTh80SS9f+ZA5ZSFAMo/AKj7ZM5l/qBttCglZR12KFqoeY11
         1s1WJGOm+jG42Tg4uV/Eqp8MblDJN6grghRoxjG4ZZh4RjJ6xULx+8g3OQpvNNBFRr8q
         aRi8+sEkgKfXdeQg51M0qwz0OZmuiDwMoBnRDE89IBl53l1fW4vvyCruFyMkiSTCYW50
         jrYAAxgG2MSEp9fFNa5Uo9rL+T2r9RHLu9exWuZJNeT5yky7p9sDhwyNt1O3X/ZaqjrD
         YCl8C5euzLr/Ej7EiiAU9ouVOa4/XIxbdmdjtwlBsA5szwWCm6e9cxTMghsXP1gmcN2c
         q/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rtv1hRrg3g/EIrEGFxddDbzy0hXXqDACXq4iYKEfH5w=;
        b=aNVE9X5S3BYFEVPuFpRK7c0RtD9l2ive0ylCGCmOj5SDEetBTaO8P+x7GCs3UEvpwx
         kldn7bt8iWEC4mhFDFw1SmGt9dF6dS0KGfky8yCDk2dnNPu1tu0Bhj95NHsnYrH4Jjzo
         w7Ygmre2NDOCiMbhqloA60ra6n8MkLWKZU3yXQZpHKzUT7mbVxof4YPra4bDPV5vwaka
         xOQoS7J6Pet7YycUthjGp7IXFx6x6kfLCauAnpstyRwT9i2419rMJwvvmux7CysoRhQV
         LwqjFk90CrqheYqQoi4fPVcu0v7zH5De66589cE2jlLGb+iYg0WS1JHAub5BRoJ1N4LY
         JkrA==
X-Gm-Message-State: AOUpUlGUYihn9aNtGZPAjbzlxumq7cC2FxObPat5/6qy7889G/hFeAxl
        8t+oFUkjlxbuJJNHEb2/bTLpq5knvfJHtxGAWuM=
X-Google-Smtp-Source: AAOMgpc67YbP5znLINKsvzKJ/+5GVdSQYJkrIqi2NR5EF38f/uDivX07JXPz/sNyOy4FC0EhBo2V3+TAb5iWX5HmtoM=
X-Received: by 2002:a0c:f3d1:: with SMTP id f17-v6mr1666697qvm.66.1531833485576;
 Tue, 17 Jul 2018 06:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180615151217.29872-1-enric.balletbo@collabora.com>
 <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
 <CGME20180618091029epcas3p498708535c8f8df019bf3785a199d58b4@epcas3p4.samsung.com>
 <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
 <5B288430.2040600@samsung.com> <65546a48-3291-9836-cb0c-1e65ff7c9d41@collabora.com>
 <5B29A4CE.9060009@samsung.com>
In-Reply-To: <5B29A4CE.9060009@samsung.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 17 Jul 2018 15:17:53 +0200
Message-ID: <CAFqH_52TaDiV6o5SmBhiT6v-qiG8tc=Bs0gPyFQzT1=7utkqGg@mail.gmail.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on reload.
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        cwchoi00@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Chanwoo Choi <cw00.choi@samsung.com> del dia dc., 20 de
juny 2018 a les 2:50:
>
> Hi Enric,
>
> On 2018=EB=85=84 06=EC=9B=94 19=EC=9D=BC 17:07, Enric Balletbo i Serra wr=
ote:
> > Hi Chanwoo,
> >
> > On 19/06/18 06:18, Chanwoo Choi wrote:
> >> Hi Enric,
> >>
> >> On 2018=EB=85=84 06=EC=9B=94 18=EC=9D=BC 18:10, Enric Balletbo Serra w=
rote:
> >>> Hi Chanwoo,
> >>>
> >>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
> >>> 2018 a les 5:23:
> >>>>
> >>>> Hi Enric,
> >>>>
> >>>> 2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@col=
labora.com>:
> >>>>> The opp table is not removed when the driver is unloaded neither wh=
en
> >>>>> there is an error within probe, so if the driver is reloaded the op=
p
> >>>>> core shows the following warning:
> >>>>>
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                200000000, volt: 900000, enabled: 1. New: freq: 2000=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                400000000, volt: 900000, enabled: 1. New: freq: 4000=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                666000000, volt: 900000, enabled: 1. New: freq: 6660=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                800000000, volt: 900000, enabled: 1. New: freq: 8000=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                928000000, volt: 900000, enabled: 1. New: freq: 9280=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>
> >>>>> This patch fixes the error path in the probe function and adds a .r=
emove
> >>>>> function to properly cleanup the opp table on unloading.
> >>>>>
> >>>>> Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver fo=
r rk3399 dmc)
> >>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com=
>
> >>>>> ---
> >>>>>
> >>>>>  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
> >>>>>  1 file changed, 27 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_=
dmc.c
> >>>>> index d5c03e5abe13..e795ad2b3f6b 100644
> >>>>> --- a/drivers/devfreq/rk3399_dmc.c
> >>>>> +++ b/drivers/devfreq/rk3399_dmc.c
> >>>>> @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platfor=
m_device *pdev)
> >>>>>         data->rate =3D clk_get_rate(data->dmc_clk);
> >>>>>
> >>>>>         opp =3D devfreq_recommended_opp(dev, &data->rate, 0);
> >>>>> -       if (IS_ERR(opp))
> >>>>> -               return PTR_ERR(opp);
> >>>>> +       if (IS_ERR(opp)) {
> >>>>> +               ret =3D PTR_ERR(opp);
> >>>>> +               goto err_free_opp;
> >>>>> +       }
> >>>>>
> >>>>>         data->rate =3D dev_pm_opp_get_freq(opp);
> >>>>>         data->volt =3D dev_pm_opp_get_voltage(opp);
> >>>>> @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platfo=
rm_device *pdev)
> >>>>>                                            &rk3399_devfreq_dmc_prof=
ile,
> >>>>>                                            DEVFREQ_GOV_SIMPLE_ONDEM=
AND,
> >>>>>                                            &data->ondemand_data);
> >>>>> -       if (IS_ERR(data->devfreq))
> >>>>> -               return PTR_ERR(data->devfreq);
> >>>>> +       if (IS_ERR(data->devfreq)) {
> >>>>> +               ret =3D PTR_ERR(data->devfreq);
> >>>>> +               goto err_free_opp;
> >>>>> +       }
> >>>>> +
> >>>>>         devm_devfreq_register_opp_notifier(dev, data->devfreq);
> >>>>>
> >>>>>         data->dev =3D dev;
> >>>>>         platform_set_drvdata(pdev, data);
> >>>>>
> >>>>> +       return 0;
> >>>>
> >>>> It looks strange. Because rk3399_dmcfreq_probe() already include
> >>>> 'return 0' when success.
> >>>> What is the base commit of this patch?
> >>>>
> >>>
> >>> Sorry, I am not sure I understand your question, If I am not answerin=
g
> >>> below could you rephrase?
> >>
> >> When I check the rk3399_dmcfreq_probe()[1], as I commented,
> >> rk3399_dmcfreq_probe() already 'return 0' after platform_set_drvdata()=
.
> >> You can check it on link[1].
> >> [1] https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/devfreq/=
rk3399_dmc.c#L443
> >>
> >> But, this patch add new '+       return 0;' line again in rk3399_dmcfr=
eq_probe().
> >> So, just I asked what is base commit of this patch.
> >>
> >
> > I think that this is just how git did the diff and if you only look at =
the diff
> > is a bit confusing, if you apply the patch on top of mainline you will =
see that
> > there is only one return 0 in the probe function.
>
> Anyway, when I applied it to git, there is no problem.
> Just I have never seen such a case and asked a question.
> Don't care about this anymore. Thanks.
>
> >
> > +       return 0; (this new return ...)
> > +
> > +err_free_opp:
> > +       dev_pm_opp_of_remove_table(&pdev->dev);
> > +       return ret;
> > +}
> > +
> > +static int rk3399_dmcfreq_remove(struct platform_device *pdev)
> > +{
> > +       struct rk3399_dmcfreq *dmcfreq =3D dev_get_drvdata(&pdev->dev);
> > +
> > +       /*
> > +        * Before remove the opp table we need to unregister the opp no=
tifier.
> > +        */
> > +       devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->dev=
freq);
> > +       dev_pm_opp_of_remove_table(dmcfreq->dev);
> > +
> >         return 0; (was this before the patch, but now is in another fun=
ction)
> >
> > Cheers,
> >  Enric
> >
> >>>
> >>> So, once the opp table is added we need an error path to free it if a=
n
> >>> error occurs later. When the probe returns 0, we need to free the opp
> >>> table when we remove the module.
> >>>
> >>>> [snip]
> >>>>
> >>>> Anyway, if probe fail, device driver have to remove registered OPP t=
able.
> >>>> Looks good to me.
> >>>>
> >>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>>>

A gentle ping, although is a fix I think is late and not enough
critical to be merged in this release cycle, there is a chance this
can be queued for 4.19?

Thanks,
 Enric

> >>>
> >>> Thanks,
> >>>  Enric
> >>>
> >>>> --
> >>>> Best Regards,
> >>>> Chanwoo Choi
> >>>> Samsung Electronics
> >>>
> >>>
> >>>
> >>
> >>
> >
> >
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics

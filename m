Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6202320850
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVwflN9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756950AbeFQAAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:00:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38849 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756925AbeFQAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:00:31 -0400
Received: by mail-io0-f193.google.com with SMTP id l19-v6so13843337ioj.5;
        Sat, 16 Jun 2018 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=KMAteSR4QGKnSoezkO3g/y9zqZmN5HdAd/A/91FOcHg=;
        b=DVwflN9Zg/vxMq8EkzwrPeNArPKxd1NmJJuC/Qdf/DOc0tIKnDSaroK1B7P9oDGaPp
         4GBXXOIpxqkdGkoMPiLX8ftorM+dXLfDDjKFqYrfC1penaxf3f8lASYu5h3EKSSxuuxC
         p/NwDzgpWkJjORyg091dc3qgQiXOgs9z4AtCnF6Zk5a+Z3z9vDZ4pK4S13+SYlRQZQys
         ElZxCmGyJgRDTPXsNiB8mfSph69wp6Jibg6/ua6mWG+FWCfe7prZIIjoKICRdLC9b5AK
         XQUZHLkhUxM2TQtjiTmTqKZqAlnwytDLIRHUz4tzEwgQCltx2RqpLXJv+jC3AioyzaKD
         vn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=KMAteSR4QGKnSoezkO3g/y9zqZmN5HdAd/A/91FOcHg=;
        b=cqqm7mlgeiMQz400EYLxjQYRAI9SNvhZiBHg3hFFK7S0YO45wnh9opAIToBTnjrALJ
         xIH6Dsph0a7PPI7aCpKMFFHjbAV8h9lhtOAIsEM1A4SAajfb9ZdcG9ERrqcvo/iDA0Ar
         2K6eEzcJ9GHk9dVAYClGni40Qh0SinudsQZ5cGh9tF90WOZOYuIuLiWE3eNLr22odvsK
         Lli8zu9tnU8mXMscSteStCj8FzOd/q32XSMMptNzXU1pQLWwkNZ5xkvKhSz9ZMRQqb/y
         OuHDJ468KYeeqTVHpODpTjUohKS3xij3wXNDrbbLZ4HJc1FhEi/aaNGumdsinExaDQql
         Vg0Q==
X-Gm-Message-State: APt69E1RlqlPdO7eECHRZarJmJU+5ZLfo9VPaqhhPKUO9SN28GoCx7L/
        DZZPWjk+M97ykpJmO5OCBz65h4B6JG1KWJILchM=
X-Google-Smtp-Source: ADUXVKJvbxRuJvi6pfaHmxOscWzDvGHOu+Wub9hdWTrb2zorr/geWVz03tc+r8kI1hOreTbOkODvokDY6GN1jUFyDSM=
X-Received: by 2002:a6b:1f0e:: with SMTP id f14-v6mr5436037iof.236.1529193630333;
 Sat, 16 Jun 2018 17:00:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:8d04:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 17:00:29
 -0700 (PDT)
Reply-To: cwchoi00@gmail.com
In-Reply-To: <CAFqH_51jDy6hvwTtVQf52OZ2QFwAACzH8bh2bUZdxAnvKqM6=A@mail.gmail.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <CGME20180514211840epcas3p41708e430bc22d7e61e8b894b12a083f9@epcas3p4.samsung.com>
 <20180514211610.26618-4-enric.balletbo@collabora.com> <5AFA0B94.4000100@samsung.com>
 <CAFqH_51jDy6hvwTtVQf52OZ2QFwAACzH8bh2bUZdxAnvKqM6=A@mail.gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 17 Jun 2018 09:00:29 +0900
Message-ID: <CAGTfZH3DqzOXNy-w6x=DC9PJ-XPe8SPtZqkONwVO2aL5OGAcqA@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] devfreq: rk3399_dmc: Pass ODT and auto power
 down parameters to TF-A.
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        hjc@rock-chips.com, David Airlie <airlied@linux.ie>,
        huang lin <hl@rock-chips.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dbasehore@chromium.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>, kernel@collabora.com,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric

2018-06-16 19:15 GMT+09:00 Enric Balletbo Serra <eballetbo@gmail.com>:
> Hi Chanwoo,
>
> I'll send a new version soon, just wanted to ask some questions here. See=
 below.
>
> Missatge de Chanwoo Choi <cw00.choi@samsung.com> del dia dt., 15 de
> maig 2018 a les 0:21:
>>
>> Hi,
>>
>> On 2018=EB=85=84 05=EC=9B=94 15=EC=9D=BC 06:16, Enric Balletbo i Serra w=
rote:
>> > Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
>> > on-die termination (ODT) and auto power down parameters from kernel,
>> > this patch adds the functionality to do this. Also, if DDR clock
>> > frequency is lower than the on-die termination (ODT) disable frequency
>> > this driver should disable the DDR ODT.
>>
>> I have a question.
>> 'disable frequency' is the same meaning of 'disable the DDR ODT'?
>>
>
> Yes, the DT defines an odt_dis_freq parameter, when the DDR frequency
> is less than the value in this parameter we disable the ODT on the
> DRAM.
>
>> >
>> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> > ---
>> >
>> >  drivers/devfreq/rk3399_dmc.c        | 50 ++++++++++++++++++++++++++++=
-
>> >  include/soc/rockchip/rockchip_sip.h |  1 +
>> >  2 files changed, 50 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc=
.c
>> > index d5c03e5abe13..cc1bbca3fb15 100644
>> > --- a/drivers/devfreq/rk3399_dmc.c
>> > +++ b/drivers/devfreq/rk3399_dmc.c
>> > @@ -18,14 +18,17 @@
>> >  #include <linux/devfreq.h>
>> >  #include <linux/devfreq-event.h>
>> >  #include <linux/interrupt.h>
>> > +#include <linux/mfd/syscon.h>
>> >  #include <linux/module.h>
>> >  #include <linux/of.h>
>> >  #include <linux/platform_device.h>
>> >  #include <linux/pm_opp.h>
>> > +#include <linux/regmap.h>
>> >  #include <linux/regulator/consumer.h>
>> >  #include <linux/rwsem.h>
>> >  #include <linux/suspend.h>
>> >
>> > +#include <soc/rockchip/rk3399_grf.h>
>> >  #include <soc/rockchip/rockchip_sip.h>
>> >
>> >  struct dram_timing {
>> > @@ -69,8 +72,11 @@ struct rk3399_dmcfreq {
>> >       struct mutex lock;
>> >       struct dram_timing timing;
>> >       struct regulator *vdd_center;
>> > +     struct regmap *regmap_pmu;
>> >       unsigned long rate, target_rate;
>> >       unsigned long volt, target_volt;
>> > +     unsigned int odt_dis_freq;
>> > +     int odt_pd_arg0, odt_pd_arg1;
>> >  };
>> >
>> >  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *f=
req,
>> > @@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev,=
 unsigned long *freq,
>> >       struct dev_pm_opp *opp;
>> >       unsigned long old_clk_rate =3D dmcfreq->rate;
>> >       unsigned long target_volt, target_rate;
>> > +     struct arm_smccc_res res;
>> > +     int dram_flag;
>> >       int err;
>> >
>> >       opp =3D devfreq_recommended_opp(dev, freq, flags);
>> > @@ -95,6 +103,15 @@ static int rk3399_dmcfreq_target(struct device *de=
v, unsigned long *freq,
>> >
>> >       mutex_lock(&dmcfreq->lock);
>> >
>> > +     dram_flag =3D 0;
>>
>> Also, if dram_flag is 0, it mean that disable ODT frequency?
>
> Yes, not a good name, maybe I should just rename it to odt_enable to
> be more clear.
>
>> If it's right, you better to define the precise variables as following
>> instead of just integer(0 or 1).
>> For example,
>> - ROCKCHIP_SIP_DRAM_FREQ_ENABLE
>> - ROCKCHIP_SIP_DRAM_FREQ_DISABLE
>>
>> > +     if (target_rate >=3D dmcfreq->odt_dis_freq)
>> > +             dram_flag =3D 1;
>> > +
>> > +     arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
>> > +                   dmcfreq->odt_pd_arg1,
>> > +                   ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
>> > +                   dram_flag, 0, 0, 0, &res);
>> > +
>>
>> This operation is special for only rk3399_dmc. It is difficult
>> to understand what to do. I recommend you better to add the detailed com=
ment
>> with code.
>
> Will do.
>
>>
>> >       /*
>> >        * If frequency scaling from low to high, adjust voltage first.
>> >        * If frequency scaling from high to low, adjust frequency first=
.
>> > @@ -294,11 +311,13 @@ static int rk3399_dmcfreq_probe(struct platform_=
device *pdev)
>> >  {
>> >       struct arm_smccc_res res;
>> >       struct device *dev =3D &pdev->dev;
>> > -     struct device_node *np =3D pdev->dev.of_node;
>> > +     struct device_node *np =3D pdev->dev.of_node, *node;
>> >       struct rk3399_dmcfreq *data;
>> >       int ret, index, size;
>> >       uint32_t *timing;
>> >       struct dev_pm_opp *opp;
>> > +     u32 ddr_type;
>> > +     u32 val;
>> >
>> >       data =3D devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KE=
RNEL);
>> >       if (!data)
>> > @@ -334,6 +353,29 @@ static int rk3399_dmcfreq_probe(struct platform_d=
evice *pdev)
>> >               return ret;
>> >       }
>> >
>> > +     /* Try to find the optional reference to the pmu syscon */
>> > +     node =3D of_parse_phandle(np, "rockchip,pmu", 0);
>> > +     if (node) {
>> > +             data->regmap_pmu =3D syscon_node_to_regmap(node);
>> > +             if (IS_ERR(data->regmap_pmu))
>> > +                     return PTR_ERR(data->regmap_pmu);
>> > +     }
>> > +
>> > +     /* Get DDR type */
>> > +     regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
>> > +     ddr_type =3D (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
>> > +                 RK3399_PMUGRF_DDRTYPE_MASK;
>> > +
>> > +     /* Get the odt_dis_freq parameter in function of the DDR type */
>> > +     if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_DDR3)
>> > +             data->odt_dis_freq =3D data->timing.ddr3_odt_dis_freq;
>> > +     else if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR3)
>> > +             data->odt_dis_freq =3D data->timing.lpddr3_odt_dis_freq;
>> > +     else if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR4)
>> > +             data->odt_dis_freq =3D data->timing.lpddr4_odt_dis_freq;
>> > +     else
>> > +             return -EINVAL;
>> > +
>>
>> how about using 'switch' statement?
>>
>
> Ok
>
>> >       /*
>> >        * Get dram timing and pass it to arm trust firmware,
>> >        * the dram drvier in arm trust firmware will get these
>> > @@ -358,6 +400,12 @@ static int rk3399_dmcfreq_probe(struct platform_d=
evice *pdev)
>> >                     ROCKCHIP_SIP_CONFIG_DRAM_INIT,
>> >                     0, 0, 0, 0, &res);
>> >
>> > +     data->odt_pd_arg0 =3D (data->timing.sr_idle & 0xff) |
>> > +                         ((data->timing.sr_mc_gate_idle & 0xff) << 8)=
 |
>> > +                         ((data->timing.standby_idle & 0xffff) << 16)=
;
>> > +     data->odt_pd_arg1 =3D (data->timing.pd_idle & 0xfff) |
>> > +                         ((data->timing.srpd_lite_idle & 0xfff) << 16=
);
>> > +
>>
>> odt_pd_arg0 and odt_pd_arg1 might be used for disabling/enabling the ODT=
 frequency.
>> As I commented, it depend on only rk3399_dmc. You better to add detailed=
 comment.
>>
>
> Ok
>
>> And I prefer to define the XXX_SHIFT/XXX_MASK definition instead of
>> using 8/16/0xff/0xffff for the readability.
>>
>
> I tried to add the XXX_SHIFT/XXX_MASK definitions and IMHO the
> readability is worst if I use a maximum line length of 80 characters.
> These masks are only used here, let me try to convince you by adding a
> good doc in the next version and if you still prefer I add the
> definition I'll do.

If you add the some description and it would be only used on here,
I don't force to add some definition such as _SHIFT, _MASK as you suggested=
.

>
>> >       /*
>> >        * We add a devfreq driver to our parent since it has a device t=
ree node
>> >        * with operating points.
>> > diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchi=
p/rockchip_sip.h
>> > index 7e28092c4d3d..ad9482c56797 100644
>> > --- a/include/soc/rockchip/rockchip_sip.h
>> > +++ b/include/soc/rockchip/rockchip_sip.h
>> > @@ -23,5 +23,6 @@
>> >  #define ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE    0x05
>> >  #define ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ     0x06
>> >  #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM   0x07
>> > +#define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD  0x08
>> >
>> >  #endif
>> >
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> Cheers,
>  Enric



--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B7CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD764208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 10:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3V98JYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD764208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeFPKPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 06:15:49 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39338 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeFPKPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 06:15:46 -0400
Received: by mail-qk0-f193.google.com with SMTP id g14-v6so7011095qkm.6;
        Sat, 16 Jun 2018 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FZku7X9v+wWiVQCVdRC6vByE4zxw3IpMMVr+m0KV9jA=;
        b=f3V98JYQmufi9rT8d5yP4ckNZQX/bEl2aa4GipteOHPvzkEiDlSpnijPk7MSipj1EL
         NBQPX70EFS1ic0vHjjPy0hNXzYE3bAQAalu9Ojk3wqVSbaRB4adMyZUetCR0HgNel8V0
         6Ma6fNMvwuElkDBCEoUxoqGie0OovEqiWlnvDeQJE8sGYsprZoMTi5mkDupOqT7VYPzc
         Tjv5Q1LoKKhgFdeH1RHsfVGWoIsyyqMW5QAECL7zs4IHG7gitDHV2yZCv+6NZR0CCzkT
         XiUt+wjRun/fE8efWrKQEiqfastYyrO2hwlhNxj5Cbh+vGG2oXE4HGMj/P5VP/wzaKRc
         kzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FZku7X9v+wWiVQCVdRC6vByE4zxw3IpMMVr+m0KV9jA=;
        b=irHTS2zAIZd5AlJkI3l43Vgu5LPuZfFqxdNl7vfleZT5s5AMtZBeXhYKrrCSvIw/cf
         3uurF3wpta5kdGB9iKb3uSDV6knmNT/1KFeskIaoNqEp0h8yQR3MiuQTMgwOhGGzAvFu
         OhCmDxd0kiFnQHlE/RJ4lsCkgyosXUCLvw1SnR39EOoeqpe34ZeleoReC2HdsIvUxH4+
         Pzu0Aelbg4IxenZserrLYDgwPaYa8fzZEps+kNYEDmSIVq6z3wTvyT5oRV88nMeKKweK
         1w9Lr39bLGnWSQHGMNQss9vGJ5zduLARAdjJ5yyu8VtAR7/ZAGFiyFR/YMqPG2PksKQA
         cumg==
X-Gm-Message-State: APt69E1z8BfojBFKXCiVaaw17qDL+wqsQiIKdJmMt2DW1rB6cRL2RVEP
        jm7NNt88MdDkFN5i0CsovifOABnIIwSoH6tnyZs=
X-Google-Smtp-Source: ADUXVKKtwp28JTmCzUBi7gps53kWNRGwUgd0F1y75shDrRAAGxIESgWsYi48odhJoLgExfE/B6DylLXK4JiFfA3TTsA=
X-Received: by 2002:a37:ba47:: with SMTP id k68-v6mr4224521qkf.105.1529144145967;
 Sat, 16 Jun 2018 03:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <CGME20180514211840epcas3p41708e430bc22d7e61e8b894b12a083f9@epcas3p4.samsung.com>
 <20180514211610.26618-4-enric.balletbo@collabora.com> <5AFA0B94.4000100@samsung.com>
In-Reply-To: <5AFA0B94.4000100@samsung.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Sat, 16 Jun 2018 12:15:34 +0200
Message-ID: <CAFqH_51jDy6hvwTtVQf52OZ2QFwAACzH8bh2bUZdxAnvKqM6=A@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] devfreq: rk3399_dmc: Pass ODT and auto power
 down parameters to TF-A.
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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

Hi Chanwoo,

I'll send a new version soon, just wanted to ask some questions here. See b=
elow.

Missatge de Chanwoo Choi <cw00.choi@samsung.com> del dia dt., 15 de
maig 2018 a les 0:21:
>
> Hi,
>
> On 2018=EB=85=84 05=EC=9B=94 15=EC=9D=BC 06:16, Enric Balletbo i Serra wr=
ote:
> > Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
> > on-die termination (ODT) and auto power down parameters from kernel,
> > this patch adds the functionality to do this. Also, if DDR clock
> > frequency is lower than the on-die termination (ODT) disable frequency
> > this driver should disable the DDR ODT.
>
> I have a question.
> 'disable frequency' is the same meaning of 'disable the DDR ODT'?
>

Yes, the DT defines an odt_dis_freq parameter, when the DDR frequency
is less than the value in this parameter we disable the ODT on the
DRAM.

> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  drivers/devfreq/rk3399_dmc.c        | 50 ++++++++++++++++++++++++++++-
> >  include/soc/rockchip/rockchip_sip.h |  1 +
> >  2 files changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.=
c
> > index d5c03e5abe13..cc1bbca3fb15 100644
> > --- a/drivers/devfreq/rk3399_dmc.c
> > +++ b/drivers/devfreq/rk3399_dmc.c
> > @@ -18,14 +18,17 @@
> >  #include <linux/devfreq.h>
> >  #include <linux/devfreq-event.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_opp.h>
> > +#include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/suspend.h>
> >
> > +#include <soc/rockchip/rk3399_grf.h>
> >  #include <soc/rockchip/rockchip_sip.h>
> >
> >  struct dram_timing {
> > @@ -69,8 +72,11 @@ struct rk3399_dmcfreq {
> >       struct mutex lock;
> >       struct dram_timing timing;
> >       struct regulator *vdd_center;
> > +     struct regmap *regmap_pmu;
> >       unsigned long rate, target_rate;
> >       unsigned long volt, target_volt;
> > +     unsigned int odt_dis_freq;
> > +     int odt_pd_arg0, odt_pd_arg1;
> >  };
> >
> >  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *fr=
eq,
> > @@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev, =
unsigned long *freq,
> >       struct dev_pm_opp *opp;
> >       unsigned long old_clk_rate =3D dmcfreq->rate;
> >       unsigned long target_volt, target_rate;
> > +     struct arm_smccc_res res;
> > +     int dram_flag;
> >       int err;
> >
> >       opp =3D devfreq_recommended_opp(dev, freq, flags);
> > @@ -95,6 +103,15 @@ static int rk3399_dmcfreq_target(struct device *dev=
, unsigned long *freq,
> >
> >       mutex_lock(&dmcfreq->lock);
> >
> > +     dram_flag =3D 0;
>
> Also, if dram_flag is 0, it mean that disable ODT frequency?

Yes, not a good name, maybe I should just rename it to odt_enable to
be more clear.

> If it's right, you better to define the precise variables as following
> instead of just integer(0 or 1).
> For example,
> - ROCKCHIP_SIP_DRAM_FREQ_ENABLE
> - ROCKCHIP_SIP_DRAM_FREQ_DISABLE
>
> > +     if (target_rate >=3D dmcfreq->odt_dis_freq)
> > +             dram_flag =3D 1;
> > +
> > +     arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> > +                   dmcfreq->odt_pd_arg1,
> > +                   ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> > +                   dram_flag, 0, 0, 0, &res);
> > +
>
> This operation is special for only rk3399_dmc. It is difficult
> to understand what to do. I recommend you better to add the detailed comm=
ent
> with code.

Will do.

>
> >       /*
> >        * If frequency scaling from low to high, adjust voltage first.
> >        * If frequency scaling from high to low, adjust frequency first.
> > @@ -294,11 +311,13 @@ static int rk3399_dmcfreq_probe(struct platform_d=
evice *pdev)
> >  {
> >       struct arm_smccc_res res;
> >       struct device *dev =3D &pdev->dev;
> > -     struct device_node *np =3D pdev->dev.of_node;
> > +     struct device_node *np =3D pdev->dev.of_node, *node;
> >       struct rk3399_dmcfreq *data;
> >       int ret, index, size;
> >       uint32_t *timing;
> >       struct dev_pm_opp *opp;
> > +     u32 ddr_type;
> > +     u32 val;
> >
> >       data =3D devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KER=
NEL);
> >       if (!data)
> > @@ -334,6 +353,29 @@ static int rk3399_dmcfreq_probe(struct platform_de=
vice *pdev)
> >               return ret;
> >       }
> >
> > +     /* Try to find the optional reference to the pmu syscon */
> > +     node =3D of_parse_phandle(np, "rockchip,pmu", 0);
> > +     if (node) {
> > +             data->regmap_pmu =3D syscon_node_to_regmap(node);
> > +             if (IS_ERR(data->regmap_pmu))
> > +                     return PTR_ERR(data->regmap_pmu);
> > +     }
> > +
> > +     /* Get DDR type */
> > +     regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> > +     ddr_type =3D (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> > +                 RK3399_PMUGRF_DDRTYPE_MASK;
> > +
> > +     /* Get the odt_dis_freq parameter in function of the DDR type */
> > +     if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_DDR3)
> > +             data->odt_dis_freq =3D data->timing.ddr3_odt_dis_freq;
> > +     else if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR3)
> > +             data->odt_dis_freq =3D data->timing.lpddr3_odt_dis_freq;
> > +     else if (ddr_type =3D=3D RK3399_PMUGRF_DDRTYPE_LPDDR4)
> > +             data->odt_dis_freq =3D data->timing.lpddr4_odt_dis_freq;
> > +     else
> > +             return -EINVAL;
> > +
>
> how about using 'switch' statement?
>

Ok

> >       /*
> >        * Get dram timing and pass it to arm trust firmware,
> >        * the dram drvier in arm trust firmware will get these
> > @@ -358,6 +400,12 @@ static int rk3399_dmcfreq_probe(struct platform_de=
vice *pdev)
> >                     ROCKCHIP_SIP_CONFIG_DRAM_INIT,
> >                     0, 0, 0, 0, &res);
> >
> > +     data->odt_pd_arg0 =3D (data->timing.sr_idle & 0xff) |
> > +                         ((data->timing.sr_mc_gate_idle & 0xff) << 8) =
|
> > +                         ((data->timing.standby_idle & 0xffff) << 16);
> > +     data->odt_pd_arg1 =3D (data->timing.pd_idle & 0xfff) |
> > +                         ((data->timing.srpd_lite_idle & 0xfff) << 16)=
;
> > +
>
> odt_pd_arg0 and odt_pd_arg1 might be used for disabling/enabling the ODT =
frequency.
> As I commented, it depend on only rk3399_dmc. You better to add detailed =
comment.
>

Ok

> And I prefer to define the XXX_SHIFT/XXX_MASK definition instead of
> using 8/16/0xff/0xffff for the readability.
>

I tried to add the XXX_SHIFT/XXX_MASK definitions and IMHO the
readability is worst if I use a maximum line length of 80 characters.
These masks are only used here, let me try to convince you by adding a
good doc in the next version and if you still prefer I add the
definition I'll do.

> >       /*
> >        * We add a devfreq driver to our parent since it has a device tr=
ee node
> >        * with operating points.
> > diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip=
/rockchip_sip.h
> > index 7e28092c4d3d..ad9482c56797 100644
> > --- a/include/soc/rockchip/rockchip_sip.h
> > +++ b/include/soc/rockchip/rockchip_sip.h
> > @@ -23,5 +23,6 @@
> >  #define ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE    0x05
> >  #define ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ     0x06
> >  #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM   0x07
> > +#define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD  0x08
> >
> >  #endif
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
Cheers,
 Enric

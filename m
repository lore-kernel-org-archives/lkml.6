Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBC520675
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4MLRlLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBUSyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:54:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34590 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:54:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so31895255wrg.1;
        Thu, 21 Feb 2019 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2mhlSVubTCiN6wHDeDsEGEqAqmH7JyqzQlrHqj6oV4=;
        b=B4MLRlLkPAiC4gWaroEaiTyB+rK9uwHs/negxXKPFfbYbC9HZbzpIIzyodTgr984SR
         puWQkHPI4NLxOO5V39j6XCOmB1wGX2y0l7+k7qNcRQqSRIQI8IX1UGHcC38jO+spu1s6
         +aP1KkLiOxIL2NtvCvgGmS1t/d8JSfzZjQN0X/mX0oZAhQ/Fgy9ruVO/vVCgI7TNXYU1
         v56SR6jPw3wd7OUL6vlJyTYGGLZK3cO4gL3n3Ej1Wm/aQkrdv5A6HxRxcjX0cv8w9hlB
         ql0117jrQjNaGHY6HRkuqT2dgmTo4LidPxHZ/+h317db1FP5ZhsgyB4GrkEt6rcv0/a4
         O6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2mhlSVubTCiN6wHDeDsEGEqAqmH7JyqzQlrHqj6oV4=;
        b=Z8E+IuI8sP9THbsGzITXGawlsyYDoxF47N0gyI0HMDu++H6bJ5vk4cuYopPkWAcePI
         12oFYhaXfgHcFF0nydUnWhSb0NUMeZqy77/MVmZ+KWwvzQTBgL0hgTHik73Hbbhmf6ii
         KCDjFQ49SqTILNjcOdA5L8CTVKMZ+20lwHZAQm7K6l6ID0GIiSLqhUeZKs9biy+rV2oc
         9/9ZpP1S0moiMjhniugRK3aq2Uyz4MS8DBxE0rkB7U/G4qid3cCVzrtyGmiCCZtn3MvU
         kTLKVrfVq2ngpHkpQIRzP5YYA2Ju/QJ0A2YXRYbcoCPbObZmssqwBiOuwfc8mC7QrBnp
         Cr2w==
X-Gm-Message-State: AHQUAuaTETp4XB8U6YSITQlzAyA7PKE7Gxi6cNZnLZGM3dOG9pxoB4lm
        P0288eZRH480NdA9q+AkRkTAKmSxhrLlfGeeVfc=
X-Google-Smtp-Source: AHgI3IbjXGoyDXKTNsbmii95WtBF6HDk+6p5zr5iVL29PzymT7fu2bQ01wm9J+i5jB+M85aGAc1+fIJ0LgOdIlaQyWI=
X-Received: by 2002:adf:dd43:: with SMTP id u3mr28082820wrm.259.1550775243513;
 Thu, 21 Feb 2019 10:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
 <20190218191141.3729-13-andrew.smirnov@gmail.com> <20190221005717.GC31479@localhost.localdomain>
In-Reply-To: <20190221005717.GC31479@localhost.localdomain>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 21 Feb 2019 10:53:52 -0800
Message-ID: <CAHQ1cqHnuzPuaVKHRTzEhj=H7Rd0+kBA4p5iXnvbT2=DzLZMVQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] thermal: qoriq: Add support for multiple thremal sites
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 4:57 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Mon, Feb 18, 2019 at 11:11:41AM -0800, Andrey Smirnov wrote:
> > TMU IP block provides temerature measurement for up to 16 sites,
> > current implementation of the driver however hardcodes a single site
> > ID. Change the code so it would be possible to reference multiple
> > sites as indivudial sensors and get their temperature readings.
>
> small typo: indivudial/individual.
>
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 132 ++++++++++++++++++++------------
> >  1 file changed, 84 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index f746c62789b0..6cc6e6b36fb0 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -24,6 +24,8 @@
> >  #define TMR_DISABLE  0x0
> >  #define TMR_ME               0x80000000
> >  #define TMR_ALPF     0x0c000000
> > +#define TMR_ALPF_MASK        GENMASK(27, 26)
> > +
> >
> >  #define REGS_TMTMIR  0x008   /* Temperature measurement interval Register */
> >  #define TMTMIR_DEFAULT       0x0000000f
> > @@ -41,21 +43,32 @@
> >  #define REGS_TTRnCR(n)       (0xf10 + 4 * (n)) /* Temperature Range n
> >                                          * Control Register
> >                                          */
> > +struct qoriq_tmu_sensor {
> > +     struct thermal_zone_device *tz;
> > +     int id;
> > +};
> > +
> >  /*
> >   * Thermal zone data
> >   */
> >  struct qoriq_tmu_data {
> >       struct thermal_zone_device *tz;
> >       struct regmap *regmap;
> > -     int sensor_id;
> > +     struct qoriq_tmu_sensor sensors[SITES_MAX];
> >  };
> >
> > +static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_tmu_sensor *s)
> > +{
> > +     return container_of(s, struct qoriq_tmu_data, sensors[s->id]);
> > +}
> > +
> >  static int tmu_get_temp(void *p, int *temp)
> >  {
> >       u32 val;
> > -     struct qoriq_tmu_data *data = p;
> > +     struct qoriq_tmu_sensor *s = p;
> > +     struct qoriq_tmu_data *data = qoriq_sensor_to_data(s);
> >
> > -     regmap_read(data->regmap, REGS_TRITSR(data->sensor_id), &val);
> > +     regmap_read(data->regmap, REGS_TRITSR(s->id), &val);
> >       if (!(val & TRITSR_V))
> >               return -ENODATA;
> >
> > @@ -63,38 +76,86 @@ static int tmu_get_temp(void *p, int *temp)
> >       return 0;
> >  }
> >
> > -static int qoriq_tmu_get_sensor_id(void)
> > +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> > +     .get_temp = tmu_get_temp,
> > +};
> > +
> > +static int qoriq_tmu_populate_sensors(struct device *dev,
> > +                                   struct qoriq_tmu_data *data)
> >  {
> > -     int ret, id;
> > +     int ret, id, i, count = 0;
> >       struct of_phandle_args sensor_specs;
> >       struct device_node *np, *sensor_np;
> > +     struct qoriq_tmu_sensor *s;
> >
> >       np = of_find_node_by_name(NULL, "thermal-zones");
> >       if (!np)
> >               return -ENODEV;
> >
> > -     sensor_np = of_get_next_child(np, NULL);
> > -     ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> > -                     "#thermal-sensor-cells",
> > -                     0, &sensor_specs);
> > -     if (ret) {
> > -             id = ret;
> > -             goto out;
> > +     for_each_child_of_node(np, sensor_np) {
> > +             u16 msite;
> > +
> > +             ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> > +                                              "#thermal-sensor-cells",
> > +                                              0, &sensor_specs);
> > +             if (ret)
> > +                     break;
> > +
> > +             if (sensor_specs.args_count != 1) {
> > +                     pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
> > +                            sensor_specs.np, sensor_specs.args_count);
> > +                     ret = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             id = sensor_specs.args[0];
> > +             if (id >= SITES_MAX) {
> > +                     ret = -EINVAL;
> > +                     dev_err(dev, "Sensor id %d is out of range\n", id);
> > +                     break;
> > +             }
> > +
> > +             msite = BIT(15 - id);
> > +             /* Enable monitoring of that particular sensor*/
> > +             regmap_update_bits(data->regmap, REGS_TMR, msite, msite);
> > +
> > +             s = &data->sensors[id];
> > +             s->id = id;
> > +             count++;
>
> Not sure I follow why you need to bother about thermal-sensor-cells..
>

devm_thermal_zone_of_sensor_register() will call
.get_temp()/tmu_get_temp(), so all present sensors need to be enabled
before that to avoid returning bogus data. The first loop going over
thermal-sensor-cells does exactly that as well as count # of sensors
present to avoid having to loop over all 16 possible sensors in the
code that follow.

Given how there's already a patch adding multiple sensors support, not
a lot of this patch will probably survive, so we can pretty much
disregard it.

Thanks,
Andrey Smirnov

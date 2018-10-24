Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A740AC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568442054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 12:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYh8/o40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568442054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJXVUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeJXVUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:20:48 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE432064A;
        Wed, 24 Oct 2018 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540385567;
        bh=yQEea3I4hlQTpaC7EFBIJrux3DpD+kCEu2DlysUhMQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYh8/o40zFZQk8ye4vZ/O605FMWaG/p0N9OM8VycOE84l3rx2FviZVTanNiZtJrSM
         Dc5gMir03el9oRCLeSofQpdytmai4wSuj7lqmVFiXwhFxjTN8JWwXTgYzLPsRXf9xf
         a0Ke85JABxE3s/JeCJWZBcdQ+wn28z77KrjxbcMc=
Received: by mail-qk1-f180.google.com with SMTP id x11-v6so3019885qkl.7;
        Wed, 24 Oct 2018 05:52:47 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJwtMXe/DBI/OO+iluuwN6lj0+ddAkvmANRit7ZgfB53Aqgxm83
        VjDPi8JuZAfQdnf7aW2pG3tGXuogWeFDVxHC1A==
X-Google-Smtp-Source: AJdET5fR8asviMH/C/JOddAJHC/EmXT82eR3qDpeVnIvs/1tZh0cJL1j4/B3WCQMy3u+rL+tBfxIguFgrgZMG7llPQk=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr2173314qkb.326.1540385566748;
 Wed, 24 Oct 2018 05:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180927024204.17314-1-andy.tang@nxp.com> <3d1f8304-9005-23f3-2e0e-ef9c962c9f6e@linaro.org>
 <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <cf157e9f-a4cb-6d7d-f51d-8b9d91f3335c@linaro.org> <DB5PR0401MB2213E291AC455D61ED15AF4AF3FE0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <77993e69-db55-a2a0-799f-5225d5ffb010@linaro.org>
In-Reply-To: <77993e69-db55-a2a0-799f-5225d5ffb010@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Oct 2018 07:52:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJMDry8vgpBTMWeChyVdjxt_YWrrjWXhf=QBNh6apAE5w@mail.gmail.com>
Message-ID: <CAL_JsqJMDry8vgpBTMWeChyVdjxt_YWrrjWXhf=QBNh6apAE5w@mail.gmail.com>
Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Yuantian Tang <andy.tang@nxp.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 6:21 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 16/10/2018 05:01, Andy Tang wrote:
> > Hi Daniel,
> >
> > Please see my reply inline.
> >
> >> -----Original Message-----
>
> [ ... ]
>
> >> I'm proposing to move struct qoriq_tmu_site_regs inside the struct
> >> qoriq_sensor.
> >>
> >>
> >> We end up with:
> >>
> >> struct qoriq_sensor {
> >>    struct thermal_zone_device *tzd;
> >>    struct struct qoriq_tmu_site_regs *regs;
> >>    struct qoriq_tmu_data *qdata;
> >>    int id;
> >> };
> > [Andy] I see your point. If I add a *regs member to qoriq_sensor struct, then I can speed up the access to the register.
> > But I don't think it is better. Currently I can access sensor register by: qdata->regs->site[qsensor->id].
> > The whole point here is we can't MOVE struct qoriq_tmu_site_regs to the struct qoriq_sensor. We can only COPY
> > it to struct qoriq_sensor.
> >
> > This is the TMU module memory map:
> > struct qoriq_tmu_regs {
> > ......
> >         u32 tscfgr;             /* Sensor Configuration Register */
> >         u8 res4[0x78];
> >         struct qoriq_tmu_site_regs site[SITES_MAX];
> >         u8 res5[0x9f8];
> >         u32 ipbrr0;             /* IP Block Revision Register 0 */
> >         u32 ipbrr1;             /* IP Block Revision Register 1 */
> > .......}
> > struct qoriq_tmu_site_regs site[SITES_MAX] is part of the memory
> > map.
> > It can't be removed or we have to define a similar struct to fill it up.
>
> Mmh, I see. Thanks for the clarification.
>
> A consolidation around this would have been nice but it means a DT
> change (reduce the size of the map). So I guess we can leave it as it is.
>
>
> >>>>> - if (sensor_specs.args_count >= 1) {
> >>>>> -         id = sensor_specs.args[0];
> >>>>> -         WARN(sensor_specs.args_count > 1,
> >>>>> -                         "%s: too many cells in sensor specifier %d\n",
> >>>>> -                         sensor_specs.np->name,
> >> sensor_specs.args_count);
> >>>>> - } else {
> >>>>> -         id = 0;
> >>>>> +         if (id > SITES_MAX)
> >>>>> +                 return -EINVAL;
> >>>>> +
> >>>>> +         qdata->sensor[id] = devm_kzalloc(&pdev->dev,
> >>>>> +                         sizeof(struct qoriq_sensor), GFP_KERNEL);
> >>>>> +         if (!qdata->sensor[id])
> >>>>> +                 return -ENOMEM;
> >>>>> +
> >>>>> +         qdata->sensor[id]->id = id;
> >>>>> +         qdata->sensor[id]->qdata = qdata;
> >>>>> +
> >>>>> +         qdata->sensor[id]->tzd =
> >>>> devm_thermal_zone_of_sensor_register(
> >>>>> +                         &pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
> >>>>> +
> >>>>> +         if (IS_ERR(qdata->sensor[id]->tzd)) {
> >>>>> +                 ret = PTR_ERR(qdata->sensor[id]->tzd);
> >>>>> +                 dev_err(&pdev->dev,
> >>>>> +                         "Failed to register thermal zone device.\n");
> >>>>> +                 return -ENODEV;
> >>>>> +         }
> >>>>> +
> >>>>> +         sites |= 0x1 << (15 - id);
> >>>>
> >>>> The current code is reading the DT in order to get the sensor id and
> >>>> initialize it. IOW, the DT gives the sensors to use.
> >>>>
> >>>> IMO, it would be more self contained if the driver initializes all
> >>>> the sensors without taking care of the DT and let the of- code to do
> >>>> the binding when the thermal zone, no ?
> >>> [Andy] could you please explain more about this way? I am not sure how
> >> to implement it.
> >>> But one thing is for sure: we must get the sensor IDs explicitly so
> >>> that we can enable them by the following command:  tmu_write(qdata,
> >>> sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);
> >>
> >> What I meant is about code separation between the driver itself and the
> >> of-thermal code.
> >>
> >> The code above re-inspect the DT to find out the sensor ids in order to
> >> enable them and somehow this is not wrong but breaks the self
> >> encapsulation of the driver. I was suggesting if it isn't possible to enable all
> >> the sensors without taking care of digging into the DT.
> >
> > [Andy] I don't want to re-parse the DT here too. But I have to.
> > This driver will be used by all our SOCs with different sensor IDs and number.
> > For example: there are 2 sensors on ls1088a platform with ID 0 and 1.
> > While on ls1043a there are 6 sensors with ID 0, 1, 2, 3, 4, 5.
> > If we don't scan the DT we would not know how many sensors it is and what are the sensor's IDs,
> > unless we hardcode it in driver.
>
> Yes, you are not the only one in this situation IMO and the drivers
> supporting multiple sensors are increasing, so this will repeat again
> and again.
>
> That could be hardcoded in the driver by using the compatible string but
> it will be nicer if we can fix that in the DT.
>
> [Cc'ing Rob]
>
> What is missing is a description of the sensors id in the temperature
> device node. We have the <thermal-sensor-cells> with 0 or 1 telling if
> there is one or several sensors but we can't specify which sensor ids we
> have. The only alternative is to parse the thermal zones to found out
> which sensors are in use and use them to initialize the driver, an
> approach which breaks the self-encapsulation: the of-thermal framework
> is the one in charge of doing the link between the thermal zone and a
> sensor id.
>
> Is it acceptable to add the list of the sensors id in the temp device
> node, so the driver can initialize these sensors without parsing the
> thermal zone in the DT ?

In other cases like this, we've usually avoided having a property as
the data is already there in DT. Granted, it's not in the most
convenient form. We already have an iterator to iterate on all
occurrences of a property in the tree (or subtree). Sure, it's not
really that efficient, but does it matter? The question that comes up
is do you have sensors not defined in DT?

Rob

Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC68C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F010F2190C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="kM4qv4EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfBQQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:37:48 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35224 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBQQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:37:48 -0500
Received: by mail-yw1-f67.google.com with SMTP id s204so5577344ywg.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcfVD+Z2d39fCjnzHaFw0lRjGDD2+KJIc2xzhByjOuc=;
        b=kM4qv4EPjUjMtCDzO/CWhMMDa8HLkcdhNO94jYwpeqfGn3QsdjmDc85nOz37CO3Oo9
         L+NJZ6KXp8nTIvFrNHUJqE98+CcPWkpEpf1/p9afOWyWwX6b2Ji4yxaaM5KEqEE37Vom
         K5AOCsgQ1/AlLpB/iZgaq3tYZ6SvSupwbGlEUMy+7cdPw6cbGdpTFRa0AMF00YsWlefu
         Y2ZUjxCcCW/+JZR1Zw8C6mXZ8+3/CtK9aQmonXdgZrZRHtU6HiySNEOa8VAZJ8pQeC7p
         nLt4ft92Q5TA6/A+c0cQhuI+OaK7IJ1WKTWlYD+p54cY7tzupTqrQwBJSN44j7Lwdp3p
         bIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcfVD+Z2d39fCjnzHaFw0lRjGDD2+KJIc2xzhByjOuc=;
        b=ICoegdoxShOV+g06IwofJvHY/ddm8c0bL2kLN7kdE9FGCsqqwJ22fvq75K07DUUTx6
         tP0YeJo5IvFEKZDNshLyV4UCQeWpvsZYJm+xw0rPhIdoMjfLGuq98nQXVgJVBRsJ2T2A
         DusEa6UIIi90UcZVtpNUpzPwu2L+cOYMvsJfIKPkdTBPodcb6W8HwY7mK/8enmFXIDJ+
         yWQQ7MfoNw+ls93aTflGQVf/gu5vz+J31XrmYXvHILyJU8MEwxg9mwaThJc6N7nd4dr8
         AHMBa6iy1MFoUhkTHRfwg53IF3DvlHfg+J/XsoGZwzzAnV+dSkW+T4JhYzoKNvvJJemy
         et3g==
X-Gm-Message-State: AHQUAuZnB/0KDYi2/O72BWrWwpvUpVk/VybZMWbEBHWhotd2pzmcU91F
        YBuOq2pFmG5NiUbzMQTmqwV9n+vJCRMYp6beBL1ANw==
X-Google-Smtp-Source: AHgI3Ia+fOvrOYqZZ1BCxWX9LPEXQiildhtsERLX/KCt9y1g0A/Sm1DbAR2gXZKmM0RPPNb1WIyzSCaCKWIpWMzFC28=
X-Received: by 2002:a81:35cc:: with SMTP id c195mr15806758ywa.18.1550421466278;
 Sun, 17 Feb 2019 08:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20190212010143.3729-1-virendra.kakade@ni.com> <20190212010143.3729-3-virendra.kakade@ni.com>
 <20190214093445.GF13737@dell>
In-Reply-To: <20190214093445.GF13737@dell>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Sun, 17 Feb 2019 08:37:35 -0800
Message-ID: <CAAtXAHemEOOKOmQGT5StDt-Jxn0RUOoc9L-breMNURhd8=9q=Q@mail.gmail.com>
Subject: Re: [RFC 2/6] mfd: Support for Ettus Research E31x devices PMU
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Virendra Kakade <virendra.kakade@ni.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

thanks for your feedback!

On Thu, Feb 14, 2019 at 1:34 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 11 Feb 2019, Virendra Kakade wrote:
>
> > Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> > ---
> >  drivers/mfd/Kconfig          |  7 +++
> >  drivers/mfd/Makefile         |  2 +-
> >  drivers/mfd/e31x-pmu.c       | 89 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/e31x-pmu.h | 20 ++++++++
> >  4 files changed, 117 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/mfd/e31x-pmu.c
> >  create mode 100644 include/linux/mfd/e31x-pmu.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 8c5dfdce4326..6c4c0747f2a5 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1916,4 +1916,11 @@ config RAVE_SP_CORE
> >         device found on several devices in RAVE line of hardware.
> >
> >  endmenu
> > +
> > +config MFD_E31X_PMU
> > +     tristate "E31X PMU driver"
> > +     select MFD_SYSCON
> > +     help
> > +      Select this to get support for the Ettus Research E31x devices.
> > +
> >  endif
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 12980a4ad460..e37c2057134b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -241,4 +241,4 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
> >  obj-$(CONFIG_MFD_SC27XX_PMIC)        += sprd-sc27xx-spi.o
> >  obj-$(CONFIG_RAVE_SP_CORE)   += rave-sp.o
> >  obj-$(CONFIG_MFD_ROHM_BD718XX)       += rohm-bd718x7.o
> > -
> > +obj-$(CONFIG_MFD_E31X_PMU)      += e31x-pmu.o
> > diff --git a/drivers/mfd/e31x-pmu.c b/drivers/mfd/e31x-pmu.c
> > new file mode 100644
> > index 000000000000..383df68a538f
> > --- /dev/null
> > +++ b/drivers/mfd/e31x-pmu.c
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 National Instruments Corp
>
> This is out of date.
>
> '\n' here.
>
> > + * Author: Virendra Kakade<virendra.kakade@ni.com>
>
> You need a space after your name.
>
> > + * Ettus Research E31x PMU MFD driver
>
> Please expand PMU.
>
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/of_device.h>
> > +#include <linux/mfd/e31x-pmu.h>
> > +#include <linux/platform_device.h>
>
> Alphabetical.
>
> > +#define E31X_PMU_MISC_IRQ_MASK               BIT(8)
> > +#define E31X_PMU_MISC_IRQ_SHIFT              8
> > +#define E31X_PMU_MISC_VERSION_MIN_MASK       GENMASK(3, 0)
> > +#define E31X_PMU_MISC_VERSION_MIN_SHIFT      0
> > +#define E31X_PMU_MISC_VERSION_MAJ_MASK       GENMASK(7, 4)
> > +#define E31X_PMU_MISC_VERSION_MAJ_SHIFT      4
> > +
> > +struct e31x_pmu {
> > +     struct regmap *regmap;
> > +};
>
> A whole struct for one attribute?
>
> > +static int e31x_pmu_check_version(struct e31x_pmu *pmu)
> > +{
> > +     int timeout = 100;
>
> Where does 100 come from?
>
> > +     u32 misc, maj;
> > +     int err;
>
> 'ret' is more common.
>
> > +     /* we need to wait a bit for firmware to populate the fields */
>
> "a bit" ?
>
> What does the datasheet say?
>
> Please use proper grammar.  Capital letters.
>
> > +     while (timeout--) {
> > +             err = regmap_read(pmu->regmap, E31X_PMU_REG_MISC, &misc);
> > +             if (err)
> > +                     return err;
> > +             if (misc)
> > +                     break;
> > +
> > +     usleep_range(2500, 5000);
>
> Formatting.
>
> > +     }
> > +
> > +     /* only firmware versions above 2.0 are supported */
>
> "Only supports firmware version 2.0 and above"
>
> > +     maj = E31X_PMU_GET_FIELD(MISC_VERSION_MAJ, misc);
> > +     if (maj < 2)
> > +             return -ENOTSUPP;
>
> '\n' here.
>
> > +     return 0;
> > +}
> > +
> > +static int e31x_pmu_probe(struct platform_device *pdev)
> > +{
> > +     struct e31x_pmu *pmu;
> > +
> > +     pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
> > +     if (!pmu)
> > +             return -ENOMEM;
>
> '\n' here.
>
> > +     pmu->regmap = syscon_regmap_lookup_by_phandle(\
>
> Why are you storing regmap?

See my comment below.
>
> Just pass it directly to e31x_pmu_check_version().
>
> > +                     pdev->dev.of_node, "regmap");
> > +
>
> Remove this line.
>
> > +     if (IS_ERR(pmu->regmap))
> > +             return PTR_ERR(pmu->regmap);
>
> '\n' here.
>
> > +     if (e31x_pmu_check_version(pmu))
>
> Please split out the function from the if.
>
> Use a variable 'ret' to feed into and check that.
>
> > +             return -ENOTSUPP;
>
> '\n' here.
>
> > +     return devm_of_platform_populate(&pdev->dev);
> > +}
> > +
> > +static const struct of_device_id e31x_pmu_id[] = {
> > +     { .compatible = "ni,e31x-pmu" },
> > +     {},
> > +};
> > +
> > +static struct platform_driver e31x_pmu_driver = {
> > +     .driver = {
> > +     .name = "e31x-pmu",
> > +     .of_match_table = e31x_pmu_id,
>
> These 2 lines need indenting.
>
> > +     },
> > +     .probe = e31x_pmu_probe,
> > +};
> > +module_platform_driver(e31x_pmu_driver);
> > +
> > +MODULE_DESCRIPTION("E31x PMU driver");
> > +MODULE_AUTHOR("Virendra Kakade <virendra.kakade@ni.com>");
> > +MODULE_LICENSE("GPL");
>
> So the whole purpose of this driver is to do a version check.
>
> Seems like over-kill!
>
> Probably better to do the version check in an inline function stored
> in a header file, then call it from each of the children's .probe()
> function.

A bit of context here, this is based on an in-house driver that we had that does
a bunch of other stuff (e.g. it controls a flag on whether the device auto-boots
on power being plugged in etc.). These functions will use the regmap.

I had advised Virendra to submit a base version and follow up with patches
that would add these functions one by one as he figures out how to expose them
in a proper way to the kernel.

Cheers,
Moritz

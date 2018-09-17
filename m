Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D06C206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OWlXNib5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D06C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeIQJPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:15:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34206 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeIQJPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:15:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12-v6so9889960otl.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 20:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QUveiL6d+YItetet6E/pGkw8XajXleiO1G/rr8KS6RQ=;
        b=OWlXNib5bVvMxSFt55sNa9EdrUb5Ht82bD+QlFItcW3SwI4lra5o7e8gQFp1aAfeA2
         Y4FQ1eZgPw+lzzkAQacxdudKFHk+wFCPtS3scz/pvPaU0qYTwuBQsecLv0igqlGxpwQv
         zwn9CL0Va+xOPh12SsEh+1CILY0TGY8Jz8x7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUveiL6d+YItetet6E/pGkw8XajXleiO1G/rr8KS6RQ=;
        b=I/fPAukbt8egtnWusLC50rd+tHEPiyKeC8mCms76wtdIBnlK725cdV8mWs2ujITvMt
         iRPjWT46j0+tpQkL4b8dxFGcw0rp9Uhob7QxXL32LuelGflOvpYwFWlGL8YQshkAAyJC
         7Xwkx/U97odwvSm13274HCTgkGm81am55C4UgQ6uaMcddJ8MGmxSwDfGQIzBJ3DAyKNx
         b+HVdgyqe0Z35E3qYtppzjIYrbLfm2uJKnZe9+/A4DMId9+smALZqZzFNAO6Qe2vLXjy
         //jgv5R//ssFB2c6EUVXxajs9pdpt52cQB1f2fqTTXwGDGM+WAJ1RZGxmblGDvBe6JD3
         qjSg==
X-Gm-Message-State: APzg51AW2flJcjRafI32h++ZxGAT1v03ZUPVV28mdvO45drj797FfWU6
        ZxAcCSlS+eh+BXeuGKfoCkNTYP0u4H3HQI0kET+t+A==
X-Google-Smtp-Source: ANB0VdaIWBf3F+fg3FoeD0rx33pWV64bfy9+9xxNA0/MHL83rsb5BCipxdo8Ppxs6oZ2jFUogFal14i4ngJtxaIQ3KE=
X-Received: by 2002:a9d:7519:: with SMTP id r25-v6mr12033145otk.73.1537156216015;
 Sun, 16 Sep 2018 20:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c11:0:0:0:0:0 with HTTP; Sun, 16 Sep 2018 20:50:15
 -0700 (PDT)
In-Reply-To: <190f80d4-624b-a46a-c3a0-578a2dbb38b8@linaro.org>
References: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
 <1533819299-3401-4-git-send-email-srinath.mannam@broadcom.com> <190f80d4-624b-a46a-c3a0-578a2dbb38b8@linaro.org>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 17 Sep 2018 09:20:15 +0530
Message-ID: <CABe79T41+-JE=0m1L2dYcP1-izKxN_H7NAdSjwB52ym8we4_dA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] thermal: broadcom: Add Stingray thermal driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for your review comments.
I will address all your comments in next patch set.

Regards,
Srinath.

On Fri, Sep 14, 2018 at 7:50 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 09/08/2018 14:54, Srinath Mannam wrote:
>> From: Pramod Kumar <pramod.kumar@broadcom.com>
>>
>> Adds stingray thermal driver to monitor six
>> thermal zones temperature and trips at critical temperature.
>
> Hi Pramod,
>
> could you elaborate a bit more the description? As you are introducing a
> new driver it would be nice to give the sensor details.
>
>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>> ---
>>  drivers/thermal/Kconfig               |   3 +-
>>  drivers/thermal/broadcom/Kconfig      |   9 ++
>>  drivers/thermal/broadcom/Makefile     |   1 +
>>  drivers/thermal/broadcom/sr-thermal.c | 216 +++++++++++++++++++++++++++=
+++++++
>>  4 files changed, 228 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 8297988..26d39d4 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -416,7 +416,8 @@ config MTK_THERMAL
>>         controller present in Mediatek SoCs
>>
>>  menu "Broadcom thermal drivers"
>> -depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
>> +depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM_IPROC |=
| \
>> +             COMPILE_TEST
>>  source "drivers/thermal/broadcom/Kconfig"
>>  endmenu
>>
>> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom=
/Kconfig
>> index c106a15..dc9a9bd 100644
>> --- a/drivers/thermal/broadcom/Kconfig
>> +++ b/drivers/thermal/broadcom/Kconfig
>> @@ -22,3 +22,12 @@ config BCM_NS_THERMAL
>>         BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (De=
vice
>>         Management Unit) block with a thermal sensor that allows checkin=
g CPU
>>         temperature.
>> +
>> +config BCM_SR_THERMAL
>> +     tristate "Stingray thermal driver"
>> +     depends on ARCH_BCM_IPROC || COMPILE_TEST
>> +     default ARCH_BCM_IPROC
>> +     help
>> +       Support for the Stingray family of SoCs. Its different blocks li=
ke
>> +       iHost, CRMU and NITRO has thermal sensor that allows checking it=
s
>> +       temperature.
>> diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadco=
m/Makefile
>> index fae10ec..79df69e 100644
>> --- a/drivers/thermal/broadcom/Makefile
>> +++ b/drivers/thermal/broadcom/Makefile
>> @@ -1,3 +1,4 @@
>>  obj-$(CONFIG_BCM2835_THERMAL)                +=3D bcm2835_thermal.o
>>  obj-$(CONFIG_BRCMSTB_THERMAL)                +=3D brcmstb_thermal.o
>>  obj-$(CONFIG_BCM_NS_THERMAL)         +=3D ns-thermal.o
>> +obj-$(CONFIG_BCM_SR_THERMAL)         +=3D sr-thermal.o
>> diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/bro=
adcom/sr-thermal.c
>> new file mode 100644
>> index 0000000..909f80c
>> --- /dev/null
>> +++ b/drivers/thermal/broadcom/sr-thermal.c
>> @@ -0,0 +1,216 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 Broadcom
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/thermal.h>
>> +
>> +#define TMON_CRIT_TEMP          105000 /* temp in millidegree C */
>
> I suggest to move this in the DT?
>
>> +#define SR_TMON_MAX_LIST        6
>> +
>> +/*
>> + * In stingray thermal IO memory,
>> + * Total Number of available TMONs MASK is at offset 0
>> + * temperature registers BASE is at 4 byte offset.
>> + * Each TMON temperature register size is 4.
>> + */
>> +#define SR_TMON_TEMP_BASE(id)   ((id) * 0x4)
>> +
>> +static const char * const sr_tmon_names[SR_TMON_MAX_LIST] =3D {
>
> It will be more elegant to replace the macro SR_TMON_MAX_LIST by
> ARRAY_SIZE(sr_tmon_names) and declare this array as:
>
> static const char *const sr_tmon_name[] =3D {
>         ...
> };
>
>> +     "sr_tmon_ihost0",
>> +     "sr_tmon_ihost1",
>> +     "sr_tmon_ihost2",
>> +     "sr_tmon_ihost3",
>> +     "sr_tmon_crmu",
>> +     "sr_tmon_nitro",
>> +};
>> +
>> +struct sr_tmon {
>> +     struct thermal_zone_device *tz;
>> +     unsigned int crit_temp;
>> +     unsigned int tmon_id;
>> +     struct sr_thermal *priv;
>> +};
>> +
>> +struct sr_thermal {
>> +     struct device *dev;
>
> This field is used for dev_dbg, may be it could be removed along with
> the dev_dbg message?
>
>> +     void __iomem *regs;
>> +     struct sr_tmon tmon[SR_TMON_MAX_LIST];
>> +};
>> +
>> +static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +     struct sr_tmon *tmon =3D tz->devdata;
>> +     struct sr_thermal *sr_thermal =3D tmon->priv;
>> +
>> +     *temp =3D readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id=
));
>> +
>> +     return 0;
>> +}
>> +
>> +static int sr_get_trip_type(struct thermal_zone_device *tz, int trip,
>> +                                     enum thermal_trip_type *type)
>> +{
>> +     struct sr_tmon *tmon =3D tz->devdata;
>> +     struct sr_thermal *sr_thermal =3D tmon->priv;
>> +
>> +     switch (trip) {
>> +     case 0:
>> +             *type =3D THERMAL_TRIP_CRITICAL;
>> +             break;
>> +     default:
>> +             dev_dbg(sr_thermal->dev,
>> +                     "Driver does not support more than 1 trip point\n"=
);
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int sr_get_trip_temp(struct thermal_zone_device *tz, int trip, i=
nt *temp)
>> +{
>> +     struct sr_tmon *tmon =3D tz->devdata;
>> +     struct sr_thermal *sr_thermal =3D tmon->priv;
>> +
>> +     switch (trip) {
>> +     case 0:
>> +             *temp =3D tmon->crit_temp;
>> +             break;
>> +     default:
>> +             dev_dbg(sr_thermal->dev,
>> +                     "Driver does not support more than 1 trip point\n"=
);
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static int sr_set_trip_temp(struct thermal_zone_device *tz, int trip, i=
nt temp)
>> +{
>> +     struct sr_tmon *tmon =3D tz->devdata;
>> +
>> +     switch (trip) {
>> +     case 0:
>> +             /*
>> +              * Allow the user to change critical temperature
>> +              * as per their requirement, could be for debug
>> +              * purpose, even if it's more than the recommended
>> +              * critical temperature.
>> +              */
>
> Couldn't the user harm the hardware with a too high value?
>
> Why not define this value in the DT?
>
>> +             tmon->crit_temp =3D temp;
>> +             break;
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +     return 0;
>> +}
>
> Is it possible to factor out these 3 functions above and remove the
> 'switch' in all of them ?
>
>> +static struct thermal_zone_device_ops sr_thermal_ops =3D {
>> +     .get_temp =3D sr_get_temp,
>> +     .get_trip_type =3D sr_get_trip_type,
>> +     .get_trip_temp =3D sr_get_trip_temp,
>> +     .set_trip_temp =3D sr_set_trip_temp,
>> +};
>> +
>> +static int sr_thermal_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev =3D &pdev->dev;
>> +     struct sr_thermal *sr_thermal;
>> +     struct sr_tmon *tmon;
>> +     struct resource *res;
>> +     uint32_t sr_tmon_list =3D 0;
>> +     unsigned int i;
>> +     int ret;
>> +
>> +     sr_thermal =3D devm_kzalloc(dev, sizeof(*sr_thermal), GFP_KERNEL);
>> +     if (!sr_thermal)
>> +             return -ENOMEM;
>> +
>> +     sr_thermal->dev =3D dev;
>> +
>> +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     sr_thermal->regs =3D (void __iomem *)devm_memremap(&pdev->dev, res=
->start,
>> +                                      resource_size(res), MEMREMAP_WB);
>> +     if (IS_ERR(sr_thermal->regs)) {
>> +             dev_err(dev, "failed to get io address\n");
>> +             return PTR_ERR(sr_thermal->regs);
>> +     }
>> +
>> +     ret =3D device_property_read_u32(dev, "brcm,tmon-mask", &sr_tmon_l=
ist);
>> +     if (ret)
>> +             return ret;
>> +
>> +     for (i =3D 0; i < SR_TMON_MAX_LIST; i++) {
>> +
>> +             if (!(sr_tmon_list & BIT(i)))
>> +                     continue;
>> +
>> +             /* Flush temperature registers */
>> +             writel(0, sr_thermal->regs + SR_TMON_TEMP_BASE(i));
>> +             tmon =3D &sr_thermal->tmon[i];
>
> It is possible to initialize tmon to:
>
>                 tmon =3D &sr_thermal->tmon;
>
> and then use the pointer increment:
>                 tmon++;
>
>
>> +             tmon->crit_temp =3D TMON_CRIT_TEMP;
>> +             tmon->tmon_id =3D i;
>> +             tmon->priv =3D sr_thermal;
>> +             tmon->tz =3D thermal_zone_device_register(sr_tmon_names[i]=
,
>> +                             1, 1,
>> +                             tmon,
>> +                             &sr_thermal_ops,
>> +                             NULL, 1000, 1000);
>> +             if (IS_ERR(tmon->tz))
>> +                     goto err_exit;
>> +
>> +             dev_info(dev, "%s: registered\n", sr_tmon_names[i]);
>> +     }
>> +     platform_set_drvdata(pdev, sr_thermal);
>> +
>> +     return 0;
>> +
>> +err_exit:
>> +     while (--i >=3D 0) {
>> +             if (sr_thermal->tmon[i].tz)
>> +                     thermal_zone_device_unregister(sr_thermal->tmon[i]=
.tz);
>> +     }
>> +
>> +     return PTR_ERR(tmon->tz);
>> +}
>> +
>> +static int sr_thermal_remove(struct platform_device *pdev)
>> +{
>> +     struct sr_thermal *sr_thermal =3D platform_get_drvdata(pdev);
>> +     unsigned int i;
>> +
>> +     for (i =3D 0; i < SR_TMON_MAX_LIST; i++)
>> +             if (sr_thermal->tmon[i].tz)
>> +                     thermal_zone_device_unregister(sr_thermal->tmon[i]=
.tz);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id sr_thermal_of_match[] =3D {
>> +     { .compatible =3D "brcm,sr-thermal", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
>> +
>> +static const struct acpi_device_id sr_thermal_acpi_ids[] =3D {
>> +     { .id =3D "BRCM0500" },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, sr_thermal_acpi_ids);
>> +
>> +static struct platform_driver sr_thermal_driver =3D {
>> +     .probe          =3D sr_thermal_probe,
>> +     .remove         =3D sr_thermal_remove,
>> +     .driver =3D {
>> +             .name =3D "sr-thermal",
>> +             .of_match_table =3D sr_thermal_of_match,
>> +             .acpi_match_table =3D ACPI_PTR(sr_thermal_acpi_ids),
>> +     },
>> +};
>> +module_platform_driver(sr_thermal_driver);
>> +
>> +MODULE_AUTHOR("Pramod Kumar <pramod.kumar@broadcom.com>");
>> +MODULE_DESCRIPTION("Stingray thermal driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

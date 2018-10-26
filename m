Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1526EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AD82064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCcR9U4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AD82064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJZUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:48:19 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46441 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeJZUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:48:19 -0400
Received: by mail-vs1-f67.google.com with SMTP id l6so532474vsj.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvHFjfYwLiJ1bSGARMprZvPl9/SgcifNpT4cGn8Nils=;
        b=RCcR9U4N/OYinID9SLzwGmFdYIfn5icGyPEDZwnGorHKKXdqv6bFEDtU31tPWUO5GR
         k4TObZdB2e9ua78EP99+wZ1o0JRaqD2QxxOjkJ9DKHMc6DP5TWZ5EDnhYPn7KwPdOwgi
         otAw8jMXQpslAPLxu/nCuzJ+LED0nl+M+mKQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvHFjfYwLiJ1bSGARMprZvPl9/SgcifNpT4cGn8Nils=;
        b=dEo7UsuTm5J4XWO3gzzSSPB/XVQozSSl2lyGLB+6dBrFchbURNc0psOS8KfWbArHZJ
         cj9uf8CwBjUC9mAHzx6UiufFJctZnvEanaOOQBYFoT+HeJfS3H+ASeKypI5piWRlW87O
         vgVU2uwdkLHJ/8Hwq1+ldoxUYiCw47kPkC0kk6E3JxmUudAjayD7FhGaKfrS5ClMDQb3
         q7Pn9xZoK97YdPZ583kSghnnlONjEB9f4SyWpjM1jUjK20X4XrxwPkzdwLBX4m9Et9K1
         YgKk9FW+r4+LPRBPLl73Pg4mSdhej3uOLGRrzQm02bkVCC2BFK3YR3yL4B4Nl3M7zrbG
         lRvw==
X-Gm-Message-State: AGRZ1gJMe4lm2V9MNZO8gpdBpkdGV64hvc4TY1LSEZORX4BOlsCB5p3i
        vi/Fw+zU6NkVt7bBcZgsh0XYOclfiTmNk2jUivFCTQ==
X-Google-Smtp-Source: AJdET5eMy9EwE0xScvPAH0VM1VSjNHTvRuwzwGXBZG+WwqW9bavMAuincogd2sOhjS+dUmHGd15rY5HPMx188YThCKE=
X-Received: by 2002:a67:e31a:: with SMTP id j26mr1319194vsf.95.1540555885656;
 Fri, 26 Oct 2018 05:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017155332epcas2p499ac9d53678d82a9984b3533e723a0dd@epcas2p4.samsung.com>
 <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com> <1539791563-5959-4-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1539791563-5959-4-git-send-email-b.zolnierkie@samsung.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 26 Oct 2018 17:41:14 +0530
Message-ID: <CAHLCerNisNkLptW3sHaue_eR8siy3-6VGo=80A9svtYfmdoiTQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] thermal: separate sensor enable and check operations
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 9:23 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> [devm]_thermal_zone_of_sensor_register() is used to register
> thermal sensor by thermal drivers using DeviceTree. Besides
> registering sensor this function also immediately:
>
> - enables it:
>
>   tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED)
>   (->set_mode is set to of_thermal_set_mode() in of-thermal.c)
>
> - checks it (indirectly by using of_thermal_set_mode()):
>
>   thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>   (which in turn ends up using ->get_temp method).
>
> For many DT thermal drivers this causes a problem because:
>
> - [devm]_thermal_zone_of_sensor_register() need to be called in
>   order to obtain data about thermal trips which are then used to
>   finish hardware sensor setup (only after which ->get_temp can
>   be used)
>
> There is also related issue for DT thermal drivers that support
> IRQ (i.e. exynos and rockchip ones):
>
> - sensor hardware should be enabled only after IRQ handler is
>   requested (because otherwise we might get IRQs that we can't
>   handle)
>
> - IRQ handler needs tzd structure which is obtained from
>   [devm_]thermal_zone_of_sensor_register()
>
> - after [devm_]thermal_zone_of_sensor_register() call core
>   thermal code assumes that sensor is enabled and ready to use
>   (i.e. that IRQ handler has been requested and sensor hardware
>   has been enabled)
>
> In order to prepare for fixing all abovementioned issues separate
> sensor enable and check operations in the core thermal code and
> update thermal drivers accordingly:

The commit message on this patch and patch 4 are identical upto here.
Perhaps consider moving the actual difference in the commit message to
the top and post the TL;DR version below it?

> * Add set_mode_skip_check flag to struct thermal_zone_device_ops and
>   set it in drivers that don't check the thermal zone device in their
>   ->set_mode method implementations.
>
> * Move thermal_zone_device_check() from ->set_mode implementations to
>   the users of thermal_zone_set_mode() (only place which calls
>   ->set_mode). Modify mode_store() in thermal_sysfs.c accordingly.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/acpi/thermal.c                             |  2 ++
>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  2 --
>  drivers/platform/x86/acerhdf.c                     |  2 ++
>  drivers/thermal/db8500_thermal.c                   |  2 ++
>  drivers/thermal/hisi_thermal.c                     |  2 ++
>  drivers/thermal/imx_thermal.c                      |  2 --
>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
>  drivers/thermal/of-thermal.c                       |  6 +++---
>  drivers/thermal/rockchip_thermal.c                 | 16 ++++++++++++----
>  drivers/thermal/thermal_sysfs.c                    |  3 +++
>  include/linux/thermal.h                            |  2 ++
>  11 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index b8b275e1..a7e3d9e 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -879,6 +879,8 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>         .get_crit_temp = thermal_get_crit_temp,
>         .get_trend = thermal_get_trend,
>         .notify = thermal_notify,
> +
> +       .set_mode_skip_check = true,
>  };
>
>  static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> index b0afd36..5f4b3bd 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> @@ -170,8 +170,6 @@ static int mlxsw_thermal_set_mode(struct thermal_zone_device *tzdev,
>
>         thermal->mode = mode;
>
> -       thermal_zone_device_check(tzdev);
> -
>         return 0;
>  }
>
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 5a2b93a..884fd83 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -507,6 +507,8 @@ static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
>         .get_trip_hyst = acerhdf_get_trip_hyst,
>         .get_trip_temp = acerhdf_get_trip_temp,
>         .get_crit_temp = acerhdf_get_crit_temp,
> +
> +       .set_mode_skip_check = true,
>  };
>
>
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index ab66b2d7..c4d0fb1 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -220,6 +220,8 @@ static int db8500_sys_get_crit_temp(struct thermal_zone_device *thermal,
>         .get_trip_type = db8500_sys_get_trip_type,
>         .get_trip_temp = db8500_sys_get_trip_temp,
>         .get_crit_temp = db8500_sys_get_crit_temp,
> +
> +       .set_mode_skip_check = true,
>  };
>
>  static void db8500_thermal_update_config(struct db8500_thermal_zone *pzone,
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 63d4fc3..6151e55 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -561,6 +561,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>         }
>
>         thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_ENABLED);
> +       thermal_zone_device_check((&data->sensor)->tzd);
>
>         return 0;
>  }
> @@ -570,6 +571,7 @@ static int hisi_thermal_remove(struct platform_device *pdev)
>         struct hisi_thermal_data *data = platform_get_drvdata(pdev);
>
>         thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_DISABLED);
> +       thermal_zone_device_check((&data->sensor)->tzd);
>
>         data->disable_sensor(data);
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 22f57ef..7abad6c 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -385,8 +385,6 @@ static int imx_set_mode(struct thermal_zone_device *tz,
>
>         data->mode = mode;
>
> -       thermal_zone_device_check(tz);
> -
>         return 0;
>  }
>
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index e26b01c..d1f0641 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -305,6 +305,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>         if (priv->uuid_bitmap & 1 << INT3400_THERMAL_PASSIVE_1) {
>                 int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
>                 int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
> +               int3400_thermal_ops.set_mode_skip_check = true;
>         }
>         priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
>                                                 priv, &int3400_thermal_ops,
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index c422b08..f1dcb7d 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -272,8 +272,6 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
>
>         data->mode = mode;
>
> -       thermal_zone_device_check(tz);
> -
>         return 0;
>  }
>
> @@ -496,9 +494,11 @@ struct thermal_zone_device *
>                 if (sensor_specs.np == sensor_np && id == sensor_id) {
>                         tzd = thermal_zone_of_add_sensor(child, sensor_np,
>                                                          data, ops);
> -                       if (!IS_ERR(tzd))
> +                       if (!IS_ERR(tzd)) {
>                                 thermal_zone_set_mode(tzd,
>                                                       THERMAL_DEVICE_ENABLED);
> +                               thermal_zone_device_check(tzd);
> +                       }

You add this here and then remove it in patch 4. I'm guessing this is
to help with git-bisect. But...

>                         of_node_put(sensor_specs.np);
>                         of_node_put(child);
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 5640675..715f4cd 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1281,9 +1281,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>
>         thermal->chip->control(thermal->regs, true);
>
> -       for (i = 0; i < thermal->chip->chn_num; i++)
> +       for (i = 0; i < thermal->chip->chn_num; i++) {
>                 thermal_zone_set_mode((&thermal->sensors[i])->tzd,
>                                       THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check((&thermal->sensors[i])->tzd);
> +       }

Similarly, most of patch 4 are about calling set_mode and device_check
after the registration across all drivers. So it seems to be that it
might be easier to just merge these two patches to make it easier to
understand what is happening.

>         platform_set_drvdata(pdev, thermal);
>
> @@ -1302,9 +1304,11 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>         struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
>         int i;
>
> -       for (i = 0; i < thermal->chip->chn_num; i++)
> +       for (i = 0; i < thermal->chip->chn_num; i++) {
>                 thermal_zone_set_mode((&thermal->sensors[i])->tzd,
>                                       THERMAL_DEVICE_DISABLED);
> +               thermal_zone_device_check((&thermal->sensors[i])->tzd);
> +       }
>
>         thermal->chip->control(thermal->regs, false);
>
> @@ -1320,9 +1324,11 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>         struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
>         int i;
>
> -       for (i = 0; i < thermal->chip->chn_num; i++)
> +       for (i = 0; i < thermal->chip->chn_num; i++) {
>                 thermal_zone_set_mode((&thermal->sensors[i])->tzd,
>                                       THERMAL_DEVICE_DISABLED);
> +               thermal_zone_device_check((&thermal->sensors[i])->tzd);
> +       }
>
>         thermal->chip->control(thermal->regs, false);
>
> @@ -1372,9 +1378,11 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>
>         thermal->chip->control(thermal->regs, true);
>
> -       for (i = 0; i < thermal->chip->chn_num; i++)
> +       for (i = 0; i < thermal->chip->chn_num; i++) {
>                 thermal_zone_set_mode((&thermal->sensors[i])->tzd,
>                                       THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check((&thermal->sensors[i])->tzd);
> +       }
>
>         pinctrl_pm_select_default_state(dev);
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 3b38fb9..ac39fb6 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -85,6 +85,9 @@
>         if (result)
>                 return result;
>
> +       if (!tz->ops->set_mode_skip_check)
> +               thermal_zone_device_check(tz);
> +
>         return count;
>  }
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 3e325b3..92c460e 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -113,6 +113,8 @@ struct thermal_zone_device_ops {
>                           enum thermal_trend *);
>         int (*notify) (struct thermal_zone_device *, int,
>                        enum thermal_trip_type);
> +
> +       bool set_mode_skip_check;
>  };
>
>  struct thermal_cooling_device_ops {
> --
> 1.9.1
>

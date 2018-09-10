Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC5CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EB92086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izPsqv6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EB92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeIJWLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:11:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43210 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIJWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:11:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so41606713oib.10;
        Mon, 10 Sep 2018 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=skU/9vx2K4jkJjLMuAxKB0AHJZ6zQXigTdl0qPp53yU=;
        b=izPsqv6zPPt2DIXGLtJIKIrlMmoIcsJNg+D/cqP0Ts/VceLi8KN+IgVliueZ6V452q
         zGkVF076+4H3TntFiX1veXyZu3RaQMZzHqv6cvba13D5Dx+w+NPdiZmwJ2uQVnNCAIPi
         eDSvcLS/Fwc8cOCFnE1etY9/Lmm8M3PDTNTz+9Vl6j8S2UXf82ItKV7G0FhRB3UJp6kU
         D7seY5sdfdN3qZcNU4GA257CvzppUZBeAmdIGxQIaavEMd5czu8ckbdkhC0EdLr6NJOE
         un/7rz3Fk2Q35d5IehqlaOlVy6x2yJ9zRpndUKV+iE+n6Pj5yXFW4ETXz6c3aJzTeKbN
         4CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=skU/9vx2K4jkJjLMuAxKB0AHJZ6zQXigTdl0qPp53yU=;
        b=Bc8NdNWOyvzkGrQuo1MVrTyxe2oBcZBuFkWGRfI8W2mVvs6hLxNCwJ/UW0lzh6QTPE
         79uSUAUWjuwgJkAj1T4J4mjpvOMADaoqM3PPIQ0piIKE/lJjWOHeKWg9nPo2lrADYicf
         9rM1x5y/DDluS5qxIXHpMVQssVM8tk4R8ppvlkl88ajFzbL5KmLu8r9oymDMPJI6rJXT
         8bFkb/kCI4VGWzI74d1UvmzrnBxVIiqPTtvSQULmQ6pgPGR6ICESE69td0VwRgO1ub2f
         4AFoJPGua1auTOA8+5vCXFkA2OibMA7pS1whW8x6Zpj8upuiQuTAFdQ9MBawaQ5AYnCK
         TUTA==
X-Gm-Message-State: APzg51A764ekozYidLFnFIgfNCZkA1XfiXWd/9XUG3vChT+FJfAKvIGi
        1scyF4ayaD057EBOqYLdCno=
X-Google-Smtp-Source: ANB0VdZ1yvtGYJTOVNTO6t4ZzAbz13I0n8G5V7q2Dx7hW9ZOTVXx7QyzAlU5s7ex32nOfBqP1L84vw==
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr21234676oia.242.1536599768928;
        Mon, 10 Sep 2018 10:16:08 -0700 (PDT)
Received: from localhost.localdomain ([12.251.228.178])
        by smtp.gmail.com with ESMTPSA id w13-v6sm15017495oiw.51.2018.09.10.10.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:16:08 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:16:06 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>,
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
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] thermal: add thermal_zone_device_toggle() helper
Message-ID: <20180910171605.GA4196@localhost.localdomain>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180410124248epcas1p453f74df4e183f9d68de255847c093d4e@epcas1p4.samsung.com>
 <1523364131-31059-2-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523364131-31059-2-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:41:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add thermal_zone_device_toggle() helper. Then update core code and
> drivers to use it.

Cool, but I think it would be good to have some sort of rational here
at the commit message telling why this helper is being added, 
don't you agree?

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/hisi_thermal.c     | 14 ++------------
>  drivers/thermal/of-thermal.c       |  2 +-
>  drivers/thermal/rockchip_thermal.c | 22 +++++-----------------
>  drivers/thermal/thermal_helpers.c  | 15 +++++++++++++++
>  drivers/thermal/thermal_sysfs.c    |  8 +++++---
>  include/linux/thermal.h            |  1 +
>  6 files changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index 761d055..9428499 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -515,15 +515,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
>  };
>  MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
>  
> -static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
> -				       bool on)
> -{
> -	struct thermal_zone_device *tzd = sensor->tzd;
> -
> -	tzd->ops->set_mode(tzd,
> -		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
> -}
> -
>  static int hisi_thermal_probe(struct platform_device *pdev)
>  {
>  	struct hisi_thermal_data *data;
> @@ -571,7 +562,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	hisi_thermal_toggle_sensor(&data->sensor, true);
> +	thermal_zone_device_toggle((&data->sensor)->tzd, true);
>  
>  	return 0;
>  }
> @@ -579,9 +570,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  static int hisi_thermal_remove(struct platform_device *pdev)
>  {
>  	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
> -	struct hisi_thermal_sensor *sensor = &data->sensor;
>  
> -	hisi_thermal_toggle_sensor(sensor, false);
> +	thermal_zone_device_toggle((&data->sensor)->tzd, false);
>  
>  	data->disable_sensor(data);
>  
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index e09f035..f138b78 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -510,7 +510,7 @@ struct thermal_zone_device *
>  			tzd = thermal_zone_of_add_sensor(child, sensor_np,
>  							 data, ops);
>  			if (!IS_ERR(tzd))
> -				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
> +				thermal_zone_device_toggle(tzd, true);
>  
>  			of_node_put(sensor_specs.np);
>  			of_node_put(child);
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index f36375d..c191e41 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1022,15 +1022,6 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  };
>  MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
>  
> -static void
> -rockchip_thermal_toggle_sensor(struct rockchip_thermal_sensor *sensor, bool on)
> -{
> -	struct thermal_zone_device *tzd = sensor->tzd;
> -
> -	tzd->ops->set_mode(tzd,
> -		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
> -}
> -
>  static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
>  {
>  	struct rockchip_thermal_data *thermal = dev;
> @@ -1292,7 +1283,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	thermal->chip->control(thermal->regs, true);
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++)
> -		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
>  
>  	platform_set_drvdata(pdev, thermal);
>  
> @@ -1311,11 +1302,8 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>  	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
>  	int i;
>  
> -	for (i = 0; i < thermal->chip->chn_num; i++) {
> -		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
> -
> -		rockchip_thermal_toggle_sensor(sensor, false);
> -	}
> +	for (i = 0; i < thermal->chip->chn_num; i++)
> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
>  
>  	thermal->chip->control(thermal->regs, false);
>  
> @@ -1332,7 +1320,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  	int i;
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++)
> -		rockchip_thermal_toggle_sensor(&thermal->sensors[i], false);
> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, false);
>  
>  	thermal->chip->control(thermal->regs, false);
>  
> @@ -1383,7 +1371,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  	thermal->chip->control(thermal->regs, true);
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++)
> -		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
> +		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
>  
>  	pinctrl_pm_select_default_state(dev);
>  
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index eb03d7e..d5db101 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -227,3 +227,18 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
> +
> +/**
> + * thermal_zone_device_toggle() - enables/disables thermal zone device
> + * @tz: a valid pointer to a struct thermal_zone_device
> + *
> + * Enables/Disables thermal zone device.
> + *
> + * Return: On success returns 0, an error code otherwise.
> + */
> +int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on)
> +{
> +	return tz->ops->set_mode(tz,
> +		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);

why not simply getting a mode type (enum thermal_device_mode)?

> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_toggle);

I know naming is always the hardest part :-), but to me, this function
is more a thermal_zone_set_mode() than device_toggle(). At least, based
on what I see in the code, we are not really toggling device per si,
just setting a mode.

> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 23b5e0a..343f52b 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -72,17 +72,19 @@
>  {
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>  	int result;
> +	bool on;
>  
>  	if (!tz->ops->set_mode)
>  		return -EPERM;
>  
>  	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
> -		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
> +		on = true;
>  	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
> -		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
> +		on = false;
>  	else
> -		result = -EINVAL;
> +		return -EINVAL;
>  
> +	result = thermal_zone_device_toggle(tz, on);
>  	if (result)
>  		return result;
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 7834be6..4fbbabe 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -467,6 +467,7 @@ struct thermal_cooling_device *
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
> +int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on);
>  

You missed the #else section of the #if IS_ENABLED(CONFIG_THERMAL),
didn't you?

We want to have a stub when config thermal is not set.

>  int get_tz_trend(struct thermal_zone_device *, int);
>  struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
> -- 
> 1.9.1
> 

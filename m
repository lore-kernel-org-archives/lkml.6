Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB7F2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtWgQcBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfBRK1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:27:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35585 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfBRK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:27:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so1851474wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 02:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zvn6TRWnEuHKetW1HPxyV61Bg80kMse2R1Evw8AuvEA=;
        b=rtWgQcBBYYy86HyhjOBcvpUMVi3WUPW0gGwjCW8LCHf3t9RxtuzmQ3wc5cg+/4Qu3s
         BfvTfLbbeplIeIiNbEjB0NYKljyq/hVvMTip7PEo7QvDbTKFPGVk/3YxrjnCK3F0ONRz
         FlyPjYdk7Ekr0KeMEgtFHrif9b33f0iq3f5z3z7qgN4pyEUi8oxo3k4jXwRZ3yN35ow1
         /UcQOvfs0yFrGyuFFt59lPmIWh1+v4UDi67wrcw+HLgN2ZfU66MX3Bqr86IR7z1Vaxkh
         vEwHcQQtVnaknO9L+3zjG2Sl2nQ9N/WtLV2xgfVEX+geXZYUN764evhGUpHZvt800dzI
         Rafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zvn6TRWnEuHKetW1HPxyV61Bg80kMse2R1Evw8AuvEA=;
        b=YcJ2zNiBMrz3yGjaDHWgmb6lrhGCp1EkjeVMQO1VSqFE698EF5rj9jEwKEWYGbAvz/
         PgGh0tohWZqPNBXTTcoJ5dVdIic9kB9d2/i7NMAz6Og+Kj+oMirX8o3huzA7VWUYYvt0
         QrVaqaN2hydWkPWhMLAJUBs3rGECb/10EVI8jDGidlfowi1ay5+yCmb62cUAlaO09FHl
         b0FbQsXrAi9Ms1llz7EY3IPX/1JvjPyywgOEfUf6rCNSZIPxoboNMLNJN4xls/ciL8c+
         e3fokQWyvX879UkUGVFQos10ySRgyUaVaRbO99c6SA6Qb+SLrkhLT3zPJbMcKKTDnoRv
         eUKQ==
X-Gm-Message-State: AHQUAuaW37CrVh69Fzwm2S/E+d1dSfww3TVrH2qw5z+61htlgILlfgj/
        Z+1ACAFxTxHDCKT9ilBobgJpAQ==
X-Google-Smtp-Source: AHgI3IaISWfn3ENTyE6VZqdkqwr1gxfjg1QD5sgeSZ0IxX0Dh/JUu166jDou/GF4yhQU1xs2mv2Yug==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr15331740wme.135.1550485656075;
        Mon, 18 Feb 2019 02:27:36 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y1sm12585779wrh.65.2019.02.18.02.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 02:27:35 -0800 (PST)
Subject: Re: [PATCH v7 3/3] thermal: tegra: add get_trend ops
To:     Wei Ni <wni@nvidia.com>, edubezval@gmail.com
Cc:     thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-4-git-send-email-wni@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bae5b0c3-3d7f-0b60-da96-730c7e8c4e5c@linaro.org>
Date:   Mon, 18 Feb 2019 11:27:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546510369-28491-4-git-send-email-wni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2019 11:12, Wei Ni wrote:
> Add support for get_trend ops that allows soctherm
> sensors to be used with the step-wise governor.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index fd2703c0cfc5..864205af104b 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -488,9 +488,43 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
>  	return 0;
>  }
>  
> +static int tegra_thermctl_get_trend(void *data, int trip,
> +				    enum thermal_trend *trend)
> +{
> +	struct tegra_thermctl_zone *zone = data;
> +	struct thermal_zone_device *tz = zone->tz;
> +	int trip_temp, temp, last_temp, ret;
> +
> +	if (!tz)
> +		return -EINVAL;
> +
> +	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&tz->lock);

No need to use the mutex here.

Why not ?

temp = READ_ONCE(tz->temperature);
last_temp = READ_ONCE(tz->last_temperature);

> +	temp = tz->temperature;
> +	last_temp = tz->last_temperature;
> +	mutex_unlock(&tz->lock);
> +
> +	if (temp > trip_temp) {
> +		if (temp >= last_temp)
> +			*trend = THERMAL_TREND_RAISING;
> +		else
> +			*trend = THERMAL_TREND_STABLE;
> +	} else if (temp < trip_temp) {
> +		*trend = THERMAL_TREND_DROPPING;
> +	} else {
> +		*trend = THERMAL_TREND_STABLE;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>  	.get_temp = tegra_thermctl_get_temp,
>  	.set_trip_temp = tegra_thermctl_set_trip_temp,
> +	.get_trend = tegra_thermctl_get_trend,
>  };
>  
>  static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


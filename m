Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CC721873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMw4ZGYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeLSBY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:24:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33552 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeLSBY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 20:24:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so9008647pfb.0;
        Tue, 18 Dec 2018 17:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Voj//nhWAMx/8ObwLtNNf6FYWhzZMRgyBUH3bthFofw=;
        b=NMw4ZGYT6Y5bDRKlqIIcXQ4J4CKHpKKvI5cGfBJVuv91Ig494qGU8j8RluuVwO2pjH
         sjV/HmtsJtfiLZx0xuhHoayMl9XA63fi3Tl4lNX9SKIk/1FUWY7kOJTKuGqjI4Nt5jP+
         HPxEFhqOk8q5lWVNtSLMn0tuRUN/mzSJYPpIGD5w88nHRI5HY/6nMt5+JECkd86LnYWD
         5n/014OkkuuSyOeP7WulFcfX822YLBurHmRIK5WKIdHJT5wCx9yGeF8pTjZsNlfPUY/n
         wwblZytOKJS60rSi0uiJ2xltYyUJ7vMZCBL7pp6KuqAKgiN4kQtOKGqanl0PZJvCP17Y
         QRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Voj//nhWAMx/8ObwLtNNf6FYWhzZMRgyBUH3bthFofw=;
        b=WbAIHCGwrk7hsaaFBWnVjnce18E68Dn7YAK/pYOFONmd4ZxNUjJtSbFhUlVmbz9d4v
         +6MlUV+CLXbgicaOCeFjUcVF3dZY/zobWRw4YYNj/zi9HYWluIxai7Z5+oqyE9/J0C4u
         844C7IHvl4N91JED2kgqllbjOHXPeslDOcurkl+DwONeevBSVGfbZom5Arrkohk3diJw
         +xslbNVEkM+gHudFzYBG4MswUXm4MTg6uDIxxP/TIIrRvtzCchy4fjHTCPKJ4oVyRRPe
         1hgSaabkj+V7vHqZ9OeA8Wz1SbUFXTq5n7gIBoSbwJ76E8eVUTqdwdv1V2T6llDQvqyZ
         pbWg==
X-Gm-Message-State: AA+aEWaC8q6LaHun0N+eFJogvx41lWNcHl8d834D/qZG97AQwNDMhOXk
        67dJ4SFHrrl+nqtF6940cfC7MfsQ
X-Google-Smtp-Source: AFSGD/Up7J95paqgemJKyWeIX7ZukSMeAuCpXUZrcWpvQISoVYHY6qJe/Ae91o3t9RWdGtiBEp2I1Q==
X-Received: by 2002:a63:de04:: with SMTP id f4mr1224960pgg.292.1545182696365;
        Tue, 18 Dec 2018 17:24:56 -0800 (PST)
Received: from localhost.localdomain ([172.58.92.156])
        by smtp.gmail.com with ESMTPSA id d6sm23778175pgc.89.2018.12.18.17.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 17:24:55 -0800 (PST)
Date:   Tue, 18 Dec 2018 17:24:52 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     rui.zhang@intel.com, thierry.reding@gmail.com,
        daniel.lezcano@linaro.org, linux-tegra@vger.kernel.org,
        srikars@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] thermal: tegra: parse sensor id before sensor
 register
Message-ID: <20181219012450.GA2842@localhost.localdomain>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <1544780993-20744-4-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544780993-20744-4-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 05:49:52PM +0800, Wei Ni wrote:
> Since different platforms may not support all 4
> sensors, so the sensor registration may be failed.
> Add codes to parse dt to find sensor id which
> need to be registered. So that the registration
> can be successful on all platform.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 45 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index fd2703c0cfc5..6bee31cd4621 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1224,6 +1224,41 @@ static void soctherm_init(struct platform_device *pdev)
>  	tegra_soctherm_throttle(&pdev->dev);
>  }
>  
> +static bool tegra_soctherm_find_sensor_id(unsigned int sensor_id)
> +{
> +	bool ret = false;
> +	struct of_phandle_args sensor_specs;
> +	struct device_node *np, *sensor_np;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return ret;
> +
> +	for_each_available_child_of_node(np, sensor_np) {
> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
> +						 "#thermal-sensor-cells",
> +						 0, &sensor_specs))
> +			continue;
> +
> +		if (sensor_specs.args_count != 1) {
> +			WARN(sensor_specs.args_count != 1,
> +			     "%s: wrong cells in sensor specifier %d\n",
> +			     sensor_specs.np->name, sensor_specs.args_count);
> +			continue;
> +		}
> +
> +		if (sensor_specs.args[0] == sensor_id) {
> +			of_node_put(sensor_np);
> +			ret = true;
> +			break;
> +		}
> +	}
> +
> +	of_node_put(np);
> +
> +	return ret;
> +}

So, I am still failing to see why this is really needed. 

Why can't you simply resolve this with different compatibles?
If the sensor is not present or disabled, the compatible is not, well,
compatible anymore.

> +
>  static const struct of_device_id tegra_soctherm_of_match[] = {
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
> @@ -1365,13 +1400,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  		zone->sg = soc->ttgs[i];
>  		zone->ts = tegra;
>  
> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
> +			continue;
> +
>  		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
>  							 soc->ttgs[i]->id, zone,
>  							 &tegra_of_thermal_ops);
>  		if (IS_ERR(z)) {
>  			err = PTR_ERR(z);
> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
> -				err);
> +			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
> +				soc->ttgs[i]->name, err);
>  			goto disable_clocks;
>  		}
>  
> @@ -1434,6 +1472,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>  		struct thermal_zone_device *tz;
>  
>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
> +		if (!tz)
> +			continue;
> +
>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>  		if (err) {
>  			dev_err(&pdev->dev,
> -- 
> 2.7.4
> 

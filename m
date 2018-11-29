Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE9FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CD9213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0rkc/8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CD9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbeK3DxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:53:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33039 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbeK3Dw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:52:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so1303101pfb.0;
        Thu, 29 Nov 2018 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WOGNP/MLlwgoMS8VRQbSZ42i8ibki5FYlLRL+d6ulzI=;
        b=Z0rkc/8TCY17P2tEJWbx+Q/frA1aEJZdWIBFwb/lxYl/iZ3v1tex66VKG1QzphZJCG
         rIiQiZeoRfVt02ZnWN9YAZ/w2neQdd8qg3KWgVYcr1L6vi7jp2njKbQiWdReiG9v9zmx
         l03CoLUu6eH8uAXxfmAkR6kctWbLWj+BeylgiwZZQOKVDggIEUJuL7r/69Ra7+PeAycl
         3fcgcFEsq5KhSxeUYX9XmQtLqH1pcJH6hjPoU+J6qtdzchMYkgcSjGyItflM9lE1Ja4i
         AmVJveuUhyYTVqbjBsjKAQUtS8LhzAKkAw3d2dcue6sa7W7cTBNy3wUnU/OoOGwvKIXX
         iEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOGNP/MLlwgoMS8VRQbSZ42i8ibki5FYlLRL+d6ulzI=;
        b=Fnv5rnjQx4mdErXTm1CFTs4kLJF+4CVY87pV6wqnOFMvA0bVcSZjWiN4cYXjvS+G0Q
         quay6SF1yobQBE1OMg9oD0YXdfMLVNbGGD6IMc61VQufp8TNIMZbzSX1GLn75TGgNgCr
         DaDy0xu1bPsyNKnmczKMQU5AMzSFzkVtIXy1ff2BXpkZOTH3IRuuQK1/4XrnA3oai1W6
         dfjlFgZ5HWwjJBDPOez/eVEBSyfGo/cBbkbiVstIrwrQ4O4ysNxikTKeA+Jjnkc6Zo84
         ANZHHSXvg7VTpqeOtfLP9tQLucXq9RENT44AgDJTNap+UKl9LXztIdeYz7fxJAnyAiGe
         afyw==
X-Gm-Message-State: AA+aEWZuDSZWC8NlMFloTjy9BzrC334XhQwwUQRLgEDi9wU7BZtGaSmE
        /6QPUnCsZ4iL5MYLd3F8MvY=
X-Google-Smtp-Source: AFSGD/UJ825tqv1ooACM1dGjtmmxua6JNtXkJwMypjoixUQbEzB/uwDoQourqYBDiAEjbenl4r7hqw==
X-Received: by 2002:a63:8441:: with SMTP id k62mr1821063pgd.392.1543510020204;
        Thu, 29 Nov 2018 08:47:00 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id 8sm4360104pfr.55.2018.11.29.08.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:46:59 -0800 (PST)
Date:   Thu, 29 Nov 2018 08:46:57 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Wei Ni <wni@nvidia.com>
Cc:     thierry.reding@gmail.com, daniel.lezcano@linaro.org,
        linux-tegra@vger.kernel.org, rui.zhang@intel.com,
        srikars@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] thermal: tegra: parse sensor id before sensor
 register
Message-ID: <20181129164656.GA2688@localhost.localdomain>
References: <1543486183-2868-1-git-send-email-wni@nvidia.com>
 <1543486183-2868-4-git-send-email-wni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543486183-2868-4-git-send-email-wni@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:09:43PM +0800, Wei Ni wrote:
> Since different platforms may not support all 4
> sensors, so the sensor registration may be failed.
> Add codes to parse dt to find sensor id which
> need to be registered. So that the registration
> can be successful on all platform.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 46 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 375cadbc24cd..bdc660f2794a 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1224,6 +1224,42 @@ static void soctherm_init(struct platform_device *pdev)
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
> +	sensor_np = of_get_next_child(np, NULL);
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
> +			ret = true;
> +			break;
> +		}
> +	}
> +
> +	of_node_put(np);
> +	of_node_put(sensor_np);
> +
> +	return ret;
> +}
> +
>  static const struct of_device_id tegra_soctherm_of_match[] = {
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
> @@ -1365,13 +1401,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  		zone->sg = soc->ttgs[i];
>  		zone->ts = tegra;
>  
> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
> +			continue;
> +


Instead of matching driver id with DT id presence, wouldnt make sense to
simply have DT with the sensors that makes sense for that platform?

I am failing to understand why you need to go over and find ids.

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
> @@ -1434,6 +1473,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
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

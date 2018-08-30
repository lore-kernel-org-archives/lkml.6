Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6304C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835E62073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0s04mg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835E62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeH3TAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:00:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36854 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbeH3TAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:00:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id m27-v6so8375639wrf.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7iBMrWUJ/4LWOFfIG1r3l7V367Fmj95PzL89YpDbeA=;
        b=g0s04mg5BhDaIrt8o0X8hneuGCimqfG/p2vp2Bm8mxJG1J/08EscNZ6zOrBNevEm2x
         /JO8VjMPHQcv49SAnpPY8rCPUJ+8+dUWqiR/Qk0G9RUtQOOKPt8d4Rr0A4Cm5W/5Bhvd
         3UMge7Sudm9rJth9rxkPppzcLwyx+1oxrH8jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7iBMrWUJ/4LWOFfIG1r3l7V367Fmj95PzL89YpDbeA=;
        b=Nw3x2/DH8LxuvvN2sa5C6NBcYl62J8cvXWjR37BcZiZTNse5LtpgksFRigh0KsaObB
         Qb4qdq7RGIFOUA7f/67IGFudF4C9lqpWVaeFZc9YqgH/QW+pZBYa8W97COUaNpzk5NNl
         aEJFgGtGkrAJuR8DSwEHGsPmBCpR87x6ggJXZh/1UMojmpBRP36Ij9/TD862o7fMfPet
         EXkIP/2Iqskuu95DqCgqUCBjVUfW0hg1bV47CNejc509frRGT+ePEV61ZXYoFaxhf2Cx
         mutX0MeLxhUGnGN/bMacs+wd0qfoYtSWUIMz89d/04flrF5YuiufCgiof+fGlBw0mBD+
         Kg/Q==
X-Gm-Message-State: APzg51A1fdu2mr+60xuw20i01ahTQ2CMnHqV8SJA9mSwdacJYIX3v0CT
        +9punw7BzgPjSqi9bWpkOkoKlA==
X-Google-Smtp-Source: ANB0VdYxgR7RGjH/I/Yw7m7V7n7/mHUoODQKkgXUQdH/FCd5/S3RKVPS5VAsYCO6rMkiIgHS+5vY7A==
X-Received: by 2002:a5d:6984:: with SMTP id g4-v6mr7616060wru.232.1535641097949;
        Thu, 30 Aug 2018 07:58:17 -0700 (PDT)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id l24-v6sm15292528wrb.65.2018.08.30.07.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 07:58:17 -0700 (PDT)
Subject: Re: [PATCH] thermal: Convert to using %pOFn instead of
 device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-45-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ac2580ab-e65a-ed54-708b-871bf0a3305d@linaro.org>
Date:   Thu, 30 Aug 2018 16:58:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-45-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2018 03:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/thermal/of-thermal.c    | 10 +++++-----
>  drivers/thermal/qoriq_thermal.c |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 977a8307fbb1..e201ae1c382f 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -483,8 +483,8 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
>  		if (sensor_specs.args_count >= 1) {
>  			id = sensor_specs.args[0];
>  			WARN(sensor_specs.args_count > 1,
> -			     "%s: too many cells in sensor specifier %d\n",
> -			     sensor_specs.np->name, sensor_specs.args_count);
> +			     "%pOFn: too many cells in sensor specifier %d\n",
> +			     sensor_specs.np, sensor_specs.args_count);
>  		} else {
>  			id = 0;
>  		}
> @@ -960,8 +960,8 @@ int __init of_parse_thermal_zones(void)
>  
>  		tz = thermal_of_build_thermal_zone(child);
>  		if (IS_ERR(tz)) {
> -			pr_err("failed to build thermal zone %s: %ld\n",
> -			       child->name,
> +			pr_err("failed to build thermal zone %pOFn: %ld\n",
> +			       child,
>  			       PTR_ERR(tz));
>  			continue;
>  		}
> @@ -995,7 +995,7 @@ int __init of_parse_thermal_zones(void)
>  						    tz->passive_delay,
>  						    tz->polling_delay);
>  		if (IS_ERR(zone)) {
> -			pr_err("Failed to build %s zone %ld\n", child->name,
> +			pr_err("Failed to build %pOFn zone %ld\n", child,
>  			       PTR_ERR(zone));
>  			kfree(tzp);
>  			kfree(ops);
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index c866cc165960..1fa132fc316b 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -129,8 +129,8 @@ static int qoriq_tmu_get_sensor_id(void)
>  	if (sensor_specs.args_count >= 1) {
>  		id = sensor_specs.args[0];
>  		WARN(sensor_specs.args_count > 1,
> -				"%s: too many cells in sensor specifier %d\n",
> -				sensor_specs.np->name, sensor_specs.args_count);
> +				"%pOFn: too many cells in sensor specifier %d\n",
> +				sensor_specs.np, sensor_specs.args_count);
>  	} else {
>  		id = 0;
>  	}
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


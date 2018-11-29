Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F47C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF0D2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGlUSo/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF0D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3Gnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:43:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37542 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3Gnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:43:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so1544483plr.4;
        Thu, 29 Nov 2018 11:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/vhBMAZb13TEvrf9BZ9cG6Oojk1dBIPBT4c6VDw/Hls=;
        b=bGlUSo/S+nIXDBU5INlAzNcphr3fi5yTaCsNHyW4tvWogNLDQIOtbvPn1SgNAAqbsv
         fM9O9bMxM4mLoy9hKWzwcmeDDZndSGsyADKuQtiywRqSqFpdX2JReSQIpVHUStDPi3Kb
         qSzsB5RPh4luo53CgihdndujLqYaLnbXijM/rp3tr1lKlo3ZvAeny8rXlChUj2hxjhj9
         322Gld/pIOzOanpai+OjCon41SG7aRUq7u1RKW0B3nSn97PUJiE9LkNhiYdGZc3/Xt3t
         SSQ3SseHGH8/7s82bmx9cWoX1e633ukxh2lYoqT3isBSFXrFi1bgTNEaCZnau7e9/GJd
         67pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/vhBMAZb13TEvrf9BZ9cG6Oojk1dBIPBT4c6VDw/Hls=;
        b=st2wCie3p2Rz3SnfqLGQc8cFmKwQ9IDmofeNOCPnIjc7RugQjnGYFIs6IZYqp6HNb0
         FHKEzyxnvSjIyzTZg02gZL959AVr4R/l3tWOcH18+uPHa0BBd7dRoCH6CA2gJccv8tL6
         oUot5hM+toi+qREGxTSvos/Mjmwxo3lIh6W2ZoHLnYbL+4/nEpSka1Qrk3LxPqBkGa4I
         +EFOcWW2Xic75engUehqsTB3mo6845CaC3Jjb085y/odE35hDLW96WjU/CcgXeesazTH
         pVRKeUzXqEasCatl3QMl0Kx5pJFl3d8Wp1wLXSmonRQox3Ru1GtyZffRHWYPfcWXa7nP
         xnAQ==
X-Gm-Message-State: AA+aEWawuPuYoiTF2eNjDLOAUq2gLwxK3oNvAYYzsC5AwXj5Kv5f6g27
        ol3gXrDa+hCUO+aRj/Mass8QVXv2p0I=
X-Google-Smtp-Source: AFSGD/UwNWOdlYOw/efEZp6btB4UnIYy5iFtoXVu5hJVXnm5oJXfwYAdzphVZr/a0RJazSDFwTInWQ==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr2747816pld.236.1543520222126;
        Thu, 29 Nov 2018 11:37:02 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id u70sm6910343pfa.176.2018.11.29.11.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:37:01 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:36:59 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, vincent.guittot@linaro.org,
        john.stultz@linaro.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Fix bad initialization
Message-ID: <20181129193658.GA6844@localhost.localdomain>
References: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543516016-28186-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 07:26:56PM +0100, Daniel Lezcano wrote:
> Without this patch, the thermal driver on hi6220 and hi3660 is broken.
> 
> That is due because part of the posted patchset was merged but a small
> change in the DT was dropped.
> 
> The hi6220 and hi3660 do not have an interrupt name in the DT, so
> finding interrupt by name fails.
> 
> In addition, the hi3660 only defines one thermal zone in the DT and we
> are trying to register two sensors assuming we have two thermal zones
> in the DT.
> 
> Fix this by adding a couple of line of code to add back compatibility
> with older DT and change the sensors number to 1 for the hi3660.

Is this a case of adding dt versioning for those nodes?

> 
> Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index c4111a9..3ab0e63 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
>  	struct platform_device *pdev = data->pdev;
>  	struct device *dev = &pdev->dev;
>  
> -	data->nr_sensors = 2;
> +	data->nr_sensors = 1;

For bisectability (heh.. is that even a word?), would you please send
one fix per patch?

>  
>  	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
>  				    data->nr_sensors, GFP_KERNEL);
> @@ -590,8 +590,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  		}
>  
>  		ret = platform_get_irq_byname(pdev, sensor->irq_name);
> -		if (ret < 0)
> -			return ret;
> +		if (ret <= 0) {

Maybe a simple <  is enough? reading it seams awkward. From a glance, I
dont think platform_get_irq* ever returns 0.

> +			ret = platform_get_irq(pdev, 0);
> +			if (ret <=  0) {

Same here.

> +				dev_err(dev, "Failed get interrupt: %d\n", ret);
> +				return ret;
> +			}
> +		}
>  
>  		ret = devm_request_threaded_irq(dev, ret, NULL,
>  						hisi_thermal_alarm_irq_thread,
> -- 
> 2.7.4
> 

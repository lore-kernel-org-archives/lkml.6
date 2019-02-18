Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D065217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUjNRDWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfBRJrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:47:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44793 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfBRJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:47:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so2955864wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 01:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zXbsVRRHBOgUZgWU8/grzVbisM8HhoSMUai2Uv5hHzI=;
        b=sUjNRDWaF8xAVRBvT/yVFdnSwPm1buhHXyevoBhWsw2BI0iL+rPbbQUHGg/lLXbbQp
         wlEDIVO8h0p6MgiWs01ncntuEXuLAUYN0rnL7wvCSxxpEnwMqHlnssSEcN92wYpmP+YM
         U4mAPmVV65KbMu48MJvZTQQMQyMyRu5bU0iJqYgQ65umPhlr+7YIaNoGawdX7k1olYxI
         /w02oWxMH+1O2lbAiXBfGjgO54LjX7COisw9NQUTSzg7jAGVGIc9gzC/HUKjod+zhTSU
         Y9pTepaXwHTergtAVH500U5wYBh7vXAyx/N5scjGIAMNf61JxwCfPoFQQwIfRo8ZNuLQ
         nSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXbsVRRHBOgUZgWU8/grzVbisM8HhoSMUai2Uv5hHzI=;
        b=IsyAaWryqzxkCC3reLzxM5BCV2cFk2f2K3+8ufyyz0CA7O84MB3isztRbZLMVHDJFO
         j3dSJq7hY6b6+LWk0bFZ16WW4QulodQTFLJ+3ocx7quMBXhKs0VCZOXXfMWasIkxruGz
         ZHTb//iRDTjCu2kFcNu3bAnvJqqwi+gi6zS+Oox5nyFPpJU/p/4w8Bk0gJ23z1O+Qavq
         8bKQn+IVjVlG8uXi+HenxIAjROhq3lkdktEM0yU5Fizvy2JQRJC/ijRVrNzS1GTRDbMs
         cVOpRipPjsqzsiiadauZkp/d6PnhiMvwMhIfLTPzQNDeOMSOAAQymRwjLvTPEvD9C00d
         dWBg==
X-Gm-Message-State: AHQUAuaeJhH8e0//WBL2LI7JdJ0dd/r4mdQSWirMXTjAoAowG7RtHeB1
        yttUpxpM3GKMnpzTPfXI0285/w==
X-Google-Smtp-Source: AHgI3IZXORASBL44km4GkpITgVyDpQqPsd7IJowqs27H301NKiqNYZp0zj8Iq178/QO2bmrUAhI4Dg==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr15576904wrg.230.1550483270374;
        Mon, 18 Feb 2019 01:47:50 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id a8sm15700429wmh.26.2019.02.18.01.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:47:49 -0800 (PST)
Subject: Re: [PATCH v7 1/3] thermal: tegra: remove unnecessary warnings
To:     Wei Ni <wni@nvidia.com>, edubezval@gmail.com
Cc:     thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        rui.zhang@intel.com, srikars@nvidia.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-2-git-send-email-wni@nvidia.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ec484530-0a07-b725-a376-43c65ca4a723@linaro.org>
Date:   Mon, 18 Feb 2019 10:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546510369-28491-2-git-send-email-wni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2019 11:12, Wei Ni wrote:
> Convert warnings to info as not all platforms may
> have all the thresholds and sensors enabled.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/thermal/tegra/soctherm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index ed28110a3535..f07de8258e93 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -569,7 +569,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  set_throttle:
>  	ret = get_hot_temp(tz, &trip, &temperature);
>  	if (ret) {
> -		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
> +		dev_info(dev, "throttrip: %s: missing hot temperature\n",
>  			 sg->name);
>  		return 0;
>  	}
> @@ -600,7 +600,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  	}
>  
>  	if (i == THROTTLE_SIZE)
> -		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
> +		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
>  			 sg->name);
>  
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C42081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hO9G5QWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3C42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeJaBQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:16:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46855 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeJaBQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:16:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id 74-v6so5072316wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sr8B7QSzrVwjRN0pvEw15ZDeRF0j8NquITusa0V0SFE=;
        b=hO9G5QWZv6kaF14JxG6OC83FkTnCmOejz5U3Hbh1rcXSjgTxqCDAJmGU6ugz1f5UFN
         4IQd6+UTzrFWXgXkJQnH55uBw8uzA9jBY70maYRQ8E+WW01WRH+DbLlEbudrGCCQpxhL
         vZ+/MMZAp+wv7JeZzdHpsESWWSjCH0GWMK2+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sr8B7QSzrVwjRN0pvEw15ZDeRF0j8NquITusa0V0SFE=;
        b=NtRhupzprTTWNLAu4ey+h4auG+awwIJvUa4tHQEqOvKba5iYOv8qv1m5tckv+xbpwz
         V65o6nz3WYF1l/PvKahHKpg4zHq0Xf8dyjYs5MzHMU/V2bfYUbuEOPl7WJZ4rMtosFEW
         EBOQeHR20+UqlvqkYQ2hRn2KtvFon43KK7ZfFvehyflgEMN5MyjN9sBEswQtcbPfyB2C
         GLl/HlEKK8VYeNaHNP8Ne0gN1MS0NXV0Sfk7lsW1cY34ss6XiS+ADuekPyz1uM7H+kSA
         ILfcYrnyZrPkrWFMmGvc5oiR7ZyqfdD8jrnVD8PVPOtcBRMTwcC6zJdSINq1HFQ1juQw
         qQPA==
X-Gm-Message-State: AGRZ1gIKOoOQZdsSBzzXzo09W9H+r3lOW4Ujl/3gpuIqKQOdeIUpDH6q
        VRL9ZD/oTeoGUpT2L9bMd7HRDci3LBU=
X-Google-Smtp-Source: AJdET5f/M2DpMECYNBBCLt/7mYq9JlCQOmaRCSXpAhXyB2km+2O5zMjg1XchEkoKl72WCZhTExqpqw==
X-Received: by 2002:adf:f501:: with SMTP id q1-v6mr3566080wro.63.1540916544773;
        Tue, 30 Oct 2018 09:22:24 -0700 (PDT)
Received: from [192.168.0.40] (12.152.88.92.rev.sfr.net. [92.88.152.12])
        by smtp.googlemail.com with ESMTPSA id l140-v6sm32827675wmb.24.2018.10.30.09.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:22:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal: broadcom: constify
 thermal_zone_of_device_ops structure
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Markus Mayer <mmayer@broadcom.com>
Cc:     kernel-janitors@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1540912500-21941-1-git-send-email-Julia.Lawall@lip6.fr>
 <1540912500-21941-3-git-send-email-Julia.Lawall@lip6.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b0442517-ea11-9366-b17d-c60acf5c9cb3@linaro.org>
Date:   Tue, 30 Oct 2018 17:22:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540912500-21941-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 16:15, Julia Lawall wrote:
> The thermal_zone_of_device_ops structure can be const as it is only
> passed as the last argument of thermal_zone_of_sensor_register
> and the corresponding parameter is declared as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Unrelated to this change, is there a reason not to use
> devm_thermal_zone_of_sensor_register?

Agree, it would make sense to use the devm* version.

>  drivers/thermal/broadcom/brcmstb_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -299,7 +299,7 @@ static int brcmstb_set_trips(void *data,
>  	return 0;
>  }
>  
> -static struct thermal_zone_of_device_ops of_ops = {
> +static const struct thermal_zone_of_device_ops of_ops = {
>  	.get_temp	= brcmstb_get_temp,
>  	.set_trips	= brcmstb_set_trips,
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


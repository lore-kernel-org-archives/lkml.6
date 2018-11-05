Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A906C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75002085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhIew8pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75002085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbeKFAYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:24:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39845 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbeKFAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:24:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so9891373wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7lYsKMSQrOrZ5aMQB2N9DXIlKfLzUM00Wo3jDJpL1wM=;
        b=VhIew8pgQmBa9ApgvBsAtjsauLhxXCrHBEcMIExNdqEA7QHqziO3Re1xuO3965bOHq
         9HLHEOGLAvZIuTXt19i7IPynQCHV/zqgMgNDL1+bG3NlchW/xbHeV0sEDRPWPxvCWNyO
         1Iy3cl1knH0SF00LZJVn70kxpSbS4GHa6HvjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7lYsKMSQrOrZ5aMQB2N9DXIlKfLzUM00Wo3jDJpL1wM=;
        b=RwBUViO+YIQPY64lWLTH/b4NgHucf5xfEWUvmV/AvWtOnfEEoxXoSW+fjYy99x19Xq
         ZDnr3ydazC8DSsX1VLxidYEGjVZ8QKJrMznGGF0rRo1V6xJR1rGTZ1z6BBAwQYr6tU5l
         cMzKxzCppoKgT1mAFZt8lnOZ8HwVcmoN/AAZJZS2JWGpVUYc7n/dZ9HRC1UdCLCREqMc
         RfXvMCDgWtBQJXanUXZ+7NVrueSScUL4pNgj0KxnzvQ0FImvhZiz/GT5C7kmON8v9C9u
         eMFDy3K1XA4wHSjASx14lpEWsZ3YuaT9aguS/rWb3kN5+b2Q6m6SLYmZizV+HxCtC7/8
         lvZw==
X-Gm-Message-State: AGRZ1gJpEX0F79zjmNoaP4i9ByzBrHZZe/JkbnnCXhh5aBu/jyX8/RuM
        6XkBHyZI2WmvvjygCNzwYf8QhA==
X-Google-Smtp-Source: AJdET5dk/ZfbDmvShyji0NX6SBTx/CedTpiHRTVBkt4EsFRjQBCXMd2ESd5y9Fi7YT0dSeDI4nMa7Q==
X-Received: by 2002:a5d:488a:: with SMTP id g10-v6mr20034475wrq.0.1541430259915;
        Mon, 05 Nov 2018 07:04:19 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id 8-v6sm11402206wmd.26.2018.11.05.07.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:04:19 -0800 (PST)
Subject: Re: [PATCH 1/5] thermal: int340x_thermal: int3400_thermal: simplify
 getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-2-wsa+renesas@sang-engineering.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6a8727da-66d6-8be2-6fd0-ad0984f819d9@linaro.org>
Date:   Mon, 5 Nov 2018 16:04:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181021200053.2194-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2018 22:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/int340x_thermal/int3400_thermal.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index e26b01c05e82..61ca7ce3624e 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -48,8 +48,7 @@ static ssize_t available_uuids_show(struct device *dev,
>  				    struct device_attribute *attr,
>  				    char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
>  	int i;
>  	int length = 0;
>  
> @@ -68,8 +67,7 @@ static ssize_t available_uuids_show(struct device *dev,
>  static ssize_t current_uuid_show(struct device *dev,
>  				 struct device_attribute *devattr, char *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
>  
>  	if (priv->uuid_bitmap & (1 << priv->current_uuid_index))
>  		return sprintf(buf, "%s\n",
> @@ -82,8 +80,7 @@ static ssize_t current_uuid_store(struct device *dev,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
> +	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
>  	int i;
>  
>  	for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


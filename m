Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4094C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ED8205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+FtyVgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ED8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLFVAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:00:34 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39305 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFVAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:00:33 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so1425333lfh.6;
        Thu, 06 Dec 2018 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZzb2UbdepgnfhAq42uK1vAEjufs/BpIJcZx7SNFVcM=;
        b=b+FtyVgLig3CRezsdbRWzj3/T2lzyw00oBJ1d+JdY9EgxD0nmyGZdsLZEYCe+eMckf
         mpYYWDZdynF8gkQkvsHIVoXOsU/rc+xv3LVNlW2ngjUT15HDR9kS8LHxWi8f8mnroiko
         49bg2o3UCu4mwf4aakmsD23aEP77e9vwgFj8IYWFqbuYe/7CYW6qsm+ybp0jnKsZeHTt
         fY6ncQwQK4uP3cz8rO25HUZI35TFKh5RgesZ94KFADv3R1iB3rKC7sGwZEOQxQ567RX5
         /gYqCfIAxc9pLK473noeUZPttHNMm0YdBuz4FM+Kj28lKz+rQ1m/8bf0xKjsZTz4Vnrb
         GUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZzb2UbdepgnfhAq42uK1vAEjufs/BpIJcZx7SNFVcM=;
        b=l9aORkm3d2FLyaPpLNi+w1yuOLbgZ68fR2fd/ZeWUueXvFJJ0/5PFda235+6gXxGzR
         R4trDf9uDckwBFxs38LZQz3pjimMmQP2JUQ6dBpJuxH1kq8KNTsoIDIVASrWC1bdSZZv
         jfqDx3wGjkJ3LZwwPslM3g9jiGAKP9Zkj6nuWCdrg9WvXZrQAP2MUkqw2lv2+HMX4swI
         aLY3EMTedvVAnA0nsv6UsDxjkwYBK42d0tM8fxyKzD5xtX0YJU0jmisbCutHjrcAJYIn
         veUHJ9+u2ZmMSk21gzwRSGEsSiqV74Rev4u5Gq3AfoKeApitLaFcqku66BufbbNNFI6M
         qwqA==
X-Gm-Message-State: AA+aEWZzG+KGutZKuVpF9zMAFv2k8QFyxiCwIlwucQkXf7mIxQO6F0ba
        MnFz8wY42W2409+NxCp/+pOqcC5c
X-Google-Smtp-Source: AFSGD/WZGO6NrnI/7p4qvWdnpao6pc73KrA8VwmyVpByNFyEegfJEARN3ulTAFuru59N7Oi1GgD3Ww==
X-Received: by 2002:a19:945b:: with SMTP id w88mr16993710lfd.15.1544130030849;
        Thu, 06 Dec 2018 13:00:30 -0800 (PST)
Received: from [192.168.1.18] (cjz82.neoplus.adsl.tpnet.pl. [83.31.75.82])
        by smtp.gmail.com with ESMTPSA id g17sm276000lfj.36.2018.12.06.13.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:00:30 -0800 (PST)
Subject: Re: [PATCH] leds: 88pm860x: Use of_node_name_eq for node name
 comparisons
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
References: <20181205195050.4759-11-robh@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c1312068-0faa-8892-0b7c-9d5027501cd8@gmail.com>
Date:   Thu, 6 Dec 2018 22:00:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205195050.4759-11-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On 12/5/18 2:50 PM, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which this is.
> 
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/leds/leds-88pm860x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-88pm860x.c b/drivers/leds/leds-88pm860x.c
> index 77a104d2b124..036d4a536697 100644
> --- a/drivers/leds/leds-88pm860x.c
> +++ b/drivers/leds/leds-88pm860x.c
> @@ -130,7 +130,7 @@ static int pm860x_led_dt_init(struct platform_device *pdev,
>   		return -ENODEV;
>   	}
>   	for_each_child_of_node(nproot, np) {
> -		if (!of_node_cmp(np->name, data->name)) {
> +		if (of_node_name_eq(np, data->name)) {
>   			of_property_read_u32(np, "marvell,88pm860x-iset",
>   					     &iset);
>   			data->iset = PM8606_LED_CURRENT(iset);
> 

Applied.

-- 
Best regards,
Jacek Anaszewski

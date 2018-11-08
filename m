Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D06ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7115220684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfmgDaOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7115220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeKIDgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:36:41 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34823 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIDgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:36:41 -0500
Received: by mail-yw1-f65.google.com with SMTP id w135-v6so8355366ywd.2;
        Thu, 08 Nov 2018 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a3ZQ95EjHKvLIc50X3Fuqq5o9w1oaPKktFkHFIugYck=;
        b=GfmgDaORstRsBJAD5f/AIWsfsNNjaKSviT24zZq0HIz/H8nm9IID45ywVsCSz9tQFE
         vcVDtq4SsNKKFsrwUoZC7rbj0VKIrFXogIUviEm+eifiCsbmThH5y34lFsBjnv5O/R0R
         cB1FDB39rf/TYI4foNILYRm8fKAPX2lU8frPzWCt5bYYVvA5Yes4PMIuPunpb1DJVwLT
         +CrPtKMbPrOAUGQX0SsNfG1Q81kh65y8YRuIcArXkj3FtyXAR+MBBZM55KC0P5nMao8l
         WwFBsqBuOfgLqjIMeEG90wPMzYWDTGT5NFk/VfyULI2og1SCBOfY28fxtOqgzWGkDQeP
         t22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a3ZQ95EjHKvLIc50X3Fuqq5o9w1oaPKktFkHFIugYck=;
        b=TnMvgmKvILanvGRlx3kRzCj5XHYaPbhcmsjnGFogpT84uLKEpBhQuOODVSFkfDrYTB
         s2JKfbd01mNjMA72g7rtzViUSlKpjs2UUl6ZQSAZeQg7wUsFR8+M74AQCzF9QaiqcsVk
         audlfNOEXXvj4FRparbVuF++cBuGL6+1PimyQ3ghwILiLLjYDlGa3rOIlGbkxii3OE3E
         XN3ivREa7tPERLeHGXEmRTCp+H9m0dTiGDoREvN7UMrVhC4ui+LOkf+Zxr6+BMU5luAP
         25Tgy6lkQnOX4yYIzO+FUIfknRzskGnydwkaSjOSjcJx7AHUbkuF+xtzhZmoddVznF8e
         htHg==
X-Gm-Message-State: AGRZ1gKa3TmAlmJxpdljol9cs0EWiXiaPfzBbGy9ltia2iuUeJ/HYOw7
        q0T7iL5V4WQBbu/BFhAJfGcfBie2
X-Google-Smtp-Source: AJdET5chSY4B3kE7HXyhpk+RpCC2ovvhx0XqQIlTzxOnhUctLBnrcF00X9t4dCkpzpJhDtL0oq70LA==
X-Received: by 2002:a81:ae64:: with SMTP id g36-v6mr5335076ywk.370.1541700001658;
        Thu, 08 Nov 2018 10:00:01 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id m16-v6sm3285567ywh.18.2018.11.08.10.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 10:00:00 -0800 (PST)
Subject: Re: [PATCH] net: phy: leds: Don't make our own link speed names
To:     Kyle Roeschley <kyle.roeschley@ni.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181108175106.25684-1-kyle.roeschley@ni.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <fa2751d5-a15c-6414-9b80-15f54fd9f135@gmail.com>
Date:   Thu, 8 Nov 2018 09:59:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108175106.25684-1-kyle.roeschley@ni.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 9:51 AM, Kyle Roeschley wrote:
> The phy core provides a handy phy_speed_to_str() helper, so use that
> instead of doing our own formatting of the different known link speeds.

In case the speed is not supported, phy_speed_to_str() would return
"Unsupported (update phy-core.c)" which is bigger (by 21 characters)
than name_suffix.

If you bumped name_suffix/PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE to 11
characters, that would be just large enough to accommodate for the
"Unsupported" part of the string and that might be an acceptable
solution in between.

> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> ---
>  drivers/net/phy/phy_led_triggers.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
> index 491efc1bf5c4..2827eb413c9c 100644
> --- a/drivers/net/phy/phy_led_triggers.c
> +++ b/drivers/net/phy/phy_led_triggers.c
> @@ -77,20 +77,9 @@ static int phy_led_trigger_register(struct phy_device *phy,
>  				    struct phy_led_trigger *plt,
>  				    unsigned int speed)
>  {
> -	char name_suffix[PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE];
> -
>  	plt->speed = speed;
> -
> -	if (speed < SPEED_1000)
> -		snprintf(name_suffix, sizeof(name_suffix), "%dMbps", speed);
> -	else if (speed == SPEED_2500)
> -		snprintf(name_suffix, sizeof(name_suffix), "2.5Gbps");
> -	else
> -		snprintf(name_suffix, sizeof(name_suffix), "%dGbps",
> -			 DIV_ROUND_CLOSEST(speed, 1000));
> -
>  	phy_led_trigger_format_name(phy, plt->name, sizeof(plt->name),
> -				    name_suffix);
> +				    phy_speed_to_str(speed));
>  	plt->trigger.name = plt->name;
>  
>  	return led_trigger_register(&plt->trigger);
> 


-- 
Florian

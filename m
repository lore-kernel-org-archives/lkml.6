Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C678C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA65524899
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My3EjFXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA65524899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeGBUYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:24:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35423 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeGBUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:24:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id h40-v6so5643570wrh.2;
        Mon, 02 Jul 2018 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8yQ9Eu9kml5Ye2mvxhNMBKjrTnAAq3PALfskOH4Xr8M=;
        b=My3EjFXe25uTcN34KYjlSnNBJ7gOeF3GHpvvX07OIsl2iHdtayJjaxEoWwfNzuXzyi
         cOjemK+XfbL1WRZQ+FI/+d1SpDJAiqSz2ndIyFdwvv/7L625dh5tssCpgL4biyPbTlos
         scBhVlg9+dOEYj2YO7NC6W2FtlPdrFHt5pZflFwSrgsM2ApevIL3se1qybuH4ZlbtWI0
         Rr/Kyi9QjMOw9YCDHAu593Cu8vrxhO7LqIZ/SICkbUJ0+qw051DLq8BbQxMi3IOLeHky
         ZkZW4LMQOetJ59j/mLIKdHvjI/tpNgopRwOUfNIff2YScsPYlFabOhUUK2atR3ga8v18
         EHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8yQ9Eu9kml5Ye2mvxhNMBKjrTnAAq3PALfskOH4Xr8M=;
        b=AkJKgIef/+mCAU/0X6oEakrus4PCVHsQ9uk0E1T2FhNqvqUAoTPbE8ExTBjf3YeQ5p
         SaQC7G4s+K0CkUxE1iij3J7IqyN6bQHqGSyi7qbkx8DlUuf0a8HSQXrC8ZIYlD4npizX
         OHx3hefWqFu8bvkKTRQM2+ZtN6p5XdbPKg1+4YJS12woa25kwTARK5VK3GZcQ+4Ru3Zo
         /HNhmv1iGTjVCHWcu6vjNus6S+1lz5dr874Xy7ku+K6gETJdWG5vQr+BUrzdk82WA2q+
         ix9sDsj6+xGciCV6iJW2ODyt12Kl/ZMoYEqQj4uFu1xWnwtAvS3dZuIdtXPx/U08hUZH
         jxJQ==
X-Gm-Message-State: APt69E1c68ucxlyEEKpQBJoOeTS3C6yewJDDebizHL+3bpGOvyhv7EZu
        FjUKxLx2UOUgdY71G25yuFalF7hq
X-Google-Smtp-Source: AAOMgpf37j0FXIzdwId37rwZtEfxYrZnYNNohgqjBAh6tL3uuSUlO+21xMVRLW9cPKT+KKEXsj1zhg==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr22317233wrd.176.1530563068075;
        Mon, 02 Jul 2018 13:24:28 -0700 (PDT)
Received: from [192.168.1.18] (cji33.neoplus.adsl.tpnet.pl. [83.31.58.33])
        by smtp.gmail.com with ESMTPSA id b190-v6sm11604759wma.24.2018.07.02.13.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:24:27 -0700 (PDT)
Subject: Re: [PATCH] leds: max8997: use mode when calling max8997_led_set_mode
To:     Colin King <colin.king@canonical.com>, Pavel Machek <pavel@ucw.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702165037.20035-1-colin.king@canonical.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <553beb33-87cd-fdf5-c287-cc6ff8b6c5be@gmail.com>
Date:   Mon, 2 Jul 2018 22:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702165037.20035-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for the patch.

On 07/02/2018 06:50 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable mode is assigned to pdata->led_pdata->mode[led->id] and yet
> is not being used when calling function max8997_led_set_mode. Fix
> this by using mode when calling max8997_led_set_mode.
> 
> Cleans up clang warning:
> warning: variable 'mode' set but not used [-Wunused-but-set-variable]
> 
> Fixes: 8584cb82f151 ("leds: Add suuport for MAX8997-LED driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/leds/leds-max8997.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
> index 4edf74f1d6d4..8c019c28f9f5 100644
> --- a/drivers/leds/leds-max8997.c
> +++ b/drivers/leds/leds-max8997.c
> @@ -268,7 +268,7 @@ static int max8997_led_probe(struct platform_device *pdev)
>   		mode = pdata->led_pdata->mode[led->id];
>   		brightness = pdata->led_pdata->brightness[led->id];
>   
> -		max8997_led_set_mode(led, pdata->led_pdata->mode[led->id]);
> +		max8997_led_set_mode(led, mode);
>   
>   		if (brightness > led->cdev.max_brightness)
>   			brightness = led->cdev.max_brightness;
> 

Applied.

-- 
Best regards,
Jacek Anaszewski

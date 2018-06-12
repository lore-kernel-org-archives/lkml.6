Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0EA00C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5371208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3I4bbWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5371208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeFLNTB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:19:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37298 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934164AbeFLNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:18:58 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so11200033pfn.4;
        Tue, 12 Jun 2018 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BVIBmjLWRYL5yrBXgx83MUIZZNsmlXwOxnK1wd67U/4=;
        b=C3I4bbWoTTLz7/4nDMoINCyME/RKDJNO2FK2SCOUgUoCR+2zzHyz3/hlPnd3AGBrHd
         9aa7mB8x/IPXVSHiMKlylRYzyBypswzi37/qdJAX58BKHmRPWMh1zUrE7OqchsnIxL3/
         TN+2PKyftdf18pH7dVjrWnTCTLvp6L5ROQ/as7inIXTY33SAxUsW5YoIArv0ihjYqY5y
         bdJgIy3SSJfzxgXIMV6mSuXN1APLGhU23/voE88WVjwfpDyVDQEmTIQyxWOD+putt6O8
         PGIkoeUSL+0kck5H9kSulWx3/ldUNhhkGzDl0wsys2Lozcc1//6erZahYIzVTTjq28pu
         lm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BVIBmjLWRYL5yrBXgx83MUIZZNsmlXwOxnK1wd67U/4=;
        b=gThdiiSEoNfBIPyPsEvAnyhEpN/Q39r7h/9px2cmq+QGWfW9F/FQe+j3lSP/NugsNh
         M7F+esm22KnRw8/dXy9NDHB3ntv/TjHZzKDVm+HPEaDvf7+rBfWmmgrYptRXKSqStJu6
         UYALY4rTv+f2QJSEP2+4ePHrS9CxLIb47bDuZ9ZT3QmgLi2heaSgvP8ftBxw6ln8xFzc
         TBbw/hWNOJic3ykVWbpqKNpd/6luBdRvZVDivAYBrqsFLWaUIrDiRWratblbWBsIj8Ux
         idU3hMhoANVO9z/v1RVyylld/9bmM+wSbwh2zU8gxl61cN3Ex8eKQZx4P4yMKjo8vXgy
         KlQg==
X-Gm-Message-State: APt69E2ysve2HBhLPLK+bMOK6f8PvYOY7PR2AWChHu3ojjc72IcnRhUi
        986ureC/ByofKdWaR9DQaDLnww==
X-Google-Smtp-Source: ADUXVKLZFd+ee+mili82GAJnNqdOQrMyqgOqZszNJZUps56ZcKKG69PJndciK6TO/vPpRGM5NU6qVw==
X-Received: by 2002:a62:8b0a:: with SMTP id j10-v6mr411318pfe.28.1528809537336;
        Tue, 12 Jun 2018 06:18:57 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k84-v6sm353727pfh.110.2018.06.12.06.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 06:18:56 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (w83792d) add error handling for i2c_new_dummy
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528774289-38443-1-git-send-email-jiazhouyang09@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8cdd8a0b-00e9-7e47-d0e2-bb43bab8fcce@roeck-us.net>
Date:   Tue, 12 Jun 2018 06:18:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528774289-38443-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 08:31 PM, Zhouyang Jia wrote:
> When i2c_new_dummy fails, the lack of error-handling code may
> cause unexpected results.
> 

What are those unexpected results ? The i2c devicees are not really used;
the only reason to allocate them was for address reservation purposes.
This is why the result was ignored, since it does not really matter
for driver operation. I don't see the point of making that fatal.

NACK, sorry.

Guenter

> This patch adds error-handling code after calling i2c_new_dummy.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>   drivers/hwmon/w83792d.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index 76aa39e..2c168c5 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> @@ -961,8 +961,15 @@ w83792d_detect_subclients(struct i2c_client *new_client)
>   	}
>   
>   	val = w83792d_read_value(new_client, W83792D_REG_I2C_SUBADDR);
> -	if (!(val & 0x08))
> +	if (!(val & 0x08)) {
>   		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
> +		if (data->lm75[0] == NULL) {
> +			dev_err(&new_client->dev,
> +				"Failed to allocate I2C device\n");
> +			err = -ENODEV;
> +			goto ERROR_SC_1;
> +		}
> +	}
>   	if (!(val & 0x80)) {
>   		if ((data->lm75[0] != NULL) &&
>   			((val & 0x7) == ((val >> 4) & 0x7))) {
> @@ -974,6 +981,12 @@ w83792d_detect_subclients(struct i2c_client *new_client)
>   		}
>   		data->lm75[1] = i2c_new_dummy(adapter,
>   					      0x48 + ((val >> 4) & 0x7));
> +		if (data->lm75[1] == NULL) {
> +			dev_err(&new_client->dev,
> +				"Failed to allocate I2C device\n");
> +			err = -ENODEV;
> +			goto ERROR_SC_1;
> +		}
>   	}
>   
>   	return 0;
> 


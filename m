Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 817B4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FC9208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="griDQLq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC9208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934096AbeFLNVL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:21:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45586 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932914AbeFLNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:21:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id a22-v6so12100327pfo.12;
        Tue, 12 Jun 2018 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RgInRBpQT6sg6R8yT4L2Icd1MLMzX1xVgfmni35Bzmg=;
        b=griDQLq847e5k08X+D/7GZJJtwJuhUByI4xfOePlnjYoabljWyeTwYQUwUQQSvsZPS
         4P6puLD1hLXuHRsWEo0ksgYf9+xK5exuvcvPboxFaZ8RZSeNL9oX+X2w2EmFn/aP5on1
         tVFxXUGWcjKxHDInXWPLoximgZIGfUkvHV879H8hE+qaWa9tgZWCA5vtkDCZVaAtr5Gq
         ETVCNFaSjBIwe98YD/d9yIgvG1ak0znVKd6msUQhS5xUL0QBhjNbWfT1noqTnQF6Vc2B
         PzzFtmPrVxjfYJLYHzQWOJ7clZ2ft2PPxoVvtpzzLxotGeGoSsFP5X6rrKLr7OFtzrJK
         w1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RgInRBpQT6sg6R8yT4L2Icd1MLMzX1xVgfmni35Bzmg=;
        b=dmf16//FKKntpAYs4MpgqeuhgxmiVl+DDZtmj8wDxVjFy+hAcJrFXT3lc+LR6zpz7k
         Dla1vrEcPimCAVSTtDrY/MCEO52hdCuKIMge8kcFtXU+uEqK/ffmfrPrfFWyh6l55mxo
         OuFEfFYth/3QNOtwydOi8D9ycs7ZjD62kSvg5rMDC/hgURXJHw8RjHKb8M2DVsubhfZo
         meUt4IoEO8oqCD0NA154nuMh5Z96cJRl0k8SFUXWC9kj9SWp457bNbS3amFyaOcVVjD9
         DxkQSl5OdRrOxyLV+edoyecDFn9R0y1trCz8E4CYhebBIokmTZ/OWpnayor8wDas1Qmw
         4f8w==
X-Gm-Message-State: APt69E0KoEJLZswFn21UMg9Q486dPtgLNY9h7NiW4ntbD7FqiZ01fq3F
        6JBMWcZ9oleYbcDvLHIxFTN2ww==
X-Google-Smtp-Source: ADUXVKIMBdR+NECqhREoJPPbEvimwt43xcu8+N/Wv4hnOeXanEZKHzem4Xv5HmLG9Rc3cjc5EEtl6g==
X-Received: by 2002:a63:27c6:: with SMTP id n189-v6mr334915pgn.164.1528809667117;
        Tue, 12 Jun 2018 06:21:07 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c19-v6sm206764pfn.182.2018.06.12.06.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 06:21:06 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (w83793) add error handling for i2c_new_dummy
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528774379-38587-1-git-send-email-jiazhouyang09@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9e38be5c-29d3-b4ec-bc95-e0d0efd49a5d@roeck-us.net>
Date:   Tue, 12 Jun 2018 06:21:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528774379-38587-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 08:32 PM, Zhouyang Jia wrote:
> When i2c_new_dummy fails, the lack of error-handling code may
> cause unexpected results.
> 

There are no unexpected results.

> This patch adds error-handling code after calling i2c_new_dummy.
> 

Making a non-fatal error fatal doesn't serve a useful purpose.

NACK

Guenter

> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>   drivers/hwmon/w83793.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index 0af0f62..4aa3a0e 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -1603,8 +1603,15 @@ w83793_detect_subclients(struct i2c_client *client)
>   	}
>   
>   	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
> -	if (!(tmp & 0x08))
> +	if (!(tmp & 0x08)) {
>   		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (tmp & 0x7));
> +		if (data->lm75[0] == NULL) {
> +			dev_err(&client->dev,
> +				"Failed to allocate I2C device\n");
> +			err = -ENODEV;
> +			goto ERROR_SC_1;
> +		}
> +	}
>   	if (!(tmp & 0x80)) {
>   		if ((data->lm75[0] != NULL)
>   		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
> @@ -1616,6 +1623,12 @@ w83793_detect_subclients(struct i2c_client *client)
>   		}
>   		data->lm75[1] = i2c_new_dummy(adapter,
>   					      0x48 + ((tmp >> 4) & 0x7));
> +		if (data->lm75[1] == NULL) {
> +			dev_err(&client->dev,
> +				"Failed to allocate I2C device\n");
> +			err = -ENODEV;
> +			goto ERROR_SC_1;
> +		}
>   	}
>   
>   	return 0;
> 


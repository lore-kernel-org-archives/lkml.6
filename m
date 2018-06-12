Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 04E35C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF34C208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJaciKJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF34C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934112AbeFLNVj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:21:39 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44643 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932914AbeFLNVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:21:35 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so14376796plk.11;
        Tue, 12 Jun 2018 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WqmRilmFRT1+DCsvY5XTNbY3+nE9CKavlqgKGk+XqVk=;
        b=fJaciKJIcCb0L3jLfpgsIz4xwTsdqB3YkOrcp17DBT4F4bmjRqAcehqPc1U+9uavGI
         mJuEj8vSrlB5LoWn2x0/o0dwiuAYnDCU1tQQvf2y1sjGLy+cArt6qQU1oP7T+5A96iZi
         xa5+/epqDx21zpsw63dOLXKpqzCpP6AFpBkQ6P/kBgifp2aHuJLhC/keAf0vudNN1Bdt
         ImY2QTq+OZB7ztWb9EwFAENL2ISgPdUVif0vJy6v9aqy2toh2CBeulM6ml5A8zmJaSsk
         PJx87Eu5I7/8KuSfTi2smHR4EcoY9LzC+1RLUgUe61BkhnpGjqGvLgMuMUYKJAKdLkli
         TZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WqmRilmFRT1+DCsvY5XTNbY3+nE9CKavlqgKGk+XqVk=;
        b=uC2oGYRs8VfvXyIeOdWwYq7hHnC3Q5TYaHy38ZMn9xCpCBR/LLzf9tZ1R70HgYuLCU
         iuhlX+cnOXN/ks3nb1USyVd2Uc31P3macrGRqyVOkYZsxoHoBHegKTGsDqRneNnHg/3j
         FDyUjo7/03BZmk9a9le4Muc3JRbEI1hIo7z4pD3UZxGQdq0Ar4SIxxDeV9y0L3A59nTt
         ZEcRHMh5o2XOWiS96Qp6z+nKBbvG9pQq9t+T6h78d+oS4EiIRw16jaU2AlSmOWKjVyM4
         51Q6QZ8Xa7hfOEafXRV7BPn71KRNYZaU9NQbZh1y6UDNjudiNoXJ5FBM7jeGBMLKJuvc
         eVqA==
X-Gm-Message-State: APt69E0DPc8pNrLw1UHWC4xAhAtwP2nM8xgIeFZWcW/9Ym4fAwljx1No
        HeC5WtDN9pyB9hMANCVTjuJnRQ==
X-Google-Smtp-Source: ADUXVKL4NINq//tXAMRjRdkLX9bRe7xQC75hzwioMASQJco8UmkeURQVXmJQndYdXGR0dhmsleuw3A==
X-Received: by 2002:a17:902:8:: with SMTP id 8-v6mr384297pla.287.1528809694832;
        Tue, 12 Jun 2018 06:21:34 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e192-v6sm217954pfg.187.2018.06.12.06.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 06:21:34 -0700 (PDT)
Subject: Re: [PATCH] hwmon: (w83791d) add error handling for i2c_new_dummy
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Marc Hulsman <m.hulsman@tudelft.nl>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528774504-38755-1-git-send-email-jiazhouyang09@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <902c09d8-57a3-442c-2e87-489be5727769@roeck-us.net>
Date:   Tue, 12 Jun 2018 06:21:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528774504-38755-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 08:35 PM, Zhouyang Jia wrote:
> When i2c_new_dummy fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling i2c_new_dummy.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>

As before, NACK, sorry.

Guenter

> ---
>   drivers/hwmon/w83791d.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
> index 28fa3bd..a183432 100644
> --- a/drivers/hwmon/w83791d.c
> +++ b/drivers/hwmon/w83791d.c
> @@ -1295,8 +1295,15 @@ static int w83791d_detect_subclients(struct i2c_client *client)
>   	}
>   
>   	val = w83791d_read(client, W83791D_REG_I2C_SUBADDR);
> -	if (!(val & 0x08))
> +	if (!(val & 0x08)) {
>   		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
> +		if (data->lm75[0] == NULL) {
> +			dev_err(&client->dev,
> +				"Failed to allocate I2C device\n");
> +			err = -ENODEV;
> +			goto error_sc_1;
> +		}
> +	}
>   	if (!(val & 0x80)) {
>   		if ((data->lm75[0] != NULL) &&
>   				((val & 0x7) == ((val >> 4) & 0x7))) {
> @@ -1309,6 +1316,12 @@ static int w83791d_detect_subclients(struct i2c_client *client)
>   		}
>   		data->lm75[1] = i2c_new_dummy(adapter,
>   					      0x48 + ((val >> 4) & 0x7));
> +		if (data->lm75[1] == NULL) {
> +			dev_err(&client->dev,
> +				"Failed to allocate I2C device\n");
> +			err = -ENODEV;
> +			goto error_sc_1;
> +		}
>   	}
>   
>   	return 0;
> 


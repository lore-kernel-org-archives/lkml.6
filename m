Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF55C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7305521773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfBIKZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 05:25:32 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:50912 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfBIKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 05:25:31 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43xSqX5LlBz1qwdT;
        Sat,  9 Feb 2019 11:25:28 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43xSqX52Xzz1qr5s;
        Sat,  9 Feb 2019 11:25:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 9IL7J2ak4fhu; Sat,  9 Feb 2019 11:25:27 +0100 (CET)
X-Auth-Info: fRH28/pkpJG0nvtF8+S2hxmg4SDSEgBcWTika5uSMRo=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  9 Feb 2019 11:25:27 +0100 (CET)
Subject: Re: [PATCH] Input: ili210x - switch to using devm_device_add_group()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190207062746.GA30406@dtor-ws>
From:   Marek Vasut <marex@denx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=marex@denx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <434984d5-69e1-edef-fa9c-e658c4e4a407@denx.de>
Date:   Sat, 9 Feb 2019 11:16:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207062746.GA30406@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 7:27 AM, Dmitry Torokhov wrote:
> By switching to devm_device_add_group() we can complete driver conversion
> to using managed resources and get rid of ili210x_i2c_remove().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/ili210x.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
> index 6cfe463ac118..af1dd9cff12a 100644
> --- a/drivers/input/touchscreen/ili210x.c
> +++ b/drivers/input/touchscreen/ili210x.c
> @@ -376,7 +376,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
> +	error = devm_device_add_group(dev, &ili210x_attr_group);
>  	if (error) {
>  		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
>  			error);
> @@ -386,7 +386,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  	error = input_register_device(priv->input);
>  	if (error) {
>  		dev_err(dev, "Cannot register input device, err: %d\n", error);
> -		goto err_remove_sysfs;
> +		return error;
>  	}
>  
>  	device_init_wakeup(dev, 1);
> @@ -396,17 +396,6 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  		client->irq, firmware.id, firmware.major, firmware.minor);
>  
>  	return 0;
> -
> -err_remove_sysfs:
> -	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
> -	return error;
> -}
> -
> -static int ili210x_i2c_remove(struct i2c_client *client)
> -{
> -	sysfs_remove_group(&client->dev.kobj, &ili210x_attr_group);
> -
> -	return 0;
>  }
>  
>  static int __maybe_unused ili210x_i2c_suspend(struct device *dev)
> @@ -454,7 +443,6 @@ static struct i2c_driver ili210x_ts_driver = {
>  	},
>  	.id_table = ili210x_i2c_id,
>  	.probe = ili210x_i2c_probe,
> -	.remove = ili210x_i2c_remove,
>  };
>  
>  module_i2c_driver(ili210x_ts_driver);
> 

Reviewed-by: Marek Vasut <marex@denx.de>
On ILI251x
Tested-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut

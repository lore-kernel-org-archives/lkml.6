Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C025FC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CDE218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ6UVCVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfAZB3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:29:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34065 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZB3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:29:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so5545477pfg.1;
        Fri, 25 Jan 2019 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=95eqdei5DLy6BvgFDZo7hJh1AsScbmdkLRMn+AGD90I=;
        b=FZ6UVCVXzywChXyCA3MNteF3ehR/o+8ZU+eiPmvM3G+OKyUTy6oP97hztWIpl+7Gxg
         hzZAAU/q8cZT2G2stqIOmcZLNvq7jSQBW5Hjhbbj1jc9Vz8TdPXQNVN2frgnTgbfWljy
         xjfHCeSXuyCXvb8vsKqQsK9ugGtRfmjez/mnf/UXJlpbyi2PG7qpeZVP13f1/6r7hvJp
         CuQNr2Ds3OdBFFuh2oFjdjUb9oob1fOS284aY+g7m6QBqlBZA+XJglAwU3nC+knN8mRn
         J4Q92KvCe4rGLvxuzC/Zdc2hu40UdziYaH9NSauUrXH4TC0O2vpurg2M1zTejkZT9B9g
         H8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=95eqdei5DLy6BvgFDZo7hJh1AsScbmdkLRMn+AGD90I=;
        b=b8/bPuL2XZjIR4cJcjP3fHoEQorrrCFeUNMlgddyekguPd2WsRRSn7N9m4xv3nK65X
         cBcoQOs71v41MHTTLQxoAIpKKPLKqN/Ag5DUFUxqQFTF2PxZ59iPUHjXv9Qi0BJXusxs
         yTjCzqNvJQDGhHxMlZ+AxFq9S44W7H/6UT+nxLpzVFbCsGBh2sKLYKTwvtiZ85r+mX6H
         F9wJj+3r58q6zLzFLHKZvGcWVvn05Tg+yaSzFO8LpTEmaGhJrkiz7s0h2TSeow+sE/DE
         bYCTpyJO7Q9aeg2NDpJCiP77sFnFJt90jUNAZPo4C4D24RVsjxKIgYzbYhnj+d+c9QBU
         hLCA==
X-Gm-Message-State: AJcUukfVPsWfoVq0WwX9s44wnBhlHAcGU3CMkngSPFaXsFIgN+22qfP4
        t0stcuWKhlvDVNB2jI/2Ry0=
X-Google-Smtp-Source: ALg8bN5dxJyTaMruG21BJzuLXt0toH1XFa+HqypqQQbRtKtpufxAlUaMmT/RexyLGGHAqZ9xpQLMQQ==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr13142482pfw.256.1548466152415;
        Fri, 25 Jan 2019 17:29:12 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q75sm51701501pfa.38.2019.01.25.17.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:29:11 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:29:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] input: misc: bma150: Use managed resources helpers
Message-ID: <20190126012909.GE212026@dtor-ws>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125184400.17669-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125184400.17669-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 07:43:58PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> The driver can be cleaned up by using managed resource helpers
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/misc/bma150.c | 40 +++++++++++++------------------------
>  1 file changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
> index 1efcfdf9f8a8..d101bb0a33d6 100644
> --- a/drivers/input/misc/bma150.c
> +++ b/drivers/input/misc/bma150.c
> @@ -471,7 +471,7 @@ static int bma150_register_input_device(struct bma150_data *bma150)
>  	struct input_dev *idev;
>  	int error;
>  
> -	idev = input_allocate_device();
> +	idev = devm_input_allocate_device(&bma150->client->dev);
>  	if (!idev)
>  		return -ENOMEM;
>  
> @@ -482,10 +482,8 @@ static int bma150_register_input_device(struct bma150_data *bma150)
>  	input_set_drvdata(idev, bma150);
>  
>  	error = input_register_device(idev);
> -	if (error) {
> -		input_free_device(idev);
> +	if (error)
>  		return error;
> -	}
>  
>  	bma150->input = idev;
>  	return 0;
> @@ -496,7 +494,7 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
>  	struct input_polled_dev *ipoll_dev;
>  	int error;
>  
> -	ipoll_dev = input_allocate_polled_device();
> +	ipoll_dev = devm_input_allocate_polled_device(&bma150->client->dev);
>  	if (!ipoll_dev)
>  		return -ENOMEM;
>  
> @@ -511,10 +509,8 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
>  	bma150_init_input_device(bma150, ipoll_dev->input);
>  
>  	error = input_register_polled_device(ipoll_dev);
> -	if (error) {
> -		input_free_polled_device(ipoll_dev);
> +	if (error)
>  		return error;
> -	}
>  
>  	bma150->input_polled = ipoll_dev;
>  	bma150->input = ipoll_dev->input;
> @@ -543,7 +539,8 @@ static int bma150_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	bma150 = kzalloc(sizeof(struct bma150_data), GFP_KERNEL);
> +	bma150 = devm_kzalloc(&client->dev, sizeof(struct bma150_data),
> +			      GFP_KERNEL);
>  	if (!bma150)
>  		return -ENOMEM;
>  
> @@ -556,7 +553,7 @@ static int bma150_probe(struct i2c_client *client,
>  				dev_err(&client->dev,
>  					"IRQ GPIO conf. error %d, error %d\n",
>  					client->irq, error);
> -				goto err_free_mem;
> +				return error;
>  			}
>  		}
>  		cfg = &pdata->cfg;
> @@ -566,14 +563,14 @@ static int bma150_probe(struct i2c_client *client,
>  
>  	error = bma150_initialize(bma150, cfg);
>  	if (error)
> -		goto err_free_mem;
> +		return error;
>  
>  	if (client->irq > 0) {
>  		error = bma150_register_input_device(bma150);
>  		if (error)
> -			goto err_free_mem;
> +			return error;
>  
> -		error = request_threaded_irq(client->irq,
> +		error = devm_request_threaded_irq(&client->dev, client->irq,
>  					NULL, bma150_irq_thread,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					BMA150_DRIVER, bma150);
> @@ -582,12 +579,12 @@ static int bma150_probe(struct i2c_client *client,
>  				"irq request failed %d, error %d\n",
>  				client->irq, error);
>  			input_unregister_device(bma150->input);

No need to unregister manually if you are using devm.

> -			goto err_free_mem;
> +			return error;
>  		}
>  	} else {
>  		error = bma150_register_polled_device(bma150);
>  		if (error)
> -			goto err_free_mem;
> +			return error;
>  	}
>  
>  	i2c_set_clientdata(client, bma150);
> @@ -595,10 +592,6 @@ static int bma150_probe(struct i2c_client *client,
>  	pm_runtime_enable(&client->dev);
>  
>  	return 0;
> -
> -err_free_mem:
> -	kfree(bma150);
> -	return error;
>  }
>  
>  static int bma150_remove(struct i2c_client *client)
> @@ -607,15 +600,10 @@ static int bma150_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  
> -	if (client->irq > 0) {
> -		free_irq(client->irq, bma150);
> +	if (client->irq > 0)
>  		input_unregister_device(bma150->input);

Here as well.

> -	} else {
> +	else
>  		input_unregister_polled_device(bma150->input_polled);

And here.

> -		input_free_polled_device(bma150->input_polled);
> -	}
> -
> -	kfree(bma150);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry

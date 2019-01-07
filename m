Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BCDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC0D2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZaWVIwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfAGLMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:12:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51368 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAGLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:12:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so505203wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 03:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4k1mx/xS/sKh0pgKMKHN8BqAkv54xevMNJELxiGyu3c=;
        b=VZaWVIwxzIg05KZgNB8SfvXhKh3kzOGFzajIU6bIrEFdGWgaOUeBdgLr/b4o92/xoV
         2Lv3GbX9DcNzVnBymwBvAZF84J6IvdGEJpoKPuvVvLrfYklQz1bFg3a0p33S8ds/FLXv
         +SjX3N/4Zk0b5SCu0bM8f1Mem/sEZYHjs0VPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4k1mx/xS/sKh0pgKMKHN8BqAkv54xevMNJELxiGyu3c=;
        b=R8fJmrPPD0+qjuh27jNIhzqQDV46JTgPRiuLZUBorySFggcYajgAO2evMqb2QNuRpE
         AStnVC0Xgl2Zdgh8+NpaxHCzTFtAhTxpZuF2G7SXWIC3MhvFbtJl6sbuKTjKAEZQFW4p
         AqGBzOImHRgFnzp+TjVAPC4rJnoCZfiMzDWzWiTosS+TYfsjXaRJ4wARk2ZgXgw1Bin6
         VEXayM+zuAjiCshbMATECHRFSP1sWWGPoR/l9M6tXm7EjoGEZM+OiS4BRedQVZQUEF3t
         O6qD11genSx3GWxRc2wHRkNur6tz4QbXDcEqb/DNzmwLXbGP+VYwnQ9Xiks4SsyfzOsT
         sgzQ==
X-Gm-Message-State: AJcUukcQoVCC3JRaf+9rWTKBzjcC9R0Rng6KYouRd/OImM0qXUvDAjTj
        wWSJ38fPkXj53qYezEvv32zTHg==
X-Google-Smtp-Source: ALg8bN7R7KZJP0lImjGhmW3j9G2LGjgo0VDGSFC+8qEVhSyCrMkifpkq/zxd7QsIBsBHxfPejB9PvA==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr8572558wme.73.1546859537450;
        Mon, 07 Jan 2019 03:12:17 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p139sm14916348wmd.31.2019.01.07.03.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 03:12:16 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:12:14 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v2 bakclight: fix missing checks in
 ambient_light_zone_store
Message-ID: <20190107111214.hl3issz5yzs5muqc@holly.lan>
References: <20190105184807.4827-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105184807.4827-1-pakki001@umn.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 12:48:07PM -0600, Aditya Pakki wrote:
> In adp8870_bl_ambient_light_zone_store, set, clear, and write

I'm curious...

What attracted you to this particular _store function? AFAICT the same
ignoring of return values occurs in other _store functions in this file?


> can return an error but are not checked. The fix adds a check for these
> cases and returns -1 to match the return type (ssize_t).

This isn't right. The caller of the store function expects -errno
values (this is the default for almost all kernel functions).


> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/video/backlight/adp8870_bl.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 8d50e0299578..56a640587a82 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -800,10 +800,14 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
>  
>  	if (val == 0) {
>  		/* Enable automatic ambient light sensing */
> -		adp8870_set_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
> +		ret = adp8870_set_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
> +		if (ret < 0)
> +			goto adp8870_bl_err;

There's nothing *wrong* with goto for error handling but is it
really needed here (there is no recovery code)?


>  	} else if ((val > 0) && (val < 6)) {
>  		/* Disable automatic ambient light sensing */
> -		adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
> +		ret = adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
> +		if (ret < 0)
> +			goto adp8870_bl_err;

+1

>  
>  		/* Set user supplied ambient light zone */
>  		mutex_lock(&data->lock);
> @@ -811,12 +815,18 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
>  		if (!ret) {
>  			reg_val &= ~(CFGR_BLV_MASK << CFGR_BLV_SHIFT);
>  			reg_val |= (val - 1) << CFGR_BLV_SHIFT;
> -			adp8870_write(data->client, ADP8870_CFGR, reg_val);
> +			ret = adp8870_write(data->client, ADP8870_CFGR,
> +						reg_val);
>  		}
>  		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			goto adp8870_bl_err;

+1


Daniel.

>  	}
>  
>  	return count;
> +
> +adp8870_bl_err:
> +	return -1;
>  }
>  static DEVICE_ATTR(ambient_light_zone, 0664,
>  		adp8870_bl_ambient_light_zone_show,
> -- 
> 2.17.1
> 

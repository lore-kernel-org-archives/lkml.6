Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE29218AD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1M2XDxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfAGLN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:13:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34890 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAGLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:13:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so9372wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3pA23E08Ou4UE/RK4r5ROnSTnHv7+wxUPxO9WtpgEfg=;
        b=U1M2XDxCkrkb/9X5OuOqq9cer2Z46FPwnTFV/vtOM7B/BPCjFl65JqpajjTqAR/B7W
         qvEHX4xf9VVAgSCS+Eu7G0+9PDF1wKPwFiMgS+y8WbHJx1wstOy6Bq9IZlPr8iuQm5A4
         a5lcNNoqrko6uCxd0gSrAVf/x7AkEULIRpzxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pA23E08Ou4UE/RK4r5ROnSTnHv7+wxUPxO9WtpgEfg=;
        b=MJ3uklF2lR/k6FQX7/UIgZ+2uYhX0vTBw8LzuQTMo3lYQh/CyKZABZFHEf5Vf2Atbv
         fmcX9Nq1IOyHDiTNKPDxr9wuD7LuIX71RnZJeqYANPrJtICAI18QamTVcJbtqn+2jtIw
         hKQupy2TMfne2ZM1YsFcYdm8k6snmhsTboQmTadvZjYMUCHiAgdyYZWKVVCOq1IiQmEj
         DuFlzzC0JJeoKhgCV+FlsNiRW9EJJEpyTAgTUzEFWlrlbzno2dfqVgeBqrVvdxh41FZ1
         x9aXhBJ89jTzpfTCiEwNUEtnhu4bZBbAy3QiRFc4D69IJ32ID+tlq6rsn140diLyqola
         Dywg==
X-Gm-Message-State: AJcUukfjPXKxsnFfkSuUFQJyoTwmxMV0heE6n/YSIxBER6H7DFIIxEwV
        tyHyFt66UMUlT+iFIo0D/dhQ4A==
X-Google-Smtp-Source: ALg8bN7REPLoDRjO0dnGcCTUS4EjNzRRKKZD4A0e1ocPcz1astS4eLLM0DXaL8q/JXOL6S+Gibuh6w==
X-Received: by 2002:adf:e891:: with SMTP id d17mr55318752wrm.140.1546859604573;
        Mon, 07 Jan 2019 03:13:24 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m6sm42275336wrv.24.2019.01.07.03.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 03:13:23 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:13:21 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v2 bakclight: fix missing checks in
 ambient_light_zone_store
Message-ID: <20190107111321.7d57uqvfdgz5sfb3@holly.lan>
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
> can return an error but are not checked. The fix adds a check for these
> cases and returns -1 to match the return type (ssize_t).

Sorry... missed this before but there is also a typo in the Subject:
line.


Daniel.

> 
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
>  	} else if ((val > 0) && (val < 6)) {
>  		/* Disable automatic ambient light sensing */
> -		adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
> +		ret = adp8870_clr_bits(data->client, ADP8870_MDCR, CMP_AUTOEN);
> +		if (ret < 0)
> +			goto adp8870_bl_err;
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

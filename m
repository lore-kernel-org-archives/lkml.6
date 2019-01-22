Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D78C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E9A217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548180211;
	bh=J2livDvCOaorraNLJqLwWTdjdl4p3HtHZyvR1MZBkvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kzyiM/xrhD2mGv3k0p6991tZEIElg67PBz7rFsWkAclaaawHyBuhlhfzATfT5ZnKS
	 /whfk3jzJ7O/rAxH8o3QSSUI9MKf8FJ0BTC08d1WsNHPoW0j9nLclWbWq7toPKZDy/
	 9o6cqbFK46QVBGVu3sbeH6KsIMtzGT9IJ1RBb3J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfAVSD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:03:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45430 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfAVSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:03:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so21416425ljd.12;
        Tue, 22 Jan 2019 10:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E3FFYJpxjt1KqLVB3Vwz0+MbFkyksMYoRu2AMp2Ajwg=;
        b=GUUAXHtz3bP4CsM5cDe7B/MzwVQIgls4GEiiX9uniVvoIUZx6UycNk/cWh3dbuD6E7
         54XTm2cHe7uU46AFvRv8aLGGmVjOxR1P3WZmaiqFJKidy9Fqt2vOKWIWHfdxswXcLC9X
         YiGIVoH/wIJI9Q8hslQ71jv6VC7zLP0Cy4/5K/egMzN4Cdm7KDS34S+jFfuoukhwfL28
         8AirxWdV2TWYiW4OEs/YdIkIdzepUwI2iBw4EAACG0VcbavI4MehWVhxynnZeX/ycb09
         m0XkGaiXzHGMS7FzMFvk/oS8bxK4YgA8W4VG3VCWdZvAnLBU/pteH3Ox6aJAY3CltacB
         +o6g==
X-Gm-Message-State: AJcUukeoA163BOsVKjs4FZbdSLVvMlUEkRsIC7a4g3U6H6m40w/oFVpW
        3gGXMXh001PmWWekuJlANZjzb7HK
X-Google-Smtp-Source: ALg8bN7jpe+3d2IYM9z7NP1rduyONvMuQfIG2zV+stNfdXgdKKnwHRqxjOJKTEpp2c5vcON5271JhQ==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr18590396ljh.15.1548180205032;
        Tue, 22 Jan 2019 10:03:25 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x29-v6sm105718ljb.97.2019.01.22.10.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:03:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gm0OP-0004ta-4o; Tue, 22 Jan 2019 19:03:21 +0100
Date:   Tue, 22 Jan 2019 19:03:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] gnss: sirf: add a separate supply for a lna
Message-ID: <20190122180321.GS3691@localhost>
References: <20190116211812.6337-1-andreas@kemnade.info>
 <20190116211812.6337-6-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116211812.6337-6-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:18:11PM +0100, Andreas Kemnade wrote:
> Devices might have a separate lna between antenna input of the gps
> chip and the antenna which might have a separate supply.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v3:
>  - improved error checking
>  - style cleanup
> 
> Changes in v2:
>  - handle lna also if there is no on-off gpio
>  - rebase on changed 2/5
> 
>  drivers/gnss/sirf.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index 943a2ec9b708..7de98edf198a 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -41,6 +41,7 @@ struct sirf_data {
>  	struct serdev_device *serdev;
>  	speed_t	speed;
>  	struct regulator *vcc;
> +	struct regulator *lna;
>  	struct gpio_desc *on_off;
>  	struct gpio_desc *wakeup;
>  	int irq;
> @@ -293,21 +294,52 @@ static int sirf_set_active(struct sirf_data *data, bool active)
>  static int sirf_runtime_suspend(struct device *dev)
>  {
>  	struct sirf_data *data = dev_get_drvdata(dev);
> +	int ret;
>  
> -	if (!data->on_off)
> -		return regulator_disable(data->vcc);
> +	if (data->on_off)
> +		ret = sirf_set_active(data, false);
> +	else
> +		ret = regulator_disable(data->vcc);
> +
> +	if (ret)
> +		return ret;
>  
> -	return sirf_set_active(data, false);
> +	ret = regulator_disable(data->lna);
> +	if (ret) {

Use an error label for this to avoid the indentation.

> +		int reenable_ret;

Rename ret2 and move to start of function.

> +
> +		if (data->on_off)
> +			reenable_ret = sirf_set_active(data, true);
> +		else
> +			reenable_ret = regulator_enable(data->vcc);
> +
> +		if (reenable_ret)
> +			dev_err(dev,
> +				"failed to reenable power on failed suspend: %d\n",
> +				reenable_ret);
> +	}
> +
> +	return ret;
>  }
>  
>  static int sirf_runtime_resume(struct device *dev)
>  {
>  	struct sirf_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(data->lna);
> +	if (ret)
> +		return ret;
>  
> -	if (!data->on_off)
> -		return regulator_enable(data->vcc);
> +	if (data->on_off)
> +		ret = sirf_set_active(data, true);
> +	else
> +		ret = regulator_enable(data->vcc);
>  
> -	return sirf_set_active(data, true);
> +	if (ret)

Use an error label here too for consistency (and if if ever add further
resources to be manipulated here).

> +		regulator_disable(data->lna);
> +
> +	return ret;
>  }
>  
>  static int __maybe_unused sirf_suspend(struct device *dev)
> @@ -395,6 +427,12 @@ static int sirf_probe(struct serdev_device *serdev)
>  		goto err_put_device;
>  	}
>  
> +	data->lna = devm_regulator_get(dev, "lna");
> +	if (IS_ERR(data->lna)) {
> +		ret = PTR_ERR(data->lna);
> +		goto err_put_device;
> +	}
> +
>  	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
>  			GPIOD_OUT_LOW);
>  	if (IS_ERR(data->on_off))

Johan

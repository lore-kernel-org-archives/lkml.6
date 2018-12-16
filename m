Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647CC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2741B21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544968395;
	bh=rSelNg/IcvBew8ramZ9ws65cEWnm3FdtocmSQlc32iY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ESTeaPrg7zOGuuErwBr9aWQI7UDsJijJrLKBI/XW67mWytYBRgWvNKwP+A5YM243D
	 IEUatLRAZSYOuC4Xqm81P6MygiGMgFVp4fDuUfO5U5MUIbxhF//Zoz0pXRXwAU7JQp
	 +pEhyOulrJLYMpL0m2wVCOT4CRj/KBk0jltu24Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbeLPNxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbeLPNxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:53:14 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB382086C;
        Sun, 16 Dec 2018 13:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544968393;
        bh=rSelNg/IcvBew8ramZ9ws65cEWnm3FdtocmSQlc32iY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zew8IQCkhWXbhXDheuB4B3v6Li5VI8F2s/JYET2FBMNzGwxtqzJpse9Zwzbrpyts4
         bSRyIdoRk8ficX1707jsfn0yTWkG1S4pOP22eo+Xk5u4nFvZLrCnEHU4WAyiCfBFYX
         V8GKHmRf4m7DKlWQGzNfUMkn3mmnmmEZf3uHnMH0=
Date:   Sun, 16 Dec 2018 13:53:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: Re: [PATCH 07/11] staging: iio: adc: ad7606: Use vendor prefix for
 DT properties
Message-ID: <20181216135305.59deb3c5@archlinux>
In-Reply-To: <1544705183-13288-8-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
        <1544705183-13288-8-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 14:46:19 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The 'adi' vendor prefix needs to be added to conversion-start, range,
> first-data and oversampling-ratio properties.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 0925379..3355301 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -322,7 +322,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  {
>  	struct device *dev = st->dev;
>  
> -	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
> +	st->gpio_convst = devm_gpiod_get(dev, "adi,conversion-start",
>  					 GPIOD_OUT_LOW);
>  	if (IS_ERR(st->gpio_convst))
>  		return PTR_ERR(st->gpio_convst);
> @@ -331,7 +331,8 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  	if (IS_ERR(st->gpio_reset))
>  		return PTR_ERR(st->gpio_reset);
>  
> -	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
> +	st->gpio_range = devm_gpiod_get_optional(dev, "adi,range",
> +						 GPIOD_OUT_LOW);
>  	if (IS_ERR(st->gpio_range))
>  		return PTR_ERR(st->gpio_range);
>  
> @@ -340,7 +341,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  	if (IS_ERR(st->gpio_standby))
>  		return PTR_ERR(st->gpio_standby);
>  
> -	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
> +	st->gpio_frstdata = devm_gpiod_get_optional(dev, "adi,first-data",
>  						    GPIOD_IN);
>  	if (IS_ERR(st->gpio_frstdata))
>  		return PTR_ERR(st->gpio_frstdata);
> @@ -348,7 +349,8 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  	if (!st->chip_info->has_oversampling)
>  		return 0;
>  
> -	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
> +	st->gpio_os = devm_gpiod_get_array_optional(dev,
> +						    "adi,oversampling-ratio",
>  						    GPIOD_OUT_LOW);
>  	return PTR_ERR_OR_ZERO(st->gpio_os);
>  }


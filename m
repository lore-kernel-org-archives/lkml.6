Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96649C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A392192B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549729588;
	bh=lfArmp9gKq2w9yF2OtbZGX0njTbCgvS+hs/0pQDIGDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fiYbqVbDtHS18fv/rVcUrqvLyN3ldYtSnZsVY+dtNzGRTTcVOmFpzEVcNMZk2rgsV
	 Mr+zuIkA+hcWOzLQDU5tJ4aE3f1zN14dbize+0cghzRvJjAMZQzUG9rTpwcB4cuiXD
	 fmWJj7HuHjX52LrKmtirjLKYlOH/Mm8Z/2ZVAV9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBIQ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:26:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfBIQ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:26:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC7521919;
        Sat,  9 Feb 2019 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549729584;
        bh=lfArmp9gKq2w9yF2OtbZGX0njTbCgvS+hs/0pQDIGDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tD5jMHyW20vQj1tJDToiJKGsElG+EJyHJiUHldykuqw4wmUuAl331HsHQo5cAIPFC
         N7ugxOn0L1zzKw3WgKmvAfT4zK8qhDHpdlStDjwQkUW6kUaw2XHygVlAbuKAK1ZoW9
         9IteCkfSdRIm42y1wYqobrZtEPJgg0scZumnXivU=
Date:   Sat, 9 Feb 2019 16:26:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 2/4] staging: iio: ad7780: move regulator to after
 GPIO init
Message-ID: <20190209162618.64edd25a@archlinux>
In-Reply-To: <b2380d77d09abdf63d6f6471ed7743f8bec14a29.1549385784.git.renatogeh@gmail.com>
References: <cover.1549385784.git.renatogeh@gmail.com>
        <b2380d77d09abdf63d6f6471ed7743f8bec14a29.1549385784.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 15:13:21 -0200
Renato Lui Geh <renatogeh@gmail.com> wrote:

> To maintain consistency between ad7780_probe and ad7780_remove orders,
> regulator initialization has been moved to after GPIO initializations.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
This looks fine, will pick up with the earlier patches when ready.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 6e4357800d31..7804cd2b273e 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -250,16 +250,6 @@ static int ad7780_probe(struct spi_device *spi)
>  
>  	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
>  
> -	st->reg = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->reg))
> -		return PTR_ERR(st->reg);
> -
> -	ret = regulator_enable(st->reg);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
> -		return ret;
> -	}
> -
>  	st->chip_info =
>  		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>  
> @@ -279,7 +269,7 @@ static int ad7780_probe(struct spi_device *spi)
>  		ret = PTR_ERR(st->powerdown_gpio);
>  		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
>  			ret);
> -		goto error_disable_reg;
> +		return ret;
>  	}
>  
>  	if (st->chip_info->is_ad778x) {
> @@ -290,7 +280,7 @@ static int ad7780_probe(struct spi_device *spi)
>  			ret = PTR_ERR(st->gain_gpio);
>  			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
>  				ret);
> -			goto error_disable_reg;
> +			return ret;
>  		}
>  
>  		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
> @@ -301,10 +291,20 @@ static int ad7780_probe(struct spi_device *spi)
>  			dev_err(&spi->dev,
>  				"Failed to request filter GPIO: %d\n",
>  				ret);
> -			goto error_disable_reg;
> +			return ret;
>  		}
>  	}
>  
> +	st->reg = devm_regulator_get(&spi->dev, "avdd");
> +	if (IS_ERR(st->reg))
> +		return PTR_ERR(st->reg);
> +
> +	ret = regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
> +		return ret;
> +	}
> +
>  	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;


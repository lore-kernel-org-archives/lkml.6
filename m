Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A524CC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D88218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548526882;
	bh=RiFHDPgNqjiIWJq9NDCRl15fKsvGnAl35JrXlrEpFRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Fubrl8glqO2tDsLHcxVkZAKBdjo15aTWInZrTm/yOBVEy16aAG3c3udbzny2So3pa
	 grce5Mid5FHNsrEhcW4D/VX3eHpTCz/Fp2J1AWsVGCLf7p9l9fG1NhdAQe88SSwmo/
	 Oyi1oJ7LekdIbq/5yrTdgODF+8e1i2/39np9+exA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAZSVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfAZSVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 13:21:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151502184C;
        Sat, 26 Jan 2019 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548526879;
        bh=RiFHDPgNqjiIWJq9NDCRl15fKsvGnAl35JrXlrEpFRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sHNCV6jBhyMWa+n0B+kKHWTMAN8DNe5A5TQtfPS+n4DyDcocZfpqGPvgGv8R8J9KO
         sAlVY/l0w3zUWwBZulvq8FryUFUpfV6MTV7TBKs7tk/LzE5q2ExrxxjSjZqrNDcy6a
         EnW1GNBbE31CmuaVliqlqp0I5VXbhJ3lB64WDtv8=
Date:   Sat, 26 Jan 2019 18:21:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7476: Add support for ADS786X ADCs
Message-ID: <20190126182114.15ac673c@archlinux>
In-Reply-To: <20190125100451.15011-1-ricardo@ribalda.com>
References: <20190125100451.15011-1-ricardo@ribalda.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 11:04:51 +0100
Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:

> Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> ADC.
> 
> Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> ---
> v2: I have missnamed the devices
>  drivers/iio/adc/Kconfig  |  3 ++-
>  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f9354e5ee65c..d86900fc2634 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -64,7 +64,8 @@ config AD7476
>  	help
>  	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
>  	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> -	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> +	  AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
> +	  to digital converters (ADC).

As commented in the earlier thread (after you sent this!), please make sure
the help text makes it clear that these aren't all Analog devices parts.

Likely to cause confusion otherwise.

Good to see you didn't spin another driver but instead tracked down that
this one would work well!

Thanks,

Jonathan

>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7476.
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 0549686b9ef8..76747488044b 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
>  	ID_ADC081S,
>  	ID_ADC101S,
>  	ID_ADC121S,
> +	ID_ADS7866,
> +	ID_ADS7867,
> +	ID_ADS7868,
>  };
>  
>  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
> @@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
>  		BIT(IIO_CHAN_INFO_RAW))
>  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> +		BIT(IIO_CHAN_INFO_RAW))
>  
>  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>  	[ID_AD7091R] = {
> @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>  		.channel[0] = ADC081S_CHAN(12),
>  		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>  	},
> +	[ID_ADS7866] = {
> +		.channel[0] = ADS786X_CHAN(12),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	},
> +	[ID_ADS7867] = {
> +		.channel[0] = ADS786X_CHAN(10),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	},
> +	[ID_ADS7868] = {
> +		.channel[0] = ADS786X_CHAN(8),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	},
>  };
>  
>  static const struct iio_info ad7476_info = {
> @@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
>  	{"adc081s", ID_ADC081S},
>  	{"adc101s", ID_ADC101S},
>  	{"adc121s", ID_ADC121S},
> +	{"ads7866", ID_ADS7866},
> +	{"ads7867", ID_ADS7867},
> +	{"ads7868", ID_ADS7868},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad7476_id);


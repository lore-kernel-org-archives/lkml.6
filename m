Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB6EC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F06A21919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549727817;
	bh=buf1gi2Y8ymXRv48z5g3r2fFgvnbxbuMsUUHlqcVba0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VXcXKVR1nydhPfTjZmr2OWvUh1dRyzGranaK/LqFu57cNeekfL4pp/5D2RhrWR88X
	 Kf2Cf9xs6mYtfrMcgo9OF1wx09OYcPGgJosvYFBfSW5VX+Nxd2peklKMyWd8fZM5E7
	 pZCUIaWOcskOVZ10hnrTbvpP69ua+gMYkMbOjAx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBIP44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfBIP4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:56:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51EB4217D8;
        Sat,  9 Feb 2019 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549727814;
        bh=buf1gi2Y8ymXRv48z5g3r2fFgvnbxbuMsUUHlqcVba0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ART72GWsXmhNJrfUlKAlD+fW+ZTl78njHkO07nQNpCO1/CynzyTMldV7O+yIBfM4X
         +44H6ZTj4sIGoJDrFHe83nxq3nnYvpoKJsfHJqaIaguvsNQfsT4A8ZT0IEfPzZFo/A
         j7KMH0h0sXBQiyDSPDxGSYPl5MG6Kuby+BS4Omxc=
Date:   Sat, 9 Feb 2019 15:56:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     linux-iio@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: ad7476: Add support for TI ADS786X ADCs
Message-ID: <20190209155650.12e99647@archlinux>
In-Reply-To: <20190204124441.18079-1-ricardo@ribalda.com>
References: <20190204124441.18079-1-ricardo@ribalda.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 13:44:41 +0100
Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:

> Add support for Texas Instruments ADS7866, ADS7867 and ADS7868
> 8/10/12 bit Single channel ADC.
> 
> Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> v4: Changes by Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> Break Kconfig into a table
> 
>  drivers/iio/adc/Kconfig  | 11 +++++++----
>  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f9354e5ee65c..3d82727fa977 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -57,14 +57,17 @@ config AD7298
>  	  module will be called ad7298.
>  
>  config AD7476
> -	tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
> +	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD an TI"
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
> -	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> -	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> +	  Say yes here to build support for the following SPI analog to
> +	  digital converters (ADCs):
> +	  Analog Devices: AD7273, AD7274, AD7276, AD7277, AD7278, AD7475,
> +	  AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495, AD7910,
> +	  AD7920.
> +	  Texas Instruments: ADS7866, ADS7867, ADS7868.
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


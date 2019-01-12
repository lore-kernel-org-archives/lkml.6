Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A472C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC252086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547319475;
	bh=rsDB393On6co7N5TK8mmmuL05w2x2LiSmKOC9CGOZxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FCLug/YGYxTXIhp7Xp19KXvOgcPgv4x6GcKZ0NtEv7RirIkwg6FnS2LpX32kR0yvb
	 lqSLln6b35s13vJbRdlKqyca88DbAF8Me5dDQjkQ3AXxu1p2WUbX5zXEEIdnSl0q99
	 LMRUsoXEAnq0cNjeVdAiFFrLm+N8smMOdVglCfUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfALS5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfALS5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:57:54 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44CDC20836;
        Sat, 12 Jan 2019 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547319473;
        bh=rsDB393On6co7N5TK8mmmuL05w2x2LiSmKOC9CGOZxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WsCxB/f3keoLgqMDQ6GTRqQz8nZ88NalRVAptMTPdYrQ/BmNcluZFGirVwLHbRAyE
         f5lsy+PetvcyGB0PhX3QnIlT+ei/au+6A29cK32CRZ4u08BmIZKB2oigDEaKy1375d
         o3ZC9UyjDHXQyfndfurGqbVRoNz5wYDCWdseYq+g=
Date:   Sat, 12 Jan 2019 18:57:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5686: Add support for AD5674R/AD5679R
Message-ID: <20190112185749.15eb02e3@archlinux>
In-Reply-To: <20190109091416.12060-1-mircea.caprioru@analog.com>
References: <20190109091416.12060-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 11:14:16 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> The AD5674R/AD5679R are low power, 16-channel, 12-/16-bit buffered voltage
> output digital-to-analog converters (DACs). They include a 2.5 V internal
> reference (enabled by default).
> 
> These devices are very similar to AD5684R/AD5686R, except that they have 16
> channels.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Looks good to me.  

One comment inline, but just ignore it ;)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/Kconfig      |  6 +++---
>  drivers/iio/dac/ad5686-spi.c |  7 ++++--
>  drivers/iio/dac/ad5686.c     | 42 ++++++++++++++++++++++++++++++++++--
>  drivers/iio/dac/ad5686.h     |  2 ++
>  4 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 851b61eaf3da..f28daf67db6a 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -148,9 +148,9 @@ config AD5686_SPI
>  	depends on SPI
>  	select AD5686
>  	help
> -	  Say yes here to build support for Analog Devices AD5672R, AD5676,
> -	  AD5676R, AD5684, AD5684R, AD5684R, AD5685R, AD5686, AD5686R.
> -	  Voltage Output Digital to Analog Converter.
> +	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
> +	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
> +	  AD5686R Voltage Output Digital to Analog Converter.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5686.
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 665fa6bd9ced..4d857c8da2d2 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD5672R, AD5676, AD5676R, AD5681R, AD5682R, AD5683, AD5683R,
> - * AD5684, AD5684R, AD5685R, AD5686, AD5686R
> + * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
> + * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
> + * AD5684R, AD5685R, AD5686, AD5686R
This goes to show that listing the parts supported by the driver at the top
is more trouble than it's worth.  The nice id tables tell us the same
thing and have much less churn ;)

oh well. I don't really care obviously.

>   * Digital to analog converters driver
>   *
>   * Copyright 2018 Analog Devices Inc.
> @@ -102,8 +103,10 @@ static int ad5686_spi_remove(struct spi_device *spi)
>  static const struct spi_device_id ad5686_spi_id[] = {
>  	{"ad5310r", ID_AD5310R},
>  	{"ad5672r", ID_AD5672R},
> +	{"ad5674r", ID_AD5674R},
>  	{"ad5676", ID_AD5676},
>  	{"ad5676r", ID_AD5676R},
> +	{"ad5679r", ID_AD5679R},
>  	{"ad5681r", ID_AD5681R},
>  	{"ad5682r", ID_AD5682R},
>  	{"ad5683", ID_AD5683},
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index a332b93ca2c4..6dd2759b9092 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -71,7 +71,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	int ret;
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  	unsigned int val, ref_bit_msk;
> -	u8 shift;
> +	u8 shift, address = 0;
>  
>  	ret = strtobool(buf, &readin);
>  	if (ret)
> @@ -94,6 +94,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	case AD5686_REGMAP:
>  		shift = 0;
>  		ref_bit_msk = 0;
> +		/* AD5674R/AD5679R have 16 channels and 2 powerdown registers */
> +		if (chan->channel > 0x7)
> +			address = 0x8;
>  		break;
>  	case AD5693_REGMAP:
>  		shift = 13;
> @@ -107,7 +110,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (!st->use_internal_vref)
>  		val |= ref_bit_msk;
>  
> -	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, 0, val);
> +	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC,
> +			address, val >> (address * 2));
>  
>  	return ret ? ret : len;
>  }
> @@ -226,10 +230,32 @@ static struct iio_chan_spec name[] = {				\
>  		AD5868_CHANNEL(7, 7, bits, _shift),		\
>  }
>  
> +#define DECLARE_AD5679_CHANNELS(name, bits, _shift)		\
> +static struct iio_chan_spec name[] = {				\
> +		AD5868_CHANNEL(0, 0, bits, _shift),		\
> +		AD5868_CHANNEL(1, 1, bits, _shift),		\
> +		AD5868_CHANNEL(2, 2, bits, _shift),		\
> +		AD5868_CHANNEL(3, 3, bits, _shift),		\
> +		AD5868_CHANNEL(4, 4, bits, _shift),		\
> +		AD5868_CHANNEL(5, 5, bits, _shift),		\
> +		AD5868_CHANNEL(6, 6, bits, _shift),		\
> +		AD5868_CHANNEL(7, 7, bits, _shift),		\
> +		AD5868_CHANNEL(8, 8, bits, _shift),		\
> +		AD5868_CHANNEL(9, 9, bits, _shift),		\
> +		AD5868_CHANNEL(10, 10, bits, _shift),		\
> +		AD5868_CHANNEL(11, 11, bits, _shift),		\
> +		AD5868_CHANNEL(12, 12, bits, _shift),		\
> +		AD5868_CHANNEL(13, 13, bits, _shift),		\
> +		AD5868_CHANNEL(14, 14, bits, _shift),		\
> +		AD5868_CHANNEL(15, 15, bits, _shift),		\
> +}
> +
>  DECLARE_AD5693_CHANNELS(ad5310r_channels, 10, 2);
>  DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
>  DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
> +DECLARE_AD5679_CHANNELS(ad5674r_channels, 12, 4);
>  DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
> +DECLARE_AD5679_CHANNELS(ad5679r_channels, 16, 0);
>  DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
>  DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
>  DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
> @@ -262,6 +288,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.num_channels = 8,
>  		.regmap_type = AD5686_REGMAP,
>  	},
> +	[ID_AD5674R] = {
> +		.channels = ad5674r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 16,
> +		.regmap_type = AD5686_REGMAP,
> +	},
>  	[ID_AD5675R] = {
>  		.channels = ad5676_channels,
>  		.int_vref_mv = 2500,
> @@ -279,6 +311,12 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  		.num_channels = 8,
>  		.regmap_type = AD5686_REGMAP,
>  	},
> +	[ID_AD5679R] = {
> +		.channels = ad5679r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 16,
> +		.regmap_type = AD5686_REGMAP,
> +	},
>  	[ID_AD5681R] = {
>  		.channels = ad5691r_channels,
>  		.int_vref_mv = 2500,
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 19f6917d4738..4c3e171ce0cc 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -54,9 +54,11 @@ enum ad5686_supported_device_ids {
>  	ID_AD5311R,
>  	ID_AD5671R,
>  	ID_AD5672R,
> +	ID_AD5674R,
>  	ID_AD5675R,
>  	ID_AD5676,
>  	ID_AD5676R,
> +	ID_AD5679R,
>  	ID_AD5681R,
>  	ID_AD5682R,
>  	ID_AD5683,


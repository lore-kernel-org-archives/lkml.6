Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D7C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912912192D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549733197;
	bh=VFI1RUfM6HaoXnpQsDBCxesX/7b0qA/hWh16LJwjWCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=z0145qjol1ZTGI1NR4Vq7oKw1xzTBkHLqSavr11bV6rezONPktE4Up/Ez/2E9al3Z
	 3nOEEnq7wRDveEc4zC5YGqEPjm10n8D4X7pKgNNTneNl0sR+b/ww+qM2/y1sbNcao+
	 Jt1wjfI8zFPQNm+IJ8UOiz6zLLjboq0qM7o3Uw3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfBIR0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfBIR0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:26:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A33A2192B;
        Sat,  9 Feb 2019 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549733194;
        bh=VFI1RUfM6HaoXnpQsDBCxesX/7b0qA/hWh16LJwjWCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zkKy9qS5tAymnhMm8UfXCnCCc4eWcJxHhLMH2s7dSUdmFxiGPMitcEB/vlp3XzOAk
         JQPfSY/vGuMjqhRy/3wFlk4wl4y3o3e73ZLQZeeQ5OGDyqGnpLrh12kV4+DugU8maN
         /mzKHjgYzWkmJL48rVzaJMuIOmtv8raSuQ3iI/vw=
Date:   Sat, 9 Feb 2019 17:26:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Beniamin Bia <biabeniamin@outlook.com>
Subject: Re: [PATCH 1/2] staging: iio: frequency: ad9834: Move frequency to
 standard iio types
Message-ID: <20190209172628.1b36e85a@archlinux>
In-Reply-To: <20190206122542.18362-1-beniamin.bia@analog.com>
References: <20190206122542.18362-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 14:25:41 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Beniamin Bia <biabeniamin@outlook.com>
> 
> Frequency attribute is added with a standard type from iio framework
> instead of custom attribute. This is a small step towards removing any
> unnecessary custom attribute.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

Hi,

How is this related to the one a few hours earlier?
V2?

If you do accidentally send twice (and realise it obviously) please
reply to say what you want ignored. For now I'll ignore this version.

I'm guessing it was fighting with your work email system.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/frequency/ad9834.c | 97 +++++++++++++++++++++-----
>  1 file changed, 80 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f036f75d1f22..370e8263899e 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -29,8 +29,7 @@
>  /* Registers */
>  
>  #define AD9834_REG_CMD		0
> -#define AD9834_REG_FREQ0	BIT(14)
> -#define AD9834_REG_FREQ1	BIT(15)
> +#define AD9834_REG_FREQ(chann)	(BIT(14) << (chann))
>  #define AD9834_REG_PHASE0	(BIT(15) | BIT(14))
>  #define AD9834_REG_PHASE1	(BIT(15) | BIT(14) | BIT(13))
>  
> @@ -81,6 +80,9 @@ struct ad9834_state {
>  	struct spi_message		freq_msg;
>  	struct mutex                    lock;   /* protect sensor state */
>  
> +	unsigned long			frequency0;
> +	unsigned long			frequency1;
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -100,6 +102,25 @@ enum ad9834_supported_device_ids {
>  	ID_AD9838,
>  };
>  
> +#define AD9833_CHANNEL(_chan) {						\
> +		.type = IIO_ALTVOLTAGE,					\
> +		.indexed = 1,						\
> +		.output = 1,						\
> +		.address = (_chan),					\
> +		.channel = (_chan),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
> +}
> +
> +static const struct iio_chan_spec ad9833_channels[] = {
> +	AD9833_CHANNEL(0),
> +	AD9833_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec ad9834_channels[] = {
> +	AD9833_CHANNEL(0),
> +	AD9833_CHANNEL(1),
> +};
> +
>  static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
> @@ -113,6 +134,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  {
>  	unsigned long clk_freq;
>  	unsigned long regval;
> +	int ret;
>  
>  	clk_freq = clk_get_rate(st->mclk);
>  
> @@ -121,13 +143,22 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  
>  	regval = ad9834_calc_freqreg(clk_freq, fout);
>  
> -	st->freq_data[0] = cpu_to_be16(addr | (regval &
> +	st->freq_data[0] = cpu_to_be16(AD9834_REG_FREQ(addr) | (regval &
>  				       RES_MASK(AD9834_FREQ_BITS / 2)));
> -	st->freq_data[1] = cpu_to_be16(addr | ((regval >>
> +	st->freq_data[1] = cpu_to_be16(AD9834_REG_FREQ(addr) | ((regval >>
>  				       (AD9834_FREQ_BITS / 2)) &
>  				       RES_MASK(AD9834_FREQ_BITS / 2)));
>  
> -	return spi_sync(st->spi, &st->freq_msg);
> +	ret = spi_sync(st->spi, &st->freq_msg);
> +	if (ret)
> +		return ret;
> +
> +	if (addr == 0)
> +		st->frequency0 = fout;
> +	else
> +		st->frequency1 = fout;
> +
> +	return 0;
>  }
>  
>  static int ad9834_write_phase(struct ad9834_state *st,
> @@ -140,6 +171,40 @@ static int ad9834_write_phase(struct ad9834_state *st,
>  	return spi_sync(st->spi, &st->msg);
>  }
>  
> +static int ad9834_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad9834_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		if (chan->address == 0)
> +			*val = st->frequency0;
> +		else
> +			*val = st->frequency1;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad9834_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad9834_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		return ad9834_write_frequency(st, chan->address, val);
> +	default:
> +		return  -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static ssize_t ad9834_write(struct device *dev,
>  			    struct device_attribute *attr,
>  			    const char *buf,
> @@ -157,10 +222,6 @@ static ssize_t ad9834_write(struct device *dev,
>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
> -	case AD9834_REG_FREQ0:
> -	case AD9834_REG_FREQ1:
> -		ret = ad9834_write_frequency(st, this_attr->address, val);
> -		break;
>  	case AD9834_REG_PHASE0:
>  	case AD9834_REG_PHASE1:
>  		ret = ad9834_write_phase(st, this_attr->address, val);
> @@ -323,8 +384,6 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
> -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
>  static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
>  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> @@ -342,8 +401,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
>  static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
>  
>  static struct attribute *ad9834_attributes[] = {
> -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
>  	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> @@ -361,8 +418,6 @@ static struct attribute *ad9834_attributes[] = {
>  };
>  
>  static struct attribute *ad9833_attributes[] = {
> -	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_frequency1.dev_attr.attr,
>  	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
> @@ -384,11 +439,15 @@ static const struct attribute_group ad9833_attribute_group = {
>  };
>  
>  static const struct iio_info ad9834_info = {
> +	.write_raw = &ad9834_write_raw,
> +	.read_raw = &ad9834_read_raw,
>  	.attrs = &ad9834_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
>  static const struct iio_info ad9833_info = {
> +	.write_raw = &ad9834_write_raw,
> +	.read_raw = &ad9834_read_raw,
>  	.attrs = &ad9833_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> @@ -435,9 +494,13 @@ static int ad9834_probe(struct spi_device *spi)
>  	switch (st->devid) {
>  	case ID_AD9833:
>  	case ID_AD9837:
> +		indio_dev->channels = ad9833_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad9833_channels);
>  		indio_dev->info = &ad9833_info;
>  		break;
>  	default:
> +		indio_dev->channels = ad9834_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad9834_channels);
>  		indio_dev->info = &ad9834_info;
>  		break;
>  	}
> @@ -474,11 +537,11 @@ static int ad9834_probe(struct spi_device *spi)
>  		goto error_clock_unprepare;
>  	}
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
> +	ret = ad9834_write_frequency(st, 0, 1000000);
>  	if (ret)
>  		goto error_clock_unprepare;
>  
> -	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
> +	ret = ad9834_write_frequency(st, 1, 5000000);
>  	if (ret)
>  		goto error_clock_unprepare;
>  


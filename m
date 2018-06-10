Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cb83JL8eHVsVUwAAmS7hNA
	; Sun, 10 Jun 2018 13:30:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 797BB607BB; Sun, 10 Jun 2018 13:30:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1w+yXXS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAE07600D0;
	Sun, 10 Jun 2018 13:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAE07600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeFJNal (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 09:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753699AbeFJNak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 09:30:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD53E2088E;
        Sun, 10 Jun 2018 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528637439;
        bh=wMkGLaXGMZ0p8Ll+MzSGvllL5UuIitCG8tBTUYMFQI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p1w+yXXS8tJV59u9qlF1rHq9L6R8hqTs5rc5g/svmZLoWpS3JPveI9J7Ew6cIPPsJ
         nutyuUnfurYC8PH89715VIzYvU3Ks7ILHS2pphwL/tiZN9DHg2wFLC537ByKTVqYhb
         7GC6P5re1vgxMvJHInTwJsKc8rLh3ECtb0WPnkp0=
Date: Sun, 10 Jun 2018 14:30:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-pm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio:dac:ad5686: Add AD5311R support
Message-ID: <20180610143034.37279fe0@archlinux>
In-Reply-To: <1528122127-1911-1-git-send-email-stefan.popa@analog.com>
References: <1528122127-1911-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018 17:22:07 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> AD5311R is a single channel DAC with 10-bit precision and i2c interface.
> The device includes a 2.5V internal reference which is enabled by default.
> 
> This device is similar to AD5691R/AD5692R/AD5693/AD5693R, the only
> difference is that it has 10-bit precision.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5310R_5311R.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5686.c     | 7 +++++++
>  drivers/iio/dac/ad5686.h     | 1 +
>  drivers/iio/dac/ad5696-i2c.c | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index e136f0f..2ddbfc3 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -221,6 +221,7 @@ static struct iio_chan_spec name[] = {				\
>  		AD5868_CHANNEL(7, 7, bits, _shift),		\
>  }
>  
> +DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
>  DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
>  DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
>  DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
> @@ -231,6 +232,12 @@ DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
>  DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
>  
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
> +	[ID_AD5311R] = {
> +		.channels = ad5311r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5693_REGMAP,
> +	},
>  	[ID_AD5671R] = {
>  		.channels = ad5672_channels,
>  		.int_vref_mv = 2500,
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index d05cda9..57b3c61 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -45,6 +45,7 @@
>   * ad5686_supported_device_ids:
>   */
>  enum ad5686_supported_device_ids {
> +	ID_AD5311R,
>  	ID_AD5671R,
>  	ID_AD5672R,
>  	ID_AD5675R,
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index d18735d..7350d98 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -71,6 +71,7 @@ static int ad5686_i2c_remove(struct i2c_client *i2c)
>  }
>  
>  static const struct i2c_device_id ad5686_i2c_id[] = {
> +	{"ad5311r", ID_AD5311R},
>  	{"ad5671r", ID_AD5671R},
>  	{"ad5675r", ID_AD5675R},
>  	{"ad5691r", ID_AD5691R},

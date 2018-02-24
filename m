Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBXMUi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 07:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeBXMUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 07:20:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD3021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Feb 2018 12:20:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, maxime.ripard@bootlin.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 13/13] iio: adc: axp20x_adc: remove !! in favor of
 ternary condition
Message-ID: <20180224122029.1520fe89@archlinux>
In-Reply-To: <9ec180ff4358ac6e163115aa7832a0674b6a640e.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
        <9ec180ff4358ac6e163115aa7832a0674b6a640e.1519044068.git-series.quentin.schulz@bootlin.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018 13:47:36 +0100
Quentin Schulz <quentin.schulz@bootlin.com> wrote:

> !!'s behaviour isn't that obvious and sparse complained about it, so
> let's replace it with a ternary condition.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp20x_adc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index a30a972..7a745cf 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -365,7 +365,7 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
>  		return -EINVAL;
>  	}
>  
> -	*val = !!(*val) * 700000;
> +	*val = *val ? 700000 : 0;
>  
>  	return IIO_VAL_INT;
>  }
> @@ -442,15 +442,17 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
>  	if (val != 0 && val != 700000)
>  		return -EINVAL;
>  
> +	val = val ? 1 : 0;
> +
>  	switch (chan->channel) {
>  	case AXP20X_GPIO0_V:
>  		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(!!val);
> +		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
>  		break;
>  
>  	case AXP20X_GPIO1_V:
>  		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
> -		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(!!val);
> +		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
>  		break;
>  
>  	default:

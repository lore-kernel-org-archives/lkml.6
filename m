Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeC3JvD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3JvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:51:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5C421723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 10:50:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: adc: meson-axg: add saradc driver
Message-ID: <20180330105055.3b0259d6@archlinux>
In-Reply-To: <20180326084629.100070-4-yixun.lan@amlogic.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
        <20180326084629.100070-4-yixun.lan@amlogic.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 16:46:29 +0800
Yixun Lan <yixun.lan@amlogic.com> wrote:

> From: Xingyu Chen <xingyu.chen@amlogic.com>
> 
> Add the SAR ADC driver for the Amlogic Meson-AXG SoC.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 799ed929ab99..a5d481a2b4ef 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -935,6 +935,11 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  	.name = "meson-gxm-saradc",
>  };
>  
> +static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> +	.param = &meson_sar_adc_gxl_param,
> +	.name = "meson-axg-saradc",
> +};
> +
>  static const struct of_device_id meson_sar_adc_of_match[] = {
>  	{
>  		.compatible = "amlogic,meson8-saradc",
> @@ -953,6 +958,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
>  	}, {
>  		.compatible = "amlogic,meson-gxm-saradc",
>  		.data = &meson_sar_adc_gxm_data,
> +	}, {
> +		.compatible = "amlogic,meson-axg-saradc",
> +		.data = &meson_sar_adc_axg_data,
>  	},
>  	{},
>  };

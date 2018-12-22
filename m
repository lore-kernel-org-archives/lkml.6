Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE15AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697EC21A7E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500435;
	bh=Nk+HsR/bnw6WXZBFAfBvVHSo8OxM5kBlExi/g7MFIzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k0tQXC7lfid2WNQSPTRbtN1N+AkD128NFN1Vg4EFfpRZzkUTtBugeK+pr5T7P5Dq1
	 bk8uN6WCj/662fqwIZzPAD29D65YVuAZF5SvoGYxn8F0HPT1u7S3EsVHJQr3c+Bvbk
	 UMOBaQSGO1mz72WWx9LNPvOqxCQk5TtCQYn9r/ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbeLVRke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389509AbeLVRkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:40:33 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD09021A4E;
        Sat, 22 Dec 2018 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545500432;
        bh=Nk+HsR/bnw6WXZBFAfBvVHSo8OxM5kBlExi/g7MFIzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1lQ5ou7f5UFTi5GtRnLsS473eNNJgiPCnxrhV5Bf+rB47KiSATxdUotQ/D8C8rkMw
         kuJmE324sBednrHXKHc7OOBx4hTcbAKwP0Wv6qQWxYJV1uZoPy4i4JKfnxuQBJjT5+
         HaTK+XHwc3JEgREBxci5zaStnWJhUO/iUP1i3z+E=
Date:   Sat, 22 Dec 2018 17:40:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH v2 1/6] staging: iio: adc: ad7606: Simplify the Kconfing
 menu
Message-ID: <20181222174026.63bb6d02@archlinux>
In-Reply-To: <1545049420-16484-2-git-send-email-stefan.popa@analog.com>
References: <1545049420-16484-1-git-send-email-stefan.popa@analog.com>
        <1545049420-16484-2-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 14:23:35 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> There is no point in having three menu entries that can be selected
> individually. Instead, the SPI and parallel interfaces should select
> AD7606.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
I think this looks right, but I've gotten these wrong too many times
to remember so fingers crossed.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.  Particularly useful with these
sorts of patches!

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/Kconfig | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index fc23059..302639a 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -4,35 +4,28 @@
>  menu "Analog to digital converters"
>  
>  config AD7606
> -	tristate "Analog Devices AD7606 ADC driver"
> -	depends on GPIOLIB || COMPILE_TEST
> -	depends on HAS_IOMEM
> +	tristate
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> -	help
> -	  Say yes here to build support for Analog Devices:
> -	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7606.
>  
>  config AD7606_IFACE_PARALLEL
> -	tristate "parallel interface support"
> -	depends on AD7606
> +	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
> +	depends on HAS_IOMEM
> +	select AD7606
>  	help
> -	  Say yes here to include parallel interface support on the AD7606
> -	  ADC driver.
> +	  Say yes here to build parallel interface support for Analog Devices:
> +	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7606_parallel.
>  
>  config AD7606_IFACE_SPI
> -	tristate "spi interface support"
> -	depends on AD7606
> +	tristate "Analog Devices AD7606 ADC driver with spi interface support"
>  	depends on SPI
> +	select AD7606
>  	help
> -	  Say yes here to include parallel interface support on the AD7606
> -	  ADC driver.
> +	  Say yes here to build spi interface support for Analog Devices:
> +	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7606_spi.


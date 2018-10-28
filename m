Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBDDC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3561220873
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh+ZGZex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3561220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJ1Ukv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 16:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeJ1Ukv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 16:40:51 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD4020843;
        Sun, 28 Oct 2018 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540727784;
        bh=yuNPW34jwAChYch75QibdqWeU380QvUdmHRUGV+qvLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sh+ZGZexBp6h79mxwAb6NAjqbHmuqf7WsGB86lmGg1lnLQd/ttsliSoKYG3Iv0dJW
         5G4ztYd6mLi2HHmXLWWdr20KxsnbKaJ1Plb4uRzYwKQLOtZdywBVdLiGcmazwHAxnS
         1QZrA8X+OYKFvt9gO1vIuEiQICk6K8/r8k2RJE3E=
Date:   Sun, 28 Oct 2018 11:56:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan O'Donovan <dan@emutex.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20181028115619.13550889@archlinux>
In-Reply-To: <1540481742-23596-3-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
        <1540481742-23596-1-git-send-email-dan@emutex.com>
        <1540481742-23596-3-git-send-email-dan@emutex.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 16:35:41 +0100
Dan O'Donovan <dan@emutex.com> wrote:

> From: Nicola Lunghi <nicola.lunghi@emutex.com>
> 
> ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
> Squared board.
> 
> Add it to the driver.
> 
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> [javier@emutex.com: fix up commit message and one checkpatch warning]
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index e6716c3..c2d1453 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -12,10 +12,12 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  
>  struct adc128_configuration {
> @@ -135,10 +137,15 @@ static const struct iio_info adc128_info = {
>  static int adc128_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> +	unsigned int config;
>  	struct adc128 *adc;
> -	int config = spi_get_device_id(spi)->driver_data;
>  	int ret;
>  
> +	if (dev_fwnode(&spi->dev))
> +		config = (unsigned long) device_get_match_data(&spi->dev);
> +	else
> +		config = spi_get_device_id(spi)->driver_data;
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -207,10 +214,19 @@ static const struct spi_device_id adc128_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id adc128_acpi_match[] = {
> +	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> +#endif
> +
>  static struct spi_driver adc128_driver = {
>  	.driver = {
>  		.name = "adc128s052",
>  		.of_match_table = of_match_ptr(adc128_of_match),
> +		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
>  	},
>  	.probe = adc128_probe,
>  	.remove = adc128_remove,


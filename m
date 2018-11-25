Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C6320868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpbZDFtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C6320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeKYWk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKYWk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:40:57 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E8020865;
        Sun, 25 Nov 2018 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543146601;
        bh=uJ0J7WjdBTq5EEmsuVh07BHNEm8mlhyG/hOw5eDVOoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KpbZDFtFbdRAjls5oEq67X3aTYdoNNxTPAfnl4dWKfbg75uNcQ0FpWq28bT8w4n35
         4+IxI1yj6BcTCLq3at2uKQcRUu0MMy7Y+2Td1zLyfzsCGlTmP56FomGFcPMCR0q3b5
         en90+arVa5jplRyshpW3YVccB/C90ZFKBi6PtVzs=
Date:   Sun, 25 Nov 2018 11:49:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] Staging: iio: adt7316: Switch irq_flags to a
 local variable
Message-ID: <20181125114957.4714a2ea@archlinux>
In-Reply-To: <20181120165658.7259-1-shreeya.patel23498@gmail.com>
References: <20181120165658.7259-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 22:26:58 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> There is no need to store irq_flags into the structure as it
> is always set to the same thing. Hence switch irq_flags to a
> local variable.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 1 -
>  drivers/staging/iio/addac/adt7316-spi.c | 1 -
>  drivers/staging/iio/addac/adt7316.c     | 8 ++++----
>  drivers/staging/iio/addac/adt7316.h     | 1 -
>  4 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index 41bc4ca008bc..ac91163656b5 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -104,7 +104,6 @@ static int adt7316_i2c_probe(struct i2c_client *client,
>  	struct adt7316_bus bus = {
>  		.client = client,
>  		.irq = client->irq,
> -		.irq_flags = IRQF_TRIGGER_LOW,
>  		.read = adt7316_i2c_read,
>  		.write = adt7316_i2c_write,
>  		.multi_read = adt7316_i2c_multi_read,
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
> index 5cd22743e140..e75827e326a6 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -94,7 +94,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
>  	struct adt7316_bus bus = {
>  		.client = spi_dev,
>  		.irq = spi_dev->irq,
> -		.irq_flags = IRQF_TRIGGER_LOW,
>  		.read = adt7316_spi_read,
>  		.write = adt7316_spi_write,
>  		.multi_read = adt7316_spi_multi_read,
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index deb2f7b40f60..dfae22619287 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2102,6 +2102,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	unsigned short *adt7316_platform_data = dev->platform_data;
> +	int irq_flags = IRQF_TRIGGER_LOW;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> @@ -2146,19 +2147,18 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  
>  	if (chip->bus.irq > 0) {
>  		if (adt7316_platform_data[0])
> -			chip->bus.irq_flags = adt7316_platform_data[0];
> +			irq_flags = adt7316_platform_data[0];
>  
>  		ret = devm_request_threaded_irq(dev, chip->bus.irq,
>  						NULL,
>  						adt7316_event_handler,
> -						chip->bus.irq_flags |
> -						IRQF_ONESHOT,
> +						irq_flags | IRQF_ONESHOT,
>  						indio_dev->name,
>  						indio_dev);
>  		if (ret)
>  			return ret;
>  
> -		if (chip->bus.irq_flags & IRQF_TRIGGER_HIGH)
> +		if (irq_flags & IRQF_TRIGGER_HIGH)
>  			chip->config1 |= ADT7316_INT_POLARITY;
>  	}
>  
> diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
> index ec40fbb698a6..fd7c5c92b599 100644
> --- a/drivers/staging/iio/addac/adt7316.h
> +++ b/drivers/staging/iio/addac/adt7316.h
> @@ -17,7 +17,6 @@
>  struct adt7316_bus {
>  	void *client;
>  	int irq;
> -	int irq_flags;
>  	int (*read)(void *client, u8 reg, u8 *data);
>  	int (*write)(void *client, u8 reg, u8 val);
>  	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);


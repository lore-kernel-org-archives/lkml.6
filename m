Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B522C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1230D2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547924591;
	bh=40nrlDnXr4tDByzHhw7hA0c4XfP+2r3WVL5NA5ACiJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=z3ahR2DlzSmAN9RB/sS/RDt/hf0jGfWOSjOAZtD2q3urVXZ1BF5f7lA8li4Suw/fG
	 +PcGjzgOou3T6DzVFWtbKZr2fWWF4E0xNV3zm1ftHIdQ9Bl3du3nf7qULYJGh0C47g
	 VMjHnZ3kti/XtOkq1BA787gN+nZBY5T3nk52FaKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfASTDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbfASTDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:03:08 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672A42086D;
        Sat, 19 Jan 2019 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547924588;
        bh=40nrlDnXr4tDByzHhw7hA0c4XfP+2r3WVL5NA5ACiJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jagVNFLLEUCpGJroBwx2aLTYAm0KCLpk6uCD+T+gOSw1AEaQ6PVykTjwM4kQx7unt
         gL/f3xdzIXki/odeRuubhyDmrIejEXpesX/Eeq0L/AzRv3D7R3axl7OCdxfUlCaGxm
         e8OW11BwCncz2oSuzRxUrKA89TqUjcILrx81k99E=
Date:   Sat, 19 Jan 2019 19:03:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Staging: iio: adt7316: Remove irq from bus
 structure
Message-ID: <20190119190303.65434e58@archlinux>
In-Reply-To: <20190119183932.14321-2-shreeya.patel23498@gmail.com>
References: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
        <20190119183932.14321-2-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2019 00:09:30 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> interrupt request is not needed to be present in the bus
> structure. It is a good option to pass it as a parameter
> in the probe function instead of having it in the bus structure.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Hi Shreeya,

I just tried applying this to the current testing branch of
iio.git and unfortunately it doesn't apply. Please rebase
on that as there have been various changes.

Superficially I think it is all white space related and a bit
of code movement, but I'd rather you made sure the rebase
worked well than I made assumptions!

The change looks good otherwise.

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c |  3 +--
>  drivers/staging/iio/addac/adt7316-spi.c |  4 ++--
>  drivers/staging/iio/addac/adt7316.c     | 15 +++++++--------
>  drivers/staging/iio/addac/adt7316.h     |  3 +--
>  4 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index ac91163656b5..335c17731cf7 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -103,14 +103,13 @@ static int adt7316_i2c_probe(struct i2c_client *client,
>  {
>  	struct adt7316_bus bus = {
>  		.client = client,
> -		.irq = client->irq,
>  		.read = adt7316_i2c_read,
>  		.write = adt7316_i2c_write,
>  		.multi_read = adt7316_i2c_multi_read,
>  		.multi_write = adt7316_i2c_multi_write,
>  	};
>  
> -	return adt7316_probe(&client->dev, &bus, id->name);
> +	return adt7316_probe(&client->dev, &bus, id->name, client->irq);
>  }
>  
>  static const struct i2c_device_id adt7316_i2c_id[] = {
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
> index e75827e326a6..adaaa3eecd04 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -93,7 +93,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
>  {
>  	struct adt7316_bus bus = {
>  		.client = spi_dev,
> -		.irq = spi_dev->irq,
>  		.read = adt7316_spi_read,
>  		.write = adt7316_spi_write,
>  		.multi_read = adt7316_spi_multi_read,
> @@ -112,7 +111,8 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
>  	adt7316_spi_write(spi_dev, 0, 0);
>  	adt7316_spi_write(spi_dev, 0, 0);
>  
> -	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
> +	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias,
> +			     spi_dev->irq);
>  }
>  
>  static const struct spi_device_id adt7316_spi_id[] = {
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 1ca4ee0f30ee..6b4b80fd80cc 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1807,12 +1807,12 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static int adt7316_setup_irq(struct iio_dev *indio_dev)
> +static int adt7316_setup_irq(struct iio_dev *indio_dev, int irq)
>  {
>  	struct adt7316_chip_info *chip = iio_priv(indio_dev);
>  	int irq_type, ret;
>  
> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> +	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
>  
>  	switch (irq_type) {
>  	case IRQF_TRIGGER_HIGH:
> @@ -1828,13 +1828,12 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
>  		break;
>  	}
>  
> -	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
> +	ret = devm_request_threaded_irq(&indio_dev->dev, irq,
>  					NULL, adt7316_event_handler,
>  					irq_type | IRQF_ONESHOT,
>  					indio_dev->name, indio_dev);
>  	if (ret) {
> -		dev_err(&indio_dev->dev, "failed to request irq %d\n",
> -			chip->bus.irq);
> +		dev_err(&indio_dev->dev, "failed to request irq %d\n", irq);
>  		return ret;
>  	}
>  
> @@ -2134,7 +2133,7 @@ static const struct iio_info adt7516_info = {
>   * device probe and remove
>   */
>  int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> -		const char *name)
> +		  const char *name, int irq)
>  {
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
> @@ -2180,8 +2179,8 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	if (chip->bus.irq > 0) {
> -		ret = adt7316_setup_irq(indio_dev);
> +	if (irq > 0) {
> +		ret = adt7316_setup_irq(indio_dev, irq);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
> index fd7c5c92b599..03d5300a98cd 100644
> --- a/drivers/staging/iio/addac/adt7316.h
> +++ b/drivers/staging/iio/addac/adt7316.h
> @@ -16,7 +16,6 @@
>  
>  struct adt7316_bus {
>  	void *client;
> -	int irq;
>  	int (*read)(void *client, u8 reg, u8 *data);
>  	int (*write)(void *client, u8 reg, u8 val);
>  	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
> @@ -30,6 +29,6 @@ extern const struct dev_pm_ops adt7316_pm_ops;
>  #define ADT7316_PM_OPS NULL
>  #endif
>  int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> -		   const char *name);
> +		  const char *name, int irq);
>  
>  #endif


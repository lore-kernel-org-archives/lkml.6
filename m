Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10921C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74BD2183E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544962241;
	bh=aWnwFzww+G2ljEvDGe/uyql9r7Mfb6Ss3XaN8l6ZAs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OZyPUrh6dX+5xEnjLLh5Ii0r7UnpL3t5IuogD6qMqILnuxvaZBdrx17j1XuNldD/8
	 qzV0u5oufRO+jXuc8BGZwt3j2UnCQAuBy3YOATa+ZrxiKtCZ3IqYl8bBHTRbhtpPfn
	 AaLgyFTR8CHb81ORZ5XGp5GMvnbKNVBkkbqWoh+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbeLPMKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbeLPMKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:10:41 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FD6217FA;
        Sun, 16 Dec 2018 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544962240;
        bh=aWnwFzww+G2ljEvDGe/uyql9r7Mfb6Ss3XaN8l6ZAs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xRYQXKRa/aTSngu6fvV63YwXV6vmDERKEac80wke/m6DtT5OAUTpffcMPPpD/bN2E
         5KFnvLobUI5+BTYMgYUSZscw5bJ6KOAmX0dsjwgIcoYC7ln0LkQfa0JIXaongaeSal
         kAyVmlxYKukF0tGllYkj9LZQZygDLtR36DIyKpZ8=
Date:   Sun, 16 Dec 2018 12:10:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: Re: [PATCH v4] Staging: iio: adt7316: Add all irq related code in
 adt7316_irq_setup()
Message-ID: <20181216121035.6d6c50cf@archlinux>
In-Reply-To: <20181213194335.11075-1-shreeya.patel23498@gmail.com>
References: <20181213194335.11075-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 01:13:35 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> ADT7316 driver no more uses platform data and hence use device tree
> data instead of platform data for assigning irq_type field and
> implement this in adt7316_irq_setup function.
> Switch case figures out the type of irq and if it's the default case
> then assign the default value to the irq_type i.e.
> irq_type = IRQF_TRIGGER_LOW
> Move devm_request_threaded_irq() and assignment of chip->config1
> into the adt7316_setup_irq() to unclutter the code in probe function.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

+CC Jeremy. As it seems we have two people working on this device at
the moment it would be great if you could review each others patches
going forwards!

Anyhow, this still applies and looks fine given the churn caused by
the parts of Jeremy's series that I applied.  It was actually more
effected by the ret = 0 cleanup patch that I just applied.

Anyhow, looks good and applied to the togreg branch of iio.git and
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v4
>   - Merge patches *[1/3 v3], *[2/3 v3] and *[3/3 v3] to make it less
> complex to review.
> 
> Changes in v3
>   - Add a new function for having all interrupt related code.
> 
> Changes in v2
>   - Make the commit message of patch *[1/5] appropriate.
> 
> 
>  drivers/staging/iio/addac/adt7316.c | 52 +++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 9c72538baf9e..1ca4ee0f30ee 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1807,6 +1807,43 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static int adt7316_setup_irq(struct iio_dev *indio_dev)
> +{
> +	struct adt7316_chip_info *chip = iio_priv(indio_dev);
> +	int irq_type, ret;
> +
> +	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_HIGH:
> +	case IRQF_TRIGGER_RISING:
> +		break;
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_FALLING:
> +		break;
> +	default:
> +		dev_info(&indio_dev->dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
> +			 irq_type);
> +		irq_type = IRQF_TRIGGER_LOW;
> +		break;
> +	}
> +
> +	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
> +					NULL, adt7316_event_handler,
> +					irq_type | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "failed to request irq %d\n",
> +			chip->bus.irq);
> +		return ret;
> +	}
> +
> +	if (irq_type & IRQF_TRIGGER_HIGH)
> +		chip->config1 |= ADT7316_INT_POLARITY;
> +
> +	return 0;
> +}
> +
>  /*
>   * Show mask of enabled interrupts in Hex.
>   */
> @@ -2101,8 +2138,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  {
>  	struct adt7316_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	unsigned short *adt7316_platform_data = dev->platform_data;
> -	int irq_type = IRQF_TRIGGER_LOW;
>  	int ret = 0;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> @@ -2146,20 +2181,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	if (chip->bus.irq > 0) {
> -		if (adt7316_platform_data[0])
> -			irq_type = adt7316_platform_data[0];
> -
> -		ret = devm_request_threaded_irq(dev, chip->bus.irq,
> -						NULL,
> -						adt7316_event_handler,
> -						irq_type | IRQF_ONESHOT,
> -						indio_dev->name,
> -						indio_dev);
> +		ret = adt7316_setup_irq(indio_dev);
>  		if (ret)
>  			return ret;
> -
> -		if (irq_type & IRQF_TRIGGER_HIGH)
> -			chip->config1 |= ADT7316_INT_POLARITY;
>  	}
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);


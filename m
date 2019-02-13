Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B07EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DED222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Ls4OrDmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbfBMILD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:11:03 -0500
Received: from vern.gendns.com ([98.142.107.122]:60866 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbfBMILC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bdurlxeqJ0bKi/cSvisd40pwu0knZ1FrIHy+CHywdxs=; b=Ls4OrDmGUsDruQm+zvoc8R7vA/
        ThK8fF6Ib2z6Ja31X3Q15DF4EXGNnuyg7T+I/wI8KxdONUa+FSsEcwt1ZCFM+uE25kYYvNjSki9ny
        /f4gPRb58AQiFBsjO+jF5zBpD+cSVF3V97zF6cnglTKL/BOqH8S860QIhGv5nc9W/11V7xf1HHxve
        oUOunUFlf3wORpj5xHa/wKEwF+qrScm2TsK0W5GEK5TNiTMP9I372Wy1V4UNa0Zo2IStTz/yj0K03
        Y2RK4odXx9/C2H5FG9P1Ec5HdV6TdMRa91EO0fjrWZFkMcFlRaukWOxGxW+3WzvbKAk9xBBQxkctw
        3CGqLXwg==;
Received: from 5f9a3e7e.rev.sefiber.dk ([95.154.62.126]:51601 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gtpZN-0003TH-SQ; Wed, 13 Feb 2019 03:07:02 -0500
Subject: Re: [PATCH v3] iio: adc: ti-ads7950: add GPIO support
To:     justinpopo6@gmail.com, linux-iio@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
References: <1550030242-5241-1-git-send-email-justinpopo6@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <9e0a8a08-9636-906b-08cf-d99947d6f51a@lechnology.com>
Date:   Wed, 13 Feb 2019 09:10:53 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550030242-5241-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/12/19 9:57 PM, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> The ADS79XX has GPIO pins that can be used. Add support for the GPIO
> pins using the GPIO chip framework.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---

It will be better to split this up into two patches[1]. One to replace 
all uses of indio_dev->mlock with the new local lock and then another to 
add GPIO support.

How are you using/testing this patch? Do we need device tree bindings?

It will also help reviewers if you add a note about what you changed in 
each revision of the patch when you resubmit. The usual way to do this 
is something like:

     v3 changes:

     - Fixed unlocking mutex too many times in ti_ads7950_init_gpio()

It also is nice to wait a few days at least before submitting the next 
revision to give people some time to respond.



[1]: 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes

>   drivers/iio/adc/ti-ads7950.c | 169 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 166 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0ad6359..9723d66 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -17,6 +17,7 @@
>   #include <linux/bitops.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> +#include <linux/gpio/driver.h>
>   #include <linux/interrupt.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> @@ -36,10 +37,14 @@
>    */
>   #define TI_ADS7950_VA_MV_ACPI_DEFAULT	5000
>   
> +#define TI_ADS7950_CR_GPIO	BIT(14)
>   #define TI_ADS7950_CR_MANUAL	BIT(12)
>   #define TI_ADS7950_CR_WRITE	BIT(11)
>   #define TI_ADS7950_CR_CHAN(ch)	((ch) << 7)
>   #define TI_ADS7950_CR_RANGE_5V	BIT(6)
> +#define TI_ADS7950_CR_GPIO_DATA	BIT(5)
> +#define TI_ADS7950_NUM_GPIOS	4
> +#define TI_ADS7950_GPIO_MASK	GENMASK(TI_ADS7950_NUM_GPIOS - 1, 0)
>   
>   #define TI_ADS7950_MAX_CHAN	16
>   
> @@ -56,11 +61,17 @@ struct ti_ads7950_state {
>   	struct spi_message	ring_msg;
>   	struct spi_message	scan_single_msg;
>   
> +	struct gpio_chip	chip;
> +	struct mutex		slock;

A comment stating what slock is protecting (i.e. the spi xfers and 
buffers) would be helpful.

> +
>   	struct regulator	*reg;
>   	unsigned int		vref_mv;
>   
>   	unsigned int		settings;
>   
> +	unsigned int		gpio_direction_bitmask;
> +	unsigned int		gpio_signal_bitmask;
> +
>   	/*
>   	 * DMA (thus cache coherency maintenance) requires the
>   	 * transfer buffers to live in their own cache lines.
> @@ -248,7 +259,8 @@ static int ti_ads7950_update_scan_mode(struct iio_dev *indio_dev,
>   
>   	len = 0;
>   	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
> -		cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings;
> +		cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(i) | st->settings
> +		      | (st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK);
>   		st->tx_buf[len++] = cmd;
>   	}
>   
> @@ -287,8 +299,9 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>   	int ret, cmd;
>   
>   	mutex_lock(&indio_dev->mlock);

The use of mlock should be removed here since we are replacing it with 
slock. Also, ti_ads7950_trigger_handler() will need to be changed to use 
slock when the use of mlock is removed. (When 
ti_ads7950_trigger_handler() is called, mlock is already held by the 
calling function.)

> -
> -	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
> +	mutex_lock(&st->slock);
> +	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings
> +	      | (st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK);
>   	st->single_tx = cmd;
>   
>   	ret = spi_sync(st->spi, &st->scan_single_msg);
> @@ -298,6 +311,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>   	ret = st->single_rx;
>   
>   out:
> +	mutex_unlock(&st->slock);
>   	mutex_unlock(&indio_dev->mlock);
>   
>   	return ret;
> @@ -362,6 +376,145 @@ static const struct iio_info ti_ads7950_info = {
>   	.update_scan_mode	= ti_ads7950_update_scan_mode,
>   };
>   
> +static void ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
> +			   int value)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +
> +	mutex_lock(&st->slock);
> +
> +	if (value)
> +		st->gpio_signal_bitmask |= BIT(offset);
> +	else
> +		st->gpio_signal_bitmask &= ~BIT(offset);
> +
> +	st->single_tx = cpu_to_be16(TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_WRITE |
> +			(st->gpio_signal_bitmask & TI_ADS7950_GPIO_MASK));

SPI xfers are CPU-endian, so cpu_to_be16() doesn't seem right here.

> +	spi_sync(st->spi, &st->scan_single_msg);
> +
> +	mutex_unlock(&st->slock);
> +}
> +
> +static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +	int ret;
> +
> +	mutex_lock(&st->slock);
> +
> +	/* If set as output, return the output */
> +	if (st->gpio_direction_bitmask & BIT(offset)) {
> +		ret = st->gpio_signal_bitmask & BIT(offset);
> +		goto out;
> +	}
> +
> +	st->single_tx = cpu_to_be16(TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_WRITE |
> +				    TI_ADS7950_CR_GPIO_DATA);

Again, cpu_to_be16() seems wrong.

> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		goto out;
> +
> +	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
> +
> +out:
> +	mutex_unlock(&st->slock);
> +
> +	return ret;
> +}
> +
> +static int ti_ads7950_get_direction(struct gpio_chip *chip,
> +				    unsigned int offset)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +
> +	return !(st->gpio_direction_bitmask & BIT(offset));

The use of `!` here seems odd. Why make gpio_direction_bitmask inverted 
compared to the gpio framework?

> +}
> +
> +static int _ti_ads7950_set_direction(struct gpio_chip *chip, int offset,
> +				     int input)
> +{
> +	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> +	int ret = 0; > +
> +	mutex_lock(&st->slock);
> +

A comment explaining what is going on here (i.e. we only send an SPI 
message if the direction changes) would be helpful. It was not quite 
obvious to me at first glance.

> +	if (input && (st->gpio_direction_bitmask & BIT(offset)))
> +		st->gpio_direction_bitmask &= ~BIT(offset);
> +	else if (!input && !(st->gpio_direction_bitmask & BIT(offset)))
> +		st->gpio_direction_bitmask |= BIT(offset);
> +	else
> +		goto out;
> +
> +
> +	st->single_tx = cpu_to_be16(TI_ADS7950_CR_GPIO |
> +				    (st->gpio_direction_bitmask &
> +				    TI_ADS7950_GPIO_MASK));
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +
> +out:
> +	mutex_unlock(&st->slock);
> +
> +	return ret;
> +}
> +
> +static int ti_ads7950_direction_input(struct gpio_chip *chip,
> +				      unsigned int offset)
> +{
> +	return _ti_ads7950_set_direction(chip, offset, 1);
> +}
> +
> +static int ti_ads7950_direction_output(struct gpio_chip *chip,
> +				       unsigned int offset, int value)
> +{
> +	ti_ads7950_set(chip, offset, value);
> +
> +	return _ti_ads7950_set_direction(chip, offset, 0);
> +}
> +
> +static int ti_ads7950_init_gpio(struct ti_ads7950_state *st)
> +{
> +	int ret;
> +
> +	/* Initialize GPIO */
> +	mutex_lock(&st->slock);
> +
> +	/* Default to GPIO input */
> +	st->gpio_direction_bitmask = 0x0;

It is probably safe to leave this out since it should already be 0.

> +	st->single_tx = cpu_to_be16(TI_ADS7950_CR_GPIO |
> +				    (st->gpio_direction_bitmask &
> +				    TI_ADS7950_GPIO_MASK));
> +	ret = spi_sync(st->spi, &st->scan_single_msg > +	if (ret) {
> +		mutex_unlock(&st->slock);
> +		return ret;
> +	}
> +
> +	/* Default to signal low */
> +	st->gpio_signal_bitmask = 0x0;
> +	st->single_tx = cpu_to_be16(TI_ADS7950_CR_MANUAL |
> +				    TI_ADS7950_CR_WRITE |
> +				    (st->gpio_signal_bitmask &
> +				    TI_ADS7950_GPIO_MASK));
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	mutex_unlock(&st->slock);
> +	if (ret)
> +		return ret;
> +
> +	/* Add GPIO chip */
> +	st->chip.label = dev_name(&st->spi->dev);
> +	st->chip.parent = &st->spi->dev;
> +	st->chip.owner = THIS_MODULE;
> +	st->chip.base = -1;
> +	st->chip.ngpio = TI_ADS7950_NUM_GPIOS;
> +	st->chip.get_direction = ti_ads7950_get_direction;
> +	st->chip.direction_input = ti_ads7950_direction_input;
> +	st->chip.direction_output = ti_ads7950_direction_output;
> +	st->chip.get = ti_ads7950_get;
> +	st->chip.set = ti_ads7950_set;

Does it make sense to also implement chip.get_multiple and 
chip.set_multiple to minimize SPI transactions?

> +
> +	return gpiochip_add_data(&st->chip, st);
> +}
> +
>   static int ti_ads7950_probe(struct spi_device *spi)
>   {
>   	struct ti_ads7950_state *st;
> @@ -457,8 +610,17 @@ static int ti_ads7950_probe(struct spi_device *spi)
>   		goto error_cleanup_ring;
>   	}
>   
> +	mutex_init(&st->slock);

This will probably never actually cause a problem, but the mutex should 
probably be inited before registering the iio device since it uses the 
mutex as well.

> +	ret = ti_ads7950_init_gpio(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to initialize GPIOs\n");
> +		goto error_destroy_mutex;
> +	}
> +
>   	return 0;
>   
> +error_destroy_mutex:
> +	mutex_destroy(&st->slock);
>   error_cleanup_ring:
>   	iio_triggered_buffer_cleanup(indio_dev);
>   error_disable_reg:
> @@ -475,6 +637,7 @@ static int ti_ads7950_remove(struct spi_device *spi)
>   	iio_device_unregister(indio_dev);
>   	iio_triggered_buffer_cleanup(indio_dev);
>   	regulator_disable(st->reg);
> +	mutex_destroy(&st->slock);
>   
>   	return 0;
>   }
> 

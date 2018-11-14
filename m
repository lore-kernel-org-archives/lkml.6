Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5AC208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NegFMrb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5AC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbeKODKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:10:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42248 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKODKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:10:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so3741526pfr.9;
        Wed, 14 Nov 2018 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uuktANu4TnaEEiDKStY1GSUmFr+VgFpLIMxiFlNYY/A=;
        b=NegFMrb8tBo0IWks2L5Adru2gEPTAS134z45LyxEfX8M7WIit7zA0B1OSDoTwsBs5K
         MJqNaYwX0bqSCIJT+62/avQNFOPsYzWBgv+f5y1U0AedWoJbrQCre2IIaVKd0Dz9DqvD
         KVZ5n0RPMnpQAiGwsq2vY3hmIyWGdz9cPvv4boC8LntI65SyKJy5J4v5ki8bFzgc92zg
         OyXZY0TIvtF+B3KWMTQ0zCZgh7uZypWkG6H0w5FR8MK/N5jIvCV54YU+XuQJiqwlC4eD
         U8mk78PBc9IVUXTcrmKohqAF75GYhewO58fpcZGFnFNaY45XePi//KIb0YP4aTMUUQck
         X4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uuktANu4TnaEEiDKStY1GSUmFr+VgFpLIMxiFlNYY/A=;
        b=g+kdpBNvydwEszNZGbfTOTqaRQVtWhVvvn5EtjtA+DydrHi7LVU6dN7+Pho4XYL7lN
         5E9Fbs+hqGjUp1R3wjpSRK3ZhkAHLA7c3F4JBM7KCrwSdAaaTjCiVVgYGISWoiWQaZCQ
         RmfVQ7g9YEh3LYu4gROBKRiPTwBJoYKMwEU8I8xFPRJrT5TelbcyPINXg/lWLna7QnMz
         5O2Z340pg+XhfkJNenKo0djcw39S6nsZ1kqZSlvNViUgiN9EcxYjMdJHQOJMdqpIwjNj
         UdR0aJlr/86eefQtaEWTmwkupOwxDgIA7UwSpn+pz1B7HIoazEOXe7HmBvDgpH+xu2Xw
         U3Tg==
X-Gm-Message-State: AGRZ1gKvSwfV5KhZ8vLpt1GZfk2ZncDE4nE14AgyJZ1Gayt0SrD52hD1
        YshH81Xgglt+pSpIW3se9Kg=
X-Google-Smtp-Source: AJdET5fsMczL45c7kyJ47bbFn9pzdapvULWSeT6ud+458zaoZ8STg0qe+5D56u+8S58KquYtFCTsQg==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr2771199pfm.18.1542215175893;
        Wed, 14 Nov 2018 09:06:15 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id k38sm57076622pgb.33.2018.11.14.09.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 09:06:15 -0800 (PST)
Date:   Wed, 14 Nov 2018 22:36:08 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: iio: ad7816: Switch to the gpio
 descriptor interface
Message-ID: <20181114170606.GA16897@nishad>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
 <3f9ea18864230b2758f86899b9bd1acb020dd176.1541733949.git.nishadkamdar@gmail.com>
 <20181111122405.23970900@archlinux>
 <20181111123154.176ac734@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111123154.176ac734@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:31:54PM +0000, Jonathan Cameron wrote:
> On Sun, 11 Nov 2018 12:24:05 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 9 Nov 2018 13:05:17 +0530
> > Nishad Kamdar <nishadkamdar@gmail.com> wrote:
> > 
> > > Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
> > > instead of the deprecated old non-descriptor interface.
> > > 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>  
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.
> Actually no it isn't, because I applied the previous version back in
> October.  Please avoid resending patches that have already been applied.
> It gets very confusing!
> 
> Jonathan
>

Sorry about that. I'll keep that in mind.

Thanks for the review.

regards,
Nishad

> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > > ---
> > >  drivers/staging/iio/adc/ad7816.c | 80 ++++++++++++++------------------
> > >  1 file changed, 34 insertions(+), 46 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> > > index bf76a8620bdb..12c4e0ab4713 100644
> > > --- a/drivers/staging/iio/adc/ad7816.c
> > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > @@ -7,7 +7,7 @@
> > >   */
> > >  
> > >  #include <linux/interrupt.h>
> > > -#include <linux/gpio.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/device.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/slab.h>
> > > @@ -44,9 +44,9 @@
> > >  
> > >  struct ad7816_chip_info {
> > >  	struct spi_device *spi_dev;
> > > -	u16 rdwr_pin;
> > > -	u16 convert_pin;
> > > -	u16 busy_pin;
> > > +	struct gpio_desc *rdwr_pin;
> > > +	struct gpio_desc *convert_pin;
> > > +	struct gpio_desc *busy_pin;
> > >  	u8  oti_data[AD7816_CS_MAX + 1];
> > >  	u8  channel_id;	/* 0 always be temperature */
> > >  	u8  mode;
> > > @@ -61,28 +61,28 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
> > >  	int ret = 0;
> > >  	__be16 buf;
> > >  
> > > -	gpio_set_value(chip->rdwr_pin, 1);
> > > -	gpio_set_value(chip->rdwr_pin, 0);
> > > +	gpiod_set_value(chip->rdwr_pin, 1);
> > > +	gpiod_set_value(chip->rdwr_pin, 0);
> > >  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> > >  	if (ret < 0) {
> > >  		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> > >  		return ret;
> > >  	}
> > > -	gpio_set_value(chip->rdwr_pin, 1);
> > > +	gpiod_set_value(chip->rdwr_pin, 1);
> > >  
> > >  	if (chip->mode == AD7816_PD) { /* operating mode 2 */
> > > -		gpio_set_value(chip->convert_pin, 1);
> > > -		gpio_set_value(chip->convert_pin, 0);
> > > +		gpiod_set_value(chip->convert_pin, 1);
> > > +		gpiod_set_value(chip->convert_pin, 0);
> > >  	} else { /* operating mode 1 */
> > > -		gpio_set_value(chip->convert_pin, 0);
> > > -		gpio_set_value(chip->convert_pin, 1);
> > > +		gpiod_set_value(chip->convert_pin, 0);
> > > +		gpiod_set_value(chip->convert_pin, 1);
> > >  	}
> > >  
> > > -	while (gpio_get_value(chip->busy_pin))
> > > +	while (gpiod_get_value(chip->busy_pin))
> > >  		cpu_relax();
> > >  
> > > -	gpio_set_value(chip->rdwr_pin, 0);
> > > -	gpio_set_value(chip->rdwr_pin, 1);
> > > +	gpiod_set_value(chip->rdwr_pin, 0);
> > > +	gpiod_set_value(chip->rdwr_pin, 1);
> > >  	ret = spi_read(spi_dev, &buf, sizeof(*data));
> > >  	if (ret < 0) {
> > >  		dev_err(&spi_dev->dev, "SPI data read error\n");
> > > @@ -99,8 +99,8 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
> > >  	struct spi_device *spi_dev = chip->spi_dev;
> > >  	int ret = 0;
> > >  
> > > -	gpio_set_value(chip->rdwr_pin, 1);
> > > -	gpio_set_value(chip->rdwr_pin, 0);
> > > +	gpiod_set_value(chip->rdwr_pin, 1);
> > > +	gpiod_set_value(chip->rdwr_pin, 0);
> > >  	ret = spi_write(spi_dev, &data, sizeof(data));
> > >  	if (ret < 0)
> > >  		dev_err(&spi_dev->dev, "SPI oti data write error\n");
> > > @@ -129,10 +129,10 @@ static ssize_t ad7816_store_mode(struct device *dev,
> > >  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> > >  
> > >  	if (strcmp(buf, "full")) {
> > > -		gpio_set_value(chip->rdwr_pin, 1);
> > > +		gpiod_set_value(chip->rdwr_pin, 1);
> > >  		chip->mode = AD7816_FULL;
> > >  	} else {
> > > -		gpio_set_value(chip->rdwr_pin, 0);
> > > +		gpiod_set_value(chip->rdwr_pin, 0);
> > >  		chip->mode = AD7816_PD;
> > >  	}
> > >  
> > > @@ -345,15 +345,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
> > >  {
> > >  	struct ad7816_chip_info *chip;
> > >  	struct iio_dev *indio_dev;
> > > -	unsigned short *pins = dev_get_platdata(&spi_dev->dev);
> > >  	int ret = 0;
> > >  	int i;
> > >  
> > > -	if (!pins) {
> > > -		dev_err(&spi_dev->dev, "No necessary GPIO platform data.\n");
> > > -		return -EINVAL;
> > > -	}
> > > -
> > >  	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> > >  	if (!indio_dev)
> > >  		return -ENOMEM;
> > > @@ -364,34 +358,28 @@ static int ad7816_probe(struct spi_device *spi_dev)
> > >  	chip->spi_dev = spi_dev;
> > >  	for (i = 0; i <= AD7816_CS_MAX; i++)
> > >  		chip->oti_data[i] = 203;
> > > -	chip->rdwr_pin = pins[0];
> > > -	chip->convert_pin = pins[1];
> > > -	chip->busy_pin = pins[2];
> > > -
> > > -	ret = devm_gpio_request(&spi_dev->dev, chip->rdwr_pin,
> > > -				spi_get_device_id(spi_dev)->name);
> > > -	if (ret) {
> > > -		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
> > > -			chip->rdwr_pin);
> > > +
> > > +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> > > +	if (IS_ERR(chip->rdwr_pin)) {
> > > +		ret = PTR_ERR(chip->rdwr_pin);
> > > +		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
> > > +			ret);
> > >  		return ret;
> > >  	}
> > > -	gpio_direction_input(chip->rdwr_pin);
> > > -	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
> > > -				spi_get_device_id(spi_dev)->name);
> > > -	if (ret) {
> > > -		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
> > > -			chip->convert_pin);
> > > +	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
> > > +	if (IS_ERR(chip->convert_pin)) {
> > > +		ret = PTR_ERR(chip->convert_pin);
> > > +		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
> > > +			ret);
> > >  		return ret;
> > >  	}
> > > -	gpio_direction_input(chip->convert_pin);
> > > -	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
> > > -				spi_get_device_id(spi_dev)->name);
> > > -	if (ret) {
> > > -		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
> > > -			chip->busy_pin);
> > > +	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
> > > +	if (IS_ERR(chip->busy_pin)) {
> > > +		ret = PTR_ERR(chip->busy_pin);
> > > +		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> > > +			ret);
> > >  		return ret;
> > >  	}
> > > -	gpio_direction_input(chip->busy_pin);
> > >  
> > >  	indio_dev->name = spi_get_device_id(spi_dev)->name;
> > >  	indio_dev->dev.parent = &spi_dev->dev;  
> > 
> 

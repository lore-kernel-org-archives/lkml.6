Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B550C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E90F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3piSu7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E90F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeJXD2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:28:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34466 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbeJXD2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:28:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so1148814pfe.1;
        Tue, 23 Oct 2018 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PrXD4JnxICCPQnrhqnIokHCmh/2aFHLbmOlKSYf0YaA=;
        b=q3piSu7aYGwTm5s8IaEMosgjvd//gngZ9rZBInZaY6l7gDl0VhVDZ8rO1G5JroWECn
         l5ZFsfFGYfGM45C11leE/St0O6nH7YW6OMILRennJdBYbccJVFsMwc9C5goXpDd4L348
         qnW1u2l1O+TU9ECcct0Ufzkj9aS7A8byC6lYcOFLFYipW43vzqpww4s7bpRs1i4f3yym
         HNdJdGcfrKdADK7kHijniumnjnLJy7M4/p4Pv/2Oax6KiBi2AfP7fVJ1wNZf3WfYII56
         sjnOwwFKla+bUfaiV8i1soJg4VyZn759V//0+NdRMcel9Hu9m4ugmc5KcIgZ/3N5u/z3
         Q93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PrXD4JnxICCPQnrhqnIokHCmh/2aFHLbmOlKSYf0YaA=;
        b=XIGluEVj47M8QoyZfmo5yaIipQMRg2ET/CTNgIX6etKH4yZvlYliIbBlyf0n9Cm1tW
         bawFdCL8F5JGLWQ0tmK4QZPQPfrgJbkxWlLSfAEJJNDOWbOyhkofmO1r7Q/ZxdtVppeI
         mS6nbcVm9BZrf4ccvlQnADGhlQ6GqQqZ8CKYEmC31OY+wO3UXERafhOCoof49Hrv4ok8
         REkIz4Pw+pAn2nbrVI/cj4A/LHsyPRn8qpcty5r8zQGtsSzP+cSEftwsBoDtqyBMNZw3
         8y521V7lMagW8EaAar/wt7txGGED/SvcGi7oSBHQ7x+XXv4aApP5lLHI8f1xVRcLAAfM
         ut6Q==
X-Gm-Message-State: ABuFfogmpNLBe+B/Y7sZENbNN7XfIPDYH6JeughY4j2Hqy2kv57wMXMB
        tvZ9qfqTaX8t0RCLH8MIdTIbSHsdtpo/Tw==
X-Google-Smtp-Source: ACcGV6364OZc089mMV78dky1rGI5FevBz7BlMQSIxlLV9R9lJJesaE7NMhKy+cgFzTkG631kpacEzg==
X-Received: by 2002:a63:700e:: with SMTP id l14-v6mr46667310pgc.359.1540321402869;
        Tue, 23 Oct 2018 12:03:22 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id d2-v6sm3081878pfd.100.2018.10.23.12.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 12:03:22 -0700 (PDT)
Date:   Wed, 24 Oct 2018 00:33:15 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181023190312.GA12915@nishad>
References: <20181022163935.GA756@nishad>
 <20181023111356.GA318@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181023111356.GA318@x220.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 01:13:56PM +0200, Slawomir Stepien wrote:
> On paź 22, 2018 22:09, Nishad Kamdar wrote:
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> 
> Hi
> 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> > Changes in v2:
> >  - Use the spi_device struct embedded in st instead
> >    of passing it as an argument to ad2s1210_setup_gpios().
> >  - Use an array of structs to reduce redundant code in
> >    in ad2s1210_setup_gpios().
> >  - Remove ad2s1210_free_gpios() as devm API is being used.
> 
> Some few more comments on that changes below.
> 
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 91 +++++++++++++------------
> >  drivers/staging/iio/resolver/ad2s1210.h |  3 -
> >  2 files changed, 48 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index ac13b99bd9cb..e4c222b47574 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -15,7 +15,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> >  
> >  #include <linux/iio/iio.h>
> > @@ -69,10 +69,21 @@ enum ad2s1210_mode {
> >  
> >  static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
> >  
> > +struct ad2s1210_gpio {
> > +	struct gpio_desc *ptr;
> 
> You are going to use this ptr to change a pointer it points to. So it must be a
> pointer to pointer: **ptr;
> 
> > +	char *name;
> 
> I guess it should be const char *.
> 
> > +	unsigned long flags;
> > +};
> > +
> >  struct ad2s1210_state {
> >  	const struct ad2s1210_platform_data *pdata;
> >  	struct mutex lock;
> >  	struct spi_device *sdev;
> > +	struct gpio_desc *sample;
> > +	struct gpio_desc *a0;
> > +	struct gpio_desc *a1;
> > +	struct gpio_desc *res0;
> > +	struct gpio_desc *res1;
> >  	unsigned int fclkin;
> >  	unsigned int fexcit;
> >  	bool hysteresis;
> > @@ -91,8 +102,8 @@ static const int ad2s1210_mode_vals[4][2] = {
> >  static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
> >  				     struct ad2s1210_state *st)
> >  {
> > -	gpio_set_value(st->pdata->a[0], ad2s1210_mode_vals[mode][0]);
> > -	gpio_set_value(st->pdata->a[1], ad2s1210_mode_vals[mode][1]);
> > +	gpiod_set_value(st->a0, ad2s1210_mode_vals[mode][0]);
> > +	gpiod_set_value(st->a1, ad2s1210_mode_vals[mode][1]);
> >  	st->mode = mode;
> >  }
> >  
> > @@ -152,8 +163,8 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
> >  
> >  static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
> >  {
> > -	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
> > -			  gpio_get_value(st->pdata->res[1]);
> > +	int resolution = (gpiod_get_value(st->res0) << 1) |
> > +			  gpiod_get_value(st->res1);
> >  
> >  	return ad2s1210_resolution_value[resolution];
> >  }
> > @@ -164,10 +175,10 @@ static const int ad2s1210_res_pins[4][2] = {
> >  
> >  static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
> >  {
> > -	gpio_set_value(st->pdata->res[0],
> > -		       ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> > -	gpio_set_value(st->pdata->res[1],
> > -		       ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
> > +	gpiod_set_value(st->res0,
> > +			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> > +	gpiod_set_value(st->res1,
> > +			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
> >  }
> >  
> >  static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
> > @@ -401,15 +412,15 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
> >  	int ret;
> >  
> >  	mutex_lock(&st->lock);
> > -	gpio_set_value(st->pdata->sample, 0);
> > +	gpiod_set_value(st->sample, 0);
> >  	/* delay (2 * tck + 20) nano seconds */
> >  	udelay(1);
> > -	gpio_set_value(st->pdata->sample, 1);
> > +	gpiod_set_value(st->sample, 1);
> >  	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
> >  	if (ret < 0)
> >  		goto error_ret;
> > -	gpio_set_value(st->pdata->sample, 0);
> > -	gpio_set_value(st->pdata->sample, 1);
> > +	gpiod_set_value(st->sample, 0);
> > +	gpiod_set_value(st->sample, 1);
> >  error_ret:
> >  	mutex_unlock(&st->lock);
> >  
> > @@ -466,7 +477,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
> >  	s16 vel;
> >  
> >  	mutex_lock(&st->lock);
> > -	gpio_set_value(st->pdata->sample, 0);
> > +	gpiod_set_value(st->sample, 0);
> >  	/* delay (6 * tck + 20) nano seconds */
> >  	udelay(1);
> >  
> > @@ -512,7 +523,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
> >  	}
> >  
> >  error_ret:
> > -	gpio_set_value(st->pdata->sample, 1);
> > +	gpiod_set_value(st->sample, 1);
> >  	/* delay (2 * tck + 20) nano seconds */
> >  	udelay(1);
> >  	mutex_unlock(&st->lock);
> > @@ -630,30 +641,30 @@ static const struct iio_info ad2s1210_info = {
> >  
> >  static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> >  {
> > -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> > -	struct gpio ad2s1210_gpios[] = {
> > -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> > -		{ st->pdata->a[0], flags, "a0" },
> > -		{ st->pdata->a[1], flags, "a1" },
> > -		{ st->pdata->res[0], flags, "res0" },
> > -		{ st->pdata->res[0], flags, "res1" },
> > +	int ret = 0, i = 0;
> 
> You do not need to init that i with 0.
> Also the ret do not have to be 0. If you return just 0 at the on this function.
> 
> > +	struct spi_device *spi = st->sdev;
> > +	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
> > +
> > +	struct ad2s1210_gpio gpios[] = {
> > +		{st->sample, "sample", GPIOD_IN},
> > +		{st->a0, "a0", flags},
> > +		{st->a1, "a1", flags},
> > +		{st->res0, "res0", flags},
> > +		{st->res1, "res1", flags},
> 
> To change a pointer, you need to pass an address of that pointer.
> I think you should you . notation when initializing the struct.
> 
> >  	};
> >  
> > -	return gpio_request_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> > -}
> > -
> > -static void ad2s1210_free_gpios(struct ad2s1210_state *st)
> > -{
> > -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> > -	struct gpio ad2s1210_gpios[] = {
> > -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> > -		{ st->pdata->a[0], flags, "a0" },
> > -		{ st->pdata->a[1], flags, "a1" },
> > -		{ st->pdata->res[0], flags, "res0" },
> > -		{ st->pdata->res[0], flags, "res1" },
> > -	};
> > +	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> 
> I do not know if that is a common practise, but you can set a pointer to gpio[i]
> as the first instruction in this for, so you would not have to write this whole
> gpio[i]:
> 
> pin = &gpios[i]
> 
> and then: pin->ptr, etc.
> 
> > +		gpios[i].ptr = devm_gpiod_get(&spi->dev, gpios[i].name,
> > +					      gpios[i].flags);
> > +		if (IS_ERR(gpios[i].ptr)) {
> > +			ret = PTR_ERR(gpios[i].ptr);
> > +			dev_err(&spi->dev, "Failed to request %s GPIO: %d\n",
> > +				gpios[i].name, ret);
> > +			return ret;
> > +		}
> > +	}
> >  
> > -	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> > +	return ret;
> >  }
> >  
> >  static int ad2s1210_probe(struct spi_device *spi)
> > @@ -692,18 +703,13 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret)
> > -		goto error_free_gpios;
> > -
> 
> Removing a empty line here, that is here to make it more readable.
> 
> > +		return ret;
> >  	st->fclkin = spi->max_speed_hz;
> >  	spi->mode = SPI_MODE_3;
> >  	spi_setup(spi);
> >  	ad2s1210_initial(st);
> >  
> >  	return 0;
> > -
> > -error_free_gpios:
> > -	ad2s1210_free_gpios(st);
> > -	return ret;
> >  }
> >  
> >  static int ad2s1210_remove(struct spi_device *spi)
> > @@ -711,7 +717,6 @@ static int ad2s1210_remove(struct spi_device *spi)
> >  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> >  
> >  	iio_device_unregister(indio_dev);
> > -	ad2s1210_free_gpios(iio_priv(indio_dev));
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
> > index e9b2147701fc..63d479b20a6c 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.h
> > +++ b/drivers/staging/iio/resolver/ad2s1210.h
> > @@ -12,9 +12,6 @@
> >  #define _AD2S1210_H
> >  
> >  struct ad2s1210_platform_data {
> > -	unsigned int		sample;
> > -	unsigned int		a[2];
> > -	unsigned int		res[2];
> >  	bool			gpioin;
> >  };
> >  #endif /* _AD2S1210_H */
> 
> -- 
> Slawomir Stepien
Hello,

Ok, I'll make the changes.

Thanks for the review.

regards,
Nishad

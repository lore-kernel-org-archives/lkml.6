Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A1C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A452082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3HGVreW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A452082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJ2F2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:28:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2F2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:28:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so2857674pgq.5;
        Sun, 28 Oct 2018 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5yRk6CxKjHC5xv26r4/dE3c8Ov+lAyCcrALTCY/VGY=;
        b=C3HGVreWHDzxPTDZWMkRicvj57ZNcWQH9UB/Pq0hcdUoF2ymZUhUToMrZ8DWLB14EZ
         d8Iv9MrshR3adCAzLmh2/IKaXA/GLu03Xb0xoHYKq02HfLot0taVMeP/BiUDOAX/yADU
         aXW8n2qhBVjyiGCrkQ94Ffo1rvPCE+VCcZBCiavX4/ir+CDFgCjrVCS3cSNFmsiuxBgE
         OE50q/ciS9J/sGYu2NaFBIQ9Zhv50XKMBhfJWslL/dR5MEsPjqP3W/DZmI0msXRhFZmb
         QTMKJb6/gLIb8jCHFDZKhqhKEMbViReyVZS4lgC/cg5T56JWTYXEiJRIBuYBiOCv9t6u
         oNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5yRk6CxKjHC5xv26r4/dE3c8Ov+lAyCcrALTCY/VGY=;
        b=Rmv9N+NKDqYr03tGUd3DnXqRfufupzbRYL/ZFjudUpkejL2BqMNWk5W6aNiLfqkz0N
         P44Schn6u+vaIgKugWbrdXp4eaFbrRPhvnadFQMfJ58yI3G01P/UthtEaxVtzro5i/oP
         LcWduIqvCdr1aNrG6FSvWXSPmaKuSs7VrhEeX9F7/Sd6MPEYsEQnC1kn9nZuaYlGa0FR
         UfvmJtiDcvJI05fTS47kwiDAFKnxkF3We5UwECcf+J3vc/4Rr8Cv2FpS55qljyaLtEiq
         CLhmdS4fy+iIaqeCzydkV1ET/kqtERnrfcEYgPFRY9hZNRJFAo8so11pvNwTrRF2jE+e
         pq9w==
X-Gm-Message-State: AGRZ1gIly2nQhR7UlUtB4s0E4kpGPE07wsJyRj9zaYpjQbBsoy3Uc9Rv
        Son/WaaVIKbmcb5HhMmJbgU=
X-Google-Smtp-Source: AJdET5eXC0D4qeYOGbIeQCXW9ecUWP0rs+sCgB6pux1vqOcWUMbWX5lS+IidlzbQTEX41RwWk6tppg==
X-Received: by 2002:a62:160c:: with SMTP id 12-v6mr1228279pfw.45.1540759337569;
        Sun, 28 Oct 2018 13:42:17 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id a64-v6sm22102256pfe.32.2018.10.28.13.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 13:42:17 -0700 (PDT)
Date:   Mon, 29 Oct 2018 02:12:11 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] staging: iio: ad2s1210: Switch to the gpio
 descriptor interface
Message-ID: <20181028202544.GA31531@nishad>
References: <cover.1540712249.git.nishadkamdar@gmail.com>
 <3b51eb662d107472e8bab38a87714354a1381779.1540712249.git.nishadkamdar@gmail.com>
 <20181028143607.332bcd4f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028143607.332bcd4f@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 02:36:07PM +0000, Jonathan Cameron wrote:
> On Sun, 28 Oct 2018 13:21:25 +0530
> Nishad Kamdar <nishadkamdar@gmail.com> wrote:
> 
> > Use the gpiod interface instead of the deprecated old non-descriptor
> > interface.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Hi Nishad,
> 
> Sorry it took me most of the week to get to this.  It's a trade off when you
> want to make fast progress, but I would suggest always leaving a few days
> between patches to see if there are other review comments coming in.
>

Ok, I'll keep that in mind.
> I don't particularly mind myself (as I'm very good at ignoring older versions ;)
> but I do feel some time got wasted here on your part.
> 
> Anyhow, what you have here is correct but the drive to get things as a nice
> array has lead to a weird mixture of being all array based and not being at all.
> Some suggestions in line that will hopefully tidy this up for you.
> 
> I'm basically suggesting adding a layer of indirection where you don't currently
> have one (on the actual reads and writes) so that you get more consistency
> with the setup code rather than adding a lot of fiddly indirection just in
> the setup code.
> 
> Note, what I've given is very much meant to be an illustration.  It's probably
> full of bugs and silly naming etc, so don't take it as being right!
> 
> Jonathan
> 
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
> >  drivers/staging/iio/resolver/ad2s1210.h |  3 -
> >  2 files changed, 50 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index ac13b99bd9cb..93c3c70ce62e 100644
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
> > +	struct gpio_desc **ptr;
> > +	const char *name;
> > +	unsigned long flags;
> > +};
> > +
> >  struct ad2s1210_state {
> >  	const struct ad2s1210_platform_data *pdata;
> >  	struct mutex lock;
> >  	struct spi_device *sdev;
> 
> With the setup below this becomes
> 	struct gpio_desc *gpios[5];
> 
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
> 
> With the below this becomes
> 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
> 
> >  	/* delay (2 * tck + 20) nano seconds */
> >  	udelay(1);
> >  	mutex_unlock(&st->lock);
> > @@ -630,30 +641,32 @@ static const struct iio_info ad2s1210_info = {
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
> > +	int ret, i;
> > +	struct spi_device *spi = st->sdev;
> > +	struct ad2s1210_gpio *pin;
> > +	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
> 
> So talk me through what is going on here?  All of a and res are controlled
> by this one parameter?
>

Yes. This was how the original code was. I kept it as it is.
> > +
> > +	struct ad2s1210_gpio gpios[] = {
> > +		{ .ptr = &st->sample, .name = "sample", .flags = GPIOD_IN },
> > +		{ .ptr = &st->a0, .name = "a0", .flags = flags },
> > +		{ .ptr = &st->a1, .name = "a1", .flags = flags },
> > +		{ .ptr = &st->res0, .name = "res0", .flags = flags },
> > +		{ .ptr = &st->res1, .name = "res1", .flags = flags },
> 
> To my eye, there are two sets of gpios in here.  They were originally handled
> like that st->pdata->a[0] etc, and it would be sensible to continue doing so.
> 
> Actually I don't really like the indirection at all.  Why not have
> a simple enum indexing the gpios and then have a single array in st for them all?
> 
> enum ad2s1210_gpios {
> 	AD2S1210_SAMPLE,
> 	AD2S1210_A0,
> 	AD2S1210_A1,
> 	AD2S1210_RES0,
> 	AD2S1210_RES1,
> };
> 
> Then have two constant versions of the above structure (shrunk a bit) that you
> pick from depending on the flag.
> 
> static const struct ad2s1210_gpio gpios_gpioin[] = {
> 	[AD2S1210_SAMPLE] = { .name = "sample", .flags = GPIOD_IN, },
> 	[AD2S1210_A0] = { .name = "a0", .flags = GPIOD_IN, },
> 	[AD2S1210_A1] = { .name = "a1", .flags = GPIOD_IN, },
> 	[AD2S1210_RES0] = { .name = "res0", .flags = GPIOD_IN, },
> 	[AD2S1210_RES1] = { .name = "res1", .flags = GPIOD_IN, },
> };
> 
> static const struct ad2s1210_gpio gpios_gpioout[] = {
> 	[AD2S1210_SAMPLE] = { .name = "sample", .flags = GPIOD_IN, },
> 	[AD2S1210_A0] = { .name = "a0", .flags = GPIOD_OUT, },
> 	[AD2S1210_A1] = { .name = "a1", .flags = GPIOD_OUT, },
> 	[AD2S1210_RES0] = { .name = "res0", .flags = GPIOD_OUT, },
> 	[AD2S1210_RES1] = { .name = "res1", .flags = GPIOD_OUT, },
> };
> 
> 
> static int ad2s1210_setup_gpios(struct ad2s1210_state *st, bool gpioin)
> {
> //note my naming is awful so do this better than I have ;)
> 	struct ad2s1201_gpio *pin = gpioin ? &gpios_gpioin[0] : &gpios_gpiout[0]; 
> 	int i;
> 
> 
> 	for (i = 0; i < ARRAY_SIZE(gpios_gpioin); i++) {
> 		st->gpios[i] = devm_gpiod_get(&spi->dev, pin[i]->name, pin[i]->flags);
> 		if (IS_ERR(st->gpios[i])) {
> 			ret = PTR_ERR(st->gpios[i]);
> 			dev_err(&spi->dev,
> 				"ad2s1210: failed to request %s GPIO: %d\n",
> 				pin->name, ret);
> 			return ret;
> 		}
> 	}
> 
> 	return 0;
> }
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
> > +		pin = &gpios[i];
> > +		*pin->ptr = devm_gpiod_get(&spi->dev, pin->name, pin->flags);
> > +		if (IS_ERR(*pin->ptr)) {
> > +			ret = PTR_ERR(*pin->ptr);
> > +			dev_err(&spi->dev,
> > +				"ad2s1210: failed to request %s GPIO: %d\n",
> > +				pin->name, ret);
> > +			return ret;
> > +		}
> > +	}
> >  
> > -	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> > +	return 0;
> >  }
> >  
> >  static int ad2s1210_probe(struct spi_device *spi)
> > @@ -692,7 +705,7 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret)
> > -		goto error_free_gpios;
> > +		return ret;
> >  
> >  	st->fclkin = spi->max_speed_hz;
> >  	spi->mode = SPI_MODE_3;
> > @@ -700,10 +713,6 @@ static int ad2s1210_probe(struct spi_device *spi)
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
> > @@ -711,7 +720,6 @@ static int ad2s1210_remove(struct spi_device *spi)
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

ok, I'll make the changes.

Thanks for thre review.

regards,
Nishad

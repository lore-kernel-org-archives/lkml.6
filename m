Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656716256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117C020892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyiV/syR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117C020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeG3SnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:43:23 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34063 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3SnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:43:23 -0400
Received: by mail-ua0-f193.google.com with SMTP id r10-v6so8329420uao.1;
        Mon, 30 Jul 2018 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VcVSAyPQCcCOAQr1PHCoW+2EjRGNa/UIMQ5J2ecBxJ8=;
        b=VyiV/syR9UKKb+c/d5ByO4qBQjb2zxa25pHCOxU2ir4Ek7uHhj46U8WJAaPj/wuZJE
         15tH6EyETsxFW3rxTdv0Q62KCCBDkuUrbfSSJfRrOnIRwYgtR0oNaxL7iFE5Q3fqjXSZ
         +DqYFQgpwsbPLCWvfH/FJMRaUSvU/bf/4i7t0EboyW9oXzb9UJag6KWgUm1zTNIHtZqb
         HX+NSQEKWiNQ+8aseRDk35+ODVPE3sV4nq9FgQ3btyw0VKvRQ09v0+od3TTz1LZLaltm
         Baz5upBsMK26ywFur4qkuvzdqeUMjQQ9x7AGcCoBR3/O9vjMeXoHQ9lQUT5b0SEuTrrw
         lZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VcVSAyPQCcCOAQr1PHCoW+2EjRGNa/UIMQ5J2ecBxJ8=;
        b=LhUF5JIYLZ89atvyQTByKnguPZw6e6mxkKJJsr3LOj4UJtHIRt0UdUPUnXthh3L4Ge
         v67XTHBDOVmuOt3D1NM41f/gf4ucGlvjEMLfXXleQJByocSLegCSK1PHhl3ir52imHzU
         eYoW6ehcgJZWQR+HHjlREnZ6gEdFf7vvIqLIqM3x8hD4cobIFdqo/BQ+TFsE4S1gTXLq
         tqa09HQXTZNwaLX/a0g1kMnaYwxJr4DMSAzHTMGV5AoPP2icoD7cwwWuEXeNa403NmF0
         bc5vn6bUIlh0u+qyYs11oZOV2w6F7YjqaWMDlb9l9KxRsiC68+T12OOnjb6nziYxqThh
         DO1A==
X-Gm-Message-State: AOUpUlF0gq5aKD9oxCtcMK89/02MucrmH2V24qacTspA3Ek+ZgxE2gXD
        G3aEKYmsFjhm0va31MMfZqQFjjOigKVUdczk67k=
X-Google-Smtp-Source: AAOMgpfvO/Qgq8iEaqLekFp9lRGy8mS7HJQTWtNShcvbc90pyarfQ7FrfNCbZjBKJvVTNmLcA5MMeIjjJ+dvsu/YVIQ=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr12510310ual.141.1532970446709;
 Mon, 30 Jul 2018 10:07:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 10:07:26
 -0700 (PDT)
In-Reply-To: <20180730140205.4972-1-mircea.caprioru@analog.com>
References: <20180730140205.4972-1-mircea.caprioru@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Jul 2018 20:07:26 +0300
Message-ID: <CAHp75VdJ95Az=WmUP2Rb7byLs7J_T80FcNJ6zTNwnxDYh4NnJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: ad5770r: Add AD5770R support
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ludovic Desroches <ludovic.desroches@o2linux.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 5:02 PM, Mircea Caprioru
<mircea.caprioru@analog.com> wrote:
> The AD5770R is a 6-channel, 14-bit resolution, low noise, programmable
> current output digital-to-analog converter (DAC) for photonics control
> applications.
>
> It contains five 14-bit resolution current sourcing DAC channels and one
> 14-bit resolution current sourcing/sinking DAC channel.

Looks nice, though few comments below.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/delay.h>
> +#include <linux/property.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>

Can we keep it sorted?

> +#define AD5770R_LOW_VREF       1250
> +#define AD5770R_HIGH_VREF      2500

_VREF_mV ?

We usually use units as suffixes to the constant to increase
readability of the code.

> +       bool                            internal_ref;
> +       bool                            ch_pwr_down[AD5770R_MAX_CHANNELS];

A nit: I would rather swap them.

> +static int ad5770r_reset(struct ad5770r_state *st)
> +{

> +       if (st->gpio_reset) {
> +               gpiod_set_value(st->gpio_reset, 0);
> +               udelay(100);
> +               gpiod_set_value(st->gpio_reset, 1);

usleep_range() ?

Btw, can it be called from atomic context?

Otherwise I would consider to call gpiod_set_value_cansleep().

> +       } else {
> +               /* Perform a software reset */
> +               return ad5770r_soft_reset(st);
> +       }

Perhaps

/* Perform software reset if no GPIO provided */
if (!st->gpio_reset)
 return ...;

...

?

> +       /* data must not be written during reset timeframe */
> +       mdelay(1); /* TODO update with value from datasheet once available */

Perhaps usleep_range()? mdelay even for 1ms is kinda long time.

> +
> +       return 0;
> +}

> +static int ad5770r_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int val, int val2, long info)
> +{
> +       struct ad5770r_state *st = iio_priv(indio_dev);

> +       unsigned char buf[2];

Perhaps this kind of buffers better to be defined as u8 ?

> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:

> +               buf[0] = ((u16)val >> 6) & 0xFF;

Useless & 0xFF.

> +               buf[1] = (val & 0x3F) << 2;
> +               return regmap_bulk_write(st->regmap, chan->address,
> +                                        buf, ARRAY_SIZE(buf));
> +       default:
> +               return -EINVAL;
> +       }
> +}

> +static int ad5770r_store_output_range(struct ad5770r_state *st,
> +                                     int min, int max, int index)
> +{
> +       int i;
> +
> +       for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
> +               if (ad5770r_rng_tbl[i].ch != index)
> +                       continue;

> +               if (ad5770r_rng_tbl[i].min != min ||
> +                   ad5770r_rng_tbl[i].max != max)

Hmm... If you keep your table sorted you may bail out immediately when
you know that there will not be proper value.

> +                       continue;
> +               st->output_mode[index].out_range_mode = ad5770r_rng_tbl[i].mode;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}

> +static const struct iio_chan_spec_ext_info ad5770r_ext_info[] = {
> +       {
> +               .name = "powerdown",
> +               .read = ad5770r_read_dac_powerdown,
> +               .write = ad5770r_write_dac_powerdown,
> +               .shared = IIO_SEPARATE,
> +       },

> +       { },

Terminator entries are slightly better without comma (guard even at
compile time).

> +};

> +static int ad5770r_channel_config(struct ad5770r_state *st)
> +{
> +       int ret, tmp[2], min, max, i;
> +       unsigned int num;
> +       struct fwnode_handle *child;

> +       bool ch_config[AD5770R_MAX_CHANNELS] = {0};

I'm not sure I understood necessity of this array.

> +       device_for_each_child_node(&st->spi->dev, child) {
> +               ret = fwnode_property_read_u32(child, "num", &num);
> +               if (ret)
> +                       return ret;
> +               if (num > AD5770R_MAX_CHANNELS)
> +                       return -EINVAL;
> +
> +               ret = fwnode_property_read_u32_array(child,
> +                                                    "adi,range-microamp",
> +                                                    tmp, 2);
> +               if (ret)
> +                       return ret;
> +
> +               min = tmp[0] / 1000;
> +               max = tmp[1] / 1000;
> +               ret = ad5770r_store_output_range(st, min, max, num);
> +               if (ret)
> +                       return ret;

> +
> +               ch_config[num] = true;

As far as I can see you will end up this loop if and only if you have
all defined channels initialized. The question left behind is a number
of child properties, thus count them first.

> +       }
> +
> +       for (i = 0; i < AD5770R_MAX_CHANNELS; i++)
> +               if (!ch_config[i])
> +                       return -EINVAL;
> +
> +       return ret;
> +}

> +       for (i = 0; i < AD5770R_MAX_CHANNELS; i++) {

> +               ret = ad5770r_set_output_mode(st,
> +                                             &st->output_mode[i], i);

Can it be one line?

> +               if (ret)
> +                       return ret;
> +       }

-- 
With Best Regards,
Andy Shevchenko

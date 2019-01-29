Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE6C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBF52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfA2Mrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:47:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43360 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfA2Mrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:47:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so17345762lji.10;
        Tue, 29 Jan 2019 04:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3L86jxVLOMgiLbQsEYlRoW4QwCnaneaySWijxSlhlQ=;
        b=hxi0rvTsG7XqiFztqZMj4cTyxp7TwLSlpcB6l/HKNFrDMgD+CBXn1qeUrLSjM3vjq/
         Heg9VBlvh2L073bn07qh2l1CdDqHiBPpR+KTz1aPfQlhyGjdYuGvMyGJy0CPH9OoO1N7
         zptqgUL3lyK2wanLdi+w00XEAg+Th80xraL0+dQKDKXVFo9gzysE9e4oSilOJUDeetdX
         4tSFeYO+HaYt+JTvxyu+cDSHI9LSruYGwe7bp34OHgmOfcL+cdsTEyaq9nBHiB5+0D8b
         HLoK3kpp43a3P6EFmBB5dTk50EDgXHn1Cd3VuG9NJT+9W1x4jEHS/8uFMjBNQn16CHmx
         PPdQ==
X-Gm-Message-State: AJcUukdA2mstRcXQnckWEQqyGsbV0Wbt/bDCuElpT0qWl+/WeM66cTax
        +i7GJngtQo7ThWglnFSfFMKgKTRAyPUi2wpyZI8=
X-Google-Smtp-Source: ALg8bN71aMk5eFhAPQveoPbkcAU4dQTcZ9BlbiPA3OHk5Yh2taEwPw/+UlhWOr9f1Ewz2lwBvlBDSNCJ8Tpv2BSsJew=
X-Received: by 2002:a2e:9147:: with SMTP id q7-v6mr17291140ljg.69.1548766057811;
 Tue, 29 Jan 2019 04:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20190125100055.13836-1-ricardo@ribalda.com> <20190126204155.6fbb9512@archlinux>
 <CAPybu_2pk9twU6Wmxng0jcdZyN_1L0jWPwDB266Cs3ZwyMmFLw@mail.gmail.com>
 <20190127150349.304fcd7a@archlinux> <CAPybu_3024ErA3AAODnQ7zsM83Ay0L7VBozMQAdOxh+hT3Lzvw@mail.gmail.com>
 <20190129124428.000029d4@huawei.com>
In-Reply-To: <20190129124428.000029d4@huawei.com>
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
Date:   Tue, 29 Jan 2019 13:47:21 +0100
Message-ID: <CAPybu_3rUON03ujnwzbr0kGSwjDCPRaap5wNsFXYVzyP5McEdw@mail.gmail.com>
Subject: Re: [PATCH v2] iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan

On Tue, Jan 29, 2019 at 1:45 PM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 28 Jan 2019 08:59:33 +0100
> Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:
>
> > Hi Jonathan
> >
> > On Sun, Jan 27, 2019 at 4:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Sat, 26 Jan 2019 22:34:50 +0100
> > > Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:
> > >
> > > > HI Jonathan
> > > >
> > > > Thanks for your review. I will make the changes and send it back to
> > > > you after testing it on Monday on real hardware.
> > > >
> > > > Until then I have pushed my changes to
> > > > https://github.com/ribalda/linux/tree/ribalda-iio-v3 in case you want
> > > > to see it before I send it to the list.
> > > > (I am still missing the dt-bindings)
> > > >
> > > > Some comments inline.
> > > Replies inline.
> > >
> > > >
> > > > Best regards!
> > > >
> > > > On Sat, Jan 26, 2019 at 9:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > > >
> > > > > On Fri, 25 Jan 2019 11:00:55 +0100
> > > > > Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:
> > > > >
> > > > > > It is a driver for Texas Instruments Dual, 12-Bit Serial Input
> > > > > > Digital-to-Analog Converter.
> > > > > >
> > > > > > Datasheet of this chip:
> > > > > > http://www.ti.com/lit/ds/sbas106/sbas106.pdf
> > > > > >
> > > > > > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> > > > > Hi Ricardo,
> > > > >
> > > > > Various bits and pieces inline.
> > > > >
> > > > > Jonathan
> > > > >
> > > > > > ---
> > > > > >
> > > > > > v2: Fix range
> > > > > >  MAINTAINERS                  |   6 ++
> > > > > >  drivers/iio/dac/Kconfig      |  10 +++
> > > > > >  drivers/iio/dac/Makefile     |   1 +
> > > > > >  drivers/iio/dac/ti-dac7612.c | 169 +++++++++++++++++++++++++++++++++++
> > > > > >  4 files changed, 186 insertions(+)
> > > > > >  create mode 100644 drivers/iio/dac/ti-dac7612.c
> > > > > >
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index d039f66a5cef..30ba5435906b 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -14877,6 +14877,12 @@ F:   Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> > > > > >  F:   drivers/clk/keystone/sci-clk.c
> > > > > >  F:   drivers/reset/reset-ti-sci.c
> > > > > >
> > > > > > +Texas Instruments' DAC7612 DAC Driver
> > > > > > +M:   Ricardo Ribalda <ricardo@ribalda.com>
> > > > > > +L:   linux-iio@vger.kernel.org
> > > > > > +S:   Supported
> > > > > > +F:   drivers/iio/dac/ti-dac7612.c
> > > > > > +
> > > > > >  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
> > > > > >  M:   Hans Verkuil <hverkuil@xs4all.nl>
> > > > > >  L:   linux-media@vger.kernel.org
> > > > > > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > > > > > index f28daf67db6a..fbef9107acad 100644
> > > > > > --- a/drivers/iio/dac/Kconfig
> > > > > > +++ b/drivers/iio/dac/Kconfig
> > > > > > @@ -375,6 +375,16 @@ config TI_DAC7311
> > > > > >
> > > > > >         If compiled as a module, it will be called ti-dac7311.
> > > > > >
> > > > > > +config TI_DAC7612
> > > > > > +     tristate "Texas Instruments 12-bit 2-channel DAC driver"
> > > > > > +     depends on SPI_MASTER && GPIOLIB
> > > > > > +     help
> > > > > > +       Driver for the Texas Instruments DAC7612, DAC7612U, DAC7612UB
> > > > > > +       The driver hand drive the load pin automatically, otherwise
> > > > > > +       it needs to be toggled manually.
> > > > >
> > > > > Given the driver doesn't load without that pin, do we need to give
> > > > > the otherwise?  I would drop this comment entirely.
> > > >
> > > > I am probing the gpio with devm_gpiod_get_optional() so the driver can
> > > > load without the pin
> > > Hmm. I thought that would blow up when you tried to set the output but
> > > it seems not as the gpiod function just returns without doing anything.
> > >
> > > So is this a an actual usecase you have?  My inclination would be to just
> > > make it non optional otherwise.  The thought of relying on a random pulse
> > > from another device doesn't seem like a good idea to me.
> >
> > I am thinking on a usecase where both voltages need to be set at the
> > same time or on sync with an external event.
> > This is how our board was designed 6 years ago: http://ge.tt/28oRQCu2
> >
> > But, up to date no one is using it that way :).
> >
> > All that said, the only change to support that usecase is to use the
> > _optional() function, that does not affect the
> > readability of the code. But if it is a showstopper for you I will
> > remove it and make the gpio "mandatory"
>
> OK. Add a clear comment on why it is optional and we can leave it as such.
> Will need to be in the DT docs and the code.
>

Text on v3 is good enough or I make a v4 with a better explanation?

Thanks!

> Jonathan
>
> >
> > Thanks and best regatrds!
> >
> >
> > >
> > > >
> > > > >
> > > > > > +
> > > > > > +       If compiled as a module, it will be called ti-dac7612.
> > > > > > +
> > > > > >  config VF610_DAC
> > > > > >       tristate "Vybrid vf610 DAC driver"
> > > > > >       depends on OF
> > > > > > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > > > > > index f0a37c93de8e..1369fa1d2f0e 100644
> > > > > > --- a/drivers/iio/dac/Makefile
> > > > > > +++ b/drivers/iio/dac/Makefile
> > > > > > @@ -41,4 +41,5 @@ obj-$(CONFIG_STM32_DAC) += stm32-dac.o
> > > > > >  obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
> > > > > >  obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
> > > > > >  obj-$(CONFIG_TI_DAC7311) += ti-dac7311.o
> > > > > > +obj-$(CONFIG_TI_DAC7612) += ti-dac7612.o
> > > > > >  obj-$(CONFIG_VF610_DAC) += vf610_dac.o
> > > > > > diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..278406f69e0c
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/iio/dac/ti-dac7612.c
> > > > > > @@ -0,0 +1,169 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * DAC7612 Dual, 12-Bit Serial input Digital-to-Analog Converter
> > > > > > + *
> > > > > > + * Copyright 2019 Qtechnology A/S
> > > > > > + * 2019 Ricardo Ribalda <ricardo@ribalda.com>
> > > > > > + *
> > > > > > + * Licensed under the GPL-2.
> > > > > > + */
> > > > > > +#include <linux/kernel.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/spi/spi.h>
> > > > > > +#include <linux/gpio/consumer.h>
> > > > > > +#include <linux/iio/iio.h>
> > > > > > +
> > > > > > +#define NUM_CHANS 2
> > > > > > +#define RESOLUTION 12
> > > > > Please prefix any naming that is generic like this with
> > > > > the driver name.  Avoids potential redefined clashes in the future.
> > > > > Where they are 'real numbers' rather than Magic numbers I would
> > > > > generally look at using the actual number rather than a define.
> > > > >
> > > > > > +
> > > > > > +struct dac7612 {
> > > > > > +     struct spi_device *spi;
> > > > > > +     struct gpio_desc *nld;
> > > > > > +     uint16_t cache[NUM_CHANS];
> > > > > > +};
> > > > > > +
> > > > > > +static int dac7612_cmd_single(struct dac7612 *priv, int channel, u16 val)
> > > > > > +{
> > > > > > +     uint8_t buffer[2];
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (channel >= NUM_CHANS)
> > > > > Is there any way this can happen?  Seems a little over paranoid.
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     buffer[0] = BIT(5) | (channel << 4) | (val >> 8);
> > > > > BIT(5) is a magic number so should probably come from a define
> > > > > as should the shifts of the other parts.
> > > > >
> > > > > > +     buffer[1] = val & 0xff;
> > > > > > +
> > > > > > +     priv->cache[channel] = val;
> > > > > > +
> > > > > > +     ret = spi_write(priv->spi, buffer, sizeof(buffer));
> > > > >
> > > > > spi write can potentially do a dma transfer so it needs
> > > > > a dma safe buffer.  This one isn't as it is on the stack.
> > > > > Given it is a moderately fast path, best option is to put the
> > > > > buffer in priv and use the __cacheline_aligned trick (plus the
> > > > > fact private data is already cacheline aligned) to get it into
> > > > > it's own cacheline.  Wofram Sang's OSS talk on i2c dma is a good
> > > > > tutorial on this and is on youtube if you have time.
> > > > >
> > > > > https://www.youtube.com/watch?v=JDwaMClvV-s
> > > > >
> > > > > > +     if (ret)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     gpiod_set_value(priv->nld, 0);
> > > > > > +     gpiod_set_value(priv->nld, 1);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +#define dac7612_CHANNEL(chan, name) {                                \
> > > > > > +     .type = IIO_VOLTAGE,                                    \
> > > > > > +     .channel = (chan),                                      \
> > > > > > +     .address = (chan),                                      \
> > > > > Not used, so don't set it.
> > > > >
> > > > > > +     .indexed = true,                                        \
> > > > > These are bit fields, so whilst this works, = 1 is more conventional.
> > > > >
> > > > > > +     .output = true,                                         \
> > > > > > +     .datasheet_name = name,                                 \
> > > > > > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> > > > > > +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
> > > > > > +     .scan_type = {                                          \
> > > > > > +                     .sign = 'u',                            \
> > > > > > +                     .realbits = RESOLUTION,                 \
> > > > > > +                     .storagebits = RESOLUTION,              \
> > > > > No need to provide scan_type as we don't have buffered output in
> > > > > mainline.  Also this would be wrong as storagebits needs to be
> > > > > 8/16/32/64 etc.
> > > > >
> > > > > Would prefer a straight forward value like RESOLUTION was just
> > > > > expressed as a number.
> > > > >
> > > > > > +     },                                                      \
> > > > > > +}
> > > > > > +
> > > > > > +static const struct iio_chan_spec dac7612_channels[] = {
> > > > > > +     dac7612_CHANNEL(0, "OUTA"),
> > > > > > +     dac7612_CHANNEL(1, "OUTB"),
> > > > > > +};
> > > > > > +
> > > > > > +static int dac7612_read_raw(struct iio_dev *iio_dev,
> > > > > > +                         const struct iio_chan_spec *chan,
> > > > > > +                         int *val, int *val2, long mask)
> > > > > > +{
> > > > > > +     struct dac7612 *priv;
> > > > > > +
> > > > > > +     switch (mask) {
> > > > > > +     case IIO_CHAN_INFO_RAW:
> > > > > > +             priv = iio_priv(iio_dev);
> > > > > > +             *val = priv->cache[chan->channel];
> > > > > > +             return IIO_VAL_INT;
> > > > > > +
> > > > > > +     case IIO_CHAN_INFO_SCALE:
> > > > > > +             *val = 1000000;
> > > > >
> > > > > This makes me wonder.  The units of voltage are millivolts, so is
> > > > > raw value * 1000000 = value in mv?
> > > >
> > > > I tried using IIO_VAL_FRACTIONAL, with val = 1 and val2=1000000, and
> > > > it only returned -EINVAL.
> > >
> > > That is odd and definitely worth chasing down the reason.
> > >
> > > > Then I discovered the PLUS_MICRO and I want to remember that cating
> > > > the range sysfs file returned:
> > > > 0,000001, but I will try again on Monday.
> > > >
> > > > >
> > > > > That would make this a very high voltage device.
> > > > > See Documentation/ABI/testing/sysfs-bus-iio* for
> > > > > IIO ABI documentation.
> > > > >
> > > > > > +             return IIO_VAL_INT_PLUS_MICRO;
> > > > > > +
> > > > > > +     default:
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +static int dac7612_write_raw(struct iio_dev *iio_dev,
> > > > > > +                          const struct iio_chan_spec *chan,
> > > > > > +                          int val, int val2, long mask)
> > > > > > +{
> > > > > > +     struct dac7612 *priv;
> > > > >
> > > > > struct dac7612 *priv = iio_priv(iio_dev);
> > > > >
> > > > > (it's just macro magic to get the right point so normally considered
> > > > > fine to be called like this).
> > > > >
> > > > >
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (mask != IIO_CHAN_INFO_RAW)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     if ((val >= BIT(RESOLUTION)) || val < 0)
> > > > > > +             return -EINVAL;
> > > > >
> > > > > As not providing a write_fmt function (which is fine)
> > > > > should also sanity check that val2 is 0.
> > > > >
> > > > > > +
> > > > > > +     priv = iio_priv(iio_dev);
> > > > > > +     if (val == priv->cache[chan->channel])
> > > > > > +             return 0;
> > > > > > +
> > > > > > +     mutex_lock(&iio_dev->mlock);
> > > > > > +     ret = dac7612_cmd_single(priv, chan->channel, val);
> > > > > > +     mutex_unlock(&iio_dev->mlock);
> > > > > > +
> > > > > > +     return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct iio_info dac7612_info = {
> > > > > > +     .read_raw = dac7612_read_raw,
> > > > > > +     .write_raw = dac7612_write_raw,
> > > > > > +};
> > > > > > +
> > > > > > +static int dac7612_probe(struct spi_device *spi)
> > > > > > +{
> > > > > > +     struct iio_dev *iio_dev;
> > > > > > +     struct dac7612 *priv;
> > > > > > +     int i;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> > > > > > +     if (!iio_dev)
> > > > > > +             return -ENOMEM;
> > > > > > +
> > > > > > +     priv = iio_priv(iio_dev);
> > > > > > +     priv->nld = devm_gpiod_get_optional(&spi->dev, "nLD", GPIOD_OUT_HIGH);
> > > > >
> > > > > This isn't a particularly standard gpio name.  Hence this driver definitely
> > > > > needs a DT binding doc (remember to cc dt list and maintainers).  Also
> > > > > this should almost certainly be prefixed with a vendor prefix.
> > > > >
> > > > > It's also not the name I'm seeing on the datasheet, so needs some justifying
> > > > > comments.
> > > > >
> > > > > > +     if (IS_ERR(priv->nld))
> > > > > > +             return PTR_ERR(priv->nld);
> > > > > > +     priv->spi = spi;
> > > > > > +     spi_set_drvdata(spi, iio_dev);
> > > > > > +     iio_dev->dev.parent = &spi->dev;
> > > > > > +     iio_dev->info = &dac7612_info;
> > > > > > +     iio_dev->modes = INDIO_DIRECT_MODE;
> > > > > > +     iio_dev->channels = dac7612_channels;
> > > > > > +     iio_dev->num_channels = NUM_CHANS;
> > > > > ARRAY_SIZE.
> > > > > > +     iio_dev->name = spi_get_device_id(spi)->name;
> > > > > > +
> > > > > > +     for (i = 0; i < NUM_CHANS; i++) {
> > > > > ARRAY_SIZE
> > > > > > +             ret = dac7612_cmd_single(priv, i, 0);
> > > > > > +             if (ret)
> > > > > > +                     return ret;
> > > > > > +     }
> > > > > > +
> > > > > > +     return devm_iio_device_register(&spi->dev, iio_dev);
> > > > > > +}
> > > > > > +
> > > > > > +static const struct spi_device_id dac7612_id[] = {
> > > > > > +     {"ti-dac7612"},
> > > > > > +     {}
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(spi, dac7612_id);
> > > > > > +
> > > > > > +static struct spi_driver dac7612_driver = {
> > > > > > +     .driver = {
> > > > > > +                .name = "ti-dac7612",
> > > > > > +                },
> > > > > > +     .probe = dac7612_probe,
> > > > > > +     .id_table = dac7612_id,
> > > > > > +};
> > > > > > +module_spi_driver(dac7612_driver);
> > > > > > +
> > > > > > +MODULE_AUTHOR("Ricardo Ribalda <ricardo@ribalda.com>");
> > > > > > +MODULE_DESCRIPTION("Texas Instruments DAC7612 DAC driver");
> > > > > > +MODULE_LICENSE("GPL v2");
> > > > >
> > > >
> > > >
> > >
> >
> >
> > --
> > Ricardo Ribalda
>
>


-- 
Ricardo Ribalda

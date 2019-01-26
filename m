Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CDBC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AAD218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYFMPo1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfAZBSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:18:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43554 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:18:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so4890026pgk.10;
        Fri, 25 Jan 2019 17:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6Iy/qu3/5OfVAMNpU2OUS/po6hhVI4bHLABVvTcgx+k=;
        b=XYFMPo1QvfqCBsXI+PZt7E4FxhLoSAarAtyNElpBKR8tYe4beB6tHiMPBXIsQSpVWp
         rXkhKkHJhulokY9YHoqVmfJlJFOyX4/PAHXpQ5+bvGVahMhO91RCc+2KIa0DI4iB/GDu
         SQkh1YH5Eh6FtfXu7s+zQ8yI/lSUfv7OcPf7ei/GSdh/vyhH7Vgg4APvbC/Whwdds7Ai
         DOfrJO5+uYpsdPc3z1tYgOCCWPIhf3jdyfDdwj1UgcOVYmCdX2i1WPBj6izyx8bhk4gt
         f3sbldpgLh+qJ2Nhv1lOA3UB6AZwwfLGI56NXBBVh5uClzVjBfNKjrvny8ftAeSZ1NP1
         SImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6Iy/qu3/5OfVAMNpU2OUS/po6hhVI4bHLABVvTcgx+k=;
        b=meRVwlhvJyrXkF0KWPVgdzj5H3DyqWo5lXz4lSPlinX/11pkMeSzENHZRe3Wps44zw
         qxHwnveP8OJQlcYmqn8nV32RxFMWgw56NZTimEW/uB9htPZo0cv5F6/X5y2JBRHV2n7G
         pk0VGG4HlHrkbuJu7C4f1Xse3gNVlM/Z4DGUDIgYjubz7u+SjUFu6MMyDbKD6s4+FNjQ
         JjTDO24fxGYXsRj/vLRhjp8dfKK+AtdHyhvGdiWiXUubJKmPcjgMyYNNReDbU4z0kL/+
         aFyHCnYZnfrykU1WGIMYKT5haAVCM9UJNfxWMUtgWZ5jy/omF3evM7A6tn+kj6LvoRZ4
         /fLw==
X-Gm-Message-State: AJcUukeTk7NwpwqEQRleDasKDDv9M2kiZtMUaOL0u7jPKtcvKQB88kxf
        wChpYCfjEV67O+MvqPv8dHI=
X-Google-Smtp-Source: ALg8bN7VG/EIENogtw9GpjzBk9Ho/4loFlMuW7bZXl5EfJrpYc81VlMZRlod5RDWw+x6V1zCmXW7iw==
X-Received: by 2002:a62:3006:: with SMTP id w6mr13336817pfw.258.1548465482862;
        Fri, 25 Jan 2019 17:18:02 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b2sm35965244pgg.87.2019.01.25.17.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:18:02 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:18:00 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] input: misc: gp2a: Add support for light sensor
Message-ID: <20190126011800.GC212026@dtor-ws>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125175045.22576-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125175045.22576-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:50:43PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> The gp2a driver previously only supported the proximity part of the
> sensor while the hardware supports both.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/misc/Kconfig         |  2 +
>  drivers/input/misc/gp2ap002a00f.c  | 71 +++++++++++++++++++++++++++++-
>  include/linux/input/gp2ap002a00f.h |  4 ++
>  3 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2be9bc5..a532efb4e6d8 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -252,6 +252,8 @@ config INPUT_GP2A
>  	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
>  	depends on I2C
>  	depends on GPIOLIB || COMPILE_TEST
> +	depends on IIO
> +	select INPUT_POLLDEV
>  	help
>  	  Say Y here if you have a Sharp GP2AP002A00F proximity/als combo-chip
>  	  hooked to an I2C bus.
> diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
> index 79c8c4c56d1a..090c8c313295 100644
> --- a/drivers/input/misc/gp2ap002a00f.c
> +++ b/drivers/input/misc/gp2ap002a00f.c
> @@ -10,9 +10,12 @@
>   */
>  
>  #include <linux/i2c.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/irq.h>
>  #include <linux/slab.h>
>  #include <linux/input.h>
> +#include <linux/input-polldev.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/gpio.h>
> @@ -20,7 +23,9 @@
>  #include <linux/input/gp2ap002a00f.h>
>  
>  struct gp2a_data {
> +	struct iio_channel *channel;
>  	struct input_dev *input;
> +	struct input_polled_dev *poll_dev;
>  	const struct gp2a_platform_data *pdata;
>  	struct i2c_client *i2c_client;
>  };
> @@ -58,6 +63,19 @@ static irqreturn_t gp2a_irq(int irq, void *handle)
>  	return IRQ_HANDLED;
>  }
>  
> +static void gp2a_poll(struct input_polled_dev *dev)
> +{
> +	struct gp2a_data *dt = dev->private;
> +	int ret, value;
> +
> +	ret = iio_read_channel_processed(dt->channel, &value);
> +	if (ret < 0)
> +		dev_err(&dt->i2c_client->dev, "failed to read value!");
> +
> +	input_report_abs(dev->input, ABS_MISC, value);
> +	input_sync(dev->input);

No, light sensor is not an input device, keep it in IIO please.

-- 
Dmitry

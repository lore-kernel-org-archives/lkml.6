Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B47C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF65243E3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVBLbCwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF65243E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDQKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:10:52 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44564 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:10:36 -0400
Received: by mail-ua0-f194.google.com with SMTP id v15-v6so3725825ual.11;
        Wed, 04 Jul 2018 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v9wU6Lu1f6XwuUbAy6v/dXZ3D/MPrqX6wpk/IUUkW7c=;
        b=pVBLbCwVSDGGSCZ8PhUv5mTY/3B08r+6tZRnx7gmkixaewSJjh0/KHUYvRFN0DD5uR
         EDzIiy2mgmvffHyry22DCf7D+bP+qixHht3r0Dc/FBrmtV19iKUqukB/MG9KGoNubJxX
         QESBIROZptj+CfZ41w70qqGYLa3OxJDQO/q3v0jPyoUnsZoaiuN3PJZrDghgYzYZax6y
         Wbs0DfUvwB+jJL6iHAV4hxyYUAg/HVP6+osP16qAMjxSU7m26ve/6TWp3toxIgUGj6FV
         qC1qzIXzB0UVVLHHWMyyHdLDZyGF9d1pb+RzjNIUpwPIY5r7TqkZKQ2yW4hnJsbHaqsL
         Pw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v9wU6Lu1f6XwuUbAy6v/dXZ3D/MPrqX6wpk/IUUkW7c=;
        b=BPIzymHggsqf30ByllDBQWQrn4nw6+88Lm4mzg/fxC5J/lsDnzdzaBIRA66Bqf8uaq
         sjNLeS4s857WMYV3dGia9SaaTTTqPh91foTXDULk2i01+ZsrxLqlP+n7/9BLXlLmVcU4
         ra6ToYq0cC17OOoXUolXmYHt8+0pnZUwNwpgNMz2nNl4DMipXooVgC7kFL8ubXnStqMW
         uraNXNtdDW4OMiL7jlJ4LQwceq0mGfpKXMbEJC6kI2pDNRLaR6QMrlYreUNrBf0txcUy
         S9HhMEEyPzbX4SMR0xyRABhqpLyiwFkvUmJcjq3ThzQ7TOio0Ha5vBfbN7eLaixNSXdr
         0GsQ==
X-Gm-Message-State: APt69E2u/SYGv5njv/SWMtupUH4i33SW39MPMV0Lirk6oILtkLG7kf/0
        k1jTeISeawCir60I6M4TlvdX8qI6ZkSrBCvLrw8=
X-Google-Smtp-Source: AAOMgpf5Nlx8R/yZmzCr0tG53tTsYgf4TsrX3zdFwy+92IhOM4i/cJSTjDJXiBvZa4xfoH3jlW05m0BlVZoDbkA2Nfs=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1567356uae.12.1530720635752;
 Wed, 04 Jul 2018 09:10:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:10:35 -0700 (PDT)
In-Reply-To: <e8cb86f843d6b524b671f8fd79fece02475a61c0.1530710826.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de> <e8cb86f843d6b524b671f8fd79fece02475a61c0.1530710826.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 19:10:35 +0300
Message-ID: <CAHp75VfJOhX3+eL-ppvT7SPfDE_S7ht1drjobvFqmXPYApMETg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 8:41 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> Use device_get_match_data API to simplify access to driver data.
> Let acpi_device_id table entries point to the same driver data as
> of_device_id table entries and uniquify access to driver data by using
> device_get_match_data API. Remove unused i2c_device_id .driver_data
> fields.
>

Couple of comments below, otherwise

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  drivers/iio/accel/st_accel_i2c.c | 56 ++++++++++++++------------------
>  1 file changed, 24 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 6bdec8c451e0..c6e08c834f11 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -14,8 +14,8 @@
>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> +#include <linux/property.h>
>
> -#include <linux/iio/common/st_sensors.h>
>  #include <linux/iio/common/st_sensors_i2c.h>
>  #include "st_accel.h"
>
> @@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id st_accel_acpi_match[] = {
> -       {"SMO8A90", LNG2DM},
> +       {"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
>         { },

Is it done against iio-next?

I see two records in this table.

(It might make sense to remove comma from terminator, though it's
minor change, up to you)

>  };
>  MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
> @@ -116,24 +116,24 @@ MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
>  #endif
>
>  static const struct i2c_device_id st_accel_id_table[] = {
> -       { LSM303DLH_ACCEL_DEV_NAME, LSM303DLH },
> -       { LSM303DLHC_ACCEL_DEV_NAME, LSM303DLHC },
> -       { LIS3DH_ACCEL_DEV_NAME, LIS3DH },
> -       { LSM330D_ACCEL_DEV_NAME, LSM330D },
> -       { LSM330DL_ACCEL_DEV_NAME, LSM330DL },
> -       { LSM330DLC_ACCEL_DEV_NAME, LSM330DLC },
> -       { LIS331DLH_ACCEL_DEV_NAME, LIS331DLH },
> -       { LSM303DL_ACCEL_DEV_NAME, LSM303DL },
> -       { LSM303DLM_ACCEL_DEV_NAME, LSM303DLM },
> -       { LSM330_ACCEL_DEV_NAME, LSM330 },
> -       { LSM303AGR_ACCEL_DEV_NAME, LSM303AGR },
> -       { LIS2DH12_ACCEL_DEV_NAME, LIS2DH12 },
> -       { LIS3L02DQ_ACCEL_DEV_NAME, LIS3L02DQ },
> -       { LNG2DM_ACCEL_DEV_NAME, LNG2DM },
> -       { H3LIS331DL_ACCEL_DEV_NAME, H3LIS331DL },
> -       { LIS331DL_ACCEL_DEV_NAME, LIS331DL },
> -       { LIS3LV02DL_ACCEL_DEV_NAME, LIS3LV02DL },
> -       { LIS2DW12_ACCEL_DEV_NAME, LIS2DW12 },
> +       { LSM303DLH_ACCEL_DEV_NAME },
> +       { LSM303DLHC_ACCEL_DEV_NAME },
> +       { LIS3DH_ACCEL_DEV_NAME },
> +       { LSM330D_ACCEL_DEV_NAME },
> +       { LSM330DL_ACCEL_DEV_NAME },
> +       { LSM330DLC_ACCEL_DEV_NAME },
> +       { LIS331DLH_ACCEL_DEV_NAME },
> +       { LSM303DL_ACCEL_DEV_NAME },
> +       { LSM303DLM_ACCEL_DEV_NAME },
> +       { LSM330_ACCEL_DEV_NAME },
> +       { LSM303AGR_ACCEL_DEV_NAME },
> +       { LIS2DH12_ACCEL_DEV_NAME },
> +       { LIS3L02DQ_ACCEL_DEV_NAME },
> +       { LNG2DM_ACCEL_DEV_NAME },
> +       { H3LIS331DL_ACCEL_DEV_NAME },
> +       { LIS331DL_ACCEL_DEV_NAME },
> +       { LIS3LV02DL_ACCEL_DEV_NAME },
> +       { LIS2DW12_ACCEL_DEV_NAME },
>         {},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> @@ -143,6 +143,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  {
>         struct iio_dev *indio_dev;
>         struct st_sensor_data *adata;
> +       const char *match;
>         int ret;
>
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
> @@ -151,19 +152,10 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>
>         adata = iio_priv(indio_dev);
>
> -       if (client->dev.of_node) {
> -               st_sensors_of_name_probe(&client->dev, st_accel_of_match,
> -                                        client->name, sizeof(client->name));
> -       } else if (ACPI_HANDLE(&client->dev)) {
> -               ret = st_sensors_match_acpi_device(&client->dev);
> -               if ((ret < 0) || (ret >= ST_ACCEL_MAX))
> -                       return -ENODEV;
> -
> -               strlcpy(client->name, st_accel_id_table[ret].name,
> -                               sizeof(client->name));
> -       } else if (!id)
> -               return -ENODEV;

> +       match = device_get_match_data(&client->dev);

>

Redundant blank line

> +       if (match)
> +               strlcpy(client->name, match, sizeof(client->name));
>
>         st_sensors_i2c_configure(indio_dev, client, adata);
>
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko

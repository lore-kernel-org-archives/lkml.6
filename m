Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD9C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D36A218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAYKE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:04:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46968 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfAYKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:04:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so7848044ljh.13;
        Fri, 25 Jan 2019 02:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7aOMs0vIJjrHNIHohArKs+ZYg6iu1l6evR+1mvQBGMA=;
        b=jlprIs3hZY668Eih1ccM8MMgcyKEhxPFwqsjynufBS3C5815EGtqeJLKqcWj2XGEyB
         mZ49Q8j9Rh/xNNEqeAr0E/90j87Z8cMTJH+KjfwzrW+8G/JK91qpBSZO/Omnts2SXdI7
         psWeyCBfYUNNO7Q+kIxxSi6me4//DDgNhedA7fsnQXSc7m5yHnBww0TDmN9D4YHTaraP
         +sZJHpbiyUfcd2s3uUGA/1IDIqqNPGZ+BVThttHfxcXmgRvNURd0AfiSvIWxm2Wu/imQ
         sAM1zSxYrU4WsAl1K0izFs4PsXgYa92bk3dzUonVMnJFXMAa3L95nfrIPcK6YXXNnAZL
         AE4g==
X-Gm-Message-State: AJcUukfWbsu/8MwGnSDNnScSyjL62CZxi3Dnc+vmS80/HraYE0KvOzXO
        yyuSvoXuMVdeMnQP0JWXQKvRucS/U4mQ16M6WwI=
X-Google-Smtp-Source: ALg8bN5lkyEpDtaLjaJgYnezYmtFGYQANkX8xyqrVlQmgIcQLGcNyH+jBMZ2IjnXE/kPP8j5qzSknPO9yAARPfV5lFI=
X-Received: by 2002:a2e:84ca:: with SMTP id q10-v6mr8550463ljh.65.1548410665846;
 Fri, 25 Jan 2019 02:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20190125100147.14259-1-ricardo@ribalda.com>
In-Reply-To: <20190125100147.14259-1-ricardo@ribalda.com>
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
Date:   Fri, 25 Jan 2019 11:04:09 +0100
Message-ID: <CAPybu_3ueYtdSofu=vZu5hr+EkfH1O8-ww31UyaKniikGfzECg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7476: Add support for ADS786X ADCs
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, for the last two mails with the wrong [PATCH], instead of
[PATCH v2]. I thought I was "dry-running" my script.

On Fri, Jan 25, 2019 at 11:01 AM Ricardo Ribalda Delgado
<ricardo@ribalda.com> wrote:
>
> Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> ADC.
>
> Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> ---
> v2: I have missnamed the devices
>  drivers/iio/adc/Kconfig  |  3 ++-
>  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f9354e5ee65c..d86900fc2634 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -64,7 +64,8 @@ config AD7476
>         help
>           Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
>           AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> -         AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> +         AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
> +         to digital converters (ADC).
>
>           To compile this driver as a module, choose M here: the
>           module will be called ad7476.
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 0549686b9ef8..76747488044b 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
>         ID_ADC081S,
>         ID_ADC101S,
>         ID_ADC121S,
> +       ID_ADS7866,
> +       ID_ADS7867,
> +       ID_ADS7868,
>  };
>
>  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
> @@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
>                 BIT(IIO_CHAN_INFO_RAW))
>  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
> +               BIT(IIO_CHAN_INFO_RAW))
>
>  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>         [ID_AD7091R] = {
> @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>                 .channel[0] = ADC081S_CHAN(12),
>                 .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>         },
> +       [ID_ADS7866] = {
> +               .channel[0] = ADS786X_CHAN(12),
> +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +       },
> +       [ID_ADS7867] = {
> +               .channel[0] = ADS786X_CHAN(10),
> +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +       },
> +       [ID_ADS7868] = {
> +               .channel[0] = ADS786X_CHAN(8),
> +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +       },
>  };
>
>  static const struct iio_info ad7476_info = {
> @@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
>         {"adc081s", ID_ADC081S},
>         {"adc101s", ID_ADC101S},
>         {"adc121s", ID_ADC121S},
> +       {"ads7866", ID_ADS7866},
> +       {"ads7867", ID_ADS7867},
> +       {"ads7868", ID_ADS7868},
>         {}
>  };
>  MODULE_DEVICE_TABLE(spi, ad7476_id);
> --
> 2.20.1
>


-- 
Ricardo Ribalda

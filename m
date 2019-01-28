Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ADCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D164421738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7+u0tsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfA1MA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:00:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36429 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfA1MA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:00:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so12782798oix.3;
        Mon, 28 Jan 2019 04:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RS7TGw3Q7q6W0EWIJ93uDTECWNvTB7WUq0nmAIxF1CY=;
        b=N7+u0tsMqAabw9jkYIOKKyc6MWUszmEb5C/ybwo69c8JJLBDFSir7TkkrWeMPZaugM
         IsZmv2qpgLUTDCM0rNkp4JPbAsPRzZLRnonNni+bGwa3oafdlOVSEo4IDPeNLn4Q2X/7
         tNRPv6JqnkXQ5YPv0RYx0aQ+j2KbOIwMjHPjTyNxtMGF69azYHIweBLQsIuCYqgQ5dwX
         h49vXKmxgYYjUQ3BLdkhoTQb9jsd0qYtppw1miabwHm0mRTML+KYStdxz6ZggUeikDbd
         9V2Q+GIVtfyg2YoW2b/TmIlVnOpv+7aCTEwzzZ/wBurMw01v37hlTKUtPGHT7xe4Q437
         y0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RS7TGw3Q7q6W0EWIJ93uDTECWNvTB7WUq0nmAIxF1CY=;
        b=Y+0U2FWGHXlgvU67NfYT4QKWsWew/KPN4kfloNvhZXFR9pfbuyk79LTjsr/tgjHL0/
         +RNpOsfX7SvrQfSXV+cWRKRQ6zXxIIP/2vLr7uso4YZTLreOMWcrqQPZgWL4qmY6s6W+
         I2CutXxWzkVCdmP8rYqFClTfOnofIePd3SDUK7B6vdioSvt/g+as30mCl2LWCD1As1l3
         o7AdTJ8f0smvnlNbC0LyBZiK6IHN+IQoh2FdAaYotj+M7/Upirx0XLOalwNEt3KKQwIC
         QNVhMh84M3O9NAfenwVtluMFaJMx+hHlcwkigF0Kw5ZJokvEixOUGRqJ950vL+n8VEIi
         60WQ==
X-Gm-Message-State: AJcUukez7+LtltVIcq0QogJKcVzN3PeTuOaaeg+noXvvG/ZJGncW+d2v
        m/zSSLzcwBQuqcEtzjfLkQ0ko2Xw7L8dVYL9BWQ=
X-Google-Smtp-Source: ALg8bN5iNpnpcaFrHlj+NNfQ5VTJ4ghSNBkWzhQtAoi3N19JChsvR4OWHdskX/6LufsrBt/pBuW4vWa/LrpMRuPG3Kw=
X-Received: by 2002:aca:d644:: with SMTP id n65mr5699040oig.287.1548676827827;
 Mon, 28 Jan 2019 04:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20190128094851.3975-1-ricardo@ribalda.com>
In-Reply-To: <20190128094851.3975-1-ricardo@ribalda.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 28 Jan 2019 14:00:15 +0200
Message-ID: <CA+U=DspRfs8G7Vaa_s367Aryde8uX4ioRcWv9yFGu6hkzQKH6Q@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: ad7476: Add support for TI ADS786X ADCs
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:49 AM Ricardo Ribalda Delgado
<ricardo@ribalda.com> wrote:
>
> Add support for Texas Instruments ADS7866, ADS7867 and ADS7868
> 8/10/12 bit Single channel ADC.
>
> Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf
>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> ---
> v3: Changes by Alexandru Ardelean <ardeleanalex@gmail.com>
>
> - Modify Kconfig to clarify that the chip is not from AD, but from TI
>
>  drivers/iio/adc/Kconfig  |  6 ++++--
>  drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f9354e5ee65c..2d3442252e32 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -57,14 +57,16 @@ config AD7298
>           module will be called ad7298.
>
>  config AD7476
> -       tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
> +       tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD an TI"
>         depends on SPI
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         help
>           Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
>           AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
> -         AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
> +         AD7495, AD7910, AD7920, AD7920. SPI analog to digital converters (ADC).
> +         And for Texas Instrumments ADS7866, ADS7867, ADS7868. SPI analog to
Typo: Instrumments -> Instruments

> +         digital converters (ADC).

I would break it into a table-like format.
I didn't see if there is a common/recommended way of doing things for
these drivers.

But something like:

           Say yes here to build support for the following SPI analog
to digital converters (ADCs):
           Analog Devices:  AD7273, AD7274, AD7276, AD7277, AD7278,
AD7475, AD7476,
                                     AD7477, AD7478, AD7466, AD7467,
AD7468, AD7495, AD7910,
                                     AD7920
           Texas Instruments:  ADS7866, ADS7867, ADS7868

Funny thing: I just noticed that the AD7920 was listed twice.


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

Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02636C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95B821915
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB4dqZRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfAYI3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:29:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33841 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYI3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:29:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so7839693otk.1;
        Fri, 25 Jan 2019 00:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLy0h+QMOhO9fBvlSzRAhEKmK/ocgEKSoYIkItMbfns=;
        b=lB4dqZRRYF9LPSu6tI2XEXdKCePsv7gVIfUlrD8Fl9l38QXUgRel4mjggM6+Qnk5Q0
         FLfn2/LO9wUU5dbqBj4vd0PkUm6EwbK2VurE48VBiKtZ4Bxyog5aScyvsgoCUa53bCCq
         +4rpSgaO3zkRAzol1NtsKBj9LAtheLgBN6h1Htayql0qa2/uLVRAyBB+XU7u4ah6jaGD
         h6r7Q8bYQeG7jb6A8rqg4ybIqdlnPUM15BUghDC/DkLtTwbK3zJpMDxOajpxaePmyGcT
         DtVFFT+x5yMffLYTfyDWHXQyGhIrRr5WysDtt82/rVBs1ox788dvvor734u8DEuy9fzO
         nolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLy0h+QMOhO9fBvlSzRAhEKmK/ocgEKSoYIkItMbfns=;
        b=iXFSZ45mb/Xu22ZLlhg0GcwazqVijSNeRZxek0IQPqg4yde9c4G7fceJ2SlP2AhLbA
         f4UnxBCeDqPIbrJ05QLlWIBT5TXwM5NuUQHnjKjiDvlt5ByZTDDRtBvWKdwHLi/JiRx1
         SdK1VNKOVh8z+3/Zv1+VTGv3IGrbJhkBJI8iLhQ2Mu4cTSjQAZZ85OMyjvY34CCZRnXs
         jNpXfkkncKqYELvjjq+iGR2MltVA6onq9VI1hVlp//GdYZC4s2WJrTbdz4sPjFxg/Tq4
         cE91J+6EQOtqeH085sjWRaR6T9oYSiK1fO60BHUwH3R+gAjGWvWB8NPs6PbMuG7xUbyJ
         a7yQ==
X-Gm-Message-State: AJcUukcwQ+MGjeaMfjpdusN9PonwOOLSPuhhm6Omp8v/hJtg0I98J1WB
        Q69i+q1cGpGRdkoHfmLdsFKfj+F3dSq8McPqA+c=
X-Google-Smtp-Source: ALg8bN69IN6ZXDFtzZPu5JLqdmJU+qXPkpumKxkXI1iL7068szzaIiN1curhyXKPK7UYfz5AOqdPgvsCjtoecZJ64kY=
X-Received: by 2002:a9d:7059:: with SMTP id x25mr7345622otj.35.1548404959292;
 Fri, 25 Jan 2019 00:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20190124213225.11803-1-ricardo@ribalda.com>
In-Reply-To: <20190124213225.11803-1-ricardo@ribalda.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 25 Jan 2019 10:29:07 +0200
Message-ID: <CA+U=Dspe=xvki7rZPhofiV50yOLnRR2sg9v1R_XRVxHbDXh-_Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7476: Add support for ADS786X ADCs
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:33 PM Ricardo Ribalda Delgado
<ricardo@ribalda.com> wrote:
>
> Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
> ADC.
>
> Datasheet: http://www.ti.com/product/ADS7866
> Datasheet: http://www.ti.com/product/ADS7867
> Datasheet: http://www.ti.com/product/ADS7868
>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> ---
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

The driver is for Analog Devices parts.
And these new parts are from TI.

I'm not sure what the policy is for mixing manufacturers in drivers.
But if that is allowed/fine, then maybe it would be a good idea to
highlight that these chips are from another manufacturer.
Or maybe rename the driver to a generic form to support both manufacturers ?

In any case, Jonathan will have to tell us what to do here :)

Thanks
Alex

>
>           To compile this driver as a module, choose M here: the
>           module will be called ad7476.
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 0549686b9ef8..108c18d64f7d 100644
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
> +#define ADS786X_CHAN(bits) _AD7476_CHAN((bits) + 4, 0, \
> +               BIT(IIO_CHAN_INFO_RAW))
>
>  static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>         [ID_AD7091R] = {
> @@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>                 .channel[0] = ADC081S_CHAN(12),
>                 .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>         },
> +       [ID_ADS7866] = {
> +               .channel[0] = ADS786X_CHAN(8),
> +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +       },
> +       [ID_ADS7867] = {
> +               .channel[0] = ADS786X_CHAN(10),
> +               .channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +       },
> +       [ID_ADS7868] = {
> +               .channel[0] = ADS786X_CHAN(12),
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeC3LJy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:09:54 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33488 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC3LJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:09:52 -0400
X-Google-Smtp-Source: AIpwx4+Tur2Qu1E1XiFs6veQnpKXJMTJIKnbrpnQLGatmi4pQq4cPFZPZOmfZ6EqmYu8eQq2TJKbFDJM67St3BaA9SQ=
MIME-Version: 1.0
In-Reply-To: <20180326084629.100070-4-yixun.lan@amlogic.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com> <20180326084629.100070-4-yixun.lan@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 30 Mar 2018 13:09:31 +0200
Message-ID: <CAFBinCCK+Y0QAHcGDXvXvSqChS91XK5C6d5XunkmUVBQa4nn+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: meson-axg: add saradc driver
To: Yixun Lan <yixun.lan@amlogic.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:46 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> Add the SAR ADC driver for the Amlogic Meson-AXG SoC.
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
I suggest changing the subject of this patch to:
iio: adc: meson-saradc: add support for Meson AXG

(because "iio: adc: meson-axg" does not point to the "meson-saradc"
driver and no new driver is added with this patch)

with that:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  drivers/iio/adc/meson_saradc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 799ed929ab99..a5d481a2b4ef 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -935,6 +935,11 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>         .name = "meson-gxm-saradc",
>  };
>
> +static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
> +       .param = &meson_sar_adc_gxl_param,
> +       .name = "meson-axg-saradc",
> +};
> +
>  static const struct of_device_id meson_sar_adc_of_match[] = {
>         {
>                 .compatible = "amlogic,meson8-saradc",
> @@ -953,6 +958,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
>         }, {
>                 .compatible = "amlogic,meson-gxm-saradc",
>                 .data = &meson_sar_adc_gxm_data,
> +       }, {
> +               .compatible = "amlogic,meson-axg-saradc",
> +               .data = &meson_sar_adc_axg_data,
>         },
>         {},
>  };
> --
> 2.15.1
>

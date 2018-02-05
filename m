Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeBEGOO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:14:14 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33996 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752828AbeBEGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:36 -0500
X-Google-Smtp-Source: AH8x226RqPtlKhrtzp5EzgXa4Qe2dzMQhlBoflcZgwsw65+IG7jxTBLuqZ7C7v/lfvHW5AnM2ARedQ==
Date: Mon, 5 Feb 2018 00:08:34 -0600
From: Rob Herring <robh@kernel.org>
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        daniel.baluta@nxp.com, mihai.serban@gmail.com, linux-imx@nxp.com,
        Mihai Serban <mihai.serban@nxp.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC driver
Message-ID: <20180205060834.7fwbqnyzrfze4cli@rob-hp-laptop>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 03:20:09PM +0200, Cosmin-Gabriel Samoila wrote:
> The AK4458 is a 32-bit 8ch Premium DAC that corresponds
> to a 768kHz PCM input and an 11.2MHz DSD input at maximum.
> It supports I2S, DSD and TDM modes with 24 or 32 bit MSB
> or 16, 24, 32 LSB formats. Its datasheet is available here:
> https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf
> 
> Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/ak4458.txt |   23 +

Separate patch please.

>  sound/soc/codecs/Kconfig                           |   18 +
>  sound/soc/codecs/Makefile                          |    6 +
>  sound/soc/codecs/ak4458-i2c.c                      |   79 ++
>  sound/soc/codecs/ak4458-spi.c                      |   61 ++
>  sound/soc/codecs/ak4458.c                          | 1132 ++++++++++++++++++++
>  sound/soc/codecs/ak4458.h                          |  127 +++
>  7 files changed, 1446 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
>  create mode 100644 sound/soc/codecs/ak4458-i2c.c
>  create mode 100644 sound/soc/codecs/ak4458-spi.c
>  create mode 100644 sound/soc/codecs/ak4458.c
>  create mode 100644 sound/soc/codecs/ak4458.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
> new file mode 100644
> index 0000000..b9e6eb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak4458.txt
> @@ -0,0 +1,23 @@
> +AK4458 audio DAC
> +
> +This device supports both I2C and SPI modes.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak4458"
> +- reg : The I2C address of the device for I2C, the chip select number for SPI.
> +- asahi-kasei,pdn-gpios: A GPIO specifier for the GPIO controlling
> +	the power down & reset pin.

reset-gpios like the Asahi Kasei ADC under review.
 
> +- asahi-kasei,mute-gpios: A GPIO specifier for the GPIO controlling
> +	the soft mute pin.

State the active state.

> +
> +Example:
> +
> +&i2c {
> +	ak4458: ak4458@10 {

dac@10

> +		compatible = "asahi-kasei,ak4458";
> +		reg = <0x10>;
> +		asahi-kasei,pdn-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>
> +		asahi-kasei,mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
> +	};
> +};

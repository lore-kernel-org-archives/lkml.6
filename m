Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeCGWaw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:30:52 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43808 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGWau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:30:50 -0500
X-Google-Smtp-Source: AG47ELtVOR1ik6eg3grPvCK3SRO0qe++amQ7y0fAzXTJbxd5JuJM1KQslUB6zYl+ShZUiAGl0cID8A==
Date: Wed, 7 Mar 2018 16:30:48 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        michael@amarulasolutions.com
Subject: Re: [PATCH v2 2/2] ASoC: Add bindings for PCM1789
Message-ID: <20180307223048.lqnryaazr5egg2m7@rob-hp-laptop>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
 <20180305124817.7421-3-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180305124817.7421-3-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 01:48:17PM +0100, Mylène Josserand wrote:
> Add a device-tree binding for Texas Instrument's PCM1789 codec.
> For the moment, only I2C bus is supported but SPI could be added
> in future.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sound/pcm1789.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm1789.txt b/Documentation/devicetree/bindings/sound/pcm1789.txt
> new file mode 100644
> index 000000000000..a6cdc2c83c98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm1789.txt
> @@ -0,0 +1,21 @@
> +Texas Instruments pcm1789 DT bindings

What function does this device provide?

> +
> +This driver supports the I2C bus.

Bindings describe h/w, not drivers.

> +
> +Required properties:
> +
> + - compatible: "ti,pcm1789"
> +
> +Required properties on I2C:
> +
> + - reg: the I2C address
> + - reset-gpios: GPIO to control the RESET pin
> +
> +Examples:
> +
> +	codec: pcm1789@4c {

audio-codec@4c

If that's the function...

> +		compatible = "ti,pcm1789";
> +		reg = <0x4c>;
> +		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <0>;
> +	};
> -- 
> 2.11.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753727AbeDTRFz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:05:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47650 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753689AbeDTRFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:05:53 -0400
Message-ID: <ac518e1f3b943385f641ea9aa785846ad64a6eb4.camel@collabora.com>
Subject: Re: [PATCH] ARM: dts: imx53-ppd: Use IRQ_TYPE_* constants
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Date: Fri, 20 Apr 2018 14:04:43 -0300
In-Reply-To: <20180420154553.18070-1-sebastian.reichel@collabora.co.uk>
References: <20180420154553.18070-1-sebastian.reichel@collabora.co.uk>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-20 at 17:45 +0200, Sebastian Reichel wrote:
> Replace magic numbers with IRQ_TYPE_* constants to improve
> DT readability.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  arch/arm/boot/dts/imx53-ppd.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
> index d5628af2e301..d02d07470ad3 100644
> --- a/arch/arm/boot/dts/imx53-ppd.dts
> +++ b/arch/arm/boot/dts/imx53-ppd.dts
> @@ -300,7 +300,7 @@
>  		compatible = "dlg,da9053-aa";
>  		reg = <0>;
>  		interrupt-parent = <&gpio3>;
> -		interrupts = <12 0x8>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
>  		spi-max-frequency = <1000000>;
>  		dlg,tsi-as-adc;
>  		tsiref-supply = <&reg_tsiref>;
> @@ -473,7 +473,7 @@
>  				compatible = "fsl,mma8453";
>  				reg = <0x1c>;
>  				interrupt-parent = <&gpio1>;
> -				interrupts = <6 0>;
> +				interrupts = <6 IRQ_TYPE_NONE>;
>  				interrupt-names = "INT1";
>  			};
>  
> @@ -539,7 +539,7 @@
>  		reset-gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
>  		reg = <0x4b>;
>  		interrupt-parent = <&gpio5>;
> -		interrupts = <4 0x8>;
> +		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>  	};
>  };
>  
> 

Looks good to me:

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

And it made me think, how many of these do we have?
Or even worse, how many are using the wrong specifiers?

$ git grep interrupts -- arch/arm/boot/dts  | grep -v IRQ_TYPE | grep GPIO
arch/arm/boot/dts/am335x-baltos-ir3220.dts:		interrupts = <20 GPIO_ACTIVE_LOW>;
arch/arm/boot/dts/am335x-baltos-ir5221.dts:		interrupts = <20 GPIO_ACTIVE_LOW>;
arch/arm/boot/dts/am335x-baltos.dtsi:		interrupts = <28 GPIO_ACTIVE_LOW>;
arch/arm/boot/dts/am335x-boneblue.dts:		interrupts = <21 GPIO_ACTIVE_LOW>;
arch/arm/boot/dts/at91-sama5d2_xplained.dts:						interrupts = <PIN_PB13
GPIO_ACTIVE_LOW>;
arch/arm/boot/dts/imx53-qsb.dts:		interrupts = <11 0x8>; /* low-level active IRQ at GPIO7_11 */
arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi:		interrupts = <11 0x8>; /* low-level active IRQ at GPIO7_11
*/
arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi:		interrupts = <9 0x8>; /* active-low GPIO2_9 */
arch/arm/boot/dts/omap3-pandora-common.dtsi:		interrupts = <30 0>;	/* GPIO_94 */
arch/arm/boot/dts/ste-href-stuib.dtsi:					 * GPIO 67 for interrupts. Pull-up
arch/arm/boot/dts/tegra124-nyan.dtsi:					interrupts = <TEGRA_GPIO(J, 0)
arch/arm/boot/dts/tegra124-venice2.dts:					interrupts = <TEGRA_GPIO(J, 0)
arch/arm/boot/dts/vf-colibri-eval-v3.dtsi:		interrupts = <11 GPIO_ACTIVE_LOW>;

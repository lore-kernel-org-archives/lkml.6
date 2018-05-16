Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEPWSl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:18:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44888 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeEPWSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:18:39 -0400
X-Google-Smtp-Source: AB8JxZpD8p/UWXdGk/kCXI584HSrzZgl/eAhPvQs3L2RQm7gtFNXbCPh22tNRZzkxswr5NtQgo+RNw==
Date: Thu, 17 May 2018 00:18:36 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: laurent.pinchart@ideasonboard.com, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: renesas: draak: Describe CVBS input
Message-ID: <20180516221836.GH17948@bigcity.dyn.berto.se>
References: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526478129-16465-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526478129-16465-3-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your patch.

On 2018-05-16 15:42:08 +0200, Jacopo Mondi wrote:
> Describe CVBS video input through analog video decoder ADV7180
> connected to video input interface VIN4.
> 
> The video input signal path is shared with HDMI video input, and
> selected by on-board switches SW-53 and SW-54 with CVBS input selected
> by the default switches configuration.

You are missing your SoB line :-)

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 36 ++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> index d03f194..9aba28f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> @@ -142,6 +142,11 @@
>  		groups = "usb0";
>  		function = "usb0";
>  	};
> +
> +	vin4_pins_cvbs: vin4 {
> +		groups = "vin4_data8", "vin4_sync", "vin4_clk";
> +		function = "vin4";
> +	};
>  };
>  
>  &i2c0 {
> @@ -154,6 +159,17 @@
>  		reg = <0x50>;
>  		pagesize = <8>;
>  	};
> +
> +	analog-video@20 {
> +		compatible = "adi,adv7180";
> +		reg = <0x20>;
> +
> +		port {
> +			adv7180_out: endpoint {
> +				remote-endpoint = <&vin4_in>;
> +			};
> +		};
> +	};
>  };
>  
>  &i2c1 {
> @@ -246,3 +262,23 @@
>  	timeout-sec = <60>;
>  	status = "okay";
>  };
> +
> +&vin4 {
> +	pinctrl-0 = <&vin4_pins_cvbs>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			vin4_in: endpoint {
> +				remote-endpoint = <&adv7180_out>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund

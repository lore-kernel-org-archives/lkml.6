Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeEPWXX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:23:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38974 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeEPWXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:23:20 -0400
X-Google-Smtp-Source: AB8JxZrjonohoYlDQd57JeskbTnGpHs8HptbvyoKh25jWB0Dl5cvg35xr5/uO30qPUd1r9Fpynvl4A==
Date: Thu, 17 May 2018 00:23:18 +0200
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: laurent.pinchart@ideasonboard.com, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: draak: Describe HDMI input
Message-ID: <20180516222318.GI17948@bigcity.dyn.berto.se>
References: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526478129-16465-4-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526478129-16465-4-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your patch.

On 2018-05-16 15:42:09 +0200, Jacopo Mondi wrote:
> Describe HDMI input connector and ADV7612 HDMI decoder installed on
> R-Car Gen3 Draak board.
> 
> The video signal routing to the HDMI decoder to the video input interface
> VIN4 is multiplexed with CVBS input path, and enabled/disabled through
> on-board switches SW-49, SW-50, SW-51 and SW-52.
> 
> As the default board switches configuration connects CVBS input to VIN4,
> leave the HDMI decoder unconnected in DTS.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

I'm not sure we have a policy about describing hardware which can't be 
used without flipping switches. I have no opinion on if we should do 
that or not I leave that to others, but for the change itself.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

I think it's good we describe it as it's part of the Draak board itself 
and not an expansion board which we have seen a lot of :-) Maybe even 
add a commented out line in the adv7612 port@2 which hints which VIN 
this is connected to if the switches are flipped?

> ---
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 38 ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> index 9aba28f..ea99dc9 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> @@ -59,6 +59,17 @@
>  		};
>  	};
>  
> +	hdmi-in {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&adv7612_in>;
> +			};
> +		};
> +	};
> +
>  	memory@48000000 {
>  		device_type = "memory";
>  		/* first 128MB is reserved for secure area. */
> @@ -170,6 +181,33 @@
>  			};
>  		};
>  	};
> +
> +	hdmi-decoder@4c {
> +		compatible = "adi,adv7612";
> +		reg = <0x4c>;
> +		default-input = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7612_in: endpoint {
> +					remote-endpoint = <&hdmi_con_in>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				adv7612_out: endpoint {
> +					pclk-sample = <0>;
> +					hsync-active = <0>;
> +					vsync-active = <0>;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  &i2c1 {
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund

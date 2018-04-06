Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757116AbeDFNt2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:49:28 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:35076 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757080AbeDFNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:49:24 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: renesas: eagle: Add LVDS decoder
Date: Fri, 06 Apr 2018 16:49:23 +0300
Message-ID: <2194450.fjOBDBAAyU@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1523020092-25540-7-git-send-email-jacopo+renesas@jmondi.org>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org> <1523020092-25540-7-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Friday, 6 April 2018 16:08:11 EEST Jacopo Mondi wrote:
> The R-Car V3M Eagle board includes a transparent THC63LVD1024 LVDS
> decoder, connected to the on-chip LVDS encoder output on one side
> and to the not-yet-described HDMI encoder ADV7511W on the other one.
> 
> As the decoder does not need any configuration it has been so-far
> omitted from DTS. Now that a driver is available, describe it in DT
> as well.

As explained in my review of patch 5/7, I'd merge 5/7, 6/7 and 7/7 all 
together as there's little use for enabling the LVDS decoder if there's 
nothing connected at its output. Note also how this patch alone, without 7/7, 
wouldn't comply with the LVDS decoder DT bindings that state that port@2 is 
mandatory.

> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts index 144b847..9d0e65d
> 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -31,6 +31,23 @@
>  		/* first 128MB is reserved for secure area. */
>  		reg = <0x0 0x48000000 0x0 0x38000000>;
>  	};
> +
> +	thc63lvd1024: lvds-decoder {
> +		compatible = "thine,thc63lvd1024";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				thc63lvd1024_in: endpoint {
> +					remote-endpoint = <&lvds0_out>;
> +				};
> +			};
> +		};
> +	};
>  };
> 
>  &avb {
> @@ -104,3 +121,15 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&lvds0 {
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&thc63lvd1024_in>;
> +			};
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart

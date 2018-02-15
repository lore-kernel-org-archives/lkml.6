Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033086AbeBOOMH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:12:07 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:48556 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032283AbeBOOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:12:05 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kbingham@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, geert@glider.be,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] arm64: dts: renesas: r8a77995-draak: Enable DU
Date: Thu, 15 Feb 2018 16:12:38 +0200
Message-ID: <6281511.bskcdgqsgb@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1518683903-10681-7-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org> <1518683903-10681-7-git-send-email-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 15 February 2018 10:38:21 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Enable the DU, providing only the VGA output for now.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I assume Simon will take care of this patch.

> ---
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 51 +++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index
> af07da240be0..668e246dfc5d 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> @@ -27,6 +27,38 @@
>  		stdout-path = "serial0:115200n8";
>  	};
> 
> +	vga {
> +		compatible = "vga-connector";
> +
> +		port {
> +			vga_in: endpoint {
> +				remote-endpoint = <&adv7123_out>;
> +			};
> +		};
> +	};
> +
> +	vga-encoder {
> +		compatible = "adi,adv7123";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7123_in: endpoint {
> +					remote-endpoint = <&du_out_rgb>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				adv7123_out: endpoint {
> +					remote-endpoint = <&vga_in>;
> +				};
> +			};
> +		};
> +	};
> +
>  	memory@48000000 {
>  		device_type = "memory";
>  		/* first 128MB is reserved for secure area. */
> @@ -46,6 +78,11 @@
>  		};
>  	};
> 
> +	du_pins: du {
> +		groups = "du_rgb888", "du_sync", "du_disp", "du_dotclkout0";
> +		function = "du";
> +	};
> +
>  	i2c0_pins: i2c0 {
>  		groups = "i2c0";
>  		function = "i2c0";
> @@ -95,6 +132,20 @@
>  	status = "okay";
>  };
> 
> +&du {
> +	pinctrl-0 = <&du_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			endpoint {
> +				remote-endpoint = <&adv7123_in>;
> +			};
> +		};
> +	};
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };


-- 
Regards,

Laurent Pinchart

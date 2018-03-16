Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeCPAAJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:00:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45083 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbeCPAAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:00:06 -0400
X-Google-Smtp-Source: AG47ELs4Z13BuzWYm9myoE9fY8axjkgO8+oUQGdrNnUSCZZbO8oMXh4eZQT40MWaMdqX80Q04cEG3Q==
Date: Fri, 16 Mar 2018 01:00:04 +0100
From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        sergei.shtylyov@cogentembedded.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car
 V3M Eagle
Message-ID: <20180316000004.GC3432@bigcity.dyn.berto.se>
References: <1521130316-1221-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521130316-1221-4-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521130316-1221-4-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thanks for your patch.

This one must depend on '[PATCH v2 0/5] arm64: dts: renesas: r8a77970: 
enable HDMI output' or something similar not yet in renesas-drivers 
repository correct?

In the next version would you care to include the LVDS commit from the 
dependency  series and squash this change into that one or in some other 
good manger stack to two? Laurent told me he did not like 5/5 in that 
patch-set as it did not yet have the LVDS decoder node due to no driver 
existed at that time when I posted that even if it's not strictly needed 
to get the display working :-)

I also think you should split this last patch out to a separate series 
as it should go in Simon's tree while the driver and documentation is 
going in earlier in a different tree right?

On a side note, do you plan to update the Gen2 boards DTS files which 
also have a decoder which are not yet described in DT?

On 2018-03-15 17:11:56 +0100, Jacopo Mondi wrote:
> The R-Car V3M Eagle board includes a transparent THC63LVD1024 LVDS
> decoder, connected to the on-chip LVDS encoder output on one side
> and to HDMI encoder ADV7511w on the other one.
> 
> As the decoder does not need any configuration it has been so-far
> omitted from DTS. Now that a driver is available, describe it in DT
> as well.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 33 +++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> index c0fd144..69f43b8 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -42,6 +42,33 @@
>  			};
>  		};
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
> +				thc63lvd1024_in_0: endpoint {
> +					remote-endpoint = <&lvds0_out>;
> +				};
> +			};
> +
> +			port@2{
> +				reg = <2>;
> +
> +				thc63lvd1024_out_2: endpoint {
> +					remote-endpoint = <&adv7511_in>;
> +				};
> +
> +			};
> +
> +		};
> +	};
>  };
>  
>  &avb {
> @@ -98,7 +125,7 @@
>  			port@0 {
>  				reg = <0>;
>  				adv7511_in: endpoint {
> -					remote-endpoint = <&lvds0_out>;
> +					remote-endpoint = <&thc63lvd1024_out_2>;
>  				};
>  			};
>  
> @@ -152,8 +179,8 @@
>  
>  	ports {
>  		port@1 {
> -			endpoint {
> -				remote-endpoint = <&adv7511_in>;
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&thc63lvd1024_in_0>;
>  			};
>  		};
>  	};
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund

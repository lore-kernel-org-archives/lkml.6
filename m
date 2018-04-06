Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeDFNPk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:15:40 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:34863 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDFNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:15:38 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        vladimir_zapolskiy@mentor.com, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
Date: Fri, 06 Apr 2018 16:15:35 +0300
Message-ID: <1664336.M7KDjLhzuK@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1523018517-24121-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1523018517-24121-1-git-send-email-jacopo+renesas@jmondi.org> <1523018517-24121-2-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36DFjZY012036

Hi Jacopo,

Thank you for the patch.

On Friday, 6 April 2018 15:41:56 EEST Jacopo Mondi wrote:
> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../bindings/display/bridge/thine,thc63lvd1024.txt | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> new file mode 100644
> index 0000000..1191f17
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> @@ -0,0 +1,60 @@
> +Thine Electronics THC63LVD1024 LVDS decoder
> +-------------------------------------------
> +
> +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS
> streams
> +to parallel data outputs. The chip supports single/dual input/output modes,
> +handling up to two two input LVDS stream and up to two digital CMOS/TTL

s/to two two/to two/
s/stream/streams/

> outputs.
> +
> +Single or dual operation modes, output data mapping and DDR output modes
> are
> +configured through input signals and the chip does not expose any control
> bus.
> +
> +Required properties:
> +- compatible: Shall be "thine,thc63lvd1024"
> +
> +Optional properties:
> +- vcc-supply: Power supply for TTL output, TTL CLOCKOUT signal, LVDS input,
> +  PPL and digital circuitry
> +- powerdown-gpios: Power down GPIO signal, pin name "/PDWN". Active low
> +- enable-gpios: Output enable GPIO signal, pin name "OE". Active high

As Rob mentioned in a reply to v6, we currently use "enable" as the inverse of 
"powerdown". I would call this one oe-gpios instead. Quoting Rob:

"Debating "oe" vs. "output-enable" is bikeshedding IMO. Anyone familiar with 
h/w design should recognize OE."

> +
> +The THC63LVD1024 video port connections are modeled according
> +to OF graph bindings specified by Documentation/devicetree/bindings/
> graph.txt
> +
> +Required video port nodes:
> +- port@0: First LVDS input port
> +- port@2: First digital CMOS/TTL parallel output
> +
> +Optional video port nodes:
> +- port@1: Second LVDS input port
> +- port@3: Second digital CMOS/TTL parallel output
> +
> +Example:
> +--------
> +
> +	thc63lvd1024: lvds-decoder {
> +		compatible = "thine,thc63lvd1024";
> +
> +		vcc-supply = <&reg_lvds_vcc>;
> +		powerdown-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				lvds_dec_in_0: endpoint {
> +					remote-endpoint = <&lvds_out>;
> +				};
> +			};
> +
> +			port@2{
> +				reg = <2>;
> +
> +				lvds_dec_out_2: endpoint {
> +					remote-endpoint = <&adv7511_in>;
> +				};
> +			};
> +		};
> +	};

-- 
Regards,

Laurent Pinchart

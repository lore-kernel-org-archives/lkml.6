Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCTSsP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:48:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54093 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTSsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:48:12 -0400
Date: Tue, 20 Mar 2018 19:47:59 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/7] arm64: allwinner: a64: add DE2 CCU related device
 tree nodes
Message-ID: <20180320184759.nb2zwn5liqa2kpm4@flea>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-6-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180316175354.21437-6-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 01:53:52AM +0800, Icenowy Zheng wrote:
> +		sram-controller@1c00000 {
> +			compatible = "allwinner,sun50i-a64-sram-controller";
> +			reg = <0x01c00000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			sram_c: sram@18000 {
> +				compatible = "mmio-sram";
> +				reg = <0x00018000 0x28000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x00018000 0x28000>;
> +
> +				de2_sram: sram-section@0 {
> +					compatible = "allwinner,sun50i-a64-sram-c";
> +					reg = <0x0000 0x28000>;
> +				};
> +			};
> +		};
> +
>  		syscon: syscon@1c00000 {
>  			compatible = "allwinner,sun50i-a64-system-controller",
>  				"syscon";

Isn't that the same device than the sram controller node you just added?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

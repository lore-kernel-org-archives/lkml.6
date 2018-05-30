Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeE3PEI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:04:08 -0400
Received: from muru.com ([72.249.23.125]:45220 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbeE3PEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:04:06 -0400
Date: Wed, 30 May 2018 08:04:02 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, t-kristo@ti.com
Subject: Re: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
Message-ID: <20180530150402.GE5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530141133.3711-6-faiz_abbas@ti.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
> The ti-sysc driver provides support for manipulating the idlemodes
> and interconnect level resets.
...
> --- a/arch/arm/boot/dts/dra76x.dtsi
> +++ b/arch/arm/boot/dts/dra76x.dtsi
> @@ -11,6 +11,25 @@
>  / {
>  	compatible = "ti,dra762", "ti,dra7";
>  
> +	ocp {
> +
> +		target-module@0x42c00000 {
> +			compatible = "ti,sysc-dra7-mcan";
> +			ranges = <0x0 0x42c00000 0x2000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x42c01900 0x4>,
> +			      <0x42c01904 0x4>,
> +			      <0x42c01908 0x4>;
> +			reg-names = "rev", "sysc", "syss";
> +			ti,sysc-mask = <(SYSC_OMAP4_SOFTRESET |
> +					 SYSC_DRA7_MCAN_ENAWAKEUP)>;
> +			ti,syss-mask = <1>;
> +			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
> +			clock-names = "fck";
> +		};
> +	};
> +
>  };

Looks good to me except I think the reset won't do anything currently
with ti-sysc.c unless you specfify also "ti,hwmods" for the module?

Can you please check? It might be worth adding the reset function to
ti-sysc.c for non "ti,hwmods" case and that just might remove the
need for any hwmod code for this module.

Regards,

Tony

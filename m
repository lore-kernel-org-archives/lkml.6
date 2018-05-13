Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeEMSau (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 14:30:50 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57653 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeEMSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 14:30:48 -0400
X-Originating-IP: 2.224.242.101
Date: Sun, 13 May 2018 20:30:35 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Simon Horman <horms@verge.net.au>
Cc: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77995: Add VIN4
Message-ID: <20180513183035.6ufwkdtlyg4gyco3@apu3b>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526032802-14376-3-git-send-email-jacopo+renesas@jmondi.org>
 <20180511112523.GK18974@bigcity.dyn.berto.se>
 <20180511134516.omsv25i2wi4cxypc@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180511134516.omsv25i2wi4cxypc@verge.net.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Fri, May 11, 2018 at 03:45:16PM +0200, Simon Horman wrote:
> On Fri, May 11, 2018 at 01:25:23PM +0200, Niklas Söderlund wrote:
> > Hi Jacopo,
> > 
> > Thanks for your work.
> > 
> > On 2018-05-11 12:00:01 +0200, Jacopo Mondi wrote:
> > > Describe VIN4 interface for R-Car D3 R8A77995 SoC.
> > > 
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > 
> > Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > 
> > > ---
> > >  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> > > index 82aed7e..bdf7017 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> > > @@ -783,6 +783,17 @@
> > >  				};
> > >  			};
> > >  		};
> > > +
> > > +		vin4: video@e6ef4000 {
> > > +			compatible = "renesas,vin-r8a77995";
> > > +			reg = <0 0xe6ef4000 0 0x1000>;
> > > +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&cpg CPG_MOD 807>;
> > > +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> > > +			resets = <&cpg 807>;
> > > +			renesas,id = <4>;
> > > +			status = "disabled";
> > > +		};
> > >  	};
> 
> Thanks, I have moved the new node to preserve sorting of nodes by bus
> address and applied the result. It is as follows:

Great, thanks for doing this, I should have take care of sorting nodes
opprtunely.

Thanks
   j

> 
> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Subject: [PATCH] arm64: dts: renesas: r8a77995: Add VIN4
> 
> Describe VIN4 interface for R-Car D3 R8A77995 SoC.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> [simon: sorted node by bus address]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> index ba98865b0c9b..2506f46293e8 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -610,6 +610,17 @@
>  			status = "disabled";
>  		};
s  
> +		vin4: video@e6ef4000 {
> +			compatible = "renesas,vin-r8a77995";
> +			reg = <0 0xe6ef4000 0 0x1000>;
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 807>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 807>;
> +			renesas,id = <4>;
> +			status = "disabled";
> +		};
> +
>  		ohci0: usb@ee080000 {
>  			compatible = "generic-ohci";
>  			reg = <0 0xee080000 0 0x100>;
> -- 
> 2.11.0
> 

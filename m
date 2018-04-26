Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756604AbeDZUvX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:51:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42241 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753861AbeDZUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:51:21 -0400
Date: Thu, 26 Apr 2018 22:51:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] MIPS: mscc: Add switch to ocelot
Message-ID: <20180426205113.GD23481@lunn.ch>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426195931.5393-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:59:29PM +0200, Alexandre Belloni wrote:
> Ocelot has an integrated switch, add support for it.
> 
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 88 +++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index dd239cab2f9d..4f33dbc67348 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -91,6 +91,72 @@
>  			status = "disabled";
>  		};
>  
> +		switch@1010000 {
> +			compatible = "mscc,vsc7514-switch";
> +			reg = <0x1010000 0x10000>,
> +			      <0x1030000 0x10000>,
> +			      <0x1080000 0x100>,
> +			      <0x10d0000 0x10000>,
> +			      <0x11e0000 0x100>,
> +			      <0x11f0000 0x100>,
> +			      <0x1200000 0x100>,
> +			      <0x1210000 0x100>,
> +			      <0x1220000 0x100>,
> +			      <0x1230000 0x100>,
> +			      <0x1240000 0x100>,
> +			      <0x1250000 0x100>,
> +			      <0x1260000 0x100>,
> +			      <0x1270000 0x100>,
> +			      <0x1280000 0x100>,
> +			      <0x1800000 0x80000>,
> +			      <0x1880000 0x10000>;
> +			reg-names = "sys", "rew", "qs", "hsio", "port0",
> +				    "port1", "port2", "port3", "port4", "port5",
> +				    "port6", "port7", "port8", "port9", "port10",
> +				    "qsys", "ana";
> +			interrupts = <21 22>;
> +			interrupt-names = "xtr", "inj";
> +
> +			ethernet-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port0: port@0 {
> +					reg = <0>;
> +				};
> +				port1: port@1 {
> +					reg = <1>;
> +				};
> +				port2: port@2 {
> +					reg = <2>;
> +				};
> +				port3: port@3 {
> +					reg = <3>;
> +				};
> +				port4: port@4 {
> +					reg = <4>;
> +				};
> +				port5: port@5 {
> +					reg = <5>;
> +				};
> +				port6: port@6 {
> +					reg = <6>;
> +				};
> +				port7: port@7 {
> +					reg = <7>;
> +				};
> +				port8: port@8 {
> +					reg = <8>;
> +				};
> +				port9: port@9 {
> +					reg = <9>;
> +				};
> +				port10: port@10 {
> +					reg = <10>;
> +				};
> +			};
> +		};
> +
>  		reset@1070008 {
>  			compatible = "mscc,ocelot-chip-reset";
>  			reg = <0x1070008 0x4>;
> @@ -113,5 +179,27 @@
>  				function = "uart2";
>  			};
>  		};
> +
> +		mdio0: mdio@107009c {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "mscc,ocelot-miim";
> +			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
> +			interrupts = <14>;
> +			status = "disabled";
> +
> +			phy0: ethernet-phy@0 {
> +				reg = <0>;
> +			};
> +			phy1: ethernet-phy@1 {
> +				reg = <1>;
> +			};
> +			phy2: ethernet-phy@2 {
> +				reg = <2>;
> +			};
> +			phy3: ethernet-phy@3 {
> +				reg = <3>;
> +			};

Hi Alexandre

These are internal PHYs? Is there an option to use external PHYs for
the ports which have internal PHYs?

I'm just wondering if they should be linked together by default. Or a
comment added to the commit message about why they are not linked
together here.

	 Andrew

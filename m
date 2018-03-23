Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeCWVSG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:18:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36988 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeCWVSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:18:01 -0400
X-Google-Smtp-Source: AG47ELuXDyK9EZ2v7LOS4XHG/0G6qkGg1iumtF58zUZke8dEAUKFvhH4s+tpB1RDe/daDwRzODjHUA==
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
Date: Fri, 23 Mar 2018 14:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-7-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> Ocelot has an integrated switch, add support for it.
> 
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 84 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index dd239cab2f9d..22a86373b1c9 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -91,6 +91,69 @@
>  			status = "disabled";
>  		};
>  
> +		switch@1010000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "mscc,ocelot-switch";
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

See my comment about the binding patch, this should be moved to a ports
subnode so it is conforming to the existing DSA binding and makes it a
lot easier to have all ports disabled by default at the .dsti level by
not defini

> +
> +			port0: port@0 {
> +				reg = <0>;
> +			};
> +			port1: port@1 {
> +				reg = <1>;
> +			};
> +			port2: port@2 {
> +				reg = <2>;
> +			};
> +			port3: port@3 {
> +				reg = <3>;
> +			};
> +			port4: port@4 {
> +				reg = <4>;
> +			};
> +			port5: port@5 {
> +				reg = <5>;
> +			};
> +			port6: port@6 {
> +				reg = <6>;
> +			};
> +			port7: port@7 {
> +				reg = <7>;
> +			};
> +			port8: port@8 {
> +				reg = <8>;
> +			};
> +			port9: port@9 {
> +				reg = <9>;
> +			};
> +			port10: port@10 {
> +				reg = <10>;
> +			};
> +		};
> +
>  		reset@1070008 {
>  			compatible = "mscc,ocelot-chip-reset";
>  			reg = <0x1070008 0x4>;
> @@ -113,5 +176,26 @@
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

status = "disabled" by default?

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

These PHYs should be defined at the board DTS level.
-- 
Florian

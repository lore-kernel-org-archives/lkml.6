Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeCZWZb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:25:31 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33453 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbeCZWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:25:28 -0400
X-Google-Smtp-Source: AG47ELuLD28T3jm52A5tTl3bwmBVhEYglybY5TIFoQbDZQxA//eknnuOxteDDXTx9DTrrtjN3FkWww==
Date: Mon, 26 Mar 2018 17:25:26 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
Message-ID: <20180326222526.gwflhl4m5bawdh7f@rob-hp-laptop>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-5-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 09:11:13PM +0100, Alexandre Belloni wrote:
> DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> new file mode 100644
> index 000000000000..ee092a85b5a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -0,0 +1,62 @@
> +Microsemi Ocelot network Switch
> +===============================
> +
> +The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
> +VSC7514)

What's the difference in these SoCs? You should probably have the 
part#'s in the compatible string.

> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-switch"
> +- reg: Must contain an (offset, length) pair of the register set for each
> +  entry in reg-names.
> +- reg-names: Must include the following entries:
> +  - "sys"
> +  - "rew"
> +  - "qs"
> +  - "hsio"
> +  - "qsys"
> +  - "ana"
> +  - "portX" with X from 0 to the number of last port index available on that
> +    switch
> +- interrupts: Should contain the switch interrupts for frame extraction and
> +  frame injection
> +- interrupt-names: should contain the interrupt names: "xtr", "inj"
> +
> +Example:
> +
> +	switch@1010000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "mscc,ocelot-switch";
> +		reg = <0x1010000 0x10000>,
> +		      <0x1030000 0x10000>,
> +		      <0x1080000 0x100>,
> +		      <0x10d0000 0x10000>,
> +		      <0x11e0000 0x100>,
> +		      <0x11f0000 0x100>,
> +		      <0x1200000 0x100>,
> +		      <0x1210000 0x100>,
> +		      <0x1220000 0x100>,
> +		      <0x1230000 0x100>,
> +		      <0x1240000 0x100>,
> +		      <0x1250000 0x100>,
> +		      <0x1260000 0x100>,
> +		      <0x1270000 0x100>,
> +		      <0x1280000 0x100>,
> +		      <0x1800000 0x80000>,
> +		      <0x1880000 0x10000>;
> +		reg-names = "sys", "rew", "qs", "hsio", "port0",
> +			    "port1", "port2", "port3", "port4", "port5",
> +			    "port6", "port7", "port8", "port9", "port10",
> +			    "qsys", "ana";
> +		interrupts = <21 22>;
> +		interrupt-names = "xtr", "inj";
> +
> +		port0: port@0 {
> +			reg = <0>;
> +			phy-handle = <&phy0>;
> +		};
> +		port1: port@1 {
> +			reg = <1>;
> +			phy-handle = <&phy1>;
> +		};
> +	};
> -- 
> 2.16.2
> 

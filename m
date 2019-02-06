Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E39AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6485720844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfBFOAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:00:25 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54505 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:00:25 -0500
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr [109.213.164.40])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 53F05C0008;
        Wed,  6 Feb 2019 14:00:21 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 7/7] ARM64: dts: marvell: armada-37xx: declare the COMPHY node
In-Reply-To: <20190108163124.6409-8-miquel.raynal@bootlin.com>
References: <20190108163124.6409-1-miquel.raynal@bootlin.com> <20190108163124.6409-8-miquel.raynal@bootlin.com>
Date:   Wed, 06 Feb 2019 15:00:20 +0100
Message-ID: <87ef8l6mq3.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Describe the A3700 COMPHY node. It has three PHYs that can be
> configured as follow:
> * PCIe or GbE
> * USB3 or GbE
> * SATA or USB3
> Each of them has its own memory area.
>
> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index e7405931f381..036d6fd6c9ef 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -242,6 +242,35 @@
>  				reg = <0x14000 0x60>;
>  			};
>  
> +			comphy: phy@18300 {
> +				compatible = "marvell,comphy-a3700";
> +				reg = <0x18300 0x300>,
> +				      <0x1F000 0x400>,
> +				      <0x5C000 0x400>,
> +				      <0xe0178 0x8>;
> +				reg-names = "comphy",
> +					    "lane1_pcie_gbe",
> +					    "lane0_usb3_gbe",
> +					    "lane2_sata_usb3";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				comphy0: phy@0 {
> +					reg = <0>;
> +					#phy-cells = <1>;
> +				};
> +
> +				comphy1: phy@1 {
> +					reg = <1>;
> +					#phy-cells = <1>;
> +				};
> +
> +				comphy2: phy@2 {
> +					reg = <2>;
> +					#phy-cells = <1>;
> +				};
> +			};
> +
>  			pinctrl_sb: pinctrl@18800 {
>  				compatible = "marvell,armada3710-sb-pinctrl",
>  					     "syscon", "simple-mfd";
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

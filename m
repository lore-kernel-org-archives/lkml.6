Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDD2FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9444E20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9444E20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeINUJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:09:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46456 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbeINUJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:09:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A28E920701; Fri, 14 Sep 2018 16:54:46 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7B23E206FF;
        Fri, 14 Sep 2018 16:54:46 +0200 (CEST)
Date:   Fri, 14 Sep 2018 16:54:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 5/7] MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
Message-ID: <20180914145446.GQ14988@piout.net>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/09/2018 11:44:26+0200, Quentin Schulz wrote:
> In order to use GPIO4 as a GPIO, we need to mux it in this mode so let's
> declare a new pinctrl DT node for it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index 8ce317c..b5c4c74 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -182,6 +182,11 @@
>  			interrupts = <13>;
>  			#interrupt-cells = <2>;
>  
> +			gpio4: gpio4 {
> +				pins = "GPIO_4";
> +				function = "gpio";
> +			};
> +

For a GPIO, I would do that in the board dts because it is not used
directly in the dtsi.

>  			uart_pins: uart-pins {
>  				pins = "GPIO_6", "GPIO_7";
>  				function = "uart";
> -- 
> git-series 0.9.1

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5497720862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5497720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeGaJbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:31:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56086 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeGaJbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:31:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6545620737; Tue, 31 Jul 2018 09:52:08 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 38774203EC;
        Tue, 31 Jul 2018 09:51:58 +0200 (CEST)
Date:   Tue, 31 Jul 2018 09:51:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        kishon@ti.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 01/10] MIPS: mscc: ocelot: make HSIO registers
 address range a syscon
Message-ID: <20180731075159.GN28585@piout.net>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <c250b2591a70bd8b31eef56d82cf5f5ccb47cc22.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c250b2591a70bd8b31eef56d82cf5f5ccb47cc22.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 14:43:46+0200, Quentin Schulz wrote:
> HSIO contains registers for PLL5 configuration, SerDes/switch port
> muxing and a thermal sensor, hence we can't keep it in the switch DT
> node.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index afe8fc9..c51663a 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -96,7 +96,6 @@
>  			reg = <0x1010000 0x10000>,
>  			      <0x1030000 0x10000>,
>  			      <0x1080000 0x100>,
> -			      <0x10d0000 0x10000>,
>  			      <0x11e0000 0x100>,
>  			      <0x11f0000 0x100>,
>  			      <0x1200000 0x100>,
> @@ -110,10 +109,10 @@
>  			      <0x1280000 0x100>,
>  			      <0x1800000 0x80000>,
>  			      <0x1880000 0x10000>;
> -			reg-names = "sys", "rew", "qs", "hsio", "port0",
> -				    "port1", "port2", "port3", "port4", "port5",
> -				    "port6", "port7", "port8", "port9", "port10",
> -				    "qsys", "ana";
> +			reg-names = "sys", "rew", "qs", "port0", "port1",
> +				    "port2", "port3", "port4", "port5", "port6",
> +				    "port7", "port8", "port9", "port10", "qsys",
> +				    "ana";
>  			interrupts = <21 22>;
>  			interrupt-names = "xtr", "inj";
>  
> @@ -220,5 +219,10 @@
>  			pinctrl-0 = <&miim1>;
>  			status = "disabled";
>  		};
> +
> +		hsio: syscon@10d0000 {
> +			compatible = "mscc,ocelot-hsio", "syscon", "simple-mfd";
> +			reg = <0x10d0000 0x10000>;
> +		};
>  	};
>  };
> -- 
> git-series 0.9.1

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36543C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083CD214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfAJLE7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:04:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42125 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfAJLE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:04:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CDE97209D7; Thu, 10 Jan 2019 12:04:56 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr [109.213.84.72])
        by mail.bootlin.com (Postfix) with ESMTPSA id 94941206DC;
        Thu, 10 Jan 2019 12:04:46 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI area
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
Date:   Thu, 10 Jan 2019 12:04:46 +0100
In-Reply-To: <20181221164503.5128-1-xypron.glpk@gmx.de> (Heinrich Schuchardt's
        message of "Fri, 21 Dec 2018 17:45:03 +0100")
Message-ID: <874lagpycx.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heinrich,
 
 On ven., déc. 21 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
> attempt to access it from Linux leads to an immediate crash.
>
> So let's make the same memory reservation as the vendor kernel.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


Applied on mvebu/fixes

I added a comment about the use with a mainline /U-Boot

Thanks,

Gregory


> ---
> v2
> 	Move the change from armada-8040-mcbin.dts to armada-ap806.dtsi.
> 	I only have a MACCHIATObin for testing but
> 	https://github.com/MarvellEmbeddedProcessors/linux-marvell
> 	has the reservation in that file.
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 7d94c1fa592a..f8dafef83db0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -28,6 +28,17 @@
>  		method = "smc";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		psci-area@4000000 {
> +			reg = <0x0 0x4000000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
>  	ap806 {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> -- 
> 2.19.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

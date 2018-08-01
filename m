Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66398C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17546208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17546208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbeHAO6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:58:14 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56238 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389196AbeHAO6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:58:14 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 46B7FA15CE;
        Wed,  1 Aug 2018 13:12:20 +0000 (UTC)
Message-ID: <1c12672d56b1e97aa594d2938ea9a36b5c0a98e0.camel@aosc.io>
Subject: Re: [PATCH v3 02/14] ARM: dts: sunxi: h3/h5: Fix i2c2 register
 address
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Date:   Wed, 01 Aug 2018 21:11:05 +0800
In-Reply-To: <20170926072234.27481-3-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
         <20170926072234.27481-3-clabbe.montjoie@gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2017-09-26二的 09:22 +0200，Corentin Labbe写道：
> The unit address and register address does not match.
> This patch fix the register address with the good one.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

This patch should be backported.

Older LTS also needs patches, but the patch needs to be refactored to
suite the versions.

Cc: stable@vger.kernel.org # 4.14

> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index b37ed3461229..289f2cd06dfe 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -632,7 +632,7 @@
>  
>  		i2c2: i2c@1c2b400 {
>  			compatible = "allwinner,sun6i-a31-i2c";
> -			reg = <0x01c2b000 0x400>;
> +			reg = <0x01c2b400 0x400>;
>  			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_I2C2>;
>  			resets = <&ccu RST_BUS_I2C2>;


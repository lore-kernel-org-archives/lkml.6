Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F2C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D0D2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D0D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935677AbeFRR6B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:58:01 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:43969 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935388AbeFRR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:58:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DE5D716E31;
        Mon, 18 Jun 2018 17:57:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dogs89_62a0dc3353e42
X-Filterd-Recvd-Size: 2527
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jun 2018 17:57:57 +0000 (UTC)
Message-ID: <6755acb72649a712bd16cee4cab92f1aa63b70b9.camel@perches.com>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: Remove leading 0x from unit
 addresses in Exynos5433
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 10:57:56 -0700
In-Reply-To: <20180618174216.24801-1-krzk@kernel.org>
References: <20180618174216.24801-1-krzk@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 19:42 +0200, Krzysztof Kozlowski wrote:
> Remove leading 0x from recently introduced unit addresses to fix DTC
> warnings:
> 
>     Warning (unit_address_format): /soc/sysmmu@0x15040000: unit name should not have leading "0x"
[]
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
[]
> @@ -1171,7 +1171,7 @@
>  			power-domains = <&pd_gscl>;
>  		};
>  
> -		sysmmu_scaler_0: sysmmu@0x15040000 {
> +		sysmmu_scaler_0: sysmmu@15040000 {
>  			compatible = "samsung,exynos-sysmmu";
>  			reg = <0x15040000 0x1000>;
>  			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1182,7 +1182,7 @@
>  			power-domains = <&pd_mscl>;
>  		};
>  
> -		sysmmu_scaler_1: sysmmu@0x15050000 {
> +		sysmmu_scaler_1: sysmmu@15050000 {
>  			compatible = "samsung,exynos-sysmmu";
>  			reg = <0x15050000 0x1000>;
>  			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;

Presumably these 3 other entries too?

$ git grep -P "\b\w+:\s+\w+@0x" -- "*.dt*"
arch/arc/boot/dts/abilis_tb10x.dtsi:            spi0: spi@0xFE010000 {
arch/arc/boot/dts/abilis_tb10x.dtsi:            spi1: spi@0xFE011000 {
arch/arc/boot/dts/vdk_axs10x_mb.dtsi:   uio_ev: uio@0xD0000000 {
arch/arm64/boot/dts/exynos/exynos5433.dtsi:             sysmmu_scaler_0: sysmmu@0x15040000 {
arch/arm64/boot/dts/exynos/exynos5433.dtsi:             sysmmu_scaler_1: sysmmu@0x15050000 {

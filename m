Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE954C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA8020828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA8020828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeK0LZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:25:00 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33334 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbeK0LZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:25:00 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gRRFM-0003Pl-Ib; Tue, 27 Nov 2018 01:29:00 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: rockchip: Add internal timer support for rv1108
Date:   Tue, 27 Nov 2018 01:28:59 +0100
Message-ID: <2433008.lBIgasatsU@phil>
In-Reply-To: <20181126173506.24068-4-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br> <20181126173506.24068-4-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. November 2018, 18:35:06 CET schrieb Otavio Salvador:
> Add support for the internal timer peripheral on RV1108.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---

looks good, but due to the newly added compatible
I'll let this sit a bit longer to give Rob a chance to add a
Review-tag or so.


Heiko


> 
> Changes in v2:
> - add binding to doc
> - fixup commit log
> 
>  .../devicetree/bindings/timer/rockchip,rk-timer.txt       | 1 +
>  arch/arm/boot/dts/rv1108.dtsi                             | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> index 16a5f4577a61..d65fdce7c7f0 100644
> --- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> @@ -2,6 +2,7 @@ Rockchip rk timer
>  
>  Required properties:
>  - compatible: should be:
> +  "rockchip,rv1108-timer", "rockchip,rk3288-timer": for Rockchip RV1108
>    "rockchip,rk3036-timer", "rockchip,rk3288-timer": for Rockchip RK3036
>    "rockchip,rk3066-timer", "rockchip,rk3288-timer": for Rockchip RK3066
>    "rockchip,rk3188-timer", "rockchip,rk3288-timer": for Rockchip RK3188
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index 23ac4b10d690..9683f3b00d9d 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -293,6 +293,14 @@
>  		};
>  	};
>  
> +	timer: timer@10350000 {
> +		compatible = "rockchip,rv1108-timer", "rockchip,rk3288-timer";
> +		reg = <0x10350000 0x20>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&xin24m>, <&cru PCLK_TIMER>;
> +		clock-names = "timer", "pclk";
> +	};
> +
>  	watchdog: wdt@10360000 {
>  		compatible = "snps,dw-wdt";
>  		reg = <0x10360000 0x100>;
> 





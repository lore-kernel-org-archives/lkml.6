Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D3520878
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D3520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeKZQTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:19:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53426 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbeKZQTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:19:36 -0500
Received: from p5b12749d.dip0.t-ipconnect.de ([91.18.116.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gR9Pp-0007Dk-4w; Mon, 26 Nov 2018 06:26:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 07/13] ARM: dts: rv1108: Fix the timer mask
Date:   Mon, 26 Nov 2018 06:26:36 +0100
Message-ID: <4443441.F7S2jYBxxL@phil>
In-Reply-To: <20181125211907.9895-7-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br> <20181125211907.9895-7-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 25. November 2018, 22:19:01 CET schrieb Otavio Salvador:
> As done in the Rockchip vendor tree and also on other
> "arm,armv7-timer" instances, the correct GIC_CPU_MASK_SIMPLE mask
> is 4 instead of 1.

Nope. That value represents the number of cores in the system.
As the rv1108 only has one core, that should likely stay as it is.

Also, it seems I only got patches 6-13 what happened to 1-5?

Heiko

> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
> ---
> 
>  arch/arm/boot/dts/rv1108.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
> index c7a26f82655b..7b331766120d 100644
> --- a/arch/arm/boot/dts/rv1108.dtsi
> +++ b/arch/arm/boot/dts/rv1108.dtsi
> @@ -71,8 +71,8 @@
>  
>  	timer {
>  		compatible = "arm,armv7-timer";
> -		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>,
> -			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		clock-frequency = <24000000>;
>  	};
>  
> 





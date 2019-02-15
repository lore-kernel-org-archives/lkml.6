Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472C82054F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394332AbfBOXIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:08:55 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37452 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389943AbfBOXIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:08:55 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gumbE-0003WA-4F; Sat, 16 Feb 2019 00:08:52 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dianders@chromium.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: add chosen node on veyron chromebooks
Date:   Sat, 16 Feb 2019 00:08:50 +0100
Message-ID: <22158501.cNvkU8jGDh@diego>
In-Reply-To: <20190215115150.32299-1-enric.balletbo@collabora.com>
References: <20190215115150.32299-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Am Freitag, 15. Februar 2019, 12:51:50 CET schrieb Enric Balletbo i Serra:
> In order to use earlycon, the stdout-path property needs to be set
> in the chosen node.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

What's the reason for adding this only for the Chromebook variants?
Uart2 is pretty much the standard output for all devices, so I'd assume
at least all veyron boards should use uart2 as well, making this ideally
live in the rk3288-veyron.dtsi instead?

Heiko

> ---
> 
>  arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi index
> b54746df3661..8890967ed572 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
> @@ -62,6 +62,10 @@
>  		pwm-off-delay-ms = <10>;
>  	};
> 
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
>  	gpio-charger {
>  		compatible = "gpio-charger";
>  		charger-type = "mains";





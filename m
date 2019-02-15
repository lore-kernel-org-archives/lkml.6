Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E1C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCDD2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404363AbfBOJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:22:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60142 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390871AbfBOJWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:22:21 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1guZgx-0000DU-91; Fri, 15 Feb 2019 10:21:55 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Levin Du <djw@t-chip.com.cn>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: rockpro64 dts rename LED labels and default trigger
Date:   Fri, 15 Feb 2019 10:21:54 +0100
Message-ID: <2294853.gTMg7XEmWK@diego>
In-Reply-To: <20190213170651.3210-4-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com> <20190213170651.3210-4-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. Februar 2019, 18:06:39 CET schrieb Akash Gajjar:
> rename white and red LEDs with status and heartbeat respectively.
> replace red LED default state off with default-trigger heartbeat.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

Hmm, in the schematics the leds are named work + diy as in the current
devicetree, so I'd like to keep node names + pinctrl matching schematics
please.

And changing the functionality of the LEDs would require a bit more
rationale in the commit message on why that is something we want.


Heiko

> ---
>  .../arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts index
> c9a2b26d7cad..dab53d2eb676 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -43,17 +43,17 @@
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&work_led_gpio>, <&diy_led_gpio>;
> +		pinctrl-0 = <&status_led_gpio>, <&heartbeat_led_gpio>;
> 
> -		work-led {
> -			label = "work";
> +		status-led {
> +			label = "rockpro64:white:status";
>  			default-state = "on";
>  			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
>  		};
> 
> -		diy-led {
> -			label = "diy";
> -			default-state = "off";
> +		heartbeat-led {
> +			label = "rockpor64:red:heartbeat";
> +			linux,default-trigger = "heartbeat";
>  			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> @@ -502,11 +502,11 @@
>  	};
> 
>  	leds {
> -		work_led_gpio: work_led-gpio {
> +		status_led_gpio: status-led-gpio {
>  			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
> 
> -		diy_led_gpio: diy_led-gpio {
> +		heartbeat_led_gpio: heartbeat-led-gpio {
>  			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};





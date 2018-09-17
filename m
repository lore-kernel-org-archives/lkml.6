Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8056ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B282147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B282147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeIQLKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:10:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35619 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeIQLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:10:05 -0400
Received: by mail-it0-f66.google.com with SMTP id 139-v6so9444583itf.0;
        Sun, 16 Sep 2018 22:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDaeUSFxCvRZ0uxjhg5PnQT7HCyTFPXSiTFiXUcL2GI=;
        b=NveYWDQyc0NAyEXmzBwFlegihv6Q3aMSgFMUNGYSLulimMKdI4Z+GjU6h7Op1A7B1W
         NLlvTwViaEJgPWQpe6n+NDtBNqmq0WZ6lm6mvbaoBzP1K6Z9TE0n+tahHCNdOe13erCj
         HnFFilePEqLYqflK/ARzQ40V5b0RgXnk4NznPlr5i66q7YBk5PWNo5v0WeEOOZKtcoPD
         ssKby19RrFEy13NNaTdsrTUUPiwM6noCKZzvwSncQ6+/ELkhl1rolT/xdw1BCL4GFwM+
         WdEM7XZCq0VsELkBV2YHRrPiFUd6tnyfTeKo4RfijTeVwKdEaf4gQ5BjLrMXlJCZixhQ
         ky7A==
X-Gm-Message-State: APzg51CT7T0baPhfu6cTdasPzP7YK3dXv4UmSXybgJDBKywsBM3nMOC/
        O6sMuRF+Iq3ojMUjmc1jbfps4dBsrw==
X-Google-Smtp-Source: ANB0Vdbbvh13pZuzcSNYclqlCTnyPaRuA3aB7NyGvanIAELlodTaBmy+i36YpEojFuIDKI1sxhjERw==
X-Received: by 2002:a24:2911:: with SMTP id p17-v6mr11311699itp.134.1537163056602;
        Sun, 16 Sep 2018 22:44:16 -0700 (PDT)
Received: from localhost ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id o22-v6sm4746430iob.4.2018.09.16.22.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 22:44:15 -0700 (PDT)
Date:   Mon, 17 Sep 2018 01:44:14 -0400
From:   Rob Herring <robh@kernel.org>
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     heiko@sntech.de, deepak_das@mentor.com,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Levin Du <djw@t-chip.com.cn>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add initial dts support for
 Rockpro64 board
Message-ID: <20180917054414.GA13346@bogus>
References: <Akash_Gajjar@mentor.com>
 <1536926957-12432-1-git-send-email-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536926957-12432-1-git-send-email-Akash_Gajjar@mentor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 05:39:09PM +0530, Akash Gajjar wrote:
> Rockpro64 board is a rockchip RK3399 based board from pine64.org.
> This commit adds initial device tree support for Rockpro64 board.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  | 770 +++++++++++++++++++++
>  3 files changed, 775 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index acfd3c7..ac95183 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -160,6 +160,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>      - compatible = "pine64,rock64", "rockchip,rk3328";
>  
> +- Pine64 RockPro64 board:
> +    Required root node properties:
> +    - compatible = "pine64,rockpro64", "rockchip,rk3399";
> +
>  - Rockchip PX3 Evaluation board:
>      Required root node properties:
>        - compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index b0092d9..03d523a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> new file mode 100644
> index 0000000..9e2d4d9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> @@ -0,0 +1,770 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Pine64 RockPro64";
> +	compatible = "pine64,rockpro64", "rockchip,rk3399";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm0 0 25000 0>;
> +		brightness-levels = <
> +			  0   1   2   3   4   5   6   7
> +			  8   9  10  11  12  13  14  15
> +			 16  17  18  19  20  21  22  23

There's a binding now so you don't have to list every single entry.

Rob

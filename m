Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE39EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808542146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808542146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeLAFI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:08:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34558 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeLAFI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:08:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 897A920DA7; Fri, 30 Nov 2018 18:58:51 +0100 (CET)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id DFDC720745;
        Fri, 30 Nov 2018 18:58:37 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ding Tao <miyatsu@qq.com>
Cc:     jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: marvell: armada-37xx: Enable emmc on espressobin
References: <20181026115028.193203-1-miyatsu@qq.com>
        <20181026115028.193203-2-miyatsu@qq.com>
Date:   Fri, 30 Nov 2018 18:58:38 +0100
In-Reply-To: <20181026115028.193203-2-miyatsu@qq.com> (Ding Tao's message of
        "Fri, 26 Oct 2018 11:50:28 +0000")
Message-ID: <874lbymoq9.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ding,
 
 On ven., oct. 26 2018, Ding Tao <miyatsu@qq.com> wrote:

> The ESPRESSObin board has a emmc interface available on U11, let's
> enable it.


Applied on mvebu/dt64 for now, but what happen if U11 is not populated?

Thanks,

Gregory

>
> Signed-off-by: Ding Tao <miyatsu@qq.com>
> ---
>  .../dts/marvell/armada-3720-espressobin.dts    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 3ab25ad402b9..ee05aabbba88 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -60,6 +60,24 @@
>  	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
>  	marvell,pad-type = "sd";
>  	vqmmc-supply = <&vcc_sd_reg1>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio_pins>;
> +	status = "okay";
> +};
> +
> +/* U11 */
> +&sdhci0 {
> +	non-removable;
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,xenon-emmc;
> +	marvell,xenon-tun-count = <9>;
> +	marvell,pad-type = "fixed-1-8v";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc_pins>;
>  	status = "okay";
>  };
>  
> -- 
> 2.17.1
>
>
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

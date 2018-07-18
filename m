Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E52ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE30D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE30D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbeGROvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:51:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55190 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbeGROvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:51:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DC74D20884; Wed, 18 Jul 2018 16:13:39 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id AC3B920720;
        Wed, 18 Jul 2018 16:13:29 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        heiko@sntech.de, Arnd Bergmann <arnd@arndb.de>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH 1/5] arm64: defconfig: Enable sound support for Samsung Chromebook Plus.
References: <20180717160610.26501-1-enric.balletbo@collabora.com>
Date:   Wed, 18 Jul 2018 16:13:29 +0200
In-Reply-To: <20180717160610.26501-1-enric.balletbo@collabora.com> (Enric
        Balletbo i. Serra's message of "Tue, 17 Jul 2018 18:06:06 +0200")
Message-ID: <87efg0aaye.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric Balletbo,
 
 On mar., juil. 17 2018, Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Enable the Rockchip sound driver with MAX98357A/RT5514/DA7219 codecs
> needed for the Samsung Chromebook Plus.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Could you remove me from your destination list for your next version?

I guess you got my name by the get_maintainer script, but for the
defconfig the result is very inaccurate. Indeed, the fact that I update
the defconfig for the SoC I care doesn't mean that I have an expertise
on the other SoC :)

Thanks,

Gregory

> ---
>
>  arch/arm64/configs/defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f9a186f6af8a..4917641060b1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -447,9 +447,20 @@ CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
>  CONFIG_SND_BCM2835_SOC_I2S=m
> +CONFIG_SND_SOC_ROCKCHIP=m
> +CONFIG_SND_SOC_ROCKCHIP_I2S=m
> +CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
> +CONFIG_SND_SOC_ROCKCHIP_RT5645=m
> +CONFIG_SND_SOC_RK3399_GRU_SOUND=m
>  CONFIG_SND_SOC_SAMSUNG=y
>  CONFIG_SND_SOC_RCAR=m
>  CONFIG_SND_SOC_AK4613=m
> +CONFIG_SND_SOC_DA7219=m
> +CONFIG_SND_SOC_MAX98357A=m
> +CONFIG_SND_SOC_RL6231=m
> +CONFIG_SND_SOC_RT5514=m
> +CONFIG_SND_SOC_RT5514_SPI=m
> +CONFIG_SND_SOC_RT5645=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_I2C_HID=m
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

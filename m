Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6178AC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF4C21901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbfBMJi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:38:27 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:27369 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbfBMJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:38:27 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 07E3313F8CF;
        Wed, 13 Feb 2019 10:38:06 +0100 (CET)
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Extend reserved memory area
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <89492342-018b-3e5d-563c-026ad83458c4@free.fr>
Message-ID: <7f67b755-436c-4172-f428-689149f8c2cf@free.fr>
Date:   Wed, 13 Feb 2019 10:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <89492342-018b-3e5d-563c-026ad83458c4@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 16:16, Marc Gonzalez wrote:

> My console locks up as soon as Linux writes to [88800000,88f00000[
> AFAIU, that memory area is reserved for trustzone.
> 
> Extend the reserved memory range, to prevent Linux from stepping on
> trustzone's feet.

s/feet/toes/

Bjorn/Andy, could you fold this vital fixup into the final patch? ^_^

> [    0.000000] early_memtest: # of tests: 17
> [    0.000000]   0x0000000080000000 - 0x0000000080080000 pattern 4c494e5558726c7a
> [    0.000000]   0x0000000080c7a000 - 0x0000000083200000 pattern 4c494e5558726c7a
> [    0.000000]   0x0000000083205b94 - 0x0000000085800000 pattern 4c494e5558726c7a
> [    0.000000]   0x0000000088f00000 - 0x00000000a1e00000 pattern 4c494e5558726c7a
> [    0.000000]   0x00000000a2000000 - 0x000000017dbc06c8 pattern 4c494e5558726c7a
> [    0.000000]   0x000000017dbc06f7 - 0x000000017dbc06f8 pattern 4c494e5558726c7a
> 
> Cc: stable@vger.kernel.org # 4.20+
> Fixes: c7833949564ec ("arm64: dts: qcom: msm8998: Add smem related nodes")
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index d69401152089..f5ec83a91fe4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -38,7 +38,7 @@
>  		};
>  
>  		memory@86200000 {
> -			reg = <0x0 0x86200000 0x0 0x2600000>;
> +			reg = <0x0 0x86200000 0x0 0x2d00000>;
>  			no-map;
>  		};
>  

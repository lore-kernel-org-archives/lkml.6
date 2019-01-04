Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD6421871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uOoNV4i7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfADAav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:30:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:28012 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfADAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:30:51 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x040UiKC008533
        for <linux-kernel@vger.kernel.org>; Fri, 4 Jan 2019 09:30:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x040UiKC008533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546561845;
        bh=1zaWMUMb40x8df+JaEPhvwLarN4qRUrWREdEEnG11Hw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uOoNV4i7ghirGfAy3ajX0nUYQJE7deib9eLTxC1sUoSVr5Z6q1rVoXMcBwEoEZM5e
         YU3c2c88KFTBgEDLkvcv7VB/yumQ4qEu21JTL7bmOLgZ5XpZnEwEBS0fmz4lDuAya9
         eB4fEW6Uoo+nvK8j9o4BSlqFoYzo6N6NL8rCz2KoS/rml7OM5lhI3JXw6rdqyOABig
         xqHnrC+/Di35YE9ZPh6MXmN07vktrGh3AuEoDvZMDDcfLcMI8CKCdTsN0GLzUFCCJ7
         fieRfmDjTIz5NqPj3A52WqHSdA5QKBu4YvLq93GiPvv8qzLUzn9IpGI7NbC65Bg/oX
         KcXucQJ/M9PmA==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id 185so7622673vkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 16:30:45 -0800 (PST)
X-Gm-Message-State: AJcUukcFrgiZtdYOSa/1qvgFVCYkvk98Mljf+j23iwmL0gpb+rU5q6Ju
        e1ywsPPXJZnvLxtecM0hWKHHZGKItsVjQK/kiwc=
X-Google-Smtp-Source: ALg8bN6PBLMbaOTNsF1Aw27xEhO9gndsPU68SPxlsuEeWiGjdT1j9ttu7APG+O2DXquaDxhyvlFovzu8m12taMbfHvY=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr17051427vkd.64.1546561844221;
 Thu, 03 Jan 2019 16:30:44 -0800 (PST)
MIME-Version: 1.0
References: <1545382284-7290-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1545382284-7290-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 4 Jan 2019 09:30:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMF12thV69tm0Ldt--N-BHxJ4FNH4FGn-Xr-KPL7P5Qw@mail.gmail.com>
Message-ID: <CAK7LNATMF12thV69tm0Ldt--N-BHxJ4FNH4FGn-Xr-KPL7P5Qw@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM: multi_v7_defconfig: enable CONFIG_UNIPHIER_MDMAC
To:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Arnd,

On Sat, Dec 22, 2018 at 12:27 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Enable the UniPhier MIO DMAC driver. This is used as the DMA engine
> for accelerating the SD/eMMC controller drivers.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> When I sent this last time, Olof asked me to resend it later
> to avoid accidental drop.
>
> I think the patches for v5.0 have been almost queued up.
> So, I am resending it on top of that.
>
> The insert context was decided by savedefconfig
> based on next-20181221.


Please let me confirm if this patch is on the right track...

https://lore.kernel.org/patchwork/patch/1027080/

Thanks.


>
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 63af623..715da88 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -862,6 +862,7 @@ CONFIG_STM32_DMA=y
>  CONFIG_STM32_DMAMUX=y
>  CONFIG_STM32_MDMA=y
>  CONFIG_TEGRA20_APB_DMA=y
> +CONFIG_UNIPHIER_MDMAC=y
>  CONFIG_XILINX_DMA=y
>  CONFIG_QCOM_BAM_DMA=y
>  CONFIG_DW_DMAC=y
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA8DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 03:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F6724B1C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 03:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wO+WLn/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F6724B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934751AbeFWDsE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 23:48:04 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:19568 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934608AbeFWDsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 23:48:03 -0400
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com [209.85.217.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5N3lj8Q018626;
        Sat, 23 Jun 2018 12:47:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5N3lj8Q018626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529725666;
        bh=Y2LNp5X8+T2o23XgJVG0BUENqSETQpqYVKeBu+atiKg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wO+WLn/RI7LLAXxkm3Yql/z2E/ETT3Az5IVLok0r9+fNTgBv3D/jRFTmGanx8EC5j
         fyuqdOM/q3VQ0VgvZ+5uLwL45zvGuIAlDofEnULGDwcuMz/QZWZOm3cTy5HiOwdkhJ
         4x0h8j8Sx8taDZy8almNSUaDlMwZx+D5cf8XJqW7cEnzRxTjwwxOTIHIZ46UDW/C5v
         3sqdxhdGWaNTJzCUBs8MrndDaSnoEkd0WIDsdrfomLWd9J9Qrg4QO4cfnzghnjLEDS
         Ejst0Fw3bVclSDq0ak+Gg0xcvpyclA8mSHL7KjwHBolPs/bofmqxLUZIs5NdOagT5+
         FD+3GC6JBXBTg==
X-Nifty-SrcIP: [209.85.217.179]
Received: by mail-ua0-f179.google.com with SMTP id k14-v6so5498253uao.12;
        Fri, 22 Jun 2018 20:47:46 -0700 (PDT)
X-Gm-Message-State: APt69E3onmxkTS0C4FmXAisZ4icyA880RC4K4GbYUh/nhEd6IxWXrTIr
        X1WPCu3Vlgr+cwexqytYHDtt4p0qLp1MOuYP3F0=
X-Google-Smtp-Source: ADUXVKK01aki13TkrizN1fSZZYhyRLERFpxRjEa9effvP7MaiRsTJzPNGnNn2eJtyMT134+PJi6spkDsZVoLaO7Q+cI=
X-Received: by 2002:ab0:2e3:: with SMTP id 90-v6mr2512613uah.144.1529725665024;
 Fri, 22 Jun 2018 20:47:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 20:47:04
 -0700 (PDT)
In-Reply-To: <20180619041153.6668-1-suzuki.katsuhiro@socionext.com>
References: <20180619041153.6668-1-suzuki.katsuhiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 23 Jun 2018 12:47:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATB-oa+K47z+egfV2iSKoD3x2tyMNXQp1ukS2f1Yek54g@mail.gmail.com>
Message-ID: <CAK7LNATB-oa+K47z+egfV2iSKoD3x2tyMNXQp1ukS2f1Yek54g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: uniphier: add headphone detect gpio for
 LD20 global board
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-19 13:11 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds GPIO for headphone detection on LD20 global board.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> index 6a074a20c924..38b75998e2dd 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> @@ -60,6 +60,7 @@
>                         &i2s_port4
>                         &spdif_port0
>                         &comp_spdif_port0>;
> +               hp-det-gpio = <&gpio UNIPHIER_GPIO_PORT(15, 0) GPIO_ACTIVE_LOW>;


When you use irq-capable gpio pin (XIRQ0),
please write like follows for consistency.


             hp-det-gpio = <&gpio UNIPHIER_GPIO_IRQ(0) GPIO_ACTIVE_LOW>;


See uniphier-ld20-ref.dts for example.



>         };
>
>         spdif-out {
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDEBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7D320878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xTJ/5OHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7D320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeH1STP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:19:15 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:40255 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeH1STP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:19:15 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7SEREkk012569;
        Tue, 28 Aug 2018 23:27:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7SEREkk012569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535466435;
        bh=D3ULHv5bPVeqWgGb88g44JdF/TPn6HJpcPVZWX6hXOE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=xTJ/5OHRFKoIn9HRwiDA6Hb/2uASGh+92Un7VUj5R41W2qGk0Tfj933hfbfE6VrcV
         n1X2D3sbZgxKbnpc8Dta8uRh7XOt69c1FBNCKuJ/ZZZVj6HemMxLWqUKB3K/im+5ka
         ukMUe4CWytHsjnveV+GuhG5RGfnb2vHChe+lp2fVwmy0e5TfeMpPg0JixS7hMv3YPT
         6OZNcZIMAiOn+mSwy8jaujcSQ0c/gJmBMwSQ2o4BhZ7OqzWuxS2QDo107BzHo3Zicg
         YIxm8x+Q6PVAb9TS5qZ+mgPOCtuvnbLo28oCqX5PaMA7BP6+P1GE0BOJxJVdp6OhPp
         mV1BZ1gOGQX8A==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id j14-v6so868114vke.8;
        Tue, 28 Aug 2018 07:27:14 -0700 (PDT)
X-Gm-Message-State: APzg51AeLIhgTyME6fH7ULThaW9xrv4DPyQJbJgroc56XvLE/s5oUl/5
        5N7q+OsFLjY5nlVz2sYASHArJC6H0fEGd3Uc3JA=
X-Google-Smtp-Source: ANB0VdYOYRre2cD6LI2y5BLRHuC/ojHfNbDBW7ptDCS1DMZLu/f65dFHeOgXBQW1Pd0lMZZ8yJJlugGwA+/ySyT7x2Y=
X-Received: by 2002:a1f:3e47:: with SMTP id l68-v6mr1177905vka.42.1535466433728;
 Tue, 28 Aug 2018 07:27:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 07:26:33
 -0700 (PDT)
In-Reply-To: <1532076645-10769-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532076645-10769-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 28 Aug 2018 23:26:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6YZeM5s=kxYFKfCDKHEmArqG-+R3Hoy20rX165iqMBA@mail.gmail.com>
Message-ID: <CAK7LNAS6YZeM5s=kxYFKfCDKHEmArqG-+R3Hoy20rX165iqMBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: uniphier: dts: add more clocks to Denali NAND
 controller node
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 17:50 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Catch up with the new binding of the Denali IP where three clocks,
> "nand", "nand_x", "ecc" are required.
>
> For UniPhier SoCs, the "nand_x" and "ecc" are tied up because they
> are both 200MHz.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Both applied.


>  arch/arm/boot/dts/uniphier-ld4.dtsi  | 3 ++-
>  arch/arm/boot/dts/uniphier-pro4.dtsi | 3 ++-
>  arch/arm/boot/dts/uniphier-pro5.dtsi | 3 ++-
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 ++-
>  arch/arm/boot/dts/uniphier-sld8.dtsi | 3 ++-
>  5 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
> index 37950ad..2a17066 100644
> --- a/arch/arm/boot/dts/uniphier-ld4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
> @@ -347,7 +347,8 @@
>                         interrupts = <0 65 4>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&pinctrl_nand2cs>;
> -                       clocks = <&sys_clk 2>;
> +                       clock-names = "nand", "nand_x", "ecc";
> +                       clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
>                         resets = <&sys_rst 2>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
> index 49539f0..da88ccc 100644
> --- a/arch/arm/boot/dts/uniphier-pro4.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
> @@ -394,7 +394,8 @@
>                         interrupts = <0 65 4>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&pinctrl_nand>;
> -                       clocks = <&sys_clk 2>;
> +                       clock-names = "nand", "nand_x", "ecc";
> +                       clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
>                         resets = <&sys_rst 2>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
> index 06c2cef..40a84f2 100644
> --- a/arch/arm/boot/dts/uniphier-pro5.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
> @@ -439,7 +439,8 @@
>                         interrupts = <0 65 4>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&pinctrl_nand2cs>;
> -                       clocks = <&sys_clk 2>;
> +                       clock-names = "nand", "nand_x", "ecc";
> +                       clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
>                         resets = <&sys_rst 2>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index 641d961..1903752 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -528,7 +528,8 @@
>                         interrupts = <0 65 4>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&pinctrl_nand2cs>;
> -                       clocks = <&sys_clk 2>;
> +                       clock-names = "nand", "nand_x", "ecc";
> +                       clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
>                         resets = <&sys_rst 2>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
> index e9b9b4f..dc723bf 100644
> --- a/arch/arm/boot/dts/uniphier-sld8.dtsi
> +++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
> @@ -351,7 +351,8 @@
>                         interrupts = <0 65 4>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&pinctrl_nand2cs>;
> -                       clocks = <&sys_clk 2>;
> +                       clock-names = "nand", "nand_x", "ecc";
> +                       clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
>                         resets = <&sys_rst 2>;
>                 };
>         };
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

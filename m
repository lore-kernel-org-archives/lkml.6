Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AEBC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 03:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236C724B1B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 03:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ixhSZZQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236C724B1B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeFWDjz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 23:39:55 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:17791 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934209AbeFWDjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 23:39:54 -0400
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com [209.85.217.178]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w5N3dSJW027259;
        Sat, 23 Jun 2018 12:39:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w5N3dSJW027259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529725168;
        bh=YmGex1vbQqU0m/48rmKt7tetDgc/6HrI1tkhx4jMsSE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ixhSZZQ6RdNausQoeYSaNKZ09yG43abIFRF39TUiYANT2QIWVIqqeknhv8DbDLvgs
         raeigTggZMnsunBOcZcj/x9+GsD+h0tr2VGAzrPOv1C5koYTYXmrTmvEVoK6fz3eMd
         0lYOTjvNRwCOK67dQT1KuyNdN3Ykbe3LsoRdfL8hQF5g4i2auWfx3TG47FRuNVcmJw
         JQQtQxpKAxv7duONzMm+C4vkwUodOEwXLWFNMpG9aPe9eMPP4JvPiJ45cCPrUrGzjL
         RM+zAzLyszd+HM78i7L8vhl1d29tcCMlsY4sqLIcl9MugZo7isWNfBOqxOIrZ3Ytz0
         FPVFSfqEzyC9g==
X-Nifty-SrcIP: [209.85.217.178]
Received: by mail-ua0-f178.google.com with SMTP id n4-v6so5505417uad.6;
        Fri, 22 Jun 2018 20:39:28 -0700 (PDT)
X-Gm-Message-State: APt69E0nqRt69yZ0pTXRaMizf61Yn6IqxLmbO+4OaESmUhhib6efJqTS
        zJkgunVxy4YWfGxqFEmybbv0zrBw6hZdXA4yzPE=
X-Google-Smtp-Source: ADUXVKLtNhcSaDD7AnPRMUvj95wi9WmMlmoB/KMqPEASKbFlkOiAPnNPcgcKXuzoQ4A8F7RBI2lKIXgEm+AIUrJsnx0=
X-Received: by 2002:a9f:3d6b:: with SMTP id m43-v6mr2715136uai.17.1529725167531;
 Fri, 22 Jun 2018 20:39:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 20:38:47
 -0700 (PDT)
In-Reply-To: <20180619041205.6720-1-suzuki.katsuhiro@socionext.com>
References: <20180619041205.6720-1-suzuki.katsuhiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 23 Jun 2018 12:38:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFjKgSAAF5RUCU2Aj2eqxaBRmA3x2H0hPMzZKwTx6jFw@mail.gmail.com>
Message-ID: <CAK7LNATFjKgSAAF5RUCU2Aj2eqxaBRmA3x2H0hPMzZKwTx6jFw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: fix widget name of headphone for
 LD11/LD20 boards
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

2018-06-19 13:12 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch fixes wrong name of headphone widget for receiving events
> of insert/remove headphone plug from simple-card or audio-graph-card.
>
> If we use wrong widget name then we get warning messages such as
> "asoc-audio-graph-card sound: ASoC: DAPM unknown pin Headphones"
> when the plug is inserted or removed from headphone jack.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---


Applied.  Thanks!



>  arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
> index e5bda40b3ec6..7cc3f6dd93d9 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
> @@ -54,7 +54,7 @@
>         sound {
>                 compatible = "audio-graph-card";
>                 label = "UniPhier LD11";
> -               widgets = "Headphone", "Headphone Jack";
> +               widgets = "Headphone", "Headphones";
>                 dais = <&i2s_port2
>                         &i2s_port3
>                         &i2s_port4
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> index 38b75998e2dd..575be4ab0072 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> @@ -54,7 +54,7 @@
>         sound {
>                 compatible = "audio-graph-card";
>                 label = "UniPhier LD20";
> -               widgets = "Headphone", "Headphone Jack";
> +               widgets = "Headphone", "Headphones";
>                 dais = <&i2s_port2
>                         &i2s_port3
>                         &i2s_port4
> --
> 2.17.1
>



-- 
Best Regards
Masahiro Yamada

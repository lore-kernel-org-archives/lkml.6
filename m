Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F84DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1839420865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TrI6miEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1839420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeK0Cp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:45:27 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31566 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Cp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:45:26 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAQFoqDB009619;
        Tue, 27 Nov 2018 00:50:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAQFoqDB009619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543247453;
        bh=qOViX/GpR6jXbfnCfQlfaTKoOyERTC7kDBvvGaiuR4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TrI6miELnIPTLUwlEUhYY1pT39MyQ3F+M2FirEKewV5LAMMceY3T3SdqUaLNrNwv+
         YgHsCtfwarN5pKmgNLo7+C9CewjNH34D+s9tu90haB4FjESpW02vVs0wgqIm2NOfaA
         5KEOKlSY4Glp755lMoF9A0xZHTAZZXbosi+bXniSrHEQuVqDUa1Fhq9Y0a20XNHtQU
         A04IwbTD0ZI/t+ZdzP7DGQxGKvYbeS4y+2BZe1jAZhUB0old5SrTxTFpV90Nrdy3qg
         rd0EK4yfBhqlGuKRvTx7lfot7kFMe9y19uAPjR3hyH6a5Js79Z4SjE4QCob5Q7ud5O
         CYsy5/lM547Ow==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id d21so6457543uap.9;
        Mon, 26 Nov 2018 07:50:52 -0800 (PST)
X-Gm-Message-State: AA+aEWYciSmA1jCp+Y2zkdHPcwWvOv4kMMigtfOViA5wRAm0uHe/aL6L
        +98A6MI3sEehQqvXOB8v5Vw1+V0QX83fO7mLhRM=
X-Google-Smtp-Source: AFSGD/VaDG+3SccZkcAerwaLed1Kp+gvuqzTEgweeQBAuG8MHlZiXguLa5wRTUknTQMEcqU+KTZmCKaGXSDjo6lpYEY=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr11476568uap.6.1543247451616;
 Mon, 26 Nov 2018 07:50:51 -0800 (PST)
MIME-Version: 1.0
References: <1539945019-24950-1-git-send-email-yamada.masahiro@socionext.com> <1539945019-24950-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1539945019-24950-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Nov 2018 00:50:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQi6TT86260vy_5iLJuH9cxBnXYzW7dsEU_cmDTrGADxg@mail.gmail.com>
Message-ID: <CAK7LNAQi6TT86260vy_5iLJuH9cxBnXYzW7dsEU_cmDTrGADxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: uniphier: add bindings for UniPhier
 SoC family
To:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 7:32 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Document the list of SoCs and boards of UniPhier platform.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to linux-uniphier.


> Changes in v3:
>   - Capitalize 'Board' consistently
>   - Add Rob's Reviewed-by
>
> Changes in v2:
>   Changes suggested by Rob.
>   - Move the file to
>     Documentation/devicetree/bindings/arm/socionext/uniphier.txt
>   - Group boards by each SoC
>   Previous post:
>   v1: https://patchwork.ozlabs.org/patch/842010/
>
>  .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/socionext/uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
> new file mode 100644
> index 0000000..b3ed103
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/socionext/uniphier.txt
> @@ -0,0 +1,47 @@
> +Socionext UniPhier SoC family
> +-----------------------------
> +
> +Required properties in the root node:
> +  - compatible: should contain board and SoC compatible strings
> +
> +SoC and board compatible strings:
> +  (sorted chronologically)
> +
> +  - LD4 SoC:  "socionext,uniphier-ld4"
> +      - Reference Board: "socionext,uniphier-ld4-ref"
> +
> +  - Pro4 SoC: "socionext,uniphier-pro4"
> +      - Reference Board: "socionext,uniphier-pro4-ref"
> +      - Ace Board:       "socionext,uniphier-pro4-ace"
> +      - Sanji Board:     "socionext,uniphier-pro4-sanji"
> +
> +  - sLD8 SoC: "socionext,uniphier-sld8"
> +      - Reference Board: "socionext,uniphier-sld8-ref"
> +
> +  - PXs2 SoC: "socionext,uniphier-pxs2"
> +      - Gentil Board:    "socionext,uniphier-pxs2-gentil"
> +      - Vodka Board:     "socionext,uniphier-pxs2-vodka"
> +
> +  - LD6b SoC: "socionext,uniphier-ld6b"
> +      - Reference Board: "socionext,uniphier-ld6b-ref"
> +
> +  - LD11 SoC: "socionext,uniphier-ld11"
> +      - Reference Board: "socionext,uniphier-ld11-ref"
> +      - Global Board:    "socionext,uniphier-ld11-global"
> +
> +  - LD20 SoC: "socionext,uniphier-ld20"
> +      - Reference Board: "socionext,uniphier-ld20-ref"
> +      - Global Board:    "socionext,uniphier-ld20-global"
> +
> +  - PXs3 SoC: "socionext,uniphier-pxs3"
> +      - Reference Board: "socionext,uniphier-pxs3-ref"
> +
> +Example:
> +
> +/dts-v1/;
> +
> +/ {
> +       compatible = "socionext,uniphier-ld20-ref", "socionext,uniphier-ld20";
> +
> +       ...
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e6a1da..87b2c2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2183,6 +2183,7 @@ M:        Masahiro Yamada <yamada.masahiro@socionext.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/arm/socionext/uniphier.txt
>  F:     Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
>  F:     Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
>  F:     arch/arm/boot/dts/uniphier*
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFE2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199D320878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tGo6IlPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199D320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeH1STB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:19:01 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36923 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeH1STA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:19:00 -0400
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7SEQeOq017405;
        Tue, 28 Aug 2018 23:26:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7SEQeOq017405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535466401;
        bh=ii/V1VQJ6f094WpaNfPYBfrtqQzFPpEpEtvZScQYTy8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tGo6IlPmkTBuAEZrJjvE2M8jySkFsluU8RFVqtOdDI4qiee5iiZLnkGm4Y6adjWVJ
         OusEA1Qb0ZD8B2SDRiOiAUixVRWn5nveen5juzEb3QNoMGHZvwBRIjNhStjnMSldWQ
         bYr2z1rUqWfgsL+XIOoRYbBnXMzO9iudTS1hpavigu3NdOzVfx+g8IqLFaVt0MdG85
         Z5hILlJ1Lv2WuagiGMa4VnR5gOKMc+9I6gkUDn9XC7/GkviZEiZFTaQYai9HiJPh/T
         Q1dOyT9D33ifRmKDSz7Va80FaJJeU+mhIDCUTEVBYFIS/Wngfa4EOGfY4fstbawvbR
         cNSigLx4078kw==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id t4-v6so860921vke.9;
        Tue, 28 Aug 2018 07:26:41 -0700 (PDT)
X-Gm-Message-State: APzg51AA7iTaAtlj+/RQeKquCTxYNXIk+STgjO5SYNao1EsMItxdaFrb
        ru8MVLYqkZKzsiZYOolUDL/EgEv+4I5W6YOcpUQ=
X-Google-Smtp-Source: ANB0VdbfwgeYhAkZ6MYPRZw76pdZ7HCmQ5pvOLN3d4/C+IQ2WojBjn2DiYFevhI+OzDivsL5EaNX2s2EfumktNYh9Z0=
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr1123203vkd.10.1535466399967;
 Tue, 28 Aug 2018 07:26:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 07:25:59
 -0700 (PDT)
In-Reply-To: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1532589000-19602-1-git-send-email-hayashibara.keiji@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 28 Aug 2018 23:25:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQH+Y0xxXDRATV5JTK-DnG5bkeJv2wCCSkRcauT2EYm-Q@mail.gmail.com>
Message-ID: <CAK7LNAQH+Y0xxXDRATV5JTK-DnG5bkeJv2wCCSkRcauT2EYm-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add SPI dts node for UniPhier SoCs
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-26 16:09 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> This series adds SPI pin-mux node and SPI node for UniPhier SoCs.
>
> Changes since v1:
> - remove the node for MCSSI which support multiple channels.
>   Since the current driver doesn't support MCSSI, it deletes this node.


Applied. Thanks.


> Kunihiko Hayashi (3):
>   ARM: dts: uniphier: add SPI pin-mux node
>   ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
>   arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3
>
>  arch/arm/boot/dts/uniphier-ld4.dtsi              | 11 ++++++
>  arch/arm/boot/dts/uniphier-pinctrl.dtsi          | 20 +++++++++++
>  arch/arm/boot/dts/uniphier-pro4.dtsi             | 11 ++++++
>  arch/arm/boot/dts/uniphier-pro5.dtsi             | 22 ++++++++++++
>  arch/arm/boot/dts/uniphier-pxs2.dtsi             | 22 ++++++++++++
>  arch/arm/boot/dts/uniphier-sld8.dtsi             | 11 ++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 22 ++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 44 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 22 ++++++++++++
>  9 files changed, 185 insertions(+)
>
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

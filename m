Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B750FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A61D2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivcThHLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A61D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeJRWZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbeJRWZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:25:53 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C87921477;
        Thu, 18 Oct 2018 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539872678;
        bh=vkfNO8xLQnsxLlhSwV054j82Tt775BuYwMMzGfYnoRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ivcThHLFV+EimVZK2BF3cc6DSQ618gKXSSgMGbZTcXFceSNACzsBONGRu2Xx4dVvQ
         +/8HlZiaN67rU2Ms9LGbEN97p/ArInFFJ0rTOD5eKmabvWRhdZD9mcj4BTv/hXV7kU
         1rUB4Gcl3CRhRPPuZMAaZWc2a/facx5yTrqxMsPo=
Received: by mail-wr1-f50.google.com with SMTP id y16so33934201wrw.3;
        Thu, 18 Oct 2018 07:24:38 -0700 (PDT)
X-Gm-Message-State: ABuFfogwaHPuMhSXUnQJa33xfIqlmWD57h5LwC0+PF9zaDR2MyOTJUF1
        yy8mj9qqGShG4LboAvo7+uxmw8/NJ8YRAjrV7RA=
X-Google-Smtp-Source: ACcGV61xzHJ9ic+gYJSO3fVzHH3QD5F2TFptyY/2+MIj8FFeKW/gx5GSJKD1RbDXi9i4X1BVtWhX9bYcaoqLISAlL7g=
X-Received: by 2002:adf:9592:: with SMTP id p18-v6mr30375166wrp.202.1539872676703;
 Thu, 18 Oct 2018 07:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org> <20181008191411.32555-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181008191411.32555-3-manivannan.sadhasivam@linaro.org>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 18 Oct 2018 22:24:25 +0800
X-Gmail-Original-Message-ID: <CAGp9LzqKEpmJMZhU0KW2GWXT4mxEiMqA0xhGxeX2kv+7_ADtKw@mail.gmail.com>
Message-ID: <CAGp9LzqKEpmJMZhU0KW2GWXT4mxEiMqA0xhGxeX2kv+7_ADtKw@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: mediatek: mt6797: Add pinctrl support
To:     manivannan.sadhasivam@linaro.org
Cc:     =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        linus.walleij@linaro.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 3:16 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add pinctrl support for Mediatek MT6797 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> index 4beaa71107d7..231230d32d09 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/mt6797-clk.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/mt6797-pinfunc.h>
>
>  / {
>         compatible = "mediatek,mt6797";
> @@ -129,6 +130,19 @@
>                 #clock-cells = <1>;
>         };
>
> +       pio: pinctrl@10005000 {
> +               compatible = "mediatek,mt6797-pinctrl";
> +               reg = <0 0x10005000 0 0x1000>,
> +                     <0 0x10002000 0 0x400>,
> +                     <0 0x10002400 0 0x400>,
> +                     <0 0x10002800 0 0x400>,
> +                     <0 0x10002C00 0 0x400>;
> +               reg-names = "gpio", "iocfgl", "iocfgb",
> +                           "iocfgr", "iocfgt";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +

The content looks good to me, but the dt-binding document is required
to be added for MT6797 SoC before the DTS instance is being added.

>         scpsys: scpsys@10006000 {
>                 compatible = "mediatek,mt6797-scpsys";
>                 #power-domain-cells = <1>;
> --
> 2.17.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

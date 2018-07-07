Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB69C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4386E20882
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBnoY429"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4386E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeGGPeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753567AbeGGPeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:34:11 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DC820882;
        Sat,  7 Jul 2018 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530977650;
        bh=way44VBhJ5IAHs5ACC3IuK7TJRPmQEn83p37vqNe6Ns=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dBnoY429mTLKtdWm8ehP3uu7BQCE0DRxQ3WDcImtQWWdHQB29+/IX7jnmIXH+h9af
         /Ipi0mUcvpxlJzgEUOGAjScNeh+PXLG7SmET7KK053RxiQlO6Y3tluPLEoB5HReOjT
         jyvilevfNkWzaTgF1BL0Qgn7aYhnYZ5OG29Bk8B8=
Received: by mail-wr1-f46.google.com with SMTP id h40-v6so6777881wrh.2;
        Sat, 07 Jul 2018 08:34:10 -0700 (PDT)
X-Gm-Message-State: APt69E2HsmUxQuBOVEEWerbKKEApb2EtXR2wOXXUtmIdPcGboB9FMtzC
        KoNw9eac4b2gWgaJZOhv23Uq9wJ1qegJLOot+Nw=
X-Google-Smtp-Source: AAOMgpfW+lT4MxECzpL2bakpr4cFRG0DSm4N+vKQK5+EYkxn+WoHKvbi8IkONPwXtISUBM3RHZ6uJaPbwjjeQdyDYYM=
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr10999801wro.259.1530977649055;
 Sat, 07 Jul 2018 08:34:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 08:34:08 -0700 (PDT)
In-Reply-To: <20180707144527.6662-1-simon@lineageos.org>
References: <20180707144527.6662-1-simon@lineageos.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 7 Jul 2018 17:34:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfUav7URsCDHFzMbtBiw5id+szVj_VtGJ-iu5ymmgWoXw@mail.gmail.com>
Message-ID: <CAJKOXPfUav7URsCDHFzMbtBiw5id+szVj_VtGJ-iu5ymmgWoXw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: add max77693 irq configuration for midas
To:     Simon Shields <simon@lineageos.org>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 July 2018 at 16:45, Simon Shields <simon@lineageos.org> wrote:
> Currently, we assume that the bootloader has correctly configured
> the interrupt pin for max77693. This might not actually be the case -
> so it's better to configure it explicitly.
>
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index f35176a35a15..30760bf2eb71 100644
> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> @@ -156,6 +156,8 @@
>                         compatible = "maxim,max77693";
>                         interrupt-parent = <&gpx1>;
>                         interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&max77693_irq>;
>                         reg = <0x66>;
>
>                         regulators {
> @@ -1117,6 +1119,13 @@
>                 samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
>         };
>
> +       max77693_irq: max77693-irq {
> +               samsung,pins = "gpx1-5";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +

Please put it before hdmi-hpd (gpx3-7). What about the interrupt for
max77693 fuel gauge? Maybe another patch for it as well?

Best regards,
Krzysztof


>         sleep1: sleep-states {
>                 PIN_SLP(gpk0-0, PREV, NONE);
>                 PIN_SLP(gpk0-1, PREV, NONE);
> --
> 2.18.0
>

Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB77ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D2020852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwLzXsID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D2020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeGRKfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeGRKfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:35:02 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1F520852;
        Wed, 18 Jul 2018 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531907875;
        bh=kaJySW2f9PAsYomx4x6VS1j/1yAJ0l+Ji/GC/do1Ruw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WwLzXsIDqkKmC7mgm/ZO0PJwWtkMgqpuWurxIB3jPeTOsE7eT70CdCOm7H4pfigNU
         iX/XMSf1jfo9VbcY5BA49UVR9KyHKWvZeT9kQBf9vfX8Q3YypT3AKaEmdnK477Qj/t
         sQ/YpkV5Xj1fcSDdhq6+PwcnXNehlftm4ROx4q+k=
Received: by mail-wm0-f51.google.com with SMTP id f21-v6so2147997wmc.5;
        Wed, 18 Jul 2018 02:57:54 -0700 (PDT)
X-Gm-Message-State: AOUpUlG+wF9rT4p9UY31I4UpnaDtEB10Om11ynyOm2ScNGOzLqFViBrv
        j+ec/ZhkFnmhtLSBVGSb3cPANVvyEwB4OsMK/Zk=
X-Google-Smtp-Source: AAOMgpeANRvtBTF6vgdYc63xTT3wiBPajjTzq9jFmOfaN5uWl9V0tPXuMjzDMis4yNuNVrtIZukFms6jE6pTDa/z2EY=
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr1218055wmm.117.1531907873286;
 Wed, 18 Jul 2018 02:57:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 02:57:52
 -0700 (PDT)
In-Reply-To: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 11:57:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
Message-ID: <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos5: add missing interrupts for pwm node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
> Add missing GIC interrupts property for pwm nodes.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 5d2f0a0..9406108 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -169,6 +169,11 @@
>                 pwm: pwm@12dd0000 {
>                         compatible = "samsung,exynos4210-pwm";
>                         reg = <0x12DD0000 0x100>;
> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,

Indentation here looks weird - spaces used after tabs but not aligned
with first entry. Please indent it properly and align it.

Best regards,
Krzysztof

> +                                  <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                                  <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                                  <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>                         samsung,pwm-outputs = <0>, <1>, <2>, <3>;
>                         #pwm-cells = <3>;
>                 };
> --
> 2.7.4
>

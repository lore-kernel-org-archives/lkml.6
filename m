Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92492070B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549365826;
	bh=NSlis3uww8wozoZ8nV/g/cBjtqy1PK2yWJaHvYlsPcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XRuH0x0v79WkwpbPTvLtOgzPIcYGe7oJ5oM01fqcQQ30uSVh5aBH92H2Szs3YBP3v
	 PXi4rIs9/P93mM3Xm3X8aCUbdFkc+1HxiOTMcrfe6Wa1O+0IB5O53k6hL1GKmWrfpM
	 v9wj9Qk5QOAatI0kSJdKu9qHI/cx7C/DnHPZbpCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfBELXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:23:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfBELXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:23:44 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B64D207E0;
        Tue,  5 Feb 2019 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549365823;
        bh=NSlis3uww8wozoZ8nV/g/cBjtqy1PK2yWJaHvYlsPcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D9neKnfcHahRljZ62EkKFRL0LaPX6Fi/U6lvg0z9Ml4TiCXis2q4tRyEmXWwS5Jdv
         axd17ev4cnW1yzHFdYR7IbUJT0f9xacT1mT2rFTzEKwLR4NFsaU0M/xQoOnHr10MY8
         y1Ozcd7UEp1q2P85dnPAs+4g8VBdgLz8nGk0xing=
Received: by mail-lf1-f43.google.com with SMTP id j15so2347856lfh.5;
        Tue, 05 Feb 2019 03:23:43 -0800 (PST)
X-Gm-Message-State: AHQUAubeSM1lES5taAU6D7aDnGKwDzT6mR4TFHKOUbHPEzzGCGTJ3s9O
        uwBOgpiqQn2NMBVyKvTDY3d2bJcHSK1bL23atuE=
X-Google-Smtp-Source: AHgI3IbkzSzvEgI8/lhW9Ro7hmoO9zcfRbZldJ5mKbvoFrSxFN+shDynqBaQaNYneLlmhlKiMDt0mTaA0jz3gOVsxz4=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr2679972lfh.159.1549365821571;
 Tue, 05 Feb 2019 03:23:41 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7@eucas1p2.samsung.com>
 <20190124154521.13589-1-k.konieczny@partner.samsung.com> <20190124154521.13589-2-k.konieczny@partner.samsung.com>
In-Reply-To: <20190124154521.13589-2-k.konieczny@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 5 Feb 2019 12:23:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfm1L2FvcyhbfYEgv-04RQpVnARc0zXt6j_41nCzfE53Q@mail.gmail.com>
Message-ID: <CAJKOXPfm1L2FvcyhbfYEgv-04RQpVnARc0zXt6j_41nCzfE53Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: exynos: add SlimSSS for Exynos5433
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 16:45, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> Add DT node for SlimSSS (aka Slim SecuritySubSystem) in Exynos5433 SoC.
> The users can use compatibility "samsung,exynos5433-slim-sss".
>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Before picking this up, bindings have to be accepted and I see
discussion is still ongoing (no Ack from Rob yet). Anyway this depends
on header file with clock ID, so it will have to wait for next cycle.

I will pick it up for v5.2, after v5.1 merge window.

Best regards,
Krzysztof
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index e7cd3b67d818..9e5fcb6c7776 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -559,6 +559,15 @@
>                                 <&cmu_top CLK_DIV_ACLK_IMEM_200>;
>                 };
>
> +               slim_sss: slim-sss@11140000 {
> +                       compatible = "samsung,exynos5433-slim-sss";
> +                       reg = <0x11140000 0x1000>;
> +                       interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-names = "aclk", "pclk";
> +                       clocks = <&cmu_imem CLK_ACLK_SLIMSSS>,
> +                                <&cmu_imem CLK_PCLK_SLIMSSS>;
> +               };
> +
>                 pd_gscl: power-domain@105c4000 {
>                         compatible = "samsung,exynos5433-pd";
>                         reg = <0x105c4000 0x20>;
> --
> 2.20.0
>

Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9273AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431E920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrCc9G/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431E920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJPXAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPXAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:00:21 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70FC62145D;
        Tue, 16 Oct 2018 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539702567;
        bh=zQiimhACeZc2wBZ4js31PHh12+qee5/i8UMw+4x5dEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DrCc9G/cND4C8CukMc/IYME6WCAUUTL/18kluwEoIRgqhIbtPJsOJ+XOoq/eEnJWM
         nSTZgu/JjoojesxG8HZeuUk8Odvel5YKxWWul7UEiyyMb2otXzGUEnP9S1JAexwU13
         qiHcSGctm30hC9PzPdOip2Wq5ERMAo262PZ4R1nc=
Received: by mail-wr1-f41.google.com with SMTP id 63-v6so25933612wra.11;
        Tue, 16 Oct 2018 08:09:27 -0700 (PDT)
X-Gm-Message-State: ABuFfoiqzHQsF2uyDvgstZlRANlj7+unZTxjPdti2bQrhpCc6HQkUbAC
        NfsHlsO8TFVLlpMHAvGrxD0lG9kPqsJkOALUNt8=
X-Google-Smtp-Source: ACcGV63J7bDgrI4/M2qEM/y6iAPNEQDgQwv80JEIM4LDGUdZ7i81vxJYvxUC7fHRGI2e6oq1/v06biRgIkUBgeX2uvI=
X-Received: by 2002:adf:e152:: with SMTP id f18-v6mr18032305wri.42.1539702565824;
 Tue, 16 Oct 2018 08:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016145647eucas1p206c068806214535da339588d77cbdfa5@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com> <20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K@eucas1p2.samsung.com>
In-Reply-To: <20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 17:09:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com>
Message-ID: <CAJKOXPe4Jf3QVbQ6BFPFptkgvmmpNu+QCmDoD3JqhyYOidJ7vA@mail.gmail.com>
Subject: Re: [PATCH 06/11] DT: arm64: exynos: add support for thermal trip irq-mode
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>

Hi Lukasz,

Thanks for patches.

I did not receive the first patches in the series. It is okay (depends
on the context) but in such case sending cover letter to all people is
quite useful. It helps to understand the entire patchset. Since I did
not get them, I really do not know:
1. Whether DTS patches are independent?
2. How this fits in the big picture of Exynos thermal?


> This patch adds support for new flash which indicates

What is "flash"?

Please wrap your lines accordingly (75 characters like in
submitting-patches.rst). Current wrapping makes it more difficult to
read.

> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

"Exynos5433 supports 8 trip points which trigger interrupt."
(or IRQ but not irq)

> Above that number other trip points should be registered
> without 'irq-mode' flag.

Why they should be registered without irq-mode?

> That will force the thermal framework to start polling
> the temperature sensor under configured conditions and
> handle the trip point.

How does it fit into existing polling mode?

>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
>  1 file changed, 70 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> index fe3a0b1..c4330f6 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
> @@ -17,37 +17,44 @@ thermal-zones {
>                         atlas0_alert_0: atlas0-alert-0 {
>                                 temperature = <65000>;  /* millicelsius */
>                                 hysteresis = <1000>;    /* millicelsius */
> -                               type = "active";
> +                               type = "passive";

Change of active->passive looks irrelevant to this topic. Here and
everywhere else.

Best regards,
Krzysztof

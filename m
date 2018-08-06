Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B905321A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+DLRhAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B905321A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbeHFWqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbeHFWqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:46:32 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F0D21A5B;
        Mon,  6 Aug 2018 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533587746;
        bh=TT3DXSoLvkI46s9+p5F1JTit8dTYoIIKPDBgGZt6r9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z+DLRhAQS7bSHYbYiCrQD9FEdrc/rMMfwk9IeQCPTe65EjYwtciyxeu6dTVE6OmCD
         HKlzaieuNfSTzpzrAmpTqKjP5um6n4QeGtN03R5qMW2S6RQYZW7Udn2qbDb0H/sUW3
         hRUGptzz9Fsu+/iHCzOhJu8JyvBecTq7tHiedN+E=
Received: by mail-qt0-f180.google.com with SMTP id m13-v6so15481502qth.1;
        Mon, 06 Aug 2018 13:35:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlFZT+Hh54S4nLcs67BrfVZ3PcxCrGfQQGxGmDKIPOJyqkQAf15+
        T01kR8rxQFo91HoUO7iADfWST/QuAI6gHgJN+w==
X-Google-Smtp-Source: AAOMgpfPwKzY+Zqlk5S1hjeSeOoCyrG+dKYvRBLRFyUc2eztb4Nz+lLVARA3z63JP7iFmq73+s5clZ2C8v0FmkJIz+k=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr16648629qta.60.1533587745997;
 Mon, 06 Aug 2018 13:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org> <1533305419-29152-5-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1533305419-29152-5-git-send-email-sricharan@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 14:35:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL2g+1maJLDf0uDAWEmLtA5bUPP5Pi_pRSd3Lu-yBFq9g@mail.gmail.com>
Message-ID: <CAL_JsqL2g+1maJLDf0uDAWEmLtA5bUPP5Pi_pRSd3Lu-yBFq9g@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm: dts: qcom: Add ipq8064-ap161.dts
To:     Sricharan <sricharan@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 8:10 AM Sricharan R <sricharan@codeaurora.org> wrote:
>
> Add a new board dts for ipq8064-ap161.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.txt | 2 ++
>  arch/arm/boot/dts/Makefile                     | 1 +
>  arch/arm/boot/dts/qcom-ipq8064-ap161.dts       | 7 +++++++
>  3 files changed, 10 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-ap161.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
> index ee532e7..2325135 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.txt
> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
> @@ -15,6 +15,7 @@ The 'SoC' and 'board' elements are required. All other elements are optional.
>
>  The 'SoC' element must be one of the following strings:
>
> +       ipq8064
>         apq8016
>         apq8074
>         apq8084
> @@ -30,6 +31,7 @@ The 'SoC' element must be one of the following strings:
>
>  The 'board' element must be one of the following strings:
>
> +       ap
>         cdp
>         liquid
>         dragonboard
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de7..233661a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -772,6 +772,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>         qcom-ipq4019-ap.dk07.1-c1.dtb \
>         qcom-ipq4019-ap.dk07.1-c2.dtb \
>         qcom-ipq8064-ap148.dtb \
> +       qcom-ipq8064-ap161.dtb \
>         qcom-msm8660-surf.dtb \
>         qcom-msm8960-cdp.dtb \
>         qcom-msm8974-fairphone-fp2.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap161.dts b/arch/arm/boot/dts/qcom-ipq8064-ap161.dts
> new file mode 100644
> index 0000000..aab5174
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq8064-ap161.dts
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "qcom-ipq8064-v1.0.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. IPQ8064/AP-161";
> +       compatible = "qcom,ipq8064-ap161";

Doesn't match what you documented above. I'm guessing the ap148 board
didn't either...

Rob

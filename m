Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE09DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999D720840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1wNA+eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999D720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeKIHTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:19:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeKIHTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:19:39 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F1120840;
        Thu,  8 Nov 2018 21:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541713334;
        bh=yn+R3U8VEdQCXLTuQjQr/tLZiE53ikIyiSiIoX70mK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n1wNA+eQ9Ta+9cN/6R55gCRHJEzlQIiKF+C4Ww6JLF4f9l0HrMHpKMYgQm9e816Ko
         9fYs75nhfgarEGWghPdKPaFyH8x7scVxuK2S7/PYCSmYhYg67mfRCRaS0OmbEgAnCt
         GdjYsRKtFAqdNXDS7VEL9xw8y7PqYnLhxyR3+sqw=
Received: by mail-qk1-f173.google.com with SMTP id e4so29247157qkh.6;
        Thu, 08 Nov 2018 13:42:14 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ8riYz2QZQrov2vVAkFddAN8nCbz7nto2n0B7+6P3NqBrZzFuf
        MfQGLEP3dVDmpICeafl0bY71w4cSYcva4YrsnQ==
X-Google-Smtp-Source: AJdET5fBz41FpSlKcF/OOg7qW4JLfXYh2fwBybUyU8PqmMQvycOPXz+X7JiO5SaLy6lJcPpgFZ1CFasFRC1P0apJS2E=
X-Received: by 2002:a37:9201:: with SMTP id u1-v6mr5681911qkd.29.1541713333546;
 Thu, 08 Nov 2018 13:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20181108184009.18430-1-vkoul@kernel.org> <20181108184009.18430-13-vkoul@kernel.org>
In-Reply-To: <20181108184009.18430-13-vkoul@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Nov 2018 15:42:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJSszvQ0QC0LLT4ho+xMgiMJRVJyrM93OgH21Neu6xMqw@mail.gmail.com>
Message-ID: <CAL_JsqJSszvQ0QC0LLT4ho+xMgiMJRVJyrM93OgH21Neu6xMqw@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] arm64: dts: qcom: pms405: add gpios
To:     Vinod <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 12:41 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Add the GPIOs present on PMS405 chip.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 2b275bbdafa3..85a3228abaf9 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -10,6 +10,25 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               pms405_gpios: gpios@c000 {

gpio@...

> +                       compatible = "qcom,pms405-gpio";
> +                       reg = <0xc000>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> +                               <0 0xc1 0 IRQ_TYPE_NONE>,
> +                               <0 0xc2 0 IRQ_TYPE_NONE>,
> +                               <0 0xc3 0 IRQ_TYPE_NONE>,
> +                               <0 0xc4 0 IRQ_TYPE_NONE>,
> +                               <0 0xc5 0 IRQ_TYPE_NONE>,
> +                               <0 0xc6 0 IRQ_TYPE_NONE>,
> +                               <0 0xc7 0 IRQ_TYPE_NONE>,
> +                               <0 0xc8 0 IRQ_TYPE_NONE>,
> +                               <0 0xc9 0 IRQ_TYPE_NONE>,
> +                               <0 0xca 0 IRQ_TYPE_NONE>,
> +                               <0 0xcb 0 IRQ_TYPE_NONE>;
> +               };
> +
>                 rtc@6000 {
>                         compatible = "qcom,pm8941-rtc";
>                         reg = <0x6000>;
> --
> 2.14.4
>

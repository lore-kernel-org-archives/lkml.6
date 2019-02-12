Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC8EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA49B2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="et3YnFo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfBLFF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:05:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44462 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLFF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:05:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so1526991qte.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 21:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SijfIY2qCi5nm0jhI17fdhfAiM3IratR88/I4mIxynI=;
        b=et3YnFo0vN2c9ocgdK/XBhNZURvkboekVTRBag6WRAA/YON6rhck2mDuTZ/064A3ft
         eKsv6/zXrlL5K2ltvAYeV0AqE+50zQwNI24As08iSkAFR+NqewDQUASt4dYCrOyFiw8c
         7mB9qdhxxiHzIDWusgLaRweU4lDWC743OA+64stLl4+kgFkcmGOnNqQdWK2nH0qnSWUP
         XaTp5IwW+dCY6KcEZ1Yx71hErbs54Li2dZsWeh6Dr3q+ySrB1xGQTMC4mfqurzSmFHKQ
         ruS6NBUTAlnH/ZnEEWGCFe257uULLcOt+LKuU4V27heONC091ZgPfRzLtju3SQK8DL78
         xOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SijfIY2qCi5nm0jhI17fdhfAiM3IratR88/I4mIxynI=;
        b=CIelmm2OXE5MjdN43mZbiFY56IHuwr7OM4jbgOMqrc25epnEIfRtl6nfg+dFEWii4l
         zUfroTUWPhzxCCDnxDMrR/PJ8z95rrNLEXqOTzWxnshKLRNg5NnAOlkKwufEXXkkspMf
         1aJoIbqIPypRF8QRwVuZdwsl5eYiMAS78YpibOYumhILNhkAYDGGzhbjqPOtBZYKY/q2
         6M7klnkstx9ULcZutaEiM7vIuhJTWEUM7PA/Bf+KwnQ/SOTYenrsqIpvbNqJ2mnvdy2p
         /f1eDk3noYo1F8WVtHHivjt+3o4nz8fXq8bofqm9zohXIOE5bdayzniaGz4zBPiKjcSv
         6JAA==
X-Gm-Message-State: AHQUAuYz6TvAr/gzXhHVnajP79pcjuDzHnOlyI9IO7zE/z6+4YpeVZ5A
        QXnXgRIg7UXhV4W3CPy99Vat0fUZq8fE9Jsp1Gxtyg==
X-Google-Smtp-Source: AHgI3IYSju9zRMSCXD6gbltH9+tDskpIiwqMrQ3FN9TYsI2DJywkN4lWGRUy+yfGjgckyQPAynUiVbp/SQggJDhs5O8=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr1424946qtd.144.1549947925594;
 Mon, 11 Feb 2019 21:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20190211190019.171583-1-mka@chromium.org>
In-Reply-To: <20190211190019.171583-1-mka@chromium.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 12 Feb 2019 10:35:14 +0530
Message-ID: <CAP245DWMH44v_E5uqet4Wm_bwpwLL7K_faB4Vq=7H5onxj94qg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add dynamic CPU power coefficients
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:30 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add dynamic power coefficients for the Silver and Gold CPU cores of
> the Qualcomm SDM845.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e4b69c74fe077..6e8a2331176ec 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -120,6 +120,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <100>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_0>;
> @@ -137,6 +138,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x100>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <100>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_100>;
> @@ -151,6 +153,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x200>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <100>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_200>;
> @@ -165,6 +168,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x300>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <100>;
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_300>;
> @@ -179,6 +183,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x400>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <396>;
>                         qcom,freq-domain = <&cpufreq_hw 1>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_400>;
> @@ -193,6 +198,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x500>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <396>;
>                         qcom,freq-domain = <&cpufreq_hw 1>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_500>;
> @@ -207,6 +213,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x600>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <396>;
>                         qcom,freq-domain = <&cpufreq_hw 1>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_600>;
> @@ -221,6 +228,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x700>;
>                         enable-method = "psci";
> +                       dynamic-power-coefficient = <396>;
>                         qcom,freq-domain = <&cpufreq_hw 1>;
>                         #cooling-cells = <2>;
>                         next-level-cache = <&L2_700>;
> --
> 2.20.1.791.gb4d0f1c61a-goog
>

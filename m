Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD87C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E6C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEtS3F6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfANIzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:55:52 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45897 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANIzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:55:52 -0500
Received: by mail-vs1-f66.google.com with SMTP id x28so13115442vsh.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIrGXrTeDTD2KD6/rilurSb9J53p/6aGfT6xPid1YYU=;
        b=QEtS3F6F8iJSrbJIhNPMukByfeYXsgwgLbJfVpCrmWBAXFwUAV5tQK63rylHg2WAIP
         plzXafdet4WODpT4ujemBbzVxIFhK6oYuWY7x3vVt2QN6IesaidDIazBE6fi17Ge6ou6
         K+osVajLPcWfC2OIcMV2uJB1Swyasg0Iw7lCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIrGXrTeDTD2KD6/rilurSb9J53p/6aGfT6xPid1YYU=;
        b=R9vYm9HF70YzdrvrX56V6YxGXGwXtg1uPixoLDnAi8QSzlE1KlZZTDUJ6dQWJJc7mm
         fxoskQSTqmUGsO4F9MOtq2413XrTOxFkijaS7dOpvcSgc3aRqMa5dNh3quk5imBDywBC
         LYNDhKNKXscVtjuSgQNFhmZnK5NbZVwqi+3aBo6ypqePo5cKGRZEV2wkZc0OBPXdIuHY
         3kHIN8WhfCCMYHjW5HQ+13E2CSTrgi1xGpSxuyk8MupsxgX0ji46C/PdO1DZ0kCCUYv9
         o0f+Y9ZrGdpCi9TrwRDuCg0i546nF5THHj7aJ6ZkJs4Bz+VIu1qNFBj5R4dWMf+E8yxb
         QXBQ==
X-Gm-Message-State: AJcUukcP/4Hj7Kl/eLH3kHWhbuytfHNEdtbaJEKcmhvtquhyUn5aq6V/
        rLHa5DTAl8Ezl6WKx8PtP+f7vw4Fc57u2v9YOntP7A==
X-Google-Smtp-Source: ALg8bN51ssr5ltoffjA6pGI8zzIRke9K+kP6V4KuJvLceI/eAmTQKSJ60AIIVZb7FwEiZtrKdoGBnUBbw9lzwYdOlWU=
X-Received: by 2002:a67:7ed8:: with SMTP id z207mr9157387vsc.159.1547456150406;
 Mon, 14 Jan 2019 00:55:50 -0800 (PST)
MIME-Version: 1.0
References: <1545416063-22552-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1545416063-22552-1-git-send-email-tdas@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 14 Jan 2019 14:25:39 +0530
Message-ID: <CAHLCerO=hzzUvPfo=s_o4mTbXDPn=UguD4jbSi5GLRpgOf7_SA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add cpufreq device node
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:44 PM Taniya Das <tdas@codeaurora.org> wrote:
>
> This change adds the cpufreq node as per the bindings example for SDM845.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 23a253b..a69a21e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -99,6 +99,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         next-level-cache = <&L2_0>;
>                         L2_0: l2-cache {
>                                 compatible = "cache";
> @@ -114,6 +115,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x100>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         next-level-cache = <&L2_100>;
>                         L2_100: l2-cache {
>                                 compatible = "cache";
> @@ -126,6 +128,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x200>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         next-level-cache = <&L2_200>;
>                         L2_200: l2-cache {
>                                 compatible = "cache";
> @@ -138,6 +141,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x300>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         next-level-cache = <&L2_300>;
>                         L2_300: l2-cache {
>                                 compatible = "cache";
> @@ -150,6 +154,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x400>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
>                         next-level-cache = <&L2_400>;
>                         L2_400: l2-cache {
>                                 compatible = "cache";
> @@ -162,6 +167,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x500>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
>                         next-level-cache = <&L2_500>;
>                         L2_500: l2-cache {
>                                 compatible = "cache";
> @@ -174,6 +180,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x600>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
>                         next-level-cache = <&L2_600>;
>                         L2_600: l2-cache {
>                                 compatible = "cache";
> @@ -186,6 +193,7 @@
>                         compatible = "qcom,kryo385";
>                         reg = <0x0 0x700>;
>                         enable-method = "psci";
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
>                         next-level-cache = <&L2_700>;
>                         L2_700: l2-cache {
>                                 compatible = "cache";
> @@ -1686,6 +1694,17 @@
>                                 status = "disabled";
>                         };
>                 };
> +
> +               cpufreq_hw: cpufreq@17d43000 {
> +                       compatible = "qcom,cpufreq-hw";
> +                       reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +                       reg-names = "freq-domain0", "freq-domain1";
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +                       clock-names = "xo", "alternate";
> +
> +                       #freq-domain-cells = <1>;
> +               };
>         };
>
>         thermal-zones {
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>

Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BD7EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4770C20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4UabTgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4770C20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966289AbeFNOWG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965632AbeFNOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:22:00 -0400
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com [209.85.214.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2A3208DA;
        Thu, 14 Jun 2018 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528986119;
        bh=VFvMhJhhhAoj9fgrj43h9MQzdv3G4jbw04Fj0CopWqA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=B4UabTgpKaP9q13FD5Rkwn7ppTJtMm5yQnwXa4k7C58HVRV+l9OQrsu1AA9a5GtR+
         HGsZ8JFwn1X7pfaVBDxATDtgqeeHpc9e5d4v7RYxd/cvxofWv7XTmNogFaHfisLQR3
         eQ8fPM/tiHaQlD5vDzpN4ZJqfbtqs8/46EB7oagw=
Received: by mail-it0-f51.google.com with SMTP id p185-v6so8930200itp.4;
        Thu, 14 Jun 2018 07:21:59 -0700 (PDT)
X-Gm-Message-State: APt69E2xMqyutwOTIRAcar2bOSyZ2AeeXi+UFNlNETpfOuK+M3k4J3WY
        GXu7hWEm7nvdDB+ODJruVDdeL85Qz5oja92JvQ==
X-Google-Smtp-Source: ADUXVKLrqKew9aRvjPBnal7Q6yslP+gQ2hsH+JXt/FAGOOB4Q/wJ0SFD613i99nxJk0fzgLOfShJZx/ef5ioguRnL6Y=
X-Received: by 2002:a02:6902:: with SMTP id e2-v6mr1382274jac.46.1528986118573;
 Thu, 14 Jun 2018 07:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 07:21:38
 -0700 (PDT)
In-Reply-To: <0cdd0957cf80c2f9921928755722a427c7309964.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org> <0cdd0957cf80c2f9921928755722a427c7309964.1528972165.git.amit.kucheria@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Jun 2018 08:21:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPKktGFH4X9gDgCFq70Uo6NvFx9-a0sR7fQU35NwZe1g@mail.gmail.com>
Message-ID: <CAL_JsqLPKktGFH4X9gDgCFq70Uo6NvFx9-a0sR7fQU35NwZe1g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] thermal: tsens: Add support for SDM845
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 uses the TSENS v2 IP block
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt | 1 +
>  arch/arm64/boot/dts/qcom/msm8996.dtsi                    | 2 +-
>  drivers/thermal/qcom/tsens-v2.c                          | 9 ++++++++-
>  drivers/thermal/qcom/tsens.c                             | 3 +++
>  drivers/thermal/qcom/tsens.h                             | 5 ++++-
>  5 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..84da3db 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -5,6 +5,7 @@ Required properties:
>   - "qcom,msm8916-tsens" : For 8916 Family of SoCs
>   - "qcom,msm8974-tsens" : For 8974 Family of SoCs
>   - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> + - "qcom,tsens-v2"      : For any SoC with v2 version of the tsens IP

Stick with "qcom,sdm845-tsens". Though perhaps it should be
'"qcom,sdm845-tsens", "qcom,msm8996-tsens"' if there is compatibility.

>
>  - reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 6c8a857..28d4c08 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -460,7 +460,7 @@
>                 };
>
>                 tsens0: thermal-sensor@4a8000 {
> -                       compatible = "qcom,msm8996-tsens";
> +                       compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";

There's no point to adding this now because you already have to
support "qcom,msm8996-tsens".

>                         reg = <0x4a9000 0x1000>, /* TM */
>                               <0x4a8000 0x1000>; /* SROT */
>                         #qcom,sensors = <13>;
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index c981a40..abc8f13 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -69,8 +69,15 @@ static const struct tsens_ops ops_v2 = {
>         .get_temp       = get_temp_tsens_v2,
>  };
>
> +const struct tsens_data data_tsens_v2 = {
> +       .ops            = &ops_v2,
> +};
> +
> +/* Kept around for backward compatibility with old msm8996.dtsi.
> + * New platforms should use data_tsens_v2 if possible and define
> + * the #qcom,sensors property in DT.

Hum, I think this should just be implied by the compatible as it was.
If this was the *only* difference, then a property would be okay, but
as soon as you find some other difference you need yet another
property and have to do a DT update on all platforms.

> + */
>  const struct tsens_data data_8996 = {
>         .num_sensors    = 13,
>         .ops            = &ops_v2,
>  };
> -
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 3440166c..a2c9bfa 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -72,6 +72,9 @@ static const struct of_device_id tsens_table[] = {
>         }, {
>                 .compatible = "qcom,msm8996-tsens",
>                 .data = &data_8996,
> +       }, {
> +               .compatible = "qcom,tsens-v2",
> +               .data = &data_tsens_v2,

Why different data if 8996 is compatible with v2?

>         },
>         {}
>  };
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index dc56e1e..69212cb 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -87,6 +87,9 @@ void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
>  int init_common(struct tsens_device *);
>  int get_temp_common(struct tsens_device *, int, int *);
>
> -extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
> +/* TSENS v1 targets */
> +extern const struct tsens_data data_8916, data_8974, data_8960;
> +/* TSENS v2 targets */
> +extern const struct tsens_data data_8996, data_tsens_v2;
>
>  #endif /* __QCOM_TSENS_H__ */
> --
> 2.7.4
>

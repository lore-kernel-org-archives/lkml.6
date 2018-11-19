Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7682C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87E5208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pwln0nkK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pwln0nkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87E5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeKSVbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:31:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43606 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeKSVbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:31:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 828BC60B26; Mon, 19 Nov 2018 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542625705;
        bh=8OXYrPMTiTW8NDzFvFM0CMJ8a7uuECoJgB97wfy8vcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pwln0nkKhACRn4tcNgcoDA/Iq88dgXIChohnyuJpUSUfX5WuJJ9HU9s47LXeQimIx
         JsxYn85ItMshz5xecSJSA/0PK7wnVOkZwGHTxIlojADqx8m+/SMu40dwryojn9QYDv
         A13f6ijQL3LWnKAlTv4Jeu9R1Ggusf+fLqIf0PHE=
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 061C860767;
        Mon, 19 Nov 2018 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542625705;
        bh=8OXYrPMTiTW8NDzFvFM0CMJ8a7uuECoJgB97wfy8vcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pwln0nkKhACRn4tcNgcoDA/Iq88dgXIChohnyuJpUSUfX5WuJJ9HU9s47LXeQimIx
         JsxYn85ItMshz5xecSJSA/0PK7wnVOkZwGHTxIlojADqx8m+/SMu40dwryojn9QYDv
         A13f6ijQL3LWnKAlTv4Jeu9R1Ggusf+fLqIf0PHE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 061C860767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f175.google.com with SMTP id q1so47795417qkf.13;
        Mon, 19 Nov 2018 03:08:24 -0800 (PST)
X-Gm-Message-State: AGRZ1gKC9raqBk8P1x6amYD4t2RSktfVo5AJOW8FODjLE3SD3ZXEviqL
        pRRoHAfExGE836e7CziqIzatVDH1ZdAGHeOuVNw=
X-Google-Smtp-Source: AJdET5fGM7cdx2hdIblD7FEUS3UvR2JmF3CXZ0nCLPw7pkhNcj3empMzWx8sdOV6nYGkFv0vijCd3vzHIMJzmfXbRJs=
X-Received: by 2002:a0c:c60b:: with SMTP id v11mr20960794qvi.198.1542625704255;
 Mon, 19 Nov 2018 03:08:24 -0800 (PST)
MIME-Version: 1.0
References: <1542619537-24038-1-git-send-email-todor.tomov@linaro.org>
In-Reply-To: <1542619537-24038-1-git-send-email-todor.tomov@linaro.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 19 Nov 2018 16:38:10 +0530
X-Gmail-Original-Message-ID: <CAFp+6iG3bRoyFtfd60SO9t=upjcH+fQm1NAOMTvMpYnk5dHjFw@mail.gmail.com>
Message-ID: <CAFp+6iG3bRoyFtfd60SO9t=upjcH+fQm1NAOMTvMpYnk5dHjFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996: Add VFE SMMU node
To:     todor.tomov@linaro.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todor,

On Mon, Nov 19, 2018 at 2:57 PM Todor Tomov <todor.tomov@linaro.org> wrote:
>
> Add VFE SMMU node.
>
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>
> This patch depends on patchset:
> https://lore.kernel.org/patchwork/cover/1013166/
>
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 13bb964..a4d087e5 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -950,6 +950,23 @@
>                         };
>                 };
>
> +               vfe_smmu: arm,smmu@da0000 {
> +                       compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> +                       reg = <0xda0000 0x10000>;
> +
> +                       #global-interrupts = <1>;
> +                       interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
> +                       power-domains = <&mmcc MMAGIC_CAMSS_GDSC>;
> +                       clocks = <&mmcc SMMU_VFE_AHB_CLK>,
> +                                <&mmcc SMMU_VFE_AXI_CLK>;
> +                       clock-names = "iface",
> +                                     "bus";
> +                       #iommu-cells = <1>;
> +                       status = "ok";

No point of adding this status here.
Rest looks good to me.

Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

> +               };
> +
>                 agnoc@0 {
>                         power-domains = <&gcc AGGRE0_NOC_GDSC>;
>                         compatible = "simple-pm-bus";
> --
> 2.7.4
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

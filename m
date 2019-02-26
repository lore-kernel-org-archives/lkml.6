Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C91CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C752218D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="elbogRHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfBZXzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:55:01 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44193 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZXzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:55:00 -0500
Received: by mail-vk1-f196.google.com with SMTP id w85so1543619vkw.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxU7Hql5c5YDsxbkfitxRNHdPf44wrr5CZ3/zjqgoUM=;
        b=elbogRHTpoFzOGMbAF7cpmf2vgfX9CJO15FRA3CJwgSp/txVgDSBKO7fxJagSq/EfR
         FGKeQtBS3PCkv7YfRy+HG6rGklDQcy08EPPYuoYQGestnPDyWkDBdEHzhzgQ+hmXCoKE
         33ZvLAcGhsSqF3rWPtP/SXAul8Y7BsW76oyQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxU7Hql5c5YDsxbkfitxRNHdPf44wrr5CZ3/zjqgoUM=;
        b=LS8cp4hPye1mpBGYgSSuG/6DsrFHFKfoceXYDEn5a28AH4dhOEgrTSpKS3rB5ss/hW
         0hFoNcELy8R9Nqr0dwXte+q3M3ngir3g1DC2Zbj8BeWDN63JmwunHQGoT/pcoLAuYXGD
         Nn3dGKzUN37fq4mcT20xxknms44CxG+Z123YgXjtObXJVn8WzIU5g2/ULMbC0d1fE6ma
         Yn0893W079S5l2kHdpXYO9re1lgMB6c6homR4J92+41twjsE7daeE99dEVM3b5QQ28Px
         bzFZV7Hh9Nq+MmmQo6vSsnybBVoIGUsGxpEASaz5lTrNgkPjJNymtZlbm5qoH7C2E3nW
         S2eg==
X-Gm-Message-State: AHQUAuZf1qgl+750BpGhcGx4JRzXirdWVuM7ra+8f6+mFWGG3aMydK9r
        PMe3mmK7JB+kZ50i2SdG66gtM2owEBw=
X-Google-Smtp-Source: AHgI3IZMMsB1U+iY0odxrfgWXBZU1VzvrtXHZExDERbo8CY78YLcVeBN3j3elGY8CJJTM+eunhRO6g==
X-Received: by 2002:a1f:a986:: with SMTP id s128mr13873114vke.53.1551225299024;
        Tue, 26 Feb 2019 15:54:59 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id j4sm11564740vke.0.2019.02.26.15.54.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 15:54:57 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id g1so2802178uae.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:54:57 -0800 (PST)
X-Received: by 2002:a67:f701:: with SMTP id m1mr228002vso.87.1551225297306;
 Tue, 26 Feb 2019 15:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20190206051335.23799-1-bjorn.andersson@linaro.org> <20190206051335.23799-9-bjorn.andersson@linaro.org>
In-Reply-To: <20190206051335.23799-9-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Feb 2019 15:54:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQwsKq1TujmmmR-OiSpMvUp_0b4Vi4Rh9TMGoKgkkkCQ@mail.gmail.com>
Message-ID: <CAD=FV=UQwsKq1TujmmmR-OiSpMvUp_0b4Vi4Rh9TMGoKgkkkCQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 5, 2019 at 9:13 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> From: Sibi Sankar <sibis@codeaurora.org>
>
> This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v5:
> - None
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 560c16616ee6..5c41f6fe3e1b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1612,6 +1612,64 @@
>                         };
>                 };
>
> +               mss_pil: remoteproc@4080000 {
> +                       compatible = "qcom,sdm845-mss-pil";
> +                       reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
> +                       reg-names = "qdsp6", "rmb";

I found that when I disabled IOMMU bypass by booting with
"arm-smmu.disable_bypass=y" that I'd get this failure:

---

[   13.633776] qcom-q6v5-mss 4080000.remoteproc: MBA booted, loading mpss
[   13.647694] arm-smmu 15000000.iommu: Unexpected global fault, this
could be serious
[   13.660278] arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0
0x00000000, GFSYNR1 0x00000781, GFSYNR2 0x00000000
...
[   14.648830] qcom-q6v5-mss 4080000.remoteproc: MPSS header
authentication timed out
[   14.657141] qcom-q6v5-mss 4080000.remoteproc: port failed halt
[   14.664983] remoteproc remoteproc0: can't start rproc
4080000.remoteproc: -110

---

Adding "iommus = <&apps_smmu 0x781 0>;" here fixed my problem.  NOTE
that I'm no expert on IOMMUs so you should confirm that this is right,
but if it is then maybe you could include it in the next spin of the
series?  I got the "0x781" just by looking at the value of the GFSYNR1
in the above splat.  I wasn't sure what to put for the mask so I put
0x0.


-Doug

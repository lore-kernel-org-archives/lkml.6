Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A1C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579D20864
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NIfbw4Vo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GAsHe3k4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2579D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGLRG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:06:27 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:37052 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeGLRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:06:26 -0400
Received: by mail-vk0-f67.google.com with SMTP id h22-v6so16708190vke.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BgmghD58pIPL5wPT3SuyKjB78NLcnFVQc5h2H7+QeYg=;
        b=NIfbw4VozRrA5mFGRe/OaJJJiWhQn3zDsiq/Djm21+Ziqp5zJV/PIs263bQaDs00HG
         Utd1PTJ+51h28UD02G1qnQ6OoIjktdl0QF6AL1oW/3pW3cxzSWuHwsiXm/PJzNhd0JNM
         di4fkxGeE+rHRq1uGIOrvAjqWpwk9WeJceUOVTZi7tQzgTy0XtapES7dmKkuu9RaudoS
         wmJ205L/6h2HWgrDkhpCz0KG/YMPc6hpatQpel4UhEGIbCT92Nh/vG/OyeYnx+fjzROr
         VnEJcAhZbohksyUF3SZLV09VsgBXJH+pcsZxwVN+hVCp5eLChUQvCM82eSE69Zyb1prY
         9/9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BgmghD58pIPL5wPT3SuyKjB78NLcnFVQc5h2H7+QeYg=;
        b=GAsHe3k4ZrSil9Bh2yaFi/r5X1OpHYEY0lLoIGPwsXdDm/P+CEJI8aUgOrZVxU9iiO
         87cLDk0MsMWuMbd43/j0kaK5lfG0aFGVJKpW2d4FXoBYa8p9cDIKzK+jzTh+xCs+11zA
         1C2ZzPqs3+pm0W5R5RRW1OA0si+Gj2gOxP/Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BgmghD58pIPL5wPT3SuyKjB78NLcnFVQc5h2H7+QeYg=;
        b=NcQ9s9dxsK9YYK5l50Sxh+e0TOE1SE+IC1nCHwpuha5okODj86okQXL73dZnyoPMJJ
         MJ1gKPp7OmcHTykUqjGQawe0PM45me4n6hIxtmPg28zkVL+hxueFniF6GzJxty5iLqwi
         ia3Qmqxumu4tDjbXvkDw3fxkaHF4dyY7YzCEQE+jJI37IzyCXO6BBrgwKwsdU/AlLnr2
         htQLNQxXXd4nmqGFF5U4rvslzxPclHlNVud5BlV2Efn2O0Ous0lVR970/hEUm1mEjhxT
         oyJl0IUNsNDDUhMkWtWc+fjae/iHchSbu/his5S8Uyn/58eIFIAIRSVo90kWiJW9EBKp
         o2lw==
X-Gm-Message-State: AOUpUlE8RfmODXpEee9NjIsS0+owVZW6WPt6EXURYU+0ByAY4oUW+qp7
        3Ls0WnlT90Ux8TloNRwfvked5mtT12Hz1Hs/3EcL7w==
X-Google-Smtp-Source: AAOMgpfTGFTikPlqnvYeVKS8Mct45/+5Qlkb8kYZM33SO15bCpy24boy2TlKDVyVIEgIFU3AwZw5mhaIFm+/HHmuFzg=
X-Received: by 2002:a1f:c014:: with SMTP id q20-v6mr1820557vkf.144.1531414563152;
 Thu, 12 Jul 2018 09:56:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 09:56:02
 -0700 (PDT)
In-Reply-To: <20180710220202.116404-2-dianders@chromium.org>
References: <20180710220202.116404-1-dianders@chromium.org> <20180710220202.116404-2-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 09:56:02 -0700
X-Google-Sender-Auth: htf1RUgmjsLz_N8Du1r_rqZviag
Message-ID: <CAD=FV=Xic0sUgWGKfXKMp8t1euRNx_T69bCSLB3XKtYtYaQ8jA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 10, 2018 at 3:02 PM, Douglas Anderson <dianders@chromium.org> wrote:
> From: Manu Gautam <mgautam@codeaurora.org>
>
> This adds nodes for USB and related PHYs.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> [dianders: reworked quite a bit]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 189 +++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 15188d34a2ab..1de59a39f4fa 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>
>  / {
> @@ -249,6 +250,18 @@
>                         #power-domain-cells = <1>;
>                 };
>
> +               qfprom@780000 {
> +                       compatible = "qcom,qfprom";
> +                       reg = <0x780000 0x8ff>;

I have later found that this should point to the "corrected" address
range, not the raw one.  Thus address should be 0x784000.

...still trying to get more details on the exact right length.


> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       qusb2p_hstx_trim: hstx-trim@1eb {
> +                               reg = <0x1eb 0x1>;
> +                               bits = <1 4>;
> +                       };

I've now found out the trim location for the secondary port.  Thus on
my next revision I'll add:

qusb2s_hstx_trim: hstx-trim-secondary@1eb {
  reg = <0x1eb 0x2>;
  bits = <6 4>;
};

Since this series isn't really ready for merging yet (see the cover
letter), I'll sit on these changes for now but I'll include them in
the next spin.


-Doug

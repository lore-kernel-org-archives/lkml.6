Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9BCC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D922145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OycqWoSA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BnKaSq51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D922145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeJRTfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:35:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJRTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:35:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 176D4605A4; Thu, 18 Oct 2018 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539862472;
        bh=CbrW3AtbOeQyfDx5PFSHslbPoc5F9SQy6NVuiHxz2g0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OycqWoSA6DoFXtqFPnTz/Urg2J775bMBm0l/jnG7lTAOCB8Z7juN/xNzfu48yli0h
         gf2rSSV9mNTZWqAqa6Bewb4iaCqtPkY/W7Oi4XQwAEOPFlJtOQUvGgTMlMk7xDYLKc
         E4+1zFinFt44lDLUcb4EfSu2am/4xgReJdSgKTCI=
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60B2F605A4;
        Thu, 18 Oct 2018 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539862471;
        bh=CbrW3AtbOeQyfDx5PFSHslbPoc5F9SQy6NVuiHxz2g0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BnKaSq51qmGIknuOwziHMQTcZ8foBH6Yf0IFh+yzfHEOfJOxqS40Hl2g+OVic0IuJ
         aGeqq/1rXWwCOIROuwWDvnYHl/enSPpiKcPQpGQtT6OxyIMXQ2GClqjFOUNFxgrmWc
         aGxA9ZGvq/YbQ0RyyMajyuVMKFgopFUz94myo3Iw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60B2F605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f181.google.com with SMTP id q41-v6so33726567qtq.10;
        Thu, 18 Oct 2018 04:34:31 -0700 (PDT)
X-Gm-Message-State: ABuFfoh5RdUUUr+FGxu3ZpSKrG0nRWPYgOAQoh9hO0honvyendR/vLBK
        4hhd91p04mcziFoMJgiGyHQB1jgvkatjvGVLk6Y=
X-Google-Smtp-Source: ACcGV60O4WFN2d/op+6xu7HGCACQRcHCm7fH3B5qWkA9sJ34gmSNIfss/LSdA7eJU/dYpcFxNwRQ0u0SlcqZZAAGar8=
X-Received: by 2002:a0c:871a:: with SMTP id 26mr29528423qvh.29.1539862470685;
 Thu, 18 Oct 2018 04:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181017172312.194281-1-evgreen@chromium.org> <20181017172312.194281-3-evgreen@chromium.org>
In-Reply-To: <20181017172312.194281-3-evgreen@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 18 Oct 2018 17:04:18 +0530
X-Gmail-Original-Message-ID: <CAFp+6iExBJu06=mx12za=Hxsp+GKzQ2vAD-JRiC3PkhDcRo0yA@mail.gmail.com>
Message-ID: <CAFp+6iExBJu06=mx12za=Hxsp+GKzQ2vAD-JRiC3PkhDcRo0yA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
To:     evgreen@chromium.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, swboyd@chromium.org,
        Doug Anderson <dianders@chromium.org>,
        Can Guo <cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:55 PM Evan Green <evgreen@chromium.org> wrote:
>
> From: Can Guo <cang@codeaurora.org>
>
> This change enables the UFS host controller and PHY on sdm845-mtp.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> I was unable to test this on an MTP, if somebody could give this a try I would
> be grateful. This applies atop agross/for-next, since it needs the regulators.
>
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index eedfaf8922e2..d5fddea71a85 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -356,6 +356,20 @@
>         status = "okay";
>  };
>
> +&ufshc1 {
> +       status = "okay";
> +
> +       vcc-supply = <&vreg_l20a_2p95>;
> +       vcc-max-microamp = <600000>;
> +};
> +
> +&ufsphy1 {
> +       status = "okay";
> +
> +       vdda-phy-supply = <&vdda_ufs1_core>;
> +       vdda-pll-supply = <&vdda_ufs1_1p2>;
> +};
> +
>  &usb_1 {
>         status = "okay";
>  };
> --
> 2.16.4
>

Looks good.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

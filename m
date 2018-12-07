Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C653C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB0920892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K380iksP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N4KY/U+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB0920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLGIcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:32:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:32:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7B4960B26; Fri,  7 Dec 2018 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544171540;
        bh=rqT7Le9hsgJsxxRAte+GCUuGqa9MC3U0Zh1btns9Mh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K380iksPmtjmjXbJcOBlD43rlsFqT7OxWL5UN9nUTh18s+Bh0QGTZ9ZUHgtdvz6sO
         llk1ltRNS9QLPPKKxgmI8Bf+lpECmT4yDnDLmZ9bHSxtUqkOc3QEGmkSNAc73oNX25
         eIyL+y161/xTFpFctN8wfqebwqEIF7MepRaFhnbI=
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65746606DD;
        Fri,  7 Dec 2018 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544171539;
        bh=rqT7Le9hsgJsxxRAte+GCUuGqa9MC3U0Zh1btns9Mh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N4KY/U+sUGgz+G8wX+UPxeh8BkVPitu6XWXJCA73A5nSRaFWROy/A8ZWMNtM0UG1V
         7aDpCXby/kCRLnxx+vz0tTp3Cih7g4XtCeFYw1VnmH+llMxtENUfJA5IvKuETaZbgL
         KUpK5RIhoZA5TlELOQ849/gFD2U5flx1QxFrOw08=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65746606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f172.google.com with SMTP id k12so3599350qtf.7;
        Fri, 07 Dec 2018 00:32:19 -0800 (PST)
X-Gm-Message-State: AA+aEWaghOK0UdpI9vrRbg98+m5i26KyAneCpBIdKtqT3r4N/78yIWI0
        rd+bwN4UEtI87k4yhTE0Hmzcxs6ouy+94+2gyE4=
X-Google-Smtp-Source: AFSGD/VlxpcsXQWwvmg3RkPGU3e7kWJxO6ldh0bVLT5DDT7Of9u/cdpvr8Ay251cad35bT2E6ivTXtoSD2Ia9mFurhk=
X-Received: by 2002:ac8:3e1a:: with SMTP id z26mr1161859qtf.180.1544171538667;
 Fri, 07 Dec 2018 00:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20181129221357.67417-1-evgreen@chromium.org> <20181129221357.67417-3-evgreen@chromium.org>
In-Reply-To: <20181129221357.67417-3-evgreen@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 7 Dec 2018 14:02:06 +0530
X-Gmail-Original-Message-ID: <CAFp+6iF5mVAdKn3FxodoEp9DAbtDYbsNFVFbwsiSP0fsAMom1w@mail.gmail.com>
Message-ID: <CAFp+6iF5mVAdKn3FxodoEp9DAbtDYbsNFVFbwsiSP0fsAMom1w@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
To:     evgreen@chromium.org
Cc:     kishon <kishon@ti.com>, "robh+dt" <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 3:45 AM Evan Green <evgreen@chromium.org> wrote:
>
> Move #clock-cells into the child node and set it to 0 to conform to the
> proper binding specification.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 13bb96444df00..4af740ca0880f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -767,7 +767,6 @@
>                 phy@34000 {
>                         compatible = "qcom,msm8996-qmp-pcie-phy";
>                         reg = <0x34000 0x488>;
> -                       #clock-cells = <1>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
> @@ -790,6 +789,7 @@
>                                 reg = <0x035000 0x130>,
>                                         <0x035200 0x200>,
>                                         <0x035400 0x1dc>;
> +                               #clock-cells = <0>;
>                                 #phy-cells = <0>;
>
>                                 clock-output-names = "pcie_0_pipe_clk_src";
> @@ -803,6 +803,7 @@
>                                 reg = <0x036000 0x130>,
>                                         <0x036200 0x200>,
>                                         <0x036400 0x1dc>;
> +                               #clock-cells = <0>;
>                                 #phy-cells = <0>;
>
>                                 clock-output-names = "pcie_1_pipe_clk_src";
> @@ -816,6 +817,7 @@
>                                 reg = <0x037000 0x130>,
>                                         <0x037200 0x200>,
>                                         <0x037400 0x1dc>;
> +                               #clock-cells = <0>;
>                                 #phy-cells = <0>;
>
>                                 clock-output-names = "pcie_2_pipe_clk_src";
> @@ -829,7 +831,6 @@
>                 phy@7410000 {
>                         compatible = "qcom,msm8996-qmp-usb3-phy";
>                         reg = <0x7410000 0x1c4>;
> -                       #clock-cells = <1>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
> @@ -851,6 +852,7 @@
>                                 reg = <0x7410200 0x200>,
>                                         <0x7410400 0x130>,
>                                         <0x7410600 0x1a8>;
> +                               #clock-cells = <0>;
>                                 #phy-cells = <0>;
>
>                                 clock-output-names = "usb3_phy_pipe_clk_src";
> --
> 2.18.1
>

Tested on db820c [1]
Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>

[1] https://github.com/vivekgautam1/linux/tree/origin/v4.20-rc5/db820c

BRs
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B25AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463D421855
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ozSWl/R0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pDNpVsFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfAHGka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:40:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfAHGka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:40:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E9276050D; Tue,  8 Jan 2019 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546929629;
        bh=MVho/2/pXvIxyi4LGk2mgoq1NAd6U9SihzBAlNuyaDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ozSWl/R0Cm6bPzhE48ONLCm53kmIFs1q5aPrDdRT+CheWQkqTr+sMPfFZR8YH3BGe
         YGRRODwQ4WIIvUv8QXkjXCI0pvfSSi79c7WvaeNz13SgJA9lgqQQHeJQKgKc/DVVYJ
         MEkAH7ai0PTY1NzjcLMMPIHAYTSUT3F39GZLFYs0=
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91C9160300;
        Tue,  8 Jan 2019 06:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546929628;
        bh=MVho/2/pXvIxyi4LGk2mgoq1NAd6U9SihzBAlNuyaDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDNpVsFL3XxdPJJYrV9tUmIE8Edh5IVn8S5xqEJ+no/Ax92N61usvBGk9Xe4ZOC5b
         NXCFZJG4UASetqs4+EfmGzVaRlo1aMjQYJY5dwTgsBxYqr9c+R38qQBekA9YFfBMPz
         VxZJsvlKVizyzDY6xQmmtsS1+iOySlqyCqaW7qKk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91C9160300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f182.google.com with SMTP id d19so3251517qtq.9;
        Mon, 07 Jan 2019 22:40:28 -0800 (PST)
X-Gm-Message-State: AJcUukc3Pj1nKcJtaxEBRYtu4hJUljEAZgyDrRID/F3Iiwdl8CKhy+AT
        FD004YnynBJgoMKofIvU1O0ryaDUyfc+odseJXw=
X-Google-Smtp-Source: ALg8bN7JKOJGBkXuVixk+XPqI4grgmRa656yTrecUF1fMcVoBF0nQ+tm0tVehoP7dgGPpeSKw3wO2wdglJMFqKTxnOY=
X-Received: by 2002:a0c:afd1:: with SMTP id t17mr516684qvc.93.1546929627882;
 Mon, 07 Jan 2019 22:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20190103103538.30970-1-mgautam@codeaurora.org>
In-Reply-To: <20190103103538.30970-1-mgautam@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 8 Jan 2019 12:10:16 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGDz4WGHyMYP1W0XbSJnL7s-sGBdb1YZ4+iaO59tBqUuA@mail.gmail.com>
Message-ID: <CAFp+6iGDz4WGHyMYP1W0XbSJnL7s-sGBdb1YZ4+iaO59tBqUuA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: msm8996: Disable USB2 PHY suspend by core
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 6:18 PM Manu Gautam <mgautam@codeaurora.org> wrote:
>
> QUSB2 PHY on msm8996 doesn't work well when autosuspend by
> dwc3 core using USB2PHYCFG register is enabled. One of the
> issue seen is that PHY driver reports PLL lock failure and
> fails phy_init() if dwc3 core has USB2 PHY suspend enabled.
> Fix this by using quirks to disable USB2 PHY LPM/suspend and
> dwc3 core already takes care of explicitly suspending PHY
> during suspend if quirks are specified.
>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---

This works well for db820c [1].
Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>

[1] https://github.com/vivekgautam1/linux/commits/origin/v4.20-rc5/db820c

Best regards
Vivek

>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index b29fe80d7288..1f14ca35afc2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -911,6 +911,8 @@
>                                 interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
>                                 phys = <&hsusb_phy2>;
>                                 phy-names = "usb2-phy";
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_enblslpm_quirk;
>                         };
>                 };
>
> @@ -940,6 +942,8 @@
>                                 interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
>                                 phys = <&hsusb_phy1>, <&ssusb_phy_0>;
>                                 phy-names = "usb2-phy", "usb3-phy";
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_enblslpm_quirk;
>                         };
>                 };
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

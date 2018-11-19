Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3F320831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="S0wmaWyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3F320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeKSWYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:24:47 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38500 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbeKSWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:24:46 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so17577971vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXBVrsV5JAHhgnBtG/5FrtfF8E4oWwctFUvnEZc094E=;
        b=S0wmaWyPgwqd0yW6R6qmj7vQU3fFOn2ItQYwjHGcpxuEKwo6qwfhiNSP6QLtFJ7uIj
         AQo9ljiuxci+9hvCSbv2KUOv6ocXS/TG46LqQbJF/LC8JJPva+OeCciBvWL/mGYgyM7g
         6fTRpSIjX3rcYooKmfZRNSEGndD9TdGXyzxkj/C9GGIz+4DP+p8HSY/d/q7dwbH7B64l
         z/8U4Oo4oyGzHRCMHtOAugxI5Tr2CtSK2yqv6iiGs5HTTQnjF+OVgBoTNs8Hm0SrvnT4
         f13FsxW/C3O9cZ5/czIDPojzVY68EPPYMc1pG8TgMpws7MTcE+3KX0bo12g3SKkj0Kpa
         pUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXBVrsV5JAHhgnBtG/5FrtfF8E4oWwctFUvnEZc094E=;
        b=ZrrXDCq/K+QBoDJGIvEgX87dShGDIVzhUJCFnxjuw9lQ9SbEaDjd+zFB8x/lZ6L88s
         vE2/y2zp440DnbaI36Z0dtatxxCZtew+JukbwtUcn3UfrcyxtNl/DGNpypegdVXq+/UR
         +JfosU/pH8sc+rZrxmeezVJq+xWnbA90MJuZpSFRwcVCBKZJVdvRan+UiDfDMYZ4obUi
         BlcMx0qilJhfvhzBeK7zkcz2LIDsYdPNTrzu8BGYx4eoD/0hEq0g66aZqXayTEq5XfQl
         N+7NOaYdm/nFGondpkL0fYCPVr1xom/wuG3nO/3qya4HrqRxwusATRtmRij3NT3H4mcw
         7LNw==
X-Gm-Message-State: AGRZ1gJYx/BNNxBz9q3lcU8u6gG228EMKCWOXtnYdBYkee1aHjR+VIS4
        o6DL6T6b6ynjPGltPo1kG1hBStw+1btWddHr0bsBog==
X-Google-Smtp-Source: AJdET5d0yO61sGzIgovSEQTrRLL/RJo5Hthi3FvQiPThncEUfXyIH2ziS0Oo4yeqkGhRCIaB8aJRz83n/k63+iTkOTk=
X-Received: by 2002:a67:e0d4:: with SMTP id m20mr9075403vsl.182.1542628880520;
 Mon, 19 Nov 2018 04:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20181109094417.12109-1-vkoul@kernel.org> <20181109094417.12109-3-vkoul@kernel.org>
In-Reply-To: <20181109094417.12109-3-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 19 Nov 2018 17:31:08 +0530
Message-ID: <CAHLCerMiJMsRh20S3KPqgT6XKFLyZF0jG5HVVVW4e8b-RkfSzA@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] arm64: dts: qcom: qcs404-evb: add dts files for EVBs
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 3:15 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> QCS404 has two EVBs, EVB-1000 and EVB-4000. These boards are mostly
> similar with few differences in the peripherals used.
>
> So use a common qcs404-evb.dtsi which contains the common parts and use
> qcs404-evb-1000.dts and qcs404-evb-4000.dts for diffs
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/Makefile            |  2 ++
>  arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 14 ++++++++++++++
>  4 files changed, 38 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index a658c07652a7..21d548f02d39 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -8,3 +8,5 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8998-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sdm845-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-1000.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-4000.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
> new file mode 100644
> index 000000000000..2c14903d808e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +/dts-v1/;
> +
> +#include "qcs404-evb.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
> +       compatible = "qcom,qcs404-evb";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
> new file mode 100644
> index 000000000000..11269ad3de0d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +/dts-v1/;
> +
> +#include "qcs404-evb.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
> +       compatible = "qcom,qcs404-evb";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> new file mode 100644
> index 000000000000..91ecbdf0ecda
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include "qcs404.dtsi"
> +
> +/ {
> +       aliases {
> +               serial0 = &blsp1_uart2;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0";
> +       };
> +};
> --
> 2.14.4
>

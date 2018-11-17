Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32ADC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 23:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656E92080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 23:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZaXUsK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656E92080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeKRJ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 04:29:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40246 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeKRJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 04:29:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id x2-v6so13067366pfm.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 15:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrJV5F3NN6K/YcoJwQ11P4Md/S4+jBJE3I81yUaWHiE=;
        b=FZaXUsK99u7gUBHN4bMPQLQWrjjlm7waX+ZSIbx6UnU8AqJYMew+Z3I4iS+26dQLec
         Qu0ZsUTEVDWl1DI+J3uQar0Ye8KKfZRrKhdNNmoxvOXM5FebUXp4m97EWl7zSMYa2uFT
         fNP1VMY4+UaSKv/849Hhr7MTJ1NMykEVjFvs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrJV5F3NN6K/YcoJwQ11P4Md/S4+jBJE3I81yUaWHiE=;
        b=E1+XX1bL1YnVKAkDEnyqERmvn2rJ8SQv9AS6Vq+PUsQ3IK74PuMIjHvFJQYYWEjA1r
         f3+2hl/Shn6KO/R7BFZLb2Wn7vNjCW7/qOJocwA9BAdNu8tMHCb+OgBPVgSyuyeH/6Dv
         YsL9wLZc4fZMxISH8NgCSjm/+bxEqOlhzpR9lhtCle2mlK3rwnCcolohfXWcZwu1RAsT
         aJ/mmZ0RyTUMNPrZONZYDT3NtfFEMy6c/Sl/liBWnL3migeiMqeWISEGTVcmo04PCYtP
         eJXZbj13mDWOeNSK7KVnazJ/Jxk6FR2RFVIK1BCT30KFrbucNu+55Mmeu0t7+2GNJxqN
         FHUA==
X-Gm-Message-State: AGRZ1gLHj5wKH/m1QNwZ4u3v2KJYgzZYiHtCyjHkSc69NZREHSS3WYqS
        I4kZT5E+sGjiIa8cgmANDV8ilA==
X-Google-Smtp-Source: AJdET5fCmBddXufZChce7hmNoGZf4ii7uvYWxM6slLCA75vN2KE+HHWVpGaQFisoSMFShnXFSa39Hw==
X-Received: by 2002:a63:cd4c:: with SMTP id a12mr15256679pgj.252.1542496291295;
        Sat, 17 Nov 2018 15:11:31 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v191sm42370092pgb.77.2018.11.17.15.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 15:11:30 -0800 (PST)
Date:   Sat, 17 Nov 2018 15:11:28 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 02/18] arm64: dts: qcom: qcs404-evb: add dts files for
 EVBs
Message-ID: <20181117231128.GB2225@minitux>
References: <20181109094417.12109-1-vkoul@kernel.org>
 <20181109094417.12109-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109094417.12109-3-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Nov 01:44 PST 2018, Vinod Koul wrote:

> QCS404 has two EVBs, EVB-1000 and EVB-4000. These boards are mostly
> similar with few differences in the peripherals used.
> 
> So use a common qcs404-evb.dtsi which contains the common parts and use
> qcs404-evb-1000.dts and qcs404-evb-4000.dts for diffs
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
> @@ -8,3 +8,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
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
> +	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
> +	compatible = "qcom,qcs404-evb";
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
> +	model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
> +	compatible = "qcom,qcs404-evb";
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
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +};
> -- 
> 2.14.4
> 

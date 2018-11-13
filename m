Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16821C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45A2224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45A2224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeKMKPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:15:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45753 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeKMKPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:15:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so488053plm.12;
        Mon, 12 Nov 2018 16:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0vQYrMta29H72nRt69LXdi5qOr98htsRSDQQQ4AqXE=;
        b=r1pzaTFVoCOmdm0m/i07hdUINFMqwwmxFABQQ0ywcmHgkPS2o4/l0jrhCAw3X4342O
         vv8vcoIMWxl9+KYXYVuvjdbwNpaQyBLLmvdOpePcgb6lcju8ur4zSOonwgYLW5yLj8SY
         JnsQZzD9LDE8xlp+TZALJmlYc2doFVKHojFC081c3rtJHvAvTE9fIiqfehPu0zFix70q
         75Zx+xNFL4rJVrBFEcLUWEfUVl/zr2LPI2sxLQJHEOW03Nuuv6vcbL2zpyTMaN8jLL5E
         RqGpnPRoP7NKrj7X7FGw6p4QqngG2Sl3LeSF90rzfmPOzstIOQnx52AyVpJL6YmFhNBV
         7nNA==
X-Gm-Message-State: AGRZ1gI8uDxyFu+O83TO/N82fe6JtZLsz8MbWOiHFQp/NJwX1oeT8Tvw
        QH1+hkAe8iSFp1oO3OXYOQ==
X-Google-Smtp-Source: AJdET5e4ndulpJsT6T9liOvOFBKOvTgxCsFhKq7AOkBjZSmR+19k92PcNcL4AaceDZuXbZCaV1t2og==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13-v6mr2959247plr.74.1542068393859;
        Mon, 12 Nov 2018 16:19:53 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id x194-v6sm25865714pfd.32.2018.11.12.16.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:19:53 -0800 (PST)
Date:   Mon, 12 Nov 2018 18:19:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: clock: Introduce QCOM LPASS clock
 bindings
Message-ID: <20181113001952.GA2556@bogus>
References: <1541814256-23254-1-git-send-email-tdas@codeaurora.org>
 <1541814256-23254-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541814256-23254-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 07:14:15AM +0530, Taniya Das wrote:
> Add device tree bindings for Low Power Audio subsystem clock controller for
> Qualcomm Technology Inc's SDM845 SoCs.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         | 16 +++++++++++++

Seems like a separate change?

>  .../devicetree/bindings/clock/qcom,lpasscc.txt     | 26 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sdm845.h        |  2 ++
>  include/dt-bindings/clock/qcom,lpass-sdm845.h      | 16 +++++++++++++
>  4 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>  create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> index 52d9345..8661c3c 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> @@ -35,6 +35,8 @@ be part of GCC and hence the TSENS properties can also be
>  part of the GCC/clock-controller node.
>  For more details on the TSENS properties please refer
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +- protected-clocks : Protected clock specifier list as per common clock
> + binding.
> 
>  Example:
>  	clock-controller@900000 {
> @@ -55,3 +57,17 @@ Example of GCC with TSENS properties:
>  		#reset-cells = <1>;
>  		#thermal-sensor-cells = <1>;
>  	};
> +
> +Example of GCC with protected-clocks properties:
> +	clock-controller@100000 {
> +		compatible = "qcom,gcc-sdm845";
> +		reg = <0x100000 0x1f0000>;
> +		#clock-cells = <1>;
> +		#reset-cells = <1>;
> +		#power-domain-cells = <1>;
> +		protected-clocks = <GCC_QSPI_CORE_CLK>,
> +				   <GCC_QSPI_CORE_CLK_SRC>,
> +				   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +				   <GCC_LPASS_Q6_AXI_CLK>,
> +				   <GCC_LPASS_SWAY_CLK>;
> +	};
> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> new file mode 100644
> index 0000000..b9e9787
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> @@ -0,0 +1,26 @@
> +Qualcomm LPASS Clock Controller Binding
> +-----------------------------------------------
> +
> +Required properties :
> +- compatible		: shall contain "qcom,sdm845-lpasscc"
> +- #clock-cells		: from common clock binding, shall contain 1.
> +- reg			: shall contain base register address and size,
> +			  in the order
> +			Index-0 maps to LPASS_CC register region
> +			Index-1 maps to LPASS_QDSP6SS register region

No input clocks?

> +
> +Optional properties :
> +- reg-names	: register names of LPASS domain
> +		 "cc", "qdsp6ss".
> +
> +Example:
> +
> +The below node has to be defined in the cases where the LPASS peripheral loader
> +would bring the subsystem out of reset.
> +
> +	lpasscc: clock-controller@17014000 {
> +		compatible = "qcom,sdm845-lpasscc";
> +		reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
> +		reg-names = "cc", "qdsp6ss";
> +		#clock-cells = <1>;
> +	};
> diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
> index b8eae5a..968fa65 100644
> --- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
> +++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
> @@ -197,6 +197,8 @@
>  #define GCC_QSPI_CORE_CLK_SRC					187
>  #define GCC_QSPI_CORE_CLK					188
>  #define GCC_QSPI_CNOC_PERIPH_AHB_CLK				189
> +#define GCC_LPASS_Q6_AXI_CLK					190
> +#define GCC_LPASS_SWAY_CLK					191
> 
>  /* GCC Resets */
>  #define GCC_MMSS_BCR						0
> diff --git a/include/dt-bindings/clock/qcom,lpass-sdm845.h b/include/dt-bindings/clock/qcom,lpass-sdm845.h
> new file mode 100644
> index 0000000..015968e
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,lpass-sdm845.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
> +#define _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
> +
> +#define LPASS_AUDIO_WRAPPER_AON_CLK			0
> +#define LPASS_Q6SS_AHBM_AON_CLK				1
> +#define LPASS_Q6SS_AHBS_AON_CLK				2
> +#define LPASS_QDSP6SS_XO_CLK				3
> +#define LPASS_QDSP6SS_SLEEP_CLK				4
> +#define LPASS_QDSP6SS_CORE_CLK				5
> +
> +#endif
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0797DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A588A25FAC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhsGeb35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A588A25FAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965770AbeF0Qow (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:44:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:47090 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965473AbeF0Qot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:44:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so1226527pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oWMZtCum+EDEPaCMIXYJqqfFFERcLLIAc5jJmeHZeSc=;
        b=QhsGeb35+FqpFb4PwBpiTlLnS0cjtWaUBy1+vZdscru7XmiGj8VOpHn4piL2Df46+Y
         wfQ/WgigFCJHsBbb/jyBzzXHZ/wJFPnjMSAnFcSqlucJJLsS+x2YwfXwCMr0WdS86Egb
         aLwbZJeL7gGwsaAkF6Prb7j62UmkI2b1kqthk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oWMZtCum+EDEPaCMIXYJqqfFFERcLLIAc5jJmeHZeSc=;
        b=i1P939q9ejlX2ns+Q5+BIkTaDzIO63ASbKYv+iyw7a27B/D7K1le+3DnhRyzOvan5z
         NdmpO3btCNvNam4kLhjzsgJ9LCNgstNrhR4LcAjgHIP4lOmC69zsudBeOZ/a2PmNmSAR
         +mWiZMInKDTCYZkG2vw5tzM5VftvG5HwtnRYAv1JA2FSC148qJvM98oHFhVyAtgn42sJ
         61g+ZixhdxPdeWxDdkcl0mVHB08hlSdrkBV5cywFTY5cMu6JUnloFlzy1DA77D/z25Rl
         oayCcxGBfhjAP2BgJkg7n2J9rrKqdFFvBsdCBcwWdEuVHJ38u5GKAM8bJlnSwXMFwrjm
         IxvA==
X-Gm-Message-State: APt69E2n2Kw41kQXB+xQDnjgBp993gQ5bQGnSSclNj3yHgLTDfERXOJG
        vimJ8U0YF6NTIprOgWpcihi3tw==
X-Google-Smtp-Source: ADUXVKKJRhXCX8hvzceouRA5Dpa+2ZqXvg2oXjah1fLUhTND7dO2SM3+T0lZeNljzN+FLKIg26Gy3w==
X-Received: by 2002:a63:4106:: with SMTP id o6-v6mr5969010pga.453.1530117888681;
        Wed, 27 Jun 2018 09:44:48 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n10-v6sm9903251pfb.27.2018.06.27.09.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 09:44:48 -0700 (PDT)
Date:   Wed, 27 Jun 2018 09:47:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, kyan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v6 1/8] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
Message-ID: <20180627164714.GK1860@tuxbook-pro>
References: <20180627142443.1570-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627142443.1570-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Jun 07:24 PDT 2018, Sibi Sankar wrote:

> Add SDM845 AOSS (always on subsystem) reset controller binding
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Not including Rob's earlier Reviewed-by due to change in compatible 
> 
>  .../bindings/reset/qcom,aoss-reset.txt        | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-aoss.h  | 17 ++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> new file mode 100644
> index 000000000000..510c748656ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> @@ -0,0 +1,52 @@
> +Qualcomm AOSS Reset Controller
> +======================================
> +
> +This binding describes a reset-controller found on AOSS-CC (always on subsystem)
> +for Qualcomm SDM845 SoCs.
> +
> +Required properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be:
> +		    "qcom,sdm845-aoss-cc"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the register
> +	            space.
> +
> +- #reset-cells:
> +	Usage: required
> +	Value type: <uint>
> +	Definition: must be 1; cell entry represents the reset index.
> +
> +Example:
> +
> +aoss_reset: reset-controller@c2a0000 {
> +	compatible = "qcom,sdm845-aoss-cc";
> +	reg = <0xc2a0000 0x31000>;
> +	#reset-cells = <1>;
> +};
> +
> +Specifying reset lines connected to IP modules
> +==============================================
> +
> +Device nodes that need access to reset lines should
> +specify them as a reset phandle in their corresponding node as
> +specified in reset.txt.
> +
> +For list of all valid reset indicies see
> +<dt-bindings/reset/qcom,sdm845-aoss.h>
> +
> +Example:
> +
> +modem-pil@4080000 {
> +	...
> +
> +	resets = <&aoss_reset AOSS_CC_MSS_RESTART>;
> +	reset-names = "mss_restart";
> +
> +	...
> +};
> diff --git a/include/dt-bindings/reset/qcom,sdm845-aoss.h b/include/dt-bindings/reset/qcom,sdm845-aoss.h
> new file mode 100644
> index 000000000000..476c5fc873b6
> --- /dev/null
> +++ b/include/dt-bindings/reset/qcom,sdm845-aoss.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_AOSS_SDM_845_H
> +#define _DT_BINDINGS_RESET_AOSS_SDM_845_H
> +
> +#define AOSS_CC_MSS_RESTART	0
> +#define AOSS_CC_CAMSS_RESTART	1
> +#define AOSS_CC_VENUS_RESTART	2
> +#define AOSS_CC_GPU_RESTART	3
> +#define AOSS_CC_DISPSS_RESTART	4
> +#define AOSS_CC_WCSS_RESTART	5
> +#define AOSS_CC_LPASS_RESTART	6
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

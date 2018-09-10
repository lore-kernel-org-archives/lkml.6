Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E46020658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E46020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeIKA5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:57:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34242 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbeIKA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:57:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so42762685ois.1;
        Mon, 10 Sep 2018 13:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x3k1ZWgvUVeVRr6iB0yWYi+Rz5ExPz+Kp6+cHT1SOCI=;
        b=KKzPX9DyEQtqay5cdStWTQydKAmlBR/UMqNEbu/CwVDmEtoyCBfAiltO71FAL+nchH
         4aTW0f2we4EnlNu8TQSlI1Mf3rkuOzxMIjb6SrdPAtj879k4DSM0U9nLXU5rqy0aDm+u
         iEprdXX/TArHjcU5bP0iDtN0XcTioXT0KwKak1yfQiy/F6ocHiysxcbm3aXsQHNaGOQL
         NqfIASlZ0Gyvyeg4JxY9cj+pdeQmyWenxtTelN21pziCTwEE838BPqLaE2OXkwLG0Tse
         +flG2ZHo7E+vVu/wWDa6fWaauOQiNwpcqZy6932GgMNDze31Olyrri4uexGylqMAvo8N
         0lLQ==
X-Gm-Message-State: APzg51B4hIjWEctJjNTZ/7x1XKOSAZSXV5xf3gbG/BGidw5luRgZkXCZ
        RyCJxL/cSHs9FjPN/d8Zf7RrtTQ=
X-Google-Smtp-Source: ANB0VdYv4J7meTMssP/iapjNBTHe/b3BbLF3Tkrzjqh/Ofns/bip3tr23F3JnPkhqBWAjjNPN3U+cw==
X-Received: by 2002:aca:6908:: with SMTP id e8-v6mr24670978oic.302.1536609684367;
        Mon, 10 Sep 2018 13:01:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w13-v6sm15595143oiw.51.2018.09.10.13.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:01:23 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:01:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v3 1/2] dt-binding: remoteproc: Add QTI ADSP PIL bindings
Message-ID: <20180910200122.GA16410@bogus>
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
 <1535975560-8200-2-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535975560-8200-2-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 05:22:39PM +0530, Rohit kumar wrote:
> Add devicetree bindings documentation file for Qualcomm
> Technolgies Inc ADSP Peripheral Image Loader.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../bindings/remoteproc/qcom,adsp-pil.txt          | 123 +++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> new file mode 100644
> index 0000000..f1c215a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> @@ -0,0 +1,123 @@
> +Qualcomm Technology Inc. ADSP Peripheral Image Loader
> +
> +This document defines the binding for a component that loads and boots firmware
> +on the Qualcomm Technology Inc. ADSP Hexagon core.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be one of:
> +		    "qcom,sdm845-adsp-pil"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the qdsp6ss register
> +
> +- interrupts-extended:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must list the watchdog, fatal IRQs ready, handover and
> +		    stop-ack IRQs
> +
> +- interrupt-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition:  List of phandle and clock specifier pairs

How many clocks?

> +
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: List of clock input name strings sorted in the same
> +				order as the clocks property.

What are the names?

> +
> +- power-domains:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to cx power domain node.
> +
> +- resets:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the reset-controller for the lpass

How many?

> +
> +- reset-names:
> +        Usage: required
> +        Value type: <stringlist>
> +        Definition: must be "pdc_sync" and "cc_lpass"
> +
> +- qcom,halt-regs:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: a phandle reference to a syscon representing TCSR followed
> +			by the offset within syscon for lpass halt register.
> +
> +- memory-region:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the reserved-memory for the ADSP
> +
> +- qcom,smem-states:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the smem state for requesting the ADSP to
> +		    shut down
> +
> +- qcom,smem-state-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "stop"
> +
> +
> += SUBNODES
> +The adsp node may have an subnode named "glink-edge" that describes the
> +communication edge, channels and devices related to the ADSP.
> +See ../soc/qcom/qcom,glink.txt for details on how to describe these.
> +
> += EXAMPLE
> +The following example describes the resources needed to boot control the
> +ADSP, as it is found on SDM845 boards.
> +	adsp-pil {
> +		compatible = "qcom,sdm845-adsp-pil";
> +
> +		reg = <0x17300000 0x40c>;
> +
> +		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +			"handover", "stop-ack";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			<&gcc GCC_LPASS_SWAY_CLK>,
> +			<&lpasscc LPASS_AUDIO_WRAPPER_AON_CLK>,
> +			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
> +			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +		clock-names = "xo", "sway_cbcr", "lpass_aon",
> +			"lpass_ahbs_aon_cbcr",
> +			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> +			"qdsp6ss_sleep", "qdsp6ss_core";
> +
> +		power-domains = <&rpmhpd SDM845_CX>;
> +
> +		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +		reset-names = "pdc_sync", "cc_lpass";
> +
> +		qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
> +
> +		memory-region = <&pil_adsp_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +	};
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

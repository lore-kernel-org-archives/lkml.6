Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B5FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ECD22B66
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ECD22B66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934120AbeGFUcn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:32:43 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36725 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeGFUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:32:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so25725604oie.3;
        Fri, 06 Jul 2018 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vC2LO6iNgylxIMIyVJHeNxVUiTIZ6PYxe1Z45t4toXI=;
        b=Pjgy7JA2cANGOB2E0/X3SyAP0N3n7jCWgnuAi/wEgwb79Kumec27OMMO5/nviWFq8c
         PonPsbJ99yRKfD6gX4KiExygYYK/qbYshdYA76HrMTX5nzSuIV5LDZunXq7sHL9q3qt5
         6phtjDF2y702sxnCrofUDvaPOQRdlN4gzHcprwTpjUav5w2gTUfmj5OgTdhQg4H2Y8n/
         Ooj+gtba9uirMwtDLuzMiuU+0G8X+M8GnYUvJsHGg1IvcOPPhOvLPX9LuD5SFsz79ax4
         8TxpIAtCBVtK9ML2SGqb4zwCEsf9iidvv1KA88SA4F1++v+koEbuhjZrWgg1XS4l4U17
         JMTA==
X-Gm-Message-State: APt69E3N2NMjssvotgwzxpJPpw+twFKRpMG50yRux+up8+ds2L3yl3ak
        6W+WZXRdvZxH+zsI40OuO86hwhE=
X-Google-Smtp-Source: AAOMgpcu68dIY+x0wUNDr8PaeOgMOuGLjEoBznasNCi64EUCZqbtlXqbdDAoXGLQ8UismErfNcBe4Q==
X-Received: by 2002:aca:3c45:: with SMTP id j66-v6mr11977626oia.118.1530909160051;
        Fri, 06 Jul 2018 13:32:40 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 203-v6sm14252190oic.28.2018.07.06.13.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:32:39 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:32:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        sbpata@codeaurora.org
Subject: Re: [PATCH v2] remoteproc: qcom: Introduce Non-PAS ADSP PIL driver
Message-ID: <20180706203236.GA24729@rob-hp-laptop>
References: <1530264053-8394-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530264053-8394-1-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:50:53PM +0530, Rohit kumar wrote:
> This adds APSS based ADSP PIL driver for QCOM SoCs.
> Added initial support for SDM845 with ADSP bootup and
> shutdown operation handled from Application Processor
> SubSystem(APSS).
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
> Changes since v1:
> - Used APIs from qcom_q6v5.c
> - Use clock, reset and regmap driver APIs instead of 
>   directly writing into the LPASS registers.
> - Created new file for non PAS ADSP PIL instead of extending
>   existing ADSP PIL driver.
> - cleanups as suggested by Bjorn and Rob.
> 
>  .../bindings/remoteproc/qcom,non-pas-adsp.txt      | 138 +++++

This should be a separate patch.

>  drivers/remoteproc/Kconfig                         |  18 +
>  drivers/remoteproc/Makefile                        |   1 +
>  drivers/remoteproc/qcom_nonpas_adsp_pil.c          | 667 +++++++++++++++++++++
>  4 files changed, 824 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
>  create mode 100644 drivers/remoteproc/qcom_nonpas_adsp_pil.c
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
> new file mode 100644
> index 0000000..0581aaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
> @@ -0,0 +1,138 @@
> +Qualcomm Technology Inc. Non PAS ADSP Peripheral Image Loader
> +
> +This document defines the binding for a component that loads and boots firmware
> +on the Qualcomm Technology Inc. ADSP Hexagon core.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be one of:
> +		    "qcom,sdm845-apss-adsp-pil"

Didn't Bjorn say to drop the 'apss' part?

> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the qdsp6ss
> +
> +- reg-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qdsp6ss"
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
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: List of clock input name strings sorted in the same
> +				order as the clocks property.
> +
> +- resets:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the reset-controller for the lpass
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
> +- cx-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the regulator to be held on behalf of the
> +		    booting Hexagon core
> +
> +- px-supply:
> +	Usage: optional
> +	Value type: <phandle>
> +	Definition: reference to the px regulator to be held on behalf of the
> +		    booting Hexagon core
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
> +The adsp node may have an subnode named either "smd-edge" or "glink-edge" that
> +describes the communication edge, channels and devices related to the ADSP.
> +See ../soc/qcom/qcom,smd.txt and ../soc/qcom/qcom,glink.txt for details on how
> +to describe these.
> +
> +
> += EXAMPLE
> +The following example describes the resources needed to boot control the
> +ADSP, as it is found on SDM845 boards.
> +	adsp-pil {
> +		compatible = "qcom,sdm845-apss-adsp-pil";
> +
> +		reg = <0x17300000 0x40c>;
> +		reg-names = "qdsp6ss";
> +
> +		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +			"handover", "stop-ack";
> +
> +		clocks = <&clock_rpmh RPMH_CXO_CLK>,
> +			<&lpasscc GCC_LPASS_SWAY_CLK>,
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
> +		cx-supply = <&pm8998_s9_level>;
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

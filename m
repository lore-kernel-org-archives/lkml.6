Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68400C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3822083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDUh88Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3822083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeFSWtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:49:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40924 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbeFSWsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:48:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so617495plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RrYICo2Bck6vVEZIUQSqgLGGXEIRPyHbZ5gJ7Irv4ME=;
        b=aDUh88Nw36YEpHYGHkFglNn3H8aFe473UYQGU9NSIzGldjFZDwOvaiIUMh+Srag5p/
         krMpNOnojpJvTCEQ6l2rR5olrePXbGiqDFCU4lxrOYplwjyOOO8AlPVkZUeyXYDQYTAH
         s63HS2RnEA11xTpPzm3wYOJEoFXYN7UXfEEtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RrYICo2Bck6vVEZIUQSqgLGGXEIRPyHbZ5gJ7Irv4ME=;
        b=Bo73jFenU3Q9hkkUYd0UxL15N7bBRAJtVZePyXy0HpE/ZcgD1yV67kgWFdtkgKsk2+
         wwToh3d5aVBMGT2SIH1tfkV0KkHXcOQGJUCRLkL6dfm0m00MbFf9/mqzUXN23u+JVCTq
         QI8pzUWji96repePLwVFQhXgrgRPW9dSF/oRAFrQUIswQYXDABqFEznkfLLIYXNQftJh
         Kn4zl9RPZAiAf2CHmUdu5/wSXtpseiRTlmeihzFarmsjQPwif1eRGoslHicGGpEqySwp
         Mzk7rg8Vi6rb50Vz7B4wZd+9JFlCmJT0HK3v6kOv/680n9zj1FrNMb6FTPWLw8hOTshG
         WKQA==
X-Gm-Message-State: APt69E2oDiNbqMLN4FUHMmhNtL13z8yaeSjxly6PeAvwzojNEE67Wcie
        4Tfkj0EZ6LScMzBbisnKwygj7A==
X-Google-Smtp-Source: ADUXVKIwgfjJxztPvpSdbCiA0sfQkl2vgmgmp+OlRsqq2cy2NmeX+F4ADWvnG4liW0k7UTFJtscezA==
X-Received: by 2002:a17:902:6945:: with SMTP id k5-v6mr16964506plt.175.1529448534720;
        Tue, 19 Jun 2018 15:48:54 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o66-v6sm906758pfi.157.2018.06.19.15.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 15:48:54 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:51:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Message-ID: <20180619225111.GD15126@tuxbook-pro>
References: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
 <1529413893-5520-3-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529413893-5520-3-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 06:11 PDT 2018, Raju P L S S S N wrote:

> From: Lina Iyer <ilina@codeaurora.org>
> 
> Add device binding documentation for Qualcomm Technology Inc's RPMH RSC
> driver. The driver is used for communicating resource state requests for
> shared resources.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> [rplsssn@codeaurora.org: minor order correction for TCS type]

In accordance with section 11 of
Documentation/process/submitting-patches.rst you must to add your
Signed-off-by tag at the end of this list.

Same on patch 3.

Regards,
Bjorn

> ---
> Changes in v8:
> 	- Describe IRQ for all DRVs
> 
> Changes in v7:
> 	- Fix example
> 
> Changes in v6:
> 	- Address comments from Stephen Boyd
> 
> Changes in v3:
> 	- Move to soc/qcom
> 	- Amend text per Stephen's suggestions
> 
> Changes in v2:
> 	- Amend text to describe the registers in reg property
> 	- Add reg-names for the registers
> 	- Update examples to use GIC_SPI in interrupts instead of 0
> 	- Rephrase incorrect description
> 
> Changes in v3:
> 	- Fix unwanted capitalization
> 	- Remove clients from the examples, this doc does not describe
> 	  them
> 	- Rephrase introductory paragraph
> 	- Remove hardware specifics from DT bindings
> ---
>  .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      | 137 +++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> new file mode 100644
> index 0000000..9b86d1e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> @@ -0,0 +1,137 @@
> +RPMH RSC:
> +------------
> +
> +Resource Power Manager Hardened (RPMH) is the mechanism for communicating with
> +the hardened resource accelerators on Qualcomm SoCs. Requests to the resources
> +can be written to the Trigger Command Set (TCS)  registers and using a (addr,
> +val) pair and triggered. Messages in the TCS are then sent in sequence over an
> +internal bus.
> +
> +The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
> +(Resource State Coordinator a.k.a RSC) that can handle multiple sleep and
> +active/wake resource requests. Multiple such DRVs can exist in a SoC and can
> +be written to from Linux. The structure of each DRV follows the same template
> +with a few variations that are captured by the properties here.
> +
> +A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
> +have powered off to facilitate idle power saving. TCS could be classified as -
> +
> +	ACTIVE  /* Triggered by Linux */
> +	SLEEP   /* Triggered by F/W */
> +	WAKE    /* Triggered by F/W */
> +	CONTROL /* Triggered by F/W */
> +
> +The order in which they are described in the DT, should match the hardware
> +configuration.
> +
> +Requests can be made for the state of a resource, when the subsystem is active
> +or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
> +will be an aggregate of the sleep votes from each of those subsystems. Clients
> +may request a sleep value for their shared resources in addition to the active
> +mode requests.
> +
> +Properties:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Should be "qcom,rpmh-rsc".
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: The first register specifies the base address of the
> +		    DRV(s). The number of DRVs in the dependent on the RSC.
> +	            The tcs-offset specifies the start address of the
> +	            TCS in the DRVs.
> +
> +- reg-names:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Maps the register specified in the reg property. Must be
> +	            "drv-0", "drv-1", "drv-2" etc and "tcs-offset". The
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-interrupt>
> +	Definition: The interrupt that trips when a message complete/response
> +	           is received for this DRV from the accelerators.
> +
> +- qcom,drv-id:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: The id of the DRV in the RSC block that will be used by
> +		    this controller.
> +
> +- qcom,tcs-config:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: The tuple defining the configuration of TCS.
> +	            Must have 2 cells which describe each TCS type.
> +	            <type number_of_tcs>.
> +	            The order of the TCS must match the hardware
> +	            configuration.
> +	- Cell #1 (TCS Type): TCS types to be specified -
> +	            ACTIVE_TCS
> +	            SLEEP_TCS
> +	            WAKE_TCS
> +	            CONTROL_TCS
> +	- Cell #2 (Number of TCS): <u32>
> +
> +- label:
> +	Usage: optional
> +	Value type: <string>
> +	Definition: Name for the RSC. The name would be used in trace logs.
> +
> +Drivers that want to use the RSC to communicate with RPMH must specify their
> +bindings as child nodes of the RSC controllers they wish to communicate with.
> +
> +Example 1:
> +
> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
> +register offsets for DRV2 start at 0D00, the register calculations are like
> +this -
> +DRV0: 0x179C0000
> +DRV2: 0x179C0000 + 0x10000 = 0x179D0000
> +DRV2: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> +TCS-OFFSET: 0xD00
> +
> +	apps_rsc: rsc@179c0000 {
> +		label = "apps_rsc";
> +		compatible = "qcom,rpmh-rsc";
> +		reg = <0x179c0000 0x10000>,
> +		      <0x179d0000 0x10000>,
> +		      <0x179e0000 0x10000>;
> +		reg-names = "drv-0", "drv-1", "drv-2";
> +		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +		qcom,tcs-offset = <0xd00>;
> +		qcom,drv-id = <2>;
> +		qcom,tcs-config = <ACTIVE_TCS  2>,
> +				  <SLEEP_TCS   3>,
> +				  <WAKE_TCS    3>,
> +				  <CONTROL_TCS 1>;
> +	};
> +
> +Example 2:
> +
> +For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
> +register offsets for DRV0 start at 01C00, the register calculations are like
> +this -
> +DRV0: 0xAF20000
> +TCS-OFFSET: 0x1C00
> +
> +	disp_rsc: rsc@af20000 {
> +		label = "disp_rsc";
> +		compatible = "qcom,rpmh-rsc";
> +		reg = <0xaf20000 0x10000>;
> +		reg-names = "drv-0";
> +		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
> +		qcom,tcs-offset = <0x1c00>;
> +		qcom,drv-id = <0>;
> +		qcom,tcs-config = <ACTIVE_TCS  0>,
> +				  <SLEEP_TCS   1>,
> +				  <WAKE_TCS    1>,
> +				  <CONTROL_TCS 0>;
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
> 

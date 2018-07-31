Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E21C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEF620894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEF620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeGaWZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:25:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39320 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeGaWZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:25:24 -0400
Received: by mail-io0-f194.google.com with SMTP id o22-v6so14208416ioh.6;
        Tue, 31 Jul 2018 13:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLOMPDsddrbMrkfmTb2WPTDcskNxO+Kc179MERRfLyQ=;
        b=L3kXMTaHagLwKCxvc76sxqMmGOC+gnrjc7U2T/ppj6LS3sRvTMek1GCfNmH5KXqGOG
         IQU2WAmYUz7FNiARkNxryrJzsA/moq7YMJL/A/QzfWLL0ak7YCgMO5qrvvJmNXVhL0T5
         Wlul9B4YHgeUjKa3fdkVWU1uxx41b2YvSPgSIUs9A27gvkeCju77roYX+EARer6yFFX+
         WxB+R1lcUIpg2Sc9uR1XeoxrMU7tMyglTDiVYdtZYooSbtiDlVpgOZ5WTDH+n01hh7jF
         COQA86z0dHs5LYYVoRWPJNGfccfxGrxKjO3H98JicOFXBWePYftpWvZJ45PAS8qifQ/9
         /Q5w==
X-Gm-Message-State: AOUpUlEVqMB4I5sZ/7vY4eyMen/E+s3ByQC23yKb3Jj6BZvXQXbM7fRQ
        xDHvviABK4vlYo0xr06xoQ==
X-Google-Smtp-Source: AAOMgpdwpWyVIElIKb85l8z8z93ZbDFh/CBH1nH4Xthxgm/CWdlwQTILC6agyfG2RUooUVbyW57JrA==
X-Received: by 2002:a5e:9910:: with SMTP id t16-v6mr1126788ioj.113.1533069797438;
        Tue, 31 Jul 2018 13:43:17 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m10-v6sm5001969ioj.22.2018.07.31.13.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:43:16 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:43:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
Message-ID: <20180731204315.GA5265@rob-hp-laptop>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:17:57PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
> and I2S/I2C interface.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,wcd9335.txt     | 123 +++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> new file mode 100644
> index 000000000000..1d8d49e30af7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
> @@ -0,0 +1,123 @@
> +QCOM WCD9335 Codec
> +
> +Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
> +Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
> +the MSM8996, MSM8976, and MSM8956 chipsets. It has in-built
> +Soundwire controller, interrupt mux. It supports both I2S/I2C and
> +SLIMbus audio interfaces.
> +
> +Required properties with SLIMbus Interface:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: For SLIMbus interface it should be "slimMID,PID",
> +		    textual representation of Manufacturer ID, Product Code,
> +		    shall be in lower case hexadecimal with leading zeroes
> +		    suppressed.  Refer to slimbus/bus.txt for details.
> +		    Should be:
> +		    "slim217,1a0" for MSM8996 and APQ8096 SoCs with SLIMbus.
> +
> +- reg
> +	Usage: required
> +	Value type: <u32 u32>
> +	Definition: Should be ('Device index', 'Instance ID')
> +
> +- interrupts
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Interrupts via WCD INTR1 and INTR2 pins
> +
> +- interrupt-names:
> +	Usage: required
> +	Value type: <String array>
> +	Definition: Interrupt names of WCD INTR1 and INTR2
> +	Should be: "intr1", "intr2"
> +
> +- reset-gpio:

reset-gpios

> +	Usage: required
> +	Value type: <String Array>
> +	Definition: Reset gpio line
> +
> +- qcom,ifd:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: SLIM interface device

Wouldn't this be the parent?

> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: See clock-bindings.txt section "consumers". List of
> +                three clock specifiers for mclk, mclk2 and slimbus clock.
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
> +
> +- vdd-buck-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V buck supply
> +
> +- vdd-buck-sido-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V SIDO buck supply
> +
> +- vdd-rx-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V rx supply
> +
> +- vdd-tx-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V tx supply
> +
> +- vdd-vbat-supply:
> +	Usage: Optional
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the vbat supply
> +
> +- vdd-micbias-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the micbias supply
> +
> +- vdd-io-supply:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: Should contain a reference to the 1.8V io supply
> +
> +- interrupt-controller:
> +	Usage: required
> +	Definition: Indicating that this is a interrupt controller
> +
> +- #interrupt-cells:
> +	Usage: required
> +	Value type: <int>
> +	Definition: should be 1
> +
> +#sound-dai-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 1
> +
> +codec@1{

audio-codec@1

> +	compatible = "slim217,1a0";
> +	reg  = <1 0>;
> +	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "intr2"
> +	reset-gpio = <&msmgpio 64 0>;
> +	qcom,ifd  = <&wc9335_ifd>;
> +	clock-names = "mclk", "native";
> +	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
> +		 <&rpmcc RPM_SMD_BB_CLK1>;
> +	vdd-buck-supply = <&pm8994_s4>;
> +	vdd-rx-supply = <&pm8994_s4>;
> +	vdd-buck-sido-supply = <&pm8994_s4>;
> +	vdd-tx-supply = <&pm8994_s4>;
> +	vdd-io-supply = <&pm8994_s4>;
> +	#sound-dai-cells = <1>;
> +}
> -- 
> 2.16.2
> 

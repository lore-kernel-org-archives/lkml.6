Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FF7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B74B20871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6N7vyDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B74B20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbeGKQoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:44:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34726 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389850AbeGKQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:44:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so9391460plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xkpApksEGjPEniERJuh7E8LC5cYAp670CEKQ8AxLBxU=;
        b=K6N7vyDBvJNiQ3uJynNHv+5XKnlDPR7RArerKb7I85qDwsiIcd2Xu+2wtzRBfzMlam
         uGFXRMH9uKqBjMf9eV1M9KYN5SSdkiJUpgXryruCk0zm8N4PXieEf1tYcLehlPM8nhwA
         xNQucS9fLk1IpOoR+O3ZW2hIul72a7hOWyPM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xkpApksEGjPEniERJuh7E8LC5cYAp670CEKQ8AxLBxU=;
        b=uM2qRUBW02os6YRH6g8jBozD8Q04+5Z8CnmrfeAPhqYFvXSHU33NxVjs8imdxcBdbU
         vmuK/bFNVkttw4+wriXK6aqnf2LpDM2Ip6hHw9F6Pzqj3ghxzbInw+ozyufXin40iW6+
         7EkyUtSufwHx7JblCkLEMSUYeJvNbIXReNTj6B0F4/oQ0IT9ZDeGZ9Qbiu4y9Y4FYN4i
         UxeH9sOlM9rRf5GgqqRnir1OMh1aX/VP7EfpwfrLVNzIHJJh4Yg7u/OILOeSkG+33qRT
         MMh9y0rciYlg8xmVyG9cKOFtDPyGH3038oyqLfQ1aiQ+LvAbt9q0a8WPPnk97pAk6wke
         cg2w==
X-Gm-Message-State: APt69E0JLls2bYPeseGInnnl/JjxbQhChRzuPtG+QMkWn3Qj/vNEvC+A
        iTlaKlKXBjN+Y/a66LevenT2lA==
X-Google-Smtp-Source: AAOMgpfKXyCkQtbUgI1yGe/8bmJTcfJnqbeGOCVp7EBnL8Y4o6fj9nbn9B0CUOSGgbe4EzQQgH4SrQ==
X-Received: by 2002:a17:902:758c:: with SMTP id j12-v6mr29343500pll.195.1531327169014;
        Wed, 11 Jul 2018 09:39:29 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j75-v6sm5059550pfj.102.2018.07.11.09.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:39:28 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:42:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 6/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
Message-ID: <20180711164209.GF545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
> 
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..8f963b1 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -1,10 +1,16 @@
>  * QCOM SoC Temperature Sensor (TSENS)
>  
>  Required properties:
> -- compatible :
> - - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> - - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> - - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> +- compatible:
> +  Must be one of the following:
> +    - "qcom,msm8916-tsens" (MSM8916)
> +    - "qcom,msm8974-tsens" (MSM8974)
> +    - "qcom,msm8996-tsens" (MSM8996)
> +    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
> +    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
> +  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC with
> +  version 2 of the TSENS IP. MSM8996 is the only exception beacause the generic
> +  property did not exist when support was added.
>  
>  - reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> @@ -12,7 +18,7 @@ Required properties:
>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>  nvmem cells
>  
> -Example:
> +Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
>  tsens: thermal-sensor@900000 {
>  		compatible = "qcom,msm8916-tsens";
>  		reg = <0x4a8000 0x2000>;
> @@ -20,3 +26,12 @@ tsens: thermal-sensor@900000 {
>  		nvmem-cell-names = "caldata", "calsel";
>  		#thermal-sensor-cells = <1>;
>  	};
> +
> +Example 2 (for any platform containing v2 of the TSENS IP):
> +tsens0: tsens@c222000 {
> +		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +		reg = <0xc263000 0x1ff>, /* TM */
> +			<0xc222000 0x1ff>; /* SROT */
> +		#qcom,sensors = <13>;
> +		#thermal-sensor-cells = <1>;
> +	};
> -- 
> 2.7.4
> 

Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5851BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9CE24654
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjlC/mGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9CE24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeFVREK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:04:10 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33170 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbeFVREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:04:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so3238741pgq.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhAA4FqalJcpBM8gE3/uQUH61pcR2LV4a3HdFmJDgz0=;
        b=RjlC/mGJFPE4/0sTFAEVWN0n0R8NkbWPI3QwgBfMbI+YQGVLFTydGC2jtKvcpIoMBD
         vtc82VmGSmvxxl4nu9KG6htqIA+bT/ryaGFseifS5sWTYTjiTgtBncyjPTuUrJEy3fKs
         pgKXCYkKqLzw/WzqW5O51eH63F1DVT6L5hYM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhAA4FqalJcpBM8gE3/uQUH61pcR2LV4a3HdFmJDgz0=;
        b=tBSuaACjKYCngm0BMScxEj7MhIBygccil9XPhwXMxkvjNVT3fBTHycUVUGH7ZsbLIX
         aEC895kJygY4GZRuxHjiL5rq5UgosdzExe+63H5o6xQ7uxieGLGwAlb2rURtFK4r2bWK
         FnpZTgXU1XbeaZG+Zb0IJozPOVEFmQLWH2Tjgy0ooyMvQtFK+T2N0qOCZDLF7P3ZbZFt
         ocoXjZ3BqwgEcfRC52Gu9iNM/Nnpo21eqEZPpLM0tLtznUWPQZToBezP9mtFEvxLFhCp
         k+QFkrWr3Dsn9NGWR/DfHJE9mk/onmk0sfGOmlsHXqQXv13izCnLGlDlGpXwwWd764cp
         fA1A==
X-Gm-Message-State: APt69E0bJw4eRaHgZwjB8mdXZRdlRbIXt2bUnyclSNPRYqotfwazTt/W
        iczX7gBA9YVH1IfW6SvH23OVfw==
X-Google-Smtp-Source: ADUXVKImlz0L1Q8pbvP0ycd8v2R0mirPaddz8pf23gYiFLySZHD50EEUnK8qF5wlyJGnchfz2Z0kCg==
X-Received: by 2002:a62:484d:: with SMTP id v74-v6mr2634633pfa.256.1529687045190;
        Fri, 22 Jun 2018 10:04:05 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u84-v6sm15371865pfg.156.2018.06.22.10.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:04:04 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:04:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, tdas@codeaurora.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, ilina@codeaurora.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, rplsssn@codeaurora.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: sdm845: Add rpmh-rsc node
Message-ID: <20180622170402.GE10336@builder>
References: <20180618215051.156270-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618215051.156270-1-dianders@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Jun 14:50 PDT 2018, Douglas Anderson wrote:

> This adds the rpmh-rsc node to sdm845 based on the examples in the
> bindings.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v2:
> - Fixed ordering of tcs-config as per Lina.
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cd308b84bed7..43a182fb42c9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -984,6 +985,24 @@
>  			#mbox-cells = <1>;
>  		};
>  
> +		apps_rsc: rsc@179c0000 {
> +			label = "apps_rsc";
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x179c0000 0x10000>,
> +			      <0x179d0000 0x10000>,
> +			      <0x179e0000 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS  2>,
> +					  <SLEEP_TCS   3>,
> +					  <WAKE_TCS    3>,
> +					  <CONTROL_TCS 1>;
> +		};
> +
>  		intc: interrupt-controller@17a00000 {
>  			compatible = "arm,gic-v3";
>  			#address-cells = <1>;
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

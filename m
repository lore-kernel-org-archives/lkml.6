Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BBFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A8921568
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A8921568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeI0CiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:38:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46014 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0CiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:38:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id c13-v6so251894otf.12;
        Wed, 26 Sep 2018 13:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2d3Qs8I55Av+N1zIL7reVCeCO/qRx/311cTebvLYQ04=;
        b=EDHTLpW0EXTeeb/Rfhoo4MZNaI7yCA8h2U+BVhdQqfqTNz2rgk9arOE01r8AIkFkHM
         RjF4G8BSN31kiF1RWlRGwfvX9HzD/wKoFnsmq2ezsM8JQKCBI/lK/IZkFsJewwbonDa+
         dZM3Fh/JOG2m6ysPgNi/zvBsFZx2g904HrDSWfYArOjWoVUSHh+dCMQDvlYffwQa+iYG
         oV124HqfB7FK4p3pg7rKrPADMNxN5SQvxWlSWaRfRsUKaAIUeUfOqNzvaFCsgkOQjNPP
         ejfBp8PyMDnc9CjilMYgPstAl8KlWigvfVBjW2TGtyN0Qo8G6e3PRPhMnYuD1cD4RSzy
         QhoQ==
X-Gm-Message-State: ABuFfoggVTdXISSt/zfJHEqKcgFasAqqdYLJP4AYxT5gBaNoVV5sV2TU
        8faXn4hoAryeBg4TkYjCsQ==
X-Google-Smtp-Source: ACcGV60N7kMncy4QlNQv4pOWc7Y+rLDuaJXZnZhROjTB+nnw2rCE/r8HC6KBcG8YqrF6rRhwgSEFmw==
X-Received: by 2002:a9d:cd8:: with SMTP id o24-v6mr3789428otd.367.1537993413842;
        Wed, 26 Sep 2018 13:23:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 39-v6sm3012052otz.67.2018.09.26.13.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:23:33 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:23:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] dt-bindings: stm32-mdma: Add DMA/MDMA chaining
 support bindings
Message-ID: <20180926202332.GA13585@bogus>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
 <1536650820-16076-4-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536650820-16076-4-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:26:56AM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the description of the 2 properties needed to support M2M
> transfer triggered by STM32 DMA when his transfer is complete.

Same problem here.

> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  .../devicetree/bindings/dma/stm32-mdma.txt         | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> index d18772d..1810f87 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> @@ -10,7 +10,7 @@ Required properties:
>  - interrupts: Should contain the MDMA interrupt.
>  - clocks: Should contain the input clock of the DMA instance.
>  - resets: Reference to a reset controller asserting the DMA controller.
> -- #dma-cells : Must be <5>. See DMA client paragraph for more details.
> +- #dma-cells : Must be <6>. See DMA client paragraph for more details.
>  
>  Optional properties:
>  - dma-channels: Number of DMA channels supported by the controller.
> @@ -26,7 +26,7 @@ Example:
>  		interrupts = <122>;
>  		clocks = <&timer_clk>;
>  		resets = <&rcc 992>;
> -		#dma-cells = <5>;
> +		#dma-cells = <6>;
>  		dma-channels = <16>;
>  		dma-requests = <32>;
>  		st,ahb-addr-masks = <0x20000000>, <0x00000000>;
> @@ -35,8 +35,8 @@ Example:
>  * DMA client
>  
>  DMA clients connected to the STM32 MDMA controller must use the format
> -described in the dma.txt file, using a five-cell specifier for each channel:
> -a phandle to the MDMA controller plus the following five integer cells:
> +described in the dma.txt file, using a six-cell specifier for each channel:
> +a phandle to the MDMA controller plus the following six integer cells:
>  
>  1. The request line number
>  2. The priority level
> @@ -76,19 +76,23 @@ a phandle to the MDMA controller plus the following five integer cells:
>     if no HW ack signal is used by the MDMA client
>  5. A 32bit mask specifying the value to be written to acknowledge the request
>     if no HW ack signal is used by the MDMA client
> +6. A bitfield value specifying if the MDMA client wants to generate M2M
> +   transfer with HW trigger (1) or not (0). This bitfield should be only
> +   enabled for M2M transfer triggered by STM32 DMA client. The memory devices
> +   involved in this kind of transfer are SRAM and DDR.
>  
>  Example:
>  
>  	i2c4: i2c@5c002000 {
>  		compatible = "st,stm32f7-i2c";
>  		reg = <0x5c002000 0x400>;
> -		interrupts = <95>,
> -			     <96>;
> -		clocks = <&timer_clk>;
> +		interrupts = <GIC_SPI 95 IRQ_TYPE_NONE>,
> +			     <GIC_SPI 96 IRQ_TYPE_NONE>;
> +		clocks = <&clk_hsi>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		dmas = <&mdma1 36 0x0 0x40008 0x0 0x0>,
> -		       <&mdma1 37 0x0 0x40002 0x0 0x0>;
> +		dmas = <&mdma1 36 0x0 0x40008 0x0 0x0 0>,
> +		       <&mdma1 37 0x0 0x40002 0x0 0x0 0>;
>  		dma-names = "rx", "tx";
>  		status = "disabled";
>  	};
> -- 
> 2.7.4
> 

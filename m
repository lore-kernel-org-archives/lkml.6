Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C38C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B6120895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsyuUC+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B6120895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeJGWHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeJGWHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:07:11 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10562075C;
        Sun,  7 Oct 2018 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538924379;
        bh=fRX0mNpuzLX3m5/HthL5UZaeok1oWsRpu9JWenJ+fDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsyuUC+9SiVLLxNZgKLz1XnsCRql3+yZ1X25dbA5B0wfbxd1YgUEYpXdc2MU/y1Ic
         5t84VZNK/fF21fxMmGec3g6oi7+EQMw3dJ6bjFIY3+RhJn9d3RJ+cH+bqvBxcaR/f1
         USINt5Ylz+equVmtgpKtypju5roFAUCW+VS4bavY=
Date:   Sun, 7 Oct 2018 20:29:30 +0530
From:   Vinod <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dt-bindings: stm32-mdma: Add DMA/MDMA chaining
 support bindings
Message-ID: <20181007145930.GA2372@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-4-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538139715-24406-4-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> 
> This patch adds the description of the 2 properties needed to support M2M
> transfer triggered by STM32 DMA when his transfer is complete.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v3:
>     v2:
>        * rework content
>     v1:
>        * Initial
> ---
> ---
>  Documentation/devicetree/bindings/dma/stm32-mdma.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-mdma.txt b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> index d18772d..27c2812 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-mdma.txt
> @@ -10,7 +10,7 @@ Required properties:
>  - interrupts: Should contain the MDMA interrupt.
>  - clocks: Should contain the input clock of the DMA instance.
>  - resets: Reference to a reset controller asserting the DMA controller.
> -- #dma-cells : Must be <5>. See DMA client paragraph for more details.
> +- #dma-cells : Must be <6>. See DMA client paragraph for more details.

can you update the example for 6 cells?

Also what happens to dts using 5 cells..

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
> @@ -76,6 +76,10 @@ a phandle to the MDMA controller plus the following five integer cells:
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
> -- 
> 2.7.4

-- 
~Vinod

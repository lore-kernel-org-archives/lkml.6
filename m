Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D8CC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8314220895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqKIX/1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8314220895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeJGWFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeJGWFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:05:03 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8982075C;
        Sun,  7 Oct 2018 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538924251;
        bh=jbJlCGdHgQhaD1P+4VxPXx7tzsagydw2Dv9csobglbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqKIX/1GQe7404iXDh/I7zz/851eE7S7zpJu/82P0d0298vy4v4gAk13j9l+/859Y
         NSTZoipMQd01wK+xHEGyeSHNxye3pm26jVWXSSIoqDCGXugkLkqB3v1dvbYa5k3kM0
         TkiCxj7h8qW5qe2Wkusd7liMlnrl+JiG35WhpoNk=
Date:   Sun, 7 Oct 2018 20:27:22 +0530
From:   Vinod <vkoul@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
Message-ID: <20181007145722.GY2372@vkoul-mobl>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> 
> This patch adds dma bindings to support DMA/MDMA chaining transfer.
> 1 bit is to manage both DMA FIFO Threshold
> 1 bit is to manage DMA/MDMA Chaining features.
> 2 bits are used to specify SDRAM size to use for DMA/MDMA chaining.

Please do mention which specific bits?

> The size in bytes of a certain order is given by the formula:
>     (2 ^ order) * PAGE_SIZE.
> The order is given by those 2 bits.
> For cyclic, whether chaining is chosen, any value above 1 can be set :
> SRAM buffer size will rely on period size and not on this DT value.
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
>  .../devicetree/bindings/dma/stm32-dma.txt          | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
> index c5f5190..2bac8c7 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
> @@ -17,6 +17,12 @@ Optional properties:
>  - resets: Reference to a reset controller asserting the DMA controller
>  - st,mem2mem: boolean; if defined, it indicates that the controller supports
>    memory-to-memory transfer
> +- dmas: A list of eight dma specifiers, one for each entry in dma-names.
> +  Refer to stm32-mdma.txt for more details.
> +- dma-names: should contain "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6" and
> +  "ch7" and represents each STM32 DMA channel connected to a STM32 MDMA one.
> +- memory-region : phandle to a node describing memory to be used for
> +  M2M intermediate transfer between DMA and MDMA.
>  
>  Example:
>  
> @@ -36,6 +42,16 @@ Example:
>  		st,mem2mem;
>  		resets = <&rcc 150>;
>  		dma-requests = <8>;
> +		dmas = <&mdma1 8 0x10 0x1200000a 0x40026408 0x00000020 1>,
> +		       <&mdma1 9 0x10 0x1200000a 0x40026408 0x00000800 1>,
> +		       <&mdma1 10 0x10 0x1200000a 0x40026408 0x00200000 1>,
> +		       <&mdma1 11 0x10 0x1200000a 0x40026408 0x08000000 1>,
> +		       <&mdma1 12 0x10 0x1200000a 0x4002640C 0x00000020 1>,
> +		       <&mdma1 13 0x10 0x1200000a 0x4002640C 0x00000800 1>,
> +		       <&mdma1 14 0x10 0x1200000a 0x4002640C 0x00200000 1>,
> +		       <&mdma1 15 0x10 0x1200000a 0x4002640C 0x08000000 1>;
> +		dma-names = "ch0", "ch1", "ch2", "ch3", "ch4", "ch5", "ch6", "ch7";
> +		memory-region = <&sram_dmapool>;
>  	};
>  
>  * DMA client
> @@ -68,7 +84,16 @@ channel: a phandle to the DMA controller plus the following four integer cells:
>  	0x1: 1/2 full FIFO
>  	0x2: 3/4 full FIFO
>  	0x3: full FIFO
> -
> + -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
> +	0: MDMA not used to generate an intermediate M2M transfer
> +	1: MDMA used to generate an intermediate M2M transfer.
> + -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.
> +	PAGE_SIZE is given by Linux at 4KiB: include/asm-generic/page.h.
> +	Order is given by those 2 bits starting at 0.
> +	Valid only whether Intermediate M2M transfer is set.

why do we need this as a property?

> +	For cyclic, whether Intermediate M2M transfer is chosen, any value can
> +	be set: SRAM buffer size will rely on period size and not on this DT
> +	value.
>  
>  Example:
>  
> -- 
> 2.7.4

-- 
~Vinod

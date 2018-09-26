Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87824C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182572150C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182572150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeI0Cfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:35:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42948 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbeI0Cfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:35:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so261926otl.9;
        Wed, 26 Sep 2018 13:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKiV69SbqQyHr+eFmOQkreF+1GvupVhedHPU6YRRkEg=;
        b=XHc7DQHnw1uQ2UQpM1xjIP5uy5Rc652iG+UNQrwIAuEKLMGweL8G/IhjwCrMIZbVa1
         9eneFFlWFtbHjQQ9d1FY5EFNHUzamz9wFPNJOqVGz2LvFOkXQXDKCJwAHaTFBv0yw5pO
         lhE+jwdidNEZe5zUhSitIf6ltZcK6WwWh5sUrtMJ1gDxGmS66i5oqB+AfFIaywa5DN3X
         UEJmg06SPkkcehrMWHF++LEgIs1mNQtQS81L/Y84r5D1MfbZwVfG4iFnEzjL05/m2Lf0
         +7bfhf8O9DhsJ77K6Orcaw3i3+BBCNyMyDY1QWjuLpnYlR266tQ/gCgxO//D3wUvQuuC
         0PzQ==
X-Gm-Message-State: ABuFfojCWCn7QEjyUG5dmhS5retBddm7+C3/NwKDQmt3GnluCgQw8NUT
        LSyHjodqQsj72Ughp9c9xQ==
X-Google-Smtp-Source: ACcGV63PJ1D52DvLrtY8EcQ6JfKqHE1WfujvWMnsPsTrTc7C2Zx3cSnJ0kXJqRd/eseWgOjEzlAOmg==
X-Received: by 2002:a9d:518c:: with SMTP id y12-v6mr5579200otg.252.1537993273385;
        Wed, 26 Sep 2018 13:21:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 89-v6sm2222276ots.72.2018.09.26.13.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:21:12 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:21:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
Message-ID: <20180926202112.GA6426@bogus>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
 <1536650820-16076-2-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536650820-16076-2-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:26:54AM +0200, Pierre-Yves MORDRET wrote:
> This patch adds dma bindings to support DMA/MDMA chaining transfer.
> 1 bit is to manage both DMA FIFO Threshold
> 1 bit is to manage DMA/MDMA Chaining features.
> 2 bits are used to specify SDRAM size to use for DMA/MDMA chaining.
> The size in bytes of a certain order is given by the formula:
>     (2 ^ order) * PAGE_SIZE.
> The order is given by those 2 bits.
> For cyclic, whether chaining is chosen, any value above 1 can be set :
> SRAM buffer size will rely on period size and not on this DT value.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  .../devicetree/bindings/dma/stm32-dma.txt          | 32 +++++++++++++++++++---
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
> index c5f5190..163be09 100644
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
> @@ -62,13 +78,21 @@ channel: a phandle to the DMA controller plus the following four integer cells:
>  	0x1: medium
>  	0x2: high
>  	0x3: very high
> -4. A 32bit bitfield value specifying DMA features which are device dependent:
> +4. A bitfield value specifying DMA features which are device dependent:

It's still a 32-bit value, right?

>   -bit 0-1: DMA FIFO threshold selection
>  	0x0: 1/4 full FIFO
>  	0x1: 1/2 full FIFO
>  	0x2: 3/4 full FIFO
>  	0x3: full FIFO
> -
> + -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
> +	0: MDMA not used to generate an intermediate M2M transfer
> +	1: MDMA used to generate an intermediate M2M transfer.
> + -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.

What's PAGE_SIZE? That's not defined for DT.

> +	Order is given by those 2 bits starting at 0.
> +	Valid only whether Intermediate M2M transfer is set.
> +	For cyclic, whether Intermediate M2M transfer is chosen, any value can
> +	be set: SRAM buffer size will rely on period size and not on this DT
> +	value.
>  
>  Example:
>  
> @@ -77,7 +101,7 @@ Example:
>  		reg = <0x40011000 0x400>;
>  		interrupts = <37>;
>  		clocks = <&clk_pclk2>;
> -		dmas = <&dma2 2 4 0x10400 0x3>,
> -		       <&dma2 7 5 0x10200 0x3>;
> +		dmas = <&dma2 2 4 0x10400 0x1>,
> +		       <&dma2 7 5 0x10200 0x1>;
>  		dma-names = "rx", "tx";
>  	};
> -- 
> 2.7.4
> 

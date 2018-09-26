Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABCCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7F621531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7F621531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeI0Cg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:36:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33218 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeI0Cg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:36:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id a203-v6so277243oib.0;
        Wed, 26 Sep 2018 13:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+KVu7TL59FZas1I8A7CopMzNF3hzMwamO6BFocg3dU=;
        b=DMvTKTRu2pqtUROFmhXgZ6zhpvRbmHBxkObO7eeQp2DM/Qf1BZy3JiNfsF3QrGuGjK
         +3y2fjlQtUpiwwdu4gsx9LCsNiV85oPKff3CS8Q5XSgqqLVmywHYwEX4IVtUtBOf/I7T
         od/dR8/jypgsxjOxKbg4qO111fpSp66RaOqJji9MOgP3NRI9oMTZhECv2YWY1ZlnL7w2
         WpbRhr8ptMJAad/YXeUNSgKJM2qPV0z+K0Zl1zjsVesTYZ5JM7boZZiPBtVc6L0vAq4Z
         WV9A2/cTu5mqQ+hJ0khCUqHGaH1dSd8lnRmi4U8T9c701YivRB5ZDF5xamP3uEHA6IxG
         4nAg==
X-Gm-Message-State: ABuFfoiptHm8NOCpKmEUMUvnDj7EPMKzj1p0WVvM9mPPl0/cbvFAMTFx
        6JZs6h5aQH1hlMNl26OUQQ==
X-Google-Smtp-Source: ACcGV60onPYpQDsQrDZJChAnF86frFcIrXXrAC1RhRrHLiSL/P8d8U52Nmb7dLc4aAx4lSM/jSqUsw==
X-Received: by 2002:aca:ef0a:: with SMTP id n10-v6mr1659608oih.326.1537993338560;
        Wed, 26 Sep 2018 13:22:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l135-v6sm2150707oig.28.2018.09.26.13.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:22:17 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:22:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] dt-bindings: stm32-dmamux: Add one cell to
 support DMA/MDMA chain
Message-ID: <20180926202217.GA12110@bogus>
References: <1536650820-16076-1-git-send-email-pierre-yves.mordret@st.com>
 <1536650820-16076-3-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536650820-16076-3-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:26:55AM +0200, Pierre-Yves MORDRET wrote:
> Add one cell to support DMA/MDMA chaining.

The diff doesn't match the description.

> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  Documentation/devicetree/bindings/dma/stm32-dmamux.txt | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
> index 1b893b2..8e092d2 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
> @@ -4,9 +4,6 @@ Required properties:
>  - compatible:	"st,stm32h7-dmamux"
>  - reg:		Memory map for accessing module
>  - #dma-cells:	Should be set to <3>.
> -		First parameter is request line number.
> -		Second is DMA channel configuration
> -		Third is Fifo threshold
>  		For more details about the three cells, please see
>  		stm32-dma.txt documentation binding file
>  - dma-masters:	Phandle pointing to the DMA controllers.
> @@ -53,7 +50,7 @@ dma2: dma@40020400 {
>  		     <68>,
>  		     <69>,
>  		     <70>;
> -	clocks = <&timer_clk>;
> +	clocks = <&clk_hclk>;
>  	#dma-cells = <4>;
>  	st,mem2mem;
>  	resets = <&rcc 150>;
> -- 
> 2.7.4
> 

Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215F4C6786D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8824213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8824213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeJLWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:19:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34111 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeJLWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:19:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id v2so5448713otk.1;
        Fri, 12 Oct 2018 07:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ZNr+m5DOarmheg6ao0qmB6YfTLxrkOOGAoybAQkYW4=;
        b=Km0w1cEPlYuLUrvP0aPJ24fEUXyYWpWOM8PZ36SdNm2bKO5prZhIRcL0OqHH5qXrdM
         tmdysXwBicZqXN/2SMD29ilTQbyFb7H90uqjLnvurWvMueXVXlNZ8mrLb8pwAxb/UUB8
         iI30lCN8MpdBruatnL236LfVo0uiTVqE3zclmh2LeSl4qdrMPjZFNJ+dBnmpMoIeX6Q1
         d4pxOsvaQylzkQtWh0sBabRRQ8GE+kV0RHx75LLfzNpMR7XSU16spBR2NgnH8SAaPZ76
         heh8mkppxOhzmyMKALGI+6y9e8W3TvtoSGh8N2iJISZ6t51ZcVEma3yl1fWTkpNaqdyc
         gW3Q==
X-Gm-Message-State: ABuFfoimwyxOwJPW4cow3yqPixPBQbAfP9gG+7H7gNYLnrLAyJWzDSUL
        Zc4wiIZkbH6pxhKTjaxH1g==
X-Google-Smtp-Source: ACcGV63zrAVQj7tk9ObctBtIME9f/30pYC88Z3QjWM2ZrHPEFOOtnCMegXQLsT8ffIuCqm8CxcKZ/w==
X-Received: by 2002:a9d:9d0:: with SMTP id 16mr4111789otz.280.1539355620194;
        Fri, 12 Oct 2018 07:47:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17-v6sm346591oia.43.2018.10.12.07.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:46:59 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:46:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: stm32-dmamux: Add one cell to
 support DMA/MDMA chain
Message-ID: <20181012144658.GA30093@bogus>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-3-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538139715-24406-3-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:01:50PM +0200, Pierre-Yves MORDRET wrote:
> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> 
> Add one cell to support DMA/MDMA chaining.

You aren't adding a cell. Is the change compatible with existing users 
(if you mask bits)?

> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Author S-o-b missing.

> ---
>   Version history:
>     v3:
>     v2:
>        * rework content
>     v1:
>        * Initial
> ---
> ---
>  Documentation/devicetree/bindings/dma/stm32-dmamux.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
> index 1b893b2..5e92b59 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
> @@ -4,9 +4,9 @@ Required properties:
>  - compatible:	"st,stm32h7-dmamux"
>  - reg:		Memory map for accessing module
>  - #dma-cells:	Should be set to <3>.
> -		First parameter is request line number.
> -		Second is DMA channel configuration
> -		Third is Fifo threshold
> +-		First parameter is request line number.
> +-		Second is DMA channel configuration
> +-		Third is a 32bit bitfield
>  		For more details about the three cells, please see
>  		stm32-dma.txt documentation binding file
>  - dma-masters:	Phandle pointing to the DMA controllers.
> -- 
> 2.7.4
> 

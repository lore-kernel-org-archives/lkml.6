Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D81C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B2F21502
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B2F21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbeHGRKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:10:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55194 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388961AbeHGRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:10:47 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so22397596itb.4;
        Tue, 07 Aug 2018 07:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NUdpm81RdynnIJTR7hXpzPEoMJn9+iFYlTGC5WW0MzQ=;
        b=uO9eVPlO1U2M4vTi4zmBaAtj1u3Ddw0NuFHpyddQI5tMM5odGK7dZRVZdrGPPg7vsV
         78ELnq5UOkzCTO3VeuDXciNLk94WiOrhqF+/piHYpoXKyjXOGlLKC4m8rz9r/Su0JlWx
         Myx4aQx3/cYVUILYe6ny982nTtwX7UwZ9b2FiHCmgJyu3Xz6w8mcliqR6g04hD7FOWBM
         Flq18ozYNDQXkCd6ybLyAWlGGBPMWNpvW9HwA8y+iZIG3qsF76o7zdXc51S0IFGQqcoP
         zD1/A4A1iFstBEJ1e1MPj993ERnIVIbf24Kbxgn3ey9ksNm+364NMn9alvRzFJiR1hlq
         5vug==
X-Gm-Message-State: AOUpUlHUd4EE98WBh2IBJzzsJ+oeOlrqtEOtoSBcYI+ulCf1evVbZfUQ
        hd4rosnz3tIkhqIPTL3Lvw==
X-Google-Smtp-Source: AA+uWPycRhfD03aNkQB+LElC7dE+d3dx4Am4l4tufIco3AbpUQ2f8sdJnkQouDY9mDEUS/a6+z9OEQ==
X-Received: by 2002:a24:4511:: with SMTP id y17-v6mr2339788ita.67.1533653764688;
        Tue, 07 Aug 2018 07:56:04 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id i20-v6sm440885ioj.57.2018.08.07.07.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:56:04 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:56:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org,
        v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v4 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
Message-ID: <20180807145603.GA1664@rob-hp-laptop>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-3-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802141012.19970-3-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:10:08PM +0200, Andrea Merello wrote:
> The width of the "length register" cannot be autodetected, and it is now
> specified with a DT property. Add DOC for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- change property name
> 	- property is now optional
> 	- cc DT maintainer
> Changes in v3:
> 	- reword
> 	- cc DT maintainerS and ML
> Changes in v4:
> 	- specify the unit, the valid range and the default value
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfaec43c..aec4a41a03ae 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -41,6 +41,10 @@ Optional properties:
>  - xlnx,include-sg: Tells configured for Scatter-mode in
>  	the hardware.
>  Optional properties for AXI DMA:
> +- xlnx,sg-length-width: Should be set to the width in bits of the length
> +  	register as configured in h/w. Takes values {8...26}. If the property
> +	is missing or invalid then the default value 23 is used. This is the
> +	maximum value that is supported by all IP versions.

If 23 is the max, then why is the range 8-26?

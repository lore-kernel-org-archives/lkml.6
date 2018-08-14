Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B964DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787FE216F3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787FE216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbeHNTBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:01:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40383 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbeHNTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:01:15 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so20444421ita.5;
        Tue, 14 Aug 2018 09:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UYT+U2muqq6JQcMrfuo+6MJvhy6zABZKkLnyBqzcfwE=;
        b=qTuZpWUwBqmlyhumdREoFCC9kCFCmI+hyqRQnXepKk9c2UDuHVqFHB58nMtM24qO8y
         JFSKWBPKZMD5us2XzuNWUaNF+7/aWQWAw1no/vd7WtKNmhCLDhLBYTRkahCmWEW8UkH4
         s82n4avIZzSfCxZBF3xWpxDss+alkQv3LQl4D3LrWXjw5x4tCpGKfj8B5rJzCEfqogq3
         qbDW4plVs0B+ec/WPVx1Ne4E/I8/X6mQJnril+Tgkjd+kBEQZC206cy7QjMdo93vBYbb
         bXsM+saCbrkEgbR9ekF3LE+Nchgnfk9lq5KffMxUeJrQaXNfp7qgk1sx2QULoCmYzzo2
         qjkw==
X-Gm-Message-State: AOUpUlHhhr2c510UQZ4M98fisXiXFer/hcrtAVI07Jf5MTybnxkZ55Mz
        BfkWAffFnOn2IB/t7PCoAhdVuWA=
X-Google-Smtp-Source: AA+uWPxIipTugNO6gYKCaJs4FqBrUxlpQUyfSSvlgGhw9amJERfKnbtW/ch3XMiz9JZziFVGBapoOQ==
X-Received: by 2002:a02:8a05:: with SMTP id j5-v6mr19481068jak.88.1534263207688;
        Tue, 14 Aug 2018 09:13:27 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id c71-v6sm9639775ioe.69.2018.08.14.09.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 09:13:26 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:13:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     vkoul@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        dan.j.williams@intel.com, appanad@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add binding
 for Xilinx MCDMA IP
Message-ID: <20180814161326.GA17341@rob-hp-laptop>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1533059173-21405-2-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533059173-21405-2-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:16:12PM +0530, Radhey Shyam Pandey wrote:
> Add devicetree binding for Xilinx AXI Multichannel Direct Memory Access
> (AXI MCDMA) IP. The AXI MCDMA provides high-bandwidth direct memory
> access between memory and AXI4-Stream target peripherals. The AXI MCDMA
> core provides scatter-gather interface with multiple channel support.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index 174af2c..57bb02e 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -11,9 +11,13 @@ is to receive from the device.
>  Xilinx AXI CDMA engine, it does transfers between memory-mapped source
>  address and a memory-mapped destination address.
>  
> +Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
> +target devices. It can be configured to have up to 16 independent transmit
> +and receive channels.
> +
>  Required properties:
>  - compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a" or
> -	      "xlnx,axi-cdma-1.00.a""
> +	      "xlnx,axi-cdma-1.00.a" or "xlnx,axi-mcdma-1.00.a".

Please reformat to 1 per line.

>  - #dma-cells: Should be <1>, see "dmas" property below
>  - reg: Should contain VDMA registers location and length.
>  - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
> @@ -56,6 +60,8 @@ Required child node properties:
>  	For CDMA: It should be "xlnx,axi-cdma-channel".
>  	For AXIDMA: It should be either "xlnx,axi-dma-mm2s-channel" or
>  	"xlnx,axi-dma-s2mm-channel".
> +	For MCDMA: It should be either "xlnx,axi-mcdma-mm2s-channel" or
> +	"xlnx,axi-mcdma-s2mm-channel".

What's wrong with reusing the existing xlnx,axi-dma-* names? 

>  - interrupts: Should contain per channel VDMA interrupts.
>  - xlnx,datawidth: Should contain the stream data width, take values
>  	{32,64...1024}.
> @@ -68,7 +74,7 @@ Optional child node properties for VDMA:
>  	enabled/disabled in hardware.
>  - xlnx,enable-vert-flip: Tells vertical flip is
>  	enabled/disabled in hardware(S2MM path).
> -Optional child node properties for AXI DMA:
> +Optional child node properties for AXI DMA and MCDMA:
>  -dma-channels: Number of dma channels in child node.
>  
>  Example:
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

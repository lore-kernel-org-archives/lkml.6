Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD521722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBWj5sLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBD521722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeH0JQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbeH0JQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:16:16 -0400
Received: from localhost (unknown [106.200.197.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BBD42152E;
        Mon, 27 Aug 2018 05:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535347872;
        bh=iceIk3PsQvO2kcj+aVqULVmqb1TU/T93OCdFbjwwkjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cBWj5sLFHSMLKN83UOHFMqXyYFfntiF4HgET47HZ4Xd92TsTkdZ5Bi8OkS9zrykov
         cIgInQAqGBPOwiZjRmw+5x3lbmp9YOclLNFwqCWtjiwvI6+El83tUVN2ToDYm1ETaX
         rauviKPt5ojfjoD2zMe8WYl/heLWwfEl04mOgMfM=
Date:   Mon, 27 Aug 2018 11:01:03 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v4 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
Message-ID: <20180827053103.GU2388@vkoul-mobl>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-3-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802141012.19970-3-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-18, 16:10, Andrea Merello wrote:
> The width of the "length register" cannot be autodetected, and it is now
> specified with a DT property. Add DOC for it.

Add Documentation for it...

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
>  - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
>  Optional properties for VDMA:
>  - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
> -- 
> 2.17.1

-- 
~Vinod

Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E8C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5220873
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE5220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934849AbeFYR3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:29:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38796 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933920AbeFYR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:29:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so6370130pgf.5;
        Mon, 25 Jun 2018 10:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W9RLrW6vHNXGCW9SZqbhZLU/LP/mOaw83xEOCyG9uuA=;
        b=tfTdrI3gt3VnFYOlRfBNOcMkHKDWv1dm1iIYiw/AlStTXcarQPxJc1sst+yjqHoRJu
         HGWOCgrReoZGoUqAR+o+Uq1nfbrjTBhooBgiIRdYoQGGJjdXNJ7fwf2ulJ7czgv4GEMH
         pooI6u88nxwS1SQZdV/kPWFQT+gLE09n2KDF7ym+o16h2r8WLcZbuDrwABhcm8ap8VuL
         2jUM+GwqXefXgmNukCQD4DlN/pZgeXuR+eJrgWAgvEyYEAZKP5PjySg0RjvU++HKTQzJ
         zWLUFaxcxyGcdLUCP3S0z6jl5/MCSF22nJ/sD4maV6xRtHbXZceiWxQWfCpQqtOpk6qd
         +G8g==
X-Gm-Message-State: APt69E067e7V1gT6wfq7oB/ora0wJJxMjnAmlcWD/HfUg3G8Ffv0nRUc
        6mqx+KErKxOnBAChoVmpJw==
X-Google-Smtp-Source: ADUXVKI7UEjXPOm6mpF/6frFUdj8wmNeyjZvT/gssb20mq36CXXJAOK/DWjIDsSmmJDE9Tw/lID5bQ==
X-Received: by 2002:a65:40ca:: with SMTP id u10-v6mr11300759pgp.2.1529947766517;
        Mon, 25 Jun 2018 10:29:26 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id w11-v6sm21770402pfn.71.2018.06.25.10.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:29:25 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:29:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
Message-ID: <20180625172924.GA398@rob-hp-laptop>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180625092724.22164-2-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625092724.22164-2-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:27:21AM +0200, Andrea Merello wrote:
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
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfaec43c..c894abe28baa 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -41,6 +41,7 @@ Optional properties:
>  - xlnx,include-sg: Tells configured for Scatter-mode in
>  	the hardware.
>  Optional properties for AXI DMA:
> +- xlnx,sg-length-width: Should be the width of the length register as configured in h/w.

What are the units? What are valid values? What is the default if the 
property is not present?

>  - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
>  Optional properties for VDMA:
>  - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
> -- 
> 2.17.1
> 

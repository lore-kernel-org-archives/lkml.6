Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDKJB1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:01:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:47255 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbeDKJBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:01:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="46004868"
Date: Wed, 11 Apr 2018 14:35:26 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc: dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, radheys@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/6] dt-bindings: dma: xilinx_dma: Add optional property
 has_axieth_connected
Message-ID: <20180411090525.GX6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-2-git-send-email-radheys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522665546-10035-2-git-send-email-radheys@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 04:09:01PM +0530, Radhey Shyam Pandey wrote:
> Add an optional AXI DMA property 'has_axieth_connected'. This can be
> specified to indicate that AXI DMA is connected to AXI Ethernet in
> hardware design and dma driver needs to do some additional handling.

1. why are DT people and list not added to this? I have added that
2. should we have a property for a specific peripheral? Wouldn't it help to have
a generic property for peripheral connected which can be scaled to more IPs
being connected in future?
3. Please use right subsystem name, it damengine: not dma:

> 
> Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
> ---
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfa..5d592e3 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -42,6 +42,7 @@ Optional properties:
>  	the hardware.
>  Optional properties for AXI DMA:
>  - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
> +- xlnx,axieth-connected: Tells whether AXI DMA is connected to AXI Ethernet.
>  Optional properties for VDMA:
>  - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
>  	It takes following values:
> -- 
> 1.7.1
> 

-- 
~Vinod

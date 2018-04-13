Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeDMD6H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 23:58:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:1746 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbeDMD6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 23:58:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="scan'208";a="220061837"
Date: Fri, 13 Apr 2018 09:32:33 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: stm32-mdma: Fix incomplete Hw
 descriptors allocator
Message-ID: <20180413040233.GJ6014@localhost>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 04:44:39PM +0200, Pierre-Yves MORDRET wrote:

>  struct stm32_mdma_desc {
>  	struct virt_dma_desc vdesc;
>  	u32 ccr;
> -	struct stm32_mdma_hwdesc *hwdesc;
> -	dma_addr_t hwdesc_phys;
>  	bool cyclic;
>  	u32 count;
> +	struct stm32_mdma_desc_node node[];

some ppl use node[0] for this but i think either is fine..

>  static void stm32_mdma_dump_hwdesc(struct stm32_mdma_chan *chan,
> -				   struct stm32_mdma_hwdesc *hwdesc)
> +				   struct stm32_mdma_desc_node *node)
>  {
> -	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", hwdesc->ctcr);

> +	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);

this is noise for this patch and IIUC you should be able to pass
node->hwdesc and keep fn same?

-- 
~Vinod

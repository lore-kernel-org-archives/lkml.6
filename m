Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDKJcK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:32:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:30212 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeDKJcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:32:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="46011642"
Date: Wed, 11 Apr 2018 15:06:34 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dan.j.williams@intel.com, eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <20180411093634.GC6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 03:46:06PM +0800, Baolin Wang wrote:

> +/*
> + * struct sprd_dma_config - DMA configuration structure
> + * @config: dma slave channel config
> + * @fragment_len: specify one fragment transfer length
> + * @block_len: specify one block transfer length
> + * @transcation_len: specify one transcation transfer length
> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
> + * @wrap_to: wrap jump to address
> + * @req_mode: specify the DMA request mode
> + * @int_mode: specify the DMA interrupt type
> + */
> +struct sprd_dma_config {
> +	struct dma_slave_config config;
> +	u32 fragment_len;

why not use _maxburst?

> +	u32 block_len;
> +	u32 transcation_len;

what does block and transaction len refer to here

> +	phys_addr_t wrap_ptr;
> +	phys_addr_t wrap_to;

this sound sg_list to me, why are we not using that here

> +	enum sprd_dma_req_mode req_mode;

Looking at definition of request mode we have frag, block, transaction list
etc.. That should depend upon dma request. If you have been asked to
transfer a list, you shall configure list mode. if it is a single
transaction then it should be transaction mode!

> +	enum sprd_dma_int_type int_mode;

Here again I think driver needs to take a call based on dma_ctrl_flags.

Okay I dont think we are proceeding in right direction on this one. This
seems to be fairly generic dma controller and in line with other IP blocks
and you should take reference from those one. I dont think we need this
configuration and can do with generic api and configuration provided.

Thanks
-- 
~Vinod

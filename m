Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeDKJEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:04:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:61920 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752140AbeDKJE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:04:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="45276519"
Date: Wed, 11 Apr 2018 14:38:55 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc: dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, radheys@xilinx.com, lars@metafoo.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/6] dmaengine: xilinx_dma: Pass AXI4-Stream control words
 to netdev dma client
Message-ID: <20180411090854.GY6014@localhost>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
 <1522665546-10035-3-git-send-email-radheys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522665546-10035-3-git-send-email-radheys@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 04:09:02PM +0530, Radhey Shyam Pandey wrote:

> +
> +		if (chan->xdev->has_axieth_connected) {
> +			seg = list_first_entry(&desc->segments,
> +					struct xilinx_axidma_tx_segment, node);
> +			if (cb.callback_param) {
> +				app_w = (u32 *) cb.callback_param;

why are you interpreting callback_param? This is plainly wrong.
we do not know what is the interpretation of callback_param and it is
internal to submitter.

What exactly is the problem you are trying to solve?

> +				hw = &seg->hw;
> +				*app_w = hw->status & XILINX_DMA_MAX_TRANS_LEN;
> +				memcpy(app_w, hw->app, sizeof(u32) *
> +					XILINX_DMA_NUM_APP_WORDS);
> +			}

-- 
~Vinod

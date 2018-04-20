Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbeDTJqJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:46:09 -0400
Received: from verein.lst.de ([213.95.11.211]:41208 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754519AbeDTJqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:46:07 -0400
Date: Fri, 20 Apr 2018 11:47:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dma-direct: Try reallocation with GFP_DMA32 if
        possible
Message-ID: <20180420094702.GA6530@lst.de>
References: <20180416151819.27520-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416151819.27520-1-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 05:18:19PM +0200, Takashi Iwai wrote:
> As the recent swiotlb bug revealed, we seem to have given up the
> direct DMA allocation too early and felt back to swiotlb allocation.
> The reason is that swiotlb allocator expected that dma_direct_alloc()
> would try harder to get pages even below 64bit DMA mask with
> GFP_DMA32, but the function doesn't do that but only deals with
> GFP_DMA case.
> 
> This patch adds a similar fallback reallocation with GFP_DMA32 as
> we've done with GFP_DMA.  The condition is that the coherent mask is
> smaller than 64bit (i.e. some address limitation), and neither GFP_DMA
> nor GFP_DMA32 is set beforehand.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
> 
> This is a resend of a test patch included in the previous thread
> ("swiotlb: Fix unexpected swiotlb_alloc_coherent() failures").

I like the patch, but as-is it doesn't apply.  Can you resend it against
latest Linus' tree?

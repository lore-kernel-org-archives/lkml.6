Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeCXRDx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:03:53 -0400
Received: from verein.lst.de ([213.95.11.211]:57066 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbeCXRDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:03:52 -0400
Date: Sat, 24 Mar 2018 18:03:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, mingo@elte.hu,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
        CONFIG_DMA_DIRECT_OPS
Message-ID: <20180324170351.GA511@lst.de>
References: <20180323174930.17767-1-hch@lst.de> <20180323185707.GD25533@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323185707.GD25533@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 02:57:07PM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 23, 2018 at 06:49:30PM +0100, Christoph Hellwig wrote:
> > Otherwise we might get unused symbol warnings for configs that built
> > swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
> > CONFIG_DMA_DIRECT_OPS, which is possible on arm.
> > 
> > Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> 
> Alternatively could we set the Kconfig to slect DMA_DIRECT_OPS?


IFF we build swiotlb.c only for xen-swiotlb we don't need DMA_DIRECT_OPS.
IF you are fine with just requring it as well that would be doable nicely
only if we consolidate to a single defintion of CONFIG_SWIOTLB instead
of one per architecture.  Which is something we should do anyway,
so I'll look into it once I get some time.

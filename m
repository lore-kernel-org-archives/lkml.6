Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeCZNnC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:43:02 -0400
Received: from verein.lst.de ([213.95.11.211]:35421 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbeCZNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:43:01 -0400
Date: Mon, 26 Mar 2018 15:42:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, mingo@elte.hu,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
        CONFIG_DMA_DIRECT_OPS
Message-ID: <20180326134259.GA15387@lst.de>
References: <20180323174930.17767-1-hch@lst.de> <20180323185707.GD25533@char.us.oracle.com> <20180324170351.GA511@lst.de> <20180324200545.GC23658@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324200545.GC23658@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 04:05:45PM -0400, Konrad Rzeszutek Wilk wrote:
> > > > Otherwise we might get unused symbol warnings for configs that built
> > > > swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
> > > > CONFIG_DMA_DIRECT_OPS, which is possible on arm.
> > > > 
> > > > Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
> > > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > 
> > > Alternatively could we set the Kconfig to slect DMA_DIRECT_OPS?
> > 
> > 
> > IFF we build swiotlb.c only for xen-swiotlb we don't need DMA_DIRECT_OPS.
> 
> I don't think there is ever an case where you want a Xen specific build.

arm never uses swiotlb directly, so any swiotlb.c build on arm is purely
for xen-swiotlb.c

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeCWTln (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:41:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWTll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:41:41 -0400
Date: Fri, 23 Mar 2018 20:41:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
cc: Christoph Hellwig <hch@lst.de>, mingo@elte.hu,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
 CONFIG_DMA_DIRECT_OPS
In-Reply-To: <20180323185707.GD25533@char.us.oracle.com>
Message-ID: <alpine.DEB.2.21.1803232039460.1481@nanos.tec.linutronix.de>
References: <20180323174930.17767-1-hch@lst.de> <20180323185707.GD25533@char.us.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Konrad Rzeszutek Wilk wrote:

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

You only want to do that when you actually need the code. If not it's a
pointless exercise.

But Christoph change makes sense independent of that because the next
oddball Kconfig will come along sooner than later and run into the very
same problem.

Thanks,

	tglx

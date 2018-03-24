Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeCYFdy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 01:33:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58714 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbeCYFdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 01:33:53 -0400
Date: Sat, 24 Mar 2018 16:05:45 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, mingo@elte.hu, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
 CONFIG_DMA_DIRECT_OPS
Message-ID: <20180324200545.GC23658@char.us.oracle.com>
References: <20180323174930.17767-1-hch@lst.de>
 <20180323185707.GD25533@char.us.oracle.com>
 <20180324170351.GA511@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324170351.GA511@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8842 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803250060
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 06:03:51PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 23, 2018 at 02:57:07PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Fri, Mar 23, 2018 at 06:49:30PM +0100, Christoph Hellwig wrote:
> > > Otherwise we might get unused symbol warnings for configs that built
> > > swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
> > > CONFIG_DMA_DIRECT_OPS, which is possible on arm.
> > > 
> > > Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > 
> > Alternatively could we set the Kconfig to slect DMA_DIRECT_OPS?
> 
> 
> IFF we build swiotlb.c only for xen-swiotlb we don't need DMA_DIRECT_OPS.

I don't think there is ever an case where you want a Xen specific build.

> IF you are fine with just requring it as well that would be doable nicely
> only if we consolidate to a single defintion of CONFIG_SWIOTLB instead
> of one per architecture.  Which is something we should do anyway,
> so I'll look into it once I get some time.

Sounds good. Thank you.

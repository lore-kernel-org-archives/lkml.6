Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeDYG7c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:59:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeDYG7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:59:31 -0400
Date: Tue, 24 Apr 2018 23:59:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Rientjes <rientjes@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] dma mapping fixes for 4.17-rc3
Message-ID: <20180425065930.GA16791@infradead.org>
References: <20180425052225.GA2350@infradead.org>
 <alpine.DEB.2.21.1804242352290.51102@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804242352290.51102@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 11:54:26PM -0700, David Rientjes wrote:
> Shouldn't that test for dev->coherent_dma_mask < DMA_BIT_MASK(32) be more 
> accurately <=? 

No, it should really be <.  The exactly 32-bit case is already covered
with GFP_DMA32.  Eventualy it should be < 24-bit with a separate
GFP_DMA32 case for > 32-bit && < 64-bit.  Takashi has been working on
that, but it is 4.18 material.

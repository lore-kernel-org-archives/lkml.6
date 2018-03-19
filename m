Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030415AbeCSSGG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:06:06 -0400
Received: from verein.lst.de ([213.95.11.211]:59574 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965570AbeCSQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:45 -0400
Date: Mon, 19 Mar 2018 17:03:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
        x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 12/14] dma-direct: handle the memory encryption bit in
        common code
Message-ID: <20180319160343.GA29002@lst.de>
References: <20180319103826.12853-1-hch@lst.de> <20180319103826.12853-13-hch@lst.de> <dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com> <20180319152442.GA27915@lst.de> <5316b479-7e75-d62f-6b17-b6bece55187c@arm.com> <20180319154832.GD14916@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319154832.GD14916@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 03:48:33PM +0000, Will Deacon wrote:
> Why can't we just resolve the conflict by adding the underscores?

We can solve the conflict easily that way.  But that's not the point.

The point is that I've been fighting hard to consolidate dma code
given that the behavior really is common and not arch specific.  And
this one is another case like that:  the fact that the non-coherent
dma boundary is bigger than the exposed size is something that can
easily happen elsewhere, so there is no need to duplicate a lot
of code for that.

Nevermind that the commit should at least be three different patches:

 (1) revert the broken original commit
 (2) increase the dma min alignment
 (3) put the swiotlb workaround in place

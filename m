Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755823AbeCSPYo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:24:44 -0400
Received: from verein.lst.de ([213.95.11.211]:59280 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755793AbeCSPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:24:43 -0400
Date: Mon, 19 Mar 2018 16:24:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 12/14] dma-direct: handle the memory encryption bit in
        common code
Message-ID: <20180319152442.GA27915@lst.de>
References: <20180319103826.12853-1-hch@lst.de> <20180319103826.12853-13-hch@lst.de> <dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd05dd14-9969-7985-826e-f440c3fc4c08@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 03:19:04PM +0000, Robin Murphy wrote:
> As a heads-up, I've just realised there's now a silent (but build-breaking) 
> conflict with the current arm64 queue brewing here, as we've unfortunately 
> had to reintroduce ARCH_HAS_PHYS_TO_DMA as a means of being safe against an 
> ugly architectural corner case - currently commit 1f85b42a691c ("arm64: 
> Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)") in -next.

Please revert that arm64 commit.  This condition should be handled
in common code as it is not arm specific.  And next time please CC
the iommu list and dma-mapping maintainers before doing such a change.

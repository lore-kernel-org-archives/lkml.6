Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756307AbeDFOO6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:14:58 -0400
Received: from verein.lst.de ([213.95.11.211]:55460 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756287AbeDFOOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:14:54 -0400
Date: Fri, 6 Apr 2018 16:14:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: hch@lst.de, thomas.lendacky@amd.com, tglx@linutronix.de,
        dwmw2@infradead.org, joro@8bytes.org, jdmason@kudzu.us,
        konrad.wilk@oracle.com, torvalds@linux-foundation.org, mulix@mulix.org,
        peterz@infradead.org, iommu@lists.linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi
        (commit 6e4bf5867783)
Message-ID: <20180406141452.GA29724@lst.de>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405205657.GA1788@light.dominikbrodowski.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

can you try current Linus' master with the following hack applied and
see if that works?

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 47aeb04c1997..32aacd0d56a8 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -1087,6 +1087,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.unmap_sg		= swiotlb_unmap_sg_attrs,
 	.map_page		= swiotlb_map_page,
 	.unmap_page		= swiotlb_unmap_page,
-	.dma_supported		= swiotlb_dma_supported,
+	.dma_supported		= dma_direct_supported,
 };
 #endif /* CONFIG_DMA_DIRECT_OPS */

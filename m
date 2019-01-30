Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5265C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0292184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfA3QXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:23:43 -0500
Received: from 8bytes.org ([81.169.241.247]:35946 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfA3QXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:23:42 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D86625B8; Wed, 30 Jan 2019 17:23:40 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:23:39 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] iommu/vt-d: Implement dma_[un]map_resource()
Message-ID: <20190130162339.d7uiqikoo7plthfs@8bytes.org>
References: <20190122213045.5667-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122213045.5667-1-logang@deltatee.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 02:30:45PM -0700, Logan Gunthorpe wrote:
> Currently the Intel IOMMU uses the default dma_[un]map_resource()
> implementations does nothing and simply returns the physical address
> unmodified.
> 
> However, this doesn't create the IOVA entries necessary for addresses
> mapped this way to work when the IOMMU is enabled. Thus, when the
> IOMMU is enabled, drivers relying on dma_map_resource() will trigger
> DMAR errors. We see this when running ntb_transport with the IOMMU
> enabled, DMA, and switchtec hardware.
> 
> The implementation for intel_map_resource() is nearly identical to
> intel_map_page(), we just have to re-create __intel_map_single().
> dma_unmap_resource() uses intel_unmap_page() directly as the
> functions are identical.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>

Applied, thanks.

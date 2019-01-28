Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BDD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA1Hxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:53:33 -0500
Received: from verein.lst.de ([213.95.11.211]:38327 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfA1Hxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:53:33 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 409897F07E; Mon, 28 Jan 2019 08:53:31 +0100 (CET)
Date:   Mon, 28 Jan 2019 08:53:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: implement generic dma_map_ops for IOMMUs
Message-ID: <20190128075331.GA3667@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance to get a review on this one?

On Mon, Jan 14, 2019 at 10:41:40AM +0100, Christoph Hellwig wrote:
> Hi Robin,
> 
> please take a look at this series, which implements a completely generic
> set of dma_map_ops for IOMMU drivers.  This is done by taking the
> existing arm64 code, moving it to drivers/iommu and then massaging it
> so that it can also work for architectures with DMA remapping.  This
> should help future ports to support IOMMUs more easily, and also allow
> to remove various custom IOMMU dma_map_ops implementations, like Tom
> was planning to for the AMD one.
> 
> A git tree is also available at:
> 
>     git://git.infradead.org/users/hch/misc.git dma-iommu-ops
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---

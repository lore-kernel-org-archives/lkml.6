Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942AFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB9D21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfBAQQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:16:40 -0500
Received: from verein.lst.de ([213.95.11.211]:35697 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:16:40 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 841E168D93; Fri,  1 Feb 2019 17:16:38 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:16:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
Message-ID: <20190201161638.GJ6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-4-hch@lst.de> <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:24:45PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> Directly iterating over the pages makes the code a bit simpler and
>> prepares for the following changes.
>
> It also defeats the whole purpose of __iommu_dma_alloc_pages(), so I'm not 
> really buying the simplification angle - you've *seen* that code, right? ;)

How does it defeat the purpose of __iommu_dma_alloc_pages?


Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F2B20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F2B20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLKJah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:30:37 -0500
Received: from 8bytes.org ([81.169.241.247]:53000 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeLKJag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:30:36 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C044D3AF; Tue, 11 Dec 2018 10:30:34 +0100 (CET)
Date:   Tue, 11 Dec 2018 10:30:30 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        ganapatrao.kulkarni@cavium.com, hch@lst.de,
        m.szyprowski@samsung.com, linuxarm@huawei.com
Subject: Re: [PATCH v4] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Message-ID: <20181211093030.3x532vs6dwz2ucp7@8bytes.org>
References: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 07:14:00PM +0800, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
> respective device NUMA node. The ternary operator which would be for
> alloc_pages_node() is tidied along with this.
> 
> The motivation for this change is to have a policy for page allocation
> consistent with direct DMA mapping, which attempts to allocate pages local
> to the device, as mentioned in [1].
> 
> In addition, for certain workloads it has been observed a marginal
> performance improvement. The patch caused an observation of 0.9% average
> throughput improvement for running tcrypt with HiSilicon crypto engine.
> 
> We also include a modification to use kvzalloc() for kzalloc()/vzalloc()
> combination.
> 
> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1692998.html
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> [JPG: Added kvzalloc(), drop pages ** being device local, remove ternary operator, update message]
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied, thanks.

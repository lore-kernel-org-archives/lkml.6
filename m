Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528B52147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528B52147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbeKVCmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:42:05 -0500
Received: from foss.arm.com ([217.140.101.70]:53908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbeKVCmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:42:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 310991D70;
        Wed, 21 Nov 2018 08:07:03 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01A493F5CF;
        Wed, 21 Nov 2018 08:07:03 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B60F21AE100A; Wed, 21 Nov 2018 16:07:18 +0000 (GMT)
Date:   Wed, 21 Nov 2018 16:07:18 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        ganapatrao.kulkarni@cavium.com, hch@lst.de,
        m.szyprowski@samsung.com, linuxarm@huawei.com
Subject: Re: [PATCH v3] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Message-ID: <20181121160718.GB24883@arm.com>
References: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542812051-178935-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:54:10PM +0800, John Garry wrote:
> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> 
> Change function __iommu_dma_alloc_pages() to allocate pages for DMA from
> respective device NUMA node. The ternary operator which would be for
> alloc_pages_node() is tidied along with this.
> 
> We also include a change to use kvzalloc() for kzalloc()/vzalloc()
> combination.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> [JPG: Added kvzalloc(), drop pages ** being device local, tidied ternary operator]
> Signed-off-by: John Garry <john.garry@huawei.com>

Weird, you're missing a diffstat here.

Anyway, the patch looks fine to me, but it would be nice if you could
justify the change with some numbers. Do you actually see an improvement
from this change?

Will

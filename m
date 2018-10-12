Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21053C67879
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BE821470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BE821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJMAhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:37:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54832 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeJMAhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:37:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27EDAF;
        Fri, 12 Oct 2018 10:04:16 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7E823F5D3;
        Fri, 12 Oct 2018 10:04:14 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:04:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/10] swiotlb: remove the overflow buffer
Message-ID: <20181012170411.GB60150@arrakis.emea.arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:02:40AM +0200, Christoph Hellwig wrote:
> Like all other dma mapping drivers just return an error code instead
> of an actual memory buffer.  The reason for the overflow buffer was
> that at the time swiotlb was invented there was no way to check for
> dma mapping errors, but this has long been fixed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/mm/dma-mapping.c       |  2 +-
>  arch/powerpc/kernel/dma-swiotlb.c |  4 +--
>  include/linux/dma-direct.h        |  2 ++
>  include/linux/swiotlb.h           |  3 --
>  kernel/dma/direct.c               |  2 --
>  kernel/dma/swiotlb.c              | 59 ++-----------------------------
>  6 files changed, 8 insertions(+), 64 deletions(-)

I went through the patches and they look fine to me (with the vunmap
fix for the last patch). For the arm64 bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

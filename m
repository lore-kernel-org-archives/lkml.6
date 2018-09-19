Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3C3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A798620880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeISUkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:40:05 -0400
Received: from verein.lst.de ([213.95.11.211]:54109 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbeISUkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:40:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E8C8E68D83; Wed, 19 Sep 2018 17:01:48 +0200 (CEST)
Date:   Wed, 19 Sep 2018 17:01:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dma_get_required_mask tidyups
Message-ID: <20180919150148.GA29588@lst.de>
References: <20180910061332.28187-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910061332.28187-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?  I have a a few things piled up that base on this, so
some forward progress would be great.

On Mon, Sep 10, 2018 at 08:13:29AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> the dma_get_required_mask dma API implementation has always been a little
> odd, in that we by default don't wire it up struct dma_map_ops, but
> instead hard code a default implementation.  powerpc and ia64 override
> this default and either call a method or otherwise duplicate the default.
> 
> This series always enabled the method and just falls back to the previous
> default implementation when it is not available, as well as fixing up
> a few bits in the default implementations.  This already allows removing
> the ia64 override of the implementation, and will also allow to remove
> the powerpc one together with a few additional cleanups in the powerpc
> code, but those will be sent separately with other powerpc DMA API
> patches.  Last but not least the method will allow us to return a more
> sensible value for typical iommu dma_ops eventually, but that is left
> to another series as well.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---

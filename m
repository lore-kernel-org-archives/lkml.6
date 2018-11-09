Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F4CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD092081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD092081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeKIRcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:32:02 -0500
Received: from verein.lst.de ([213.95.11.211]:60409 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeKIRcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:32:02 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9897468C48; Fri,  9 Nov 2018 08:52:38 +0100 (CET)
Date:   Fri, 9 Nov 2018 08:52:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: move the arm arch_dma_alloc implementation to common code
Message-ID: <20181109075238.GA27578@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I get a quick review from the arm64 folks?  I think it should
be fine there as it basically is a code move, but an additional pair
or two of eyes always helps to weed out bugs.

On Mon, Nov 05, 2018 at 01:19:22PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series moves the existing arm64 implementation of arch_dma_alloc and
> arch_dma_free to common code given that it is not arm64-specific, and
> then also uses it for csky.  Given how many architectures remap memory
> for the DMA coherent implementation it should be usable for many more,
> and the new cache flushing hook and the generic atomic pool are also
> enablers for implementing the IOMMU API dma ops in common code in a
> follow on series.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---

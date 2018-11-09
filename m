Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8CEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8E220840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8E220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeKIRbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:31:22 -0500
Received: from verein.lst.de ([213.95.11.211]:60404 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeKIRbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:31:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A829268C48; Fri,  9 Nov 2018 08:51:58 +0100 (CET)
Date:   Fri, 9 Nov 2018 08:51:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] csky: use the generic remapping dma alloc
 implementation
Message-ID: <20181109075158.GB27489@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-10-hch@lst.de> <20181106070140.GA6232@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106070140.GA6232@guoren-Inspiron-7460>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:01:41PM +0800, Guo Ren wrote:
> > +	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> >  }
> >  postcore_initcall(atomic_pool_init);
> Seems also could remove atomic_pool_init from csky, why not put them in
> common?

The code basically moved to common code, but the architecture needs
to pick the gfp mask (GFP_DMA32 on arm vs GFP_KERNEL on csky for example)
and the pgprot it needs for uncached remappings.

> Reviewed-by: Guo Ren <ren_guo@c-sky.com>
> 
> Compile is OK, qemu boot OK. Functions are the same and just move to common.

Thanks for your review!

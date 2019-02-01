Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94742218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfBAQMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:12:05 -0500
Received: from verein.lst.de ([213.95.11.211]:35670 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:12:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D614968D93; Fri,  1 Feb 2019 17:12:02 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:12:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] dma-mapping: add a Kconfig symbol to indicated
 arch_dma_prep_coherent presence
Message-ID: <20190201161202.GH6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-2-hch@lst.de> <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:22:46PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> Add a Kconfig symbol that indicates an architecture provides a
>> arch_dma_prep_coherent implementation, and provide a stub otherwise.
>>
>> This will allow the generic dma-iommu code to it while still allowing
>> to be built for cache coherent architectures.
>
> I've been pondering this for a while now, and I still can't really come up 
> with a case where arch_dma_prep_coherent() would need to behave differently 
> from arch_sync_dma_for_device(..., DMA_BIDIRECTIONAL). I wonder if we could 
> just save ourselves this little bit of complexity by using that instead...

A lot of architectures do really weird stuff in the dma sync routines.
So my plan would be to consolidate a lot more logic in there first,
and then maybe as a next step we could look into using
arch_sync_dma_for_device eventually.

Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FAA2081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FAA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLHMs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:48:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:41836 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeLHMs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:48:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wAU3HgS0007716;
        Thu, 29 Nov 2018 21:17:44 -0600
Message-ID: <53c18168393e3134f7e4120a2528f972b1002c01.camel@kernel.crashing.org>
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 14:17:42 +1100
In-Reply-To: <20181127074253.GB30186@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
         <20181127074253.GB30186@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 08:42 +0100, Christoph Hellwig wrote:
> Any comments?  I'd like to at least get the ball moving on the easy
> bits.

So I had to cleanup some dust but it works on G5 with and without iommu
and 32-bit powermacs at least.

We're doing more tests, hopefully mpe can dig out some PASemi and
NXP/FSL HW as well. I'll try to review & ack the patches over the next
few days too.

Cheers,
Ben.

> On Wed, Nov 14, 2018 at 09:22:40AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series switches the powerpc port to use the generic swiotlb and
> > noncoherent dma ops, and to use more generic code for the coherent
> > direct mapping, as well as removing a lot of dead code.
> > 
> > As this series is very large and depends on the dma-mapping tree I've
> > also published a git tree:
> > 
> >     git://git.infradead.org/users/hch/misc.git powerpc-dma.4
> > 
> > Gitweb:
> > 
> >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4
> > 
> > Changes since v3:
> >  - rebase on the powerpc fixes tree
> >  - add a new patch to actually make the baseline amigaone config
> >    configure without warnings
> >  - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
> >    always present
> >  - fix compile in mem.c for one configuration
> >  - drop the full npu removal for now, will be resent separately
> >  - a few git bisection fixes
> > 
> > The changes since v1 are to big to list and v2 was not posted in public.
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---


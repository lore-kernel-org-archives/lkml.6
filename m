Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78796C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483F1208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483F1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeK0Sjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:39:53 -0500
Received: from verein.lst.de ([213.95.11.211]:57128 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbeK0Sjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:39:53 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 74ADD68BDB; Tue, 27 Nov 2018 08:42:53 +0100 (CET)
Date:   Tue, 27 Nov 2018 08:42:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181127074253.GB30186@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?  I'd like to at least get the ball moving on the easy
bits.

On Wed, Nov 14, 2018 at 09:22:40AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series switches the powerpc port to use the generic swiotlb and
> noncoherent dma ops, and to use more generic code for the coherent
> direct mapping, as well as removing a lot of dead code.
> 
> As this series is very large and depends on the dma-mapping tree I've
> also published a git tree:
> 
>     git://git.infradead.org/users/hch/misc.git powerpc-dma.4
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4
> 
> Changes since v3:
>  - rebase on the powerpc fixes tree
>  - add a new patch to actually make the baseline amigaone config
>    configure without warnings
>  - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
>    always present
>  - fix compile in mem.c for one configuration
>  - drop the full npu removal for now, will be resent separately
>  - a few git bisection fixes
> 
> The changes since v1 are to big to list and v2 was not posted in public.
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---

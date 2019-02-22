Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC96C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC502070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfBVMts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:49:48 -0500
Received: from verein.lst.de ([213.95.11.211]:43943 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfBVMts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:49:48 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BB8E768CEC; Fri, 22 Feb 2019 13:49:46 +0100 (CET)
Date:   Fri, 22 Feb 2019 13:49:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the
 dma-mapping tree
Message-ID: <20190222124946.GA29125@lst.de>
References: <20190222091728.6d3d9877@canb.auug.org.au> <87ef80pjwy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef80pjwy.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 02:43:41PM +1100, Michael Ellerman wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > Hi all,
> >
> > Today's linux-next merge of the powerpc tree got a conflict in:
> >
> >   arch/powerpc/kernel/dma-swiotlb.c
> >
> > between commit:
> >
> >   cfced786969c ("dma-mapping: remove the default map_resource implementation")
> >
> > from the dma-mapping tree and commit:
> >
> >   68005b67d15a ("powerpc/dma: use the generic direct mapping bypass")
> >
> > from the powerpc tree.
> >
> > I fixed it up (I just used the latter) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> 
> Thanks.
> 
> Christoph, I've put the powerpc dma changes in a topic branch if you
> want to merge it to reduce the conflicts. Up to you.

Thanks.  I think the conflicts are pretty harmless as we are mostly
removing code entirely in the powerpc tree that the dma-mapping tree
touches.

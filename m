Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917C8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4904E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IOlYdRrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4904E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753475AbeFTEeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:34:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFTEeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1vH85kXQFrRjbgVqqeJSFHQo1U3r6NK3DBp7RWNvaVI=; b=IOlYdRrdUq119lgOUjBFENX0c
        7A8YeVGpeApXBHDthoa3DlavPbVhge5N3nL5ZZPFfLDy5tbJ2TxzHl1bRbUbLMkcAZc0mf7g8Skik
        RePxX0/KHd7kDpZE5NIRJw3zJhgfg7TkMYHufpetqtEthOmgO+PMug5Cg7/fCbdT96Org9lwU6lk5
        q/jF9f4tbLd9uYs0USWsjt375Psr5KE7/rmDgeRapcH/0iuJk94hSdcTd5ZyRHnAxF6hx6birMsak
        Q2vSXPkaFOk0ztRpkcedUX49DhE0hWfPqu6Q2bGg0SnTs0bx0n+xH8DF8Qp0RZW+lYt1dufCCkNDs
        yqNdnruEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVUoy-0000ny-Db; Wed, 20 Jun 2018 04:34:16 +0000
Date:   Tue, 19 Jun 2018 21:34:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] dma-mapping file renames for Linux 4.18
Message-ID: <20180620043416.GA27631@infradead.org>
References: <20180619044358.snyej666melspv46@infradead.org>
 <CA+55aFwEZHzxXDdUGwwuw5HYZB9R5CfTv3XKbft46+ai7C_Q7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwEZHzxXDdUGwwuw5HYZB9R5CfTv3XKbft46+ai7C_Q7w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 07:52:53AM +0900, Linus Torvalds wrote:
> On Tue, Jun 19, 2018 at 1:44 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > below is a rename of the assorted dma-mapping files to that they live
> > under kernel/dma and lose their dma-* prefixes.  If there is any time
> > to do this it is right after -rc1, so let me know if this is something
> > you'd take.
> 
> I iwas going to take it, but then I noticed that it's an unsigned tag
> from a random site.
> 
> Yeah, yeah, I have pulled such things in the past, but  I'm really
> trying to convince people to use signed tags.
> 
> I prefer signed tags even on kernel.org, where I know the security is
> tight. On other sites, I really want that warm fuzzy feeling of
> knowing that yeah, you actually put that code there.

In fact it wasn't tagged at all, just a branch as I simplify forgot
to tag it.  Tagged version is here:

The following changes since commit be779f03d563981c65cc7417cc5e0dbbc5b89d30:

  Merge tag 'kbuild-v4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2018-06-13 08:40:34 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-rename-4.18

for you to fetch changes up to cf65a0f6f6ff7631ba0ac0513a14ca5b65320d80:

  dma-mapping: move all DMA mapping code to kernel/dma (2018-06-14 08:50:37 +0200)

----------------------------------------------------------------
Move all the dma-mapping code to kernel/dma

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-mapping: use obj-y instead of lib-y for generic dma ops
      dma-mapping: move all DMA mapping code to kernel/dma

 Documentation/driver-api/infrastructure.rst        |  4 +-
 MAINTAINERS                                        |  9 +---
 drivers/base/Makefile                              |  3 --
 include/linux/dma-contiguous.h                     |  2 +-
 init/Kconfig                                       |  4 --
 kernel/Makefile                                    |  1 +
 kernel/dma/Kconfig                                 | 50 ++++++++++++++++++++++
 kernel/dma/Makefile                                | 11 +++++
 .../base/dma-coherent.c => kernel/dma/coherent.c   |  0
 .../dma-contiguous.c => kernel/dma/contiguous.c    |  0
 lib/dma-debug.c => kernel/dma/debug.c              |  0
 lib/dma-direct.c => kernel/dma/direct.c            |  0
 drivers/base/dma-mapping.c => kernel/dma/mapping.c |  2 +-
 lib/dma-noncoherent.c => kernel/dma/noncoherent.c  |  0
 {lib => kernel/dma}/swiotlb.c                      |  0
 lib/dma-virt.c => kernel/dma/virt.c                |  2 -
 lib/Kconfig                                        | 47 +-------------------
 lib/Makefile                                       |  6 ---
 18 files changed, 69 insertions(+), 72 deletions(-)
 create mode 100644 kernel/dma/Kconfig
 create mode 100644 kernel/dma/Makefile
 rename drivers/base/dma-coherent.c => kernel/dma/coherent.c (100%)
 rename drivers/base/dma-contiguous.c => kernel/dma/contiguous.c (100%)
 rename lib/dma-debug.c => kernel/dma/debug.c (100%)
 rename lib/dma-direct.c => kernel/dma/direct.c (100%)
 rename drivers/base/dma-mapping.c => kernel/dma/mapping.c (99%)
 rename lib/dma-noncoherent.c => kernel/dma/noncoherent.c (100%)
 rename {lib => kernel/dma}/swiotlb.c (100%)
 rename lib/dma-virt.c => kernel/dma/virt.c (98%)

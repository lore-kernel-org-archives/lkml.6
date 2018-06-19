Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B19220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsnfj8m2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B19220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbeFSEoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:44:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeFSEoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lpiOEoN0tnNeupWMcASW5+UoQgmZUij+2yCaDmaxPRo=; b=gsnfj8m2hjlvGcr7XgEEIptWKw
        v/k1PftP2iuv5IPXVVvajtmsALJ1I69spvsJ4Wh1OzvcIVhSAWVqNK9ztp8kipy2gKDC0Dga9Zv8j
        56shE9An7l5nVAHUIXwT8lCGbQrfP1VBOEiSPMFbONy5JTTL9deyrghZTzHbn0oFjInTe3d/KymBd
        07Ey2NvcxkzEnVCbV0e3jCtEXpZcG/oP/xYBdVOZiV+b49SrtMprJsYq+MrYCEgm8ZsZR3vPHsQKG
        C/wvZfzV7XFh9Syqs3+fwp8X1hxS6dCEkd6lWdFZQg08wxBjVQccHt+ri7fc2RxCWLmn4bZD1yrRC
        tFqNubew==;
Received: from 089144192009.atnat0001.highway.a1.net ([89.144.192.9] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fV8Us-0004r5-1W; Tue, 19 Jun 2018 04:44:02 +0000
Date:   Tue, 19 Jun 2018 06:43:58 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping file renames for Linux 4.18
Message-ID: <20180619044358.snyej666melspv46@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

below is a rename of the assorted dma-mapping files to that they live
under kernel/dma and lose their dma-* prefixes.  If there is any time
to do this it is right after -rc1, so let me know if this is something
you'd take.


The following changes since commit be779f03d563981c65cc7417cc5e0dbbc5b89d30:

  Merge tag 'kbuild-v4.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2018-06-13 08:40:34 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git for-linus

for you to fetch changes up to cf65a0f6f6ff7631ba0ac0513a14ca5b65320d80:

  dma-mapping: move all DMA mapping code to kernel/dma (2018-06-14 08:50:37 +0200)

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeDYFWg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:22:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeDYFWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:22:32 -0400
Date: Wed, 25 Apr 2018 07:22:25 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma mapping fixes for 4.17-rc3
Message-ID: <20180425052225.GA2350@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17-3

for you to fetch changes up to 60695be2bb6b0623f8e53bd9949d582a83c6d44a:

  dma-mapping: postpone cpu addr translation on mmap (2018-04-23 14:44:24 +0200)

----------------------------------------------------------------
A few small dma-mapping fixes for Linux 4.17-rc3:

 - don't loop to try GFP_DMA allocations if ZONE_DMA is not actually
   enabled (regression in 4.16)
 - don't try to do virt_to_page before we know we actuall have a
   valid page in dma_common_mmap
 - a comment fixup related to the above fix

----------------------------------------------------------------
Jacopo Mondi (1):
      dma-mapping: postpone cpu addr translation on mmap

Robin Murphy (1):
      dma-coherent: clarify dma_mmap_from_dev_coherent documentation

Takashi Iwai (1):
      dma-direct: don't retry allocation for no-op GFP_DMA

 drivers/base/dma-coherent.c | 5 +++--
 drivers/base/dma-mapping.c  | 6 ++----
 lib/dma-direct.c            | 3 ++-
 3 files changed, 7 insertions(+), 7 deletions(-)

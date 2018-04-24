Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeDXSQg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:16:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeDXSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:16:33 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: remove PCI_DMA_BUS_IS_PHYS V2
Date: Tue, 24 Apr 2018 20:16:20 +0200
Message-Id: <20180424181625.22410-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series tries to get rid of the global and PCI_DMA_BUS_IS_PHYS flag,
which causes the block layer and networking code to bounce buffer memory
above the dma mask in some cases.  It is a leftover from i386 + highmem
days and is obsolete now that we have swiotlb or iommus so that the
dma ops implementations can always (minus the ISA DMA case which
will require further attention) handle memory passed to them.

Changes since V1:
 - dropped all patches not strictly required to remove
   PCI_DMA_BUS_IS_PHYS, those will be resent separately

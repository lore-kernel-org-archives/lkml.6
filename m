Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935483AbeBMOvX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:51:23 -0500
Received: from verein.lst.de ([213.95.11.211]:45400 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935258AbeBMOvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:51:22 -0500
Date: Tue, 13 Feb 2018 15:51:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
Message-ID: <20180213145120.GA14657@lst.de>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does this fix your warning?

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 62f541f968f6..07074820a167 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -375,6 +375,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 	dev->ofdev.dev.of_node = np;
 	dev->ofdev.archdata.dma_mask = 0xffffffffUL;
 	dev->ofdev.dev.dma_mask = &dev->ofdev.archdata.dma_mask;
+	dev->ofdev.dev.coherent_dma_mask = dev->ofdev.archdata.dma_mask;
 	dev->ofdev.dev.parent = parent;
 	dev->ofdev.dev.bus = &macio_bus_type;
 	dev->ofdev.dev.release = macio_release_dev;

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934651AbeBMQqZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:46:25 -0500
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:41984 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934360AbeBMQqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:46:24 -0500
Date: Tue, 13 Feb 2018 18:46:20 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Christoph Hellwig <hch@lst.de>
cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
In-Reply-To: <20180213145120.GA14657@lst.de>
Message-ID: <alpine.LRH.2.21.1802131845580.21385@math.ut.ee>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee> <20180213145120.GA14657@lst.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this fix your warning?
> 
> diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
> index 62f541f968f6..07074820a167 100644
> --- a/drivers/macintosh/macio_asic.c
> +++ b/drivers/macintosh/macio_asic.c
> @@ -375,6 +375,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
>  	dev->ofdev.dev.of_node = np;
>  	dev->ofdev.archdata.dma_mask = 0xffffffffUL;
>  	dev->ofdev.dev.dma_mask = &dev->ofdev.archdata.dma_mask;
> +	dev->ofdev.dev.coherent_dma_mask = dev->ofdev.archdata.dma_mask;
>  	dev->ofdev.dev.parent = parent;
>  	dev->ofdev.dev.bus = &macio_bus_type;
>  	dev->ofdev.dev.release = macio_release_dev;

Yes, it does - thank you!

Tested-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos (mroos@linux.ee)

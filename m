Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967272AbeEYQR2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:17:28 -0400
Received: from verein.lst.de ([213.95.11.211]:37761 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966976AbeEYQR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:17:27 -0400
Date: Fri, 25 May 2018 18:23:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/7] core, dma-direct: add a flag 32-bit dma limits
Message-ID: <20180525162307.GB28900@lst.de>
References: <20180525143512.1466-1-hch@lst.de> <20180525143512.1466-2-hch@lst.de> <20180525145012.GA3863@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525145012.GA3863@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:50:12PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 25, 2018 at 04:35:06PM +0200, Christoph Hellwig wrote:
> > Various PCI bridges (VIA PCI, Xilinx PCIe) limit DMA to only 32-bits
> > even if the device itself supports more.  Add a single bit flag to
> > struct device (to be moved into the dma extension once we around it)
> 
> "once we around it"?  I don't understand, sorry.

Should be "once we get around it", which in proper grammar should
probably be "once we get to it".  Anyway, the point is that right
now struct device is bloated with a lot of fields for dma/iommu
purposes and we need to clean this up.  It's been on my TODO list
for a while.

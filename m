Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeE1GNA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:13:00 -0400
Received: from verein.lst.de ([213.95.11.211]:46968 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbeE1GM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:12:58 -0400
Date: Mon, 28 May 2018 08:19:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 7/7] x86: switch the VIA 32-bit DMA quirk to use the
        struct device flag
Message-ID: <20180528061859.GA4145@lst.de>
References: <20180525143512.1466-1-hch@lst.de> <20180525143512.1466-8-hch@lst.de> <alpine.DEB.2.21.1805280808280.1585@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805280808280.1585@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 08:10:40AM +0200, Thomas Gleixner wrote:
> n Fri, 25 May 2018, Christoph Hellwig wrote:
> 
> x86/pci-dma: ...
> 
> Please
> 
> > Instead of globally disabling > 32bit DMA using the arch_dma_supported
> > hook walk the PCI bus under the actually affected bridge and mark every
> > device with the dma_32bit_limit flag.  This also gets rid of the
> > arch_dma_supported hook entirely.
> 
> Shouldn't this go before the other two? 

Which other two?  The boot optional removal patches?  They just remove
the visible interface, but keep the implementation which is converted
to the better mechanism here, so I think the order makes sense.
But I might be missing something..

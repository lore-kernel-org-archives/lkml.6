Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeBMBps (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:45:48 -0500
Received: from verein.lst.de ([213.95.11.211]:42727 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933102AbeBMBpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:45:47 -0500
Date: Tue, 13 Feb 2018 02:45:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux-foundation.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
Message-ID: <20180213014546.GB3303@lst.de>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 10:52:46PM +0200, Meelis Roos wrote:
> I tested 4.16-rc1 on my PowerMac G4 and got the following warning from 
> macio pata driver. Since pata-macio has no recent changes, dma-mapping.h 
> changes seem to be related.

Thje are, as they add just that warning.  But the root cause looks
older, and that is that the macio bus doesn't seem to to set the
dma coherent mask, which could cause all kinds of hidden issues.

I'm travelling right now, but unless someone beats me to it I'll look
into a patch to properly set the coherent mask ASAP.

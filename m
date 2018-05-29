Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbeE2HFN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:05:13 -0400
Received: from verein.lst.de ([213.95.11.211]:53585 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754661AbeE2HFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:05:09 -0400
Date: Tue, 29 May 2018 09:11:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh
        SONIC based ethernet
Message-ID: <20180529071119.GB32615@lst.de>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net> <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com> <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com> <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com> <alpine.LNX.2.21.1805291047230.13@nippy.intranet> <b4f0d2d7-fcd5-b68f-0bc6-cd41c353aba7@gmail.com> <alpine.LNX.2.21.1805291524080.16@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1805291524080.16@nippy.intranet>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 03:38:23PM +1000, Finn Thain wrote:
> On Tue, 29 May 2018, Michael Schmitz wrote:
> 
> > > 
> > > Since an arch gets to apply limits in the dma ops it implements, why 
> > > would arch code also have to set a limit in the form of default 
> > > platform device masks? Powerpc seems to be the only arch that does 
> > > this.
> > 
> > One of Christoph's recent patches removed most of arches' dma ops, 
> > replacing them by one generic implementation instead. m68k was one of 
> > the affected arches. I concede his patch series is experimental still 
> > and not in mainline, but may be included at some time.
> 
> I found some patches here,
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent.2
> 
> Looks like m68k_dma_alloc() gets renamed arch_dma_alloc() and the generic 
> ops don't use the dma masks.

This is for the 'coherent' allocations, and literatelly nothing changes
for those yet.

But for the mapping path this switches m68k to use the dma-direct
path, wrapped by dma-noncoherent.  And these do check dev->dma_mask,
although only really for sanity checking.

Btw, can I get a review and testing for the above?  They aren't really
experimental any more, and I'd like to move architectures over as soon
as possible.

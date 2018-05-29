Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeE2FiT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:38:19 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:60560 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeE2FiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:38:17 -0400
Date: Tue, 29 May 2018 15:38:23 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
In-Reply-To: <b4f0d2d7-fcd5-b68f-0bc6-cd41c353aba7@gmail.com>
Message-ID: <alpine.LNX.2.21.1805291524080.16@nippy.intranet>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net> <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com> <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com> <alpine.LNX.2.21.1805291047230.13@nippy.intranet> <b4f0d2d7-fcd5-b68f-0bc6-cd41c353aba7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, Michael Schmitz wrote:

> > 
> > Since an arch gets to apply limits in the dma ops it implements, why 
> > would arch code also have to set a limit in the form of default 
> > platform device masks? Powerpc seems to be the only arch that does 
> > this.
> 
> One of Christoph's recent patches removed most of arches' dma ops, 
> replacing them by one generic implementation instead. m68k was one of 
> the affected arches. I concede his patch series is experimental still 
> and not in mainline, but may be included at some time.

I found some patches here,
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent.2

Looks like m68k_dma_alloc() gets renamed arch_dma_alloc() and the generic 
ops don't use the dma masks.

Maybe I'm looking at the wrong patches?

-- 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeE2HCF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:02:05 -0400
Received: from verein.lst.de ([213.95.11.211]:53558 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754609AbeE2HCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:02:03 -0400
Date: Tue, 29 May 2018 09:08:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh
        SONIC based ethernet
Message-ID: <20180529070813.GA32615@lst.de>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net> <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com> <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com> <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com> <CAOmrzkKVu6vPgMgvR9JuR==Q=XmTnDf_iyXfP7sDVymaXDX20Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOmrzkKVu6vPgMgvR9JuR==Q=XmTnDf_iyXfP7sDVymaXDX20Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:59:37AM +1200, Michael Schmitz wrote:
> Hi Geert,
> 
> my preference would be Finn's patch introducing a m68k
> arch_setup_pdev_archdata(). It nicely preserves what bus code sets up
> prior to registering a platform device (important for Zorro devices
> using platform or mfd devices), and allows overriding by drivers that
> need it.

Let's go with those for now.

> 
> If ever a kernel-wide consensus is reached to move this setup to the
> generic arch_setup_pdev_archdata(), we can still back out his patch at
> that time. Finn found one counterexample where absence of DMA mask
> signaled 'do not use DMA', so I think moving the DMA mask setup to
> generic code is unlikely to happen any time.

This is the right thing to do in the long run, and I'll spend some time
auditing all dma_mask users for the next merge window.

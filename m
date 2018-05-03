Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeECIso (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:48:44 -0400
Received: from verein.lst.de ([213.95.11.211]:42992 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeECIsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:48:40 -0400
Date: Thu, 3 May 2018 10:51:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
Message-ID: <20180503085120.GA14574@lst.de>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org> <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com> <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 10:46:56AM +0200, Geert Uytterhoeven wrote:
> Perhaps you can add a new helper (platform_device_register_simple_dma()?)
> that takes the DMA mask, too?
> With people setting the mask to kill the WARNING splat, this may become
> more common.
> 
> struct platform_device_info already has a dma_mask field, but
> platform_device_register_resndata() explicitly sets it to zero.

Yes, that would be useful.  The other assumption could be that
platform devices always allow an all-0xff dma mask.

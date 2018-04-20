Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbeDTO5J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:57:09 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:46126 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755243AbeDTO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:57:02 -0400
Date: Fri, 20 Apr 2018 10:56:21 -0400
From: Rich Felker <dalias@libc.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180420145621.GQ3094@brightrain.aerifal.cx>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180418104703.GA12462@infradead.org>
 <20180418131314.GC3999@w540>
 <20180420083147.GC31275@infradead.org>
 <CAMuHMdWwJrUgOjaAX1oUHd+KFUMuUzcH6g29zC2mJX377oAHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWwJrUgOjaAX1oUHd+KFUMuUzcH6g29zC2mJX377oAHiA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:59:13AM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Fri, Apr 20, 2018 at 10:31 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Wed, Apr 18, 2018 at 03:13:14PM +0200, jacopo mondi wrote:
> >> As long as it goes for arch/sh, the only user of dma_alloc_coherent()
> >> is platform_resource_setup_memory(), and it has been fixed by this
> >> patch.
> >
> > Great!
> >
> >> Unfortunately, as Thomas pointed out, there are drivers which calls
> >> into this with the wrong 'struct device' as the sh_eth one he had fixed.
> >
> > Yes, we'll need fixes there.  Other DMA ops implementations also look
> > at struct device, so they generally are buggy.
> >
> >> I would then say that as long as it goes for the NULL case, we should be
> >> fine now.
> >
> > Then I'd say skil that part, please.
> 
> The major reason for keeping the NULL WARN_ON() checks is to make it
> obvious to the developer what is wrong, and fall back to the old behavior.
> 
> Without the checks, the kernel will just crash during early startup,
> without a clue in the (missing) kernel output, usually leading to a
> frustrating bisection experience (if the developer is sufficiently motivated,
> at all).
> 
> Hence my vote for keeping the checks.

Sounds good to me.

Rich

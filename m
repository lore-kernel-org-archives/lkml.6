Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDIPLd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:11:33 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:45862 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeDIPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:11:31 -0400
Date: Mon, 9 Apr 2018 11:11:13 -0400
From: Rich Felker <dalias@libc.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Robin Murphy <robin.murphy@arm.com>, jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp,
        geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [RFC v2 2/2] base: dma-mapping: Postpone page_to_pfn() on mmap()
Message-ID: <20180409151113.GD3094@brightrain.aerifal.cx>
References: <1510679286-6988-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180409072547.GU20945@w540>
 <7da3f31e-e4ad-7f1a-e66c-0d3e0fb8b27d@arm.com>
 <2555020.mSAUJ9kk90@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2555020.mSAUJ9kk90@avalon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 04:06:15PM +0300, Laurent Pinchart wrote:
> Hello,
> 
> On Monday, 9 April 2018 14:11:22 EEST Robin Murphy wrote:
> > On 09/04/18 08:25, jacopo mondi wrote:
> > > Hi Robin, Laurent,
> > > 
> > >      a long time passed, sorry about this.
> > > 
> > > On Wed, Nov 15, 2017 at 01:38:23PM +0000, Robin Murphy wrote:
> > >> On 14/11/17 17:08, Jacopo Mondi wrote:
> > >>> On SH4 architecture, with SPARSEMEM memory model, translating page to
> > >>> pfn hangs the CPU. Post-pone translation to pfn after
> > >>> dma_mmap_from_dev_coherent() function call as it succeeds and make page
> > >>> translation not necessary.
> > >>> 
> > >>> This patch was suggested by Laurent Pinchart and he's working to submit
> > >>> a proper fix mainline. Not sending for inclusion at the moment.
> > >> 
> > >> Y'know, I think this patch does have some merit by itself - until we know
> > >> that cpu_addr *doesn't* represent some device-private memory which is not
> > >> guaranteed to be backed by a struct page, calling virt_to_page() on it is
> > >> arguably semantically incorrect, even if it might happen to be benign in
> > >> most cases.
> > > 
> > > I still need to carry this patch in my trees to have a working dma memory
> > > mapping on SH4 platforms. My understanding from your comment is that
> > > there may be a way forward for this patch, do you still think the same?
> > > Have you got any suggestion on how to improve this eventually for
> > > inclusion?
> > 
> > As before, the change itself does seem reasonable; it might be worth
> > rewording the commit message in more general terms rather than making it
> > sound like an SH-specific workaround (which I really don't think it is),
> > but otherwise I'd say just repost it as a non-RFC patch.
> 
> I actually can't remember any better fix I would have in mind, so this looks 
> good to me :-) I agree with Robin, the commit message should be reworded. 
> Robin's explanation of why virt_to_page() should be postponed until we know 
> that cpu_addr represents memory that is guaranteed to be backed by a struct 
> page is a good starting point. You can mention SH4 as an example of an 
> architecture that will crash when calling virt_to_page() in such a case, but 
> the fix isn't specific to SH4.

Just checking since I joined late -- is the consensus that this does
not require any action/review specific to SH (in my role as maintainer
way behind on maintenance)?

Rich

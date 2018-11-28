Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A016C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2C32081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DG4UBxK1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VK/7TAWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2C32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeK1Rqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:46:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1Rqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:46:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ED3B360B73; Wed, 28 Nov 2018 06:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543387569;
        bh=VJBWpzf0krcaIQQzwAR9f0GiUi5g6FVrrYYHIrEmhic=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=DG4UBxK1qZ1Ed8G84uRm4MvNQoXhnBTsjpcYa7J3PN4aN2OezfxDaK2AUSzRT+VZ1
         qzu2CiAV8QhWCHGWEgJL4rvw7YKYQ4rMc4oFbVLjIi25jOSney004DNCzQutcqfPi5
         30HEkmtBVu7yPs76zxXboPRHSN1NufAlvhZP4dx0=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B52A860722;
        Wed, 28 Nov 2018 06:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543387568;
        bh=VJBWpzf0krcaIQQzwAR9f0GiUi5g6FVrrYYHIrEmhic=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VK/7TAWNARK1Hi7A8DeUQ5rk0Ljxo/CLL1h/qNe+Iewfq6UFZdndXCdd/flKrODch
         104360pq+nCcSghKP1eG2Gj/Lc1I3VXS0icNLqyDDZ89CoOcMY6Gyt6kRoqKftSmxu
         tfiyvREbRST6fMRju9DCOJJjk7Gj8xIygmH+FZFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B52A860722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Tue, 27 Nov 2018 22:46:07 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Brian Starkey <Brian.Starkey@arm.com>
cc:     nd <nd@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Arve Hjonnevag <arve@android.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
In-Reply-To: <20181127103551.3phyldvtjbdsxetf@DESKTOP-E1NTVVP.localdomain>
Message-ID: <alpine.DEB.2.10.1811272231460.20916@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com> <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com> <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com> <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain> <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com> <20181127103551.3phyldvtjbdsxetf@DESKTOP-E1NTVVP.localdomain>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Brian Starkey wrote:

> Hi Liam,
> 
> On Mon, Nov 26, 2018 at 08:59:44PM -0800, Liam Mark wrote:
> > On Tue, 20 Nov 2018, Brian Starkey wrote:
> > 
> > > Hi Liam,
> > > 
> > > I'm missing a bit of context here, but I did read the v1 thread.
> > > Please accept my apologies if I'm re-treading trodden ground.
> > > 
> > > I do know we're chasing nebulous ion "problems" on our end, which
> > > certainly seem to be related to what you're trying to fix here.
> > > 
> > > On Thu, Nov 01, 2018 at 03:15:06PM -0700, Liam Mark wrote:
> > > >Based on the suggestions from Laura I created a first draft for a change
> > > >which will attempt to ensure that uncached mappings are only applied to
> > > >ION memory who's cache lines have been cleaned.
> > > >It does this by providing cached mappings (for uncached ION allocations)
> > > >until the ION buffer is dma mapped and successfully cleaned, then it
> > > drops
> > > >the userspace mappings and when pages are accessed they are faulted back
> > > >in and uncached mappings are created.
> > > 
> > > If I understand right, there's no way to portably clean the cache of
> > > the kernel mapping before we map the pages into userspace. Is that
> > > right?
> > > 
> > 
> > Yes, it isn't always possible to clean the caches for an uncached mapping 
> > because a device is required by the DMA APIs to do cache maintenance and 
> > there isn't necessarily a device available (dma_buf_attach may not yet 
> > have been called).
> > 
> > > Alternatively, can we just make ion refuse to give userspace a
> > > non-cached mapping for pages which are mapped in the kernel as cached?
> > 
> > These pages will all be mapped as cached in the kernel for 64 bit (kernel 
> > logical addresses) so you would always be refusing to create a non-cached mapping.
> 
> And that might be the sane thing to do, no?
> 
> AFAIK there are still pages which aren't ever mapped as cached (e.g.
> dma_declare_coherent_memory(), anything under /reserved-memory marked
> as no-map). If those are exposed as an ion heap, then non-cached
> mappings would be fine, and permitted.
> 

Sounds like you are suggesting using carveouts to support uncached?

We have many multimedia use cases which use very large amounts of uncached
memory, uncached memory is used as a performance optimization because CPU
access won't happen so it allows us to skip cache maintenance for all the
dma map and dma unmap calls. To create carveouts large enough to support
to support the worst case scenarios could result in very large carveouts.

Large carveouts like this would likely result in poor memory utilizations
(since they are tuned for worst case) which would likely have significant
performance impacts (more limited memory causes more frequent memory
reclaim ect...).

Also estimating for worst case could be difficult since the amount of
uncached memory could be app dependent.
Unfortunately I don't think this would make for a very scalable solution.

> > 
> > > Would userspace using the dma-buf sync ioctl around its accesses do
> > > the "right thing" in that case?
> > > 
> > 
> > I don't think so, the dma-buf sync ioctl require a device to peform cache 
> > maintenance, but as mentioned above a device may not be available.
> > 
> 
> If a device didn't attach yet, then no cache maintenance is
> necessary. The only thing accessing the memory is the CPU, via a
> cached mapping, which should work just fine. So far so good.
> 

Unfortunately not.
Scenario:
- Client allocates uncached memory.
- Client calls the DMA_BUF_IOCTL_SYNC IOCT IOCTL with flags
DMA_BUF_SYNC_START (but this doesn't do any cache maintenance since there
isn't any device)
- Client mmap the memory (ION creates uncached mapping)
- Client reads from that uncached mapping

Because memory has not been cleaned (we haven't had a device yet) the
zeros that were written to this memory could  still be in the cache (since
they were written with a cached mapping), this means that the unprivilived
userpace client is now potentially reading sensitive kernel data....

> If there are already attachments, then ion_dma_buf_begin_cpu_access()
> will sync for CPU access against all of the attached devices, and
> again the CPU should see the right thing.
> 
> In the other direction, ion_dma_buf_end_cpu_access() will sync for
> device access for all currently attached devices. If there's no
> attached devices yet, then there's nothing to do until there is (only
> thing accessing is CPU via a CPU-cached mapping).
> 
> When the first (or another) device attaches, then when it maps the
> buffer, the map_dma_buf callback should do whatever sync-ing is needed
> for that device.
> 
> I might be way off with my understanding of the various DMA APIs, but
> this is how I think they're meant to work.
> 
> > > Given that as you pointed out, the kernel does still have a cached
> > > mapping to these pages, trying to give the CPU a non-cached mapping of
> > > those same pages while preserving consistency seems fraught. Wouldn't
> > > it be better to make sure all CPU mappings are cached, and have CPU
> > > clients use the dma_buf_{begin,end}_cpu_access() hooks to get
> > > consistency where needed?
> > > 
> > 
> > It is fraught, but unfortunately you can't rely on 
> > dma_buf_{begin,end}_cpu_access() to do cache maintenance as these calls 
> > require a device, and a device is not always available.
> 
> As above, if there's really no device, then no syncing is needed
> because only the CPU is accessing the buffer, and only ever via cached
> mappings.
> 

Sure you can use cached mappings, but with cached memory to ensure cache 
coherency you would always need to do cache maintenance at dma map and dma 
unmap (since you can't rely on their being a device when 
dma_buf_{begin,end}_cpu_access() hooks are called).
But with this cached memory you get poor performance because you are 
frequently doing cache mainteance uncessarily because there *could* be CPU access.

The reason we want to use uncached allocations, with uncached mappings, is 
to avoid all this uncessary cache maintenance.

> > 
> > > >
> > > >This change has the following potential disadvantages:
> > > >- It assumes that userpace clients won't attempt to access the buffer
> > > >while it is being mapped as we are removing the userpspace mappings at
> > > >this point (though it is okay for them to have it mapped)
> > > >- It assumes that kernel clients won't hold a kernel mapping to the
> > > buffer
> > > >(ie dma_buf_kmap) while it is being dma-mapped. What should we do if
> > > there
> > > >is a kernel mapping at the time of dma mapping, fail the mapping, warn?
> > > >- There may be a performance penalty as a result of having to fault in
> > > the
> > > >pages after removing the userspace mappings.
> > > 
> > > I wonder if the dma-buf sync ioctl might provide a way for userspace
> > > to opt-in to when the zap/fault happens. Zap on (DMA_BUF_SYNC_WRITE |
> > > DMA_BUF_SYNC_WRITE_END) and fault on (DMA_BUF_SYNC_READ |
> > > DMA_BUF_SYNC_START)
> > > 
> > 
> > Not sure I understand, can you elaborate. 
> > Are you also adding a requirment that ION pages can't be mmaped during a
> > call to dma_buf_map_attachment?
> 
> I was only suggesting that zapping the mappings "at random" (from
> userspace's perspective), and then faulting them back in (also "at
> random"), might cause unexpected and not-controllable stalls in the
> app. We could use the ioctl hooks as an explicit indication from the
> app that now is a good time to zap the mapping and/or fault back in
> the whole buffer. begin_cpu_access is allowed to be a "slow"
> operation, so apps should already be expecting to get stalled on the
> sync ioctl.
> 

I think we have to do the zapping when have a device with which we can
then immediately clean the caches for the memory.

The dma_buf_map_attachement seems like a logical time to do this, we have
a device and the user should not be doing CPU access at this time.
There is no guarantee you will ever have a device attached when the ioctl
hooks are called so this could mean you never get a chance to switch to
actual uncached mappings if you only try to do this from the ioctl hooks.

The one-of hit of having to fault the pages back in is unfortunate but I
can't seem to find a better time to do it.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

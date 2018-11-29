Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A498C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CC72081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EyEMVk76";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RzU/jSD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CC72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeK2SIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:08:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeK2SID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:08:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 455AF60B13; Thu, 29 Nov 2018 07:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543475021;
        bh=wXMDgVQylrcQzmtpWbuyF0XNl38jPeDZmNi2eVj1TfE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=EyEMVk76Mb1bABdndozgdAY36dvEEZo2V21LfEbUg372V6bwpdFGz/MVDqAj/hMWC
         1inSN2D2cQUMr6qcX3IcpWk5jH0gtmgP6xVzhtjwibcltMMVomExu0yWxKtOffUQc3
         WJHTpBrQLl0/90BMBwrmRDn7Bkf7jdWGkYif6hA0=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5984C602FE;
        Thu, 29 Nov 2018 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543475018;
        bh=wXMDgVQylrcQzmtpWbuyF0XNl38jPeDZmNi2eVj1TfE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RzU/jSD4kegpnrUgOgGp8ECvBcWq4cNfY4dgi6/9tz/xl3s7CDJGtGx8xGdwTTvPB
         xe4dcYE9hbYNdX0VDiPIlGm9cQb+qTF9+Bjdm+Zs/ZlW3x4FULm5I5zqyXIOeTI8S6
         4asUmxK5ogOGSLG0CIVqIgTrLVyMlo68lbzlaMBQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5984C602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Wed, 28 Nov 2018 23:03:37 -0800 (PST)
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
In-Reply-To: <20181128111052.q2xokwcpuucynoft@DESKTOP-E1NTVVP.localdomain>
Message-ID: <alpine.DEB.2.10.1811282249350.28066@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com> <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com> <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com> <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <20181120164636.jcw7li2uaa3cmwc3@DESKTOP-E1NTVVP.localdomain> <alpine.DEB.2.10.1811262051310.9248@lmark-linux.qualcomm.com> <20181127103551.3phyldvtjbdsxetf@DESKTOP-E1NTVVP.localdomain> <alpine.DEB.2.10.1811272231460.20916@lmark-linux.qualcomm.com>
 <20181128111052.q2xokwcpuucynoft@DESKTOP-E1NTVVP.localdomain>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018, Brian Starkey wrote:

> Hi Liam,
> 
> On Tue, Nov 27, 2018 at 10:46:07PM -0800, Liam Mark wrote:
> > On Tue, 27 Nov 2018, Brian Starkey wrote:
> > 
> > > Hi Liam,
> > > 
> > > On Mon, Nov 26, 2018 at 08:59:44PM -0800, Liam Mark wrote:
> > > > On Tue, 20 Nov 2018, Brian Starkey wrote:
> > > > 
> > > > > Hi Liam,
> > > > > 
> > > > > I'm missing a bit of context here, but I did read the v1 thread.
> > > > > Please accept my apologies if I'm re-treading trodden ground.
> > > > > 
> > > > > I do know we're chasing nebulous ion "problems" on our end, which
> > > > > certainly seem to be related to what you're trying to fix here.
> > > > > 
> > > > > On Thu, Nov 01, 2018 at 03:15:06PM -0700, Liam Mark wrote:
> > > > > >Based on the suggestions from Laura I created a first draft for a change
> > > > > >which will attempt to ensure that uncached mappings are only applied to
> > > > > >ION memory who's cache lines have been cleaned.
> > > > > >It does this by providing cached mappings (for uncached ION allocations)
> > > > > >until the ION buffer is dma mapped and successfully cleaned, then it
> > > > > drops
> > > > > >the userspace mappings and when pages are accessed they are faulted back
> > > > > >in and uncached mappings are created.
> > > > > 
> > > > > If I understand right, there's no way to portably clean the cache of
> > > > > the kernel mapping before we map the pages into userspace. Is that
> > > > > right?
> > > > > 
> > > > 
> > > > Yes, it isn't always possible to clean the caches for an uncached mapping 
> > > > because a device is required by the DMA APIs to do cache maintenance and 
> > > > there isn't necessarily a device available (dma_buf_attach may not yet 
> > > > have been called).
> > > > 
> > > > > Alternatively, can we just make ion refuse to give userspace a
> > > > > non-cached mapping for pages which are mapped in the kernel as cached?
> > > > 
> > > > These pages will all be mapped as cached in the kernel for 64 bit (kernel 
> > > > logical addresses) so you would always be refusing to create a non-cached mapping.
> > > 
> > > And that might be the sane thing to do, no?
> > > 
> > > AFAIK there are still pages which aren't ever mapped as cached (e.g.
> > > dma_declare_coherent_memory(), anything under /reserved-memory marked
> > > as no-map). If those are exposed as an ion heap, then non-cached
> > > mappings would be fine, and permitted.
> > > 
> > 
> > Sounds like you are suggesting using carveouts to support uncached?
> > 
> 
> No, I'm just saying that ion can't give out uncached _CPU_ mappings
> for pages which are already mapped on the CPU as cached.
> 

Okay then I guess I am not clear on where you would get this memory 
which doesn't have a cached kernel mapping.
It sounded like you wanted to define sections of memory in the DT as not 
mapped in the kernel and then hand this memory to 
dma_declare_coherent_memory (so that it can be managed) and then use an 
ION heap as the allocator.  If the memory was defined this way it sounded 
a lot like a carveout. But I guess you have some thoughts on how this 
memory which doesn't have a kernel mapping can be made available for general
use (for example available in buddy)?

Perhaps you were thinking of dynamically removing the kernel mappings 
before handing it out as uncached, but this would have a general system 
performance impact as this memory could come from anywhere so we would 
quickly lose our 1GB block mappings (and likely many of our 2MB block 
mappings as well).


> > We have many multimedia use cases which use very large amounts of uncached
> > memory, uncached memory is used as a performance optimization because CPU
> > access won't happen so it allows us to skip cache maintenance for all the
> > dma map and dma unmap calls. To create carveouts large enough to support
> > to support the worst case scenarios could result in very large carveouts.
> > 
> > Large carveouts like this would likely result in poor memory utilizations
> > (since they are tuned for worst case) which would likely have significant
> > performance impacts (more limited memory causes more frequent memory
> > reclaim ect...).
> > 
> > Also estimating for worst case could be difficult since the amount of
> > uncached memory could be app dependent.
> > Unfortunately I don't think this would make for a very scalable solution.
> > 
> 
> Sure, I understand the desire not to use carveouts. I'm not suggesting
> carveouts are a viable alternative.
> 
> > > > 
> > > > > Would userspace using the dma-buf sync ioctl around its accesses do
> > > > > the "right thing" in that case?
> > > > > 
> > > > 
> > > > I don't think so, the dma-buf sync ioctl require a device to peform cache 
> > > > maintenance, but as mentioned above a device may not be available.
> > > > 
> > > 
> > > If a device didn't attach yet, then no cache maintenance is
> > > necessary. The only thing accessing the memory is the CPU, via a
> > > cached mapping, which should work just fine. So far so good.
> > > 
> > 
> > Unfortunately not.
> > Scenario:
> > - Client allocates uncached memory.
> > - Client calls the DMA_BUF_IOCTL_SYNC IOCT IOCTL with flags
> > DMA_BUF_SYNC_START (but this doesn't do any cache maintenance since there
> > isn't any device)
> > - Client mmap the memory (ION creates uncached mapping)
> > - Client reads from that uncached mapping
> 
> I think I maybe wasn't clear with my proposal. The sequence should be
> like this:
> 
>  - Client allocates memory
>    - If this is from a region which the CPU has mapped as cached, then
>      that's not "uncached" memory - it's cached memory - and you have
>      to treat it as such.
>  - Client calls the DMA_BUF_IOCTL_SYNC IOCTL with flags
>    DMA_BUF_SYNC_START (but this doesn't do any cache maintenance since
>    there isn't any device)
>  - Client mmaps the memory
>    - ion creates a _cached_ mapping into the userspace process. ion
>      *must not* create an uncached mapping.
>  - Client reads from that cached mapping
>    - It sees zeroes, as expected.
> 
> This proposal ensures that everyone will *always* see correct data if
> they use the DMA APIs properly (device accesses via
> dma_buf_{map,unmap}, CPU access via {begin,end}_cpu_access).
> 

I am not sure I am properly understanding as this is what my V2 patch 
does, then when it gets an opportunity it allows the memory to be 
re-mapped as uncached.

Or are you perhaps suggesting that if the memory is allocated from a 
cached region then it always remains as cached, so only provide uncached 
if it was allocated from an uncached region? If so I view all memory 
available to the ION system heap for uncached allocations as having a 
cached mapping (since it is all part of the kernel logical mappigns), so I 
can't see how this would ever be able to support uncached allocations.

I guess once I understand how you will be providing memory to ION which 
isn't mapped as cached in the kernel, and therefore can be used to satisfy 
uncached ION allocations, this will make more sense to me.


> > 
> > Because memory has not been cleaned (we haven't had a device yet) the
> > zeros that were written to this memory could  still be in the cache (since
> > they were written with a cached mapping), this means that the unprivilived
> > userpace client is now potentially reading sensitive kernel data....
> > 
> 
> This is precisely why you can't just "pretend" that those pages
> are uncached. You can't have the same memory mapped with different
> attributes and get consistent behaviour.
> 
> > > If there are already attachments, then ion_dma_buf_begin_cpu_access()
> > > will sync for CPU access against all of the attached devices, and
> > > again the CPU should see the right thing.
> > > 
> > > In the other direction, ion_dma_buf_end_cpu_access() will sync for
> > > device access for all currently attached devices. If there's no
> > > attached devices yet, then there's nothing to do until there is (only
> > > thing accessing is CPU via a CPU-cached mapping).
> > > 
> > > When the first (or another) device attaches, then when it maps the
> > > buffer, the map_dma_buf callback should do whatever sync-ing is needed
> > > for that device.
> > > 
> > > I might be way off with my understanding of the various DMA APIs, but
> > > this is how I think they're meant to work.
> > > 
> > > > > Given that as you pointed out, the kernel does still have a cached
> > > > > mapping to these pages, trying to give the CPU a non-cached mapping of
> > > > > those same pages while preserving consistency seems fraught. Wouldn't
> > > > > it be better to make sure all CPU mappings are cached, and have CPU
> > > > > clients use the dma_buf_{begin,end}_cpu_access() hooks to get
> > > > > consistency where needed?
> > > > > 
> > > > 
> > > > It is fraught, but unfortunately you can't rely on 
> > > > dma_buf_{begin,end}_cpu_access() to do cache maintenance as these calls 
> > > > require a device, and a device is not always available.
> > > 
> > > As above, if there's really no device, then no syncing is needed
> > > because only the CPU is accessing the buffer, and only ever via cached
> > > mappings.
> > > 
> > 
> > Sure you can use cached mappings, but with cached memory to ensure cache 
> > coherency you would always need to do cache maintenance at dma map and dma 
> > unmap (since you can't rely on their being a device when 
> > dma_buf_{begin,end}_cpu_access() hooks are called).
> 
> As you've said below, you can't skip cache maintenance in the general
> case - the first time a device maps the buffer, you need to clean the
> cache to make sure the memset(0) is seen by the device.
> 

Unfortunately if are only using cached mappings it isn't only the first 
time you dma map the buffer you need to do cache maintenance, you need to 
almost always do it because you don't know what CPU access happened (or 
will happen) without a device.
Explained more below.

> > But with this cached memory you get poor performance because you are 
> > frequently doing cache mainteance uncessarily because there *could* be CPU access.
> > 
> > The reason we want to use uncached allocations, with uncached mappings, is 
> > to avoid all this uncessary cache maintenance.
> > 
> 
> OK I think this is the key - you don't actually care whether the
> mappings are non-cached, you just don't want to pay a sync penalty if
> the CPU never touched the buffer.
> 
> In that case, then to me the right thing to do is make ion use
> dma_map_sg_attrs(..., DMA_ATTR_SKIP_CPU_SYNC) in ion_map_dma_buf(), if
> it knows that the CPU hasn't touched the buffer (which it does - from
> {begin,end}_cpu_access).
> 

Unfortunately that isn't the case we are trying to optimize for,  we 
aren't trying to optimize for the case where CPU *never* touches the 
buffer we are trying to optimize for the case where the CPU may *rarely* 
touch the buffer.

If a client allocates cached memory the driver calling dma map and dma 
unmap has no way of knowing if at some pointe further down the pipeline 
there will be some userspace module which will attempt to do some kind
of CPU access (example image library post processing).  This userspace 
moduel will call the required DMA_BUF_IOCTL_SYNC  IOCTLs, however there 
may no longer be a device attached, therefore these calls won't 
necessarily do the appropriate cache maintenance.

So what this means is that if a cached buffers is used you have to at 
least  always to a cache invalidating when dma unmapping (from a device 
which isn't io-coherrent that did a write)  otherwise there could be a CPU 
attempted to read that data using a cached mapping which could end up 
reading a stale cache line (for example acquired through speculative 
access).

This frequent uncessary cache maintenance adds a significant performance 
impact and that is why we use uncached memory because it allows us to skip 
all this cache maintenance.
Basically your driver can't predict the future so it has to play it safe 
when cached ION buffers are involved.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

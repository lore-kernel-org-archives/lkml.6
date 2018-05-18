Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-371457-1526679214-3-1726058599494782296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526679214; b=dLeOT/CP6CGk2lPY31KPYxy8JizNp4Bmx07g61aB5OI7HCu70T
    SQe5vfJEIWA7RnzM46I/lGAYCnGUXVJpJ08pn76MoP2d5pTCUYOH7+U6ObJ4fEAq
    zUW3Op9ZBeSCsn8oLWHJEMgyQMtaw/83DcDoh+Ls6himtERX+0V2JkbwBt69kIag
    ZUemaXcKELGy34AkyV0xGaEJLH9v6UGgo1knK2hU1gFc7j2gPg4rd57B6mfqtDy6
    WlJpWYjA1/+BivuGJn/xvoeJ1ZDehBpFjUro0xTkWBFyK6+FrgV2jVXvzyDkDzya
    Y3h+b3HA5TcNg1kWUZzazlDj9iinvsEncOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526679214; bh=+VtlEKMc0qw/70CkC48YEtrDLPYzFR
    dBDGBkF4QFvn0=; b=J9NyaNH4797uo6dIzGYOEEduVhZEsWI8EM1j/U/Ut/piYE
    Iu57/qErgDRb9lMJ2pwZPELcpMIqkosEstX1EiEI3XWRs/NyYRWxo6glzeK5bkYs
    DXd+hncgRG+wMaWPMt3UZ1XOhJRes9eCMZuBnJXKICQy4SqXSqpGbhw4yEFMoyD+
    TRRWW6atuBHzJEEWlnnpuT8zQyIhdaHgs1SfO7wm851/GQnqmBHimTMEO90/3em0
    SzJHPj+BEW0AQg1XXQ5JOcqjQt0KOhX99/+crTc52hCNZxOZLtn8Vt5lTmwFE3L7
    0gv07UqUNGAbZiBPnlIgOeX/aRkONIfDAIF05M0g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RbYhN7ca
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=armlinux.org.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RbYhN7ca
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=pandora-2014;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=armlinux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=armlinux.org.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHBZdLUnaUMLUPSqepk7gNrhNFjHpqnoOjIQrt/ysGjmH9MHAZ/Szg5tt9H6wM2jRW4IC7He1YsJjQE5X2Z6rW6BKkhz2QJA4Cq8H0h1fzCikCez8zik
    X++bDu1WHs5giizH5UgGgP7N5jkaQrZ6Ch3TJfj8V2MWvLWe8c4TrbRk8LeDRj8ZcKkM1WTtJL0gl3gTyWEcanq6BLa/Bw2Wi7bhmfId8Mi3Tq0aq6LgOtnr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=PHq6YzTAAAAA:8 a=PMT70qdeAAAA:8 a=6rZMM5Dh5mJajZGa77EA:9
    a=CjuIK1q_8ugA:10 a=ZKzU8r6zoKMcqsNulkmm:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeERVd3 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 17:33:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54486 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeERVd1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 17:33:27 -0400
Date: Fri, 18 May 2018 22:33:10 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH
 02/20] dma-mapping: provide a generic dma-noncoherent implementation)
Message-ID: <20180518213309.GG17671@n2100.armlinux.org.uk>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
 <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
 <20180518175004.GF17671@n2100.armlinux.org.uk>
 <182840dedb4890a88c672b1c5d556920bf89a8fb.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182840dedb4890a88c672b1c5d556920bf89a8fb.camel@synopsys.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 07:57:34PM +0000, Alexey Brodkin wrote:
> Hi Russel,

That's Russell.

> On Fri, 2018-05-18 at 18:50 +0100, Russell King - ARM Linux wrote:
> > It's necessary.  Take a moment to think carefully about this:
> > 
> >         dma_map_single(, dir)
> > 
> >         dma_sync_single_for_cpu(, dir)
> > 
> >         dma_sync_single_for_device(, dir)
> > 
> >         dma_unmap_single(, dir)
> > 
> > In the case of a DMA-incoherent architecture, the operations done at each
> > stage depend on the direction argument:
> > 
> >         map             for_cpu         for_device      unmap
> > TO_DEV  writeback       none            writeback       none
> > TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> > BIDIR   writeback       invalidate      writeback       invalidate
> > 
> > * - only necessary if the CPU speculatively prefetches.
> 
> I think invalidation of DMA buffer is required on for_cpu(TO_CPU) even
> if CPU doesn't preferch - what if we reuse the same buffer for multiple
> reads from DMA device?

That's fine - for non-coherent DMA, the CPU caches will only end up
containing data for that memory if:
- the CPU speculatively fetches data from that memory, or
- the CPU explicitly touches that memory

> > The multiple invalidations for the TO_CPU case handles different
> > conditions that can result in data corruption, and for some CPUs, all
> > four are necessary.
> 
> I would agree that map()/unmap() a quite a special cases and so depending
> on direction we need to execute in them either for_cpu() or for_device()
> call-backs depending on direction.
> 
> As for invalidation in case of for_device(TO_CPU) I still don't see
> a rationale behind it. Would be interesting to see a real example where
> we benefit from this.

Yes, you could avoid that, but depending how you structure the
architecture implementation, it can turn out to be a corner case.
The above table is precisely how 32-bit ARM is implemented, because
the way we implement them is based on who owns the memory - the "map"
and "for_device" operations translate internally to a cpu-to-device
ownership transition of the buffer.  Similar for "unmap" and "to_cpu".
It basically avoids having to add additional functions at the lower
implementation levels.

> > Things get more interesting if the implementation behind the DMA API has
> > to copy data between the buffer supplied to the mapping and some DMA
> > accessible buffer:
> > 
> >         map             for_cpu         for_device      unmap
> > TO_DEV  copy to dma     none            copy to dma     none
> > TO_CPU  none            copy to cpu     none            copy to cpu
> > BIDIR   copy to dma     copy to cpu     copy to dma     copy to cpu
> > 
> > So, in both cases, the value of the direction argument defines what you
> > need to do in each call.
> 
> Interesting enough in your seond table (which describes more complicated
> case indeed) you set "none" for for_device(TO_CPU) which looks logical
> to me.
> 
> So IMHO that's what make sense:
> ---------------------------->8-----------------------------
>         map             for_cpu         for_device      unmap
> TO_DEV  writeback       none            writeback       none
> TO_CPU  none            invalidate      none            invalidate*
> BIDIR   writeback       invalidate      writeback       invalidate*
> ---------------------------->8-----------------------------

That doesn't make sense for the TO_CPU case.  If the caches contain
dirty cache lines, and you're DMAing from the device to the system
RAM, other system activity can cause the dirty cache lines to be
evicted (written back) to memory which the DMA has already overwritten.
The result is data corruption.  So, you really can't have "none" in
the "map" case there.

Given that, the "for_cpu" case becomes dependent on whether the CPU
speculatively prefetches.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

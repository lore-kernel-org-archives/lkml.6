Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF54C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6134921655
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6134921655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeHTPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:49:17 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42383 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeHTPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:49:16 -0400
Received: by mail-qk0-f193.google.com with SMTP id p71-v6so5433865qka.9;
        Mon, 20 Aug 2018 05:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUKpnY/C90k6KcQydpKxf9wAMB6kxoCNQSnFoqYzN0A=;
        b=iD18vWE60V5xvpulsrvsNNvf3LDsT/fxn43V0K9Z8t3rNevppbsJxCjh+c/dmOul2S
         oSOUJixU3Oj1UpwIMnV0PKCKKqSgWbC4/KyBHZM/B3GM0mw9X+QgH+G0i2rdSyFCkBQZ
         7ou+8bidS10CMZjYx5zDDyPo4PbZmIxSYOB8SatSv7jAKQnSr3HCIbabcCUG5ewRk30O
         IOnWt3g9/Izt++4qfV+fjStM7lAlsJGk71MTcUdtVsJuH0nAE5U/7f1cxJYspoWCJf8B
         +oo8Cs5g6hHvVDEt5Se940rHNPfqvnwe42iH05z38lzsK63NaFnW3qSaDzMKU35etpQt
         9i9Q==
X-Gm-Message-State: AOUpUlG4DLzNZ/KDXpojowTMXI+DZHwY9ud1DWyyAtnx8R0j5EMYjcpB
        3VZNOd9ltC091ygtuemBKtwzcJ1ebZX1cu5U01KWY/Pq
X-Google-Smtp-Source: AA+uWPwhGGxYfJaYjwsWRtt3u4q7Iot0AC2lDHnG0M6EIhTrW6PjthtlDlgARwiQYdVGocWoSmwRK/gsoGfl2eFr7Hc=
X-Received: by 2002:a37:7946:: with SMTP id u67-v6mr39928093qkc.283.1534768427791;
 Mon, 20 Aug 2018 05:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
 <18df6608-61c1-963d-bb1a-d46320232f40@landley.net> <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
 <418f3fa1-036f-d775-f1bc-e96778b4a4d8@landley.net> <CAK8P3a3x0f_op8PxOaWGNHQ3udg05T6NZggFAd7awns-FoL4yA@mail.gmail.com>
 <3f9fed2a-9800-8a86-2b1f-f7baaea74e54@landley.net>
In-Reply-To: <3f9fed2a-9800-8a86-2b1f-f7baaea74e54@landley.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 14:33:31 +0200
Message-ID: <CAK8P3a0Be9SaTH7+KRG1roESeJUn7nR+UNX477Tzyhs+b3j9Cw@mail.gmail.com>
Subject: Re: dmaengine for sh7760 (was Re: use the generic dma-noncoherent
 code for sh V2)
To:     Rob Landley <rob@landley.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 7:38 AM Rob Landley <rob@landley.net> wrote:
>
> On 08/17/2018 03:23 PM, Arnd Bergmann wrote:
> > On Fri, Aug 17, 2018 at 7:04 PM Rob Landley <rob@landley.net> wrote:
> >> On 07/31/2018 07:56 AM, Arnd Bergmann wrote:
> >>> On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob@landley.net> wrote:
> >>>> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
> >>>>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
> >>>>>> Hi all,
> >>> If you hack on it, please convert the dmaengine platform data to use
> >>> a dma_slave_map array to pass the data into the dmaengine driver,
> >>
> >> The dmatest module didn't need it? I don't see why the ethernet driver would?
> >> (Isn't the point of an allocator to allocate from a request?)
> >
> > I guess you have hit two of the special cases here:
> >
> > - dmatest uses the memory-to-memory DMA engine interface, not the slave
> >   API, so you don't have to configure a slave at all
>
> I've read through
> https://www.kernel.org/doc/Documentation/driver-api/dmaengine/client.rst twice
> and am still very unclear on the slave API.
>
> > - smc91x (and its smc911x.c relative) are apparently special in that they
> >   use they use the DMA slave API
>
> Only sort of. In 4.14 at least it's under #ifdef ARCH_PXA and full of PXA
> constants (PXAD_PRIO_LOWEST and such).
>
> > but (AFAICT) require programming
> >   the dmaengine hardware into a memory-to-memory transfer with no
> >   DMA slave request signal and completely synchronous operation
> >   (the IRQ handler polls for the DMA descriptor to be complete),
> >   see also https://lkml.org/lkml/2018/4/3/464 for the discussion about
> >   the recent rework of that driver's implementation.
>
> Bookmarked, thanks.
>
> (Being able to just upgrade to a 4.19 kernel or something and have DMA work in
> this driver if I've got dmaengine set up for the platform would be lovely.)

I wouldn't expect too much even with the newer kernel, I think it
still relies on a special case in the pxa DMA engine driver, possibly
even in their hardware implementation.

> >>> mapping the settings from a (pdev-name, channel-id) tuple to a pointer
> >>> that describes the channel configuration rather than having the
> >>> mapping from an numerical slave_id to a struct sh_dmae_slave_config
> >>> in the setup files. It should be a fairly mechanical conversion.
> >>
> >> I think all 8 channels are generic. Drivers should be able to grab them and
> >> release them at will, why does it need a table?
> >>
> >> (I say this not having made the smc91x.c driver use this yet, its "conversion"
> >> to device tree left it full of PXA #ifdefs and constants, and I've tried the
> >
> > Another point about smc91x is that it only uses DMA on the PXA platform,
> > which is not part of the "multiplatform" ARM setup. It's likely that no
> > other platform actually has a DMA engine that can talk to this device in
> > the absence of a request signal, or that on more modern CPU cores,
> > a readsl() is actually just as fast, but it avoids the setup cost of talking
> > to the dma engine. Possibly both of the above.
>
> The sh7760 has the CPU pegged at 100% trying to keep up with ethernet traffic.
> Being able to use DMA on this would be very nice.

This is probably for the most part due to the rather slow bus interface
of the smc91x, especially if you can't use the 32-bit mode or an optimized
readsl() implementation.

Using DMA won't let you do the transfer in the background either, as it
would on any other ethernet hardware, it just means the CPU is blocked
for a little less time if the DMA engine can access the bus faster
than the readsl() implementation can on your CPU.

> >> last half-dozen kernel releases and qemu releases and have yet to find an arm
> >> mainstone board under qemu that _doesn't_ time out trying to use DMA with this
> >> card. But that's another post...)
> >
> > Is smc91x the only driver that you want to make use of the DMA engine?
>
> This driver's the low-hanging fruit, yeah. Copying NOR flash jffs2 data into
> page cache would be nice but there's a decompression step so I'm not sure that's
> a win.

Right, that would be even harder. The devices that are actually designed
for interacting with the DMA engine are likely MMC, USB and audio on
that chip. Those should be easier to do than the smc91x.

> > I suspect that every other one currently relies on passing a slave ID
> > shdma_chan_filter into dma_request_slave_channel_compat() or
> > dma_request_channel() , which are some of the interfaces we want to
> > remove in the future, to make everything work the same across
> > all platforms.
>
> What are "all platforms" in this context? I tried to find an x86 variant that
> uses DMAEngine but came up empty. Can I use DMAEngine on a raspberry pi perhaps?
> Is there a QEMU taret I can play with DMAEngine under?

Most ARM SoCs these days have a DMA engine that only uses the new
style interface with dma_request_chan() or dma_request_slave_channel().
This includes the raspberry pi, or many of the machines supported by qemu
(not sure which DMA engines are supported on qemu specifcally, I would
guess vexpress/realview, omap, and allwinner).

On x86, only some of the embedded Atom chips have a DMA engine, but
it's integrated in a more complex manner using a mix of PCI probing and
ACPI, so probably not worth looking at as an example for any other architecture.

The platforms that still use the old interface (dma_request_channel or
dma_request_slave_channel_compat) are

- atmel (should be changed over now that arch/avr32 is gone)
- PXA/MMP (patches are being worked on
- ep93xx
- ux500
- MIPS pic32 (for no reason I can see, should be changed now)
- tegra (not really, can be trivially cleaned up)
- imx3 (only for framebuffer on non-DT platforms)
- sh/shmobile (hard to do without testing arch/sh)

> I built a mainstone kernel with dmaengine amd smc91x both enabled, and booted it
> on qemu-system-arm -M mainstone, and it works fine until I try to ping the host
> (via the 10.0.2.2 redirect), at which point no packets are received and a timer
> expires all over the console a few seconds later. I.E. the DMA claims to be
> there, but the transfer never occurs.
>
> I built and tested every Linux version back to 4.2 (before the smc91x was
> converted from PXA dma to use DMAEngine, albeit in a very PXA specific manner).
> I also tested each qemu release back to 2.3.0, with no obvious behavioral
> difference.
>
> I can dig further back in qemu history maybe? Ask on the qemu list? (Did this
> ever work for anyone? I can post my kernel config and qemu command line if you
> think it would help?)

No idea really. This is not a popular platform at any rate, I wouldn't be
surprised if it hasn't worked in a long time.

> > shdma_chan_filter() is one of those that expect its pointer argument to
> > be a number that is in turn associated with an sh_dmae_slave_config
> > structure in the platform data of the dma engine. What the newer
> > dma_request_chan() interface does is to pass a pointer to the
> > slave device and a string as identifier for the same data, which then
> > gets associated through the dma_slave_map. On smc91x, both
> > the device and name argument are NULL, which triggers the special
> > case in the pxa dmaengine driver.
>
> I do not understand what the slave map is for, is it documented anywhere? (The
> Documentation/randomdir/dmaengine/client.nolongertxt file says: "The association
> is done via DT, ACPI or board file based dma_slave_map matching table." which is
> its only mention of the existence of dma_slave_map.
>
> If the driver just needs "a channel" and doesn't care which one, why isn't the
> config info for that channel in the driver as a generic request for resource?

AFAICT, the dmaengine API doesn't really support a case of the slave API
without specifying a slave, only PXA with smc91x needed that until
now. ;-)

> >>> The other part I noticed is arch/sh/drivers/dma/*, which appears to
> >>> be entirely unused, and should probably removed.
> >>
> >> I had to switch that off to get this to work, yes. I believe it predates
> >> dmaengine and was obsoleted by it.
> >
> > Ok. Have you found any reason to keep it around though?
>
> I have not.

Ok. Unless someone else does it first, I might send a patch to remove
it then. I'm also planning to send a patch to remove the broken
sh5 support, which is getting in the way of some of my y2038 work.

       Arnd

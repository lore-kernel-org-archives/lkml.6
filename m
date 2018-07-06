Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABEDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5D922B40
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5D922B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeGFXfH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:35:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:35509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932774AbeGFXfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:35:05 -0400
Received: from [79.235.159.56] ([79.235.159.56]) by web-mail.gmx.net
 (3c-app-gmx-bs19.server.lan [172.19.170.71]) (via HTTP); Sat, 7 Jul 2018
 01:35:02 +0200
MIME-Version: 1.0
Message-ID: <trinity-b6608404-d325-4007-9480-1cb7947516b2-1530920102234@3c-app-gmx-bs19>
From:   =?UTF-8?Q?=22J=C3=BCrgen_Urban=22?= <JuergenUrban@gmx.de>
To:     "Fredrik Noring" <noring@nocrew.org>
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Christoph Hellwig" <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Aw: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 7 Jul 2018 01:35:02 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20180706205449.GB2313@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
 <5811ebe5-b2bd-efc1-bf54-a8f05432c4f8@arm.com>
 <20180706141926.GA2313@localhost.localdomain>
 <bd63815c-260e-078f-4184-561c8e54e636@arm.com>
 <20180706205449.GB2313@localhost.localdomain>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Q394b9kat2nDFqOo79nu3M5tynrIPEL7fcKDLMRv7wkHCbJD+jr31bT+e4qukBL/a6bA5
 RjEpak+OkR5axBMYt/24Y5vSiIe0fg+jc1VUZq0fYE7DY+q9knQT5PRfnHCLakf7iyPliK0c93yC
 3HLKA1gTNEMY+gyRKOJwdCcFSw7MzI5vdBf2zyjnNiT9PiEhZR4DVr24Tw/awZMTm3AsfGPvV7Bq
 Y6L6HOYETNjdX2/cODkMqtnrV208pCqItBHCXZ4K8RHv7wnTjrbXU4AV+Iuw8WuR6Ps2ejraPwqw
 Jo=
X-UI-Out-Filterresults: notjunk:1;V01:K0:8YBFQRPE1Ts=:WU+pSOigtyivqd2vXhABAg
 8jeGT6wniTA4xtOVeW1tXsUzTDMo4xFTC457quOH3ZPqL1m5lcqMy+Edn0FF7prr29pdqPxkG
 XaenVpNYH6cBncO49aGh6zOE3S/GAkVpRtXslQYlYiKmGHjuWrrDW+Ay9BSFTcolrfKAFrztf
 JXcXCYQNWJJToTfOQzIL5xUTGPIZJjPTkrsd+/sw5zDpjprbemSKZUZhALBTstIaZCYPTSUUP
 ZonH+rL48XDdpHC5TKKAuolTq4OsK7xq3+RhqIcXuAi9Ims5CSx41oJ25jPAv9KrO+jjQH62z
 lnnIdVQs4BZLin6ZJVINDbrlFK0TvKRq98kpHxl7JzWlLuOqEW37IK5ClyyOcEL8MQ50vWAcv
 L0H/kHl8Bm5P1tWJGS57pBYZZBi3jqufJhXiloO9HokJ56zrp22EAWMn/aUCGOU89YGh1wcGW
 /OaM9+PkXL+DzHRJWZnyQDhsNSo1d3ATryGy9kdjOBBv6ZWcdNPp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fredrik,

> Gesendet: Freitag, 06. Juli 2018 um 22:54 Uhr
> Von: "Fredrik Noring" <noring@nocrew.org>
> An: "Robin Murphy" <robin.murphy@arm.com>
> Cc: "Christoph Hellwig" <hch@lst.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Maciej W. Rozycki" <macro@linux-mips.org>, JuergenUrban@gmx.de
> Betreff: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
>
> Hi Robin,
> 
> > > Does dma_set_coherent_mask want a device object representing the IOP? Such
> > > a thing is currently not implemented, but can certainly be done.
> > 
> > Nope, just the same OHCI device as the dma_declare_coherent_memory() call.
> 
> Ah... and then some kind of dma_ops structure is needed to avoid -EIO?
> Possibly using set_dma_ops()?
> 
> By the way, the DMA hardware supports executing device->{memory,FIFO},
> {memory,FIFO}->device and FIFO<->memory simultaneously, with hardware stall
> control, between different devices where memory or FIFOs act as intermediate
> buffers. Memory can also be a source or a destination.
> 
> That might be a way to have the OHCI efficiently transfer data from/to main
> memory. I suppose it would be two simultaneously linked DMA transfers such
> as
> 
> 	OHCI <-> SIF <-> main memory
> 
> or even three linked DMA transfers as in
> 
> 	OHCI <-> IOP memory <-> SIF <-> main memory
> 
> where SIF is the IOP DMA interface, which is a bidirectional hardware FIFO.
> 
> Does the kernel DMA subsystem support simultaneously linked DMA transfers?
> In addition, the DMA hardware also supports scatter-gather (chaining), so
> memory need not be physically continuous.

Don't forget that the SIF DMA packets are limited and the kernel will block/reschedule when it is out of SIF DMA packets. The allocation is implemented inside the SBIOS. You may easily get a deadlock or a livelock when you just let it run without thinking about the design. When you use the old CDVD driver on IOP, the RPC code inside SBIOS tries to simulate the interface like the new CDVD driver. The problem is that this is done by a busy loop waiting for a free SIF DMA packet. This would block the complete Linux kernel for an unknown time.
As I understand you, you wanted to move the SBIOS code inside the Linux kernel. I am not sure whether you already have done it. When you do this, it is easier to fix the CDVD problem, but you need to think about booting using the official RTE disc from Sony for Linux, because it loads different modules and a different SBIOS. As this is the official way to start Linux on the PS2 which is supported by Sony, we should also support this in the official Linux kernel. Kernelloader can partially simulate it, but you need the files from the RTE disc.

> > > As you noted, the kernel cannot and must not allocate any kind of normal
> > > memory for this device. Typical DMA addresses 0-0x200000 are mapped to
> > > 0x1c000000-0x1c200000 and is memory managed exclusively by the IOP. What
> > > would be a suitable mask for that?
> > 
> > For the sake of accuracy, I guess maybe DMA_BIT_MASK(20) since that's what
> > the OHCI's effective addressing capability is, even if it does happen to be
> > to remote IOP RAM.
> 
> Isn't it 21 for 2 MiB? Hmm... I'm considering raising that to 8 MiB since
> there are such devices too.

At least on some models I think you can desolder the RAM and replace it by a larger memory up to 4GB, because the 1394 Lead Vehicle Manual lists a feature:
"Hardware generated response to received read or write requests in a designated 4GB address range without CPU involvment."
The 1394 Lead Vehicle is not used in the PS2, but it is very similar to the IOP and it is the only manual we have about IOP. So I think the DMA mask for the device must be at least 32 Bits, because the device is able to access full 32 Bit. The EE where Linux is running may only be able to access a part of it directly. I think SIF DMA is always able to access it completely, as this is an official feature which is documented. The mapping at 0x1c000000-0x1c200000 seems just to be good luck, because it is not documented. As this is no official interface Sony is able to remove this mapping at any time in a new model. I don't know where the border of the mapping is, but in my experiements I have seen some hints that it can be different depending on which hardware or software is used. It looks like the more stuff is integrated into one single chip, the lower is the border, because I have seen strange behaviour and exceptions when accessing this memory on newer PS2 model. I limited the memor
 y to 256KB for USB OHCI because of this strange behaviour on some models, but I wasn't able to figure out what was the real cause of the problem. I just recognized that it was stable with the 256KB limit.
So the question is: What is the purpose of the DMA mask in Linux? Is it the area which can be accessed by the device? Or is it the area which can be accessed by the CPU? For the device it is 32 Bit. For the CPU it depends on the software and hardware and can be 0, because nothing may be shared with the CPU. Even with DMA mask 0, the SIF DMA is still able to access the full 32 Bit. Each memory access by the OHCI driver can't be done directly and needs first to be transferred to IOP memory via SIF DMA before it can be accessed by OHCI DMA. This is what you called linked DMA transfer. As far as I remember the USB sub-system and the OHCI driver was not written to handle memory which can't be written by the CPU at all. So I assume that you first need to allocate some temporary memory which is used to copy the data to or from the IOP DMA memory. Then I think you can increase the 256KB limit without getting an unstable system.
I heard someone talking about problems in the SMMU which were fixed by increasing the DMA mask. This lets me believe that the DMA mask is something which is required by SMMU and therefore 32 Bit should be correct. But when a hardware designer tries to add an IOMMU to the PS2, there would be at least 3 different IOMMUs needed, because we have 3 different buses (for EE, IOP and GS).

> > Alternatively, there is perhaps some degree of argument
> > for deliberately picking a nonzero but useless value like 1, although it
> > looks like the MIPS allocator (at least the dma-default one) never actually
> > checks whether the page it gets is within range of the device's coherent
> > mask, which it probably should do.
> 
> Perhaps Maciej knows more about the details of the MIPS allocator?

The original approach for USB OHCI in Linux 2.4 was that IOP memory is handled as PCI memory. I.e. the driver was "thinking" that it allocates PCI memory, but indeed there was IOP memory allocated. All DMA ops where implemented in the PCI ops and so it was just working like a PCI card with device local memory.

Best regards
Jürgen Urban

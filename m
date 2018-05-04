Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeEDHYG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:24:06 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42815 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDHYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:24:03 -0400
X-Google-Smtp-Source: AB8JxZrA3nzvh6fAO8uqtzrWn7nm6s3RU54fGOvoHeE6OaKe4gFrDjnsaRcBB8FWMvlWMXTj8GWiS3h5CCDewgYutgs=
MIME-Version: 1.0
In-Reply-To: <CAOmrzk+y5pmm2anaw15pch--y_gqoUO4NQemSbSanAXpEnttkg@mail.gmail.com>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
 <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
 <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <20180503085120.GA14574@lst.de> <CAOmrzk+y5pmm2anaw15pch--y_gqoUO4NQemSbSanAXpEnttkg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 May 2018 09:24:02 +0200
X-Google-Sender-Auth: 9mBiBhep2sWeRF68X8upbYlV81g
Message-ID: <CAMuHMdW+waQSQxLvBXEZkhCAj_kh=4SR1hZ4FAeC8YWXtRKg1A@mail.gmail.com>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, May 3, 2018 at 10:24 PM, Michael Schmitz <schmitzmic@gmail.com> wrote:
> On Thu, May 3, 2018 at 8:51 PM, Christoph Hellwig <hch@lst.de> wrote:
>> On Thu, May 03, 2018 at 10:46:56AM +0200, Geert Uytterhoeven wrote:
>>> Perhaps you can add a new helper (platform_device_register_simple_dma()?)
>>> that takes the DMA mask, too?
>>> With people setting the mask to kill the WARNING splat, this may become
>>> more common.
>>>
>>> struct platform_device_info already has a dma_mask field, but
>>> platform_device_register_resndata() explicitly sets it to zero.
>>
>> Yes, that would be useful.  The other assumption could be that
>> platform devices always allow an all-0xff dma mask.
>
> That's not always true (Atari NCR5380 SCSI and floppy would use a 24
> bit DMA mask). We use bounce buffers allocated from a dedicated lowmem
> pool there currently, and for all I know don't use the DMA API yet.
>
> I bet that is a rare exception though. Setting the default DMA mask
> for platform devices to all-0xff and letting the few odd drivers force
> a different setting seems the best way forward.

I'd say that's usually a property of the platform, not of the device?
So IMHO it belongs in the platform code, not in the device driver code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

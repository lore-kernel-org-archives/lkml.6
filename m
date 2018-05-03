Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeECUYo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:24:44 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41070 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeECUYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:24:39 -0400
X-Google-Smtp-Source: AB8JxZpNzXUHcmzod7LVwl/tE9LZu6Vix2u2/TFdG7wl+OHPcHSSJmRc3zwwUS2OsxO3y/rVtz83hXyWdPDpt1imSBI=
MIME-Version: 1.0
In-Reply-To: <20180503085120.GA14574@lst.de>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
 <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
 <alpine.LNX.2.21.1805031801310.8@nippy.intranet> <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <20180503085120.GA14574@lst.de>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Fri, 4 May 2018 08:24:38 +1200
Message-ID: <CAOmrzk+y5pmm2anaw15pch--y_gqoUO4NQemSbSanAXpEnttkg@mail.gmail.com>
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, May 3, 2018 at 8:51 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, May 03, 2018 at 10:46:56AM +0200, Geert Uytterhoeven wrote:
>> Perhaps you can add a new helper (platform_device_register_simple_dma()?)
>> that takes the DMA mask, too?
>> With people setting the mask to kill the WARNING splat, this may become
>> more common.
>>
>> struct platform_device_info already has a dma_mask field, but
>> platform_device_register_resndata() explicitly sets it to zero.
>
> Yes, that would be useful.  The other assumption could be that
> platform devices always allow an all-0xff dma mask.

That's not always true (Atari NCR5380 SCSI and floppy would use a 24
bit DMA mask). We use bounce buffers allocated from a dedicated lowmem
pool there currently, and for all I know don't use the DMA API yet.

I bet that is a rare exception though. Setting the default DMA mask
for platform devices to all-0xff and letting the few odd drivers force
a different setting seems the best way forward.

Cheers,

  Michael



> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

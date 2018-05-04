Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeEDIRL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:17:11 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36608 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeEDIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:17:07 -0400
X-Google-Smtp-Source: AB8JxZrfrViOOpZrmQfaLHg+MN335PZ4j1U2RvCr8AbQmb3sQDfRCVtiw6f4Zq/nQqM3YT82TT32Ag==
Subject: Re: [PATCH net] macmace: Set platform device coherent_dma_mask
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <S1751632AbeECEYA/20180503042400Z+254@vger.kernel.org>
 <CAMuHMdUAxmVZLekekvVrnMbbL18oyY86sF9QX087idSqcKMiPQ@mail.gmail.com>
 <alpine.LNX.2.21.1805031801310.8@nippy.intranet>
 <CAMuHMdU1XBqt7hwEW6JTas64ZNGCGCMr5HMZwuLo0O-ZBCOWyA@mail.gmail.com>
 <20180503085120.GA14574@lst.de>
 <CAOmrzk+y5pmm2anaw15pch--y_gqoUO4NQemSbSanAXpEnttkg@mail.gmail.com>
 <CAMuHMdW+waQSQxLvBXEZkhCAj_kh=4SR1hZ4FAeC8YWXtRKg1A@mail.gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <bf7667f7-a11f-87ac-3aca-130cca86d328@gmail.com>
Date: Fri, 4 May 2018 20:16:58 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW+waQSQxLvBXEZkhCAj_kh=4SR1hZ4FAeC8YWXtRKg1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Am 04.05.2018 um 19:24 schrieb Geert Uytterhoeven:
> Hi Michael,
> 
>>> Yes, that would be useful.  The other assumption could be that
>>> platform devices always allow an all-0xff dma mask.
>>
>> That's not always true (Atari NCR5380 SCSI and floppy would use a 24
>> bit DMA mask). We use bounce buffers allocated from a dedicated lowmem
>> pool there currently, and for all I know don't use the DMA API yet.
>>
>> I bet that is a rare exception though. Setting the default DMA mask
>> for platform devices to all-0xff and letting the few odd drivers force
>> a different setting seems the best way forward.
> 
> I'd say that's usually a property of the platform, not of the device?

Right - I was thinking 'm68k' as platform, not a particular machine like
Mac or Falcon (the 24 bit mask only applies to that particular model
anyway).

> So IMHO it belongs in the platform code, not in the device driver code.

OK - let's have a default mask of 64 bit, and allow machine specific
platform_init() to override using a new helper function.

Cheers,

	Michael

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

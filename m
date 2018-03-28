Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeC1HxQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:53:16 -0400
Received: from verein.lst.de ([213.95.11.211]:44377 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750753AbeC1HxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:53:14 -0400
Date: Wed, 28 Mar 2018 09:53:13 +0200
From: "hch@lst.de" <hch@lst.de>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Evgeniy.Didin@synopsys.com" <Evgeniy.Didin@synopsys.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: dma-mapping: clearing GFP_ZERO flag caused crashes of Ethernet
        on arc/hsdk board.
Message-ID: <20180328075313.GA19864@lst.de>
References: <1522170774.2593.9.camel@synopsys.com> <CAHp75VeZSsdR1=ZhOM6jseYCP3m0GyE=8EjJUxWosze9BBw9rQ@mail.gmail.com> <1522185558.6917.7.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522185558.6917.7.camel@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The logical question is why?
> 
> 1. See that's another platform with ARC core so maybe in case of ARM
>    DMA allocator already zeroes pages regardless provided flags -
>    personally I didn't check that.

Yes, most architectures always clear memory returned by dma_alloc*.
Looks like a few don't and my commit got them in trouble.  As usual
I'd prefer to match x86 semantics for now to avoid problems.

I'll send patches for arc and s390 which seem to be actually used
holdouts, and will look if anyone else is also affected.

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-986160-1521540260-2-9901683154259454777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521540259; b=W19moE1Pm7d9DazVqhjNFcLIQIsrxYjbCy3xwKypVO4ipgr
    fGMy9JUStXyLISUkOSAv9zWIceefvBd/aWGzlYWg0jWrJTqYWLcMgfQetzDWAc/t
    geKeTKFQHa6lC/WeE4BBkPT0Jh13s6PKf6SDYLkjipA0+J6yoadIMeZdZFbYWKnJ
    wx3mq1nHckIos+mJxlW3DhmAqPXH4J1xphJHho2q4vu7FNQqO98fXYPWl1RzSxAb
    YpYcingoAblUZ7zk9nI+r1Q+bgzh1FdQyqHwKM3omGyI8PwwdXHwtoZA0xI0fMCb
    b3tZD53bg8ohXfrnANzy6orPnpUwvbYl1UGHJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521540259; bh=/
    0Om8q3werVxZbCN4J8334IyHEHiYXbKRKNd8CRnPb8=; b=Dm1cKgYMIq7svqOfz
    UFF8Pn4msWrHWI2DPXn5ruJzDO5g0BY6CeM5bcUcBjQB9J9iar7uSGKbFLzNDaHO
    YfsttIh49uWr84KyMhH8lxhgojTcksqgUS4n/jLTmU3XXmYRtIh2Isvr0QVPEbHJ
    1XbBEQpaSTpeBH97NFncjP01gQdM/VSi8eivmFU3HsXJTf22MMfN5h2gxsABA2mx
    YneW9X4Be1Rigx23XbRNlGTpwDUBrftKbUU623zmsvrwCg+5kmMAS/6kk2g0jS29
    wugkVGDvmmyvU1FwPD7PcjBS1D3Zi6gvFOnuTX8nZ7yphQX2xydmPROKfWU2O0KH
    /hNEQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qOT/zv+z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=acQHTQcj;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qOT/zv+z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=acQHTQcj;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELumy88xSEAojA/8eB6lXpBCboCr18V7tlSQv1PT4alJlbk0XVkYJ+mY1s3raKLBoZtM49z8UWjNKI7z9mezVIA=
MIME-Version: 1.0
In-Reply-To: <CANk1AXR3sv2=G-KsQh1p0rdcvy-3XZs6qVy5EMbcAMS6OSVzeQ@mail.gmail.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-7-git-send-email-geert@linux-m68k.org>
 <CANk1AXR3sv2=G-KsQh1p0rdcvy-3XZs6qVy5EMbcAMS6OSVzeQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Mar 2018 11:04:09 +0100
X-Google-Sender-Auth: 9_BBDWtk2KvxqXY7sjqxkaL7gYI
Message-ID: <CAMuHMdU-0VOs6MYrCaCrtRfBqGgaQfox1AgbExNNcYxVC6Uh-Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] fpga: Remove depends on HAS_DMA in case of
 platform dependency
To: Alan Tull <atull@kernel.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
 linux-iio@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
 netdev <netdev@vger.kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Linux I2C <linux-i2c@vger.kernel.org>, linux1394-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, scsi <linux-scsi@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>, Joerg Roedel <joro@8bytes.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 linux-serial@vger.kernel.org, Matias Bjorling <mb@lightnvm.io>,
 David Woodhouse <dwmw2@infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>, driverdevel <devel@driverdev.osuosl.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Felipe Balbi <balbi@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-spi <linux-spi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S . Miller" <davem@davemloft.net>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alan,

On Mon, Mar 19, 2018 at 5:06 PM, Alan Tull <atull@kernel.org> wrote:
> On Fri, Mar 16, 2018 at 8:51 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> This essentially removes this commit
>
> commit 1c8cb409491403036919dd1c6b45013dc8835a44
> Author: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Date:   Wed Aug 3 13:45:46 2016 -0700
>
>     drivers/fpga/Kconfig: fix build failure
>
>     While building m32r allmodconfig the build is failing with the error:
>
>       ERROR: "bad_dma_ops" [drivers/fpga/zynq-fpga.ko] undefined!
>
>     Xilinx Zynq FPGA is using DMA but there was no dependency while
>     building.
>
>     Link: http://lkml.kernel.org/r/1464346526-13913-1-git-send-email-sudipm.mukherjee@gmail.com
>     Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>     Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
>     Cc: Alan Tull <atull@opensource.altera.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Yes it does. The major change is that the first (core) series introduces
all needed dummies to do successful compile-testing on NO_DMA=y platforms.

>> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
>> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
>> In most cases this other symbol is an architecture or platform specific
>> symbol, or PCI.
>>
>> Generic symbols and drivers without platform dependencies keep their
>> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
>> cannot work anyway.
>>
>> This simplifies the dependencies, and allows to improve compile-testing.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Acked-by: Robin Murphy <robin.murphy@arm.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

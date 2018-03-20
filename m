Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2022467-1521570063-2-16285018407682916770
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521570062; b=Mp68j7h4BDFhENVVFHBiobVKZ9iHubzU02E9LEqnlFcj1eZ
    VMSVHQhvjASFe/cJZTeo2hJZwYhfmXNmabLD1G31AbAG+ZmQIrUsmrorLY3Kq4Xx
    P9+QwKV9oK8d7poYlyyuKzNCS09VdCRHNVxppI+NFl/Szc6Ofr8QLlM1j2Qc9TRT
    M3WtP+Z7cfw+7YVesa6zNKfqGFw+rpfgMYOI9hePrLQP4ohK4VczeZ6EB6WuRoWM
    LioQ+NCYL5R6yUjv+jsGhn66smK5Qt65JxViL1NZQyNICnFiey0NdtTGBzQIxME5
    Y6oulhpKRt8eRupy3oUD9RcQXNhnOedQiHji6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521570062; bh=U
    aFaeCCt0WIWbSUPDfo8Lcxr/GsR8laLsAxYrxu4iEM=; b=YWi73SgMQQdH0JXQ1
    Y0gBQVk6eB0HGRXG3ArLz0hvWC3WAz13euoiwHqpGy3eg+ZQ3WCAS0RINDooDsoQ
    6L+5tcTCtzADMtcyWBx+3GK8AOkTxT5oBhK5s6I4/gbvFW2+JsH4NjNA7eM+0cZ8
    ybJ7ORxaah+MpQZKZqyoxbh6vLg9d0MmD0DR09zHnJMvK+y19TixV3kj6QdCG4Fm
    /if8p4xdT+m3hAMjrrDu84NQd+LG1zPJfx7pT4WPwy1L9P9afppPkd3EzDjqzlnw
    Ild/jKz5OiRT4ceQd+4LWxAknkzZiDBBmR/eOltk9l6CDB526hn7PF5jp9LPJQXx
    nlKBg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DF821851
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AG47ELuPEw1U5SGpC1c7MLCA+xY+KsGl/UJneDtjd9CKzfpX1E32HeRTPE23hL6CXeiftC4Q4L94hNfihL6dQj//Fdo=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU-0VOs6MYrCaCrtRfBqGgaQfox1AgbExNNcYxVC6Uh-Q@mail.gmail.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-7-git-send-email-geert@linux-m68k.org>
 <CANk1AXR3sv2=G-KsQh1p0rdcvy-3XZs6qVy5EMbcAMS6OSVzeQ@mail.gmail.com>
 <CAMuHMdU-0VOs6MYrCaCrtRfBqGgaQfox1AgbExNNcYxVC6Uh-Q@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 20 Mar 2018 13:20:11 -0500
X-Gmail-Original-Message-ID: <CANk1AXRve3asPTufFYe=C_YPfyGwDpXxOWYZbWDq2bAnVkj00A@mail.gmail.com>
Message-ID: <CANk1AXRve3asPTufFYe=C_YPfyGwDpXxOWYZbWDq2bAnVkj00A@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] fpga: Remove depends on HAS_DMA in case of
 platform dependency
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Mar 20, 2018 at 5:04 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

Hi Geert,

> Hi Alan,
>
> On Mon, Mar 19, 2018 at 5:06 PM, Alan Tull <atull@kernel.org> wrote:
>> On Fri, Mar 16, 2018 at 8:51 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> This essentially removes this commit
>>
>> commit 1c8cb409491403036919dd1c6b45013dc8835a44
>> Author: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>> Date:   Wed Aug 3 13:45:46 2016 -0700
>>
>>     drivers/fpga/Kconfig: fix build failure
>>
>>     While building m32r allmodconfig the build is failing with the error:
>>
>>       ERROR: "bad_dma_ops" [drivers/fpga/zynq-fpga.ko] undefined!
>>
>>     Xilinx Zynq FPGA is using DMA but there was no dependency while
>>     building.
>>
>>     Link: http://lkml.kernel.org/r/1464346526-13913-1-git-send-email-sudipm.mukherjee@gmail.com
>>     Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>     Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
>>     Cc: Alan Tull <atull@opensource.altera.com>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Yes it does. The major change is that the first (core) series introduces
> all needed dummies to do successful compile-testing on NO_DMA=y platforms.

OK yes, I looked at the first patch that does the fix.  Looks good.
Thanks for doing this.

>
>>> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
>>> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
>>> In most cases this other symbol is an architecture or platform specific
>>> symbol, or PCI.
>>>
>>> Generic symbols and drivers without platform dependencies keep their
>>> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
>>> cannot work anyway.
>>>
>>> This simplifies the dependencies, and allows to improve compile-testing.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Reviewed-by: Mark Brown <broonie@kernel.org>
>>> Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Alan Tull <atull@kernel.org>

Regards,
Alan

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214944-2-16452835605294413435
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
    t=1521214927; b=cCHapzDrHyQfmGJ/mw+B3VfRFln+4w3j89wa/XDVPAm7jvt
    aZ5Io9RldRrfdgQ6c6XdOTBD3rdxp88zEgoYyoRV5CBCwvZKx/u2cF82QXLtk5ye
    iigZ07NnOXkGM8eOgGjpctW72/FMdn80R8MpYkFKN6EFzSqopG8u3rrwVR2w3nlF
    Y5JTCxg2Jkusnhy22sCvl6XSWc2iPlMN3HP/OoLWfTNGmdRwf+LVkby8JhMFT/uh
    FwMzMAjlLo0LIO+lQDOP0yHwF4vZ/7+YKq2UVa97YIoLQhDfdprPYf/HvB2ZztMl
    /JoEGgM2HFSGOzJntcK+XGWDRYJJmtTxXZqJHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521214927; bh=f
    B+Xg84lsQgJYxTSnfZ7Wgp+RjaDyt0Y1TaLb1rDXgM=; b=iODU52Jc5TVFDs2ea
    Yqpg/wc9NUot2mXAGAax6T02GMf4AUVTLmEUtDlN/+2idKTj5gRYNJ4Gri7IQ+Jp
    9T1jReUQFGJDwcgn2BUd7pArVkgNsr07eB1Y8DPGfPTvIESv+b4AKESLHNIQk7sg
    hnIUdwWsu7YVG3aSTTG/n8/luv+NsNBYD2Hn1koTsL+iFn5c3ud9jIcIKljCEVgb
    leRukGspju24FoZ4NQT9n+46S8px49huEFLUREYTE06B4z1aTH5jqOPAYcARgWqX
    OS7hKM01ZUmq3DXmqclwf1YVaG3GEe+D1IEJaMBJ/XNws+KfHDswdGtBUulWibQW
    DWzYg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=abBwJFNN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KwzcumV6;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=abBwJFNN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KwzcumV6;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELst/PddN6OSpmB1OJTrKOuz4Q2LOws2s+wwIjPTU6GJr4cvv5n5CxrTHpKgByDahCR847A8LthfpktuDjE3mQU=
MIME-Version: 1.0
In-Reply-To: <20180316151410.GA6527@gondor.apana.org.au>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <20180316151410.GA6527@gondor.apana.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Mar 2018 16:41:57 +0100
X-Google-Sender-Auth: m3kMmAdfKmZjW_6m7MPSHwthd50
Message-ID: <CAMuHMdUKULvoB6-6EhsYpdbWEEEfjtn27GbzpXj7+Mz+=qeOnw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
To: Herbert Xu <herbert@gondor.apana.org.au>
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
 scsi <linux-scsi@vger.kernel.org>, Richard Weinberger <richard@nod.at>,
 Joerg Roedel <joro@8bytes.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, linux-serial@vger.kernel.org,
 Matias Bjorling <mb@lightnvm.io>, David Woodhouse <dwmw2@infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>, driverdevel <devel@driverdev.osuosl.org>,
 Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Moritz Fischer <mdf@kernel.org>,
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

Hi Herbert,

On Fri, Mar 16, 2018 at 4:14 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, Mar 16, 2018 at 02:51:33PM +0100, Geert Uytterhoeven wrote:
>> This patch series:
>>   - Removes dependencies on HAS_DMA for symbols that already have
>>     platform dependencies implying HAS_DMA.
>>
>> To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
>> this (drivers) series should be applied after the previous (core)
>> series (but not many people may notice/care ;-)
>>
>> Changes compared to v1:
>>   - Add Reviewed-by, Acked-by,
>>   - Drop dependency of SND_SOC_LPASS_IPQ806X on HAS_DMA,
>>   - Drop dependency of VIDEOBUF{,2}_DMA_{CONTIG,SG} on HAS_DMA,
>>   - Drop new dependencies of VIDEO_IPU3_CIO2, DVB_C8SECTPFE, and
>>     MTD_NAND_MARVELL on HAS_DMA,
>>   - Split in per-subsystem patches,
>>   - Split-off the core part in a separate series.
>>
>> This series is against v4.16-rc5. It can also be found at
>> https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=no-dma-compile-testing-v2
>>
>> It has been compile-tested with allmodconfig and allyesconfig for
>> m68k/sun3, and has received attention from the kbuild test robot.
>
> Do these patches have any dependencies? Can they be applied directly
> in a subsystem tree?

| To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
| this (drivers) series should be applied after the previous (core)
| series (but not many people may notice/care ;-)

Apart from introducing build failures in allmodconfig/allyesconfig builds on
(uncommon) NO_DMA=y platforms, they can be applied directly and individually.

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

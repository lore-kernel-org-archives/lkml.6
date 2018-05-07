Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-382095-1525677718-2-1413502371729570446
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525677718; b=Ye/F+VwUPWIye5tMYJ2n2s7ooXAIELuCCqTcFOFt+f7OGxwaXN
    gNfDwhmPEtM9F6L90C75xXzPa06HffQZmu3WCsvpYYWU3wYPMZzgR7K20qY9vNR+
    r18XrNumscIAzX68XemGVvzNLnGY3Lee9rxksQmbcIeg5eZltnLmgPbK98PSp2B4
    x9wc1ZEq4CH51XUVuz2IOs/VD2kmSrc79NowSRriz6L2wmbki7vS8KkcjAsIEMs7
    5qn4edfr6GSPmy5OQrRitsVE2y6n+Ww01QX0PnNo9gmbeP6RI1R2lxgGGG+y2MKb
    XKzTjuoxanBKqMgfOWPrD7D87b3hn2fdsTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525677718; bh=aepDT
    K7SA42GUZQzF1FatfuJ36puwGRrQe3mOI9ovS8=; b=i7BCmJZd+EJIFhTlwdjs0
    gU/R30MHUHbzuuVd3fD/R0epsqNStnta5oo0ICmm1IE4n/XWSQoCJVa+LuTfBqbe
    vAQVmQODOd6eXOX3ujmY3xhaMYZ0yk5LW4QPbQmFwNoX4owXXwh80oaBXpBBx2zS
    Axt634JQSDOUS68I3OttsZ44PKPxf2oz/J7J4kzwrr/8xnHna2g91Fwsu6As64Dc
    WAYs+3+VOBaTbSVdzA702KHTrhNIrlMZPeA1LGn0YuH7DOtMRElalHlblr+eqQvB
    V0jUjFACpJxrWzPN2cSzKrKB3hGeU2C0fDXFFjOQR29lwfAb4s7Jd0G+pJZFgP9n
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=iWAQQPAo x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=aOO9WLFN;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=iWAQQPAo x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=aOO9WLFN;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA3sESU+HzIalmBgyoJ+sjFZ8WJVfsf/d46OY1uypQpL7XbyQiEv1dFg14Fiwh9ntHYE/LYrmTyil+t17DyeebXBMF9Su9TMdjv8C4ReZe8S/DeM/ava
    ZMrsMK70Vns3lfM5/vZ8hR86K/nRXPWCgbkdVc39WCQiN2f6vVh/OqNN5fL8PzYh1fNf70nX6CFM7HKWAh+LnCwgQTQ1r5nX4EEZkMCLuX7Z0imi8My/NpGC
    8tMZkA05IJNrp27yVMPdxg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=tBb2bbeoAAAA:8
    a=DDOyTI_5AAAA:8 a=ehAlpLcAVyUD3Dw46EwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrCWoXJCrDcehFuWwS+mppz0AF86w9LMlfqJuzUUt4+Ti1TtK4UmA/t02/0hkarZMS9P9AOwvtxv5d9BYxUEMo=
MIME-Version: 1.0
In-Reply-To: <20180505094743.4d201ba0@vento.lan>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
 <1523987360-18760-13-git-send-email-geert@linux-m68k.org>
 <20180505094743.4d201ba0@vento.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 May 2018 09:21:47 +0200
X-Google-Sender-Auth: FqKElX-Q9jfqY0zcIk_ktsuM340
Message-ID: <CAMuHMdXp8u9O7Yt3W+WxuOOadYOM+_28DLOMfktwgy_WqML_0A@mail.gmail.com>
Subject: Re: [PATCH v3 12/20] media: Remove depends on HAS_DMA in case of
 platform dependency
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
 netdev <netdev@vger.kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Linux I2C <linux-i2c@vger.kernel.org>, linux1394-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Joerg Roedel <joro@8bytes.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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
 Felipe Balbi <balbi@kernel.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-spi <linux-spi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>,
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

Hi Mauro,

On Sat, May 5, 2018 at 2:47 PM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> Em Tue, 17 Apr 2018 19:49:12 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
>
>> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
>> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
>
> Applying a patch like that is hard, as there are lots of churn at
> the code. That's against latest media upstream:

[...]

I can rebase. What's your preferred target? media-next?

>> In most cases this other symbol is an architecture or platform specific
>> symbol, or PCI.
>>
>> Generic symbols and drivers without platform dependencies keep their
>> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
>> cannot work anyway.
>
> Actually, depends on HAS_DMA was introduced on media because builds
> were failing otherwise. We started adding it before the addition
> of COMPILE_TEST.

Indeed. Before the 5 commits below, a missing dependency on HAS_DMA
would cause the build to fail for NO_DMA platforms.

    f29ab49b5388b2f8 dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
    ab642e952f80c66c dma-coherent: Add NO_DMA dummies for managed DMA API
    c1ce6c2beea38171 mm: Add NO_DMA dummies for DMA pool API
    bff739b6559e2fce scsi: Add NO_DMA dummies for SCSI DMA mapping API
    1f674e16f9ce6eb2 usb: gadget: Add NO_DMA dummies for DMA mapping API

> Can we just remove all HAS_DMA Kconfig dependencies as a hole from the
> entire media subsystem, with something like:
>
>         $ for i in $(find drivers/media -name Kconfig) $(find drivers/staging/media -name Kconfig); do sed '/depends on HAS_DMA/d;s/ && HAS_DMA//g' -i $i; done
>
> Or would it cause build issues?

It should not cause build issues, but it would enable lots of drivers that
need DMA platform support on platforms where they wouldn't work, making the
life of distro configurators harder.

That's why my series removes HAS_DMA only for symbols that have a platform
dependency.

Thanks!

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

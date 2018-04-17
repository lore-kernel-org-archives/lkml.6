Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2367869-1523987294-2-11992607087798874534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523987293; b=eiTusJsVdbdlPHNPxc2C+tOl8G80kAeB+SzTtuHCwv9XJguiBv
    IdHYnXHp+eJSmuK+2fEf7GVExb4x7Zo7VrJIexBmMCwk7S0uwH5FPVHNOMd90o3S
    7T+pTZZ5q6lWIfzwTy8cspiphv0ta5CMCK9C5fcmbCPQAepqGvToKhXV45uu3xVR
    I1Y4pxatQMpdigx9wO+AX6qPzdeL788DEY3vuMuEGz/I8Oi+Eh6DS8+PD6p97H28
    Kjy7lxed67rAalEzGb4NxdyRG7HkaRYHiz2muPzyuAitAsnOrPvOe8b+VrdjMbgf
    HxAswiyeJ2nNxb6LqgXh3aG4M/pYsO5RhdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523987293; bh=ysVfr
    1W346TzxRUdEyDDk+j5c9+wQo2AO/pZUuHL0XI=; b=dTZCDlRoorTOGlSRmxH1x
    B6pU12HILOlSyZlKtpfk+84HFBd2ZQsi6klj2wtlSGWjAV/2K6+skqaTYo9MMAfA
    D1QSaUm1nS/J4n2ZXOQOD5iAk/fZgmk8qp589WeaK9MeNMBnIvDRrKo/bFs245Ni
    37yODZPsF+Aczxaf1I/5CU8ovDowZ3MJcvxl2skO/SOnNx5gsvVdqkxTbpKwMhRM
    LmQKkdPeOnk9+G3cuKGvXdXJah7POeMq6CVociqUA7Vh8v4PXrok+Hs96tB6YaD4
    jgxnb5a3c/194Xt2jlg8E/t/n0rUlgr7Y1dWRWEjIgcA+LO9e4RcIkpaSaNLOzB7
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eplFbjYz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N3g6t7QQ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eplFbjYz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N3g6t7QQ;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK4w5+sm8fpw7Pg6eJaDsWS1T+EGjo7B3nliu21PKXAV36JpmZx8kGiOmDPiJN8GnfW0mB/zLV5QhsIbZi3PfOnXnXKeX8Nby4xfPmJVIiPSyjtkBRMw
    6D+UtoHDFRwLfbzniyOY1MU4kiE/ABu3RPEsGUsVPYEEdLh92fbvUFyXYUuI1zc01L0uduieDztp2uud/1TVRn2aLgzrMHFUVOLoXrgSHNHBgmpzTslAQ5KW
    ehtxwL6aRFYwnVUyCf6Tmw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=tBb2bbeoAAAA:8
    a=DDOyTI_5AAAA:8 a=gpLIBaJHDwOuF0mSB2cA:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48nf+w9PxDD6qiveUruOmxra2vNmSWPKeBPkc/clFaPLV2Dxdytn1O/Br/ogggJkuE/1nYvL5QxYD9rQz7qdQE=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJMppYaz31Gg8BH2OaAxs56dnjZ4y+nzBBp-Tt2odaqCw@mail.gmail.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <CAL_JsqJMppYaz31Gg8BH2OaAxs56dnjZ4y+nzBBp-Tt2odaqCw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Apr 2018 19:48:01 +0200
X-Google-Sender-Auth: IFLwgvS49uW1XFRVu8zSa4MmpAY
Message-ID: <CAMuHMdUrLW7gdsUfKQ5FHBHh1t5ecYBSy-6ZKxPSJoP6TQzXvw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
To: Rob Herring <robherring2@gmail.com>
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
 <linux-remoteproc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
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
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Matias Bjorling <mb@lightnvm.io>, David Woodhouse <dwmw2@infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>, driverdevel <devel@driverdev.osuosl.org>,
 Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Moritz Fischer <mdf@kernel.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Felipe Balbi <balbi@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
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

Hi Rob,

On Thu, Apr 5, 2018 at 2:32 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Mar 16, 2018 at 8:51 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> If NO_DMA=y, get_dma_ops() returns a reference to the non-existing
>> symbol bad_dma_ops, thus causing a link failure if it is ever used.
>>
>> The intention of this is twofold:
>>   1. To catch users of the DMA API on systems that do no support the DMA
>>      mapping API,
>>   2. To avoid building drivers that cannot work on such systems anyway.
>>
>> However, the disadvantage is that we have to keep on adding dependencies
>> on HAS_DMA all over the place.
>>
>> Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
>> more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
>> already covering intention #2.  Having to add an explicit dependency on
>> HAS_DMA here is cumbersome, and hinders compile-testing.
>
> The same can be said for CONFIG_IOMEM and CONFIG_OF. Any plans to
> remove those too? CONFIG_IOMEM is mostly just a !CONFIG_UM option.

Perhaps, if time permits...

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

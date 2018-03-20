Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-986160-1521540418-2-7395081585862436225
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
    t=1521540417; b=MN/WReahBfG03CTfoXZ2AScFsFLjtP/ARmySVH1dGYpFPR5
    cIq6pLx34EjFtkz3jGqjjB8m1NLmlu6flOiAkr3kJqOxU3tbDUlpO3LJLe4gPlUd
    inTosgnbXr55U0dAPxYl9ntM6qjuMS7uVMuSiOo7DjMrMSj9PMver/hBSLepBZg+
    sOO/GeO1+a8BUhGrDKfn3uaJW1tqJ5d+pavx7Mn/JW8Vij+rdfpxhgY6yWzozx08
    CEDBKZ710+yqUhfPTHQ/DQgQfK57rDDz4WzJN/nV4tvVPpTzawn3uZq657Alf0xe
    NTixB3W3CU7e3mHtpKw6dsxePWOkBv6IBZEVq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521540417; bh=0
    FUth9E5890kaVG66RLjXcd3esuc0ETPYuQ5693xdxE=; b=TtEdNpylxbHOHnVov
    NdxfhmXCmGXzQ7W3zuxl+zHvl0LnlrrSBTyWejjaldcPcAhKM1Helc7tC3Nb2aWS
    19k0+hrk9d2cN8s3XaoIGyDZEe/q6sIyEX6+PdpEFuMzQMs9u/OL+zkOSX4wC4C1
    IKGZOYxUaMd03MDwRoa+GavIxboOVymj3pAO+8pdpCX1PNEBIGcpvIFpok8SR+Ps
    I7r+fR/fmo1H4QZIurxRkaoKTtBakJEownj2DTQpZ8cB7vjzeP/On4DKsWffnMo+
    Kh6nBVCgq4qv7uZYhKXZPI21/nkVIOSHrlSb94wX/rMioxFIbHdvJNVxeDSedrAU
    zVRkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MWymDeTe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GgHOf9tT;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MWymDeTe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GgHOf9tT;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtORuZ7G1L8USec1Uqbc8Ti9PUwzBH/SgR43T1LT5dXw6JW2YmxAActVKY4HmpNpQmUhZGsa2A7rTfzvP0q4sA=
MIME-Version: 1.0
In-Reply-To: <20180318230410.382f69a1@bbrezillon>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-15-git-send-email-geert@linux-m68k.org>
 <20180318230410.382f69a1@bbrezillon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Mar 2018 11:06:48 +0100
X-Google-Sender-Auth: lHD6ysmOl3s44OvcFygAppQPbi0
Message-ID: <CAMuHMdW2ohqEC2QZ8p7d9cN08a14pV19VcyWMKLS-egzc5JLMA@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] mtd: Remove depends on HAS_DMA in case of
 platform dependency
To: Boris Brezillon <boris.brezillon@bootlin.com>
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

Hi Boris,

On Sun, Mar 18, 2018 at 11:04 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Fri, 16 Mar 2018 14:51:47 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
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
>
> Don't know which release you're targeting but it's likely to conflict
> with the change I have in my nand/next branch. Is this a problem if I
> take this patch through the mtd tree after [1] has reached Linus' tree?

No problem, I will rebase and resubmit after v4.17-rc1.

> [1]https://lkml.org/lkml/2018/3/16/435
>
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

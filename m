Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1747912-1525524538-2-14964309564326550533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525524537; b=NnUEOB+1Y6W4jpkEpyiRZALhjYW08kAVj4GWL1Uk37weKfRu2N
    qTLXukHgGg2vNW32J7cJtL5VeaOM8HmVHnL85RMwFzSfJFTzJuu+RxyNNcH/4Yx/
    TwX/gByVBOHXC4NL5tkeC2n7bD07win1J1XHQcHI5j2z9SUFc+KsU2IMD+juxDjV
    Q/9SnQPPFBaMdMUe5r85ZQNX1y3RlYcEq7kZ5Rnpl2Q2OSot5ITPLWiUwEy2v2vG
    LyddKm+qRPIBbrXpdaq/COWf9kFSFSg2a15ljb6Aqn/A1OoxOGwktAvCkNUReyF8
    qlr9Q+NiX7S+3y57a79mWObC3d2AAHMFQv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525524537; bh=KK0FU
    08VIqwBUUEos48R8DCGf0/zWT4tK02nky/hXCU=; b=HW7gnSDiatDMIhxxmSvZv
    EobOK/zdwWxXpByvLty66/OisDcjtUrdmKH9Ii7M/wUi0idcmxATnGib33QJokGg
    uQopERLa01t9rWSJDB36FFlfpBXT7Zw3RXjh9eOUlYVlTG7NE3NRKqi8TUkeZ19K
    Ttpeuex4Qn7sxrKj8PzsIx7AOqvwwTxEQiAuGtvLqC/W5clmJrs3uTLC6Yc7urKf
    8dzHDc8M4Otl1HeKFsd2dWIuBKd3XGQHGss2JsET2gHsEmFetNRkznF9fuqCyVU7
    dxPCCAbmyiA0+Se/LSsDnvtkB/XKCtDNtwOdIR2SXgmUvlbyWoHHpsxqBXiuZ/D0
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=FqRTPZbR
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=FqRTPZbR
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFVGMKZ2mo0vIKA39tRI70I+Qu4Ng5AlTJjPRGmxTiX4xzkzezKakd52P+7Vt8bI/Kep6kTEbfYuXleCJDeXq5PdRqDNbVU2tu2wQT00+7yMrZt3FL31
    NstaRMgZluZRvGfMzH1shFt2t86p9ZsOWp9ySQ/tqrbO1DuMgvximXr+QJBmZiji+S5d4aN1A8YfCQI8qpRHk/13/hopWbm/L7d+MmcyY4lvTEyrGKYFyMxJ
    7CQEZK0I6MnSm6vaWJGm5A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=DDOyTI_5AAAA:8
    a=dkTHDUvtyvX_5yIpi9MA:9 a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 5 May 2018 09:47:43 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 12/20] media: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180505094743.4d201ba0@vento.lan>
In-Reply-To: <1523987360-18760-13-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
 <1523987360-18760-13-git-send-email-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
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
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Joerg Roedel <joro@8bytes.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, linux-serial@vger.kernel.org,
 Matias Bjorling <mb@lightnvm.io>, David Woodhouse <dwmw2@infradead.org>,
 linux-media@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
 devel@driverdev.osuosl.org, Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 linux-fbdev@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-spi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
 linux-crypto@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
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

Hi Geert,

Em Tue, 17 Apr 2018 19:49:12 +0200
Geert Uytterhoeven <geert@linux-m68k.org> escreveu:

> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".

Applying a patch like that is hard, as there are lots of churn at
the code. That's against latest media upstream:

checking file drivers/media/pci/intel/ipu3/Kconfig
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED
checking file drivers/media/pci/solo6x10/Kconfig
checking file drivers/media/pci/sta2x11/Kconfig
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED
checking file drivers/media/pci/tw5864/Kconfig
checking file drivers/media/pci/tw686x/Kconfig
checking file drivers/media/platform/Kconfig
Hunk #2 FAILED at 63.
Hunk #3 succeeded at 81 (offset 1 line).
Hunk #4 succeeded at 91 (offset 1 line).
Hunk #5 succeeded at 101 (offset 1 line).
Hunk #6 succeeded at 111 (offset 1 line).
Hunk #7 succeeded at 124 (offset 1 line).
Hunk #8 succeeded at 142 (offset 1 line).
Hunk #9 succeeded at 169 (offset 1 line).
Hunk #10 succeeded at 186 (offset 1 line).
Hunk #11 succeeded at 197 (offset 1 line).
Hunk #12 succeeded at 213 (offset 1 line).
Hunk #13 succeeded at 227 (offset 1 line).
Hunk #14 succeeded at 254 (offset 1 line).
Hunk #15 succeeded at 265 (offset 1 line).
Hunk #16 succeeded at 275 (offset 1 line).
Hunk #17 succeeded at 284 (offset 1 line).
Hunk #18 succeeded at 295 (offset 1 line).
Hunk #19 succeeded at 303 (offset 1 line).
Hunk #20 succeeded at 312 (offset 1 line).
Hunk #21 succeeded at 338 (offset 1 line).
Hunk #22 succeeded at 383 (offset 1 line).
Hunk #23 succeeded at 397 (offset 1 line).
Hunk #24 succeeded at 422 (offset 1 line).
Hunk #25 succeeded at 435 (offset 1 line).
Hunk #26 succeeded at 452 (offset 1 line).
Hunk #27 succeeded at 470 (offset 1 line).
Hunk #28 succeeded at 612 (offset 1 line).
1 out of 28 hunks FAILED

> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.

Actually, depends on HAS_DMA was introduced on media because builds
were failing otherwise. We started adding it before the addition 
of COMPILE_TEST.

Can we just remove all HAS_DMA Kconfig dependencies as a hole from the
entire media subsystem, with something like:

	$ for i in $(find drivers/media -name Kconfig) $(find drivers/staging/media -name Kconfig); do sed '/depends on HAS_DMA/d;s/ && HAS_DMA//g' -i $i; done

Or would it cause build issues?

Regards,
Mauro




Thanks,
Mauro
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

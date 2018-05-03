Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2513336-1525352584-2-8711951129861859484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525352583; b=iEu2Kys9kS8N5fJz6X0S/FYa3f8x4XcOCvNBtmwXnkSZD75Trq
    DBBuGNw3RwHDbBgqtrfbOrUMod8ByntYIZFZVZc5upS62MHJeLMAwFm/yHxNYNlS
    qTlFCa8BEsE+34yt3Rk6Dv/3HrDpEwcfzFoY/SNKWWh4zMOZQ8O4cHXqUV1jh7hr
    xH2MTCt3DAUDwiVRt3x34KYuyMiN7oRQYCNqW/MaVc1mCWYCLndhql8uSK+rwaFP
    IG3RDTqcpZmk/BkayPL0J9tBGJ1U+LI/5RrElBeQk8lCqr7/8znJT//gepFOC7+E
    OQxel7fx/UPlEM5BPDcOEx/CT0aniMiNZxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525352583; bh=J4ZdO
    sU09laWwBlvCDsQ8Y5QdEvSLPGWGfa/JMSCvb8=; b=MptnLMgu0CC4o7UUtmX8N
    85WcYa/8+gbZ0Nx4WvnvlrxoZK7y/E46VnrKMeV4NJuawvvk56rOBa8dCLMgWvMZ
    F/zuYkCPtdP1+vUJ+EqHuQVMG2Btv/L6TqgkENr4R9fEtpRiROdho1Bhrxl8hfL6
    i4Jga4O0WmYUdxB1dd5WA8BhUqr1MD3XIwdXlG9WDCMHcFQdtlxLWX1rRMW07Z+e
    D3FqOH8ZropCzn59WMYm+8M1gpfcoHpMVSpIxGNNj2ScmDLEdfXQbobwUrPgcqNm
    OPmdWmwCGn8KE68aPsieSZY7KtyuGAN7F1VBAWJ3s6xWtV6EW2wjy43uWQxW3Ftc
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=8bytes.org header.i=@8bytes.org header.b=YkpuKBCX x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=8bytes.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=8bytes.org header.i=@8bytes.org header.b=YkpuKBCX x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=8bytes.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAIe7p+dyo750oenJwHeNSbovMadvqvoE3MHX8MRqxkYYkWZOPaC/mBjT8V8ZfzcPH2BTkn8kw6FXj47fUAeOkAINdQsnqe8t6kSehqVVLuwZKxJa7K+
    oIlUMtavmeS09XBKduMIdYvSVbpzhCq1Q8fcPIVBI4D922+fK8zQ9t8eJDaiGMYnr5nydsTb3B3foNoqFLh3mr/7deTZMwWEbWmf/LVttFExj2SHst7VtIev
    JSppRZ7DwDSPB8i7NtbWmw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=DDOyTI_5AAAA:8 a=CKI3KOnNTA-zpUAOr0UA:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 3 May 2018 15:02:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 09/20] iommu: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180503130244.ifal7n4tyxvekjnj@8bytes.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
 <1523987360-18760-10-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523987360-18760-10-git-send-email-geert@linux-m68k.org>
User-Agent: NeoMutt/20170421 (1.8.2)
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
 Jassi Brar <jassisinghbrar@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 linux-serial@vger.kernel.org, Matias Bjorling <mb@lightnvm.io>,
 linux-media@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
 devel@driverdev.osuosl.org, Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, linux-fbdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Felipe Balbi <balbi@kernel.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-crypto@vger.kernel.org,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "David S . Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 07:49:09PM +0200, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Joerg Roedel <jroedel@suse.de>

Applied, thanks.

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

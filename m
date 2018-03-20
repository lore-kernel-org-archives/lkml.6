Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-986160-1521539859-2-9188536116881908697
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
    t=1521539858; b=jzN4sD05lbla6UKztXUg1KIs7zAS/eP6bU45QBJnHpbjhsc
    PGaoOCZV5SvMvJdkGmDTLTkwVH5Iw3z3Y01ph3Y7krTyGX3pb+2fNKX8InJkAejt
    WXUB6ySmgXvFs9YTrnYc019DnU/hkI8uO8gLEP7TB2NFZLgp+Voj5KWKJvV2Om3F
    VMMVYR0KloswZ7JufSSS7IY9wXasnTcW6knHc5MQmgSWu6M29byxzBuxsufaeT4r
    L7rQgkbU8Et/2IQeKMM3zsp/mhFZfhZ9wPfxALrT1Zg6i4SIr+8KpffYKGjDvvRj
    MLZhi68kArjfH9Ht6EwN6UM7MRI99XX4lsUVJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521539858; bh=H
    0kHiyvk1TodiMoopo80ZqLsl8Gm3PhMFZrE+sd2C4s=; b=RX97K8FJwbQvwcPhT
    00KVSVBE0KE7hmqbikbRIGcX63KHDP7dDFex9KwTmf6BvQ2pwIhjF9FvqukOaIaV
    Vr+q/0Jr7xmDYZlOENf2IjM1YtcHCQ624qvGsYN7iyNPdDjo9sQkOPmtJzORfOu9
    GYe7tesfg7CDw3kdpktZvGbrKPP/MepXi6R6p8JB77vi5U4WZulCYZfTqu+y/ZN6
    Jlw+QQ1PYPVYv9KtsheVeHCUCGHGzNLBd7C1uFwcr+98yM9wJB7t32msz84/GMkT
    poV8NOMSeNuQDOOPpfr7+PML8/5pYpGONxvcuAbWEDOcWeSAsNldPqw7RYxSNPxd
    3Q6LQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lFv3b4Ld x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qZTK+dpm;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lFv3b4Ld x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qZTK+dpm;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsc9ykBlUm2JZZZeSO7XvRcX380i0g0SRfYd+NdhViYa4X0SRBrvviLnbCXWqUoP9W2v2p8pI2ju6iNjvXalW4=
MIME-Version: 1.0
In-Reply-To: <20180316212317.7d5rri3p25hpmx44@ninjato>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <20180316212317.7d5rri3p25hpmx44@ninjato>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Mar 2018 10:57:28 +0100
X-Google-Sender-Auth: Cx4nL72ze8EHzKqqhrOcpfMAANI
Message-ID: <CAMuHMdUUKMngcyajm_s==KbhL3ZjMNHVxhNNGkPWkpnePE2rMw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
To: Wolfram Sang <wsa@the-dreams.de>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-iio@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-remoteproc@vger.kernel.org,
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

Hi Wolfram,

On Fri, Mar 16, 2018 at 10:23 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
>> this (drivers) series should be applied after the previous (core)
>> series (but not many people may notice/care ;-)
>
> I still don't get if there is a dependency on the core patches. I.e.
> shall I apply the subsystem patch now by myself or do you want to push
> the series after the core patch and need my ack here?

Yes, there is a dependency. Without the core patches, enabling COMPILE_TEST,
and compile-testing drivers irrelevant on obscure NO_DMA=y platforms will
cause build failures.

To play it safe, you want to postpone the subsystem patches until the core
part has landed upstream. I will rebase and resubmit after v4.17-rc1.

Thanks, and sorry for being unclear.

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

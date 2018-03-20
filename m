Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1105679-1521540553-2-7173674515408975684
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
    t=1521540553; b=gx2Rd3CqgfRvlSRXElAZt77Il08bU/pjjlQ0Cncsj5kAIGo
    SBIA+2KEmcnVSbO92W6+U1EUfbND338FLBbSRFusseku7ouWIt0f/vlgBu7OVii8
    mD4iP9ih+z12a9Yf5qMin9IU0YTSztk/ZPoQvRnTVu/v9KpMXwP+ihKLiMoVUFve
    a8l3S31inx6lIYPN0jg2cQWjg3SSY0Tyfr3ITtrp0/q+vXbNH5ZB6DQ03a8zd8oc
    d5sOrwN/PJvFkgsZGcpe922pWfKx7eOyMlvIicKOqSKXmtOfowR1ReUnzRIzKDu3
    WK3fkrdeACHlQGtNvUwxAJgmLGFst7Ov+58tTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521540553; bh=1
    /LoUoeopbPG43d3HIZDfmyeieeIhaZUF81xTwh/p+Y=; b=FJE5YDNzEv+Z9qFY3
    JOGDyarY/nv6VWmZHx3CMDF5Qimc81C/XMtO3kgCjNsuDSnq44N4OglU0HBJih5U
    lT/VED9H41ggNZdo+tSKMSP4/D2F7XDEF0cMVEkX+LEQg+P3t0LaiDantB/L+kIA
    L1pd2YvJIMSLsSxiVk3nSHJpERdJWdjPpgP/L+fUB60wOEjZCNT2W58vDxEVChg1
    5Rr+DlqVkUa1Ht6B40DunLG1OHTjAzu2Gb3QLkGHivPywB2JI5RYIyrEQC8ux5eH
    XnmSVlvUP6oyEvKzJQWrSGLD6NpxIXQxc+fxubKPTbkFXrHk0v7melo8HSvB0isr
    jgTEg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lWHyJCRa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=D0QqexxM;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lWHyJCRa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=D0QqexxM;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsv5xYmqvryLqFYdMhMNkneYnZTRmwOPpakatXqgzDgpu1Hp21m2PTPRyhZsJQkgHGmlm/UZq97xk/vlyam53s=
MIME-Version: 1.0
In-Reply-To: <AM5PR04MB3267989AB6A81639F61AB165ECD40@AM5PR04MB3267.eurprd04.prod.outlook.com>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-11-git-send-email-geert@linux-m68k.org>
 <AM5PR04MB3267989AB6A81639F61AB165ECD40@AM5PR04MB3267.eurprd04.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Mar 2018 11:09:06 +0100
X-Google-Sender-Auth: UbYBiZNQ3bQ6LCLHN70nKunvLoE
Message-ID: <CAMuHMdXZNqO0NDESs9Y3uJs0kmQSXY05ei0xJE9uT9EUixuxAQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] lightnvm: Remove depends on HAS_DMA in case of
 platform dependency
To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
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
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux1394-devel@lists.sourceforge.net"
 <linux1394-devel@lists.sourceforge.net>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>, Joerg Roedel <joro@8bytes.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Matias Bjorling <mb@lightnvm.io>, David Woodhouse <dwmw2@infradead.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Felipe Balbi <balbi@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
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

Hi Madalin-cristian,

On Mon, Mar 19, 2018 at 6:27 AM, Madalin-cristian Bucur
<madalin.bucur@nxp.com> wrote:
>> -----Original Message-----
>> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
>> On Behalf Of Geert Uytterhoeven
>> Remove dependencies on HAS_DMA where a Kconfig symbol depends on
>> another
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
>> Notes:
>>   - FSL_FMAN keeps its dependency on HAS_DMA, as it calls set_dma_ops(),
>>     which does not exist if HAS_DMA=n (Do we need a dummy? The use of
>>     set_dma_ops() in this driver is questionable),
>
> Hi,
>
> The set_dma_ops() is no longer required in the fsl/fman, I'll send a patch to remove it.

Thank you, looking forward to it!

>>   - SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_PLATFORM loose their
>>     dependency on HAS_DMA, as they are selected from
>>     SND_SOC_APQ8016_SBC.
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

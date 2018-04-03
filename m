Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1832042-1522769960-2-14064480201366797995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522769958; b=DjdOyF22OmV+qn530vvO99aiGn1/HB1SVVNzt3d+L7+FMVX4EZ
    +8LIuXhI4NF/SUexdRlSiAB7C5iW1RrcABGUAUXrnIUt8Y/BoxNBzGnHh2vUyoGV
    nqpBfI0A7SHJvnrA2oDip6c7Iltg/ETOtufPDChMTL2bkyYnkYrE8/b7/C57c7LE
    1p1r3A2iloPW/Udf1xHoifc7RawqVbYlXx8whJ2P7dzCCxJ5rh19Cj1WtXeri1bi
    /9DoRMqv+DvuXwdFGvJxYf5ZeOwy8IJ4/LK3XBTtS++bBHPDmv28E7MknCkB6ypa
    ZYwrXS/OzBtamnUIwawG63GMdASuCbD+CvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522769958; bh=e4u/5
    IBjY9+Tq1N1nEHT9r+1JJ7n8s71D2nRmYM//z8=; b=r/gleJHfSiwZz8ic1aywf
    uioGy7YF2ZD1JRXKLiNrgJV7HHaBh6B5goV0aa8f2ty2+lWHb0s/GX/3d9x1PA27
    f8WEQlOvtGavpzRCmFUZSCPfXBphdKuyQW95oUX3MgTZb8P7aOOaOfAjdZM9qqYW
    Yh4MdC5qpe117cvbxEK1cusujUB3DcI+TLkO2fne64LX+DyRdIsiRZru9UlaKh0K
    n2aBF2ExbsNvQywF2ZX6DmvkflpXkV8dkQIxmAlBPUyiV76tHn9L/hD3T3aGvczr
    75BSQoqlbSjB228ldIo6P1jdxXHShCcrjSMW2GV0e+omt9v9PEaP0qLuP0TIl7iy
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nej04Qzp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P15aBFiB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nej04Qzp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P15aBFiB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOXoFpt8FbGpY/7KlVeT/XFkoyCPRHq7lfbBjscZOW12uX5PBtlXL4C3BWfQ+CPNKPkI/8JoIKelNys/55uMXSH00r8lB5bMeH+ym9rYqdnkU5uhxocA
    nD8oussZ1NW2tcE1xE8kfDoTylI4KgaPTVXx6hkSOSvD1ja4rkfRU5/zd15GCMXlr42CUPw+iZu3Dt25Qr+BC6e587axk3yRj6RF0w/0mV28TmETq13xkWPk
    wUZcJmpyy4ilqrSsJv6vyg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=NKF3q6Ty5xSe5C7JOTEA:9
    a=xgJuoCrB_Xp59KlH:21 a=gonDi58az3nhbHVb:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4++zd2sitC5cQN9CTCPklA5kTxgfQooq571SvbJsL3ozjBpV8hmvj3A6+5gGtpyD8CPUO4gLv04DI83Xbzz500=
MIME-Version: 1.0
In-Reply-To: <87tvss48ti.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-3-robert.jarzmik@free.fr>
 <CAK8P3a3pSitVqfiF2LK0cMrAKLOeCWXXJBLeVc5f_Tg=vALkUA@mail.gmail.com>
 <87tvss48ti.fsf@belgarion.home>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 17:39:08 +0200
X-Google-Sender-Auth: 5adpF_wUGcNLyez34-tIusmfvTk
Message-ID: <CAK8P3a2FFVnPj4+VoQET3-Jz2DaYbc6UUJnX1fH5s8VumJZ7Og@mail.gmail.com>
Subject: Re: [PATCH 02/15] ARM: pxa: add dma slave map
To: Robert Jarzmik <robert.jarzmik@free.fr>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, IDE-ML <linux-ide@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 devel@driverdev.osuosl.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>,
 Takashi Iwai <tiwai@suse.com>, Russell King <linux@armlinux.org.uk>,
 Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Samuel Ortiz <samuel@sortiz.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Tejun Heo <tj@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 5:18 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>>> +       { "smc911x.0", "rx", PDMA_FILTER_PARAM(LOWEST, -1) },
>>> +       { "smc911x.0", "tx", PDMA_FILTER_PARAM(LOWEST, -1) },
>>> +       { "smc91x.0", "data", PDMA_FILTER_PARAM(LOWEST, -1) },
>>
>> This one is interesting, as you are dealing with an off-chip device,
>> and the channel number is '-'1. How does this even work? Does it
>> mean
>
> This relies on pxa_dma, in which the "-1" for a requestor line means "no
> requestor" or said in another way "always requesting". As a consequence, as soon
> as the DMA descriptors are queued, the transfer begins, and it is supposed
> implicitely that the FIFO output availability is at least as quick as the system
> bus and the DMA size is perfectly fit for the FIFO available bytes.
>
> This is what has been the underlying of DMA transfers of smc91x(x) on the PXA
> platforms, where the smc91x(s) are directly wired on the system bus (the same
> bus having DRAM, SRAM, IO-mapped devices).

Ok, I looked at the driver in more detail now and found the scary parts.
So it's using the async DMA interface to do synchronous DMA in
interrupt context in order to transfer the rx data faster than an readsl()
would, correct?

It still feels odd to me that there is an entry in the slave map for
a device that does not have a request line. However, it also seems
that the entire code in those two drivers that deals with DMA is specific
to PXA anyway, so maybe it can be done differently: instead of
calling dma_request_slave_channel_compat() or dma_request_chan()
with a fake request line, how about calling dma_request_channel()
with an NULL filter function and data, and have the driver handle
the empty data case the same way as the rq=-1 case today?

>>> +       /* PXA25x specific map */
>>> +       { "pxa25x-ssp.0", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
>>> +       { "pxa25x-ssp.0", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
>>> +       { "pxa25x-nssp.1", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
>>> +       { "pxa25x-nssp.1", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
>>> +       { "pxa25x-nssp.2", "rx", PDMA_FILTER_PARAM(LOWEST, 23) },
>>> +       { "pxa25x-nssp.2", "tx", PDMA_FILTER_PARAM(LOWEST, 24) },
>>> +       { "pxa-pcm-audio", "nssp2_rx", PDMA_FILTER_PARAM(LOWEST, 15) },
>>> +       { "pxa-pcm-audio", "nssp2_tx", PDMA_FILTER_PARAM(LOWEST, 16) },
>>> +       { "pxa-pcm-audio", "nssp3_rx", PDMA_FILTER_PARAM(LOWEST, 23) },
>>> +       { "pxa-pcm-audio", "nssp3_tx", PDMA_FILTER_PARAM(LOWEST, 24) },
>>> +
>>> +       /* PXA27x specific map */
>>> +       { "pxa-pcm-audio", "ssp3_rx", PDMA_FILTER_PARAM(LOWEST, 66) },
>>> +       { "pxa-pcm-audio", "ssp3_tx", PDMA_FILTER_PARAM(LOWEST, 67) },
>>> +       { "pxa27x-camera.0", "CI_Y", PDMA_FILTER_PARAM(HIGHEST, 68) },
>>> +       { "pxa27x-camera.0", "CI_U", PDMA_FILTER_PARAM(HIGHEST, 69) },
>>> +       { "pxa27x-camera.0", "CI_V", PDMA_FILTER_PARAM(HIGHEST, 70) },
>>> +
>>> +       /* PXA3xx specific map */
>>> +       { "pxa-pcm-audio", "ssp4_rx", PDMA_FILTER_PARAM(LOWEST, 2) },
>>> +       { "pxa-pcm-audio", "ssp4_tx", PDMA_FILTER_PARAM(LOWEST, 3) },
>>> +       { "pxa2xx-mci.1", "rx", PDMA_FILTER_PARAM(LOWEST, 93) },
>>> +       { "pxa2xx-mci.1", "tx", PDMA_FILTER_PARAM(LOWEST, 94) },
>>> +       { "pxa3xx-nand", "data", PDMA_FILTER_PARAM(LOWEST, 97) },
>>> +       { "pxa2xx-mci.2", "rx", PDMA_FILTER_PARAM(LOWEST, 100) },
>>> +       { "pxa2xx-mci.2", "tx", PDMA_FILTER_PARAM(LOWEST, 101) },
>>> +};
>>
>> Since more than half the entries in here are chip specific, maybe it would be
>> better to split that table into three and have a copy for each one in
>> arch/arm/mach-pxa/pxa{25x.27x.3xx}.c?
> Mmmh, today the split is :
>  - 16 common entries
>  - 10 pxa25x specific entries
>  - 5 pxa27x specific entries
>  - 7 pxa3xx specific entries
>  => total of 38 lines
>
> After the split we'll have :
>  - 26 pxa25x specific entries
>  - 21 pxa27x specific entries
>  - 23 pxa3xx specific entries
>  => total of 70 lines
>
> That doubles the number of lines, not counting the declarations, and amending of
> pxa2xx_set_dmac_info().
>
> If you think it's worth it, what is the driving benefit behind ?

It seems a bit cleaner to only register the tables for the dma lines that
are actually present on a given chip.

>> Does that mean it's actually a memory-to-memory transfer with a device being
>> on the external SRAM interface?
> I'm taking this is the follow up to the "-1" question :0

Right.

        Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-854779-1522738308-2-2753371142847566831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522738307; b=UF5stEDf232xcYqGc1y+Oh400/UrmLRXpdijt+DaYb60xFvC5L
    uI2m3DHsWcYs669atJ67jeHiCkG2ZNLelz9FlZDRh9Kbe3mdB6NHDgdEkandAnlc
    pLEaNpDFQxVAtqANL5GZRQ6p/lATkEz2Fv6JyuDnWvBg2aEE1Yaa4AfI9wO1t2Go
    UbNZ483Vl0OvkROLt30fXEJ16DASp9nUupA8a2bryHgnTxk8qITXFed1wuYMDj0f
    bNxZVMSCWd55FZ3EMBmMjxs/CR2so2xW4syc2wxF0cxDpg30QPuta/vw8LLPOClB
    /EHiwG7GOEwPQNrtztkmm4xV+wenn54AZoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522738307; bh=jiiM/
    mUyjFhxgT0qkK+xBGxd4cTulmFmsSPSFS3cysk=; b=G/joIa0Izm8wOIHPOI+6V
    Kl0LIXjMuvUs+p5ikSDJb5/hZLNuTu7lR7JnhiCXi5+4sydhxpxOuBsQXTLgJO0/
    RnURE53JSA0/6Is9mEfKnpKKcnKkBGGwhmZ7CYHx3opVX451Zog9PVjx4iNx0emN
    NPlkZsBhOVWyEJ/4fFfIFaHyBF8yAq9N6mnbOG+rEBAh44UJrtdzh+ClLwXMq76u
    5qM4ELIGoCO2g/Q9jBhJBTVymSOHRoMdeZGfbYHcga5anJ1SNTubtZbIZCcIC/Dh
    D4O/hAhzgpoJybTNo5ZulR6lw2EUN1lNQmAFLFnrfhlla/CDgh7/bxUgoA1MmnTa
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VmHX1rgk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RsGimW+o;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VmHX1rgk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RsGimW+o;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHc/WH7h1yJdYiKlQ9Uy4aj8jQTtpp56YjbRHzYQ1/upVTbOtHVik8i7ZWTiiLaf0g96gWA0Z+OIuMhRk9z3bKq+DTic9K8cdxLt+l/h1Yg5bW+cb8ie
    /aQ4a8A+fTmwOKPOkn9LdQaF6y7jSK1/BzAaUIaSsVmbWZiQVMhvHcHdmBm6wzw4PHdNsLBN49HjiJQg9HY1YAbN/iRy8noJTkdjKV2DN88wvQumhXpYHlii
    5wczBpc5brq0Qv2ED4LREQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=trmq3IoyueeSbaebCCwA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+1Psj4fh1GgTn5/iVgVniPY38Gi+btE6tEKTCmrK/bBi1qE0wsON9l40QOe5WVcpbexlqENFl5IIiDBRycn0U=
MIME-Version: 1.0
In-Reply-To: <20180402142656.26815-3-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-3-robert.jarzmik@free.fr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 08:51:37 +0200
X-Google-Sender-Auth: pFRafwfKOeEHKo09MZpmwOVXwME
Message-ID: <CAK8P3a3pSitVqfiF2LK0cMrAKLOeCWXXJBLeVc5f_Tg=vALkUA@mail.gmail.com>
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

On Mon, Apr 2, 2018 at 4:26 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> +
> +static const struct dma_slave_map pxa_slave_map[] = {
> +       /* PXA25x, PXA27x and PXA3xx common entries */
> +       { "pxa-pcm-audio", "ac97_mic_mono", PDMA_FILTER_PARAM(LOWEST, 8) },
> +       { "pxa-pcm-audio", "ac97_aux_mono_in", PDMA_FILTER_PARAM(LOWEST, 9) },
> +       { "pxa-pcm-audio", "ac97_aux_mono_out", PDMA_FILTER_PARAM(LOWEST, 10) },
> +       { "pxa-pcm-audio", "ac97_stereo_in", PDMA_FILTER_PARAM(LOWEST, 11) },
> +       { "pxa-pcm-audio", "ac97_stereo_out", PDMA_FILTER_PARAM(LOWEST, 12) },
> +       { "pxa-pcm-audio", "ssp1_rx", PDMA_FILTER_PARAM(LOWEST, 13) },
> +       { "pxa-pcm-audio", "ssp1_tx", PDMA_FILTER_PARAM(LOWEST, 14) },
> +       { "pxa-pcm-audio", "ssp2_rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> +       { "pxa-pcm-audio", "ssp2_tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> +       { "pxa2xx-ir", "rx", PDMA_FILTER_PARAM(LOWEST, 17) },
> +       { "pxa2xx-ir", "tx", PDMA_FILTER_PARAM(LOWEST, 18) },
> +       { "pxa2xx-mci.0", "rx", PDMA_FILTER_PARAM(LOWEST, 21) },
> +       { "pxa2xx-mci.0", "tx", PDMA_FILTER_PARAM(LOWEST, 22) },


> +       { "smc911x.0", "rx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +       { "smc911x.0", "tx", PDMA_FILTER_PARAM(LOWEST, -1) },
> +       { "smc91x.0", "data", PDMA_FILTER_PARAM(LOWEST, -1) },

This one is interesting, as you are dealing with an off-chip device,
and the channel number is '-'1. How does this even work? Does it
mean

> +       /* PXA25x specific map */
> +       { "pxa25x-ssp.0", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
> +       { "pxa25x-ssp.0", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
> +       { "pxa25x-nssp.1", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> +       { "pxa25x-nssp.1", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> +       { "pxa25x-nssp.2", "rx", PDMA_FILTER_PARAM(LOWEST, 23) },
> +       { "pxa25x-nssp.2", "tx", PDMA_FILTER_PARAM(LOWEST, 24) },
> +       { "pxa-pcm-audio", "nssp2_rx", PDMA_FILTER_PARAM(LOWEST, 15) },
> +       { "pxa-pcm-audio", "nssp2_tx", PDMA_FILTER_PARAM(LOWEST, 16) },
> +       { "pxa-pcm-audio", "nssp3_rx", PDMA_FILTER_PARAM(LOWEST, 23) },
> +       { "pxa-pcm-audio", "nssp3_tx", PDMA_FILTER_PARAM(LOWEST, 24) },
> +
> +       /* PXA27x specific map */
> +       { "pxa-pcm-audio", "ssp3_rx", PDMA_FILTER_PARAM(LOWEST, 66) },
> +       { "pxa-pcm-audio", "ssp3_tx", PDMA_FILTER_PARAM(LOWEST, 67) },
> +       { "pxa27x-camera.0", "CI_Y", PDMA_FILTER_PARAM(HIGHEST, 68) },
> +       { "pxa27x-camera.0", "CI_U", PDMA_FILTER_PARAM(HIGHEST, 69) },
> +       { "pxa27x-camera.0", "CI_V", PDMA_FILTER_PARAM(HIGHEST, 70) },
> +
> +       /* PXA3xx specific map */
> +       { "pxa-pcm-audio", "ssp4_rx", PDMA_FILTER_PARAM(LOWEST, 2) },
> +       { "pxa-pcm-audio", "ssp4_tx", PDMA_FILTER_PARAM(LOWEST, 3) },
> +       { "pxa2xx-mci.1", "rx", PDMA_FILTER_PARAM(LOWEST, 93) },
> +       { "pxa2xx-mci.1", "tx", PDMA_FILTER_PARAM(LOWEST, 94) },
> +       { "pxa3xx-nand", "data", PDMA_FILTER_PARAM(LOWEST, 97) },
> +       { "pxa2xx-mci.2", "rx", PDMA_FILTER_PARAM(LOWEST, 100) },
> +       { "pxa2xx-mci.2", "tx", PDMA_FILTER_PARAM(LOWEST, 101) },
> +};

Since more than half the entries in here are chip specific, maybe it would be
better to split that table into three and have a copy for each one in
arch/arm/mach-pxa/pxa{25x.27x.3xx}.c? Does that mean it's actually
a memory-to-memory transfer with a device being on the external
SRAM interface?

       Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

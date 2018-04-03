Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-909279-1522739215-2-13940222002491802247
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
    1522739215; b=GXtjB5vbffiSmxt2MSMaYln2ByswYUIjSfdBr3KcFOpx2TQ8uJ
    a5aAuk50lfjKFY5wgpFBp0ClIYfABk4yMW29Jy1wtL5ENJ2eeyROeDS7f22mkfxv
    BCiJcFkY7rud+8X4MtblyCHdW+pC8dUFG1gaxellczqbg6Dp6nRFFg0lpexxO7oU
    2kvIEyys6BNOi7Ena9qBd3IUnk31k2U3pReoy9nl/8hsQEbD0Lo2pTRbZm2ypShF
    t8j35R+P+wBfGFGArrrm6bcB68uoGxCBa+I+zRdxkKccOUDU737ArCR3FsJHRqZ8
    LTLSpRqkltupVMhR7abmSNJVmAf4Rz0ivprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522739215; bh=Zzny5
    eHV0LFVFsXbcatcJXyP5LS+/WDKt6arPTKRp3Q=; b=XASNHm/g7CTDA4jO6d/6Y
    VTBsRTC2gdrDUFmjWoTWI+LuyL05vuBZ/s1koQqvQEJmc1BEfWm08kiPeGmvhawg
    wnwCHez++iQFnF5Pj+gadj2ge4C8D2kgQOCBwLVpk2n4Atnhn1q+mLQGIlwLJyZk
    0AGgI9JEud9rhHX411VqC6cIVGsZsVlpIT/IBvIBn5shuE7vPlDefaFyCMPE7QJN
    uPIvljH1hfstPX3epz5oUu0MEZ+SYa5woPtt/ZZqVrxl/Tdl8oax3zojEBCYsS/V
    zg7R5130QKOA2Wgsbwd2GG7wBjk2C2+b/oMDWKyR2Rqef4XycrKVt5CSAByElmF8
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xq6fKgnv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fe6ozm9e;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xq6fKgnv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fe6ozm9e;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF0e0CEAwroM5YR1NW323p9x5ZG+4aEHB8/3zXGKZiT0yMT0Yuusp1x0FwvsSZoSbcQXjgtFTephX8GGvW6ZXIaWljwFcE7ZXHFsyY+frgggXR817Uuj
    OHjUo3ZeRLlefCtlozEcy1AwdOQ8gPv4jWFys1Gds96aqefuRqJ5NH6cRtPmP8fGK2LBtFF1mdff9329Tphvl8faFDLkVzds4lWtaUcIj6d/31IblshwBw/3
    Xnaxl+iBHQpzMqGjLftU/w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=36Dk5VdrRMVujahIgl4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+aBmt383iJRhSbGzl1mpLYHxjTlDQVUk6i6wvA9GjO5MwtYfgY7Z+BKP09Q2DJ6Zh9RQPWsjsBWQjOvC6k8F4=
MIME-Version: 1.0
In-Reply-To: <20180402142656.26815-15-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-15-robert.jarzmik@free.fr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 09:06:46 +0200
X-Google-Sender-Auth: UyYJjYD_XY9oOqM_az1JcumPJEw
Message-ID: <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] ARM: pxa: change SSP devices allocation
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, alsa-devel@alsa-project.org,
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
 Philippe Ombredanne <pombredanne@nexb.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
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

>
> +static struct pxa_ssp_info pxa_ssp_infos[] = {
> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
> +       { .dma_chan_rx_name = "ssp1_rx", .dma_chan_tx_name = "ssp1_tx", },
> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
> +       { .dma_chan_rx_name = "ssp2_rx", .dma_chan_tx_name = "ssp2_tx", },
> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
> +       { .dma_chan_rx_name = "ssp3_rx", .dma_chan_tx_name = "ssp3_tx", },
> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
> +       { .dma_chan_rx_name = "ssp4_rx", .dma_chan_tx_name = "ssp4_tx", },
> +};

This part looks odd to me, you're adding an extra level of indirection to
do two stages of lookups in some form of platform data.

Why can't you just always use "rx" and "tx" as the names here?

(also, I don't see why each line is duplicated, but I'm sure there's
an easy answer for that).

       Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

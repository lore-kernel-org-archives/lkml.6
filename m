Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1782788-1522768132-2-116057162590626621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522768131; b=iyT8wB1YT4zaQ//uRYYfyw85bRV1ls/Xi5zgXm3f/tKM8pcvYS
    oV0qmmlUU757Rv6wR/EBpPTom10z//sRouWIX45AHvlNF6iSOndH1D+EB18Y+Iay
    x3jkk+v1o3W6QGqCB5rb7n3OyA8NPaA9wvvCiYoI6Fzsxzh/2ymWrmu9ZVQ2nZOT
    m8N7Fp5CGvgvid/jEUqlrQVbwU0gxiYUIycOLLWxKuerUFlYkcWxFhQ8Hq2qBOKT
    vj4xXk6MW5S/7LEn9igT9ikBAY6/MWmP0CoFCCFyL1i4SBIwuMy+ZeDchEsyey8F
    MSkWBNatSCK0X0zRZDCg5UVBLRPOFgkpYqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522768131; bh=OHirC
    6kfhRyHghPBwAtPwTcvIp9YWMG0XtS8Zdgwlsk=; b=vYmG8d6h5wjSYYXNHf1S/
    bGw1fef0vC4HGPBukjg7/LtXUB74+rZZuwj9KXkXRnDOupMRmEdWoI9ArrptAyL9
    DU3f5g26aR0aW3wtxcPv6biruqB6fp2ePa76yl25v98CCnHs8QPd95WYyMw+nZyX
    zpaEAA/5uWoYezLZQY9IPbSdwgs96wdlwqYmq2jUyVmqJ3WmvugdIiYfP/d818Xn
    jUkKez1RfSQn69YzsPq1c2fECZbx/8JCSPaJplnbNn2XR8HQYq6g1gAPW2pwKeHN
    kSpVCSM8Ndg2WqMlpa1ZXtpT2ckhbmi1bmVysRiTCon45WO4RylqFkH3e39zezs3
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=G6/LjdFI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t7+OHIEP;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=G6/LjdFI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t7+OHIEP;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJFKHUuPM34vKkoC6Tme7xTB6s76QIFAsbX3QMSQUUIGROaxOPn/7Rr+zQpAT9AN+NddXwiahuNmvLJU0M4Rr5SHqI0bL/FrnycTMzi+nFVYdSsiXGIR
    g42pTcWWm2modxYk3cdTlZJL61TeixCFkGeDWJ4jiLXz/VoSHjGPqHDHflbpLSpstRFND5YzCoxyzGJHv8k/UJThW41EX5Q2lRHKzxrdJgPHsv8uKtrGzCNL
    MONXeCvF1e0+fmkt9d8buA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=KKAkSRfTAAAA:8 a=DDOyTI_5AAAA:8
    a=M5xsSrE1qK_39k9jjXgA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49hpSBeBIbPrYQYlOZ9MbXRJeNK8JK13uqPrzg5/02mBa8odN5uCbg4Nmt/AAfreWhhkIttN1iTw1/EFDIJakQ=
MIME-Version: 1.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Apr 2018 17:08:42 +0200
Message-ID: <CAPDyKFot9dAST2jQL5s8E4U=bCHxkio=uwpqPd6S0N4FWJRB-w@mail.gmail.com>
Subject: Re: [PATCH 00/15] ARM: pxa: switch to DMA slave maps
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
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 linux-ide@vger.kernel.org, netdev@vger.kernel.org,
 linux-mtd@lists.infradead.org, driverdevel <devel@driverdev.osuosl.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Vinod Koul <vinod.koul@intel.com>, Richard Weinberger <richard@nod.at>,
 Takashi Iwai <tiwai@suse.com>, Marek Vasut <marek.vasut@gmail.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 linux-media@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, dmaengine@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
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

On 2 April 2018 at 16:26, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Hi,
>
> This serie is aimed at removing the dmaengine slave compat use, and transfer
> knowledge of the DMA requestors into architecture code.
>
> This was discussed/advised by Arnd a couple of years back, it's almost time.
>
> The serie is divided in 3 phasees :
>  - phase 1 : patch 1/15 and patch 2/15
>    => this is the preparation work
>  - phase 2 : patches 3/15 .. 10/15
>    => this is the switch of all the drivers
>    => this one will require either an Ack of the maintainers or be taken by them
>       once phase 1 is merged
>  - phase 3 : patches 11/15
>    => this is the last part, cleanup and removal of export of the DMA filter
>       function
>
> As this looks like a patch bomb, each maintainer expressing for his tree either
> an Ack or "I want to take through my tree" will be spared in the next iterations
> of this serie.

Perhaps an option is to send this hole series as PR for 3.17 rc1, that
would removed some churns and make this faster/easier? Well, if you
receive the needed acks of course.

For the mmc change:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> Several of these changes have been tested on actual hardware, including :
>  - pxamci
>  - pxa_camera
>  - smc*
>  - ASoC and SSP
>
> Happy review.
>
> Robert Jarzmik (15):
>   dmaengine: pxa: use a dma slave map
>   ARM: pxa: add dma slave map
>   mmc: pxamci: remove the dmaengine compat need
>   media: pxa_camera: remove the dmaengine compat need
>   mtd: nand: pxa3xx: remove the dmaengine compat need
>   net: smc911x: remove the dmaengine compat need
>   net: smc91x: remove the dmaengine compat need
>   ASoC: pxa: remove the dmaengine compat need
>   net: irda: pxaficp_ir: remove the dmaengine compat need
>   ata: pata_pxa: remove the dmaengine compat need
>   dmaengine: pxa: document pxad_param
>   dmaengine: pxa: make the filter function internal
>   ARM: pxa: remove the DMA IO resources
>   ARM: pxa: change SSP devices allocation
>   ARM: pxa: change SSP DMA channels allocation
>
>  arch/arm/mach-pxa/devices.c               | 269 ++++++++++++++----------------
>  arch/arm/mach-pxa/devices.h               |  14 +-
>  arch/arm/mach-pxa/include/mach/audio.h    |  12 ++
>  arch/arm/mach-pxa/pxa25x.c                |   4 +-
>  arch/arm/mach-pxa/pxa27x.c                |   4 +-
>  arch/arm/mach-pxa/pxa3xx.c                |   5 +-
>  arch/arm/plat-pxa/ssp.c                   |  50 +-----
>  drivers/ata/pata_pxa.c                    |  10 +-
>  drivers/dma/pxa_dma.c                     |  13 +-
>  drivers/media/platform/pxa_camera.c       |  22 +--
>  drivers/mmc/host/pxamci.c                 |  29 +---
>  drivers/mtd/nand/pxa3xx_nand.c            |  10 +-
>  drivers/net/ethernet/smsc/smc911x.c       |  16 +-
>  drivers/net/ethernet/smsc/smc91x.c        |  12 +-
>  drivers/net/ethernet/smsc/smc91x.h        |   1 -
>  drivers/staging/irda/drivers/pxaficp_ir.c |  14 +-
>  include/linux/dma/pxa-dma.h               |  20 +--
>  include/linux/platform_data/mmp_dma.h     |   4 +
>  include/linux/pxa2xx_ssp.h                |   4 +-
>  sound/arm/pxa2xx-ac97.c                   |  14 +-
>  sound/arm/pxa2xx-pcm-lib.c                |   6 +-
>  sound/soc/pxa/pxa-ssp.c                   |   5 +-
>  sound/soc/pxa/pxa2xx-ac97.c               |  32 +---
>  23 files changed, 196 insertions(+), 374 deletions(-)
>
> --
> 2.11.0
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

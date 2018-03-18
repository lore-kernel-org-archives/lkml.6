Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1076671-1521410673-2-10624433630737211496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521410672; b=COH/JxbFDx5xuwvC9xNO8MI7ZO1A5I/kO4Z+HTralaBvg8E
    YeFRaGaUGwlOmeUNmY9PioUb5gPqObdCTgrF3bE3E6cWZPB8MzC3tuhcZqTSqAQV
    hNC6wTQ/K+Jul+L4krbjSN+v0fwHn5eLdn9MsFqDuVM+KeAIMucYWLi2ig0+JkIS
    7SEmIxVDwkXvvx6ER5YGtSsXpmLuxAeeoKamZd5PYNCtP8E0b+NW13zziji+b1Z6
    /wdsY4qxMk2WxJjhAQOJ7afu8nKM71Ce4VMPUK9i/blx0UcvOTTf2aI8xPj+ECu3
    9+cCDkf39ZL21c7sa3oihWco3wfd0kCr///77VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521410672; bh=T
    KGslegMOaz3ZL+qld1fQqB685AtxXmao9kh5TeGmlw=; b=P4ayR5uMvQVGOLfjc
    rkuDqHMN1CkJP5iT5x5cghv9kTSNaMGPd9jTihXNHxrWMSbrfSm9zL8azjsytEnq
    b8zLqloFB4Q1q2i34NquSkHjKfRXS57lHmBZRcEJk8LXSmjajVZ/vCh+Fw5cR+C/
    YNeziwCR3a7ROeZv+3XQfjWKBk5of1omjt1VhPofrRy9n8+jqAPe87NiyYZ3lQHN
    XRkAWeNfHSEf/80leKEKF7O57X2jWMZGemWbiuphItHva9hmC0YvBHVVc8EtJSR3
    NzjhwRb7RtAFdmjqJrU8R7RFh7p37z5bFUY6Wj515o4DopktOSGlAZv5WD3LPNjg
    n10Ew==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 18 Mar 2018 23:04:10 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 14/21] mtd: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180318230410.382f69a1@bbrezillon>
In-Reply-To: <1521208314-4783-15-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-15-git-send-email-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
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
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Joerg Roedel <joro@8bytes.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 linux-serial@vger.kernel.org, Matias Bjorling <mb@lightnvm.io>,
 David Woodhouse <dwmw2@infradead.org>, linux-media@vger.kernel.org,
 Ohad Ben-Cohen <ohad@wizery.com>, devel@driverdev.osuosl.org,
 Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 linux-fbdev@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-crypto@vger.kernel.org,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S .
 Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Geert,

On Fri, 16 Mar 2018 14:51:47 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

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

Don't know which release you're targeting but it's likely to conflict
with the change I have in my nand/next branch. Is this a problem if I
take this patch through the mtd tree after [1] has reached Linus' tree?

Regards,

Boris

[1]https://lkml.org/lkml/2018/3/16/435

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Drop new dependency of MTD_NAND_MARVELL on HAS_DMA,
>   - Split per subsystem.
> ---
>  drivers/mtd/nand/Kconfig    | 8 ++------
>  drivers/mtd/spi-nor/Kconfig | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 736ac887303c88ba..55a2f8a2fa90cd87 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -46,7 +46,7 @@ config MTD_NAND_DENALI
>  config MTD_NAND_DENALI_PCI
>          tristate "Support Denali NAND controller on Intel Moorestown"
>  	select MTD_NAND_DENALI
> -	depends on HAS_DMA && PCI
> +	depends on PCI
>          help
>            Enable the driver for NAND flash on Intel Moorestown, using the
>            Denali NAND controller core.
> @@ -184,7 +184,6 @@ config MTD_NAND_S3C2410_CLKSTOP
>  config MTD_NAND_TANGO
>  	tristate "NAND Flash support for Tango chips"
>  	depends on ARCH_TANGO || COMPILE_TEST
> -	depends on HAS_DMA
>  	help
>  	  Enables the NAND Flash controller on Tango chips.
>  
> @@ -328,7 +327,7 @@ config MTD_NAND_MARVELL
>  	tristate "NAND controller support on Marvell boards"
>  	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_MVEBU || \
>  		   COMPILE_TEST
> -	depends on HAS_IOMEM && HAS_DMA
> +	depends on HAS_IOMEM
>  	help
>  	  This enables the NAND flash controller driver for Marvell boards,
>  	  including:
> @@ -490,7 +489,6 @@ config MTD_NAND_SH_FLCTL
>  	tristate "Support for NAND on Renesas SuperH FLCTL"
>  	depends on SUPERH || COMPILE_TEST
>  	depends on HAS_IOMEM
> -	depends on HAS_DMA
>  	help
>  	  Several Renesas SuperH CPU has FLCTL. This option enables support
>  	  for NAND Flash using FLCTL.
> @@ -558,7 +556,6 @@ config MTD_NAND_SUNXI
>  config MTD_NAND_HISI504
>  	tristate "Support for NAND controller on Hisilicon SoC Hip04"
>  	depends on ARCH_HISI || COMPILE_TEST
> -	depends on HAS_DMA
>  	help
>  	  Enables support for NAND controller on Hisilicon SoC Hip04.
>  
> @@ -572,7 +569,6 @@ config MTD_NAND_QCOM
>  config MTD_NAND_MTK
>  	tristate "Support for NAND controller on MTK SoCs"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> -	depends on HAS_DMA
>  	help
>  	  Enables support for NAND controller on MTK SoCs.
>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index 89da88e591215db1..c493b8230a38c059 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -71,7 +71,7 @@ config SPI_FSL_QUADSPI
>  config SPI_HISI_SFC
>  	tristate "Hisilicon SPI-NOR Flash Controller(SFC)"
>  	depends on ARCH_HISI || COMPILE_TEST
> -	depends on HAS_IOMEM && HAS_DMA
> +	depends on HAS_IOMEM
>  	help
>  	  This enables support for hisilicon SPI-NOR flash controller.
>  



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

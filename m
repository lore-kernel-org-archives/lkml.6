Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2983821-1524417206-5-8340144205815941665
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524417205; b=msfc3oFeVpxc7Rtnnehz2I1oVPh6ttp/oxqtX77mzDaisFgPwC
    czHIIHYJwnIqJff1ZzH5MVPUIxqnsivYlicN5aMyfF84/TpwYpp7DWw9qiGVsRcS
    l355EhYl01F7oZ9eHaqJexcBmWNP4aUu+PW/fuVMVuSPdGb/sav+30GJbhmK6jjW
    jkGrIrlo3dTEu6YWkLM9IvbHJNrlysj2Y+ZFAfpD+AdsvhG3Qgc/7slYGSOku63/
    DAaSkAlwBb0E6TQuETKJhILrhyOfrxRBpCuY31o6N1zXQheLKECYR1+hPAe2jX4G
    ups+9adxs43GuQAQg4H3Dr2LZ40mOm8orqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524417205; bh=MgEN1
    5vCJ2PZbCe6mOCMsQ9EL85BJIoJv0/9SwLswSE=; b=wfHO1PbL7dP1qNILGSGJP
    B9sr6f6Ywde8Bw/cQkw7BpRcDVJm6/U+iZjWJkVfa0xQWmGPFQuryHRDRKN3GAm2
    YB/OSbe/zbqpSPihVQqBFVN19PVfP1GuEDi7UV+4bHeWORIewoJBokWvpcWrI47Q
    n6FemGHgfJtvQeW4XVQDKnEtmHv6dAJYcBzHQ/elL5GW12OIkeRCyqbDWzSMU64H
    eMa5ttw0MydZruWDiPVACvvaA2IYAwFNkAlbuW7cQGuSSIRlqI5N78EKDIM7ctc3
    0qA5DfJ2yUcgZkHlkzmD8Mlhaec0ikW6fp2AnNV1zaz81Vub2IB0yATFfR58YrYG
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOhJUp8ZT23UrDUx22wsOXFCg4zdSlm4B6rv8OXYJtYlncbpZFSyPShV+1Oapz5IHwE7RI0FEICV3j6dW//e/UQRim/ykHUpsj4CcxpUVbY9680b/XZS
    VJ15SkfR59CFBE4DAf5WsfEagz87YFaKt7MPiocxIG63Eu3I4Ika8W2V1follpnjII6a8Mp6zX0ONhzTE1Snl9sQopPeOqf785NpmrX0iUlK9qoYtQwxg5R5
    NYSRhZp/diDt7kmMtkJghg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=DDOyTI_5AAAA:8 a=1XBcy4zVM9dn8EyfbC8A:9 a=CjuIK1q_8ugA:10
    a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 22 Apr 2018 19:12:57 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 14/20] mtd: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180422191257.255bdd9f@bbrezillon>
In-Reply-To: <1523987360-18760-15-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
 <1523987360-18760-15-git-send-email-geert@linux-m68k.org>
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

On Tue, 17 Apr 2018 19:49:14 +0200
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
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Applied to mtd/next.

Thanks,

Boris

> ---
> v3:
>   - Rebase to v4.17-rc1,
> 
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Drop new dependency of MTD_NAND_MARVELL on HAS_DMA,
>   - Split per subsystem.
> ---
>  drivers/mtd/nand/raw/Kconfig | 8 ++------
>  drivers/mtd/spi-nor/Kconfig  | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 19a2b283fbbe627e..6871ff0fd300bb81 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -46,7 +46,7 @@ config MTD_NAND_DENALI
>  config MTD_NAND_DENALI_PCI
>          tristate "Support Denali NAND controller on Intel Moorestown"
>  	select MTD_NAND_DENALI
> -	depends on HAS_DMA && PCI
> +	depends on PCI
>          help
>            Enable the driver for NAND flash on Intel Moorestown, using the
>            Denali NAND controller core.
> @@ -152,7 +152,6 @@ config MTD_NAND_S3C2410_CLKSTOP
>  config MTD_NAND_TANGO
>  	tristate "NAND Flash support for Tango chips"
>  	depends on ARCH_TANGO || COMPILE_TEST
> -	depends on HAS_DMA
>  	help
>  	  Enables the NAND Flash controller on Tango chips.
>  
> @@ -285,7 +284,7 @@ config MTD_NAND_MARVELL
>  	tristate "NAND controller support on Marvell boards"
>  	depends on PXA3xx || ARCH_MMP || PLAT_ORION || ARCH_MVEBU || \
>  		   COMPILE_TEST
> -	depends on HAS_IOMEM && HAS_DMA
> +	depends on HAS_IOMEM
>  	help
>  	  This enables the NAND flash controller driver for Marvell boards,
>  	  including:
> @@ -447,7 +446,6 @@ config MTD_NAND_SH_FLCTL
>  	tristate "Support for NAND on Renesas SuperH FLCTL"
>  	depends on SUPERH || COMPILE_TEST
>  	depends on HAS_IOMEM
> -	depends on HAS_DMA
>  	help
>  	  Several Renesas SuperH CPU has FLCTL. This option enables support
>  	  for NAND Flash using FLCTL.
> @@ -515,7 +513,6 @@ config MTD_NAND_SUNXI
>  config MTD_NAND_HISI504
>  	tristate "Support for NAND controller on Hisilicon SoC Hip04"
>  	depends on ARCH_HISI || COMPILE_TEST
> -	depends on HAS_DMA
>  	help
>  	  Enables support for NAND controller on Hisilicon SoC Hip04.
>  
> @@ -529,7 +526,6 @@ config MTD_NAND_QCOM
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

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

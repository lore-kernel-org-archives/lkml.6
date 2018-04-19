Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524143876; cv=none;
        d=google.com; s=arc-20160816;
        b=lkTI3YEic6jjkQOGwTJH/HzwYbs5AAADgOCH3FSg2HPyPJAYTZDfuqpj5XMVUXVZfl
         DgThRaZc3IZPb65uzU3U9IwgTKSEFNElmu89jXJQXZ/LL8ltfFKHwVQDSLTJsLsFC8Qr
         gG+IOW0tk/mDLa7QlgZdcHA+Oi7ID4i/FlGq2eYzB4h8HSKve87zYFeIlGQXVMsOgDpQ
         X5At4YhxRsuAZNdTkmYMFdHSYAsV9vLa3nYq90dh1DUYXYRjheSxKln+0nGq4b833cZ1
         YWiYSZtdQ0tdI1+uTcFjv7CNp+QU+Dxs9Hzyc6Nl1Y1iE+3x8WW7KuREza+1Owsbv36H
         ueWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fMJXbMSF8FXUlRcxuTpqcmfOkG69CtcPtg3gBgqSI9s=;
        b=E57fs+HQcTzGn/UKiPRodRyEXSRnLPaexZeMuRMkmC7vN+SX+3p0r8ksO2qOXB14AY
         wEgXkdJTzmlRDEVhkgW/jO9qcDcNSm/NIcvQdEt5X7NYSVxFy4aYDOW+hBTMwiu6SFDa
         WESV8BH7FASSz31jB97VOeWOMYL1vMST7GKrbgDLzjfJ2BV+UDWbgJmdHj9xHYCQtzbp
         uE38rrmQ4CowCd8jDQNxTb6aqcVBAlujnMj813DLHuugZugbWsi44CqDCmoAtE+dDIcR
         lFb5Xz4/bYQ4pK9BXCiTMMdEgQ+/qVAjxVXC9hVJh9NjUWPOaN04DtcRGzhgyigJ5Vk+
         mgHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fMFvUwhX;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fMFvUwhX;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48bhzKa19ZkGBYznaUuj/B/lWqWWVeSqwS0KSUrU0cKWaldSWY3PCHW9H9eiz5cO1XFCKuUYbtfitiq8I2/OIY=
MIME-Version: 1.0
In-Reply-To: <1523987360-18760-14-git-send-email-geert@linux-m68k.org>
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org> <1523987360-18760-14-git-send-email-geert@linux-m68k.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Apr 2018 15:17:53 +0200
Message-ID: <CAPDyKFrDsqJ-URAi=b0JmRkqoAqgT01HDPpQtNkH5to_Enm+LA@mail.gmail.com>
Subject: Re: [PATCH v3 13/20] mmc: Remove depends on HAS_DMA in case of
 platform dependency
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>,
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org,
	Linux USB List <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux1394-devel@lists.sourceforge.net,
	linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-block <linux-block@vger.kernel.org>,
	linux-media@vger.kernel.org,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
	driverdevel <devel@driverdev.osuosl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598020894263137714?=
X-GMAIL-MSGID: =?utf-8?q?1598180689169212849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17 April 2018 at 19:49, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, applied for next!

Kind regrds
Uffe

> ---
> v3:
>   - Add Acked-by,
>   - Rebase to v4.17-rc1,
>
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/mmc/host/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9589f9c9046f14b1..3978d0418958bf6b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -358,7 +358,6 @@ config MMC_MESON_MX_SDIO
>         tristate "Amlogic Meson6/Meson8/Meson8b SD/MMC Host Controller support"
>         depends on ARCH_MESON || COMPILE_TEST
>         depends on COMMON_CLK
> -       depends on HAS_DMA
>         depends on OF
>         help
>           This selects support for the SD/MMC Host Controller on
> @@ -401,7 +400,6 @@ config MMC_OMAP
>
>  config MMC_OMAP_HS
>         tristate "TI OMAP High Speed Multimedia Card Interface support"
> -       depends on HAS_DMA
>         depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
>         help
>           This selects the TI OMAP High Speed Multimedia card Interface.
> @@ -511,7 +509,6 @@ config MMC_DAVINCI
>
>  config MMC_GOLDFISH
>         tristate "goldfish qemu Multimedia Card Interface support"
> -       depends on HAS_DMA
>         depends on GOLDFISH || COMPILE_TEST
>         help
>           This selects the Goldfish Multimedia card Interface emulation
> @@ -605,7 +602,7 @@ config MMC_SDHI
>
>  config MMC_SDHI_SYS_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
> -       depends on MMC_SDHI && HAS_DMA
> +       depends on MMC_SDHI
>         default MMC_SDHI if (SUPERH || ARM)
>         help
>           This provides DMA support for SDHI SD/SDIO controllers
> @@ -615,7 +612,7 @@ config MMC_SDHI_SYS_DMAC
>  config MMC_SDHI_INTERNAL_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
>         depends on ARM64 || COMPILE_TEST
> -       depends on MMC_SDHI && HAS_DMA
> +       depends on MMC_SDHI
>         default MMC_SDHI if ARM64
>         help
>           This provides DMA support for SDHI SD/SDIO controllers
> @@ -669,7 +666,6 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on HAS_DMA
>         depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
> @@ -748,7 +744,6 @@ config MMC_DW_ZX
>
>  config MMC_SH_MMCIF
>         tristate "SuperH Internal MMCIF support"
> -       depends on HAS_DMA
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         help
>           This selects the MMC Host Interface controller (MMCIF) found in various
> @@ -868,7 +863,6 @@ config MMC_TOSHIBA_PCI
>  config MMC_BCM2835
>         tristate "Broadcom BCM2835 SDHOST MMC Controller support"
>         depends on ARCH_BCM2835 || COMPILE_TEST
> -       depends on HAS_DMA
>         help
>           This selects the BCM2835 SDHOST MMC controller. If you have
>           a BCM2835 platform with SD or MMC devices, say Y or M here.
> --
> 2.7.4
>

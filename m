Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1601348-1521428937-5-10743993780137631717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521428936; b=uTLcg5GQdpLm8ic1rayZ/Tv8GTXSK8/E4FaFdgDUzKimpxF
    sZC0tnRUNMIixz7oExao7VUU7BfWmqHr4Ka85y9Is9NmG8hHvcYRGApM9PaCN1pj
    yZRkna0eL9qcNfLoojCFK/tGZrNZXYCvkkrhYZJxzHz2sp++ZAXHHL5Nyv9R9ZUt
    pOhHSPfy8eYqzC/gUuzsjR2HE/AiFzX4aZQ7/L3/eyix58OcI0Mgoeh7DzvCmj4w
    dFug36MuaZ69qVO9Iv8s+lIefASzzEOkho/ONCwWHB5E7P3oXQa47RIeEAHBfWKm
    h+g9vzCA2U8gQA5emV8AzRS3DmZYg20mzyjl0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521428936; bh=i
    N2tuOZP9SDLn2cN6mTzSwhRvdEGTi+6sQ8ieHcEW7A=; b=LX0eRtWfFP1p9o2JD
    EMJdfsH2Cfz++4C05MjfCFbUWehj3QB55xUkdDP6m7At2LABvhswzJgdVerVwRvg
    owgm+5m0gIFMY301nbiv89tFBvJxQaUhKeO1h5lyMX6Ilt/yHyUOTrFgwWMHr6V3
    WQEdTdMgh36+e8PNpebMYHmz97eKgnYp2rF7PBt7UzRHkPIv9w3ncMZq2ywAJGRu
    GeLV/jh2pIDwAjDcLA7+d4fTnt4+Aieq3O2Ui2RvhMzl9ihxRIwUaiAFNpx9zMow
    bd+znC60X3wlgWNAlUt0e3oqAXIDLlVBzrYzkr1Ad6rlw42fMFai65hL0s/js2L3
    3/mLg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=MLrta3Ud x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gBiN/UKf;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=MLrta3Ud x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gBiN/UKf;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt5NRTmpbT0RNJdyf9pP9qE6f/fNRFkABAV/NWSqHIwxcieWTMoCYmKepWol7+m54Fjf4Pnxi6PX7wvqSnqKyk=
MIME-Version: 1.0
In-Reply-To: <1521208314-4783-14-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-14-git-send-email-geert@linux-m68k.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 Mar 2018 04:08:43 +0100
Message-ID: <CAPDyKFpPEQJLOv+i8yBEPkAiPG9QhjGGvyYSawPxRVShayznvw@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] mmc: Remove depends on HAS_DMA in case of
 platform dependency
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-iio@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
 netdev@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-scsi <linux-scsi@vger.kernel.org>, Richard Weinberger <richard@nod.at>,
 Joerg Roedel <joro@8bytes.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>, linux-serial@vger.kernel.org,
 Matias Bjorling <mb@lightnvm.io>, David Woodhouse <dwmw2@infradead.org>,
 linux-media@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
 driverdevel <devel@driverdev.osuosl.org>, Alan Tull <atull@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Felipe Balbi <balbi@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
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

On 16 March 2018 at 14:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/mmc/host/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 620c2d90a646f387..f6d43348b4a3e5d4 100644
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
> @@ -688,7 +685,6 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on HAS_DMA
>         depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
> @@ -758,7 +754,6 @@ config MMC_DW_ZX
>
>  config MMC_SH_MMCIF
>         tristate "SuperH Internal MMCIF support"
> -       depends on HAS_DMA
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         help
>           This selects the MMC Host Interface controller (MMCIF) found in various
> @@ -878,7 +873,6 @@ config MMC_TOSHIBA_PCI
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
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AG47ELvvmOjqhh/DuhO6gbsK4zBAyaNykyhv7jAX8I97f31pZFjZiOpaTWnc9iEDqZbBQssmnJYN
ARC-Seal: i=1; a=rsa-sha256; t=1521475631; cv=none;
        d=google.com; s=arc-20160816;
        b=OnNcLWlSG8g3h17Tqovi0khUkVHqPKxBpF9Iq6jG2R4CKGonaKicv8Hu3fDltU0Itk
         VLUcJC5zUBGJB3loAwHJFq2z2FmWvzZGGECq/6Ww/Q4EyijwOtDuS0W1oF/1mC8EKS7Y
         vbVZ+9E8iAFMzYC3mtkyzWQ8Jq+0C0mflmlY1T6fmKBrkuDL2d4cpwh2s2ucK/NSTQKO
         WaW71SGVa7ncVhCavnOaAutn07srKpW19yU5GCVD67R0654NWhf9brkGzYBMdNysMHC6
         bW3fakSeds+XP1wyMA1ushFX0C9DoGpO5WqD4CfwQRpfZkpo0WL+19tr8p6J/E0bwUxf
         dO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=3AUUNjF6+iKGTL1TPgTKhsLwS4sIjyWBRVQp6IWuLrw=;
        b=ceSvQQBE7H0Ho0GC5C/3uZncD4YouTLMmntrla5nWzI1E0ms+n01v3NYVoFWwxpIF1
         FNNC5PEvNAdCbMyusCh7T45XaxglfQbG50Pb8ujzlDJVZ1ALA/0weEkdRqy97/jwVCRZ
         RP7BU17t2IRfgSc53YlnsYSTJtIoh3k/Rj7ifXcFD2Ds1NVz3BHtyLZGHbF+5jIdz/Df
         GxIcFVMKqNigDpIHy7PN6YfqUa/pa0WtuvJjkQEtfV6CMbKHlqVrfNQ+OGix4q8rl0UV
         MJKmfpLqE6XM129B0Y4urGOEovG9IjPsveq4t80oVnVcWzGAxv+r5zzg7h/HiWjtMIOX
         ar9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8CD2185F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <1521208314-4783-7-git-send-email-geert@linux-m68k.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org> <1521208314-4783-7-git-send-email-geert@linux-m68k.org>
From: Alan Tull <atull@kernel.org>
Date: Mon, 19 Mar 2018 11:06:29 -0500
X-Gmail-Original-Message-ID: <CANk1AXR3sv2=G-KsQh1p0rdcvy-3XZs6qVy5EMbcAMS6OSVzeQ@mail.gmail.com>
Message-ID: <CANk1AXR3sv2=G-KsQh1p0rdcvy-3XZs6qVy5EMbcAMS6OSVzeQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] fpga: Remove depends on HAS_DMA in case of
 platform dependency
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>, iommu@lists.linux-foundation.org,
	linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-ide@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-block@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102584190137224?=
X-GMAIL-MSGID: =?utf-8?q?1595382831804648683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 8:51 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

Hi Geert,

This essentially removes this commit

commit 1c8cb409491403036919dd1c6b45013dc8835a44
Author: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed Aug 3 13:45:46 2016 -0700

    drivers/fpga/Kconfig: fix build failure

    While building m32r allmodconfig the build is failing with the error:

      ERROR: "bad_dma_ops" [drivers/fpga/zynq-fpga.ko] undefined!

    Xilinx Zynq FPGA is using DMA but there was no dependency while
    building.

    Link: http://lkml.kernel.org/r/1464346526-13913-1-git-send-email-sudipm.mukherjee@gmail.com
    Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
    Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
    Cc: Alan Tull <atull@opensource.altera.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Alan

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
> ---
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/fpga/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index f47ef848bcd056d5..fd539132542e30ee 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -53,7 +53,6 @@ config FPGA_MGR_ALTERA_CVP
>  config FPGA_MGR_ZYNQ_FPGA
>         tristate "Xilinx Zynq FPGA"
>         depends on ARCH_ZYNQ || COMPILE_TEST
> -       depends on HAS_DMA
>         help
>           FPGA manager driver support for Xilinx Zynq FPGAs.
>
> --
> 2.7.4
>

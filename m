Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521412606; cv=none;
        d=google.com; s=arc-20160816;
        b=RYXkjbAsrdBsaxg/naAeBSeHw3VhmpY2sX7NQGFhwIv3Fm39dURD0zjV0DaPolVwmy
         YzQ6BIAnVFTCHZy2uvc7WxCAXv5TLVGtox9WLhRW6K/GOIsXWOgddUNLhWtngDW3/1k/
         lWiOhMUHDDC0vaoPgTHSPomJDD/EbCQfwNx4XfNuSOZvo9j81kr8fTpU5i1Z4qYeiNG1
         KExZvofxYUa5WHoAvBJyMd6+lOzuilcnPXhgrCv5cp+yiuuPK6LmjMc3aGpYY2+bR+MU
         NbXlSYIlBfYy2fuad0+CRrwh3tfFQ+pXcgWoS0P5WhpCWSPHBrFmcz4f7WCDkre17kn7
         UWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=qrUsdAF1qqMbAVG8Pz5YnP/lwig8hxqkqPl6PKFJquQ=;
        b=PkNyitIL3XwJr43BOxTyeNRNP6neWOHFQtnAcZTiGniuV461g6whG2UlUp0N4dpO/b
         8je5bxXibKsUaCN7dkHUzwG3I0ntFYpumUHK5cieLEtrubzW09OcTeQSEFQowbfANFVm
         p6KXwPv7tvc/C9STUXfY27HslJvoU/KDiCNTHLBkrIAZuiEFpDOBjAo8SVEPgT2cPY/q
         Bh15IHDsFVtFSLWaNUJBVRfQMWjqxpC3fFVyDB2qdymVaqgeff9VN5OT+l77m7c8no/S
         yWf1ONEE+n0OUgNd5Dqb1fm9zQio45kI4XWXjfezkq/FeC/+ci++uKEH8cdXbhVF5KAq
         3YCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=M3H4enqb;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=M3H4enqb;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsOLbRfOer7dJMmHePEUk8NNi4VSI0VL/8xpbhksg3lneTnKp8bEv5KRWUTn8nypcLkCTRoDg==
Date: Sun, 18 Mar 2018 15:36:37 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Matias Bjorling <mb@lightnvm.io>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Richard Weinberger <richard@nod.at>,
	Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen <ohad@wizery.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-block@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/21] remoteproc: Remove depends on HAS_DMA in case
 of platform dependency
Message-ID: <20180318223637.GA5626@tuxbook-pro>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-17-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521208314-4783-17-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595106223315235711?=
X-GMAIL-MSGID: =?utf-8?q?1595316745621795515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16 Mar 06:51 PDT 2018, Geert Uytterhoeven wrote:

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

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/remoteproc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index b609e1d3654ba65f..b60d8132113de0f7 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -23,7 +23,6 @@ config IMX_REMOTEPROC
>  
>  config OMAP_REMOTEPROC
>  	tristate "OMAP remoteproc support"
> -	depends on HAS_DMA
>  	depends on ARCH_OMAP4 || SOC_OMAP5
>  	depends on OMAP_IOMMU
>  	select MAILBOX
> -- 
> 2.7.4
> 

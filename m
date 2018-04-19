Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+EwTkfFCWzp10oiq4aLfy14RDtT8PnFt1BKNl9rO4ddkWxBiSPwV1sxKsgTSaMDB9w8nYe
ARC-Seal: i=1; a=rsa-sha256; t=1524156091; cv=none;
        d=google.com; s=arc-20160816;
        b=VUcT4W0MM+EuOqwU8T45JggFhynJPb1qTb7wIA2McOqeNKul7TBx1PJ+MtLaotWRfk
         5ws8SdQ8ZxXDmU7GYUTSPxlBRxCBCkwmJgCIMZ9Ob3o52Cj16zFnJl18M6mt7O+iWnea
         XarMUjk3RY7xC285Mrersuf0+TVvl1BxzGN32tDjQT3nACgKrN9buILnjBLp2i7ThfGx
         OBErdDyGoxMNwsJ5lqEuAevevq4h5pmmCOPBOJ0tjHSLm7PeT3f7Tj97uAqmOyDyNCC3
         Gdpx60i869ClYm2b/hTzbucd1PSCL86EMV8v1OUQuMVz6KsZKaEp2k+8yhnOHZNz6IUI
         mCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=J7VKwcGABHWf09oC+BdMd9Cjy5uwI6jp04BDhQHrg5Y=;
        b=MwLWoVya18+9WRQmhzffLIBlxnQEA2TMjCMJ26Jbp4sn7m2Eb2Jtym4mzIi8uB7RJe
         9GSaCxv3YnuyA20rcUhxnaPfSl2zf/yezEMBP1Rd7m1irk+l0BcI38QeGrh/jwM8dl/t
         vKwnGumBviVSIW3HNx6wA/+0COyoqbLr4cw61N+DkMPExctIAcrmyUNoPEOzHEuzIglX
         mxeq51IzaF0rVROixcrO8EOBNzDuaxgVtpYpYZzoV2Nd2FDk5m+2+WVoGXVBQ3m/1TRp
         H57WE9KURkSAmQpTSz+H/GRDf3BIvsGqMtBDPzEFZFo17ZtpchhLFc6h+/2S27p4Zm5y
         yWPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@codeaurora.org header.s=default header.b=IE39z9Lv;
       dkim=fail header.i=@codeaurora.org header.s=default header.b=i2Jp7iO1;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=fail header.i=@codeaurora.org header.s=default header.b=IE39z9Lv;
       dkim=fail header.i=@codeaurora.org header.s=default header.b=i2Jp7iO1;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34A1F60AE0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,  Marek Szyprowski <m.szyprowski@samsung.com>,  Robin Murphy <robin.murphy@arm.com>,  Felipe Balbi <balbi@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Andrew Morton <akpm@linux-foundation.org>,  Mark Brown <broonie@kernel.org>,  Liam Girdwood <lgirdwood@gmail.com>,  Tejun Heo <tj@kernel.org>,  Herbert Xu <herbert@gondor.apana.org.au>,  "David S . Miller" <davem@davemloft.net>,  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,  Stefan Richter <stefanr@s5r6.in-berlin.de>,  Alan Tull <atull@kernel.org>,  Moritz Fischer <mdf@kernel.org>,  Wolfram Sang <wsa@the-dreams.de>,  Jonathan Cameron <jic23@kernel.org>,  Joerg Roedel <joro@8bytes.org>,  Matias Bjorling <mb@lightnvm.io>,  Jassi Brar <jassisinghbrar@gmail.com>,  Mauro Carvalho Chehab <mchehab@kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>,  David Woodhouse <dwmw2@infradead.org>,  Brian Norris <computersforpeace@gmail.com>,  Marek Vasut <marek.vasut@gmail.com>,  Cyrille Pi
 tchen <cyrille.pitchen@wedev4u.fr>,  Boris Brezillon <boris.brezillon@free-electrons.com>,  Richard Weinberger <richard@nod.at>,  Ohad Ben-Cohen <ohad@wizery.com>,  Bjorn Andersson <bjorn.andersson@linaro.org>,  Eric Anholt <eric@anholt.net>,  Stefan Wahren <stefan.wahren@i2se.com>,  iommu@lists.linux-foundation.org,  linux-usb@vger.kernel.org,  alsa-devel@alsa-project.org,  linux-ide@vger.kernel.org,  linux-crypto@vger.kernel.org,  linux-fbdev@vger.kernel.org,  linux1394-devel@lists.sourceforge.net,  linux-fpga@vger.kernel.org,  linux-i2c@vger.kernel.org,  linux-iio@vger.kernel.org,  linux-block@vger.kernel.org,  linux-media@vger.kernel.org,  linux-mmc@vger.kernel.org,  linux-mtd@lists.infradead.org,  netdev@vger.kernel.org,  linux-remoteproc@vger.kernel.org,  linux-serial@vger.kernel.org,  linux-spi@vger.kernel.org,  devel@driverdev.osuosl.org,  linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 15/20] net: Remove depends on HAS_DMA in case of platform dependency
In-Reply-To: <1523987360-18760-16-git-send-email-geert@linux-m68k.org> (Geert
	Uytterhoeven's message of "Tue, 17 Apr 2018 19:49:15 +0200")
References: <1523987360-18760-1-git-send-email-geert@linux-m68k.org>
	<1523987360-18760-16-git-send-email-geert@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Date: Thu, 19 Apr 2018 19:41:15 +0300
Message-ID: <87wox3i1xw.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598016623350220186?=
X-GMAIL-MSGID: =?utf-8?q?1598193498204678407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(adding linux-wireless)

Geert Uytterhoeven <geert@linux-m68k.org> writes:

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
> v3:
>   - Rebase to v4.17-rc1,
>   - Drop obsolete note about FSL_FMAN,
>
> v2:
>   - Add Reviewed-by, Acked-by,
>   - Drop RFC state,
>   - Split per subsystem.
> ---
>  drivers/net/ethernet/amd/Kconfig                | 2 +-
>  drivers/net/ethernet/apm/xgene-v2/Kconfig       | 1 -
>  drivers/net/ethernet/apm/xgene/Kconfig          | 1 -
>  drivers/net/ethernet/arc/Kconfig                | 6 ++++--
>  drivers/net/ethernet/broadcom/Kconfig           | 2 --
>  drivers/net/ethernet/calxeda/Kconfig            | 2 +-
>  drivers/net/ethernet/hisilicon/Kconfig          | 2 +-
>  drivers/net/ethernet/marvell/Kconfig            | 8 +++-----
>  drivers/net/ethernet/mellanox/mlxsw/Kconfig     | 2 +-
>  drivers/net/ethernet/renesas/Kconfig            | 2 --
>  drivers/net/wireless/broadcom/brcm80211/Kconfig | 1 -
>  drivers/net/wireless/quantenna/qtnfmac/Kconfig  | 2 +-
>  12 files changed, 12 insertions(+), 19 deletions(-)

For wireless:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

Leaving the hunks for linux-wireless list to see:

> diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
> index 9d99eb42d9176f0f..6acba67bca07abd7 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
> +++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
> @@ -60,7 +60,6 @@ config BRCMFMAC_PCIE
>  	bool "PCIE bus interface support for FullMAC driver"
>  	depends on BRCMFMAC
>  	depends on PCI
> -	depends on HAS_DMA
>  	select BRCMFMAC_PROTO_MSGBUF
>  	select FW_LOADER
>  	---help---
> diff --git a/drivers/net/wireless/quantenna/qtnfmac/Kconfig b/drivers/net/wireless/quantenna/qtnfmac/Kconfig
> index 025fa6018550895a..8d1492a90bd135c0 100644
> --- a/drivers/net/wireless/quantenna/qtnfmac/Kconfig
> +++ b/drivers/net/wireless/quantenna/qtnfmac/Kconfig
> @@ -7,7 +7,7 @@ config QTNFMAC
>  config QTNFMAC_PEARL_PCIE
>  	tristate "Quantenna QSR10g PCIe support"
>  	default n
> -	depends on HAS_DMA && PCI && CFG80211
> +	depends on PCI && CFG80211
>  	select QTNFMAC
>  	select FW_LOADER
>  	select CRC32

-- 
Kalle Valo

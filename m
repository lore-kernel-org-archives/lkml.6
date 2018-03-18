Return-Path: <mb@lightnvm.io>
ARC-Seal: i=1; a=rsa-sha256; t=1521398775; cv=none;
        d=google.com; s=arc-20160816;
        b=WwFZ1HRJbzM0sIpn8I+OFxZcu9+Ohf0V2M/Lyju+DKJnkzykA40r9eSgO5GcB257/8
         Tz2IDUBB1fCHNoeRcdHK/snlNeAAN2fq/WtO+AX3LcyImLML6wqrjfXOGMDck53wsUs6
         z6Q6lGcVwiMPWGHLYXrQLKtpJw3ryO3kNNMJNtKDNMRdvLoTdSulzWRPIoaq2Sg31OLG
         jlq2J5xDUOWpxCJjtIctw/wUEO4IqMTIIHyFbKm3K+D1Iwzp9MjuH47sv10dLfzNussF
         hceSdePQXeyBw7pd0612LLgPTQdMabP8+ecG2eDaYbA9aisPU3bXuVvEciJDF4C/dZFo
         ckZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Og7X/rl3kDVLhesEnkKjOJ+h6/NpuyIJgWyttam9V0g=;
        b=TfRD2RgIuiZFzMshQ13VDI4vC4epqoeLjANXU1BR7sH64lxZRYphH2eMgpqUrOtxQc
         BCMipezcBRl61j6IqUHGOy1b6AWTvCgOhVZAcRHmJY6YnffzT/ygef3EcfRuCQzhDOkX
         W5yn4Qenuu5MFXg+ns0fV0ESevrEUBqeL1UbVZDfFjmVmt3UsLmp9Hs87FeTdV1BSU3a
         5OACkThIANJnrGGR9CYzC4Fur3DQnXCIR37YWaLCanuXNP6wxEL42cjFIqRnyWhLP0ac
         10vbffqWLVBpGee/DzmVcjJXQ7NpTAz04dbLqNrqFpmuUwElenYt9Vk7/jE+mMSqtCcn
         illA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lightnvm-io.20150623.gappssmtp.com header.s=20150623 header.b=fzGsJ6U3;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of mb@lightnvm.io) smtp.mailfrom=mb@lightnvm.io
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lightnvm-io.20150623.gappssmtp.com header.s=20150623 header.b=fzGsJ6U3;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of mb@lightnvm.io) smtp.mailfrom=mb@lightnvm.io
X-Google-Smtp-Source: AG47ELtfF1xm8yigRkERzWAMGSfLD7LsbU/8oVlsH3mlWI31Lg5NKUowAlyOblVa2GzgGmqP0ZkvcQ==
Subject: Re: [PATCH v2 10/21] lightnvm: Remove depends on HAS_DMA in case of
 platform dependency
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Tejun Heo <tj@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
 Jonathan Cameron <jic23@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
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
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-11-git-send-email-geert@linux-m68k.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <319a2b17-f08e-7219-cf5d-08e2df81d55c@lightnvm.io>
Date: Sun, 18 Mar 2018 19:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1521208314-4783-11-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595106489861540942?=
X-GMAIL-MSGID: =?utf-8?q?1595302242311149538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 02:51 PM, Geert Uytterhoeven wrote:
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
> Notes:
>    - FSL_FMAN keeps its dependency on HAS_DMA, as it calls set_dma_ops(),
>      which does not exist if HAS_DMA=n (Do we need a dummy? The use of
>      set_dma_ops() in this driver is questionable),
>    - SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_PLATFORM loose their
>      dependency on HAS_DMA, as they are selected from
>      SND_SOC_APQ8016_SBC.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2:
>    - Add Reviewed-by, Acked-by,
>    - Drop RFC state,
>    - Split per subsystem.
> ---
>   drivers/lightnvm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index 10c08982185a572f..9c03f35d9df113c6 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,7 +4,7 @@
>   
>   menuconfig NVM
>   	bool "Open-Channel SSD target support"
> -	depends on BLOCK && HAS_DMA && PCI
> +	depends on BLOCK && PCI
>   	select BLK_DEV_NVME
>   	help
>   	  Say Y here to get to enable Open-channel SSDs.
> 

Looks good.

Reviewed-by: Matias Bjørling <mb@lightnvm.io>

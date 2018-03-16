Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuIJQdgLby7UXlscGs46OgVc7sOtWk68iuLFFxY1otrhhdiQmhyO/TsGBB38alN3JjpHG7W
ARC-Seal: i=1; a=rsa-sha256; t=1521211878; cv=none;
        d=google.com; s=arc-20160816;
        b=If5ttHTuoz9xiGpqWaiZij4uxmtyFHCHy6fp6US/sV9hbjaKeGyr4EQpuQF9eVdR21
         u5VvDZOvy1R5MvXvnfA+jbhLNlrIH0joE3ozEkgQR+yZJFaGbzQlr/t7XW6IWlWmIU4y
         CJXYTO5f8zH1Xp/4U+QITkUMxZYjKyUDriQ2cBlJcPLVbDvKbepqUl3EQrmAuFCiOytu
         3B58CAzoohIR02+SRvzvUL3y0wcNiyW2emepplAPiLsM75lncvZ6y19gFO5PP1MZG6rt
         m29+mNM2vp7MiIGOXZXOrvv+5tG3z5s5XzjFEzIPqIPa26U8BEdSYg5mciAXu5MQ8iq9
         /reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=O2m/KnDvvzi6hfU3Rh9fZRC3pcjapNrM5qfUZi00Mwo=;
        b=P0fv+P5WJy0fva2jsnEYyTCT/Pe6s4fCVSqschXOrvbUnm7r4+bcdRD+DfjmcHrLB0
         5Kr0rTLpCQF45330Au3YzUPZ3YiKyb/cHGNqJpBhXmy/hP2f7vWZTPMuIJMH74TWCBvR
         ClJWlXlsuxi5aEbOvE1zWlbrcH+0OO/9jRv9lQn5E+VqEo4syfustA2vJxfmpPoDxmOM
         +9PXKzzcu2Z1NjZJ7NvLnB8eezDQOUfpS292wecdjgxOKrSMu/+jPe+BKixyKfCca3Ou
         PFKADCm54WObV9x5BOHoPoECw+EsasH1h9QS6bPvQ6Q7jd+lKyxkmgKCYh+ZIh/RINoJ
         nlnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OdojO69X;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OdojO69X;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Fri, 16 Mar 2018 15:51:16 +0100
From: Joerg Roedel <joro@8bytes.org>
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
	Jonathan Cameron <jic23@kernel.org>,
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
	Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: Re: [PATCH v2 09/21] iommu: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180316145116.GE11365@8bytes.org>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-10-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521208314-4783-10-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595104321000579025?=
X-GMAIL-MSGID: =?utf-8?q?1595106266719614971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:51:42PM +0100, Geert Uytterhoeven wrote:
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

Acked-by: Joerg Roedel <jroedel@suse.de>

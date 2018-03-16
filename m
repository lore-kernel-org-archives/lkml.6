Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AG47ELsI/7CyZpV+M3sHGn9lOL4tuXlogWb1RAkgvShb/B/HA3PPCRIfVZYErBaBBcukOoTizkO3
ARC-Seal: i=1; a=rsa-sha256; t=1521215583; cv=none;
        d=google.com; s=arc-20160816;
        b=P1qIJ9YT7cB3JBFJ9GZxAAgex7k6yN73zSIQ/g9L7AAKJregrRLoyF1QqSrEAQ/lQF
         Ke/eRyqL2EKqXOZRlyyKealV8GkHhXnZmgRZifQ/khSNG1GNEvvpVpz2t5CR1/RM30cn
         zgykT1FH8ibXOK1uWe3QZSNpItjhKxYUfoVIDEEzQh7W6Du1TZh3Ec6/iZ7TDSHBAb5E
         mR1+gnVaS/NioiUkLDbIfteiaW0aasjrvti1zi9RqFZV6ZPJd4IJoSX/EbqP7+0j2w8C
         ETj8WnijgpCG11I3aFFPL411Our1x4PuTAgCjT7ao8wTglOyEOKpKOGAWKTNfBLUZxiL
         G7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=e/hWHKZXnKH+nmtWDtYufYh9O+avyJ8a3jvhFwXNd7I=;
        b=ZKaTzCK+9hpHTgN9CJhltwzmsIkycVJYQamxV/BUfUgggfmSIVLxy2l0FkZ2ZfUgqq
         Z03otfS0cr1YaPuxRZGpgIMNv3Bz/p3J/ez674qVkVtMorOPmEBPA65Gx3Jo14thpqjr
         nIPyu8MqiO8ScTn3j19L+0TZPXBaTWR1hCIajgcoIww74Z34TBTkP0CctQ57UvhkJBzx
         B1LMFALLqYX44wvtoqO9Z86TK7dNHEEgg293p3kf0hFIP+SEfYqLiG2n6ww3/Oq8BAYa
         NMzB4CsoHyYTeLD91xW2lhShRqcv+3ivUMtGcuhWdCc0yAzxDH34soQzPLw1eKqT0KQT
         xgSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Fri, 16 Mar 2018 23:52:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
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
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	iommu@lists.linux-foundation.org,
	USB list <linux-usb@vger.kernel.org>,
	scsi <linux-scsi@vger.kernel.org>,
	ALSA Development Mailing List <alsa-devel@alsa-project.org>,
	linux-ide@vger.kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-fpga@vger.kernel.org,
	Linux I2C <linux-i2c@vger.kernel.org>, linux-iio@vger.kernel.org,
	linux-block@vger.kernel.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Linux MMC List <linux-mmc@vger.kernel.org>,
	MTD Maling List <linux-mtd@lists.infradead.org>,
	netdev <netdev@vger.kernel.org>, linux-remoteproc@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
	driverdevel <devel@driverdev.osuosl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
Message-ID: <20180316155250.GA7095@gondor.apana.org.au>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <20180316151410.GA6527@gondor.apana.org.au>
 <CAMuHMdUKULvoB6-6EhsYpdbWEEEfjtn27GbzpXj7+Mz+=qeOnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUKULvoB6-6EhsYpdbWEEEfjtn27GbzpXj7+Mz+=qeOnw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595106436515547078?=
X-GMAIL-MSGID: =?utf-8?q?1595110151404647268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 04:41:57PM +0100, Geert Uytterhoeven wrote:
>
> | To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
> | this (drivers) series should be applied after the previous (core)
> | series (but not many people may notice/care ;-)

Oops, didn't notice it :)

> Apart from introducing build failures in allmodconfig/allyesconfig builds on
> (uncommon) NO_DMA=y platforms, they can be applied directly and individually.

I think I'll leave this with you then.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

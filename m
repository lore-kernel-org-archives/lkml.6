Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AG47ELvxGHl4f9wyCVz8bTPsXzbQ8f9L2vHaBZUT4IibGzct2+aQU+/wM+FudDujao3mU0ORYgtG
ARC-Seal: i=1; a=rsa-sha256; t=1521213296; cv=none;
        d=google.com; s=arc-20160816;
        b=akHNkSW4yL6LStHNNXjKAoxo7upB97NDhFu/6izjADrttc8+H7ZKCdKoAXB90DaEBH
         7ppQMzWUcZaRfptfWGJ8OIWtGVul769NhOKx0ZlR9rPSRyWf3qIaE6TnX88Jitb0f6+O
         sGVkni5W2/RxU9zt/VpZHaoKL/2hDC36Af/BZIr4fKh9jgmqVLpM7VEEU8plJHWCroTU
         hAR+e7NbImfpWEbAE03UgImFAtUx2kwfG5Oq3JsooXTK+3qgYcedvP7JQuT/2vGrHQZz
         ZzTLw15A+8vlI6VpqtRlI9S3EGN6VANvd4/mYT+e3mIdzCVvAgHo7Sml5pGH3YQKS6ne
         w15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1wslwsg9BouJTGRZMMUJUvBsY+5NuyqFRwWZiJ4cOpg=;
        b=fVwiFDSYSKEpIwkbv/rBsOjg0edugD7hW7JYwVcFtrxULa7wbK9Ty8DkHE6zagTqVI
         n3KCDOm3kHu3etTgSfflLc0yLmGLN0MJrJUxtHhsbpIp1Junvo9hjMTuF0o1jbfurAf+
         Nw/+ckjm+nqAnsXddqxXkFZG6D36u2a/mrreYkdS73tAzWI0Q67v+l5g+0Tb2AERHUN5
         tPObpMW9DLbwVOIo5+pyNGNr4xV0J4XTUrgdoqklSew/ffgL4wi9wemRwyxipv4INZbK
         0Lurrh301APe8RF68zpIa/kCAnkfX7j5OycAshxwAtCr9Qma4616g9rUta0QEWPViYe8
         QfMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Fri, 16 Mar 2018 23:14:10 +0800
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
Subject: Re: [PATCH v2 00/21] Allow compile-testing NO_DMA (drivers)
Message-ID: <20180316151410.GA6527@gondor.apana.org.au>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595106436515547078?=
X-GMAIL-MSGID: =?utf-8?q?1595107754123922170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:51:33PM +0100, Geert Uytterhoeven wrote:
>
> This patch series:
>   - Removes dependencies on HAS_DMA for symbols that already have
>     platform dependencies implying HAS_DMA.
> 
> To avoid allmodconfig/allyesconfig regressions on NO_DMA=y platforms,
> this (drivers) series should be applied after the previous (core)
> series (but not many people may notice/care ;-)
> 
> Changes compared to v1:
>   - Add Reviewed-by, Acked-by,
>   - Drop dependency of SND_SOC_LPASS_IPQ806X on HAS_DMA,
>   - Drop dependency of VIDEOBUF{,2}_DMA_{CONTIG,SG} on HAS_DMA,
>   - Drop new dependencies of VIDEO_IPU3_CIO2, DVB_C8SECTPFE, and
>     MTD_NAND_MARVELL on HAS_DMA,
>   - Split in per-subsystem patches,
>   - Split-off the core part in a separate series.
> 
> This series is against v4.16-rc5. It can also be found at
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=no-dma-compile-testing-v2
> 
> It has been compile-tested with allmodconfig and allyesconfig for
> m68k/sun3, and has received attention from the kbuild test robot.

Do these patches have any dependencies? Can they be applied directly
in a subsystem tree?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

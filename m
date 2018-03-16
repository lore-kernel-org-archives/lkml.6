Return-Path: <herbert@gondor.apana.org.au>
X-Google-Smtp-Source: AG47ELtAePsx1+aGmI5uYRnwtJtxtQchSXky6onR+fozuTtcyFx1Y60L5aM1HVezgX9ICXKjI93I
ARC-Seal: i=1; a=rsa-sha256; t=1521215558; cv=none;
        d=google.com; s=arc-20160816;
        b=SzniEtN9P9pp5oCMcE60HLKwJjWZNW101wZCALxgv/0ROf3JR/+Z9bdzE7gLOrKbMy
         B2E/lEApVQkahXZQL7BAaUVrqScgqc9d64ki3KFTN2f9rkam5qMfbhulLE3R+9SPz8cr
         BzY1jjbkERSpIjzHpPGpAPyZZOUlB1vo7RQpUxHC5yjTj5O9wgIzhrRdI6PkngoRjLus
         xxxHAs1Dt33icArMLy4QbBgfqvzWpjOdt5gFcWj+xIRzFOAlROHjiucD9GEUyyIbeKCh
         /iMVDZjPLJslZ6MgsjOy7cINYQ+FcjbHVqEy1BUoaNvd8dps+Cww1nQsXsIIE61Whs1k
         3s7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2TnOLhsQusnixcob6Lj/jnQdM0tRx0HyQ9TFlFRhkFs=;
        b=cFDPhqqhfjfzcS/ZuMHrbv+IYfnIOz29MdJfvjzvYj6sCjtMnB3gU5V+c2fG8lBudy
         ZVZ8n6ZJbIwm2BRhCoE8eGsSa8HRDXM38zsqWK+gaeVF+DcQQIFz7Z4+JnH2We+Luxb1
         wsihj5nNAFCGg55dHTtzA04RWWSJKr/3r5avG91SduG1yccbjzFdExJ4I4HNV2mkw/Rs
         9GrAT1G+thWHpb3tvjjKEhbGH1pDl8jdWDNn+uF4AkTgXQAgigYlJ4hJK6Wo7Lmm5DHN
         wGQpGJg0gSlpDgDq0G3eZS49nM+osfgE1jl6sMkFJY8V888bFgfHHbfdQjFHTKISL9yM
         c6qQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of herbert@gondor.apana.org.au designates 104.223.48.154 as permitted sender) smtp.mailfrom=herbert@gondor.apana.org.au
Date: Fri, 16 Mar 2018 23:52:14 +0800
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
Subject: Re: [PATCH v2 03/21] crypto: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180316155214.GA7250@gondor.apana.org.au>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-4-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521208314-4783-4-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595106383003521178?=
X-GMAIL-MSGID: =?utf-8?q?1595110125748283842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:51:36PM +0100, Geert Uytterhoeven wrote:
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

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

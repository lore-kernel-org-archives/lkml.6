Return-Path: <b.zolnierkie@samsung.com>
X-Google-Smtp-Source: AG47ELuk80frUtxgAtsefjmHlbOoR5CVgAFX8PlvEp5wvEtPxAvRxWtGJYD4dlDt6E/6lVqVSeRW
ARC-Seal: i=1; a=rsa-sha256; t=1521216079; cv=none;
        d=google.com; s=arc-20160816;
        b=UPjghJTv+RZoydbQrGpPqVUhMX4BHzpxyeG/A0ntMY+F9qlZFoh5JYOufx6LI7P0eq
         dX0WKb827ESYBuZ6Wb2yoYuQzKAX52lyITQEApMMcie4qfAI1CutEWHO9kWXSihxQNKn
         hAug5JaIDfXoGueaaxP3zIBTFXB2Whjmyg2By0pFE1D94hma2jLUFz4vkfAS/HapUYEL
         lA6CiyWgaQaL2L9cQlWh8pbshtXwWQkjW3Zoobl9zwniuvUSJJwQyOLdx2aEiePEfmrh
         Hu3QPdgsXSc4NQWStwo9xYICWk7yvcfrdvNvQlbyWK1UtGmCeqbnxwLn981q9ukYbAbR
         UE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:mime-version
         :in-reply-to:user-agent:message-id:date:subject:cc:to:from
         :sun-java-system-smtp-warning:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=A5Rp2I1Tu8Jrvzs0cXy95riRfKeVeXDS8YfGfl7mrNA=;
        b=fgL8hf4HxeGHnIQ1nrf7KHrOkoLvpd/yXI8WvYiFQCK9VH7xoFbZokiF/QdNJkvGbJ
         Axbq3w3Wi5vp/5ezK4ScAFY0T5yik9F7bI9FnQ2eo2MKpYvhZaabM9eaXBfTCHLUIig1
         aZFQ/KUpMmDTWJfAWqisZ3Nz1jg82TSmSf6toY6XCTEw1XC/h2MIaK7YWLq6zs5+8SxK
         cTUTqsdUGl95gAPFc06mMo/SACoxt/LsWm1YWXrB64X2+mLUxmUiiF749rCtefIWQEhE
         vbE/oSnQA31nhP9p47Wj0sfFxtBOND2wpZhuB9Muhv+TmCWLV/UIAibQ7RK5vRjmcTX0
         dE9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=tvIoJEDx;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=tvIoJEDx;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180316160116epoutp047f3d4379bd1385f98fd1261a4d378142~ccfZSoHv90223402234epoutp04G
X-AuditID: b6c32a38-adbff70000001054-b7-5aabea4cf34d
Sun-Java-System-SMTP-Warning: Lines longer than SMTP allows found and
	wrapped.
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Felipe
	Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tejun
	Heo <tj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S .
 Miller" <davem@davemloft.net>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Wolfram Sang
	<wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Matias Bjorling <mb@lightnvm.io>, Jassi Brar
	<jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf
	Hansson <ulf.hansson@linaro.org>, David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>, Marek Vasut
	<marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Boris
	Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger
	<richard@nod.at>, Kalle Valo <kvalo@codeaurora.org>, Ohad Ben-Cohen
	<ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Anholt
	<eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
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
Subject: Re: [PATCH v2 04/21] fbdev: Remove depends on HAS_DMA in case of
 platform dependency
Date: Fri, 16 Mar 2018 17:01:13 +0100
Message-id: <1863306.fWLBGQtWhd@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1521208314-4783-5-git-send-email-geert@linux-m68k.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxjHc+69vbd067grzp2oGaaLLoI6THB7gpuKI/PGuKX6ZQvZwrpx
	QceLpBUmfCplQBFlMnQgqwxkqX1DSAesYC0IpTCEIYOCdooOq1sIL84hUBQ32ssSvv2e5/zO
	c/7nJEdMyozMOvHR9OO8Kl2ZKqclVHPnlqhtBycs8VH5LeGgr7fSMDzYQYDXOMKAu8DHwPW2
	aQra/6qh4NwfPhpcN+pI6NTMkKAf+JoCR98iA6WmMhLac4cQPPReJSCvtp4Gk6WLgOKJDVDd
	tgtGjBcYMJemwz2tmYCi7xsYuGiqoWFuWEfAVW8k3B3zE9BT8kgE4+fnGdAtzSJw28cJqHIt
	nz7UqqfhVEOTCFz/foPgitbAQN6AHIpH7TT01Z5mIPfvW8sjDfkkPP6xiYI61x0GuhxjJFzq
	fk6A8WcXBQbbMwJ+yN0P7uq18NSyQEJZyySCa498IrAZb9IwO9xLwOKlLgTddR+BqaeS3Auc
	71oVwTX8o6U57Yyb5qxVVsQNlZwmuEbTLYIbc3ZSnM82iLiWyjsM19y+iWvy7uR+MkZwNnMR
	zRV7FhB3e8RBcz0VTylFeLzknUQ+9WgWr3pz92eSIxrPFJXhp0+4NA6kQQ9FJ1GIGLPR+PaD
	KXQSScQy1o5wYesvlFDMI/z71P1lSxy0/MUhQv8KwuWPLaRQPFmW+p/TgVFhrAJ/e8OAAkyz
	Mbi00IwCm9ew27DeTwR8kh0NxXM3K1b8BFztuU8FmGI34YppExFgKbsF5477g/FeYQ/gRmdh
	sB/CxmG31YIE52W8UDYW3Euy4djZdk4k8Fbc776MhKt5Q/Bi+W6B47BB10kKHIYnuhsZ4WLr
	8W9d7wayYTYP4Tm7Y8U5g7CjXibwLtzZPbgy/yU8/eTUyqNIsa5gReHwzLCTFjgWT3v+pIX3
	GUS4zeRizqDXKlfFrlwVu3JV7GpEmtFaPkOdlsyrd2REb1cr09SZ6cnbvziWZkPB/xMBduT4
	9WAHYsVI/qL0Xr8lXiZSZqmz0zoQFpPyNVKDb7klTVRm5/CqYwmqzFRe3YHWiyn5q1KFIi5e
	xiYrj/MpPJ/Bq/5fJcQh6zToUH4KOeqNef1DnUT8VtyFaMt3irNfNm9VLhWGDdzNCa3NThmd
	TNjjSXK0luxM3Pjx5Rc2axqtsZGx++SHLzLzoc8+yZrMP6xflNXE9tbt27Cn2Xii/G0P916P
	Pmn/AHOgN5ywRV3f+yDGlBnh7Mv5dGlj0udnv6p531FQVhT5xuwHWrucUh9R7oggVWrlf6kb
	czA7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG/b5zes4BqRzRyTfUkNTgpd5wmfGdU7cZnSfGGDUmRhKHzThD
	Iy1ND+LYX23RqXQwGaLYVQTB2gsEUoXBhlxLYeImyG3ibAU6Z4wDdF6oeAMaE/573vf9Pc/z
	z8tREUYmijuoSRF1GlWSggml294M8su3PXTGxeb6WLCUlTDQ1dGIoc/Ww4Lnez8LbXVDNNQ/
	KKQht9/PgLu9lIIm/TAFlptHaai58ZKFbHsOBfWGTgT3+65hSC8qY8DubMZgejgPCuo+hR7b
	eRYc2Rq4Z3RgOPlzOQsX7YUMPO86geFa31LweQMYWrNGZDBw7gULJ14/ReCpGsCQ7x5v7/zV
	wsAP5RUycL/9EcFvRisL6TcVYOqtYuBGUSYLhse3xyOtxyh4UlxBQ6n7LgvNNV4KLre8wWD7
	xU2D1fUKwwXDFvAUzIEx5ygFOdWPEDSM+GXgsv3FwNOu6xheXm5G0FK6B+ytZupzEPwN+Vgo
	/9/ICMZhDyOU5JcgoTMrEwtX7bex4K1togW/qwMJ1ea7rFBZHyNU9K0WrtiUgstxkhFM3aNI
	+LunhhFa88boHdFxoesSxKSDqaJu5Yb9oQf03f/R2gDzrVtfg/ToviwDcRzhPyYBU0gGCuUi
	+GpE/GPP2ODwDJGjf5yhMlAIN4vfToyWnyY1w68l2ccdaMI8m19OLAE8wVO8L5y8cnhlQT6e
	FHQP0hOa5mNI3pAdT2g5v4QYBgKTzAf8VnK19vjkPoTfRDwlThQs7kBkKOMBChpmktEc72QQ
	xUeT2rpcWVArSVl1Cz6FePMUzDwFM0/BChDlQB+KWkmdqJY+0q7SiEdWSCq1dFiTuOLrZLUL
	jX9mZZMyqwr5iuMbEc8hRZgc2p1xETJVqpSmbkSEoxSz5Vb/+EqeoEr7TtQlx+sOJ4lSI5rL
	0YpI+R2NZ28En6hKEQ+JolbUvb9iLiRKj5a5AlZ5vebL+eyFMXmkqW54UdgnzrzB6G8WpS1s
	jqwKt05bRlObZy2OHd3am5qZZj/bP+L8V9lP75JkIzFbopK1ho1fzFhw59Kaz2I7E+OPTbev
	P7ImYemtwL6F4W3/+Pxe3+6v5uxLT+i9tbZ9p7StQaq8vj+scN2fpzelbGz6XbubKGjpgGqV
	ktJJqneLmxfQlQMAAA==
X-CMS-MailID: 20180316160116epcas1p45c86ecb0054839c3defa2ac4b2646bf7
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180316152138epcas1p3e0e107cd14fd6fb4aeb595e0e7661ab7
X-RootMTR: 20180316152138epcas1p3e0e107cd14fd6fb4aeb595e0e7661ab7
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
	<CGME20180316152138epcas1p3e0e107cd14fd6fb4aeb595e0e7661ab7@epcas1p3.samsung.com>
	<1521208314-4783-5-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595108171076271857?=
X-GMAIL-MSGID: =?utf-8?q?1595110671792793727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, March 16, 2018 02:51:37 PM Geert Uytterhoeven wrote:
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

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

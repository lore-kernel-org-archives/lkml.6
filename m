Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AG47ELvkUPS6emJ0z+8aOiI1F7SlgJxMMjqyHBtBCXrMuIOaI57zy9ifP5NwaEnS81NewwquRIT8
ARC-Seal: i=1; a=rsa-sha256; t=1521420892; cv=none;
        d=google.com; s=arc-20160816;
        b=ksPk6wcmiUzjGnaNs3hWBWUU4eXBO/j9FrWCtTXDYPmqcLJIGGxL6FXepHUqzOy/3q
         A6JxYgQkGFXnbun1iuJet39wqHyQtMr2Fl+g5/vdGY5WCBqc4BPJjfLh16+ko3+wPViM
         Zv3FM5dh6UvDR5VhUwVbR4g/xrhfmaHu/poFEeArWkwexsjFlzDHNNZqFZxThuqMvoBU
         I+fvKPt4vWnAtlPGivHmldNUlVRF7JXi9XjIwHACBIZhxuD/RWvYt9B2meNsPPoxGplA
         HbMd+z8YUZftDPyqbRf8epoRpMUPQfKFjWNu1k/g6mU3ROcx4KN7/UEVFHVaosTVZpzi
         aeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=4nFNIJM7kZ6j3/DvOUV1gS3cWAtbF6PA0LZE/gZv0N0=;
        b=SWVAJZjjkLX5dY6JZ7ADNdy/UU44dmAN+Z1uRt1aVRl7CPscOATnnp7T2dKLr9uPu0
         rhWdE5Av1t6v3C/9Q6WqhIO8pj1JNZv/sbAlenqzGYuaIB5/FoGF9k0c62fOJnwD3nbd
         AGMRj7i4OUzm0r9Ei5DtMl7yhSKGLFmcSgmAPkwTPFcdY+JVNDg7Z7CHsLx9RB6N0GOK
         t+KoG1Tu63VMYdgBJc3pzmeVbOfeD+LIZFWb+Pe74P5s0bEnTkcynofWlc9My8V1IyU7
         MNsQ0KDXevAwrOFIHTAOPqLW8OCdEKlsBM3GVZ/0GJMJnHnmh7kOqWasb7HUE3Q1sdtP
         xgug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Ml8LJVnU;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 172.104.155.198 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Ml8LJVnU;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 172.104.155.198 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Sun, 18 Mar 2018 17:54:34 -0700
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v2 19/21] spi: Remove depends on HAS_DMA in case of
 platform dependency
Message-ID: <20180319005434.GZ2186@sirena.org.uk>
References: <1521208314-4783-1-git-send-email-geert@linux-m68k.org>
 <1521208314-4783-20-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rYRijwbmzeJBcrGE"
Content-Disposition: inline
In-Reply-To: <1521208314-4783-20-git-send-email-geert@linux-m68k.org>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102591524978255?=
X-GMAIL-MSGID: =?utf-8?q?1595325434255275556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--rYRijwbmzeJBcrGE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2018 at 02:51:52PM +0100, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.

Acked-by: Mark Brown <broonie@kernel.org>

--rYRijwbmzeJBcrGE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqvCkoACgkQJNaLcl1U
h9BMigf9GUiHnb+8UvcX70O+PBqRtvv8ENPWuJqF1yPy6LrCjn3P3iOQCW8q7Xa1
d06amrO7NytpkLP5/ubGHCmQ+IeET/5pneEyPrRxwwT0mjGNnxfjw4g8JUMHM5Lr
kfeBhpFWCkvffVxFQdE89iCYTYvScqDzXqe3rPepUE2o635Ptf7AdhUAYtqp4Ym7
7Q5VJmJKN8cyzyIfvnmz2FMMJtWxHfW7DjyE1+bcNKhGHdJAh2bM9jCiXALMJ+Sg
9yMqTzY5D5xE27zy1L/5ZkN0iKt/1+xx5xVV1t87RJwqNoEW6IG5RZbwbPYKNv4/
9x+b1IRk+1OTqCZbHgO+4OzYqk638g==
=KKog
-----END PGP SIGNATURE-----

--rYRijwbmzeJBcrGE--

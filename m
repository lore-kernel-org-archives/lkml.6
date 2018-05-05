Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZo7cDnyQbH8LZP2dQU4p9M9NOCHu35mcm4MUc9VcbMzq+RIQN5v7t0DzrUpuVNA2h2aG90x
ARC-Seal: i=1; a=rsa-sha256; t=1525483522; cv=none;
        d=google.com; s=arc-20160816;
        b=VKA7miaX0DquOAfOmaibJcB1ZS5GZDI9IB+LMeTbHJHyLy7cAupXqmtSKuoKVSSS60
         GjN6RlD3XcyarZJYuItFhOicPnLqQoPgm7fMSTSo6XdrFMgtSjwy91yK9sJ6KUPmNIrh
         Mp54aOp9K+Uge/uU988I84gCDjZ96Grcq/4oqAhy0kO73HWa42Vhcw4gfwXbaS8uvJdW
         xPjMhfR5GgCDBbxKrYq0JLyP/cx+s3tekeX2N3afR5AEoWV8FYWfaeB2TGzwT58orpEn
         TTIE8WLcg/GZuK/lzdVhMWj+ObrC77JkSHmHoW5zp+2+2JAhUteLE7+G11KG/i2HCzlL
         JVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=T2Ft8a/9pXCPeQPg6o/qz6H7Dgbib5ViQbRZEeycIOc=;
        b=dPIUc3dyHxLhdmkHDo/uYFENbmHFPbQ6nmOTsYczexGvwEAKPHvMLBxWYkHxEZumXN
         +MTRs97LCbp5R6nb0nWJVCaflDaU2ly2OVA6UXS+YMSVnGLHoCyYbulp4XIhXdSJb4bf
         gJtpcdVtMlsez5pZ5EMoamgx4+qLCOeAf9DihzZSHE/Vh44FwwTdpJPvv3KJTf3g7pii
         ws9vnhcS9d3DYzJkQWN1kaqdMJJokjhqZVAMTgsi6Vt+eprDUFRUTLs1zWp2Xt/xbXtW
         oUV7pQKc7dYgEC2Rciq7qqSfh4vYTEfWmBZaAsCeMolieU1X3G/V1NGbZsD4LSR+gt9Y
         ypUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=xiy3zOlU;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=xiy3zOlU;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Sat, 5 May 2018 10:25:13 +0900
From: Mark Brown <broonie@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
	Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexander Graf <agraf@suse.de>, Grant Likely <grant.likely@arm.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
Message-ID: <20180505012513.GJ13402@sirena.org.uk>
References: <20180501213114.20183-1-robh@kernel.org>
 <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
 <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
 <74d495d8-04e2-fb7d-7d07-0905fbc8a6cf@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bgQAstJ9X1Eg13Dy"
Content-Disposition: inline
In-Reply-To: <74d495d8-04e2-fb7d-7d07-0905fbc8a6cf@arm.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599585409937886378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bgQAstJ9X1Eg13Dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2018 at 07:49:57PM +0100, Robin Murphy wrote:

> I guess there's also the possibility that a single driver may want multiple
> behaviours, if e.g. if SoC variants A and B have some identical peripherals
> but slightly different pinctrl/IOMMU/etc. hardware such that A has workable
> default behaviour and can be treated as optional, whereas B absolutely must
> be controlled by the kernel for the consumers to function properly, and they
> *should* defer forever otherwise. I think that would pretty much demand some
> sort of explicitly-curated white/blacklist setup at the subsystem or driver
> level.

Different board variants, and possibly even different bootloaders might
also be an issue here - a vendor bootloader might do pinmuxing that an
upstream bootloader doesn't for example.  In some cases the pinmuxing
even depends on the boot method with things only getting configured if
the bootloader wanted to use them.

--bgQAstJ9X1Eg13Dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrtB/gACgkQJNaLcl1U
h9D36gf+NGCs2L2oQLDrkfirjYtQCzWyoyDF5AUTuptG2p4w8gOd01NKW+x3vm8j
FM8pDZBJ07oKXWAolGFS/qfEjrhsr652zHV+z5YsWrBVGNIWMXHcIRetvgsYCtAR
ZAV8Pa9Va/JP2OlErC4AxhZCyTs3NScwC7g0BqU7bPpSZiTjJNKYuGa+jBXVyJzz
0NDuU+bIoHup9Cq+NC3CTisxyZ0Oz5lp7gOxrdWGKjNay29+tiaOUZKC0U4iGq5f
TYfXBqUnWWuUkauJdSKK0NvlVdX2gN4cWstepfOlcYYOLqq2XAZp08zRWWOGZHGp
rfd1TTUV7q+ADx05Jjx/U35/P0OUXA==
=JAMb
-----END PGP SIGNATURE-----

--bgQAstJ9X1Eg13Dy--

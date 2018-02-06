Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AH8x224vK3CqT93bEHfFCfGEvR2DyAFZIKdbZOehuZIVYepcCkGTvAR7xUJByYX+6qcX3bvi6OrT
ARC-Seal: i=1; a=rsa-sha256; t=1517918470; cv=none;
        d=google.com; s=arc-20160816;
        b=ocOWUmP5SMQ7JJRDICRBoMpRgHvHRV31uD5vkyNB7JYTF+YBzatE5uog6vEbnupxvz
         toKF3o0jGRG7IK6QSsGQEGOS7Z98vRhXA0e58ViuTKmS6Kwb6nCv2UiaB10LFCvBykq5
         1xS79i1GolTQ3gLtGGI+/KYf+H9OM+yu1blij3XPBaJH1AWLGTPlGpXENgj2ys3585RV
         8+nRCeBK8wOJP7zm7PiGOx53v78n8mLsV5S+BjhQO/B/ErhiAzJm2arBPY+VqdRmOwv0
         pI9Q0qtPG1Fn/3tOi0wGM4HwGMiex6r8LAgme9zOkLDyQ6+7qkSz7IjRNA1J0uIfv3qO
         w9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=C6///0fCj09pVORYP94zPiPN59XyK9zae5ZbaxpgBB0=;
        b=MiXFoAzVl9ZVWcgfbq5ZAd3aTpHILNeIjLQNC2qxb4V+kcTpjiFh2rb1GbV5kKieYb
         2lO11SR38YJyMypaRapTDhCXdLZu1IPvJ3DkT4rQTTDjEvSpUL1MG220N8Va4SjWkGJo
         WFJmkWAKpX8BbHqp8q2NijDGNx3vrq5DPyTb2mqKAsQybVKfOmOLPEx9vZntFdAATWFV
         GuFJhspZp2oPlOszrRa2Brj90CvQ9nWif1hWgP/3LpU6c2vd8ZVhVbzxn2HM9S75V+Ls
         AHbYCGJYFL3r7LurexPi6iD6Sff/8DTMvCdozNaRV7+dmz7Eg10t4dpBDPAv7QiBgZGJ
         st/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=gdX0ekq7;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=gdX0ekq7;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Date: Tue, 6 Feb 2018 12:01:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH/RFC 0/6] Allow compile-testing NO_DMA
Message-ID: <20180206120102.GD5681@sirena.org.uk>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591646200835555929?=
X-GMAIL-MSGID: =?utf-8?q?1591652877231152268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 11:14:46AM +0100, Geert Uytterhoeven wrote:

> The intention of this is twofold:
>   1. To catch users of the DMA API on systems that do no support the DMA
>      mapping API,
>   2. To avoid building drivers that cannot work on such systems anyway.
>=20
> However, the disadvantage is that we have to keep on adding dependencies
> on HAS_DMA all over the place.

> Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
> more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
> already covering intention #2.  Having to add an explicit dependency on
> HAS_DMA here is cumbersome, and hinders compile-testing.

Thanks for doing this, hopefully it'll make everyone's life easier!

Reviwed-by: Mark Brown <broonie@kernel.org>

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5mP4ACgkQJNaLcl1U
h9DQHwf/XBpyddbvSIv1fVAWYehY0CxC/MJFXBMtwxQlvO/iNmeq8zu68qIQR8ZV
kgzNy45Ru21rYhgFakUF/Evu564Xl9KLhdYSHanizj6vj4beEnw8PETfGSqdScfK
Qs7IbU5yIFJ6dzXqSLTaNK2qEn7qclRI7Zk1JQxUzpGVGRhWQd6ezIKJOy/5xlSE
Fn3QdQMMu/yWFZdxS1HIIlG6F5/ZExZWHxz9nvpG6MrexN85o4IPgcdXsd1Xaiai
zsDBsurAlRY/vfSewSSpAWuSAbwwKMNco5r1RjDzhI+cwPHGEFwCMDNFTMKF+Q21
ZQVVVljyBt8WnK2LmofdtryHy/61XQ==
=g5tK
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--

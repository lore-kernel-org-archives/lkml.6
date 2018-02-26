Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeBZTzY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:55:24 -0500
Received: from sauhun.de ([88.99.104.3]:38280 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeBZTzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:55:23 -0500
Date: Mon, 26 Feb 2018 20:55:21 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180226195521.vs32bemg7iopkjvd@ninjato>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <20180212111041.027edd85@endymion>
 <20180212185152.GA20877@roeck-us.net>
 <20180214152305.57b76ea5@endymion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vvgnqlsxbfrdninx"
Content-Disposition: inline
In-Reply-To: <20180214152305.57b76ea5@endymion>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vvgnqlsxbfrdninx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 03:23:05PM +0100, Jean Delvare wrote:
> On Mon, 12 Feb 2018 10:51:52 -0800, Guenter Roeck wrote:
> > On Mon, Feb 12, 2018 at 11:10:41AM +0100, Jean Delvare wrote:
> > > On Sat, 30 Dec 2017 08:50:57 -0800, Guenter Roeck wrote: =20
> > > > @@ -298,12 +295,15 @@ static int piix4_setup_sb800(struct pci_dev *=
PIIX4_dev,
> > > >  	else
> > > >  		smb_en =3D (aux) ? 0x28 : 0x2c;
> > > > =20
> > > > -	mutex_lock(&piix4_mutex_sb800);
> > > > +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_sm=
b"))
> > > > +		return -EBUSY; =20
> > >=20
> > > This would happen if and only if another driver has requested the
> > > region already but without IORESOURCE_MUXED, right? Don't you want to=
 =20
> >=20
> > Or if its call to alloc_resource() fails.
>=20
> OK, two things which are not supposed to happen, so failing is the
> right thing to do.
>=20
> > > write an error message then? I don't think request_muxed_region() will
> > > do, and probe failing with -EBUSY but no error message logged would be
> > > hard to diagnose.
> >
> > NP, though the analysis is quite simple - /proc/iomem will show the cul=
prit.
>=20
> I'm confused. How would the user know what to look for in /proc/iomem
> (or, I believe, /proc/ioports actually) if the driver does not print
> which resource allocation failed?
>=20
> If the information is already printed somewhere, then I agree there's no
> point adding a message. But from the code I could not find it.

I don't see any ack or rev from Jean, so I guess there are open issues?


--vvgnqlsxbfrdninx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUZikACgkQFA3kzBSg
KbYvMxAAo0aFcnHK9L9U8NcRkWpk+BlQqeIiiNmH39XGzhpRb+24ObkGF9T45X1k
nQHu+g1vBP00VAO/Y50n1DWRNy9COx4n4hkIvh5w8VtnecnYOI5tJWVw0V2lzH/B
tBJQ41wcCBDcAEPoA36lpUnbaGMgyh9hX8gJLJJ8Jir+3p61nwVI69y3jkxihVis
4bXgH9uohS0TBYkE4EEyVrc/dSxjx+sAd+V4xsmguNVKmMY9cl3H0a4vHkVEePYs
oBIcH/QLVY0pP700KIlKeq4NRmzjnkF9vf6fq8+Hj4mj4q8YpBUwdUohVbvvbpK/
zHHYArLHbU8msu4gok129lVywpchtlwslkm8nY2QOCmzJkZvInsX+DoGPg5UxXzb
8t7DY+/DYczA/JEoAp2gbrdztoPVNFBJITgRcbiapTXwhf1TTW1iR0AFLCB42Br5
ys0/6uU/kpyfs21Zc/P5ckZbBnMtbf0UAkIuZlmYgYtCDHzHaC+0u3OX/Hh4/XCY
8FOrOCKhkzQWBCRf9dHtoEfLk0LAK/cNuVJWkb8cyvFOha4VdUeoROWTapdIKPsV
XY/esTXaJMlnJKlfaUZ5BwPYrsaFidN4DPif8wJadpCy6M1m89Ub6oLGOCBn7Osh
fCoZMbw2ujASwO8TMZeDtWcQw+8qGZkssn+rG6fiBxMTDGtuKkc=
=hXuL
-----END PGP SIGNATURE-----

--vvgnqlsxbfrdninx--

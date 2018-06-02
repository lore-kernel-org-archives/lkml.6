Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeFBSQb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:16:31 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:33694 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751031AbeFBSQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:16:30 -0400
Date: Sat, 2 Jun 2018 14:08:08 -0400
From: Hugo Lefeuvre <hle@owl.eu.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] staging: pi433: add rw semaphore fixing concurrency
 issues
Message-ID: <20180602180808.GA2052@hle-laptop.local>
References: <20180601125037.GA2339@hle-laptop.local>
 <20180601160954.GA4895@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20180601160954.GA4895@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> Unless you can measure the performance difference, do not use a rw
> semaphore, just use a normal mutex please.  Odds are it will be faster
> in the end and take up less space.
>=20
> So please test, or if you can't test, just use a mutex.

I don't have the device yet, so I won't be able to test. I have opted for t=
he
mutex instead.

I have just sent an updated version fixing another issue in my code: The
mutex can't be included in pi433_instance because we have to lock it
before dereferencing our pi433_instance pointer. The best solution I
could think of was to create a wrapper struct pi433_data which would contain
pointers to the pi433_instance and its mutex. I couldn't find any
similar situation in the kernel, so I'm not sure it's the right way to
go though.

Thanks !

Regards,
 Hugo

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlsS3QIACgkQLVy48vb3
khl7Ywf+JgbCTVNU4nnILdewRJwkssfRjabXeWDV4g7bXBTJs95CINea1zPUh+4H
6ivbIQJTZAe6aISgRFeMkRVwLdpC+eQHv1Tzn7yR2gthzMfU58tRpX8e4H62i0OC
s8wlCrVvke7Fd8D6Cspxa5L6qVX5yY0gaABJnLh26J2/k3C0HPHQOLp9yLivSMDs
BAf+hXStf7hbUN6Bm+Ju0CYyQvD3zvvsEsVSIAOhGJBBGFNl5og+wh7s2twMVKOb
2Rm+/ISG16wTlYm+H0PrQtJPu5P4pNB98Lo0GwO8ExouOvMjENROEgdD2HVwWmju
Tu+s0ILa6l4JoKJB+4S0eypp6e7IVQ==
=8z3d
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

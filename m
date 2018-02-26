Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeBZVoS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:44:18 -0500
Received: from sauhun.de ([88.99.104.3]:38923 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbeBZVoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:44:16 -0500
Date: Mon, 26 Feb 2018 22:44:14 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zoltan Boszormenyi <zboszor@pr.hu>
Subject: Re: [PATCH v2 2/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180226214414.6jbloibqkidr66de@ninjato>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
 <1519678013-32749-2-git-send-email-linux@roeck-us.net>
 <20180226205204.p37lf7dcl5k7az37@ninjato>
 <20180226213406.GB2211@roeck-us.net>
 <20180226214307.irourq2svpd7ok7e@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3b23ppokprbe2wga"
Content-Disposition: inline
In-Reply-To: <20180226214307.irourq2svpd7ok7e@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3b23ppokprbe2wga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 10:43:07PM +0100, Wolfram Sang wrote:
>=20
> > It is an alternate and somewhat simpler solution which does not
> > attempt to change the kernel API. My primary goal was to find
> > a solution for the immediate problem between the watchdog and
> > i2c drivers. My solution does not attempt to fix the access problem
> > for (initialization) functions with no return code. At the same time,
> > I prefer to use functions which _do_ return an error if that is possible
> > since it _may_ after all be that there are other users calling
> > request_region().
> >=20
> > Having said that, I'll be just as happy if Zoltan's series is accepted
> > instead of this patch (except for patch #5; the watchdog driver has
> > already been converted to use request_muxed_region).
>=20
> Thanks for the explanation!
>=20
> So, as I understand: I can apply this patch to fix the immediate (and
> long standing) problem and decouple it from the API change. The latter
> can then still be worked on and the changes for the piix driver should
> then be minimal. Correct?

And we should have Zoltan on CC.


--3b23ppokprbe2wga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUf64ACgkQFA3kzBSg
KbYqdg/6A6T1GxMOY5qrkw6WQPXO80F+FlFy2EJI0X8xw784cBDGz23+kZoo945f
yKPZ7yAI1J1jdvA+Z5Z4y8YnvhwB48VMYRtvgy7LNLNfyCc9WCug3jm7nlonb/NY
nk3WiHfcDhanKydaMtq1KzQ3RrTxHIbr+2azaQyfDTSNj30QraRKTvI45I4YLCYk
QQlcELqQUgW0240yc63YRTubZFXfzZdCXTyY9SDQZIWVnqis7mZzl0cOXI8uvBUU
N0AaxGz6zd7D2z5IQHpABaOiOJgf3jDA/Cwa3Yg0Y6uD2HAbJzXZiUbOoLHRKOyT
Ke1OzAj313vGlqcxuPYpe7SHX8ty6+avmw6gjzuQNpDerH9nppZOB2oLXDnOK1er
0CB5NaJw67fpke2VxUVL7+TqI9kWm4ymQwq7S4VCooJHWgTF7Hgpq2mmSEHFg6G1
3Xpysfrk38rdgepgjORVRkgcZ5DejFxuG07eQbVpmbPlSCCVr3HtWknOV5QTUPZC
GAnSNUS6K1orxRr3yHb+O73t/UcA2lQXZ4AP47rDt87GyuypO6naKpQByERGVx5P
yKrpUSRSeoBH531ALpNgNyvwB8cpyRHsOISef/XJeBEhCBetdytZ4hwIjOTBhAin
b1KsSUiOAf2T2ryWpOuOxns7SfZPIlRVY3nQqLG6bvL1dg/dLgg=
=+5Sl
-----END PGP SIGNATURE-----

--3b23ppokprbe2wga--

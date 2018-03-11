Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932450AbeCKVbB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:31:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60321 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeCKVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:31:00 -0400
Date: Sun, 11 Mar 2018 22:30:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com, xiyou.wangcong@gmail.com, fw@strlen.de
Subject: Re: [PATCH] proc: reject "." and ".." as filenames
Message-ID: <20180311213057.GA3769@amd>
References: <20180310001223.GB12443@avx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20180310001223.GB12443@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-03-10 03:12:23, Alexey Dobriyan wrote:
> Various subsystems can create files and directories in /proc
> with names directly controlled by userspace.
>=20
> Which means "/", "." and ".." are no-no.
>=20
> "/" split is already taken care of, do the other 2 prohibited names.

Hmm, patch is probably good idea, but now it means that userspace can
trigger WARN()s, and can hide objects from root by naming them '.' and
'..'... which is not good.

If you know where this happens, it would be nice to fix them in
addition to this patch.
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqloBEACgkQMOfwapXb+vK44gCggq8HxytmKuVAYi8louCiq25G
p6gAnR9eZOhaxU8d8gg7qt8vX4wA2IoB
=nB3z
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

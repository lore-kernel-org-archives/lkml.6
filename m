Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCKVlz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:41:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60556 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeCKVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:41:54 -0400
Date: Sun, 11 Mar 2018 22:41:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com, xiyou.wangcong@gmail.com, fw@strlen.de
Subject: Re: [PATCH] proc: reject "." and ".." as filenames
Message-ID: <20180311214153.GA6842@amd>
References: <20180310001223.GB12443@avx2>
 <20180311213057.GA3769@amd>
 <20180311213534.GA5171@avx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20180311213534.GA5171@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-03-12 00:35:34, Alexey Dobriyan wrote:
> On Sun, Mar 11, 2018 at 10:30:58PM +0100, Pavel Machek wrote:
> > On Sat 2018-03-10 03:12:23, Alexey Dobriyan wrote:
> > > Various subsystems can create files and directories in /proc
> > > with names directly controlled by userspace.
> > >=20
> > > Which means "/", "." and ".." are no-no.
> > >=20
> > > "/" split is already taken care of, do the other 2 prohibited names.
> >=20
> > Hmm, patch is probably good idea, but now it means that userspace can
> > trigger WARN()s, and can hide objects from root by naming them '.' and
> > '..'... which is not good.
>=20
> Patch rejects creation of such entries.
>=20
> And they should be harmless as VFS lookup won't find them, only readdir
> would. It not clear how they could be useful.

Yeah, as I said, that's half of problem.

If I can name my object "." and it will be hidden from root, that
sounds like a security hole to be prevented.

So if you know _which_ subsystem allow creating files and directories
in /proc with names directly controlled by userspace, please let us
know, we want to fix that.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqloqEACgkQMOfwapXb+vKICQCZAfh8VSGI06cXQPaKwHK9pfC9
VwUAnA6uF7N+IxbamcL7NpX4UbD3VALf
=cTlf
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

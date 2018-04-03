Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755266AbeDCIvC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:51:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51498 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbeDCIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:51:01 -0400
Date: Tue, 3 Apr 2018 10:50:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] mm: Add free()
Message-ID: <20180403085059.GB3926@amd>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
 <1e95ce64-828b-1214-a930-1ffaedfa00b8@rasmusvillemoes.dk>
 <20180323143435.GB5624@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20180323143435.GB5624@bombadil.infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > And sure, your free() implementation obviously also has that property,
> > but I'm worried that they might one day decide to warn about the
> > prototype mismatch (actually, I'm surprised it doesn't warn now, given
> > that it obviously pretends to know what free() function I'm calling...),
> > or make some crazy optimization that will break stuff in very subtle wa=
ys.
> >=20
> > Also, we probably don't want people starting to use free() (or whatever
> > name is chosen) if they do know the kind of memory they're freeing?
> > Maybe it should not be advertised that widely (i.e., in kernel.h).
>=20
> All that you've said I see as an advantage, not a disadvantage.
> Maybe I should change the prototype to match the userspace
> free(), although gcc is deliberately lax about the constness of
> function arguments when determining compatibility with builtins.
> See match_builtin_function_types() if you're really curious.
>=20
> gcc already does some nice optimisations around free().  For example, it
> can eliminate dead stores:

Are we comfortable with that optimalization for kernel?

us: "Hey, let's remove those encryption keys before freeing memory."
gcc: :-).

us: "Hey, we want to erase lock magic values not to cause confusion
later."
gcc: "I like confusion!"

Yes, these probably can be fixed by strategic "volatile" and/or
barriers, but...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDQHMACgkQMOfwapXb+vLrSgCeNOji+4hBPeycnjBAONNSs1CB
bpoAoLiCussX5yWpsJiygcsSdM/1gXYI
=BEih
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

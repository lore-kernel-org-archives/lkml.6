Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934511AbeCBXNE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:13:04 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33956 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934345AbeCBXNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:13:01 -0500
X-Google-Smtp-Source: AG47ELulh0hB1szXaQnpWxW5MLnlyr30ytifQ7baeznomMZPXQTnrYQsq485XwFEKBFYAYtZqspIUw==
Date: Fri, 2 Mar 2018 13:12:56 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kbuild@vger.kernel.org, Arnaud Lacombe <lacombar@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/kconfig: replace single character strcat()
 appends
Message-ID: <20180302231256.4aevdu2b5ylyrzkr@gmail.com>
References: <20180302074424.2myh3zhxnbpaohjq@gmail.com>
 <20180302134453.mtd4uepeiviicyef@huvuddator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5c6njx6tk3sxs4db"
Content-Disposition: inline
In-Reply-To: <20180302134453.mtd4uepeiviicyef@huvuddator>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5c6njx6tk3sxs4db
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 02:44:53PM +0100, Ulf Magnusson wrote:
> Not sure this is an improvement. Zeroing the bytes after the initial
> null terminator is redundant, and the explicit '\0' makes it clearer to
> me what's going on.

Yes, I agree with you, that is definitely quite true. This along with
the other comments you made me want to rethink this a little bit.

On Fri, Mar 02, 2018 at 02:44:53PM +0100, Ulf Magnusson wrote:
> I like the approach, but I wonder if we can take it a bit further.
> Here's what I'd do:
>=20
> 	1. Rename the 'in' parameter to 's'.
> 	2. Rename 'p' to 'in'.
> 	3. Rename 'end' to 'out'
>=20
> At that point, you're reading from 'in' and writing to 'out', which
> seems pretty nice and readable.
>=20
> This code is pretty cold by the way, so it wouldn't matter for
> performance. GCC knows how functions like strcat() work too, and uses
> that to optimize (see
> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html).
>=20
> I'm all for trying to make Kconfig's code neater though.

Since this code is pretty cold (completely agree with you there), I
think it would actually be much more useful to rework my patch to
have a more style-centric approach rather than an optimization-centric
one; this code would definitely benefit from being neater.

Some useful changes would be to rename of the _atrociously_ short
identifiers like p and l.

Anyway I'll give that link a read over and try and make a V2 later
on today.

Appreciate the feedback, thanks for the comments!

--=20
Cheers,
Joey Pabalinas

--5c6njx6tk3sxs4db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqZ2ngACgkQruvLfWhy
VBl/2hAA0tVRbvfSQVQv/LRD8Wp+CAcnvnLwI4VPp0vrCh/f/oxqUV533/6Cj2o6
0AatrgS4Qa1VyiIZjaMUaerwnzsWQAnBA2+iXpP5RbcicreMCfN/YI6qtr/brzvR
Q35wOtU6QqM6s4tg5Se0gS71UkgPgItwRLN4tZoGCSWooBPjOtU58tY69YzxJVBk
Vi1Os3RiuJzMwEjdv/ztwjSTWN37op9ZwjFFB9X7WEGiJw3VI8iZ5fANI0OR+niH
6QTp4Hmz1OzHqze837pn7T8xY02pwU2IsZkGAWxrdZgPip1iTaQxEOQGLNWSSvQ9
WWmd/H2a0+ifxx22FdtFhBviip+gK0xcSCYaOeh8MVphWwuWsC7FCWmszw8H2blz
47SfjCsHsAKisxwCMIZH/q2YegFUvqjKnfQ1aK2AmgWvek44oknDUA40XHQyUQyw
Cl8/Rr+LTTcAtX+Xb4HDOOflSQq5YpX6N4ZwxI6z0wuxdcnLQM3KSgACjdrgp+YS
TfvHu+jabiI5p/Wi7SQ+Otw3imAzrexfX42GPnno0xGPOrgleBAuNgMq9P99rMf4
5WkqKFOdqRh6w9sSFQvzLQdEltXgfxkZxm+sevao70YFE98rutIOrd2/V+Qrs8wt
nVjQeN3BSxUl/msIuTmK6g584+6QvSL7N5IGNnkXzI7XUpnLWqA=
=Uaaf
-----END PGP SIGNATURE-----

--5c6njx6tk3sxs4db--

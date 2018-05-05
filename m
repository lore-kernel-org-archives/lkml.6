Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEEVtv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 17:49:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEEVts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 17:49:48 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 06 May 2018 07:49:40 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] rhashtable: silence RCU warning in rhashtable_test.
In-Reply-To: <20180505091046.bd74tk75oieaasi5@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605424.18473.310003836978239224.stgit@noble> <20180505091046.bd74tk75oieaasi5@gondor.apana.org.au>
Message-ID: <87y3gxdb7v.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, May 05 2018, Herbert Xu wrote:

> On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
>> print_ht in rhashtable_test calls rht_dereference() with neither
>> RCU protection or the mutex.  This triggers an RCU warning.
>> So take the mutex to silence the warning.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> I don't think the mutex is actually needed but since we don't
> have rht_dereference_raw and this is just test code:

I agrees there is no functional need for the mutex.  It just needed to
silence the warning, so that other warnings are easier to see.

>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

thanks,
NeilBrown

> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlruJvQACgkQOeye3VZi
gblIihAAjUaeZNump5z/C4Mlt44suqZrthqo7fcC9CpZoC6O+e2+lq3Pu07KaXxs
YEfJCNQohKb+oYQp4AkaCloRhrbvVpMR1AoUrB6dt/7ZcQo1T0yrw/WvrJdhvflh
UmQ96dKH8xXwBLVh25g35VwO3yI4xfm/JkvLmj4Hz6JRY0cUCflVl5hwhZWB9Dxp
PjM91omUc3GOFwsdi+9N2JG3K2lYZyGxhixFDh/QTtheVFTOSThQccmykE7z4V9V
v7JWD/dBxfabgWnQEsI5BDff2cSeauRrf/pQYGkDxfDfCAP4zxpxMfTgQ0myEL7/
ZAw09wMAZC4yJbXdWRhC7tJZn6hoKtwPvTD2izsmytHSFTULtJVIiq/9OfPJjXiy
JlDZ3H/IF7x15dt+oin/aSqtxEUAOXnyJSN1V1LCuFs1HuF4RF1mBM2ch6eAwJgq
tuz9O736X1PokaTUM7WOON+qZHsgGxrMSyD2rnr8so1p4cf/78M9Ju9f+O442EOJ
WVLl0CfTbV52pyjIOCAMGgMfzJ7Gq0Lpq6V9vE/5+MRZPY3NgB0lEANh0dLJCU2A
KAgzkYPXkJUwPs7VhAuGLJb3H9+bzTtnNhfJEIGc1rZQLKsTqBpD9CotQlc0MLiM
JS6u/nHt+HrOtlVmqnzPhGbPMwn8v9qhe5sPH5u2vfEDhXM97zQ=
=wmBu
-----END PGP SIGNATURE-----
--=-=-=--

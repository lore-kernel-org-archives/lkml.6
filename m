Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeFDAZT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40137 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbeFDAZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:25:17 -0400
From: NeilBrown <neilb@suse.com>
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 04 Jun 2018 10:25:07 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 15/18] rhashtable: use bit_spin_locks to protect hash bucket.
In-Reply-To: <9bea77df-e7db-677a-31b2-710dc6d956ee@gmail.com>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824984.30340.1634082820568216846.stgit@noble> <20180602050322.liesw324q5kawcue@gondor.apana.org.au> <9bea77df-e7db-677a-31b2-710dc6d956ee@gmail.com>
Message-ID: <871sdnqty4.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 02 2018, Eric Dumazet wrote:

> On 06/02/2018 01:03 AM, Herbert Xu wrote:
>=20=20
>> Yes the concept looks good to me.  But I would like to hear from
>> Eric/Dave as to whether this would be acceptable for existing
>> network hash tables such as the ones in inet.
>
>
> What about lockdep support ?

bitlocks don't have native lockdep support.
I would be fairly easy to add lockdep support to
rht_{lock,unlock,unlocked} if you think it is worthwhile.
It could only really help if a hash-function or cmp-function took a
lock, but it is not a great cost so we may as well just do it.
I'll try to have a patch in the next day or so.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsUhuMACgkQOeye3VZi
gbmwkQ//RIyzYqB5x8M2NuN5PX/2FC9O4l/r5SWXOe5ekHtmUnnVIZGvmw4UiBOZ
/E7P3pYUzmUYz1IQ7I2tiEITfuPZUGNeQHZ/H8mc8UWjP2MxtngDIDYQjDNk79E4
+Oxr/oXXDnFvk1EH1HejMbYXScJRl0dtqivZeDW4xqqK33kityY1ezBgjgm2VTlC
uxMybXW+mhsDmpScwZ5iXk8y9SX/88VOC+D/nsQ7CnqRjTkOH4VjQcXEl3VXvdd0
Ih8Q67W7aRYCFe4E+/0p1eGXFZ1ej3zQI+kMqUiDNv7iJ1s3hNIvsZuOqB75vY8z
j92//V1W95G6vfUE4c1aPRLSOT04n+RCzvhRByV8u1kG6tBrmmSZ4NyjoS4fd+Q/
Cd2YdooylkVc/eD4oc3YI6n3wjgDGpIIHRPZOomtXtDJmBdC/9IUsvgMNKUP5nFB
gkrNY2grjGN1U3auRKcw/lt1PLsSQlO5o7SbpEaH2YAjxi5sRDnhpvI0FXtyJWj9
bNtiARNUfxrBKxTNDmSKVBtjoS/U6xzyT+Zlh++ys5FbbPiOe/nEqyoaVu/d9jRT
Na8bmRejXzcJSag6ZuR+m1QFMHqEipsoMeewpnbx+631rOTWbnMSmKbH8ad9oiw2
GVciPf5yDGQYL5nkcdI8Om28KtqpmvVEh53//2eFwRrTRERB/lw=
=O1to
-----END PGP SIGNATURE-----
--=-=-=--

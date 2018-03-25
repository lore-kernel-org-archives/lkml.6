Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeCYVKT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 17:10:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42616 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751142AbeCYVKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 17:10:16 -0400
Date: Sun, 25 Mar 2018 21:01:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
Message-ID: <20180325210132.GE74743@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180325182803.30036-1-avarab@gmail.com>
 <20180325182803.30036-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20180325182803.30036-3-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-rc5-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Score: -1.205 BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RDNS_NONE,SPF_FAIL,URIBL_BLOCKED
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 25, 2018 at 06:28:03PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> The earlier change to add this option described the problem this
> option is trying to solve.
>=20
> This turns it on by default with a value of 1 second, which'll
> hopefully solve it, and if not user reports as well as the
> X-Mailer-Send-Delay header should help debug it.
>=20
> I think the trade-off of slowing down E-Mail sending to turn this on
> makes sense because:
>=20
>  * GMail is a really common client, git.git's own unique authors by
>    %aE are ~30% @gmail.com, ~20% for linux.git. That's just patch
>    submitters, my guess is this it's much more common among those who
>    mostly read the list, and those users who aren't using mu4e / mutt
>    etc. anyway.
>=20
>  * There's really no point in having this feature at all if it's not
>    made the default, since the entire point is to be able to read a
>    list like the git ML or the LKML and have patches from others show
>    up in order.
>=20
>  * I don't think anyone's really sensitive to the sending part of
>    send-email taking longer. You just choose "all" and then switch to
>    another terminal while it does its thing if you have a huge series,
>    and for 1-3 patches I doubt anyone would notice this anyway.

I'm not sure that this is going to have the effect you want it to have.
Let me give an example to demonstrate why.

If I send a series to the list, in order for this to work, you need my
SMTP server (Postfix) to essentially send mails slowly enough to
vger.kernel.org (ZMailer) that it doesn't batch them when it sends them
to GMail.  The problem is that with my mail server, due to filtering and
such, already takes at least a second to accept, process, and relay
submitted messages.  vger still batched them and delivered them back to
me out of order.  This will be even worse with large series.

You are also assuming that my mail server will not have batched them and
delivered them out of order, which it might well do, since Postfix uses
a connection cache to machines that don't do STARTTLS (which, much to my
annoyance, vger doesn't offer).

In short, I don't think this is going to be especially helpful because
it won't change the status quo for a lot of senders.  You'd have to
insert some significant delay in order to get the effect you desire, and
even then things could still be delivered out of order.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlq4DiwACgkQv1NdgR9S
9otDQw/9H8FPstoFfE9ZLLry8V6c9Wxx61F1h/GrR1fWcMsa111DVlEvYjb4Fq2q
XjG7MCTPbQAJ9fPEdNHyqMdczGKdrWU4MYEl39pDUBCCiAL3X9WsHZps/glGxuQx
yVJ7D5fHKHY8Xh3Ovps9cdpes3it9I5AzA0wMj7oY1s18A8VTKH5vVb/hwEEP/lw
NiqrGAucbr8I1t05Y3IIqpFAY7HAuwk4Ik2nIS9cfGl9WpjkmBF9lJaMNp49KB0A
YvqOAe6fsJRrqr1BZ/06RaTQPxmPOi/hdVep8qIBmna3GBmfCv/wxaUTweYeUkib
XTAI8Q/muLzW4MlSFifu4L7XKDW+zlPyKGCCzcFZ9ENup4xr87gWuO87FEvKgq8/
+p9855UDEOQeCL2ZrvcdXCtiuBuXGbzuhYEGXty5TejIhE7i+osY+19gxomAhEzc
NZaCtgb/dxhIywniqKUCCL+woFVY7lQjsMZldFKa1MIkhmv3iG5VbNWYDTZj1M46
NXiGRYogRQlq8TTMf/B8OLSnHRWicNJs8aIqGFHfrCMg6amEipCOEBK+q7FOgu2c
BzolRL5y53O2MR2qHSSg0mGPzd/ENqNQePFy9wT//GuHapEUFMODDfRcyh36VyUx
9n5z9u7bQ+ewlq5pNk4bUA7ffDbYcyK1ZvANmeiOu0cZeOdrm6k=
=NQDg
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

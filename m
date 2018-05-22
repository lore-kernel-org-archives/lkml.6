Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeEVJGy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:06:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34030 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbeEVJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:06:50 -0400
X-Google-Smtp-Source: AB8JxZpRlioCOBjU1v+rLK0ZKU5LWRSVHho69Mt35WHCpfU8knt0AOmvV0Lw8rP82DuqTQufv3/pOw==
Date: Mon, 21 May 2018 23:06:47 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4] scripts/tags.sh: use `find` for $ALLSOURCE_ARCHS
 generation
Message-ID: <20180522090647.pmy7c4zwax4jlp7w@gmail.com>
References: <20180518115619.jqb4hqdym7fmrs2p@gmail.com>
 <CAK7LNASuhoJsaBz6RjumbQnqhtyLJGLjkhGSs5-bvDz1TOuGww@mail.gmail.com>
 <20180522082117.p2b5jt5qtuwarqwo@gmail.com>
 <CAK7LNARgW-YdGbtT3sJt_UpE02CEAvE9csm8Oc2SoSZo71Bt8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="63wlwkyb4zdixizi"
Content-Disposition: inline
In-Reply-To: <CAK7LNARgW-YdGbtT3sJt_UpE02CEAvE9csm8Oc2SoSZo71Bt8w@mail.gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--63wlwkyb4zdixizi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 05:41:48PM +0900, Masahiro Yamada wrote:
> I see some new motivations for this patch now.
>=20
>   - The current code includes 'Kconfig' in ALLSOURCE_ARCHS,
>     but it should not.
>=20
>   - Simplify the code, removing the find_all_archs().
>=20
>=20
> If you are motivated for v5,
> how about this?
>=20
>   - Remove the double-quotes from "${tree}arch/"
>     (Because the rest parts of this script do not have double-quoting,
>      I do not see point in adding it in this line only.)
>=20
>   - Update the git-log to not mention the hypothetical space things.

Alright, that sounds reasonable. What do you think of:

> ALLSOURCE_ARCHS=3D$(find ${tree}arch/ -mindepth 1 -maxdepth 1 -type d -pr=
intf '%f ')

The double quotes surrounding the arguments have been removed to be more
consistent with the other find commands in the script.

The ' %f' was changed to '%f ' so that you don't get that weird leading
space; I couldn't think of a way this could break anything but I wanted
to be 100% sure instead of needing to make a v6, heh.

The commit message will definitely be fixed as well.

--=20
Cheers,
Joey Pabalinas

--63wlwkyb4zdixizi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlsD3acACgkQruvLfWhy
VBkA1RAArI7aqGBk3UQbTcyELc4ACJ9Bip8rSMpvM8TIYJSKEhy/yTaeGtXqRPkK
qRIKurqGZl8+x9o6kOmfW2EPeLR8fD6zBnAqqt9JlUQuvV/0z//L2vE98Hy4qKcB
BscYB6IHYz/i+9oXHXYqZ6JvfPDETK0fsKZtJnVrk8X6gPQGodLaXMo9xlxuliri
LYKpftGAkBWzKVb0HMLm3XymtqRTbrYE8iyaLXltoFsiV+Kd/GyHg+89V7wDKNmc
Ap70fSDG8TVFhF4V/AGOVaotgqPp7o55UrOl9KAzIJafql5jNTcA2ebwBcfAeXu0
fDQNKEPEdN0vGdCq8cMTdov+K8VqmfnU/fGX9F6HbCIrsuOz0n2yxA71PMXlMsuq
hb6H6M5ae+bE/+fXNEL0AMRunAXCLsee6UDlekwhAerKqFCkF3yz7DG8V2S9nQhQ
HsX92b63znClLIgMO58gkZJfEIgL24bkbmhAfm8/eCHncCCHNjYxnJ/R+FhwMe+U
FgpxK3cKLh+sNZv2f1rbwxHXJZA7H5+qE+cRwQPbKD8E7QHd71g5mnVJwRFqD6n3
71NyJG5cPLxG5fcS7czI91Lk4WXyIF21l8Ws7qFHxvXkvXVOrDWJPc6hO+V3qqZo
nK8b8w/q6/eEXRTY5wQacR28S3c2AHNSL+kGI27vXyyL2A4UqOc=
=dtRo
-----END PGP SIGNATURE-----

--63wlwkyb4zdixizi--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeERLwL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:52:11 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:33115 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:52:08 -0400
X-Google-Smtp-Source: AB8JxZpchVZJQ9k3m0oRrKf2PVC9ElewVFJfqY95vJ2g76Koq+kgoeKTXNTqQjl5bsdkvE18ZVkITA==
Date: Fri, 18 May 2018 01:52:04 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3] scripts/tags.sh: don't parse `ls` for
 $ALLSOURCE_ARCHS generation
Message-ID: <20180518115204.fvz24hdytdh6qgt7@gmail.com>
References: <20180518062553.kodjjrlrosrg7vfq@gmail.com>
 <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
 <20180518093131.7g5m4mu3mtrgb7so@gmail.com>
 <CAK7LNATYiKYzD11anXzCqjWaqeezHo4R1db+qAdCAAJLkvuf9A@mail.gmail.com>
 <20180518095833.kua6rcsrvz3vb4qv@gmail.com>
 <CAK7LNAQbJKYkmZgE_0bZxff9L0RY8K4W_hndpqKS2d110ArduA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hqjldhauj7dntyvd"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQbJKYkmZgE_0bZxff9L0RY8K4W_hndpqKS2d110ArduA@mail.gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hqjldhauj7dntyvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 08:03:26PM +0900, Masahiro Yamada wrote:
> Does this work?
> ALLSOURCE_ARCHS=3D$(find "${tree}"arch -mindepth 1 -maxdepth 1 -type d
> -printf ' %f')

Aha, that actually works perfectly.

> It would leave one leading space, but I do not think it is a big deal.
>=20
>=20
> It would be possible to chop it like follows, but I wonder if it is worth=
 doing.
> ALLSOURCE_ARCHS=3D$(find "${tree}"arch -mindepth 1 -maxdepth 1 -type d
> -printf ' %f' | cut -c2-)

Yeah, the leading space isn't really something that is worth worrying
about here in my opinion either.

I'll use this in my v4 then, thanks.

--=20
Cheers,
Joey Pabalinas

--hqjldhauj7dntyvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr+vmQACgkQruvLfWhy
VBkh8hAAjuzMmHGTcMOGcx4nZDzJT9t73wv00VFIBIHjR3l4vdP5+j5jKiDsFHO5
LENF5XM9ICXINhjUSV8GMBqHea4nefx8hl3yWFFKNOZZ3GgifxW2VaonxpoIW6Ik
j9EHfeEe+7j6QiNFkkB1rj+/b1oNCaOuA1jWaAsYFlhhP4A+elR+v7zmummgpNNd
699e35aB2sOmHwdLgVzh6kcHvHp/c207aVno6pZkqFBmSzXam3Zkiq98tI4w+DUP
RwkINojoG0Z7DnFCLivjEz0gRKTFEtOCW4B86suyGjOUOJ8oM1/bdBSwhpAWaD8E
A//lOZSDJNkelhi0fn3p1Z0K35CZ+0+7y7U5ms4jOs1pAUZxQPq+tiOZIZTPgy2K
FaA9ofqet4347mBexxpcOjmT5HM7+u8JypO9aZJL0w0VTypeyu71xLHCJEQgVsei
qB7gvVoHY0cAGIlHEJXUMueedkpd1tChDckhWePUNSQlOtkfhBBcClwixLykgMsU
an+vhIz9D5K7UMWf9ULuMsNx+/Fg0rHByXj0YtOcOY13qndmEjtqj/dBknodxhdR
hmFrztJ/N983p5mnZn6pBJgJNYe31WUR8ROO/zcpXfucIV7AeGQhorgHoHNEsuJZ
VlJz06S5KbuELV/jJ2Ymlu49gqgaors8ZSE874T3dIgaj6Sf+MY=
=uVbM
-----END PGP SIGNATURE-----

--hqjldhauj7dntyvd--

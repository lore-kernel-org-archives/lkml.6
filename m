Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeERJbj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:31:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35303 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbeERJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:31:34 -0400
X-Google-Smtp-Source: AB8JxZqJFB5Q8edjN+AohRSxQ343lSjvxWIIhxeJadEx/NHtqSzr3nav2RbjQgZm8rxfSDPxI+A79Q==
Date: Thu, 17 May 2018 23:31:31 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3] scripts/tags.sh: don't parse `ls` for
 $ALLSOURCE_ARCHS generation
Message-ID: <20180518093131.7g5m4mu3mtrgb7so@gmail.com>
References: <20180518062553.kodjjrlrosrg7vfq@gmail.com>
 <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5cyb62egrzp6zia"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5cyb62egrzp6zia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 04:08:44PM +0900, Masahiro Yamada wrote:
> I do not like hard-coding the file(s) in arch/.
>=20
> Don't you have an idea to list only directories?
> 'find -type d' or 'ls -F' or something?

How do you feel about the following?

>  # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
>  if [ "${ALLSOURCE_ARCHS}" =3D "" ]; then
>          ALLSOURCE_ARCHS=3D"${SRCARCH}"
>  elif [ "${ALLSOURCE_ARCHS}" =3D "all" ]; then
>          ALLSOURCE_ARCHS=3D"$(cd "${tree}arch/" && find . -maxdepth 1 -ty=
pe d | paste -sd' ')"
>          ALLSOURCE_ARCHS=3D"${ALLSOURCE_ARCHS//[.\/]}"
>  fi

If something like that if acceptable, I'll use that for the v4.

--=20
Cheers,
Joey Pabalinas

--b5cyb62egrzp6zia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr+nXMACgkQruvLfWhy
VBkBuxAAgDBYeQtJ4o77t7+kaYAo0iGJjXiOBY+YA0PE8mnyKLDasDNzO/iWI4Vw
fAL20WyAH5+Q+CO+o913rJ/egIoo7XMu7S8ZkGH46Yghhi0ViweKIAjLzIAV+tQT
9xUUFd3mUAYRFc+rxCHxXwGLVacEnlEZ3Je+OuRzgCRYDNLigCF0B96Ojf8nGFz1
yPxn8FrGBaFE2ox/fUtNmQWaUCGk72b7F3VdEe9vtRwnZSFuD7GmP2W1xKukzXJJ
Px3X9HrPZ0Oax78hA5lfU2Xjx6dnxLURpZzCz6UK/trsyaKkzIbq7aHv0wUI5R6K
D0OECUXzVNH7BxgsZbJ8WMys854WjPsCa+BgGOVkSI0RniHGAG3IzrpA2fHqlZ5W
higjnH7rd6QcygiKViBEGg78IVV+47qNeEi/gJn9BE+2VvtXRhw0kh4kLVFvRK4e
BjdfZfaIaXBdHLf7iVxJj99ZkXH/wKy8cDP05BLn35V0plvPMsI87anXRE3S4nRL
SPFq5aUwXzsMAvBzYOPfVbwwQUOqLVmCMHpoVguEw8+E+aqI2YAIB9LkUNoFs/qp
3MZ7Jz3Tnssmvdhh+S/gExWyUaAFqwR9ssCswDTyI08Z21PUlTWMOVAQec2bKSHD
JMJIhpV5nMh/oNGVXGyXVdBDF4HwSNobu3PyUrEZE4fdoaEU+3I=
=lnCa
-----END PGP SIGNATURE-----

--b5cyb62egrzp6zia--

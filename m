Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeCUXw6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753875AbeCUXwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:52:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF27620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 21 Mar 2018 23:52:50 +0000
From: James Hogan <jhogan@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: remove ralink_halt()
Message-ID: <20180321235249.GC13126@saruman>
References: <87370v9mkg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <87370v9mkg.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 07:29:51PM +1100, NeilBrown wrote:
>=20
> ralink_halt() does nothing that machine_halt()
> doesn't already do, so it adds no value.
>=20
> It actually causes incorrect behaviour due to the
> "unreachable()" at the end.  This tell the compiler that the
> end of the function will never be reached, which isn't true.
> The compiler responds by not adding a 'return' instruction,
> so control simply moves on to whatever bytes come afterwards
> in memory.  In my tested, that was the ralink_restart()
> function.  This means that an attempt to 'halt' the machine
> would actually cause a reboot.
>=20
> So remove ralink_halt() so that a 'halt' really does halt.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>

Thanks, I've cosmetically tweaked the commit message (mainly reflow to
72 characters) and added:

Fixes: c06e836ada59 ("MIPS: ralink: adds reset code")
Cc: <stable@vger.kernel.org> # 3.9+

and applied for 4.16.

BTW, I'm intrigued to know if there's a particular reason you don't
author / sign-off as "Neil Brown"? Its supposed to be real names, though
"NeilBrown" is hardly difficult to figure out so I don't actually
object.

Cheers
James

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqy8FEACgkQbAtpk944
dnocMBAAwMcM/Wl7R8i+9/r0Vbda5XdgMxOVOjqEG2FRcxCy0XRSbQiwjvOBn1es
L4AnIIhYJxkb0UEPXo3E82yf6ZHwWVnTO1W+IpgiRzzDjySIE7K6Nksl2mCRH34O
isELVoDxMpiqkVVWsp37B5mILf5vmizFvhr/q1pJla6b+fSEb8TWmlN6rsA4vb6j
pJ6PBPLYLJUDlq0oORFsq12LikI3+kpn2ToHMV37IOSdTlB8n4w9T/jtOueQwYbu
NDP5BZUL8pABu/pcDq9XkqWgNcR9Wpee3SWFYSLYwoowFPeDYcUmAi7B3MqRCfbv
S8VJU/zxa5CoPWtDkVgfRrb6e+jhn2tNEpYWUTwo+mG8U+7vp99Tejtje/HWuBCN
QYOvZ9kjdJwjgmhngiP4SKrsJMuPVLCpmDf8Dv5KyZT226xROAiv5XFD2XmrR3jY
B+UV8kD5y6RhmMTQfl9cIMplYWqSIgdN2ugya8jsUGvn+7qauXnQP/hxqdga6lKW
cxQG4Hu8NpXjXSVMpYgcLaFEpPgK7ioL7oRoMC6hbE+Pq+MiOwAQUv2Sii3zr4lW
0KrGwb1yYpBfufKBRCoELIQPuFcKy5tJ/9C1UJbjqhZnDNXr1OF7NhetY9fZPwFK
esh4DLxQJMUO3Koij1swK+bRba/gpIOtDd93KgubH9+wqKNCnuc=
=1kWr
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--

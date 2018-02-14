Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966876AbeBNEyu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 23:54:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:36530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966813AbeBNEyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 23:54:50 -0500
Date: Wed, 14 Feb 2018 15:54:42 +1100
From: Aleksa Sarai <asarai@suse.de>
To: Enrico Weigelt <lkml@metux.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Message-ID: <20180214045442.jyv6zpbwz5glzi4z@gordon>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
 <20180213222751.p3fyg7whg6jqlzz5@gordon>
 <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mk7kxfbcygvibxyh"
Content-Disposition: inline
In-Reply-To: <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mk7kxfbcygvibxyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-02-14, Enrico Weigelt <lkml@metux.net> wrote:
> On 13.02.2018 22:27, Aleksa Sarai wrote:
>=20
> > You can do this by creating a new user namespace (CLONE_NEWUSER), which
> > then gives you the required permissions to create other namespaces
> > (CLONE_NEWNS). This is how "rootless containers" or unprivileged
> > containers operate.
>=20
> hmm, unshare -U doesn't work for me (even as root). But docker works,
> so user namespaces should be working. Any idea what could be wrong ?

It depends how old your kernel is and what distro you use. Arch Linux
disables user namespaces entirely, Debian requires that you set a sysctl
to enable unprivileged user namespaces, and RHEL requires you to set
both a sysctl and a kernel boot-flag. Also check how old your kernel is
(unprivileged user namespace support was added in 3.8).

Also Docker doesn't use user namespaces by default (you need to manually
enable it with --userns-remap, check the docs for more details). You
probably also want to be using "unshare -r" in your testing (as "unshare
-U" will leave you without mapped users).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--mk7kxfbcygvibxyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlqDwQ8ACgkQnhiqJn3b
jbQCsw//XLK86wSs95l94TQCrztf8nUpjflSLgZKt+p+IdwOhvf4GaQoFA68cIV5
QPARksiYj1WGXacwL8Ajw+ZtCUzVQcHV5iAh1wu/Ep5KjEjJGegFDiwW0MmMp4w9
qkxUwak8T5ZVu0K8CBrl/LAuCJE62udau+Z1Xu2kN8MMrN6DT3M3M9QFRXSs/Lrz
1P0OTRvuK4ifNKePF7j0aZ3Ts7HUvgEgRGQ7gI5Lpr8Zwe9vNeq+Rl3pHkERt9sR
bbPA84xClI1JSxOTVhrNvTYoQuq6Hg5106vLSlJaGOxRRzLKF+60hLK6LgJuQuY/
PJ9ky7Iu6CrBYueHegdwly6m2H7AHwP9uNtIJ9gpfmLtuF4xI14L/rhjbS+SGikM
0ESDe3NcS4gnN9PyWv8ieynzsne6jdVZ7S4tYYC+V0CFKZxeJhYx7AxPbHtSaqDV
tCKEnxrN6Oyk8R9KPCGNPhkvoOc4Gx8suQOlto9wThZWs0XjvjaR7WstJ7183aSd
2zNk8OgNh7AM9keQUMGPncMmpqNnB13CabzBm4sVfhXkuuPO4/XDbR7an0F23esl
2wzq2xNrbwE3BcfxmvgsU3wOq1XBfxILJB4hfZzAomycVhbXfb45UoQhjXSC3Xzm
sj3ZHFkFCLE/+1gUkGtITcWJb77h82dDLAeTR8LIrfki3iNaaAQ=
=9bBi
-----END PGP SIGNATURE-----

--mk7kxfbcygvibxyh--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967214AbeBNKYS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:24:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:59794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967066AbeBNKYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:24:17 -0500
Date: Wed, 14 Feb 2018 21:24:10 +1100
From: Aleksa Sarai <asarai@suse.de>
To: Enrico Weigelt <lkml@metux.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Message-ID: <20180214102410.dxgbayb4i76h5exo@gordon>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
 <20180213222751.p3fyg7whg6jqlzz5@gordon>
 <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net>
 <20180214045442.jyv6zpbwz5glzi4z@gordon>
 <9c097fd9-3035-d5be-a829-fc18e7734f18@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i6vlwh3q4g7b5nmn"
Content-Disposition: inline
In-Reply-To: <9c097fd9-3035-d5be-a829-fc18e7734f18@metux.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i6vlwh3q4g7b5nmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-02-14, Enrico Weigelt <lkml@metux.net> wrote:
> On 14.02.2018 04:54, Aleksa Sarai wrote:
>=20
> > It depends how old your kernel is and what distro you use. Arch Linux >
> > disables user namespaces entirely, Debian requires that you set a
> sysctl> to enable unprivileged user namespaces, and RHEL requires you to
> set> both a sysctl and a kernel boot-flag. Also check how old your kernel
> is> (unprivileged user namespace support was added in 3.8).
> Just tried on a mainline kernel (4.15). Same problem:
>=20
> root@alphabox:~ unshare -U -r
> unshare: unshare(0x14000000): Invalid argument
> root@alphabox:/proc/sys/user cat max_user_namespaces
> 5922

What distribution are you using and which release? Also, are you trying
to do this inside a Docker container or something similar (Docker has
seccomp filters that block CLONE_NEWUSER by default, for instance).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--i6vlwh3q4g7b5nmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlqEDkcACgkQnhiqJn3b
jbR/lRAAhtJwY1LdR9n3xTMOgI6w518forGtJw6stoKAUvTvSv0ZbTqR6da1J2YA
fwPosBpttzWbygbhi/7GjzCYkNUDYu9OJMf/toXHqniuvnj7KlDODCsAUlIe3CEx
8aaPSHDuSxrmi/Mu66f89DT58flU5zc/jrVr8CH5Rk8yY8fVW5zI7RtV7o9xCz6/
CW8Dhu0fIBPxzK3lGK5bfmsiWXL/zsDe5e2cHBczX4fUORfIYepQ8luAbckOsxYE
lGqlPM0/NwdgSrSpL2g+a+6WhN+ZI2FsQak75d0XtJ28l/pwAizcAYKquPUEd9dp
wkFS6g3TSZ7pEK8NdCKT1D6y00ZtzEhX2eUZq3VDSnVcf8y67e3u/JtSIBayIo4L
gwKsvZOWu9yjPOQiPgSl3Znlas0uIbR5EOcxQ4q4Fu1jnX7IRdz/kjDDfW+sYHgi
EL6+6LxV+fr6hKaisKq5QprefpU9bk4n0prPv6aw8nCw9dwPD8FDvLi2cy/Io1fz
slE2XTFNFDP1T91iRsWrlXl1OmwT9wJvHTl5MaY774L1cMluqbXkDgEXZVniE5Rq
ze7+BJluc4KLb5VpnT5qUAqWOc+VdoVKPxewunXn9+qxSfSEUmw144vumVivuvAp
LOQ2Tr+1mWSen+odSI8+atCmygixQNxhvTGHOUeNfdfeQx7+vyo=
=HU2g
-----END PGP SIGNATURE-----

--i6vlwh3q4g7b5nmn--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966030AbeBMW17 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:27:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:59826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965900AbeBMW16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:27:58 -0500
Date: Wed, 14 Feb 2018 09:27:51 +1100
From: Aleksa Sarai <asarai@suse.de>
To: Enrico Weigelt <lkml@metux.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Message-ID: <20180213222751.p3fyg7whg6jqlzz5@gordon>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6hqz3juwskhopve"
Content-Disposition: inline
In-Reply-To: <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6hqz3juwskhopve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-02-13, Enrico Weigelt <lkml@metux.net> wrote:
> On 13.02.2018 22:12, Enrico Weigelt wrote:
> > I'm currently trying to implement plan9 semantics on Linux and
> > yet sorting out how to do the mount namespace handling.
> >=20
> > On plan9, any unprivileged process can create its own namespace
> > and mount/bind at will, while on Linux this requires CAP_SYS_ADMIN.
> >=20
> > What is the reason for not allowing arbitrary users to create their
> > own private mount namespace ? What could go wrong here ?

You can do this by creating a new user namespace (CLONE_NEWUSER), which
then gives you the required permissions to create other namespaces
(CLONE_NEWNS). This is how "rootless containers" or unprivileged
containers operate.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--a6hqz3juwskhopve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAlqDZmcACgkQnhiqJn3b
jbQBiQ/+PPO9TOTnb9rSgeR/g5QRZEI4/mUBjlwDl/F6bBXb/23FMBBX2DnaZ5uk
XgeRYDQcw5kh62Zq6QSXNMOmodfoI3WhEMUh/p3xVHCOTwfs8UR7kaE1YjXg0sld
wtTFePg75WF+A9ct1SWCm0vMKn2u2+iLcb0l3XqIl/xGplSbfRXWMIBAMxLgwOG/
/FNR4vTuxuDcsRXOo7TdfvY+vMf1yQJrb0DamZx+hshzh+a4l4Q5MjOb2pffhNrj
eBymq06aFn69KETJFnujIPXOm87zPieH/bF98xMdn64xuX8Z1JZ0+Ei9ISnxK2Uf
Be8FQlrkuJ7t3LU8YUX0Sg9tgxVO8jHeTlWduo02NCUEntBxc5nZAe1IwbQmieoC
604OKkAA6Qv5xi2/cKKUgXpcyZAvvn7oKPJlmyYkwUXmL1TafB1MISXIVhx1MQWa
fPsKtSOYvHzOCmFmS/LBuQEBJOQvk4x3qt4YT59pcnuR00Tn6Hv2cIl7q7zFTr5C
Twz3zDlcR5iV5mS+PUhKvwiS5trMB3+SJzz9fUP/AhSe39ojfnWDVRoNo5WjZkeO
dwuFm6PEN3cqN4ljj2NAoT3VbiMomcpjl4W1HJuoeDR8q6yCfYe4xNmfpLQnP6jP
sV/mUbvdCs7eiRUoPYwticI6NYYFzMuhHEIZ2kJ1EpYQzbYMkG8=
=EiJn
-----END PGP SIGNATURE-----

--a6hqz3juwskhopve--

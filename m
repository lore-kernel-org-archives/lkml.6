Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeD0Jt6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:49:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40746 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757800AbeD0Jt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:49:56 -0400
X-Google-Smtp-Source: AB8JxZrxtC9XsLJ6/WVm3m5h3jOHSLgWnHtAt2/nJ2xYWpFrDRBsmV15r//5hHEylNe5p9CwpJV1pw==
Date: Fri, 27 Apr 2018 11:49:53 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] iommu/tegra: gart: Constify number of GART pages
Message-ID: <20180427094953.GN30388@ulmo>
References: <cover.1523304324.git.digetx@gmail.com>
 <954659be6760130f6ffd5e733db2ad58cbb8e6e4.1523304324.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Content-Disposition: inline
In-Reply-To: <954659be6760130f6ffd5e733db2ad58cbb8e6e4.1523304324.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qYrsQHciA3Wqs7Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 11:07:21PM +0300, Dmitry Osipenko wrote:
> GART has a fixed aperture size, hence the number of pages is constant.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

This doesn't really give a good explanation of why you want to do this.
While it is certainly true that the aperture is fixed in size, I can
imagine cases where somebody would want to restrict the aperture size
(perhaps there's a fixed mapping somewhere near the end of the mapping
that Linux shouldn't touch, or the GART aperture could be reduced to
simulate out of IOVA memory situations).

Without a good explanation why this is necessary I don't see why the
current code should be changed.

Thierry

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri8kEACgkQ3SOs138+
s6FctRAAoUkhihlrmgwWCXP1zK7QT3+qpmdYyr1JNLF4i+0x73Qb0/wPoGu89JNV
EcjSkaOIm7SQN+pvvPQnbKVuIJYM1PDKIdC+XNEtOTkDmfx2vhWL/X4sXnth+cia
aabuCK0Q5epsaUIS7cvpKgChuOwmNeKADI3WSWZEpI2etqeCo6xIQ3FB+3rsoQCQ
/eOzmk6eKsaySKFRLLWq8SmOjw8e3HFgU8OgHU1jk2vzACgn2kN8p4r7voV20MrF
Y6xdlySnVLaKkXNNtpjCZ51eOQkD34T4T3YaIf6aNwvv5TT3tiEvPk4zoHNq0/aB
o9vFOYc8F5IApoLAx4N1KKItk2F9HuvpK2DSqlQRH6VJqUw4PL1qu+8Rq6wWhofC
p4IR0iEcCa9NpHZrF3jAJdNhrOo/3vA2aFyOJwg7UYCFZIGd4gCNa24TZxlhp2Z7
6XDnqijmQHuQcl2wtvpwdRnpBXNQ5E2dvKpbNvRUsoPeD/1G25CaDySt2ol1mx3i
ebOtpYSJ+oH/qNz+Da6qjH/agVtBYYjvpT6kA9fAr5MnF6/d/vCmt5TbdYpb4tio
Y5mrcD488qIAifg6a1r/O2xq6v+q3h9NnyN4MNbibfuwRXaT+csBb5wYL9jlFC2P
okwV9TwsbaVbh1lOZlALGKKt2HGhJYED4qKxgLd4pfUlPiCMN8w=
=x0GZ
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--

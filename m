Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeD3IHv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:07:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41906 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbeD3IHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:07:48 -0400
X-Google-Smtp-Source: AB8JxZpi6ra/gosL6ac7cCUHZRZ89q3iogCyQ1CCC0u+/abtxt2p/CfSMjmTI9tarrWTjl9GSXU1PA==
Date: Mon, 30 Apr 2018 10:07:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
Message-ID: <20180430080745.GA2484@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <675f74f82378b5f7d8f61d35e929614a0e156141.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <675f74f82378b5f7d8f61d35e929614a0e156141.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:31PM +0300, Dmitry Osipenko wrote:
> Tegra30+ has some minor differences in registers / bits layout compared
> to Tegra20. Let's squash Tegra20 driver into the common tegra-mc driver
> in a preparation for the upcoming MC hot reset controls implementation,
> avoiding code duplication.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/Kconfig         |  10 --
>  drivers/memory/Makefile        |   1 -
>  drivers/memory/tegra/Makefile  |   1 +
>  drivers/memory/tegra/mc.c      | 120 +++++++++++++++++--
>  drivers/memory/tegra/mc.h      |  11 ++
>  drivers/memory/tegra/tegra20.c | 178 +++++++++++++++++++++++++++++
>  drivers/memory/tegra20-mc.c    | 254 -----------------------------------=
------
>  include/soc/tegra/mc.h         |   2 +-
>  8 files changed, 299 insertions(+), 278 deletions(-)
>  create mode 100644 drivers/memory/tegra/tegra20.c
>  delete mode 100644 drivers/memory/tegra20-mc.c

I've applied this now and squashed in patch "memory: tegra: Remove
handling of MC_GART_ERROR_REQ on Tegra20".

Thanks,
Thierry

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrmzs8ACgkQ3SOs138+
s6FuzRAApQnPwRJPJTDj4CPHW1c40336Q79dx5RPPDNoyugQoWk+YgqT7JT3bpV7
ZULc2dDSXd+UScWI1TZoM6sqW5HvdzTb5sCZ5740M296CrcsCPs/PE6behseQSJV
FL6uOxI3MUK4gC13K28ABZsz8aGCiWFAgOqJKPcR6nFKEsCUb6kYNKhMPKk55lml
gzLaz/eRTA0oBEiAjDJX+L0EfKvffXCNUaesvYd9453y15PYHXoqBDdJ+T9vQQhk
Fz860qU5pUllv+lemFsxsXftSCK8n0Ex+LVOwWF24gyMWY5h2KbngkDXQeytlzIJ
B83EKrevhsa9a4znaj2cMB6VCV15NTkHa9ZHNuR8ltxXelvk0qIeECHnWictdFD9
IX/JzzXdJ5V4FOeSp3hk982lIfmnrDkPKkpWZN2Byx0jQW0Z/N/QTdvb3aGlN/yR
wwF6Hwa3RPEV+pjmWqx7krxWyWou1Jnt75VdXXTtPq8u07SbyZD1z6ibylap+HS+
ALhkgqvL+L9v62VroQAeGg691eJqvUBGZYITs6v7OiDMmS1riMNCRL85vrQrYoYt
VfmEjpCA93HnbIQTiokC+DFjtjeDoE98qiS5f+8GqBK9A/M7ZWa62ipZUvHe+Q+S
TRv+xPASZ1eu9sydfQBNe2ygnqybgu7idMcVJibN/XkKy5HhJkg=
=CcR0
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

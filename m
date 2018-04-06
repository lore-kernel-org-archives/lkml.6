Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeDFXJb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753051AbeDFXJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:09:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61F120B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Sat, 7 Apr 2018 00:09:25 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>, Antony Pavlov <antonynpavlov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: vmlinuz: Fix compiler intrinsics location and
 build directly
Message-ID: <20180406230924.GB1730@saruman>
References: <20180403160728.GB3275@saruman>
 <1522833502-28007-1-git-send-email-matt.redfearn@mips.com>
 <b05a0ec9-d052-49c7-3e8f-2ba233d84f03@mips.com>
 <20180405214219.GA31336@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20180405214219.GA31336@saruman>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 10:42:19PM +0100, James Hogan wrote:
> On Thu, Apr 05, 2018 at 11:13:14AM +0100, Matt Redfearn wrote:
> > Actually, this patch would be better inserted as patch 3 in the series=
=20
> > since it can pull in the generic ashldi3 before the MIPS one is removed=
=20
> > in the final patch. Here's an updated commit message:
>=20
> Thanks Matt, applied.

Loongson1b/c defconfigs are still broken unfortunately. The .o files
aren't getting generated, apparently due to a different cmd_cc_o_c
definition when CONFIG_MODVERSIONS=3Dy.

I'm gonna drop this patchset from 4.17. Hopefully an updated version can
be applied for 4.18 after the merge window.

Thanks
James

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrH/h4ACgkQbAtpk944
dnpWAg/9HQbxFOZwOg2DY/r+KJC19kVdrzAkbkneRQhGKBAVNA2QoZjnwPzn8zVF
/Tm03zXyHDI4m7TLXXWnGjLFI5lMMQ5TFOLpQXpXgp33/zimTHo33PStNQT2v9Dv
3+AokX7BSPlYnlgmCtXXdreuD2bBKlED3hzcDbQ7ZHcJOXpXpgrkZwYJF4q3kAgg
HaQx2o415CE6n/Hyc5BBjRir6BeoHHKnADt3pM7/9oTKl6YtrXbBDTiDCsUtg5R2
fj0ye52jFVhGUgGAWANtclk/1T20riZNb+YQ2/XjuQ2+4tLFlSpoMdJNp0BLFlYu
JdlpO23wZeDqIixDcHXDAli3oqhqWF84e9vkw02n0pwhKha1316MaEu0RVpzoXeO
k64crb7AKqMPjOxq7KYuOdMDeXsBsTz1YwqkmdpicGU+qade+jIGS86hqSjHxThM
AdkjUZM77Gza5N4XgAa31oJc2bhqtpja9T8Pg6K6xx1Z/uWrP7ay3+ReYjiv59UW
e+vS/Zn3ICBZxM0nhYQYAWe0FSjZJh07DLLPi+fShomVEwkCGXqZ6xXF9IUWv4DZ
Ht0g7uKm2kST8oqq9+fTUPurEevneqIdHYqM5gCPsxhcSvO1Xy7tVpu4d4W3pmAB
QWQwovtDVcm8gHkGy/cEvBPLDvyk8clqLVMN/JXAwfrPk0xsukA=
=qaZb
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

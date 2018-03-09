Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeCILZo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbeCILZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:25:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA90205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Fri, 9 Mar 2018 11:25:37 +0000
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@mips.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/4] MIPS: Introduce isa-rev.h to define MIPS_ISA_REV
Message-ID: <20180309112536.GE24558@saruman>
References: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 05:02:41PM +0000, Matt Redfearn wrote:
> There are multiple instances in the kernel where we need to include or
> exclude particular instructions based on the ISA revision of the target
> processor. For MIPS32 / MIPS64, the compiler exports a __mips_isa_rev
> define. However, when targeting MIPS I - V, this define is absent. This
> leads to each use of __mips_isa_rev having to check that it is defined
> first. To simplify this, this series introduces the isa-rev.h header
> which always exports MIPS_ISA_REV (the name is changed so as to avoid
> confusion with the compiler builtin and to avoid accidentally using the
> builtin). All uses of __mips_isa_rev are then replaced with the new
> define, removing the check that it is defined.
>=20
> Applies on v4.16-rc1
>=20
>=20
> Matt Redfearn (4):
>   MIPS: Introduce isa-rev.h to define MIPS_ISA_REV
>   MIPS: cpu-features.h: Replace __mips_isa_rev with MIPS_ISA_REV
>   MIPS: BPF: Replace __mips_isa_rev with MIPS_ISA_REV
>   MIPS: VDSO: Replace __mips_isa_rev with MIPS_ISA_REV

Applied for 4.17,

Thanks
James

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqibzAACgkQbAtpk944
dnriTg//axat2ZVYjGpD1ArP8HiDNdFjSh35vumKNvnd4CGDFAgzMSzZV4bx+lGj
/sw8Go7PbTAfkmoi9CAixTeaxQSmAPZ1v9k3MDpRpUJk+5OjFbG4d0xzOHayg/fM
ETM7uuzSj16ee4DRcSgmfS30QJvSCcZFXWeVugM8Im7wCMeIQ5LWrxjTXqoFsc+/
URRgMola5oh7MvvduX1nPJuuk2Xk9YL9W/Qja8RDQqNTVTWDXWHGk4YFl0EFGZXi
RFRKJlMaK1fLkY12H0n0WxMzFoBkAYnNYq4cqDEKUW+cf0DbXQlYxc54YWd37BB+
opZkz6Ed84NI9NcyqLbMnDjqcrzULblhkJWAZ00NAAzNRlqdU+Iwv6mTDVzeAQZB
hr2IYi4bWunjzuvSnZTOx1eb+PYPZ8Y4gY10nPVmHDdXhI/g9SqVO5ojgmufLEu4
4Mafd7o2phX2Q1EstX6CIL/56DWSpITrpqf8OXISxumWHYwy0mehDRbuKIQZoMt0
8ilxvSa/Fohxeywc65vX/b7xKRLsAIczzctNDPoCeJgF6mlqLg331yV6/diBNDNV
NoaTvICCm/RnZ9AWiDvZVvZoTAP/Q5aVgP5uDwNlIcG3hphLZ3NwNIGgKZd2bSPb
yMJ7xh0OeGZazAuXXj/wuQCma3DWKxRGBEI0fQEqcf5Kz8pdi8o=
=FsvF
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeERJWH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:22:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36019 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeERJWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:22:04 -0400
X-Google-Smtp-Source: AB8JxZpHAEAaZRTG9fy79YxbYspG5Q79Zral0hh2GZ6pkHmI4+tYwsPfExR/Uw6yV8onblZrAaqcLA==
Date: Fri, 18 May 2018 11:22:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Emil Goode <emil.fsw@goode.io>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] gpu: host1x: Fix compiler errors by converting to
 dma_addr_t
Message-ID: <20180518092201.GL14500@ulmo>
References: <20180516102204.stviarlxgrz3k2nh@lianli>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zH41lVBEV8cLJnCl"
Content-Disposition: inline
In-Reply-To: <20180516102204.stviarlxgrz3k2nh@lianli>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zH41lVBEV8cLJnCl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 12:22:04PM +0200, Emil Goode wrote:
> The compiler is complaining with the following errors:
>=20
> drivers/gpu/host1x/cdma.c:94:48: error:
> 	passing argument 3 of =E2=80=98dma_alloc_wc=E2=80=99 from incompatible p=
ointer type
> 	[-Werror=3Dincompatible-pointer-types]
>=20
> drivers/gpu/host1x/cdma.c:113:48: error:
> 	passing argument 3 of =E2=80=98dma_alloc_wc=E2=80=99 from incompatible p=
ointer type
> 	[-Werror=3Dincompatible-pointer-types]
>=20
> The expected pointer type of the third argument to dma_alloc_wc() is
> dma_addr_t but phys_addr_t is passed.
>=20
> Change the phys member of struct push_buffer to be dma_addr_t so that we
> pass the correct type to dma_alloc_wc().
> Also check pb->mapped for non-NULL in the destroy function as that is the
> right way of checking if dma_alloc_wc() was successful.
>=20
> Signed-off-by: Emil Goode <emil.fsw@goode.io>
> ---
> v2: - Change the phys member type instead of adding casts.
>     - Check pb->mapped in the destroy function as 0 is a valid value
>       for dma_addr_t.
>=20
>  drivers/gpu/host1x/cdma.c | 2 +-
>  drivers/gpu/host1x/cdma.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--zH41lVBEV8cLJnCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+mzkACgkQ3SOs138+
s6E/pg//bHifSGSSjuLuoGSL2+fTU7b8n8NLFMy43WOwRNaOZWmQ23lGmSrTrSm8
4EhzWSrEFdKL4YR/n3r6EsaH2IZjPxEM2qd0+V525ZURbkfy/kOqPUGa6lf2THJ1
nGt7pDOZH6gZzqYfrkZygmrL5KbterkF9V39Mu77xehmP6BVKT2XGlXTbJCcl4cV
kPwUnTblvQAMstZWLr9WZKV54JSB93l1oiA4mgxIIrlNusu4itOefMyTj5BMKmj2
YVp8Dnw9cuJ0gJl3cbGpXL51aJzO5dqaBXy/Ws4l2fmR0Cp132DWZl1X5NOx8Bi5
4JLvc5+V+MdE19Ohntwok1qffUvRZj6xJwLuvCAuDSFiB5TnwsotMFxdMt/UULeg
qraPDDVJ10QaXchAgfS1w+d1ZdSDeDoWsvurdEfuy7vHV/IeZbOZBqRzoNie0wfX
jtDxd/dKSpPr9pkPuMuiT3RVSGYIiST8e0hmDlO5nJnx8rw4vyIWExKFNRKcjln6
o268mMhtRF0/Su0o565/sq99mhdZNJkkm/G/glzCcgFNcWUqsQYHLhHyP8iTD93X
00IUTlPmY7iJ2yIwq08hvhPkPNjrkZm2HwK1cx+CYB1iH6H1yzcRfUNyb67LeW27
JstXrXkcLR6LmzshZhloGkqaqCO8kyyfuAgmjbsC2U75j8nyJDk=
=EXzw
-----END PGP SIGNATURE-----

--zH41lVBEV8cLJnCl--

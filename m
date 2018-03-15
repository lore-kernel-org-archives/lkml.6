Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeCOK1F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:27:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41392 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCOK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:27:03 -0400
X-Google-Smtp-Source: AG47ELtusmXJZGYpCK8KT8gtV5ndg3/Vq4jGboUw9A6jYj1STuwQHpz2YKFALP4yREu6Ao9e5YLaMA==
Date: Thu, 15 Mar 2018 11:27:00 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] drm/tegra: plane: Fix RGB565 plane format on
 older Tegra's
Message-ID: <20180315102700.GA15393@ulmo>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 04:00:23AM +0300, Dmitry Osipenko wrote:
> Simplify opaque format adjustment by removing format checking. There are
> only 4 formats that require the adjustment and so this way is less error
> prone, avoiding mishandling native formats, like in this case RGB565 is
> the format that was erroneously treated as invalid.
>=20
> Fixes: ebae8d07435a ("drm/tegra: dc: Implement legacy blending")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c    | 11 ++---------
>  drivers/gpu/drm/tegra/plane.c | 21 ++++++---------------
>  drivers/gpu/drm/tegra/plane.h |  2 +-
>  3 files changed, 9 insertions(+), 25 deletions(-)

I've applied a slightly different version of this which doesn't rework
as much of the surrounding code and is therefore easier to backport to
v4.16.

Thierry

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqqSnEACgkQ3SOs138+
s6GLWBAAjVnw0dbXXghy0m5xpXQi+uwcqhbDv/imL5un0qIt3ZxcbdRM1WoGZwSF
090XlZi0/sQwCOR5TFZUPfbWOXqKI3YghMp5jcxuoRGbi51yzDS8US2VnA2A6gFb
VsPn7pgPgOyMibjVvQ+zLhK6XBQwW2I/ThEBuzqCLFSruDiGdPblC9JbtRKLRVkA
1Mb0faLhNZ1LlL/6H/YJ5YnaQ/JekVRbbSOOVCMyCXmUvpVvUTzJbQ5viNwJGp22
kO5YLa/WFwijndX7uUdVb77tO+g9WQ0N5Vnd000df/S+nsBV19SJunP2mgwpORf5
jwB707wqYwn+wJ16FsI22fLNcWLwTWgchP8fYkOr9YxRM9KEzRtz8pxJ/XqWG47b
SZ+Mif5cIXAvQ+kbTrKYuEUvmFrJLCZmanDw5zujnLVMl5fB+XMuDN3NRtSvOFED
FHiE54RlwwqkEY7mimYmf6FJbVnV5/qry0TaEAkGJPlYglihGWbRYx/8iXGlbM1x
AUvFSuWzr+Xlaruzf91RKvCQ6Bss5Yc6NKwoir+Gs0JZNbTM9OPMil9X1Wu8Bz5h
Mrg5fwSx/uw3KSX2vqFjQmDexSL9H5pt0ThIi9FauQmAtxQhg+gmVIS3JvkwRSMg
38TnqJtPtREAjlgUAIA74b6fq7IDcWHdLr/4OOTm9cBVwrVb2cc=
=rz7o
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

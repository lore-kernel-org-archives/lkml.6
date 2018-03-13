Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeCMXCB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:02:01 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53455 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeCMXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:02:00 -0400
X-Google-Smtp-Source: AG47ELuPRmHunv91IfMzaYHVo+FgD2NtFfdR9t7/AnZAYmFpGBlg5lCBaYdmSJoe1pcMx2ZXpzEszA==
Date: Wed, 14 Mar 2018 00:01:57 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>,
        Philippe CORNU <philippe.cornu@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: rm68200: add backlight dependency
Message-ID: <20180313230155.GC23414@mithrandir>
References: <20180313210015.3344380-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <20180313210015.3344380-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 09:59:54PM +0100, Arnd Bergmann wrote:
> Like many other panel drivers, this one fails to build
> when backlight support is disabled:
>=20
> drivers/gpu/drm/panel/panel-raydium-rm68200.o: In function `rm68200_probe=
':
> panel-raydium-rm68200.c:(.text+0x14a): undefined reference to `devm_of_fi=
nd_backlight'
>=20
> This adds the appropriate dependency.
>=20
> Fixes: 2b7ed18bed1a ("drm/panel: Add support for Raydium RM68200 panel dr=
iver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/panel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

This shouldn't be necessary. include/linux/backlight.h defines a stub if
the backlight class is not enabled.

What tree are you seeing this on?

Thierry

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqoWFkACgkQ3SOs138+
s6F1KxAAgCIdNvSanDaZsraJKVilggmVIvzKI7hmaujMiUc96ziuHHXeIyplWsHm
ZRjxlNyd9GLHz6zBbB/0SfQSM88gWYEtj/1r4sjh3wMPmh3kroEyaUjMOcuwl3J2
KzSdTEjTjHw0uv0VyuEneCADKOPEm7WEIZ0o4LaWY6fvVZf6fPAWw+0rCeBl3vk7
AZXIyhPV+qY9h6FGpF1tUG7RDgrj/8WUJSlsmWB2lCA6XoMikvdos+LCJ05Lvqob
eDgVj3jVTgTL/RSgrvhWBuYwM4A4Cm1CXAwwxhSnw9MDZsUvmTTfVYOfbVSb8smq
+5+FsHEmnF4+RjYArqFs4qTPGQ7HlZR79UvRMyPwIOIEgPwASp6of3US2oljAvmu
jfRMGm3n+uz8twiWoRLT91epTJCcwAInartuFyen8fq5iguCjapbDWj7A1B/KvY+
qBEkLV8cLGoa8c2ge9hw27xoneiP77p4KgkybB2PgluA8n07zaalt6rJRTdldpMN
hfS40DRQ8lMiEub772Y/PHi8gTYhuJTDP8sBX8ttaPHs2yKMYkzBas/e7foQKw8b
HeQXUyeKG6loXuYQXTMbmCXmEw6KtXj6k39cUglyL88pHGMf9UEYjyx81WWw4SAB
LRphzoYVX3o+pAWylS6RCJUpUKfUg/JPWIeBiHhVp8ANFwZHIrs=
=OYvy
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--

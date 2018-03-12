Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeCLIEO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:04:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37015 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbeCLIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:04:08 -0400
X-Google-Smtp-Source: AG47ELs7E+v2nF5UO79N+AU9eC64cS9e/M4N0OnA4QmX9g/DwnmGtrV8TtLliMr8yk/Vdea/VxZevg==
Date: Mon, 12 Mar 2018 09:04:04 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 0/2] drm/panel: Add support for Raydium RM68200 panel
Message-ID: <20180312080404.GE23060@ulmo>
References: <20180302153222.4377-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <20180302153222.4377-1-philippe.cornu@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 04:32:20PM +0100, Philippe Cornu wrote:
> The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280
> TFT LCD panel connected using a MIPI-DSI video interface.
>=20
> Version 2:
> - Add Rob Herring Reviewed-by on dt-bindings.
> - Update Kconfig & driver thanks to Thierry Reding comments: no more
>   DRV_NAME, DRM_WARN_ONCE instead of DRV_NAME where applicable, use
>   backlight_enable/disable() & devm_of_find_backlight(), no extra
>   gpio reset to 0, no more msg if successful, use RM68200 instead of
>   rm68200 where necessary.
>=20
> Version 1:
> - Initial commit
>=20
> Philippe Cornu (2):
>   dt-bindings/display/panel: Add support for Raydium rm68200 dsi panel
>   drm/panel: Add support for Raydium RM68200 panel driver
>=20
>  .../bindings/display/panel/raydium,rm68200.txt     |  25 ++
>  drivers/gpu/drm/panel/Kconfig                      |   8 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/panel-raydium-rm68200.c      | 437 +++++++++++++++=
++++++
>  4 files changed, 471 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydi=
um,rm68200.txt
>  create mode 100755 drivers/gpu/drm/panel/panel-raydium-rm68200.c

Applied, thanks. There were a few tiny things I wasn't entirely happy
about, but I fixed those up myself.

Most notable was the use of DRM_WARN_ONCE(), which is bad in this case
because it won't show any subsequent errors, ever again. I think in this
case the proper solution is DRM_ERROR_RATELIMITED(), or erroring out on
the first error, assuming that subsequent operations won't succeed
either. I went with the rate limitation.

Thierry

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmNHAACgkQ3SOs138+
s6FJPxAAkcVyNFgq6clEHSv/FUN5JRrV8NAYLAomWppOAD46e/9EekeQEPiPJ1zS
UWcUDu/xySAH+FlkIgecDeO6v+V2F56qBEkrRyxqXTGtBffv2Q/p/jDioDGUniMA
63eSn4OUeHv4FEAyx1k92gdCxKdNwGMFINMkMvAOha3MryXGp4UpRfkiv3jFDJdG
6XQyUSV4UCtw33GA32kkCMSINNFZZHtxGuav6MUe4ZV32wYNca3dNnuBDTb7Ucu6
oJyZvyiX56ZrHd1mWW3ehR5ilt+5fobZjzNwnUiipdVLO3j+aWjHzm5xxNrw0C3a
HPiQuN2oCF5Y7umnMpLVX/0jJPMKzCNV51nZJsWU3s1AoZ9jA5eqrrisVWGnlZC8
f5Wkms/1zjX8pIgsejD/QEZinKHr0SaX899MOPG4nbfBdtx52gNFVRiYereicmRe
YBvzDVxpQPlsKHR0N8vVCm+jjXcdi2UeFMgTlCmm7WIyExvU/MDzXB6hPquWW6zN
A9VF6lOUKIBw0q5dsg4VMa533p2LDvmeW0akXtL+nO6IZqJfAHKj2+wb6KZkayUV
J6iiDwvYPw2Q6ovmCtvcytH+S88CEiYMzt50g8B32H7SGSkeBIUlfIpBifiNwQT4
sn7l1ieNAEThrOkv4mLL20g2PYdDBARFp+VaGoCMpT7as96zcD4=
=w22k
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--

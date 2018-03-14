Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeCNLIi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:08:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51508 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCNLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:08:37 -0400
X-Google-Smtp-Source: AG47ELt8d/qBaMo6kth7mdcan9zfRUXrLMGLZ6ydwU8ctE3qZWjmsbuoWqIxMMcLUNE6YILAxX/bHw==
Date: Wed, 14 Mar 2018 12:08:34 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: David Laight <David.Laight@ACULAB.COM>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/nouveau/secboot: remove VLA usage
Message-ID: <20180314110834.GB8564@ulmo>
References: <20180313162411.GA1983@embeddedgus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20180313162411.GA1983@embeddedgus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 11:24:11AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA. In this particular
> case directly use macro NVKM_MSGQUEUE_CMDLINE_SIZE instead of local
> variable cmdline_size. Also, remove cmdline_size as it is not
> actually useful anymore.
>=20
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
>=20
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Use sizeof(buf) instead of NVKM_MSGQUEUE_CMDLINE_SIZE. This change
>    is based on the feedback provided by David Laight. Thanks David.
>=20
>  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c | 7 +++-=
---
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqpAq8ACgkQ3SOs138+
s6EoOg//S3oaA0fk2LHi/O5aXNHiK+EAqIjnb+tbwu5zji9AHXLyqvkjme5ZfwSl
YnAAH4gffi+93bHSVdC5gMAT02Lpep1wN/5O76dKRK25LZluMYK2ybAgC9LDeZeI
3j406OS3Fe/qYk5c0nj5vrRNAJOBVrkZ52FMhakc36896ZYu+aHqUkhdv0nYgYiF
+RQwtNldnTOOJ12WU+ZqCR7u/v5OAc+rOxsyuYozJHJ8JFE23hraxV15XIsRsizr
VjWD8aIUNnchlpGiiiN61f7h50E7kYi0ChprUcSQtmTO+xp2bgFVLKRFevCLu5kL
SckzSGzewvUCkTC18yFuwZbtHW948c1FrO1aveK3PvLtqGe1RwMe9nTz/9aRNJZu
+fLcNVD+5kDC4h8zcbdBDXfDxtAUcPZpDgv+xutUuVjN1cay+B7+EijwX2j7CCxC
JlMSsOVcSA7A8tIxqMCMPfQ9QwbX3W42B48CvvlP3hL1kiEOz4InXlqkR5p/yFRg
C6e2jpHm2xJV7RPIQGTx9efexCxgosUhV1k2YQiBzRheKJtuR29HATEvrC1xQla4
Xl971Tq5Ugbrm4hJlczsbz4T1dKBsPp6J3hSzcuJuWYzRMuG3zgcW1l1n3L08g8e
oC/yn42kH5jhaFJW8h0lBc63Era61OxSKPxoZCKqKe8WVKYfN8A=
=YxhP
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

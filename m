Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39FFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E2F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeGKISz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:18:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39526 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbeGKISz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:18:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A387820732; Wed, 11 Jul 2018 10:15:48 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73FF4206ED;
        Wed, 11 Jul 2018 10:15:48 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:15:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Liu <net147@gmail.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] drm/sun4i: fix build failure with
 CONFIG_DRM_SUN8I_MIXER=m
Message-ID: <20180711081548.nq2jekqt726aqmr2@flea>
References: <20180709160615.2686055-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtcckkykkmswe2lx"
Content-Disposition: inline
In-Reply-To: <20180709160615.2686055-1-arnd@arndb.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtcckkykkmswe2lx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 06:05:55PM +0200, Arnd Bergmann wrote:
> Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module result=
s in
> a link error, as we try to access a symbol from the sun8i_tcon_top.ko mod=
ule:
>=20
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko=
] undefined!
> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] und=
efined!
>=20
> This solves the problem by adding a silent symbol for the tcon_top module,
> building it as a separate module in exactly the cases that we need it,
> but in a way that it is reachable by the other modules.
>=20
> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible c=
rtcs")
> Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TC=
ON TOP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--dtcckkykkmswe2lx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltFvLMACgkQ0rTAlCFN
r3RRkxAAjD6N8e+9J8e7C4jnNp/UZTwIN3CYBIZy/G/4xIZP6sX5tTv1xETJ+TlO
NA5nGaleMZ4bKj8w2ngboKihvZwhJMc/K1PtexB7CBQ9Qz96DSUjTEufLa4zZqkV
/XqjYUROgRwZlSffOZpvMPQScH2UNiMdLGl0zo+huLQqk3ZI8ZzFEeJfD8LNjGPx
4B8l37K57/4tOOtuvVfE90o2ztTx920ulqAP/Q0DL6kLBHJFWMIhui3QVoswzfSI
nmrxQ8YWmY/7vyYOCmV+5d+rA9xOUdTg+OxbgsEsNcayp7b/NGMVO4Ak5Sn0E+kU
SkD4kEx/HaPwzPJd06BK69QJ9WwIby8R30qZ54Y6RPl+kKAXtvjLZPJpiSpaL4C3
a6OJ/14HH6SI27JWQQ+wKyIuna/1viFWVeBVu2lNhP0Hh6JKiIrfCvFi2GkYoAWk
XEJMnETWQ75ROnOw5UoZaAEXM9F+6sPxZkhY52lcScEXfkoH6GduFLJvm4QL9F/Z
GJ21+dyuglKzvoSJ6MOMXuGGxarcW3r9TgRpZAa1WHO1uOvokEewa+nBm2rI7FDQ
IFNVWqVDuh4JtH+sHiOHKpY0X8qiC0eO+Yvl2d7geeMR71/zNjsGOHKucoK1Ty91
iQ0NCfBBeBhTwBPMja9WMhut9AS8TC1glx/ZerusEJOs5dQShlA=
=j0yV
-----END PGP SIGNATURE-----

--dtcckkykkmswe2lx--

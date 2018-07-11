Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6069AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A20820C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A20820C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeGKNsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:48:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53408 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbeGKNsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:48:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DE7C620775; Wed, 11 Jul 2018 15:44:15 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id AC4CE20737;
        Wed, 11 Jul 2018 15:44:05 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:44:05 +0200
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
Message-ID: <20180711134405.yh4c5g3ckmqyldmo@flea>
References: <20180709160615.2686055-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lvfyoyhj5kxqjbuu"
Content-Disposition: inline
In-Reply-To: <20180709160615.2686055-1-arnd@arndb.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lvfyoyhj5kxqjbuu
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

Actually, this was conflicting with some rework I merged at the time,
can you rebase and resend?

Thanks! (and sorry)

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--lvfyoyhj5kxqjbuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltGCaQACgkQ0rTAlCFN
r3RQRw//XcMPa+wzaLsQpVmZR2R9XwpuZMjZS7Oxmu1htlCyRI2Yr/j3Zn7nSivl
FJqiEUjWFh8QsgnR0cP20b9JCJ2wBoTK8GCL9+nrYJovKCR+IVIZ6PDhLG0kmWqJ
ZVbXhk5UD3fKojPEsrLRPK+tQrT1DpaSffoKSVEozDNgPvEoLeFJ3pYV5BahGwVj
ECCAFB/4Duqza+cLx/JgNRkX4WFvBa/yXSPCIT75pxcvYmL/ZdfN/nGbOgtTQRZN
lwg9WZEF6XO/TWgbYj6+mbcWgMlt7Tpzdg9+Au4pL7WLngMOTJRM4DdRVC/yzxq+
ZNr+E4MtemQfKYrZkgPJ5oML3fB5eMpu6eXH9f+UuS6nJlkCBxOjME7Ydkt2ZuBJ
8Dlpn5ZDYT8YnLQTMdnmin4hM7GByQHWrH3eHX4OxgYtpYTyWBVvSFrU0I0UxXuz
i3f5RUzHJN0+NFVkHS1yhx48EDk9e+/Ak2e5+qky8Lsx6XTiIufA7pVuSprZq+Kq
t4UZxoiIYIbyyfjKW6qYvggQ4BGI+CICa4UtsYkUTb/1UOmABphdo/42DdeOfliX
dlAXtJs70cz8gkxAWPBVbfo8sug5PI0rwQ1rAbyNRPVr3+lfn9vRJBvapauwbDPD
anL7PeZM5jZfDgkTJUkBQ00WPtUe0O7rvoTMirRL7jwttFP6gNw=
=FAco
-----END PGP SIGNATURE-----

--lvfyoyhj5kxqjbuu--

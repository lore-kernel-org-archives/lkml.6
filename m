Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A62ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1404420877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1404420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGQQGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:06:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45223 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbeGQQGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:06:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6307220717; Tue, 17 Jul 2018 17:33:19 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 322C820717;
        Tue, 17 Jul 2018 17:33:09 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:33:09 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2] drm/sun4i: sun8i: Avoid clearing blending order at
 each atomic commit
Message-ID: <20180717153309.bhxw6gdeyz7lwq7s@flea>
References: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a5bmnfticdas2aey"
Content-Disposition: inline
In-Reply-To: <20180717122522.11327-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a5bmnfticdas2aey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 02:25:22PM +0200, Paul Kocialkowski wrote:
> Blending order is set based on the z position of each DRM plane. The
> blending order register is currently cleared at each atomic DRM commit,
> with the intent that each committed plane will set the appropriate
> bits (based on its z-pos) when enabling the plane.
>=20
> However, it sometimes happens that a particular plane is left unchanged
> by an atomic commit and thus will not be configured again. In that
> scenario, blending order is cleared and only the bits relevant for the
> planes affected by the commit are set. This leaves the planes that did
> not change without their blending order set in the register, leading
> to that plane not being displayed.
>=20
> Instead of clearing the blending order register at every atomic commit,
> this change moves the register's initial clear at bind time and only
> clears the bits for a specific plane when disabling it or changing its
> zpos.
>=20
> This way, planes that are left untouched by a DRM atomic commit are
> no longer disabled.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--a5bmnfticdas2aey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltODDQACgkQ0rTAlCFN
r3S0Yw//RtZqZal/rupm0nBsH7yHgbC9dTXAvMI0i4nX9y3hZwOExd82pREUpx7c
WL+JZcFyhRA2PmWqGPBVEL+1Ge4rGbZj4fn3YJD3LTn4TiFQFekRDeYUQQJ9u0Zt
6PZ5Fe/tFb9FOG2b7C62JMyKnT05JcCDKIh1vd29JtZiPoQTj0INBQi4K+f1D4fK
AAnJSH6k8Bj8xlaAZoHxvKwyruFC4cje/avZ9PD3r7mO4oBX+Xu0Ich+bM9YRVUu
r6dmT/if2I89whqJ0gPeIN1v7cBKcZKg9+/5DEVnQ5P8748yfAgUvE+TlwHV8WwA
VnFQe/jxmdDtEM4nKInhnnuWlt/W6JQKtEyWGVQI+GGbNO/aWIP2IvTgMGOkLBEC
6rxnUiLIkJ8GW/cIAnb5VuzE7OvcYiM91vsZBAstVMOt22rpryOZkcVKKetuB0hp
k4P7gpeNhEhiHPrm4NxsexjADqNoe9PQ59j3AHe/LvrtIx2u+a3jcx76OkqbBe4z
SgpZ6c7g7gns2ROR8cIgLLtyVLG4ITSYPka1EkxJb6GGbwpU9FQg9oY9UXBxpOYq
TAPjqXcxGvAK3xVB5181lgzQC2ctLAZeL9k7gppp8tQPhG8ZZkC9/F6+EPZqBZ6z
DqalGbflswI7o4KZDv86fOJR2yO534gN/9co/ChEt3DL2vpJxL4=
=w5Ux
-----END PGP SIGNATURE-----

--a5bmnfticdas2aey--

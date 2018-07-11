Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB3CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ABA20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ABA20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeGKJdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:33:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43211 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeGKJdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:33:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 87F2720739; Wed, 11 Jul 2018 11:30:26 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5407B20732;
        Wed, 11 Jul 2018 11:30:16 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:30:16 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
Message-ID: <20180711093016.bcnsnogbj26azoo7@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180711083036.7attjq4hm5ay5gmn@flea>
 <2406320.TaIT7vHipu@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2i47dnbrxp5mgx2c"
Content-Disposition: inline
In-Reply-To: <2406320.TaIT7vHipu@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2i47dnbrxp5mgx2c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 10:41:54AM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard napisal(a):
> > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > This series fixes several issues found in R40 HDMI patch series after
> > > it was applied. Conversation can be found here:
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/58601=
1.htm
> > > l
> > >=20
> > > Patches are based on latest linux-next (next-20180710) and are ordered
> > > in such way that they don't break R40 HDMI at any time. Because of th=
at
> > > I suggest that whole series goes through drm-misc to preserve that or=
der.
> > >=20
> > > I also tested those patches on H3 to make sure it doesn't break other
> > > platforms. However, it would be nice to test for regressions also on
> > > older SoCs (with DE1).
> > >=20
> > > Best regards,
> > > Jernej
> >=20
> > Applied all patches but the patch 10, thanks!
> > Maxime
>=20
> Ok, I'll send patch 10 separately. However,  patch 4 needs a fix accordin=
g to=20
> test build robot:
>=20
> if (IS_ERR_VALUE(index))
> should be:
> if (index < 0)

Yeah, sorry, I forgot to say it, but I fixed it locally (and the
return below as well).

> Additionally, due to Arnds patch merged (drm/sun4i: fix build failure wit=
h=20
> CONFIG_DRM_SUN8I_MIXER=3Dm), sun4i_tcon.c needs additional handling if TC=
ON_TOP=20
> driver is not build.

I'll drop it then, I haven't pushed it yet.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--2i47dnbrxp5mgx2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltFzicACgkQ0rTAlCFN
r3TQTg/6A8zff6ACPntglkg/UsbOyQbI4AOEX0zkwlHl6huT9/gBPWw1rdG29GY/
jUDkyyIxRMBTQAFW+4eBygfNnnsOHb/gJypXtl4I4tzgRnvzzFzQXd7xa+ARoEKX
ij6SYjYKDzk/M4boJILeAllt23LF/pCdP8ycluY/0PwZubbSrXYHIST+uszA8Opg
X6A/2V9ZeSl02izmRuQiDLHgVJqzGwZLmWfIVZWWtD88aUBXfid0VRfGcTH0lJuJ
zKa/xfB1DMjZc+clIy9tNuTjlZtQFwuoX+LReEOIk9OFKFeu0Ia2GFMvEKH4bW1E
c5/PNqeMtJVywROfkKE4Ujq60eXH7iU5AeYxI14/v+v6YJoFWSQADVIrUsmylkML
UW7uXbJPQdQgA2OdmknKubrPYibIQJsIS1QGH1J4izD18P7Vr5GO9MBCmL5+n9O3
ldUNinfKn3EwHrPMgZt0McXX6cNQrmQtV1VdoBzoj5qEQJfe6rNfUEKg48k0ZTys
KcAwRAlwxKnwksPf4j6TfjW2MSUa8uDdnBZcY3WYk8xDZrT3S8QUer58ofLlpout
ocFxmaeBBy+KCCMoCt0wHXRK05TDBdAxGiAUUratdaBhEnGqMgG150xh+RWs/M3c
reXmKl23TU4PKRkO2QTlDxZCWArsp5sx+Pf7ZHFdRfUx85fQGwM=
=DsbC
-----END PGP SIGNATURE-----

--2i47dnbrxp5mgx2c--

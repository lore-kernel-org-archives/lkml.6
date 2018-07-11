Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7E0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6366320864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6366320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbeGKNk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:40:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53270 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732469AbeGKNk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:40:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3928520775; Wed, 11 Jul 2018 15:36:04 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 086222072C;
        Wed, 11 Jul 2018 15:36:04 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:36:03 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, wens@csie.org, robh+dt@kernel.org,
        airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
Message-ID: <20180711133603.xfc5fxkocdl4okca@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <2406320.TaIT7vHipu@jernej-laptop>
 <20180711093016.bcnsnogbj26azoo7@flea>
 <5673885.I9ZBC4zXdg@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hnnak6lg7buneo2o"
Content-Disposition: inline
In-Reply-To: <5673885.I9ZBC4zXdg@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hnnak6lg7buneo2o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2018 at 11:34:58AM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 11. julij 2018 ob 11:30:16 CEST je Maxime Ripard napisal(a):
> > On Wed, Jul 11, 2018 at 10:41:54AM +0200, Jernej =C5=A0krabec wrote:
> > > Dne sreda, 11. julij 2018 ob 10:30:36 CEST je Maxime Ripard napisal(a=
):
> > > > On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
> > > > > This series fixes several issues found in R40 HDMI patch series a=
fter
> > > > > it was applied. Conversation can be found here:
> > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/5=
86011
> > > > > .htm
> > > > > l
> > > > >=20
> > > > > Patches are based on latest linux-next (next-20180710) and are or=
dered
> > > > > in such way that they don't break R40 HDMI at any time. Because of
> > > > > that
> > > > > I suggest that whole series goes through drm-misc to preserve that
> > > > > order.
> > > > >=20
> > > > > I also tested those patches on H3 to make sure it doesn't break o=
ther
> > > > > platforms. However, it would be nice to test for regressions also=
 on
> > > > > older SoCs (with DE1).
> > > > >=20
> > > > > Best regards,
> > > > > Jernej
> > > >=20
> > > > Applied all patches but the patch 10, thanks!
> > > > Maxime
> > >=20
> > > Ok, I'll send patch 10 separately. However,  patch 4 needs a fix acco=
rding
> > > to test build robot:
> > >=20
> > > if (IS_ERR_VALUE(index))
> > > should be:
> > > if (index < 0)
> >=20
> > Yeah, sorry, I forgot to say it, but I fixed it locally (and the
> > return below as well).
> >=20
> > > Additionally, due to Arnds patch merged (drm/sun4i: fix build failure=
 with
> > > CONFIG_DRM_SUN8I_MIXER=3Dm), sun4i_tcon.c needs additional handling if
> > > TCON_TOP driver is not build.
> >=20
> > I'll drop it then, I haven't pushed it yet.
>=20
> Which one? This series or patch from Arnd?

Arnd's

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hnnak6lg7buneo2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltGB8IACgkQ0rTAlCFN
r3QYJQ/+P1yS3MgYDX0jTqbk2BULEKMMiWss7TqkoiI/xkQXSUPdT1GW2FwPLjl0
JRplz1FoX/KnuM6Ii91Fp1gftkzv6Od/g2mp5d8D4GM1DZY282rVDO0+GhZNM5LB
4e/4Hu31RmONkRn7uDpJJmaffQVb25ReZCBH6wss3XRtL2m5fP9/7fSwzgCjK/ed
PvowGDR2tMyNP1PTaOLOSHY+T7WNocgwLRu0ROqw5NNriBLhQaY+Q/GHfsaVkFO2
hlC0C9OcAfVZGI1jVROlVDPuUnSYVwZ15C2+QENGX+RjZ4oF5tpscLwIcvSiH6U5
uW5P3OxPDNvKsa54ruPFHJ1hP3fjrFtSVJTVLXjfUu8Owm2vdOGMwkw5Wo84htiY
6Ouc9wjQCjv+ydoF+jX/TO9qifYcA70pA09DzAAbeWVcSJFBDQFEZCi+65FqHRiC
NaFJcxBW52wKdtDd7hsAod8J5woqAu98TNrN0Oe7OPukFKP2Sx/+61zr4nnPJANf
QXkY5vjXteVEJ+s4KSBqTu6KoDZymziidXiruBng86k5qMf9+qhThqAlC321FivP
4VzV58e4svieFzACUplWp9EEnBP+ki+7KPs5/aCuBkjMkckkxTQuWWYR1VYfn/Hx
AploudqjQ5uGCY0CpCP8AGSSo6DQlu8dNO8Gm5kwzIghUeVVA+Y=
=Gt5C
-----END PGP SIGNATURE-----

--hnnak6lg7buneo2o--

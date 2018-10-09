Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539C9ECDE39
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2453C21502
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2453C21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJIXLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:11:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56601 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIXLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:11:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 975AE207C8; Tue,  9 Oct 2018 17:53:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 62F5120618;
        Tue,  9 Oct 2018 17:53:47 +0200 (CEST)
Date:   Tue, 9 Oct 2018 17:53:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 10/29] drm/sun4i: Rename DE2 registers related macros
Message-ID: <20181009155348.exmeyvvelxwnv3b5@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-11-jernej.skrabec@siol.net>
 <20181008101828.hb4xtppbexwalbkk@flea>
 <11072788.dZi9MDiihb@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qlwprrpwi56itdhx"
Content-Disposition: inline
In-Reply-To: <11072788.dZi9MDiihb@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlwprrpwi56itdhx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 04:28:41PM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 08. oktober 2018 ob 12:18:28 CEST je Maxime Ripard napisa=
l(a):
> > Hi,
> >=20
> > On Sun, Oct 07, 2018 at 11:38:46AM +0200, Jernej Skrabec wrote:
> > > In preparation to introduce DE3 support, change prefix from "SUN8I_" =
to
> > > "DE2_". Current prefix suggest that it's valid only for one family,
> > > whereas in reality, DE2 unit is used also on sun50i family.
> > > Additionally, it will be easier to distinguish DE3 specific macros by
> > > using "DE3_" prefix.
> > >=20
> > > No functional change in this commit.
> >=20
> > I'm not too sure about this one. There's basically two ways to look at
> > this: you described the first one, and the second one would be to
> > treat it as we do for the compatibles: the IP was introduced on one
> > SoC family, and then got used on some other ones.
> >=20
> > Trying to always match the one you have however have a quite big
> > maintainance cost, as can be shown by your patch: you always have to
> > adapt comments, function names, defines, etc. This creates a lot of
> > useless churns (ie, non-functional changes) in the drivers, that need
> > to be written in the first place, and then reviewed.
> >=20
> > It's just not worth it.
>=20
> Well, using family neutral way would mean that there is no need
> anymore for adaptation in the future, but as you wish.

If you consider only the DE case, where it has been numbered by
design, yes. If you consider all the other controllers that haven't
been (like, SPI, or the USB PHY, for example), then you end up with
two drivers that are using the same names, with no easy way to tell
which is which

> What prefix should I use for DE3 specific registers?

We should just follow the same pattern, and use the first family where
it was introduced. So sun50i, I guess?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qlwprrpwi56itdhx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu8zwsACgkQ0rTAlCFN
r3QqwQ/+IoZy8t7aGMla11oE/6yNeaFJ34IxjnNbHLImveD7Ovr9f5ba3XSoQpxX
AX83BsNpV0Y3c42ZOIAE5O1sJ9dO0P9YAQXsWIhtglWpt6PByfJ6fP6oHmV2Oacn
4THjYt00r1vGtrjU9RpTVQ5deR1dLTLobPc1pB0gTCzRn3W7mnqdMs2p/yT2SMyT
sPqwmVvK7flMM1B/h6yG9nzTsWzj4Xh64+Y7w+eviUUVqS7PpL5yG+y2zFeag3rH
3KYKqWzaewOisFJZhHv9T/Q3NC1XXdNn8Dv4fg3i6zcPJFxi1oWFp44PXEMHEJsd
3FtTxLSbk8IvYSRWkd+qVKLKngstpA97wJ84MTpRaEeIVk39vwBYRuvQwwG6aior
+1juz0zdqLmDihnNfo/JhyEd8z32CPOxSAJBaWz9AspFynHtS17vM0qzFupQfiSK
w7iCl8cplcfoFRJj+qFexAzPeL6Q3HSNRu0nQJ/hRnXQs3QbXFNWalHJ8R9slzH2
S4hsP7X9xGx55xZEQM23CtHve1zMQ6uZPdJ8ncRmkFsAA6OL2YGCVTEauSxa8bge
dXD7ZMm3+ucSJ6c4jRFJb9VL13FVFxgYYn9u1HcY9B7DK97Y1UldMP4jHs+SQFGy
SI1gafvdOxtaIaATXp2SbPmAoh3PjKgVLr//lAjul9m822mnxLU=
=VJae
-----END PGP SIGNATURE-----

--qlwprrpwi56itdhx--

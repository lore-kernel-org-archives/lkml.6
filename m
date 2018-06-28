Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34237C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8638270F3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8638270F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeF1Ilv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:41:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39863 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeF1Ils (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:41:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0240F208C0; Thu, 28 Jun 2018 10:41:46 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id C1EDE20703;
        Thu, 28 Jun 2018 10:41:45 +0200 (CEST)
Date:   Thu, 28 Jun 2018 10:41:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/24] Add support for R40 HDMI pipeline
Message-ID: <20180628084146.ttqshyiehjj5by3k@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180627180215.y5kvvdqeriadxwte@flea>
 <20180627195043.hfasvppfm2cbudx7@flea>
 <4275695.oLYl8XEDF6@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4mqqv2i6olj3uyyi"
Content-Disposition: inline
In-Reply-To: <4275695.oLYl8XEDF6@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4mqqv2i6olj3uyyi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 10:25:37PM +0200, Jernej =C5=A0krabec wrote:
> Dne sreda, 27. junij 2018 ob 21:50:43 CEST je Maxime Ripard napisal(a):
> >=20
> > On Wed, Jun 27, 2018 at 08:02:15PM +0200, Maxime Ripard wrote:
> > > On Mon, Jun 25, 2018 at 02:02:40PM +0200, Jernej Skrabec wrote:
> > > > This series adds support for R40 HDMI pipeline. It is a bit special
> > > > than other already supported pipelines because it has additional un=
it
> > > > called TCON TOP responsible for relationship configuration between
> > > > mixers, TCONs and HDMI. Additionally, it has additional gates for D=
SI
> > > > and TV TCONs, TV encoder clock settings and pin muxing between LCD
> > > > and TV encoders.
> > > >=20
> > > > However, it seems that TCON TOP will become a norm, since newer
> > > > Allwinner SoCs like H6 also have this unit.
> > > >=20
> > > > I tested different possible configurations:
> > > > - mixer0 <> TCON-TV0 <> HDMI
> > > > - mixer0 <> TCON-TV1 <> HDMI
> > > > - mixer1 <> TCON-TV0 <> HDMI
> > > > - mixer1 <> TCON-TV1 <> HDMI
> > > >=20
> > > > Please review.
> > >=20
> > > I just applied it. It didn't apply cleanly, so please make sure it
> > > does next time, or at least state what the dependencies are.
> >=20
> > And it didn't compile either, because of the compile error that was
> > reported to the previous version by kbuild... Those shouldn't be
> > ignored and simply fixed.
>=20
> Sorry about that. I forgot to rebase and had same linux-next base for all=
 3=20
> versions.
>=20
> I actually take a look at that kbuild message, but it just didn't make mu=
ch=20
> sense and it worked for me without issues. Merge conflicts would explain =
that.

This was happening when the driver is compiled as a module, which is
pointed by the config attached to the kbuild mail. And asking is
definitely encouraged when you're confused about such things, ignoring
it on the other hand, not so much.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4mqqv2i6olj3uyyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAls0n0kACgkQ0rTAlCFN
r3SjEg//XPoaakL1HuR6pou4aBAC3wBTH0xzen/xOcnlwBSrjqVJix2BoYYgTxED
RTIzeQDU3S2r0VWarPej/LDsu0/qk1CLiB5/fVUvNsVDTzcRtaqgRJWCAkFlFcvG
lIphwo1nHZeJPmEBn9DsM/DN1svHIjlpbgiJXTHlpCtX/PgWZOghTKqySAbICCOF
7XBO6OSW/IsG+4QEZzogVYOEbX25x2uzKcZTH3K2MjHoZN3k1tosz34h0BiBrDls
PhJiYCC8UOfXQAHE6ZeA8B2z4F4V8GhE4WbI55voY1hrEWfDGVQySSM3dxrOwsbN
3xkCQgRcMM/0qqR7849AADN4iTo+6HZUEW9qHZA5Wjeu2ua7Qn47mPS2D0tU34ut
YAAR2D+aIHLgX4W8VXy2xBZmmE0CsCmBs6+kXPqQDdGCeJ5oVjoK8Bvfw1Q7bfgU
Gr2L1aXKh7QgIZs3ecc+tm9RJe13wHTMz5o1GgegN0CEiHA1S0rqquRScK+JH2Qm
kjpRiEENkb1u9LTDemOHsnRYHAJTGxpfl7Vfi6HVwIij0uKxrGFWkMvqQXYBviXA
gbBDAyUbyo5osnO+t9RWxfQ0v7yOMN8AZ+5qiB8cccx1Xjl7RLvAFcTThtRv+IUz
R4WLG3/74LLLj1CemxQi2r9In0ammee7VmyoOHrES1vzxUVG4lc=
=sNCe
-----END PGP SIGNATURE-----

--4mqqv2i6olj3uyyi--

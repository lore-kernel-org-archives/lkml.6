Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA9FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C512525A11
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C512525A11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965955AbeF0TvA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:51:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51591 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965654AbeF0Tu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:50:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 840D9207F3; Wed, 27 Jun 2018 21:50:53 +0200 (CEST)
Received: from localhost (unknown [88.128.82.6])
        by mail.bootlin.com (Postfix) with ESMTPSA id 44313203B4;
        Wed, 27 Jun 2018 21:50:43 +0200 (CEST)
Date:   Wed, 27 Jun 2018 21:50:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 00/24] Add support for R40 HDMI pipeline
Message-ID: <20180627195043.hfasvppfm2cbudx7@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180627180215.y5kvvdqeriadxwte@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bezsy6kupmrzsenq"
Content-Disposition: inline
In-Reply-To: <20180627180215.y5kvvdqeriadxwte@flea>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bezsy6kupmrzsenq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1;5202;0c
On Wed, Jun 27, 2018 at 08:02:15PM +0200, Maxime Ripard wrote:
> On Mon, Jun 25, 2018 at 02:02:40PM +0200, Jernej Skrabec wrote:
> > This series adds support for R40 HDMI pipeline. It is a bit special
> > than other already supported pipelines because it has additional unit
> > called TCON TOP responsible for relationship configuration between
> > mixers, TCONs and HDMI. Additionally, it has additional gates for DSI
> > and TV TCONs, TV encoder clock settings and pin muxing between LCD
> > and TV encoders.
> >=20
> > However, it seems that TCON TOP will become a norm, since newer
> > Allwinner SoCs like H6 also have this unit.
> >=20
> > I tested different possible configurations:
> > - mixer0 <> TCON-TV0 <> HDMI
> > - mixer0 <> TCON-TV1 <> HDMI
> > - mixer1 <> TCON-TV0 <> HDMI
> > - mixer1 <> TCON-TV1 <> HDMI
> >=20
> > Please review.
>=20
> I just applied it. It didn't apply cleanly, so please make sure it
> does next time, or at least state what the dependencies are.

And it didn't compile either, because of the compile error that was
reported to the previous version by kbuild... Those shouldn't be
ignored and simply fixed.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--bezsy6kupmrzsenq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsz6pIACgkQ0rTAlCFN
r3QHyw//UA9Nx2FAEMfBfKNdc8cDdb5MMoAGgXg8uqNDSjuj5BhCPwiqE6rLZSTS
beJSkjmLfBR0CauhVv53vwmGOveNd2Uz0saS3FZY4bO/jLAmGOpB7na0Hlq3pZYH
sBuzFTkxollAkHohikoG1avNV2dBDfeFB+RfQ3ElcyJ9C8Bt/dphy4d0Ea4dRSMa
NZQ9fJvjPSaKOEFWWOmT6kbvAwkaEgg4g7q3nYltdF3Mlk9tWE5ZaGTRYClXenpb
HZoUf0hXSTEs8Ls5CsQlZJvSxmisPJ2OY1ByYxAKVjYZAw0EWMs7rg0/2lA4SvM4
OxswQm4XhB/e0Dtn87OVn7q7Vz0nCZO23g2GBVDTIzTGsfRn8f+3Ma9glcKZsyDL
HqdOKrJ0zROS0R6AIMa/OVu46DC+ajUn3w2/h/aBkP8KJfdaN+MqWtDEGOYmq68o
wDiz3Dgz3WOg3YLPM8p/94fopkEfihaeRCa+7Drt35Tfo3bI0rB7KIenzLehLnmt
Pvu7wDOk5OJiW6u4LU0TLsUoEq4Dd62xhBkyvM7cm6Stn6O13Hnhsn5imTK48hYJ
H6QmGW4uEFkXRfYGcQx5WY4IcD7zGNGlcNuCMjhMmvegTY75U1DFgS1W6jsu8hEu
NtOK2+L/SsRdksyyUj9rhMQXn/wJhYr45rn/a4pKAJCLvxhJa6E=
=L764
-----END PGP SIGNATURE-----

--bezsy6kupmrzsenq--

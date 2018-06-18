Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA1BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FA920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FA920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966538AbeFRJX2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:23:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53278 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966332AbeFRI1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:27:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF20620798; Mon, 18 Jun 2018 10:27:06 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 946BD20012;
        Mon, 18 Jun 2018 10:27:06 +0200 (CEST)
Date:   Mon, 18 Jun 2018 10:27:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
Message-ID: <20180618082706.jjklq36jeu3nqs2q@flea>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m4crjbjbuqxcciob"
Content-Disposition: inline
In-Reply-To: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m4crjbjbuqxcciob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:16:47AM +0200, Paul Kocialkowski wrote:
> This reverts commit 2c17a4368aad2b88b68e4390c819e226cf320f70.
>=20
> The offending commit triggers a run-time fault when accessing the panel
> element of the sun4i_tcon structure when no such panel is attached.
>=20
> It was apparently assumed in said commit that a panel is always used with
> the TCON. Although it is often the case, this is not always true.
> For instance a bridge might be used instead of a panel.
>=20
> This issue was discovered using an A13-OLinuXino, that uses the TCON
> in RGB mode for a simple DAC-based VGA bridge.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--m4crjbjbuqxcciob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsnbNoACgkQ0rTAlCFN
r3StnA//fZ4BBAsibltVNFsbllO/joCK3Ae7sE6XPcwCChhBlgPQ9/PZ/Pp01p4j
E0x3uE9zi+4Ie7KeCdSufbB+b2jBVJsGLtn9yfeBzQ/HP5s4CdvflwTJVcIBOUEQ
vhAu6pis4LzD+f4I6AKRCF4MhVZFFB5njbpIQ8ldngClQsPEX6RiypOPpIskRUUH
kge/lwGv/fESQpLiQJ0OkFVyE0XrkIx31vYKIiH6CB34JZJMHz9MyjXIUahaVFTg
n5hdOn1nNt2o11HnYkmkocuZnSTtrQdhlwrFss5ViBeDAp8+l/ac7v6lfiXxMBTH
Ip81rTnXkL7xQuPSdAkRD9EDtVZjUNIBNPDDAM6cqRAlcegnM14ThafBEJQ4ZgMg
vBTGLMxYAb5a+OjTo5WUNm/HoVdiTGelG3wZ565VTFqIJPr7gl8qRGZ2AVRm+UfT
sfWeOhaWhsgZ1/TB7NxJ0s50yMdoH1srJA7FelNsnW+kwx/yjw7Fq72d7tSxkR19
2aMsQDSpgKDGTSfbQjye92XlqJSdbuyys3u45AlA3So8RijvaRqo7+J/3zDf6pFK
JKxlagZ7ISgKlBJwBd7mO5XP83+TZ9Sw8+pymV/+OvYo/G2Pj633QrYcyDOTvPpo
/Oe84mqCLeCuS2xNJKhMrMOw+5LKcAHiig8NlynQ6QQmt1dNeMk=
=r7ix
-----END PGP SIGNATURE-----

--m4crjbjbuqxcciob--

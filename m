Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEFFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3193520645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3193520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbeISPKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:10:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43442 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730688AbeISPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:10:04 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 82E8820798; Wed, 19 Sep 2018 11:32:59 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53B4C20795;
        Wed, 19 Sep 2018 11:32:49 +0200 (CEST)
Date:   Wed, 19 Sep 2018 11:32:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/4] Fix A64/R40 HDMI PHY device tree binding
Message-ID: <20180919093249.lkjoaki6bi6ieyht@flea>
References: <20180916043409.62374-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7g7ukbp3bqtwy35t"
Content-Disposition: inline
In-Reply-To: <20180916043409.62374-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7g7ukbp3bqtwy35t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 16, 2018 at 12:34:05PM +0800, Icenowy Zheng wrote:
> When adding support for A64 HDMI PHY in 4.19, we assumed that the two
> PLL-VIDEOs can both feed the HDMI PHY clock. However experiments show
> that the mux bit discovered in R40 blob is not applicable on A64. This
> is not discovered, as normally with a single display pipeline only
> PLL-VIDEO0 will be used.
>=20
> In this patchset the second PLL is dropped, and a binding specially for
> R40 HDMI PHY is added (which seems to have the mux).
>=20
> PATCH 1 is dropping second PLL for A64 HDMI PHY, and PATCH 2 to 4
> are adding R40 HDMI PHY binding, as R40 behaves differently with A64
> with this.
>=20
> This patchset targets v4.19 fixes tree, because the binding is
> introduced in v4.19, and if we don't fix it there a wrong binding will
> be left in a stable version released. A64 display pipeline support is
> not yet in v4.19, but R40 support is in it.

Applied 1 and 4 as fixes for 4.19, 2 and 3 for 4.20, since they are
not fixes per se, and the R40 display engine is not enabled in 4.19
anyway.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7g7ukbp3bqtwy35t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluiF8AACgkQ0rTAlCFN
r3RaAw//YLqqhPetvvB7J9Iks0Cmu4R84IAfdn9XQLNI8U7KaFJW90RQTg8EELUX
POCmmXx70uWh1Jo04bl6Q+gSIfEO/PLUakgQiPk9p3FREWs+JG0fsYDLRb6jaVMr
0qBHBdGONSOCnQx1fTejQ6oLUzJo5pz9Zz1ZcXr5y56/NeRN6YncIwnq7bwiBdLo
4Xtv1sGrOf7zkzYsSegPe27QJilF8cv3Nhjnd1UGH1h6jDrZqf3ahsUL/XFgBa2O
JE01KOZ/DeV7ZNBnRgsuhNNsDJKTQTw6ii26uvpZAR/+Fa27DagPc4DJi4kyV/uB
PAHAm3yMlWSecDfPLpFA4EmSjIOkJTieGc0HUowf5UqZeyG5CKiE8k87jQmCdcGm
SEouRTYXakk3EcR3qTeZ/z2vIS96rIvauWbp7fOL7pIxN2j5pfEhPFlFvvrdAwUt
b/2LMzOsArNTBuwvOPFTMol9kiZGvNXlwJv1T3RR7EDNtr14fvPTWPNCr48xRl0p
ENNKZOYkXlG2hKBocKNhI0jmjM/1XvA3DBTXX8V51I/Tv8vgXVgs2TgLhAfVsk5L
6kRHS16OQgn3cIaVg+vjV9QWYASei7wKeNm78gcdqbNhqR3teqEkF3nNcQNyvi+e
WgbW1g+L97J3oOWU/1/YMUXygtUnuhDYzxg7nnGqPXP56rkDMMc=
=gOnr
-----END PGP SIGNATURE-----

--7g7ukbp3bqtwy35t--

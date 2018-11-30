Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80323C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48562214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48562214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeK3Tzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:55:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46308 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbeK3Tzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:55:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C5D0B20741; Fri, 30 Nov 2018 09:47:08 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6FE67206D8;
        Fri, 30 Nov 2018 09:47:08 +0100 (CET)
Date:   Fri, 30 Nov 2018 09:47:08 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] media: sun6i: Separate H3 compatible from A31
Message-ID: <20181130084708.rbggq5y3f2c5w7vu@flea>
References: <20181130075849.16941-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l27y7yu4kizrcwqt"
Content-Disposition: inline
In-Reply-To: <20181130075849.16941-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l27y7yu4kizrcwqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 03:58:43PM +0800, Chen-Yu Tsai wrote:
> The CSI (camera sensor interface) controller found on the H3 (and H5)
> is a reduced version of the one found on the A31. It only has 1 channel,
> instead of 4 channels supporting time-multiplexed BT.656 on the A31.
> Since the H3 is a reduced version, it cannot "fallback" to a compatible
> that implements more features than it supports.
>=20
> This series separates support for the H3 variant from the A31 variant.
>=20
> Patches 1 ~ 3 separate H3 CSI from A31 CSI in the bindings, driver, and
> device tree, respectively.
>=20
> Patch 4 adds a pinmux setting for the MCLK (master clock). Some camera
> sensors use the master clock from the SoC instead of a standalone
> crystal.
>=20
> Patches 5 and 6 are examples of using a camera sensor with an SBC.
> Since the modules are detachable, these changes should not be merged.
> They should be implemented as overlays instead.
>=20
> Please have a look.
>=20
> In addition, I found that the first frame captured seems to always be
> incomplete, with either parts cropped, out of position, or missing
> color components.

For the first 4 patches,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--l27y7yu4kizrcwqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAD5DAAKCRDj7w1vZxhR
xauvAP4issrQ4ZQs2FKhnrnSC1e5aHrpRt9yMYST6XBEX3tNIwD/WUtRUNxlN5GK
gwcfuhO9WrkqAxQhilUqJ4LX5m69qwA=
=ng2d
-----END PGP SIGNATURE-----

--l27y7yu4kizrcwqt--

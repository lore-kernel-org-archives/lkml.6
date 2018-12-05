Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E19C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A4A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeLELJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:09:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48724 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLELJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:09:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3FD9620C18; Wed,  5 Dec 2018 12:09:55 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id EB28920745;
        Wed,  5 Dec 2018 12:09:38 +0100 (CET)
Date:   Wed, 5 Dec 2018 12:09:39 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] ARM: sun8i: a33: Audio codec improvements
Message-ID: <20181205110939.w4sbagsah5heo4ye@flea>
References: <20181205101152.22983-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djerp4ndjffky3di"
Content-Disposition: inline
In-Reply-To: <20181205101152.22983-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djerp4ndjffky3di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 06:11:49PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This series improves audio support on the A33. Like other Allwinner
> SoCs, the A33 requires the use of a sigma-delta modulation fractional-N
> PLL to generate the correct clock used for audio playback. Otherwise the
> pitch would be slightly off.
>=20
> Patch 1 enables sigma-delta modulation for the audio PLL on the A33.
>=20
> Patch 2 is only slightly related. It sets the CLK_SET_RATE_PARENT flag
> for all audio-related module clocks
>=20
> Patch 3 lowers the audio codec's oversampling rate, so that it can
> play back audio sampled at beyond 48 KHz.
>=20
> This is the same as what has recently been done for the A64, which
> shares the same audio codec hardware design.
>=20
> However, on the A33 it seems the PLL doesn't always immediately lock on
> to the new clock frequency when there is a rate change. Also since the
> codec is only put in standby instead of turned off, runtime PM never
> kicks in, and the audio related clocks never get turned off. I'm still
> looking into this.
>=20
> On an unrelated note, if you get pops when playing back audio on sunxi,
> it might be related to cpufreq. Try setting the governor to performance
> and see if that removes the pops.

Applied all 3 patches, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--djerp4ndjffky3di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAex8wAKCRDj7w1vZxhR
xYe4AP9cjPfghU+vltMG2R6qzW6a9kKvBwIUP+KU0Pd0i3GGAAEA+MeRdE7pdiDC
/DWn8hpg4iY6XXGOPSTzcv32BcCqvQs=
=jpF3
-----END PGP SIGNATURE-----

--djerp4ndjffky3di--

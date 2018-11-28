Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B59420660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B59420660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeK1VXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:23:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47393 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbeK1VXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:23:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C9F1320701; Wed, 28 Nov 2018 11:22:22 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 966F22039F;
        Wed, 28 Nov 2018 11:22:12 +0100 (CET)
Date:   Wed, 28 Nov 2018 11:22:12 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 06/15] rtc: sun6i: Add support for different variants
Message-ID: <20181128102212.4sodbbk6uu52nug3@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-7-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abq6ote33gmac3x6"
Content-Disposition: inline
In-Reply-To: <20181128093013.24442-7-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--abq6ote33gmac3x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 05:30:03PM +0800, Chen-Yu Tsai wrote:
> Amongst the Allwinner SoCs that have seen some kind of coverage by the
> linux-sunxi community, whether it be mainline Linux or U-boot support,
> or just available datasheets, most newer chips use the RTC design first
> seen in the A31 (sun6i).
>=20
> Overall there have been some minor differences. This patch covers the
> following:
>=20
>   - average clock rate of the internal RC oscillator
>     + presence of fixed and adjustable prescaler for this clock
>   - availability of an external (to the SoC) clock output
>=20
> One major difference regarding the H6 is the 24 MHz crystal is now
> routed through the RTC, as a digitally compensated oscillator (DCXO).
> This is not covered in this patch and will be supported later.
>=20
> Other differences are either unrelated to RTC or clock functionality,
> such as boot or crypto related registers, or the driver simply doesn't
> use the feature in question. One example of the latter is the
> calibration function for the RC oscillator. We consider this clock to
> be very bad and avoid using it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--abq6ote33gmac3x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/5sVAAKCRDj7w1vZxhR
xbgfAQCrRuACC6/4VYLiVFJ1VyJVIUwm58P/hcdy/38wZQh33wEAqiPnqEPr16zt
jth0aWCyPpcIr2U7MelKvSuTvoFJAgI=
=O851
-----END PGP SIGNATURE-----

--abq6ote33gmac3x6--

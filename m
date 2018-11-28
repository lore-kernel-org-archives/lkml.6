Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E022C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2F22086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2F22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeK1V3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:29:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47795 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbeK1V3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:29:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A0FD220701; Wed, 28 Nov 2018 11:27:55 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 694192039F;
        Wed, 28 Nov 2018 11:27:45 +0100 (CET)
Date:   Wed, 28 Nov 2018 11:27:45 +0100
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
Subject: Re: [PATCH 12/15] ARM: dts: sunxi: h3/h5: Fix up RTC device node and
 clock references
Message-ID: <20181128102745.v2dvq24jjf4vxrbd@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-14-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="szxyjblth4aupeez"
Content-Disposition: inline
In-Reply-To: <20181128093013.24442-14-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--szxyjblth4aupeez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 05:30:10PM +0800, Chen-Yu Tsai wrote:
> The RTC module on the H3 was claimed to be the same as on the A31, when
> in fact it is not. The A31 does not have an RTC external clock output,
> and its internal RC oscillator's average clock rate is not in the same
> range. The H5's RTC has some extra crypto-related registers compared to
> the H3. Their exact functions are not clear. Also the RTC-VIO regulator
> has different settings.
>=20
> This patch fixes the compatible string and clock properties to conform
> to the updated bindings. The device node for the internal oscillator is
> removed, as it is internalized into the RTC device. Clock references to
> the IOSC and LOSC are also fixed.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> squash! ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock referenc=
es

But you might want to remove that :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--szxyjblth4aupeez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/5toQAKCRDj7w1vZxhR
xbb1AQDbsazHXajG+TDCwmKEqdQ0tuj6J+vEmjpStlOqZLzkJwD/Up5RxeH2hidm
uaxv+2it9EJzUu/GB+RaqZFU4/HDtAA=
=1nYs
-----END PGP SIGNATURE-----

--szxyjblth4aupeez--

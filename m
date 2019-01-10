Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02950C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07982173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfAJG7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:59:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34610 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfAJG7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:59:41 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9B718209EF; Thu, 10 Jan 2019 07:59:39 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6637F20729;
        Thu, 10 Jan 2019 07:59:29 +0100 (CET)
Date:   Thu, 10 Jan 2019 07:59:29 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: sun5i: fail gracefully when clock rate is
 unavailable
Message-ID: <20190110065929.3vqqzdhrcdkfxpyv@flea>
References: <20190110062207.18787-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xobxpkhdrt4q2yph"
Content-Disposition: inline
In-Reply-To: <20190110062207.18787-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xobxpkhdrt4q2yph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 02:22:07PM +0800, Chen-Yu Tsai wrote:
> If the clock tree is not fully populated when the timer-sun5i init code
> is called, attempts to get the clock rate for the timer would fail and
> return 0.
>=20
> Make the init code for both clock events and clocksource check the
> returned clock rate and fail gracefully if the result is 0, instead of
> causing a divide by 0 exception later on.
>=20
> Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current cod=
e")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xobxpkhdrt4q2yph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDbtUQAKCRDj7w1vZxhR
xeD8AP9YfZ3756cbdi2l58QMJAF5x2SC7Munn8CWmq/qUjQfSwEApSGayIf49Ho8
wNJa4RC+ZB/73zekhANEnOPOyJihsA4=
=3Zx/
-----END PGP SIGNATURE-----

--xobxpkhdrt4q2yph--

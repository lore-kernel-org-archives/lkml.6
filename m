Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7CDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E06A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfAJP2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:28:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50459 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbfAJP2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:28:54 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 849A3209C2; Thu, 10 Jan 2019 16:28:51 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 50116209BC;
        Thu, 10 Jan 2019 16:28:51 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:28:51 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: sunxi: Fix and simplify pin bank regulator
 handling
Message-ID: <20190110152851.g33mgpfgzeatj332@flea>
References: <20190110082633.6321-1-wens@csie.org>
 <20190110082633.6321-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2pnopejneh27lbcz"
Content-Disposition: inline
In-Reply-To: <20190110082633.6321-2-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2pnopejneh27lbcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 04:26:33PM +0800, Chen-Yu Tsai wrote:
> The new per-pin-bank regulator handling code in the sunxi pinctrl driver
> has mismatched conditions for enabling and disabling the regulator: it
> is enabled each time a pin is requested, but only disabled when the
> pin-bank's reference count reaches zero.
>=20
> Since we are doing reference counting already, there's no need to enable
> the regulator each time a pin is requested. Instead we can just do it
> for the first requested pin of each pin-bank. Thus we can reverse the
> test and bail out early if it's not the first occurrence.
>=20
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> I'm getting the feeling that the current code is prone to race
> conditions when pinctrl sets are actively switched during runtime, or
> gpios are requested and freed from userspace.
>=20
> Any ideas?

IIRC, I've looked into it when writing that patch and there's an upper
mutex that prevents request from being called multiple times at
once. Linus might prove me wrong though.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2pnopejneh27lbcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDdkswAKCRDj7w1vZxhR
xT4RAQDm0VrViQOqnAb+y4lxm/C2Kk6e0f9nii3jW/wt7IavcgEA2l2fHktJKyQS
bjMr8bur8Y3On3zKYvDRU+a+LHjdEAc=
=+NHo
-----END PGP SIGNATURE-----

--2pnopejneh27lbcz--

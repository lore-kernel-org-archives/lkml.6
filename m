Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4E720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbeGWTLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:11:15 -0400
Received: from sauhun.de ([88.99.104.3]:50486 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387861AbeGWTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:11:15 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 70F09631238;
        Mon, 23 Jul 2018 20:08:49 +0200 (CEST)
Date:   Mon, 23 Jul 2018 20:08:49 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Esben Haabendal <eha@deif.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] i2c: imx: Fix reinit_completion() use
Message-ID: <20180723180848.ctfwxrk2www2ede2@ninjato>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
 <20180709094304.8814-2-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wqed2ci7gvcette"
Content-Disposition: inline
In-Reply-To: <20180709094304.8814-2-esben.haabendal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wqed2ci7gvcette
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 11:43:01AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
>=20
> Make sure to call reinit_completion() before dma is started to avoid race
> condition where reinit_completion() is called after complete() and before
> wait_for_completion_timeout().
>=20
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-current and added stable, thanks!

Uwe, do you have comments for the other patches, too?


--7wqed2ci7gvcette
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltWGbAACgkQFA3kzBSg
KbaOjBAApJ9ECR3ZplMNccodfIHepXh8Wubqou0RJDT81hu1E+2MCS9ihe8jBSEN
Qg34DOXUWwNrF59XeUbp+zUwIxBgKIM1xZdXk3aYNts5sW79dSOYVccsnHGAQ4Ai
tO85xI1YbJv4Llawx0wyspnNYYvAyFXZjcChlE+qCojbBTX1TFCHZzFEOk4yd92P
QJLOxp0D7CMKd0qHzPPg2BZkEPrfzARjnAtcRU5oae8fP3R3xjizp2uVe8pTSRcZ
IY6dWZNkbsGzJ+pFu1ng5kEtiZb66oHnNZlUQj2vvjAGZ/Cr9/Yjn0m2+E7NRglJ
eJSwENEdr96e4A08h7fKZM4cRQ0vOv2Mh9AkODgDTDUCcn6ipzI+zFeXXM2PXaOp
PVIp0cLq54LKvA+Tp/lvPZI89DbPM7BVYc1rwFWR9AOUAXpcfJcjd6RoqSjPxipY
sCV8AaXfZK0varFF7RVibJ5U8vc1+FAW37WSOPYpFkXCyw/3AbnKYw4KgZEYDgzg
mD0A6uAHWRpu/MF2QopiqRZPjpDAkbVUf0AUelhVAn9AE5jVhgIR+nCt9nKRLZpY
YPlwwMdM4WTFbh4+Z43T5WI9yw3do94nPx7OZK10KzBY2vlPfbaIK+hsBURcXL/+
wBsk7CdjzPqDNH0DqeN/h7mm+6erF9TMBGDZCnBcWKswoQwuANI=
=ANsa
-----END PGP SIGNATURE-----

--7wqed2ci7gvcette--

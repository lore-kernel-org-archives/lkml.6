Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6868FC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADDF2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADDF2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbeKMXZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:25:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52372 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733232AbeKMXZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:25:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D3407207BB; Tue, 13 Nov 2018 14:27:07 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id A00C8206A7;
        Tue, 13 Nov 2018 14:26:57 +0100 (CET)
Date:   Tue, 13 Nov 2018 14:26:58 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v4 03/26] clk: sunxi-ng: Add check for maximum rate to
 NKM PLLs
Message-ID: <20181113132658.niwy6bqdqzaeqpv2@flea>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qkzagaz2qwa76467"
Content-Disposition: inline
In-Reply-To: <20181113111633.20189-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qkzagaz2qwa76467
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 04:46:10PM +0530, Jagan Teki wrote:
> Some NKM PLLs, frequency can be set above PLL working range.
>=20
> Add a constraint for maximum supported rate. This way, drivers can
> specify which is maximum allowed rate for PLL.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

As Vasily reported on a previous version, this should be squashed with
the patch 2.

> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 3 +++
>  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nk=
m.c
> index 6b5ad990f802..b8b66cdd30bf 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -128,6 +128,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mu=
x_internal *mux,
>  	if (rate < nkm->min_rate)
>  		return nkm->min_rate;
> =20
> +	if (nkm->max_rate && rate > nkm->max_rate)
> +		return nkm->max_rate;
> +

I would expect the test to be the same for the minimum and maximum cases.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qkzagaz2qwa76467
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+rRIQAKCRDj7w1vZxhR
xUtiAP0Qzz9KTR8SbP2fs3KcowHxL8xYV+GOUNZ9/VA8BWSVxAD+KRBkAWya7D4N
adBknlFW6CNpkDt3SyJa46/5Dwt0WgU=
=E1t8
-----END PGP SIGNATURE-----

--qkzagaz2qwa76467--

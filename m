Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA17620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA17620832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeK1Veb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:34:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48350 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbeK1Vea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:34:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2F61720743; Wed, 28 Nov 2018 11:33:17 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1BB44207AD;
        Wed, 28 Nov 2018 11:33:02 +0100 (CET)
Date:   Wed, 28 Nov 2018 11:33:02 +0100
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
Subject: Re: [PATCH 08/15] rtc: sun6i: Expose internal oscillator through
 device tree
Message-ID: <20181128103302.n7abjuf4ixjafth6@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-10-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4vh5seys36kdunea"
Content-Disposition: inline
In-Reply-To: <20181128093013.24442-10-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4vh5seys36kdunea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

65;5402;1c
On Wed, Nov 28, 2018 at 05:30:06PM +0800, Chen-Yu Tsai wrote:
> The bindings have been updated to expose the RTC's internal oscillator,
> for some SoCs that have it directly feeding the PRCM block. The changes
> include the index 2 for the clock outputs, as well as the clock output
> names.
>=20
> This patch adds the internal oscillator to the list of clocks exposed
> through of_clk_add_hw_provider(), and also have the driver optionally
> fetch the name of the clock from the device tree if it's available.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/rtc/rtc-sun6i.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 62ed9ce53d8c..273ab7fbbbe3 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -220,6 +220,7 @@ static void __init sun6i_rtc_clk_init(struct device_n=
ode *node,
>  		.ops		=3D &sun6i_rtc_osc_ops,
>  		.name		=3D "losc",
>  	};
> +	const char *iosc_name =3D "rtc-int-osc";
>  	const char *clkout_name =3D "osc32k-out";
>  	const char *parents[2];
> =20
> @@ -228,7 +229,7 @@ static void __init sun6i_rtc_clk_init(struct device_n=
ode *node,
>  		return;
> =20
>  	rtc->data =3D data;
> -	clk_data =3D kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
> +	clk_data =3D kzalloc(struct_size(clk_data, hws, 3), GFP_KERNEL);
>  	if (!clk_data) {
>  		kfree(rtc);
>  		return;
> @@ -253,8 +254,10 @@ static void __init sun6i_rtc_clk_init(struct device_=
node *node,
>  	if (!of_get_property(node, "clocks", NULL))
>  		goto err;
> =20
> +	of_property_read_string_index(node, "clock-output-names", 2,
> +				      &iosc_name);
>  	rtc->int_osc =3D clk_hw_register_fixed_rate_with_accuracy(NULL,
> -								"rtc-int-osc",
> +								iosc_name,
>  								NULL, 0,
>  								rtc->data->rc_osc_rate,
>  								300000000);
> @@ -290,9 +293,10 @@ static void __init sun6i_rtc_clk_init(struct device_=
node *node,
>  		return;
>  	}
> =20
> -	clk_data->num =3D 2;
> +	clk_data->num =3D 3;
>  	clk_data->hws[0] =3D &rtc->hw;
>  	clk_data->hws[1] =3D __clk_get_hw(rtc->ext_losc);
> +	clk_data->hws[2] =3D rtc->int_osc;

Shouldn't we add a check on either the compatible on the number of
clock-output-names?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4vh5seys36kdunea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/5u3gAKCRDj7w1vZxhR
xdgBAP0TS5jYj43RhJUZaBpvilPR8NCcJn0ROpWAHbuAwipcrwEAys09f2igBsbo
NqXxEBFIQT32qOacr+yaLZwpCXZWJQQ=
=MIEY
-----END PGP SIGNATURE-----

--4vh5seys36kdunea--

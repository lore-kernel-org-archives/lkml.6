Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1EAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1D120851
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393201AbeKVTYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:24:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47297 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbeKVTYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:24:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 88E4D2072F; Thu, 22 Nov 2018 09:45:36 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 55C7820DDE;
        Thu, 22 Nov 2018 09:45:26 +0100 (CET)
Date:   Thu, 22 Nov 2018 09:45:26 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v3 09/17] pinctrl: sunxi: add support for suniv
 F1C100s (newer F-series SoCs)
Message-ID: <20181122084526.gc5qfez4ppxstq3d@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <fc20d96f5531d7d1eb5ce3d5cf920c8bf59cad58.1542824904.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eposblfbribc57f5"
Content-Disposition: inline
In-Reply-To: <fc20d96f5531d7d1eb5ce3d5cf920c8bf59cad58.1542824904.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eposblfbribc57f5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2018 at 09:30:42PM +0300, Mesih Kilinc wrote:
> +static const struct sunxi_pinctrl_desc suniv_f1c100s_pinctrl_data =3D {
> +	.pins =3D suniv_f1c100s_pins,
> +	.npins =3D ARRAY_SIZE(suniv_f1c100s_pins),
> +	.irq_banks =3D 3,
> +	.disable_strict_mode =3D true,
> +};

One thing I forgot to check before giving my Acked-by, you shouldn't
disable the strict mode here, this is only meant as a legacy option,
new drivers need to enforce it.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--eposblfbribc57f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/ZspgAKCRDj7w1vZxhR
xcKOAP4naQLMC0gpZDuz8OAFPm2gADR9V+QJL1ubsG5MgnoUqgD/cE9ZJypOAUuP
yEC3BMC1+TlcN4GFPd8KQefYuQQHVgc=
=2HHW
-----END PGP SIGNATURE-----

--eposblfbribc57f5--

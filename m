Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48A3CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B21208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B21208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbeFNPkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:40:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55042 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755330AbeFNPj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:39:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5084D2072C; Thu, 14 Jun 2018 17:39:54 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id AE265203B4;
        Thu, 14 Jun 2018 17:39:53 +0200 (CEST)
Message-ID: <042923c4f378f3e134bf490d5f6a650173984411.camel@bootlin.com>
Subject: Re: [PATCH v3 11/14] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Florent Revest <florent.revest@free-electrons.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Randy Li <ayaka@soulik.info>
Date:   Thu, 14 Jun 2018 17:39:53 +0200
In-Reply-To: <20180507154201.4vz3y6j7u7kzfud6@flea>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
         <20180507124500.20434-12-paul.kocialkowski@bootlin.com>
         <20180507154201.4vz3y6j7u7kzfud6@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-purauuQLG3hCGT6AarW3"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-purauuQLG3hCGT6AarW3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2018-05-07 at 17:42 +0200, Maxime Ripard wrote:
> On Mon, May 07, 2018 at 02:44:57PM +0200, Paul Kocialkowski wrote:
> > +#define SYSCON_SRAM_CTRL_REG0	0x0
> > +#define SYSCON_SRAM_C1_MAP_VE	0x7fffffff
>=20
> This isn't needed anymore

Will do in the next revision.

> > +	dev->ahb_clk =3D devm_clk_get(dev->dev, "ahb");
> > +	if (IS_ERR(dev->ahb_clk)) {
> > +		dev_err(dev->dev, "failed to get ahb clock\n");
> > +		return PTR_ERR(dev->ahb_clk);
> > +	}
> > +	dev->mod_clk =3D devm_clk_get(dev->dev, "mod");
> > +	if (IS_ERR(dev->mod_clk)) {
> > +		dev_err(dev->dev, "failed to get mod clock\n");
> > +		return PTR_ERR(dev->mod_clk);
> > +	}
> > +	dev->ram_clk =3D devm_clk_get(dev->dev, "ram");
> > +	if (IS_ERR(dev->ram_clk)) {
> > +		dev_err(dev->dev, "failed to get ram clock\n");
> > +		return PTR_ERR(dev->ram_clk);
> > +	}
>=20
> Please add some blank lines between those blocks

Yes, looks much better that way!

> > +	dev->rstc =3D devm_reset_control_get(dev->dev, NULL);
>=20
> You're not checking the error code here

Good catch.

> > +	dev->syscon =3D syscon_regmap_lookup_by_phandle(dev->dev->of_node,
> > +						      "syscon");
> > +	if (IS_ERR(dev->syscon)) {
> > +		dev->syscon =3D NULL;
> > +	} else {
> > +		regmap_write_bits(dev->syscon, SYSCON_SRAM_CTRL_REG0,
> > +				  SYSCON_SRAM_C1_MAP_VE,
> > +				  SYSCON_SRAM_C1_MAP_VE);
> > +	}
>=20
> You don't need the syscon part anymore either

Correct.

> > +	ret =3D clk_prepare_enable(dev->ahb_clk);
> > +	if (ret) {
> > +		dev_err(dev->dev, "could not enable ahb clock\n");
> > +		return -EFAULT;
> > +	}
> > +	ret =3D clk_prepare_enable(dev->mod_clk);
> > +	if (ret) {
> > +		clk_disable_unprepare(dev->ahb_clk);
> > +		dev_err(dev->dev, "could not enable mod clock\n");
> > +		return -EFAULT;
> > +	}
> > +	ret =3D clk_prepare_enable(dev->ram_clk);
> > +	if (ret) {
> > +		clk_disable_unprepare(dev->mod_clk);
> > +		clk_disable_unprepare(dev->ahb_clk);
> > +		dev_err(dev->dev, "could not enable ram clock\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	ret =3D reset_control_reset(dev->rstc);
> > +	if (ret) {
> > +		clk_disable_unprepare(dev->ram_clk);
> > +		clk_disable_unprepare(dev->mod_clk);
> > +		clk_disable_unprepare(dev->ahb_clk);
> > +		dev_err(dev->dev, "could not reset device\n");
> > +		return -EFAULT;
>=20
> labels would simplify this greatly, and you should also release the
> sram and the memory region here.

I'll definitely do a sweep and add labels/gotos for this before
submitting the nexr revision.

Thanks for the review!

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-purauuQLG3hCGT6AarW3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlsijEkACgkQ3cLmz3+f
v9Hydgf+OIPRQvVyBsgSEBIz2maSQGarde+mFPAqwKmSDz1v9JtVd7poVe3mGkrM
uPiPJJhWhZtvH8Ph/3LasSdsA/pq1vpzBlZ5pJd4RMOLvV6WyIduAgBIqsNQrK+R
cV7v5GpeDnC1mooMhUdCHzjWOLdAy5GurwIALKCbKiFAuU5azIz9NIZU19kqqSve
D5CrdVrjzZWQc9eqc0KL/tbCD7/gy9f+CNdpvPbZTr4r3NcRRGBqX0Cd1pVLoz0f
SNL77ACWlOIZEYTNw426ke3FfaYDNgls5dkIBaraucRnLcMpVJlRD9Kfg/Jwbi7F
K8CYo+pM9uKmGxQV18wOpHPUic35Lw==
=TaaQ
-----END PGP SIGNATURE-----

--=-purauuQLG3hCGT6AarW3--


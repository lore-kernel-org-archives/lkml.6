Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45BAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6209521470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6209521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbeGQJk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:40:59 -0400
Received: from sauhun.de ([88.99.104.3]:33922 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbeGQJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:40:58 -0400
Received: from localhost (p54B33605.dip0.t-ipconnect.de [84.179.54.5])
        by pokefinder.org (Postfix) with ESMTPSA id 3DD1A5E000F;
        Tue, 17 Jul 2018 11:09:21 +0200 (CEST)
Date:   Tue, 17 Jul 2018 11:09:20 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel@pengutronix.de,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
Message-ID: <20180717090920.zy6lkeqlcewhrfs5@ninjato>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
 <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tg455teebzxcygml"
Content-Disposition: inline
In-Reply-To: <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tg455teebzxcygml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

> > -	gpio =3D devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
> > +	gpio =3D devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
> >   	if (IS_ERR(gpio)) {
> >   		r =3D PTR_ERR(gpio);
> >   		if (r =3D=3D -ENOENT || r =3D=3D -ENOSYS)
> >=20
>
> This was intentional. The gpio we use to drive the i2c line is implemente=
d in an
> FPGA and signals a buffer attached to the GPIO to drive scl OPEN drain. T=
he GPIO is output
> only.

So, it is not possible to read SCL status then? Hmm, currently a working
get_scl is required...

> The gpio setup can still specify the the GPIO be allocated OPEN drain if =
someone wishes
> to use a "smarter" gpio.
>=20
> So while the scl is open drain, there may be hardware in between that isn=
't.
> What would the correct way be to deal with that now?

Well, I don't know much about this IP core and how/where it is used. I
just wonder what happens if another user comes along using an
open-drain GPIO. Is that possible?

I assume it is the same with SDA? Non open-drain? Output only?

Regards,

   Wolfram


--tg455teebzxcygml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltNskAACgkQFA3kzBSg
KbZwbQ/+MJCShrVhonYuESLYY03BEi6p8a5WPFWHsZmTC4Nc8uuKXupxRvNP6qpy
OdXYBJvLdhIjVRGbpV7MRQII/mYeXpC4hxaVoZhkInxpf07CwqMDUyNU9oiXC0yP
kM0ONuHPZ/sjCWQSrASMZdu44JgMqZ61PV3FTWN+FBZZY/FEFy0jiem1LK4RupB3
J3ZrvOBzNE53yv1GLhXm4JvmYqOexkmm5NV2xJW/e1DB4LGNQvxgBxHmz1/1mMNE
SkUSu125FR/6nhSizpr6Ftq/SC4AACPYmH+SXLCYh7GOtWCwY3ru2eWc5gBFoHkb
pgjPV5H2GxCO38+IFPVSilH+9lMfc+BB/ykpXdLlo9wcIYBFU0g5ws4cY7/H4ZLL
+FsJwFo3LZbNVVzA1xdT5OQmIQ5Y3ASN+Z2kJ5r3J0ZDRJrG6u5hUw0H/4/KVrm3
XcWZxxDr0L4xetggo007TvqD7tIt9qpPI94cgwKnkzR4ky65szKDJDynyswrjXID
D1YjDkHwB6h+FfpIM/c9pWtSaR76NJ4J+f1ouF53NWSVANlUt+O7gDx6ugwDV05w
BFfxq0iWvIKYtBuD9TjyH2HnMjJysHEfvtTsAImjsXtVEVq87L040UIxlEMz09fV
j50YUzVql9wE2eQLncmIj2CV+xMhakex6SjkE6m7vLgumtQciZk=
=L2Mj
-----END PGP SIGNATURE-----

--tg455teebzxcygml--

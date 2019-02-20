Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98210C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751542183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfBTOzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:55:36 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:51649 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBTOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:55:35 -0500
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D6BA5100011;
        Wed, 20 Feb 2019 14:55:31 +0000 (UTC)
Date:   Wed, 20 Feb 2019 15:55:31 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Philipp Rossak <embed3d@gmail.com>,
        Emmanuel Vadot <manu@bidouilliste.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Allwinner SID THS calibration data cell representation?
Message-ID: <20190220145531.xu2t5gklnien7a3i@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
 <20180906115114.inc6dhqhy47obo25@flea>
 <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pfmyvb5oulioawsq"
Content-Disposition: inline
In-Reply-To: <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pfmyvb5oulioawsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 03:54:00PM +0800, Chen-Yu Tsai wrote:
> Sorry for resurrecting an old discussion, but since someone posted patches
> for H5 and H6, I thought we should resolve this. I'm working on patches to
> fix / replace the big-endian issue.
>=20
> On Thu, Sep 6, 2018 at 7:51 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
> > > On 04.09.2018 18:46, Emmanuel Vadot wrote:
> > > > > +                 /* Data cells */
> > > > > +                 thermal_calibration: calib@234 {
> > > > > +                         reg =3D <0x234 0x8>;
> > > > > +                 };
> > > >   You are declaring 8 bytes of calibration data but to my knowledge=
 it's
> > > > only 2 bytes per sensor, so 2 bytes for H3.
> > > >   Am I missing something ?
> > > >
> > > >   Thanks,
> > >
> > > Emmanuel you are right, it is 2 bytes per Sensor and should be 2 byte=
s for
> > > H3, but the thermal calibration data field is on all chips 64 bit wid=
e - so
> > > 8 bytes. So I'm reading here the complete calibration data field.
> >
> > Having one cell per channel would make more sense I guess.
>=20
> Would it? The 2 32-bit words directly map onto the registers 0x74 / 0x78 =
in
> the THS. As far as the SID is concerned, their is just one consumer for t=
his
> data, the thermal sensor. How the thermal sensor uses that data is really=
 not
> its concern. And the thermal sensor is really just copying the data from =
the
> e-fuses into its registers. Nothing more.
>=20
> Furthermore, with the register access interface, the e-fuses are read/wri=
te
> 32 bits at a time. Seems to me it would make more sense to enforce a 32-b=
it
> word size, so cells should be multiples of 32 bits.

I guess you convinced me :)

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pfmyvb5oulioawsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1qYwAKCRDj7w1vZxhR
xfquAQDelRqy0KSIwPv4oRKC2HvytiWLK3V5rOiAN3M29yfUdQD8CEnw/bd4nQ8r
EOdlVk5w/gtOyB8NmF9rMr4XR947xAU=
=G2bD
-----END PGP SIGNATURE-----

--pfmyvb5oulioawsq--

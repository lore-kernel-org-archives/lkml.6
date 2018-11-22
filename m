Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA0DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA8E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA8E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395262AbeKWAid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:38:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56876 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388851AbeKWAid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:38:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5649E207A8; Thu, 22 Nov 2018 14:59:03 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 297442072F;
        Thu, 22 Nov 2018 14:58:53 +0100 (CET)
Date:   Thu, 22 Nov 2018 14:58:53 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 3/5] media: sunxi: Add A10 CSI driver
Message-ID: <20181122135853.4rpxb32d6ios5zac@flea>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <f34c79f5-66d6-2c2f-5616-020ad2b96400@xs4all.nl>
 <20181115205106.thbkojnzdwmaeui3@flea>
 <20181121220102.6nn7uwu2c67zs6pz@mara.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3quxuh5gpkv3x7ke"
Content-Disposition: inline
In-Reply-To: <20181121220102.6nn7uwu2c67zs6pz@mara.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3quxuh5gpkv3x7ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Thu, Nov 22, 2018 at 12:01:03AM +0200, Sakari Ailus wrote:
> On Thu, Nov 15, 2018 at 09:51:06PM +0100, Maxime Ripard wrote:
> > Hi Hans,
> >=20
> > Thanks for your review! I'll address the other comments you made.
> >=20
> > On Tue, Nov 13, 2018 at 01:24:47PM +0100, Hans Verkuil wrote:
> > > > +static int csi_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct sun4i_csi *csi;
> > > > +	struct resource *res;
> > > > +	int ret;
> > > > +	int irq;
> > > > +
> > > > +	csi =3D devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
> > >=20
> > > devm_kzalloc is not recommended: all devm_ memory is freed when the d=
river
> > > is unbound, but a filehandle might still have a reference open.
> >=20
> > How would a !devm variant with a kfree in the remove help? We would
> > still fall in the same case, right?
>=20
> Not quite. For video nodes this is handled: the release callback gets cal=
led
> once there are no file handles open to the device. That may well be much
> later than the device has been unbound from the driver.

I might be missing something, but how the release callback will be
able to get the reference to the structure we allocated here so that
it can free it?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3quxuh5gpkv3x7ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/a2HQAKCRDj7w1vZxhR
xeYmAP9yPJlEhJ3rYDcEmTa7fnMkqikKNh6ty85vrrlg+FCEBgD/Xvwbv+mZKRbm
TOU2UTA8aEpKmFShx9jEqRewxE1iDQw=
=+FLC
-----END PGP SIGNATURE-----

--3quxuh5gpkv3x7ke--

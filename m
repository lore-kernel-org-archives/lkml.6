Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D592C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EF5205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EF5205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeK2UHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:07:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34667 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbeK2UHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:07:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 41EAB20D73; Thu, 29 Nov 2018 10:02:26 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id E09CD20D04;
        Thu, 29 Nov 2018 10:02:15 +0100 (CET)
Message-ID: <9aa0953ea2d6c3f5363c811efe7586b705a2ee28.camel@bootlin.com>
Subject: Re: [PATCH] media: cedrus: Remove global IRQ spin lock from the
 driver
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Thu, 29 Nov 2018 10:02:15 +0100
In-Reply-To: <20181116104722.akw7bz6zirsslh3s@flea>
References: <20181115143955.2645-1-paul.kocialkowski@bootlin.com>
         <20181116104722.akw7bz6zirsslh3s@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bIL1yrgM+lpQk+UnYSMX"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bIL1yrgM+lpQk+UnYSMX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2018-11-16 at 11:47 +0100, Maxime Ripard wrote:
> On Thu, Nov 15, 2018 at 03:39:55PM +0100, Paul Kocialkowski wrote:
> > We initially introduced a spin lock to ensure that the VPU registers
> > are not accessed concurrently between our setup function and IRQ
> > handler. Because the V4L2 M2M API only allows one job to run at a time
> > and our jobs are completed following the IRQ handler, there is actually
> > no chance of an interrupt happening while programming the VPU registers=
.
>=20
> That's not entirely true. There's no chance that the interrupt
> signaling the end of the frame decoding can happen.
>=20
> However, spurious interrupts can happen at any point in time as soon
> as you have the interrupts enabled.
>=20
> > In addition, holding a spin lock is problematic when doing more than
> > simply configuring the registers in the setup operation. H.265 support
> > currently involves a CMA allocation in that step, which is not
> > compatible with an atomic context.
>=20
> That's not really true either. Any allocation can be done with
> GFP_ATOMIC or GFP_NOWAIT, and be compatible with an atomic
> context. Whether it's something we want is a different story :)
>=20
> And since the h265 code isn't upstream, I'm not really sure it's
> relevant to mention it here.

Thanks for your comments, I have just made associated changes and sent
out v2.

Cheers!

 * Paul

> > As a result, remove the global IRQ spin lock.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Maxime
>=20
--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-bIL1yrgM+lpQk+UnYSMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlv/qxcACgkQ3cLmz3+f
v9HgCAgAnoJ7P1Fno4eCPOUmZvaDrZKuIzZYy3Rid4s5TAEpbkfdmB4dcs8O2Iuj
r8Dm3NXLjmJ/q0LnyR0ulqpFjDbU7Oh8f7YUPSyNrjb18O3wRTs7j7jMbgOY4FLW
9q8Ail4rPuWlHPvsDRv33tN3HcITmLpoc3GVflr8G6L+tQBranoxzUIcFAeAAaZz
m3O3CjXuCqvKZIZr+fwoRSSIV3SPYcFPZi87WS3QVApodvLlGz+w50+NELiX1Az6
PshhBQ/z8dRI3zUY6GZVgjOW2cHtBNuDaE+/sOV8NY50fncqCyxBCQT8rBdDSP0G
ddY1J+MXECQtnfVr6gCW5gtrCezAmg==
=fjP7
-----END PGP SIGNATURE-----

--=-bIL1yrgM+lpQk+UnYSMX--


Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F88C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1515F21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1515F21A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeHFLa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:30:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46161 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbeHFLaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:30:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6D7C720794; Mon,  6 Aug 2018 11:22:43 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-99-143.w90-88.abo.wanadoo.fr [90.88.4.143])
        by mail.bootlin.com (Postfix) with ESMTPSA id ED7A1206DE;
        Mon,  6 Aug 2018 11:22:42 +0200 (CEST)
Message-ID: <145b34861e7cd487dc4d9383020f186c9f273f13.camel@bootlin.com>
Subject: Re: [PATCH v6 0/8] Cedrus driver for the Allwinner Video Engine,
 using media requests
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Mon, 06 Aug 2018 11:22:43 +0200
In-Reply-To: <4e8a0286-7e49-5622-1895-ac3268224152@xs4all.nl>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
         <4e8a0286-7e49-5622-1895-ac3268224152@xs4all.nl>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gH/QfZuiTxIkFDOdCPyB"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gH/QfZuiTxIkFDOdCPyB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 2018-08-04 at 14:43 +0200, Hans Verkuil wrote:
> On 07/25/2018 12:02 PM, Paul Kocialkowski wrote:
> > This is the sixth iteration of the updated Cedrus driver,
> > that supports the Video Engine found in most Allwinner SoCs, starting
> > with the A10. It was tested on the A13, A20, A33 and H3.
> >=20
> > The initial version of this driver[0] was originally written and
> > submitted by Florent Revest using a previous version of the request API
> > that is necessary to provide coherency between controls and the buffers
> > they apply to.
> >=20
> > The driver was adapted to use the latest version of the media request
> > API[1], as submitted by Hand Verkuil. Media request API support is a
> > hard requirement for the Cedrus driver.
> >=20
> > The driver itself currently only supports MPEG2 and more codecs will be
> > added to the driver eventually. The output frames provided by the
> > Video Engine are in a multi-planar 32x32-tiled YUV format, with a plane
> > for luminance (Y) and a plane for chrominance (UV). A specific format i=
s
> > introduced in the V4L2 API to describe it.
> >=20
> > This implementation is based on the significant work that was conducted
> > by various members of the linux-sunxi community for understanding and
> > documenting the Video Engine's innards.
> >=20
> > In addition to the media requests API, the following series are require=
d
> > for Cedrus:
> > * vicodec: the Virtual Codec driver
>=20
> This will appear in for 4.19.
>
> > * allwinner: a64: add SRAM controller / system control
> > * SRAM patches from the Cedrus VPU driver series version 5
>=20
> What about these? Are they queued up for 4.19 as well?

Yes, they are queued for 4.19 through Maxime's tree[0].

> I'll post a rebased reqv17 later today that includes the
> "add v4l2_ctrl_request_hdl_find/put/ctrl_find functions" patch.

Great, I'll rebase and send a new version (taking in account your latest
review) as soon as time allows!

Cheers,

Paul

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=
=3Dsunxi/for-next

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

--=-gH/QfZuiTxIkFDOdCPyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAltoE2MACgkQ3cLmz3+f
v9F7GAgAgDUAirtsw3BKANs8zTvXri5GPb8Mpa90t2gQHkcFR55DWQxGNI6QgeFM
idMNa6aEs+IvPU9kotJsNK/KUdVgNP17L4NfefIVa3Ilti1RC5V74pUB/sGaZk4n
KUqzNyuUx13Adkrqw6eNUEE71i5lrA55ApUNA7SwaZcQo2ODpGilIQW2Q/UANYKR
9DdxVXGC6sY+CHCFJtfEDGUaI7ejg38cv7hbKrEiMIaKWktNUZ4rFDANxwWaN+7C
mma0n8b9nF29RvgUSc55WFgAA1uN4Xc72V0TsTs5iC5dLbtj2kox0AsbDC0nTzpx
7K6U3tzTZzVrVcFKsOlWPcFWe9Sx/A==
=jdA/
-----END PGP SIGNATURE-----

--=-gH/QfZuiTxIkFDOdCPyB--


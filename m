Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D832EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B74A2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B74A2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeIEMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:25:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36597 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbeIEMZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:25:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04D6D208BE; Wed,  5 Sep 2018 09:56:16 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 13DEF208AE;
        Wed,  5 Sep 2018 09:56:02 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:56:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] dt-bindings: change the A64 HDMI PHY binding to R40
Message-ID: <20180905075601.32kzkd3is2gpa3ft@flea>
References: <20180903133434.58188-1-icenowy@aosc.io>
 <20180903133434.58188-2-icenowy@aosc.io>
 <20180905071435.lgsogpzmh5nw6bcy@flea>
 <3D28A45F-D67D-4388-9FB7-2A2763955398@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jstdn7l5m4f2ddx"
Content-Disposition: inline
In-Reply-To: <3D28A45F-D67D-4388-9FB7-2A2763955398@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jstdn7l5m4f2ddx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 03:46:41PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B49=E6=9C=885=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=883=
:14:35, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Mon, Sep 03, 2018 at 09:34:32PM +0800, Icenowy Zheng wrote:
> >> By experiment, the A64 HDMi PHY doesn't support the PLL-VIDEO mux
> >> introduced in R40, although it has two PLL-VIDEOs.
> >>=20
> >> Change the A64 HDMI PHY binding to R40 one.
> >>=20
> >> This binding is introduced in v4.19, which is still in RC stage, so
> >we
> >> have change to fix it.
> >>=20
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >
> >That doesn't make much sense. The A64 doesn't have any particular
> >reason to behave like the R40, and the R40 can definitely use a
> >different compatible if it has a different behaviour. But I don't see
> >*why* the A64 not behaving like the R40 is a justification to remove
> >the A64 compatible. Especially when the R40 was released later.
> >
> >Add a new compatible, and leave the A64 compatible alone.
>=20
> But the behavior of A64 compatible will change from double
> PLL to single PLL, because the A64 HDMI PHY is proven
> to have no double PLL.
>=20
> Should I then change the A64 compatible behavior and import R40
> compatible at the same time?

I don't see why you should do both at the same time. Fix the A64, and
add the support for the R40, those are two orthogonal changes.

> In addition maybe I can just drop A64 compatible, and let A64
> use H3 one.

No, that break the backward compatibility.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4jstdn7l5m4f2ddx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPjBAACgkQ0rTAlCFN
r3TsdQ/9H0JdBXgyUmIS5JgJqON/ZI+gQPZsi9ZSnJZgU12peHAi94J/1qaSCjqU
NYl/7lMHshTCsF8V8JIVkPBxrBCSo9n/4azyE07OMXXtL65MkvhXY1LEYoRQLyrc
N0yKqLSDrV/Yp+e8+RawO9tNzwoHAy0AK+vGErq5Y+7c8WqTvh8fxgMHvaKlB8lq
68vgmD7+wtD2wd3HhLcrxvg7Dbfz2pSHU4lW8K8IVb+B+zFjcL/mWuFyp2qXl6jr
VSQHtFBo25vNIdgbv3LuzG+qu0c+D85Oq249kwucFAk/Rlv4+8Y9ayxiwSjA4nl+
oNpmEKHdKEsVmZzxLqcpGlGxlIz+Q/XkdsH0N5L41/+ZtWgAAEv8rGi2cmGs/N8C
nB/QeLwSsnDgXI3rFIvZWY3BJRTjO9VIQo+NhugC+PQYaSweVzLXxNS2Zgzm+e89
jBG+Q6Wc2Oq4UTRBhpx0bytyeemQAUAYlUcczPMn8Rjf+vYEz0FlDMfFWJ5frg6l
9Bo3fOBeOQ8H+ccnoznOwBqFi+91OuNk9ETahZYfEzM4FRzfS1CMpE7g24PVEt54
2aRojZim/gv0C+l4YXF6yHiqQ1qaiClyKiIGj2YXByT9DOXKcr3XnnrA++zmaDXD
5TR4IDqCGR9Fd7KKTCzyNhHxlujaJ+Gw67/T3fj5PmfNin82s0A=
=VpVl
-----END PGP SIGNATURE-----

--4jstdn7l5m4f2ddx--

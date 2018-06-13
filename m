Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DAA2DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BC820891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BC820891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934419AbeFMHfA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:35:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41794 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933759AbeFMHe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:34:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D94A12092B; Wed, 13 Jun 2018 09:34:56 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id A731620720;
        Wed, 13 Jun 2018 09:34:56 +0200 (CEST)
Date:   Wed, 13 Jun 2018 09:34:56 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 04/27] dt-bindings: display: sunxi-drm: Add TCON TOP
 description
Message-ID: <20180613073456.jk72zw4rt4ysjco7@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-5-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uzd22rhmxyob4kzr"
Content-Disposition: inline
In-Reply-To: <20180612200036.21483-5-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uzd22rhmxyob4kzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for working on this!

On Tue, Jun 12, 2018 at 10:00:13PM +0200, Jernej Skrabec wrote:
> TCON TOP main purpose is to configure whole display pipeline. It
> determines relationships between mixers and TCONs, selects source TCON
> for HDMI, muxes LCD and TV encoder GPIO output, selects TV encoder
> clock source and contains additional TV TCON and DSI gates.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt      | 45 +++++++++++++++++++
>  include/dt-bindings/clock/sun8i-tcon-top.h    | 11 +++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h
>=20
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 3346c1e2a7a0..ef64c589a4b3 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -187,6 +187,51 @@ And on the A23, A31, A31s and A33, you need one more=
 clock line:
>     - 'lvds-alt': An alternative clock source, separate from the TCON cha=
nnel 0
>                   clock, that can be used to drive the LVDS clock
> =20
> +TCON TOP
> +--------
> +
> +TCON TOPs main purpose is to configure whole display pipeline. It determ=
ines
> +relationships between mixers and TCONs, selects source TCON for HDMI, mu=
xes
> +LCD and TV encoder GPIO output, selects TV encoder clock source and cont=
ains
> +additional TV TCON and DSI gates.
> +
> +It allows display pipeline to be configured in very different ways:
> +
> +                             / LCD0/LVDS0
> +                 / TCON-LCD0
> +                 |           \ MIPI DSI
> + mixer0          |
> +        \        / TCON-LCD1 - LCD1/LVDS1
> +         TCON-TOP
> +        /        \ TCON-TV0 - TVE0/RGB
> + mixer1          |          \
> +                 |           TCON-TOP - HDMI
> +                 |          /
> +                 \ TCON-TV1 - TVE1/RGB
> +
> +Note that both TCON TOP references same physical unit.
> +
> +Required properties:
> +  - compatible: value must be one of:
> +    * allwinner,sun8i-r40-tcon-top
> +  - reg: base address and size of the memory-mapped region.
> +  - clocks: phandle to the clocks feeding the TCON TOP
> +    * bus: TCON TOP interface clock
> +  - clock-names: clock name mentioned above
> +  - resets: phandle to the reset line driving the DRC

s/DRC/TCON TOP/ ?

> +    * rst: TCON TOP reset line

Remaining consistent with the clock name would be great

> +  - reset-names: reset name mentioned above
> +  - #clock-cells : must contain 1

An example would be nice here

> +- ports: A ports node with endpoint definitions as defined in
> +    Documentation/devicetree/bindings/media/video-interfaces.txt. The fi=
rst port
> +    should be the input for mixer0 mux. The second should be the output =
for that
> +    mux. Third port should be input for mixer1 mux. Fourth port should b=
e output
> +    for mixer1 mux. Fifth port should be input for HDMI mux. Sixth port =
should
> +    be output for it. All output endpoints should have reg property with=
 the id
> +    of the target TCON. All ports should have only one enpoint connected=
 to

                                                          ^ endpoint

I guess it would me more readable if you were to make it a bullet
list, but this works for me otherwise.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--uzd22rhmxyob4kzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsgyR8ACgkQ0rTAlCFN
r3QN5w//bI6wGq8N0eSl7T8E11SnbC71KgWyFoknB2TB1nWsvRnt7GVBFcz+lUe2
PqZZHDnzL9J2Wd8M+Q4BEsRIO0m5uCvqZ2ce/8iRggqz8U8OUfmChJW1kY3kfcw4
TAL7OxScdSeRZnyyALlbMr5kSDsZLmUa+kbCeS3YSQm6wiVu6V+I5kYyQylHqgnL
E0DKcNY49zMwHs1UB6g7ena5EUGMUgoptkbGpdVntnQKoTXOdv0/BJf8TYYHuTNL
dX97904/ocljZF0hnVKCGAyk+H+gNKgZXMVq1JVVYA9co2w59c9rvAX7LWuFpBiw
B+xsyxxdH3qdOBvyxcvwQztF+2UCqkcAEGrthJHq3yUnaGsMrdGMt8615+ZjW56S
HIsUKJ3Lx48xnz2qGlRzjaUfds/R7T39Nz4rQBJ5622pw2RzaJQjxMUqgpP44e5W
bgoxh3v8OMAaZYDSfFiSEElMhEKHmO75gx8J9eNRyB3YvG6uzWiB3TNior1byu0G
5DCm0UhsKkKFAa+o698qKMUvkrhzu1z5hQIAfxQY1dePp2mIfZ02fpAvfiLBwyud
atb++whW+WVRCdP0PmEk5/VOjdPVNOXsLDU1NmaxIkUpCcwTz/6okIOSzMnxQe7u
67x76Ux9bHdKjSAjb1HcbTyMaCoCn6Ad6miOISU03d9hFQumZRs=
=oyTu
-----END PGP SIGNATURE-----

--uzd22rhmxyob4kzr--

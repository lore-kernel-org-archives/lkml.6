Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C470CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8585C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8585C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeIJTRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:17:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41808 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeIJTRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:17:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 50299208B9; Mon, 10 Sep 2018 16:23:01 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D847208A4;
        Mon, 10 Sep 2018 16:22:51 +0200 (CEST)
Date:   Mon, 10 Sep 2018 16:22:50 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/5] dt-bindings: sun4i-drm: drop second PLL from A64
 HDMI PHY binding
Message-ID: <20180910142250.he54s4pm436qyshs@flea>
References: <20180907072234.48282-1-icenowy@aosc.io>
 <20180907072234.48282-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ats4uxpwvt5bttal"
Content-Disposition: inline
In-Reply-To: <20180907072234.48282-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ats4uxpwvt5bttal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 03:22:30PM +0800, Icenowy Zheng wrote:
> By experiments it seems that the A64 HDMI PHY is not able to use the
> second video PLL as the clock parent.
>=20
> Drop pll-1 from the device tree binding of A64 HDMI PHY.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index f8773ecb7525..62034039cee1 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -114,7 +114,6 @@ Required properties:
> =20
>  H3 and A64 HDMI PHY require additional clocks:
>    - pll-0: parent of phy clock
> -  - pll-1: second possible phy clock parent (A64 only)

You shouldn't need to do this. The DT is about the hardware. The fact
that we haven't figured out how to use it is quite irrelevant, and can
change in the future, unlike this binding.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ats4uxpwvt5bttal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluWfjkACgkQ0rTAlCFN
r3Q74xAAjAa1HuH2fzpYeWb5biy+x0ryFWJ9JAiCK6EzpZpEmTLehp0OiOYN/o8A
SJCGj7w6rGb03c7n0Avj8jVmLvNSy3QDezl9mNyvTkQnH10rYAOccdlgYw6IY8iv
YdrDptgtVrVSmccpJDR0L8XYtrjCGnKr+tyWJNBczdxPD6ZAIBzHwI/gllbSFNs6
dCK8wFN1EEoyYtHeCrkd5Nis4rGLTcKL4ZpNi25aP+xgro4JOR0yAvDyl1yfQFra
GQtAj0YPaQnJ1BsP9MH57oJ/KyOYi19FX7GlfzdQMqIgonHHffYOWlX+GVrxlOKT
n56t4v9iDtcMBy+vn+lFdDtfzbAZ9lPKsoQLMHFHtjOw1V7JeNYySSGPSlVQU1Ku
rmZjM2mS5ZDnFwg1R922pzPMy1W+sg7hxW5q851rU6tlsz0ZPHT26YkhsZjejcDP
YFjQSAbMUVmQM5f7OP+LYYP18roVCBENRTIqp8ETcikaBNeGDjKY1DKXXyVGLxHL
8imO/2WC0oYlFyTbkat3Qu/Wc952Ddc4Y0uGS049sxazFIYK2zWLrTQFvVnJU2nc
SxTcievim0KbdDwzS7mIfN5f9zlA8fgVUzT1Ln4hJIX5ehG4fpcWGpYMawyBJ9fi
75AP4BamEDdFNHthv8wAoZajHrQVp2dLmK76Jgz8/RlxjQmZyXc=
=vbta
-----END PGP SIGNATURE-----

--ats4uxpwvt5bttal--

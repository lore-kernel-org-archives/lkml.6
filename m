Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B6C65BD1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047422084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047422084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJHPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:42:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36022 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbeJHPmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:42:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E2667207CC; Mon,  8 Oct 2018 10:32:03 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id AE15C2072D;
        Mon,  8 Oct 2018 10:31:53 +0200 (CEST)
Date:   Mon, 8 Oct 2018 10:31:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2 01/29] dt-bindings: bus: add H6 DE3 bus binding
Message-ID: <20181008083154.hhrelzmmpbjwu7sy@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3log35b4kqixjsi6"
Content-Disposition: inline
In-Reply-To: <20181007093905.11253-2-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3log35b4kqixjsi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2018 at 11:38:37AM +0200, Jernej Skrabec wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> The Allwinner H6 DE3 bus is similar to the A64 DE2 one.
>=20
> Add its compatible string with the A64 string as fallback to the
> binding.
>=20
> Some description of the binding is modified to make it more generic.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt b/D=
ocumentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> index 87dfb33fb3be..ac1445b95f41 100644
> --- a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> +++ b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> @@ -1,11 +1,14 @@
> -Device tree bindings for Allwinner A64 DE2 bus
> +Device tree bindings for Allwinner DE2/3 bus
> =20
>  The Allwinner A64 DE2 is on a special bus, which needs a SRAM region (SR=
AM C)
> -to be claimed for enabling the access.
> +to be claimed for enabling the access. The DE3 on Allwinner H6 is at the=
 same
> +situation, and the binding also applies.
> =20
>  Required properties:
> =20
> - - compatible:		Should contain "allwinner,sun50i-a64-de2"
> + - compatible:		Should be one of:
> +				- "allwinner,sun50i-a64-de2"
> +				- "allwinner,sun50i-a6-de3", "allwinner,sun50i-a64-de2"

                                                    ^ that would be h6 I gu=
ess?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3log35b4kqixjsi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7FfkACgkQ0rTAlCFN
r3TIgQ//SivUUsAlT5b1rfWXw2uIAhHhSS1ujd0WM58KWZ9Wcfj/H/DqwxwKsf6a
VhV6JRjh47bNCPgR6uHoNAnzG5/3rFCKqgRxDynEXiE2cKtX6X28rEMUGC19Fzub
t4AHDv94quEB3UCpSlsmZ64UnizUqw5gpQBkpihCub/EFvd31ro5cYRcb5ovlqem
fjVZsYaL74e7BfgpYWi7hlqpUY3JMf7SzigkCDLrsS9t/DeHFq/ESwYTiY2R/l5O
Ktjq75/PyM0hhDFIxiiQpJa2HRIMAXfVIXYkQRwAp8VrAuQ4usZ6jMWp/q7LE/yx
dLUUHPwH5nkm8KtFGJ0p1zvPwxc68qCsiNf7bStxrzfd/UEjtsorhqoV6bxNrM7g
HJjXpK74tgWadAQDOvNXp05TJveHy1MfCad8UY6uoPKRwEIkZqFo87l5xwMR36xT
3k5MKwb9rFTnvV5Uk4mbnV8n+m+E0ksMZEl0EHmDDt1mf0WTIQ/OkAinSw6oSeZj
jyDPBcS/upsARcnTEfOhFjFGW8mNIVEylE1hmUJD/5zaKvzwSX9XLspSwMbMdWO3
FSSI+beJAojP73/qnZ8RxLQyPKg8qb9R0otNwaDahmaBvmC6EXSCPz0AP9l3ZE0t
hO7QTSjY+mPb88JQ6nM70ebx1HcBUmWHED5fSf3Mr3ECHwf8/74=
=AuM9
-----END PGP SIGNATURE-----

--3log35b4kqixjsi6--

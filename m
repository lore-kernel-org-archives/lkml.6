Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CED8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD12C2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD12C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJHOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:38:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32959 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeJHOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:38:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DEEE620898; Mon,  8 Oct 2018 09:27:53 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 95FC1207CC;
        Mon,  8 Oct 2018 09:27:43 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:27:43 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] ARM: dts: axp81x: add AC power supply subnode
Message-ID: <20181008072743.ecjb75nixm6wbp6b@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-3-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o6zad24q5tl26anv"
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-3-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o6zad24q5tl26anv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:32AM +0300, Oskari Lemmela wrote:
> Add AC power supply subnode for AXP81X PMIC.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  arch/arm/boot/dts/axp81x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
> index 043c717dcef1..67c17151b584 100644
> --- a/arch/arm/boot/dts/axp81x.dtsi
> +++ b/arch/arm/boot/dts/axp81x.dtsi
> @@ -69,6 +69,11 @@
>  		};
>  	};
> =20
> +	ac_power_supply: ac-power-supply {
> +		compatible =3D "x-powers,axp813-ac-power-supply";
> +		status =3D "disabled";
> +	};
> +

IIRC, when it's a DT node of something that has no address (register or
bus address), we order alphabetically the DT nodes within the same
parent node. So here, we would put it before axp_adc.

Thanks,
Quentin

--o6zad24q5tl26anv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7Bu8ACgkQhLiadT7g
8aO0OQ/9FWgY8uN6zoKN9UanALsJ/+9n3RmGFLqiGqbd9f57OdkHld0j05yYUiqx
TkOUZKUCj09zQvdy7MxszTTifEGMauZi3R5Rzo4MGp0HtBTn6RSUucHKbRJ6wE0r
BnqvtokMrK9qE9EThw65+mntSOWkHCPCLQ321lV8C1nZJyh7LKp8LetXmLSpALgY
EUCasx/gq2BULVuTsgOKfo7UbsyZYs4Oc4YA/jmiNH4rlV6c/RHrWPwSgaKzKoeT
pxcyPfxG22UZ2n8ghbF4U0PDvcqIxN9P50j18Ibo+LIOlu6CGmlmiAmqtaNR7U1J
LgKjQvvsOEsL70CVUbwX9WUC78PwyCXC4B3y7KdWaw7ZXRNRJgRxa8mY09XMUINE
2T412OFvQRb431d88fS3FilO9/MvsM/3iC32dnEOCbgIG0YTWybf+a06EDb3NSU2
uzLYwqjqwNJhXsN2neHsuqY9j3hG/GxKamAZIUqBLO7ZPVcUgUHG76XqlFGmF6Pr
IuKhyv+YSE2VZDz0CW6TBxeFo2t3d7CJKe25vdD5wVl5TmCUhHqebSRBUtMwk7IX
PRpGR2zZMiOrNS0SRq8bo7HNTP5peQke1ohJHtK68jE/0kv2Ex9Cy7+dCToQ8YBv
Fc1rg5yKe+zO1lKW/4SXy/tXXsrm9LF96socFleCKsViwjGuSdc=
=a6NW
-----END PGP SIGNATURE-----

--o6zad24q5tl26anv--

Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF091C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF507208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF507208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbeG0PWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:22:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38251 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbeG0PWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:22:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 877D620733; Fri, 27 Jul 2018 16:00:31 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5597B20618;
        Fri, 27 Jul 2018 16:00:31 +0200 (CEST)
Date:   Fri, 27 Jul 2018 16:00:32 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI
 output on A64 boards w/ HDMI
Message-ID: <20180727140032.go6f3dwzxrzfstzj@flea>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-11-icenowy@aosc.io>
 <20180727125615.ju23ecgm6y4rz7p5@flea>
 <8DF4600E-DFE4-47CD-B541-FFDD903A65FB@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7khuw5dmvnh5md2"
Content-Disposition: inline
In-Reply-To: <8DF4600E-DFE4-47CD-B541-FFDD903A65FB@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7khuw5dmvnh5md2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 09:26:11PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B47=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
8:56:15, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Fri, Jul 27, 2018 at 01:12:57AM +0800, Icenowy Zheng wrote:
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> index 1b9b92e541d2..1b972bade9f6 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> @@ -62,6 +62,21 @@
> >>  	chosen {
> >>  		stdout-path =3D "serial0:115200n8";
> >>  	};
> >> +
> >> +	connector {
> >> +		compatible =3D "hdmi-connector";
> >> +		type =3D "a";
> >> +
> >> +		port {
> >> +			hdmi_con_in: endpoint {
> >> +				remote-endpoint =3D <&hdmi_out_con>;
> >> +			};
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&de {
> >> +	status =3D "okay";
> >>  };
> >> =20
> >>  &ehci0 {
> >> @@ -82,6 +97,17 @@
> >> =20
> >>  };
> >> =20
> >> +&hdmi {
> >> +	hdmi-supply =3D <&reg_dldo1>;
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&hdmi_out {
> >> +	hdmi_out_con: endpoint {
> >> +		remote-endpoint =3D <&hdmi_con_in>;
> >> +	};
> >> +};
> >> +
> >>  &i2c1 {
> >>  	pinctrl-names =3D "default";
> >>  	pinctrl-0 =3D <&i2c1_pins>;
> >> @@ -99,6 +125,10 @@
> >>  	};
> >>  };
> >> =20
> >> +&mixer1 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >>  &mmc0 {
> >>  	pinctrl-names =3D "default";
> >>  	pinctrl-0 =3D <&mmc0_pins>;
> >> @@ -238,6 +268,10 @@
> >>  	status =3D "disabled";
> >>  };
> >> =20
> >> +&tcon1 {
> >> +	status =3D "okay";
> >> +};
> >
> >Is it working or not on the pine64?
>=20
> Not tested yet, as my main A64 device is Pine A64-LTS now.

It was last reported as broken, so it's better to leave it out of that
patch until someone figures it out.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--v7khuw5dmvnh5md2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltbJW0ACgkQ0rTAlCFN
r3QllA//exZmfAVzyiiH1jm4uSPE1bgA7XZC7jlWLVRwhkm4ZHCIjnCrSof1b4Up
1ndnaL8fujY+Tv5ZzclTb51hJ0r4pI30MehokD8gakgn59pc3BI0P+wpJKxDafsp
Ba7494kwY55iyJU/xlPHpwcll0od4J+5qMT3qie6GGqH0yIkkvz2iiWZtTod89Dd
l5vdmtYX+arqo+XA1E8uDzG/0Rlu24UkKCE/rKqDXXIsEPfTvz9AHaAUmYDw1glI
5pyWbHweasNtsiBQJMRAIvkVMY6HwDVkVRmigz6Rt6oxzKPzOZ2tfamXGmDSjEfp
knckzERBdco0RsB/29Kze1w3C1VcO1wN7JJcRWPMEqD5ZtSNJRe32JV40JiwKcgH
A9Vw8NdmqQp8UdUs6mj2JmPzPYbDp6g/kJtC+TUxJnuOYb2r9gJX++mIKueUa6hC
Reqx5DQdY3KRhQTeQkjnbuF3+9ipyeT2Tzn48LnIG6gjns6EVTefAT1JKuRii+Pz
LsZVA129CJsTrAexRN1GL9zzuJuwmnmqu/+d0PdfW+CSXS0WKrb+ziyZcSwM4wPR
U+8k4R0H3/4F7aR9Z50B5dhn/Evh+B9nEGdQUMuFf0coawkB9KoqRnLBBvH4yiiz
HsKCPQYT6aZBSegoSAkPO/U6S+wYIqXw8KavPOLF11H2gtvQHCE=
=oa88
-----END PGP SIGNATURE-----

--v7khuw5dmvnh5md2--

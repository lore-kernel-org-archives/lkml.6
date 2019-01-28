Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB36C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1962084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="JD3ygfcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390686AbfA1Qov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:44:51 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:34954 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbfA1Qor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mGB8DEDySB6RHrLQInzE74pNyXQC/5XZJ4QtJxmbywg=; b=JD3ygfcs+iL7S+RZ3FbqWlKbw
        1YPgWo21TiwtUDiZmPh2jxmwEVBxnxCLqhnXilmNP8TLFFo/D5QgHZIzmKQwP7ulS2K8kh9lPTdl/
        1FQHqojjvSXC8YC+mZ4co+Xz4JI5nkuWRuvRKzHt0d0Vf6TaRGs1s782BKCeZdDHiWR6w=;
Received: from p200300ccfbcaa5007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbca:a500:7ee9:d3ff:fe1f:a246] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1goA1Y-0007Gz-AI; Mon, 28 Jan 2019 17:44:40 +0100
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1goA1V-0002f6-LS; Mon, 28 Jan 2019 17:44:37 +0100
Date:   Mon, 28 Jan 2019 17:44:29 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] arm: dts: gta04: add gps support
Message-ID: <20190128163025.7daa385b@kemnade.info>
In-Reply-To: <20190128075356.GJ3691@localhost>
References: <20190125194310.11170-1-andreas@kemnade.info>
 <20190128075356.GJ3691@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jnd3g4.rS3VPk9X7AQnelhT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jnd3g4.rS3VPk9X7AQnelhT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jan 2019 08:53:56 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Fri, Jan 25, 2019 at 08:43:10PM +0100, Andreas Kemnade wrote:
> > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > which one is mounted so use the compatibility entry for w2sg0004
> > for all which will work for both.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > w2sg0004 bindings (together with the corresponding support is in
> > https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next)
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/oma=
p3-gta04.dtsi
> > index e53d32691308..d58c117e429f 100644
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -312,6 +312,12 @@ =20
> >  		>; =20
> >         };
> > =20
> > +	gps_pins: pinmux_gps_pins {
> > +		pinctrl-single,pins =3D <
> > +			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* gpio1=
45 */
> > +		>;
> > +	};
> > +
> >  	hdq_pins: hdq_pins {
> >  		pinctrl-single,pins =3D <
> >  			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda=
.hdq */
> > @@ -644,6 +650,13 @@
> >  &uart2 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&uart2_pins>;
> > +	gps: gps { =20
>=20
> The node should be named "gnss" as per the binding.
>=20
> > +		compatible =3D "wi2wi,w2sg0004";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&gps_pins>;
> > +		sirf,onoff-gpios =3D <&gpio5 17 GPIO_ACTIVE_HIGH>;
> > +		lna-supply =3D <&vsim>; =20
>=20
> Also, the vcc-supply is a required property.
>=20
well, it is not require in the driver and it has different behavior (on eve=
n when not opened if
on-off is there) than the lna-supply used here. So maybe fix the binding do=
cumentation?

Regards,
Andreas

--Sig_/jnd3g4.rS3VPk9X7AQnelhT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxPMW0ACgkQl4jFM1s/
ye9ZoQ//VDB79MrCEDDdmoQ81Yg/OoS+lifHW5tNqOVyNrMNVaOxBwLU6K58X7w6
2eCBj79lc4EDxhanbw5b2dczCyi5HdaeOPPkQu3exYonnXAw1j9+tAEEz6howJXu
9c/FOO4AsiUuyIqbMtHg+Vu93ydGhWuA2xG4PBwwIXdacLUTtkL7MRQfQadUpHt+
w4cBm+BR0AsWJQETP2Y0qu8XfRTUJ1tXyO96UUt3USzPOW58LhY6Dw3llBaLActc
vkKRa8yr1NppxwBqixnSpXI6AG1l0MuQnSQhsF0D3J1TbYnLbYDpyeitMBbe1Vmf
Cr0kA7VKVJ0chSCVZOuFBhGmbG6cgwxFK91tu/Fo6ZjIMXCfzyY7PFjPAqevpp4a
skkEZMiCL6WdHabKVGRJiFnCOOXEEq/RZguXNhvUF9GHTlFP0vWtz6+ozgc6gNWv
97C/02Oo49qkTnrJHvhBdZ05iq7TD8hlurjSnwq2c1rk4CSIWVD6nkkgI+Nii87D
4Fr20DUhcyJtyDE0h0MP4fXvLTrMsPuRM4dY+y6LCR8uwaFBNv5mB+DmUxfS/gJ6
IvUWEtgJ94jc6e4a2W3gc6L0jQS7TiMedlwIN0/Ebyrekt1tWHyvZEahHzcWrY7U
dWH1kNyNG3QyFB6AHUfqlkri5z7zpYNsmHScTtjaXTM0ZKCgE+Q=
=r8SB
-----END PGP SIGNATURE-----

--Sig_/jnd3g4.rS3VPk9X7AQnelhT--

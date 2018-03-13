Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964902AbeCMPmJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:42:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50735 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934567AbeCMPmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:42:06 -0400
Date: Tue, 13 Mar 2018 16:41:54 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCH 5/5] arm64: allwinner: a64: Add support for TERES I laptop
Message-ID: <20180313154154.lnzomhknzfuv7gqy@flea>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180312161050.7647-6-harald@ccbib.org>
 <20180313084108.uh3ui5jwin2knvuu@flea>
 <E1evhmK-0000OI-Nw@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ebyjolsfirckcycp"
Content-Disposition: inline
In-Reply-To: <E1evhmK-0000OI-Nw@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ebyjolsfirckcycp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 12:07:36PM +0100, Harald Geyer wrote:
> >> +/ {
> >> +	model =3D "Olimex Teres I A64";
> >=20
> > It's called the Teres-I, there's no need for the A64 here
>=20
> Olimex said in the past they want the Teres to be very modular, with
> boards for different SoCs compatible with each other on the level of
> external pins. The PCBs we have right now are labled like
> TERES_PCB1-A64-MAIN, TERES-PCB2-IO, etc. - I wouldn't be surprised if
> they start selling TERES_PCB1-x86-MAIN to be put into your average Teres =
I,
> so I felt this naming was safer.
>=20
> However I specifically CCed them on this series, so they can comment on
> issues such as this one...

Then maybe call it A64 Teres-I to be consistent with the compatible?

> >> +		compatible =3D "gpio-leds";
> >> +
> >> +		led_capslock: capslock {
> >=20
> > Same thing here
>=20
> I was kind of hoping I could use it to link the led to the keyboard,
> so that it goes on when the capslock key is pressed. But no such luck:
> 1) There seems to be no binding for external leds in the input subsystem.
> 2) The keyboard is a usb one and get enumerated automatically, so not DT
>    node by default.
>=20
> I guess I can remove it, but then I guess labels for the leds might be
> helpful when further customizing the DT locally, so why not just keep the=
m?

I'm not sure that would be useful either. I'd expect someone modifying
the DT locally that they would modify the DT directly, and you already
have the node there.

> >> +	reg_usb1_vbus: usb1-vbus {
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "usb1-vbus";
> >> +		regulator-min-microvolt =3D <5000000>;
> >> +		regulator-max-microvolt =3D <5000000>;
> >> +		enable-active-high;
> >> +		gpio =3D <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
> >> +		status =3D "okay";
> >=20
> > I guess this one has a parent regulator too?
>=20
> Unless I failed to read the schematic correctly: No.
> The step-up converter providing 5V power for the usb1-vbus is connected
> directly to the IPS (intelligent power source) output of the PMIC and
> enabled directly by the 3.3V supply. So technically of course there is
> a parent regulator, but nothing we can control from software.

Ok

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ebyjolsfirckcycp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqn8UEACgkQ0rTAlCFN
r3QQ1A//Yo+yqqvqTH1Ovfy8TzF7NFg13GXct8S7ojdaObp4A3H//QruDD2kGcy1
8onkOw3/aMJiFKXOcifiD+azpeeNSDV/qHh71JMYpadC600YMAeepNjEDDUBkXZW
wDADTWfE5z4OlNeMQ3s3MVr+ZABsuIKt4HIs4HotOuVFVQrMGmi2Ey4v++RIxts9
XHYjG3mP4HDCv/3YePkeQks6Yx8IktkSZDWqH2568B0niTjRWcqijSMq+pGiHqQa
n37H1VBBgZYlhWB3gOW1jLFoL/22B/dKC2xOf1l1WC8/09ks9J1RAXID6zqm34TM
AKuiXC+eyjYE30Q+Rlh+ynRwGPypOqtViKagqScb7ZId1LULq0jj1V7BezGECNsw
GzGdjI993YfYslrxZHZojf2Dk8YCKZwMryk39cB9dTRRqI/BaedF6Kr4wGQg10Sp
sso/hGa5/B6S+jSS4+qLEV27I6QQ9TXQ8xMyh7pDyISwUteQBzMPZdoaVMoNmrr9
Q9349vUCq5CnSHgmPNMGphxR4FYQp6ZhzwLAtorAxEZSUDuc0VlOib/pDO1xUAAQ
XVCaBRvhfJrWFTGVdaqXm8nodK+lFhjFUn2upH8yQbIk3ubCUCJgPDMykpf/PJsc
CnxxfJDtssSS2QKnl9M106OBUJa+OyJLs1LyIWHs+Lpy4DlzWog=
=1lhW
-----END PGP SIGNATURE-----

--ebyjolsfirckcycp--

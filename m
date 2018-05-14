Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeENI1t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:27:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33839 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeENI1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:27:47 -0400
Date: Mon, 14 May 2018 10:27:45 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: Allwinner A64: Issue on external rtc clock to wifi chip
Message-ID: <20180514082744.ydmfg5mzsbol5onu@flea>
References: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
 <20180514075727.uxggyhmbahvhestx@flea>
 <CAMty3ZDew=+zytKUx5+nX27CjCe0UfJpyYOy2s07NoJvbe57mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ko2m32o4savwftrl"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDew=+zytKUx5+nX27CjCe0UfJpyYOy2s07NoJvbe57mQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ko2m32o4savwftrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 01:34:56PM +0530, Jagan Teki wrote:
> On Mon, May 14, 2018 at 1:27 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Mon, May 14, 2018 at 12:37:49PM +0530, Jagan Teki wrote:
> >> Hi Maxime and All,
> >>
> >> We are trying to bring-up AP6330 Wifi chip for A64 board. We noticed
> >> to have an external rtc clock has driven from wifi chip.
> >>
> >> So the devicetree is configured according to this as below.
> >>
> >> / {
> >>         wifi_pwrseq: wifi-pwrseq {
> >>                 compatible =3D "mmc-pwrseq-simple";
> >>                 clocks =3D <&rtc 1>;
> >>                 clock-names =3D "ext_clock";
> >>                 reset-gpios =3D <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> >>                 post-power-on-delay-ms =3D <400>;
> >>         };
> >> };
> >>
> >> &rtc {
> >>         clock-output-names =3D "rtc-osc32k", "rtc-osc32k-out";
> >>         clocks =3D <&osc32k>;
> >>         #clock-cells =3D <1>;
> >> };
> >>
> >> &mmc1 {
> >>         pinctrl-names =3D "default";
> >>         pinctrl-0 =3D <&mmc1_pins>;
> >>         vmmc-supply =3D <&reg_dcdc1>;
> >>         vqmmc-supply =3D <&reg_eldo1>;
> >>         mmc-pwrseq =3D <&wifi_pwrseq>;
> >>         bus-width =3D <4>;
> >>         non-removable;
> >>         status =3D "okay";
> >>
> >>         brcmf: wifi@1 {
> >>                 reg =3D <1>;
> >>                 compatible =3D "brcm,bcm4329-fmac";
> >>                 interrupt-parent =3D <&r_pio>;
> >>                 interrupts =3D <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAKE-A=
P: PL3 */
> >>                 interrupt-names =3D "host-wake";
> >>         };
> >> };
> >>
> >> And observed rtc-osc32k-out clock is never enabled[1] and the value of
> >> LOSC_OUT_GATING is 0x0 which eventually not enabling
> >> LOSC_OUT_GATING_EN
> >>
> >> Pls. let us know if we miss anything here?
> >>
> >> [1] https://paste.ubuntu.com/p/X2By4q8kD2/
> >
> > Could you paste your config and the logs from a boot to?
>=20
> .config
> https://paste.ubuntu.com/p/w9w2KB7RFc/
>=20
> dmesg
> https://paste.ubuntu.com/p/mrZGk5bWRR/

This is kind of weird. Have you tested with a 4.17 kernel? We have
runtime_pm changes lined up in next, so that might be a regression
there, even though we tested it with Quentin at some point.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ko2m32o4savwftrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5SIAACgkQ0rTAlCFN
r3SREQ//Sd9Vzci56gaoyeqJquVHEj0I9cyPBRIGk+3DwMfke5cCN8xoPpbK2epJ
slxXhGW0oiuB1zm6azMb0xkE6TnpaImVQp4Vx1wUzjnQgKAvKwuFq+tCpjP3bqUY
wkO4SI4pE841l4XaWyJ6M7fEyCJrIGf396xRcaVtRD7/5WHec6w2+T26H41McKek
kTlYQkg01j3b5HFMXX0SJ0i415x+eGFRW9xoOjM/WYznnUlM60GikJ06LQKe2zim
s86eqX8V0+Ef+7LRXVv99qgzv655afCu7/9n42aC+fIPqSgFRHllO0hu+qQCQSaU
3ISkC1OGlGTBOI1iGhajFyNOJDG5Pw3MT7Wvk03P4HDjgHAh1ErX/44D9zjt0mQB
b+AyNP9uP5c2QnBYGAxGG2fjbyFI5rgk8WRFNGnE6eQzEexNKJN1UZ28w4OmlYKx
YV1sBn/Gd1GAIjYUHB72CoArTtG7uVhYtqnJAoTJ8/koaPFKZdIQklihrE6dpCr9
lUHsruEosYqXzNTy7vbWFTU1hr4ollZqt6PsocZA82aMQW3epNrAp/xatIqyCSVc
b/hJ6uHwim8+zAlv5l43EUJRxP4a+YJ132nJpFVJ2k8dCNSP40oVAkHmE4lkI04A
yzx0KL+PpmqmLaG/6Ex+yaGisS3TZ9Uvp76PFWkuDkqWgpIrj64=
=6V4c
-----END PGP SIGNATURE-----

--ko2m32o4savwftrl--

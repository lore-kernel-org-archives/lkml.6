Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeENLRj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:17:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42916 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbeENLRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:17:38 -0400
Date: Mon, 14 May 2018 13:17:26 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: Allwinner A64: Issue on external rtc clock to wifi chip
Message-ID: <20180514111726.lnxpegipqklyetmv@flea>
References: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
 <20180514075727.uxggyhmbahvhestx@flea>
 <CAMty3ZDew=+zytKUx5+nX27CjCe0UfJpyYOy2s07NoJvbe57mQ@mail.gmail.com>
 <20180514082744.ydmfg5mzsbol5onu@flea>
 <CAMty3ZC3ggxkZwirpQ-aRP8Udg=aYypBArb0KcR0_Z0AG8wATA@mail.gmail.com>
 <20180514090618.r5xc3elzpvfp47f4@flea>
 <CAMty3ZCAWBHtemeeWcgLy5PoYLn10MwxpHdirqpsxFY3BA7=4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwemxfhk4a6ebnef"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCAWBHtemeeWcgLy5PoYLn10MwxpHdirqpsxFY3BA7=4g@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwemxfhk4a6ebnef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 03:12:49PM +0530, Jagan Teki wrote:
> On Mon, May 14, 2018 at 2:36 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Mon, May 14, 2018 at 02:34:22PM +0530, Jagan Teki wrote:
> >> On Mon, May 14, 2018 at 1:57 PM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >> > On Mon, May 14, 2018 at 01:34:56PM +0530, Jagan Teki wrote:
> >> >> On Mon, May 14, 2018 at 1:27 PM, Maxime Ripard
> >> >> <maxime.ripard@bootlin.com> wrote:
> >> >> > Hi,
> >> >> >
> >> >> > On Mon, May 14, 2018 at 12:37:49PM +0530, Jagan Teki wrote:
> >> >> >> Hi Maxime and All,
> >> >> >>
> >> >> >> We are trying to bring-up AP6330 Wifi chip for A64 board. We not=
iced
> >> >> >> to have an external rtc clock has driven from wifi chip.
> >> >> >>
> >> >> >> So the devicetree is configured according to this as below.
> >> >> >>
> >> >> >> / {
> >> >> >>         wifi_pwrseq: wifi-pwrseq {
> >> >> >>                 compatible =3D "mmc-pwrseq-simple";
> >> >> >>                 clocks =3D <&rtc 1>;
> >> >> >>                 clock-names =3D "ext_clock";
> >> >> >>                 reset-gpios =3D <&r_pio 0 2 GPIO_ACTIVE_LOW>; /*=
 PL2 */
> >> >> >>                 post-power-on-delay-ms =3D <400>;
> >> >> >>         };
> >> >> >> };
> >> >> >>
> >> >> >> &rtc {
> >> >> >>         clock-output-names =3D "rtc-osc32k", "rtc-osc32k-out";
> >> >> >>         clocks =3D <&osc32k>;
> >> >> >>         #clock-cells =3D <1>;
> >> >> >> };
> >> >> >>
> >> >> >> &mmc1 {
> >> >> >>         pinctrl-names =3D "default";
> >> >> >>         pinctrl-0 =3D <&mmc1_pins>;
> >> >> >>         vmmc-supply =3D <&reg_dcdc1>;
> >> >> >>         vqmmc-supply =3D <&reg_eldo1>;
> >> >> >>         mmc-pwrseq =3D <&wifi_pwrseq>;
> >> >> >>         bus-width =3D <4>;
> >> >> >>         non-removable;
> >> >> >>         status =3D "okay";
> >> >> >>
> >> >> >>         brcmf: wifi@1 {
> >> >> >>                 reg =3D <1>;
> >> >> >>                 compatible =3D "brcm,bcm4329-fmac";
> >> >> >>                 interrupt-parent =3D <&r_pio>;
> >> >> >>                 interrupts =3D <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-=
WAKE-AP: PL3 */
> >> >> >>                 interrupt-names =3D "host-wake";
> >> >> >>         };
> >> >> >> };
> >> >> >>
> >> >> >> And observed rtc-osc32k-out clock is never enabled[1] and the va=
lue of
> >> >> >> LOSC_OUT_GATING is 0x0 which eventually not enabling
> >> >> >> LOSC_OUT_GATING_EN
> >> >> >>
> >> >> >> Pls. let us know if we miss anything here?
> >> >> >>
> >> >> >> [1] https://paste.ubuntu.com/p/X2By4q8kD2/
> >> >> >
> >> >> > Could you paste your config and the logs from a boot to?
> >> >>
> >> >> .config
> >> >> https://paste.ubuntu.com/p/w9w2KB7RFc/
> >> >>
> >> >> dmesg
> >> >> https://paste.ubuntu.com/p/mrZGk5bWRR/
> >> >
> >> > This is kind of weird. Have you tested with a 4.17 kernel? We have
> >> > runtime_pm changes lined up in next, so that might be a regression
> >> > there, even though we tested it with Quentin at some point.
> >>
> >> This is 4.17-rc4 do you want to try it on 4.16 ?
> >
> > No, this is next-20180503. Please try with 4.17-rc4
>=20
> Couldn't find any different in behaviour [2]
>=20
> [2] https://paste.ubuntu.com/p/m3PGBwrv6W/

It's hard to tell without the board, but have you looked at the return
value of devm_clk_get in the pwrseq code?

Enabling the clk ftrace events would also help.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rwemxfhk4a6ebnef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5cEUACgkQ0rTAlCFN
r3SGOg//U+w+Ojukr19zd4krXZ6U5Whz9g0rxvaLjGZGM/EzSOe4ZFxlB52TgjgQ
Vb/c0BxR+LL2oBxO8sWYIgHpy7IOAm6AS3M6uhTyMFk7XrKBJ72LVfpd1mPoh780
tTZbUT2Lx7ecuosYalSLN06GfXEbMlhc415MCiKHPELLwIDpgXeVi0UEYahkzskP
BdsULGQGwMDHO3+vjUTcSSl9ByrboISua974SMONklEBe3757toLmzAonqEOoVNb
UhSl97BX5v1+ZtZQArEtQ6XFse7CZdyRZXxUrHxy/cB+ByeRiUSX7zr+4UKnd23n
DbYtTk0zhZbaM8Hs4/x0XSijizSstwNZctUTCamFIhInAaqmgEf6pebqy3GKCtw5
9edYXMWPPfb7O16ad1UvwJ2oPnumRkqZpzPeuJELV9TratoVa/HDNk3N3acZm+Ri
ZxdL8GjhRM2fVNg0eW3bTOH+U+UrLoX0NtrUyyK2mKdwtCx3MNWGkLR/JlKQYejx
OjRnF9kNumqaWvY3gBayyb1dm84Ev/zEiX4u3UKLOoeCzXJLSEsOpGfp+A5qNic2
BuyOGoLQ9BIg3Q+Gde8tYOgJBrQAJL6uSWwQCon1RMFcYHJXwaXa6+SBoCcyYo58
LuSW0oM18A93l024nOw9l7mP5sGfPvPhErcE2hFxlbhuMqjFmu8=
=rx9p
-----END PGP SIGNATURE-----

--rwemxfhk4a6ebnef--

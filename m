Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeENJGi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:06:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36342 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752683AbeENJGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:06:35 -0400
Date: Mon, 14 May 2018 11:06:18 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: Allwinner A64: Issue on external rtc clock to wifi chip
Message-ID: <20180514090618.r5xc3elzpvfp47f4@flea>
References: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
 <20180514075727.uxggyhmbahvhestx@flea>
 <CAMty3ZDew=+zytKUx5+nX27CjCe0UfJpyYOy2s07NoJvbe57mQ@mail.gmail.com>
 <20180514082744.ydmfg5mzsbol5onu@flea>
 <CAMty3ZC3ggxkZwirpQ-aRP8Udg=aYypBArb0KcR0_Z0AG8wATA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ukibym7r2ti6656l"
Content-Disposition: inline
In-Reply-To: <CAMty3ZC3ggxkZwirpQ-aRP8Udg=aYypBArb0KcR0_Z0AG8wATA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ukibym7r2ti6656l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 02:34:22PM +0530, Jagan Teki wrote:
> On Mon, May 14, 2018 at 1:57 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Mon, May 14, 2018 at 01:34:56PM +0530, Jagan Teki wrote:
> >> On Mon, May 14, 2018 at 1:27 PM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >> > Hi,
> >> >
> >> > On Mon, May 14, 2018 at 12:37:49PM +0530, Jagan Teki wrote:
> >> >> Hi Maxime and All,
> >> >>
> >> >> We are trying to bring-up AP6330 Wifi chip for A64 board. We noticed
> >> >> to have an external rtc clock has driven from wifi chip.
> >> >>
> >> >> So the devicetree is configured according to this as below.
> >> >>
> >> >> / {
> >> >>         wifi_pwrseq: wifi-pwrseq {
> >> >>                 compatible =3D "mmc-pwrseq-simple";
> >> >>                 clocks =3D <&rtc 1>;
> >> >>                 clock-names =3D "ext_clock";
> >> >>                 reset-gpios =3D <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL=
2 */
> >> >>                 post-power-on-delay-ms =3D <400>;
> >> >>         };
> >> >> };
> >> >>
> >> >> &rtc {
> >> >>         clock-output-names =3D "rtc-osc32k", "rtc-osc32k-out";
> >> >>         clocks =3D <&osc32k>;
> >> >>         #clock-cells =3D <1>;
> >> >> };
> >> >>
> >> >> &mmc1 {
> >> >>         pinctrl-names =3D "default";
> >> >>         pinctrl-0 =3D <&mmc1_pins>;
> >> >>         vmmc-supply =3D <&reg_dcdc1>;
> >> >>         vqmmc-supply =3D <&reg_eldo1>;
> >> >>         mmc-pwrseq =3D <&wifi_pwrseq>;
> >> >>         bus-width =3D <4>;
> >> >>         non-removable;
> >> >>         status =3D "okay";
> >> >>
> >> >>         brcmf: wifi@1 {
> >> >>                 reg =3D <1>;
> >> >>                 compatible =3D "brcm,bcm4329-fmac";
> >> >>                 interrupt-parent =3D <&r_pio>;
> >> >>                 interrupts =3D <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAK=
E-AP: PL3 */
> >> >>                 interrupt-names =3D "host-wake";
> >> >>         };
> >> >> };
> >> >>
> >> >> And observed rtc-osc32k-out clock is never enabled[1] and the value=
 of
> >> >> LOSC_OUT_GATING is 0x0 which eventually not enabling
> >> >> LOSC_OUT_GATING_EN
> >> >>
> >> >> Pls. let us know if we miss anything here?
> >> >>
> >> >> [1] https://paste.ubuntu.com/p/X2By4q8kD2/
> >> >
> >> > Could you paste your config and the logs from a boot to?
> >>
> >> .config
> >> https://paste.ubuntu.com/p/w9w2KB7RFc/
> >>
> >> dmesg
> >> https://paste.ubuntu.com/p/mrZGk5bWRR/
> >
> > This is kind of weird. Have you tested with a 4.17 kernel? We have
> > runtime_pm changes lined up in next, so that might be a regression
> > there, even though we tested it with Quentin at some point.
>=20
> This is 4.17-rc4 do you want to try it on 4.16 ?

No, this is next-20180503. Please try with 4.17-rc4

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ukibym7r2ti6656l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5UYkACgkQ0rTAlCFN
r3Ta6w/+MCFS5Ns6tQ98abOVs37/ycB3leNAEWjsSDsmTlmAQga/gsQoSI2Y9eLi
wVrmMYR87Gw0PoWKcvWQKN/zhgl3717LOhF77SCxB3AdQbsYWOVjXmLBJjOtup9h
PgTkAiaAo82hxT5J9ukiySez0F6OTxdHyu9QZVr/gFCGAj/VRDhpwFA18xC/j6Ml
seg3SjnW74WvzXIy726mw90izTOl0RNUwScVKBCVWathnQ46F0hJPLyTu2XGlerY
B6Y5nnvvmcsuEFRjwzjtcvKWwv1mkVc6dHzdBQGwD8RZaSyXVPPmzYfu9L11NkCw
2cqB+jRgMhYRd2mM/eRcVN8VRc3j3ZJpTCVCK/iTuYq/2wCFHAgd4xTQgbsNiSh/
EMqDmV/+qZQ1Cug6Xew/doXh5uwunurnLAW/+4Z+TxijW3UDgTzdeaKXCXF1bIsX
EKlcl62TYhNrJNMTxjnVohw+wgDPVWFP6/TvC5p2v8zb4Fz4WLsSZtd6dHt+f0rZ
UxcWnKPymjhWefHmJUQn1VK+9Rv8uUi8WmSFD3Y3bwbcYFLCFmEdbgF1nwJYmA/T
tqBoM3YVZKqadkmFS5MsaecfmIC451hYObnRy7FeZ7GhvRsO8i1OmlFQBWe8hAoj
Qit99dXnA40Tl6tzP6IzJNQ6NSmc2JtqIPE3Z1wBa0PiIXeErJw=
=0lEx
-----END PGP SIGNATURE-----

--ukibym7r2ti6656l--

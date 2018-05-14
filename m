Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeENH5c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:57:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60129 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbeENH5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:57:30 -0400
Date: Mon, 14 May 2018 09:57:27 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: Allwinner A64: Issue on external rtc clock to wifi chip
Message-ID: <20180514075727.uxggyhmbahvhestx@flea>
References: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kx3hdnajnzxhcs2n"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCNyuEwmLGdDZLM_9qKJ2NsT33rodug7ZpKAE-OHymVEg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kx3hdnajnzxhcs2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 14, 2018 at 12:37:49PM +0530, Jagan Teki wrote:
> Hi Maxime and All,
>=20
> We are trying to bring-up AP6330 Wifi chip for A64 board. We noticed
> to have an external rtc clock has driven from wifi chip.
>=20
> So the devicetree is configured according to this as below.
>=20
> / {
>         wifi_pwrseq: wifi-pwrseq {
>                 compatible =3D "mmc-pwrseq-simple";
>                 clocks =3D <&rtc 1>;
>                 clock-names =3D "ext_clock";
>                 reset-gpios =3D <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>                 post-power-on-delay-ms =3D <400>;
>         };
> };
>=20
> &rtc {
>         clock-output-names =3D "rtc-osc32k", "rtc-osc32k-out";
>         clocks =3D <&osc32k>;
>         #clock-cells =3D <1>;
> };
>=20
> &mmc1 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&mmc1_pins>;
>         vmmc-supply =3D <&reg_dcdc1>;
>         vqmmc-supply =3D <&reg_eldo1>;
>         mmc-pwrseq =3D <&wifi_pwrseq>;
>         bus-width =3D <4>;
>         non-removable;
>         status =3D "okay";
>=20
>         brcmf: wifi@1 {
>                 reg =3D <1>;
>                 compatible =3D "brcm,bcm4329-fmac";
>                 interrupt-parent =3D <&r_pio>;
>                 interrupts =3D <0 3 IRQ_TYPE_LEVEL_LOW>;  /* WL-WAKE-AP: =
PL3 */
>                 interrupt-names =3D "host-wake";
>         };
> };
>=20
> And observed rtc-osc32k-out clock is never enabled[1] and the value of
> LOSC_OUT_GATING is 0x0 which eventually not enabling
> LOSC_OUT_GATING_EN
>=20
> Pls. let us know if we miss anything here?
>=20
> [1] https://paste.ubuntu.com/p/X2By4q8kD2/

Could you paste your config and the logs from a boot to?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kx3hdnajnzxhcs2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5QWYACgkQ0rTAlCFN
r3SrtA/9GuZDqH3zmlBuHDU3zz9r657hhP6rc96xIVjb7hWNDLfrjc/w64LhmMiB
eZKWja/PO/31QhpU/wcHUjZgjoWaMSHCNhpZr0mVbw9DoVs9oJuEM/9wEH5NbqUj
ILC1px2uWVBaQW3AqTW2bow8MXMlX8bm0BpHf14bQsgcu0I2mVp/s+n8TJF0xPM7
/af61LG07HPLo+LNpq2RB60RhIHksx1+MfI4Rd5my6r1tMmrQBKYi0EE1M0BYY+u
p0V7znu1Q1Utqw/lHFgBQ9Np06GOUOVUsnjiOCQhbg3VX6TeUqUEJPefudr/QOwO
+kdcI6hvfHQLM6H8QNJXJxj2E3ep9TfWVTz5Bn5lqy6IS/cPwFr+5qKjvtUyhqvG
nwQH69b15Ww2riOc7CJYLBZfGSEwyIBt7kTu6O3R9YJw8PY/Jneu5uBBWQvzT02s
knVk6h46NU53LC06rqmHZ5ZI5iVPQP6e8tHEVn5ctcFmkZQ2CoB59wuxhMIznAFM
/zbuLfZf3k9yk4MH0M0w2bs9FmGgJ2wcQuq/LPw7xfOFjhrpJMrJjh2DcyDGqNMx
0XVzOUSNE1s/hjk+5r3RqMI0NTbwTZMdXKQtMS3pL3uZbqMOQLhOQKTlivCPJ2c+
kjz5aouVlL8w7Sid2lRCRPT1YMW4xWdqLXmzwzaRY6TVIe+VzbQ=
=b7od
-----END PGP SIGNATURE-----

--kx3hdnajnzxhcs2n--

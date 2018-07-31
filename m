Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06740C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1EC20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1EC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbeGaPzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:55:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39585 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbeGaPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:55:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D556720789; Tue, 31 Jul 2018 16:15:15 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id A462520731;
        Tue, 31 Jul 2018 16:15:15 +0200 (CEST)
Date:   Tue, 31 Jul 2018 16:15:16 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
Message-ID: <20180731141516.t67esj3dlatvm7gg@flea>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
 <20180730084519.iqyhvocxsfuopze7@flea>
 <CAMfw5YpH1nbO1eYGoAOEEreboHs3VEY61x8qRO-BYDcGS+DBqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6xewxfb3utvscbte"
Content-Disposition: inline
In-Reply-To: <CAMfw5YpH1nbO1eYGoAOEEreboHs3VEY61x8qRO-BYDcGS+DBqg@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6xewxfb3utvscbte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 11:17:44AM +0200, Diego Rondini wrote:
> >> +&uart1 {
> >> +     pinctrl-names =3D "default";
> >> +     pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
> >> +     status =3D "okay";
> >> +};
> >
> > I guess it is the BT chip? Which chip is it?
>=20
> Yes, according to schematics Bluetooth is on uart1.
> It's an Ampak 6212A with a Broadcom 43438 chip. To my understanding
> it's the same chip in the Raspberry Pi 3 B / B+ and Raspberry Zero W.
>=20
> I've tried to integrate support for Bluetooth with the following:
>=20
> &uart1 {
>     pinctrl-names =3D "default";
>     pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
>     status =3D "okay";
>=20
>     bluetooth {
>         compatible =3D "brcm,bcm43438-bt";
>         max-speed =3D <2000000>;
>         shutdown-gpios =3D <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
>         device-wakeup-gpios =3D <&pio 9 2 GPIO_ACTIVE_HIGH>; /* PL2 */
>         host-wakeup-gpios =3D <&pio 0 20 GPIO_ACTIVE_HIGH>; /* PA20 */
>     };
> };
>=20
> but the hci_bcm driver doesn't load automatically and doesn't probe
> the device when loaded manually. I haven't investigated further.

I would expect to have a clock and psosibly a regulator needed to
before being able to power the BT chip properly. You probably want to
double check the polarity of the GPIOs too.

At this point, the driver and the bindings are there, so there's no
real excuse to not enable it in the DT.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6xewxfb3utvscbte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltgbvMACgkQ0rTAlCFN
r3Tm4A//Te63jLNOfGouI+HoKPSmDm6kF8gK9EdUer9LbIJbecmilAdvl72C6md2
5mtoc21To/XRc6gGdNI8vn1NM1/dJ6FwcafnNXWJq4Iiu/uxxS/Rm8t7ZSkfUbcZ
jXpv/RTIj/pUqKjxJgdzadxmHU4rDX/X77igAHmcSQmJPGMx3VIjqBXj8hfY2us5
63Q1Z5isKDafU0wNuUT05F46euv6J77brAnwCok2SBLOzPIVjZOw06XPH5jyQ38X
owcQOEXGThmr2sYc4McT0cEjwq3zPlveV4RviI8LK67FeUJoFGhoF8du0b2wjVSK
7x5Jc08Ys4qM1jsvM9tWFNiVdUc+H62JTW9A9uShcMHg9hyD5HOEhlm0eoxy/wJn
mhxVIxfDQpsJe9C/N4NE4Ruvm7/LoMztPG+52PZwtlR/5k1IKX5UO5gGxuA61pyi
Y5oCBE790TQT6qQosJNA1RAM9h96E2/76cFkKQVVljyY1x4km2njaQoNAi7pZm81
3qE/3GlZVpfVyjENNu2e9aYahKVJMU7Fmi+WkZGKhwMEXkEhTkEejPiTeWiqgabG
Yp2Le3NngpWnSKlF+d8NeLcvuPQFbj0s6iqBEj6a0jN515uo+HjgFqg6OZzyVQmp
6lWu12r84QJ9AEwvwW96J3fjtrEjmZHm0nxrXsGX600a2IrnFsI=
=5LcL
-----END PGP SIGNATURE-----

--6xewxfb3utvscbte--

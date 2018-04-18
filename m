Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeDRLlv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:41:51 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:27247 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753971AbeDRLlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:41:49 -0400
Date: Wed, 18 Apr 2018 13:41:19 +0200
From: Alban <albeu@free.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Alban <albeu@free.fr>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode
 for the cells list
Message-ID: <20180418134119.2e587621@avionic-0020>
In-Reply-To: <20180417180040.04f53495@avionic-0020>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
        <20180417165420.423a691b@avionic-0020>
        <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
        <20180417180040.04f53495@avionic-0020>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6UANJLWS_b0VD=xXkYsV.zT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6UANJLWS_b0VD=xXkYsV.zT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Apr 2018 18:00:40 +0200
Alban <albeu@free.fr> wrote:

> On Tue, 17 Apr 2018 16:44:01 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>=20
> > Thanks for explaining,
> >=20
> > On 17/04/18 15:54, Alban wrote: =20
> > > This will not only allow reading the calibration data from nvmem, but
> > > will also create a partition on the MTD device, which is not acceptab=
le.
> > > With my proposed binding this would become:
> > >=20
> > > flash@0 {
> > > 	#address-cells =3D <1>;
> > > 	#size-cells =3D <1>;
> > > 	compatible =3D "s25sl064a";
> > > 	reg =3D <0>;
> > >=20
> > > 	nvmem-cells {
> > > 		compatible =3D "nvmem-cells";
> > > 		#address-cells =3D <1>;
> > > 		#address-cells =3D <1>;
> > >=20
> > > 		calibration: calib@404 {
> > > 			reg =3D <0x404 0x10>;
> > > 		};
> > > 	};   =20
> >=20
> > Why can't we make nvmem-cells node a nvmem provider in this case?
> > Which should work! =20
>=20
> TBH I just copied what have been done to fix the same problem with the
> MTD partitions. But yes we could also just extend the current binding
> to require a compatible string on each nvmem-cell, which would not
> require any code change to support.

However this scheme will not work if the device node binding already
have subnodes with addresses. The addressing, as specified by
#address-cells and #size-cells, might be incompatible or might overlap.
Using the nvmem-cells subnode solve this problem.

Alban


--Sig_/6UANJLWS_b0VD=xXkYsV.zT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1y7gAAoJEHSUmkuduC286NAP/1mYRWkrmms4OOs0JteVDswv
xo+aBOqxH2ju4yUUOlkt9VBNmt+HSmHPM+Wn/MEEQXrkY+fgK5ai+sz/RXGgAhu2
aq+5ZrsgDORpHpljPNAYMEmXSAud7lXzKlYBiEn7UiuA1nuJTxKhrsMJ35UQmBx7
A0DJDcDreXJqI09rVja0oU1IESkxZD9Aazl/36rvSrC2ZtOg977oMbagWaNHPhwb
4PGuW1MqVAxfR5dyBsKixiGhz2mLMnpO7sn+EpLoe/jez7OnjEMHKTG9BcrRAu7n
/OjjanxuZ/k6ISDXtcoHO5wrIvzdCLmemRXehuQ5OwgLZdKRr5CPmgBsc9Hp+82z
XAMJOhAvGl1q4J2bVm3GyNN8HepGwZSp8c0bp6/2ButkHVsFy1fO7qxNS0AcQsMt
bIEIEHTmYC/L80h/l8wQQXii3MvtP0SSCCHdoSXyukg2QGIof1WWeXW9VjQ3kp2a
7R4zodG7Px5SWRRuXuHQ+Uw5eYfxiBzRwt1NCyT6tns1cTD95UJhsMkc4kn8k82S
sUnkIuGlUIzIYdR9u5ANb7TEoqvnMbLhB0L5EquZKQ9pk/+UD2nbvU8Cdx9reOVQ
EaySaKuplXm1a4qASx8PeUw4bP6EAwu6RCxHZ0SlS9EYdgAlNykR2DOTExb8qWng
xpgYJQEaCm3JytPF9Kwy
=b649
-----END PGP SIGNATURE-----

--Sig_/6UANJLWS_b0VD=xXkYsV.zT--

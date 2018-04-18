Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeDRNfP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:35:15 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:37567 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752812AbeDRNfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:35:13 -0400
Date: Wed, 18 Apr 2018 15:34:40 +0200
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
Message-ID: <20180418153440.187ed16e@avionic-0020>
In-Reply-To: <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
        <20180417165420.423a691b@avionic-0020>
        <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
        <20180417180040.04f53495@avionic-0020>
        <20180418134119.2e587621@avionic-0020>
        <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
        <20180418143243.3c23493c@avionic-0020>
        <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AZ+RuJxPdBoTxXd12bCw6CQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AZ+RuJxPdBoTxXd12bCw6CQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Apr 2018 13:53:56 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 18/04/18 13:32, Alban wrote:
> >> I was also suggesting you to use nvmem-cell subnode, but make it a
> >> proper nvmem provider device, rather than reusing its parent device.
> >>
> >> You would end up some thing like this in dt.
> >>
> >> flash@0 {
> >> 	#address-cells =3D <1>;
> >> 	#size-cells =3D <1>;
> >> 	compatible =3D "s25sl064a";
> >> 	reg =3D <0>;
> >>
> >> 	nvmem-cells {
> >> 		compatible =3D "mtd-nvmem";
> >> 		#address-cells =3D <1>;
> >> 		#size-cells =3D <1>;
> >>
> >> 		calibration: calib@404 {
> >> 			reg =3D <0x404 0x10>;
> >> 		};
> >> 	};
> >> }; =20
> > But the root cause is in the nvmem binding, this conflict could exists =
=20
> No, the root cause is because of passing wrong device instance to nvmem=20
> core. And trying to workaround is the actual issue.

The data is stored on the MTD, so the nvmem provider is the MTD device.
I don't think it is a good idea to have a virtual device in the DT to
accommodate the nvmem API.

> > with any device type, not just MTD. I don't understand why we would want
> > such workarounds instead of just fixing the problem once and for all. =
=20
> AFAIU, This is not a workaround, this is how nvmem provider bindings are=
=20
> and all providers should try to follow it.
>=20
> I still do not understand what is the issue in making nvmem-cells node a=
=20
> proper nvmem provider device?

It is doable, but beside making the code more complex, AFAIU that would
goes against DT best practice as no such device exists in the hardware.
The DT should only represent that this device contains data that can be
requested by a driver, and ideally in the same way for all kind of
storages.

Alban

--Sig_/AZ+RuJxPdBoTxXd12bCw6CQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa10lxAAoJEHSUmkuduC28ohsQAOU+13gwBBmeFX9rVtwI/Et/
pz5qPpHgMWlofIb5UqqNP+jFYZQzd69H17rmHLXXB04pF6UA7qxvorYLsoHp9PAJ
uavZ3e4Wiavaj/g1iYkO6G5LQNWun5P/X6Cck86Wyz6JhTFhX3i6+0xDdmCC9ToY
X5sbA47pFFOq0N2s6H+NdYqL0RRtbW5vDzH8QN430h0hU/IFaWnfWKRovrznGVhP
/x8Wrv3SL2/HrL3anx5P2rcmNWv5cATrlpD6ASjZn8rXrDZJUGgsLQ3W9hYWgh1O
gAwv6to8REwmkiry4Ui9lJG2n3OEt+24fgtQxXs5s8p60z4rCgnMSNzqEHZwIzog
pF+tgV3l+xWzb8WlOtnBZbs3JM1fmg82vQrWEPH9j9c3iIqB1GjxQ/RnWT7r039u
xCeOeFZYJ92niRSzeD1xEID6oeW9gG2ezBL+3n6zLtk6Y+gAYMra6OJPBo+20Thu
A82PJd9Ah9NIrzTbB/fXkbvubzOJp49BBjR8mHolCRB9y8RJ3+G0Eeg+fYoADC5c
T/O+URuv//n1+g27t2BzBfAjFnLDWtqeaVknkw1FzOb/vzzsLaeqpKWMw6OM0gf1
jjjZeOK6bCgA5XN2nWxjgrkwFYrCIg0sZLEuMe9OlDAg7uV9OAxUrjlr9y4uNmqN
gqFr4TjR+/UNEElgsOHo
=kviY
-----END PGP SIGNATURE-----

--Sig_/AZ+RuJxPdBoTxXd12bCw6CQ--

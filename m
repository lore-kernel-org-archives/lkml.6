Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeDRMdP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:33:15 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:47968 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbeDRMdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:33:14 -0400
Date: Wed, 18 Apr 2018 14:32:43 +0200
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
Message-ID: <20180418143243.3c23493c@avionic-0020>
In-Reply-To: <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
        <20180417165420.423a691b@avionic-0020>
        <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
        <20180417180040.04f53495@avionic-0020>
        <20180418134119.2e587621@avionic-0020>
        <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qRNXTY2_RtgSGW0qHQjEJ5b"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qRNXTY2_RtgSGW0qHQjEJ5b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Apr 2018 13:12:48 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 18/04/18 12:41, Alban wrote:
> > On Tue, 17 Apr 2018 18:00:40 +0200
> > Alban <albeu@free.fr> wrote:
> >  =20
> >> On Tue, 17 Apr 2018 16:44:01 +0100
> >> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> >> =20
> >>> Thanks for explaining,
> >>>
> >>> On 17/04/18 15:54, Alban wrote: =20
> >>>> This will not only allow reading the calibration data from nvmem, but
> >>>> will also create a partition on the MTD device, which is not accepta=
ble.
> >>>> With my proposed binding this would become:
> >>>>
> >>>> flash@0 {
> >>>> 	#address-cells =3D <1>;
> >>>> 	#size-cells =3D <1>;
> >>>> 	compatible =3D "s25sl064a";
> >>>> 	reg =3D <0>;
> >>>>
> >>>> 	nvmem-cells {
> >>>> 		compatible =3D "nvmem-cells";
> >>>> 		#address-cells =3D <1>;
> >>>> 		#address-cells =3D <1>;
> >>>>
> >>>> 		calibration: calib@404 {
> >>>> 			reg =3D <0x404 0x10>;
> >>>> 		};
> >>>> 	}; =20
> >>>
> >>> Why can't we make nvmem-cells node a nvmem provider in this case?
> >>> Which should work! =20
> >>
> >> TBH I just copied what have been done to fix the same problem with the
> >> MTD partitions. But yes we could also just extend the current binding
> >> to require a compatible string on each nvmem-cell, which would not
> >> require any code change to support. =20
> >=20
> > However this scheme will not work if the device node binding already
> > have subnodes with addresses. The addressing, as specified by
> > #address-cells and #size-cells, might be incompatible or might overlap.
> > Using the nvmem-cells subnode solve this problem.
> >  =20
>=20
> I was also suggesting you to use nvmem-cell subnode, but make it a=20
> proper nvmem provider device, rather than reusing its parent device.
>=20
> You would end up some thing like this in dt.
>=20
> flash@0 {
> 	#address-cells =3D <1>;
> 	#size-cells =3D <1>;
> 	compatible =3D "s25sl064a";
> 	reg =3D <0>;
>=20
> 	nvmem-cells {
> 		compatible =3D "mtd-nvmem";
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
>=20
> 		calibration: calib@404 {
> 			reg =3D <0x404 0x10>;
> 		};
> 	};
> };

But the root cause is in the nvmem binding, this conflict could exists
with any device type, not just MTD. I don't understand why we would want
such workarounds instead of just fixing the problem once and for all.

Alban

--Sig_/qRNXTY2_RtgSGW0qHQjEJ5b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1zrsAAoJEHSUmkuduC28Q0cQAKQdYP/RHd/RrlAkHhAMFwBM
1lGLrNYd2ob3AzA5Xa/JvpRrYHCj3YNYktT9T2nrEaoXeCDPKqCnZQOBUm6h4UH3
R4YvfcPxbk8ZcDJ3hcymaVuF7ol544u53a1PPwOMJWcmHJ0D/u8FP4fkilFlvKYA
SsJZtKb9Gi7ja7p9ZKB3xmfuQQImLem4WxVuopGvKwKm4J83J3wge8Xic/nYV1kP
zMG+ZMzOvfcGToZSn/0l+2y/Y8Weg5vf/quDAgc6qk6zKSird7+f+EEZZ1OOfS3M
BuoHizAsurZvU/QiwvMnE2VJUdTTcuZfDVv++VoyFPIDkGiuzphx2COBHLCQFqEq
ywiN9QWjLPa5uh6I4OfDsnnfZCgVG1IbgmKcxNpc12my0hS/0U6tqs7ucJMX+7Iw
WfKs6ttf4Y+pOxJK/e4RZ9tiyUeK6aDLWRVuVavgNrAh0dTHtb/XTao1P/JfMqP4
shsqkWRkx06C17ghBI11HnsSzpVM3DfYcpDuRpkk0MRtm1qF698TjH/HGZ/3iOCj
gZqQVrKr690AMpT0etdTR46W1Nz5kAXP+IzL5oSfUkYM8jPK8Ub6X29aZglbNcdM
RiSiMiF4JD3mrcIJ7qy4nFsmKXfiy7hqTcREvZOCzH+BZEKxJDLOcW+UY0nEs29a
AlzkOVuaZsa2Spxh8iDa
=uFJx
-----END PGP SIGNATURE-----

--Sig_/qRNXTY2_RtgSGW0qHQjEJ5b--

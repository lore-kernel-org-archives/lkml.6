Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754028AbeDQRGA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:06:00 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:3326 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeDQQBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:01:10 -0400
Date: Tue, 17 Apr 2018 18:00:40 +0200
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
Message-ID: <20180417180040.04f53495@avionic-0020>
In-Reply-To: <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-2-git-send-email-albeu@free.fr>
        <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
        <20180417165420.423a691b@avionic-0020>
        <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YLeXxEFOUnyhF3V3rFza/6w"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YLeXxEFOUnyhF3V3rFza/6w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Apr 2018 16:44:01 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> Thanks for explaining,
>=20
> On 17/04/18 15:54, Alban wrote:
> > This will not only allow reading the calibration data from nvmem, but
> > will also create a partition on the MTD device, which is not acceptable.
> > With my proposed binding this would become:
> >=20
> > flash@0 {
> > 	#address-cells =3D <1>;
> > 	#size-cells =3D <1>;
> > 	compatible =3D "s25sl064a";
> > 	reg =3D <0>;
> >=20
> > 	nvmem-cells {
> > 		compatible =3D "nvmem-cells";
> > 		#address-cells =3D <1>;
> > 		#address-cells =3D <1>;
> >=20
> > 		calibration: calib@404 {
> > 			reg =3D <0x404 0x10>;
> > 		};
> > 	}; =20
>=20
> Why can't we make nvmem-cells node a nvmem provider in this case?
> Which should work!

TBH I just copied what have been done to fix the same problem with the
MTD partitions. But yes we could also just extend the current binding
to require a compatible string on each nvmem-cell, which would not
require any code change to support.

Alban

--Sig_/YLeXxEFOUnyhF3V3rFza/6w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1hopAAoJEHSUmkuduC28O7UQAL22SFho4/P7CylA+uQcs/zC
9kE/xD/hgrQ+dbnfJkrDgkebwW9RQb7WxSKjy5fzSxjCqEat5qAbPNeur25MEDbw
TbBbgaquxDoFA+g3aDm47Gx2LfycZJRpEkbByDJ18bbFCsFqDSccllXX6nfINroG
8rKKbZKambP7R3HQS5zJh0uIrG9Sl/uDZ6mpLC3QFf0mXi2cvOUbm49g0D28GHRf
MRF3Tsgmza1Pmfv1vSFaLCKXUuHSLTBMbXrmrS/u8W78yw+4cxrVXDA3WrcKXboK
bfjz+sEfCJQvRF3Ci2sUdRFaZ7GMZLc28CBVSxUCZGHMcreSXifL562rMIkSNIUP
pBK/CH/1gSKHN8sFKqUtsCZ+omXXaZyHw76zzrDCUQMvX2uA8dH3xa7Ezsdo+vCK
rPjyA24LgRbUvjxpiC9DotKeWV93yfTYW5UYl2sYjPHe59u7hiepEzABodOMKydD
Woap16GsSblZTzZ1fpykqrN/G4J24BHfDtnZYG/thpG1efHc6ZXf7KHMc4fCZnKF
7OyAIhw0SR35jnMFzZAAcuaGOpLfpVmDn6JhInu0zSJB0aNeojhnk8buXxtXtIYz
aSSmyYdkMqjjzmMC5JO00XhNYpm5xeGMxhxNqELTjcrWVCEOG6VdRVXsKK+97Myt
IZIk0BPwkeqPiDiFZJ2r
=UpNP
-----END PGP SIGNATURE-----

--Sig_/YLeXxEFOUnyhF3V3rFza/6w--

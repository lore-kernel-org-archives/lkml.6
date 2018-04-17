Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeDQMpa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:45:30 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:62546 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeDQMp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:45:27 -0400
Date: Tue, 17 Apr 2018 14:44:57 +0200
From: Alban <albeu@free.fr>
To: Rob Herring <robh@kernel.org>
Cc: Alban <albeu@free.fr>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 2/3] doc: bindings: Add bindings documentation for
 mtd nvmem
Message-ID: <20180417144457.2831140e@avionic-0020>
In-Reply-To: <20180416210851.shu73nlincslxlde@rob-hp-laptop>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
        <1521933899-362-3-git-send-email-albeu@free.fr>
        <20180416210851.shu73nlincslxlde@rob-hp-laptop>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YaQdhV8Xmwhoyq.u7ihIurc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YaQdhV8Xmwhoyq.u7ihIurc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Apr 2018 16:08:51 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Mar 25, 2018 at 12:24:58AM +0100, Alban Bedel wrote:
> > Config data for drivers, like MAC addresses, is often stored in MTD.
> > Add a binding that define how such data storage can be represented in
> > device tree.
> >=20
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> > Changelog:
> > v2: * Added a "Required properties" section with the nvmem-provider
> >       property
> > v3: * Fixed my name in From and Signed-off-by
> >     * Moved to the new nvmem binding with the nvmem-cells subnode
> > ---
> >  .../devicetree/bindings/nvmem/mtd-nvmem.txt        | 27 ++++++++++++++=
++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nvmem/mtd-nvmem.t=
xt
> >=20
> > diff --git a/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt b/Do=
cumentation/devicetree/bindings/nvmem/mtd-nvmem.txt
> > new file mode 100644
> > index 0000000..c819a69
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt
> > @@ -0,0 +1,27 @@
> > +=3D NVMEM in MTD =3D
> > +
> > +Config data for drivers, like MAC addresses, is often stored in MTD.
> > +An MTD device, or one of its partition, can be defined as a NVMEM prov=
ider
> > +by having an 'nvmem-cells' subnode as defined in nvmem.txt.
> > +
> > +Example:
> > +
> > +	flash@0 {
> > +		...
> > +
> > +		partition@2 { =20
>=20
> This unit address is not correct...

Is it because I ellipsed the #address-cells and #size-cells? I will add
them.
=20
> > +			label =3D "art";
> > +			reg =3D <0x7F0000 0x010000>; =20
>=20
> Lowercase hex.

Will do.

> > +			read-only;
> > +
> > +			nvmem-cells {
> > +				compatible =3D "nvmem-cells";
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > +
> > +				eeprom@1000 { =20
>=20
> "eeprom" isn't specific data. The purpose of the nvmem binding is to=20
> provide specific data fields like MAC addresseses.
>=20
> Plus "eeprom" is the node name for EEPROM devices.

This example is from a board using an ath9k chip and this field contains
what the driver names EEPROM, although it is in fact only a config
binary blob. However I agree that it is misleading for such an example,
I will replace it with something like "wifi-config-data".

Alban

--Sig_/YaQdhV8Xmwhoyq.u7ihIurc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1exKAAoJEHSUmkuduC28DRcQALqSRWKNSEwlkDiawwP6OTu2
cR0rBDAJ6j2Hc4Xe9+kk9Ns1DyGEh3/wanyr4/jyVHCmy2qW2bQi6+lC6Z9mtVR7
jk5j0iUH4KyPoa2GRqjMdhU2LIH4g4UDrOgPa/Uje90sP6kZ29dCIphh8cUG0W/Z
gyGNvrbFjSINaVs5VaNz/Uobd4md/dKu/oI2zFa0UrMGY6G+pL4ZnxpEyRngUy58
91i4tEPQJbWc8/LmWoIySwPG2PBi3vHi7RPDSvNGLey6BNDJxZwJYttVrvbbpoxh
ajBL05V9NkZ/o486m3+PZSu4hxyDtGLjP4TmokqdCS+aqrJ//O6pXWaiaIjJgg8b
lTOnNrcIRIeGx6yqOmvZ2A4lYtVK0407km8BbJbybS3Gk0l14Qk9psLVKAMsrkC+
nO2rlQ9qP9cly90cwZ2MdSYhGD4sNI3/UFNyIXv/wtTLDJFB59ws8COjugdEaRjB
j5b8Oo42O0pCnpnKWqdVeRyoKrJKb34v932SOdHFGI8J738RglTMpNaWgRgv2Stz
0uBwhjtaxg73I7rgt+n5KdN+kd0J3FlAW7HYsM4Gh3tULeQc+hUp6uuKcscDhkTo
0PbcObJW2vsltl8rH9yJ0SspB4ROi1WT0l3H4EI7bue/bSEoTOc2m6IDQ6N4ji/j
5owAfRtQdnI0kCIVm7yF
=pCmc
-----END PGP SIGNATURE-----

--Sig_/YaQdhV8Xmwhoyq.u7ihIurc--

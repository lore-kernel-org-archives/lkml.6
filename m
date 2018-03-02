Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947348AbeCBSje (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:39:34 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37937 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947334AbeCBSjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:39:32 -0500
X-Google-Smtp-Source: AG47ELsKx7X5oVs0zlnHhEJe1Wvk6YniUQIP8N38UhBjVBdpRpbgT1jbp5P9N+s55+IgjkSPkwBQjQ==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v2 3/8] arm64: zynqmp: Add support for Xilinx zcu102
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <dd5933d6a49247de4b3b7516ed7fab55d1b3eb90.1519396753.git.michal.simek@xilinx.com>
 <20180302164803.nb45aqgqvnzxuyn5@rob-hp-laptop>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <f935102d-149f-cc67-e811-ab62caf4abd1@monstr.eu>
Date: Fri, 2 Mar 2018 19:39:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302164803.nb45aqgqvnzxuyn5@rob-hp-laptop>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WzaLwjH3bGzo6lsmao0Dk6FFwLfnOPgCK"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WzaLwjH3bGzo6lsmao0Dk6FFwLfnOPgCK
Content-Type: multipart/mixed; boundary="QmakYYkRx9Faw8gqwhXQvw4Qx76yZEwX5";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <f935102d-149f-cc67-e811-ab62caf4abd1@monstr.eu>
Subject: Re: [PATCH v2 3/8] arm64: zynqmp: Add support for Xilinx zcu102
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <dd5933d6a49247de4b3b7516ed7fab55d1b3eb90.1519396753.git.michal.simek@xilinx.com>
 <20180302164803.nb45aqgqvnzxuyn5@rob-hp-laptop>
In-Reply-To: <20180302164803.nb45aqgqvnzxuyn5@rob-hp-laptop>

--QmakYYkRx9Faw8gqwhXQvw4Qx76yZEwX5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2.3.2018 17:48, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 03:40:25PM +0100, Michal Simek wrote:
>> This patch is adding revA, revB and rev1.0. There are also other
>> revisions between which should be backward compatible with previous
>> versions. Unfortunately all revs are still in use.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Remove i2c mw u-boot commands
>> - Use i2c-mux instead of i2cswitch
>> - Use clock generator without numbers.
>> - Use dash in node name zcu102 rev1.0
>> - Record compatible string to xilinx.txt
>>
>>  Documentation/devicetree/bindings/arm/xilinx.txt   |   5 +
>>  arch/arm64/boot/dts/xilinx/Makefile                |   3 +
>>  .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |  36 ++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  | 550 ++++++++++++=
+++++++++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  42 ++
>>  5 files changed, 636 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt=
s
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>=20
>=20
> but...
>=20
>=20
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>> new file mode 100644
>> index 000000000000..ed3cc684931f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>> @@ -0,0 +1,42 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU102 RevB
>> + *
>> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +#include "zynqmp-zcu102-revA.dts"
>> +
>> +/ {
>> +	model =3D "ZynqMP ZCU102 RevB";
>> +	compatible =3D "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102", "xln=
x,zynqmp";
>> +};
>> +
>> +&gem3 {
>> +	phy-handle =3D <&phyc>;
>> +	phyc: phy@c {
>> +		reg =3D <0xc>;
>> +		ti,rx-internal-delay =3D <0x8>;
>> +		ti,tx-internal-delay =3D <0xa>;
>> +		ti,fifo-depth =3D <0x1>;
>> +	};
>> +	/* Cleanup from RevA */
>> +	/delete-node/ phy@21;
>> +};
>> +
>> +/* Different qspi 512Mbit version */
>=20
> Stray comment

will remove.

>=20
>> +
>> +/* Fix collision with u61 */
>> +&i2c0 {
>> +	i2cswitch@75 {
>=20
> Missed this name.
>=20
> This probably creates a new node rather than going into the existing=20
> tree. If this compiles, we should fix it to not allow the same=20
> unit-address twice.

hmm interesting I didn't see that before I sent this. There is a warning
but not error.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--QmakYYkRx9Faw8gqwhXQvw4Qx76yZEwX5--

--WzaLwjH3bGzo6lsmao0Dk6FFwLfnOPgCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqZmloACgkQykllyylKDCFtJwCggs+MAz4q5UwqQFsmZFXpz4fe
hF4An3WswcjKFeQfwB0AMYinZuvo/Yh3
=6/Qe
-----END PGP SIGNATURE-----

--WzaLwjH3bGzo6lsmao0Dk6FFwLfnOPgCK--

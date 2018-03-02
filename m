Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426995AbeCBSmi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:42:38 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33142 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423170AbeCBSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:42:36 -0500
X-Google-Smtp-Source: AG47ELu/ttr5o9dfSXxSN30vQ+EAlvpyIpxBMkEuEdjFK3C8nU93Ox2XhMlFuBmZwKJhE6hDo4Uecw==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v2 4/8] arm64: zynqmp: Add support for Xilinx zcu104-revA
To: Rob Herring <robh@kernel.org>, Michal Simek <michal.simek@xilinx.com>
Cc: devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <68acadbb82fb0a8ac5abb9b1e156b9a9cf5b0f11.1519396753.git.michal.simek@xilinx.com>
 <20180302180258.hex77xmptf5ab3xd@rob-hp-laptop>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <b73d92a9-bbe0-e4a9-c0d7-c9379ac4ad80@monstr.eu>
Date: Fri, 2 Mar 2018 19:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302180258.hex77xmptf5ab3xd@rob-hp-laptop>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="zj26nuPppTofy5jPafFuDy0eJeVjx9f0s"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zj26nuPppTofy5jPafFuDy0eJeVjx9f0s
Content-Type: multipart/mixed; boundary="rsHEz8qLvKsNh7aw0t7DMuIUnuR1pKUFx";
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
Message-ID: <b73d92a9-bbe0-e4a9-c0d7-c9379ac4ad80@monstr.eu>
Subject: Re: [PATCH v2 4/8] arm64: zynqmp: Add support for Xilinx zcu104-revA
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <68acadbb82fb0a8ac5abb9b1e156b9a9cf5b0f11.1519396753.git.michal.simek@xilinx.com>
 <20180302180258.hex77xmptf5ab3xd@rob-hp-laptop>
In-Reply-To: <20180302180258.hex77xmptf5ab3xd@rob-hp-laptop>

--rsHEz8qLvKsNh7aw0t7DMuIUnuR1pKUFx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2.3.2018 19:02, Rob Herring wrote:
> On Fri, Feb 23, 2018 at 03:40:26PM +0100, Michal Simek wrote:
>> Xilinx zcu104 is another customer board. It is sort of zcu102 clone
>> with some differences.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Remove i2c mw u-boot commands
>> - Record compatible string to xilinx.txt
>>
>>  Documentation/devicetree/bindings/arm/xilinx.txt  |   3 +
>>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 197 +++++++++++++=
+++++++++
>>  3 files changed, 201 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Docume=
ntation/devicetree/bindings/arm/xilinx.txt
>> index 2b922ec3c82a..a9ce08a68711 100644
>> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
>> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
>> @@ -26,3 +26,6 @@ Additional compatible strings:
>>    "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
>>    "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
>>    "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
>> +
>> +- Xilinx evaluation board zcu104
>> +  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
>> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts=
/xilinx/Makefile
>> index 24e3ce801304..1c039e59c7c3 100644
>> --- a/arch/arm64/boot/dts/xilinx/Makefile
>> +++ b/arch/arm64/boot/dts/xilinx/Makefile
>> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zcu100-revC.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zcu102-revA.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zcu102-revB.dtb
>>  dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zcu102-rev1.0.dtb
>> +dtb-$(CONFIG_ARCH_ZYNQMP) +=3D zynqmp-zcu104-revA.dtb
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> new file mode 100644
>> index 000000000000..89d26f56514b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * dts file for Xilinx ZynqMP ZCU104
>> + *
>> + * (C) Copyright 2017 - 2018, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "zynqmp.dtsi"
>> +#include "zynqmp-clk.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +	model =3D "ZynqMP ZCU104 RevA";
>> +	compatible =3D "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104", "xln=
x,zynqmp";
>> +
>> +	aliases {
>> +		ethernet0 =3D &gem3;
>> +		gpio0 =3D &gpio;
>=20
> Drop. Not a supported alias.
>=20
>> +		i2c0 =3D &i2c1;
>> +		mmc0 =3D &sdhci1;
>> +		rtc0 =3D &rtc;
>> +		serial0 =3D &uart0;
>> +		serial1 =3D &uart1;
>> +		serial2 =3D &dcc;
>> +		usb0 =3D &usb0;
>=20
> Drop. Not a supported alias.
>=20
>> +	};
>> +
>> +	chosen {
>> +		bootargs =3D "earlycon";
>> +		stdout-path =3D "serial0:115200n8";
>> +	};
>> +
>> +	memory@0 {
>> +		device_type =3D "memory";
>> +		reg =3D <0x0 0x0 0x0 0x80000000>;
>> +	};
>> +};
>> +
>> +&can1 {
>> +	status =3D "okay";
>> +};
>> +
>> +&dcc {
>> +	status =3D "okay";
>> +};
>> +
>> +&gem3 {
>> +	status =3D "okay";
>> +	phy-handle =3D <&phy0>;
>> +	phy-mode =3D "rgmii-id";
>> +	phy0: phy@c {
>> +		reg =3D <0xc>;
>> +		ti,rx-internal-delay =3D <0x8>;
>> +		ti,tx-internal-delay =3D <0xa>;
>> +		ti,fifo-depth =3D <0x1>;
>> +	};
>> +};
>> +
>> +&gpio {
>> +	status =3D "okay";
>> +};
>> +
>> +&i2c1 {
>> +	status =3D "okay";
>> +	clock-frequency =3D <400000>;
>> +
>> +	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
>> +	i2cswitch@74 { /* u34 */
>=20
> i2c-mux@74

grrr - this was done but squashed to 5/8 instead.

Will fix.

M


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--rsHEz8qLvKsNh7aw0t7DMuIUnuR1pKUFx--

--zj26nuPppTofy5jPafFuDy0eJeVjx9f0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqZmxIACgkQykllyylKDCH+QACfWaIHsKhyTSV4KSV77T7IJKIf
y+QAn2L0xR8byCMig3aUJvk0tKAeWVu5
=7NLu
-----END PGP SIGNATURE-----

--zj26nuPppTofy5jPafFuDy0eJeVjx9f0s--

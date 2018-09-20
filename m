Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D977D214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Xp5UVDtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D977D214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbeIUCYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:24:16 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50892 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeIUCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:24:16 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CF9C584482;
        Fri, 21 Sep 2018 08:38:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1537475936;
        bh=0y6OLbScyb+jB+JHM+sjGplgRWlGsPhkjzNAfq00YUQ=;
        h=From:To:CC:Subject:Date:References;
        b=Xp5UVDtCjkV8CS4KFKfguEYtRzgL1u3F4fgUkiZHXdIPeGpfS/eYYG2K6O7LgSRts
         C23pPTshvs1HzVeN8va7qnktq+MJGsXas/cZ5fKaL/OWe1j0/3xQYTY2XTeSqpTvLq
         OBQGuKwcBhiyk0rMsv5ttiABXqaug0SedNPaP+Vc=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ba405600000>; Fri, 21 Sep 2018 08:38:56 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 21 Sep 2018 08:38:54 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 21 Sep 2018 08:38:54 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] ARM: dts: mvebu: updates and new board
Thread-Topic: [PATCH 0/4] ARM: dts: mvebu: updates and new board
Thread-Index: AQHUJJWLnsN52fzAokSTnxLtDBllKg==
Date:   Thu, 20 Sep 2018 20:38:54 +0000
Message-ID: <e627c26d707f4a20a5a427a5a64232d3@svr-chch-ex1.atlnz.lc>
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
 <87bm8sjh6f.fsf@bootlin.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/18 03:57, Gregory CLEMENT wrote:=0A=
> Hi Chris,=0A=
>   =0A=
>   On jeu., juil. 26 2018, Chris Packham <chris.packham@alliedtelesis.co.n=
z> wrote:=0A=
> =0A=
>> This series updates the armada-xp-98dx3236 SoC and related boards to use=
 the=0A=
>> new style dts bindings for nand.=0A=
>>=0A=
>> I've also added a new db-88f6820-amc board which is an Armada-385 based=
=0A=
>> reference board from Marvell's switch team. It's a plugin card for eithe=
r the=0A=
>> db-dxbc2 or db-xc3-24g4 which can be used if you disable the internal CP=
U on=0A=
>> those platforms.=0A=
>>=0A=
>> Chris Packham (4):=0A=
>>    ARM: dts: mvebu: 98dx3236: Rename nand controller node=0A=
>>    ARM: dts: mvebu: db-dxbc2: use new style nand binding=0A=
>>    ARM: dts: mvebu: db-xc3-24g4: use new style nand binding=0A=
>>    ARM: dts: mvebu: Add device tree for db-88f6820-amc board=0A=
> =0A=
> While applying this series mvebu/dt, I got few warning with "ARM: dts:=0A=
> mvebu: 98dx3236: Rename nand controller node".=0A=
> =0A=
> I fix them and also use the new partition binding, the diff is the=0A=
> following:=0A=
> =0A=
> iff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/bo=
ot/dts/armada-385-db-88f6820-amc.dts=0A=
> index d87614057e3f..dc9ccce1d4a1 100644=0A=
> --- a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts=0A=
> +++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts=0A=
> @@ -102,9 +102,14 @@=0A=
>                  nand-ecc-strength =3D <4>;=0A=
>                  nand-ecc-step-size =3D <512>;=0A=
>   =0A=
> -               partition@user {=0A=
> -                       reg =3D <0x00000000 0x40000000>;=0A=
> -                       label =3D "user";=0A=
> +               partitions {=0A=
> +                       compatible =3D "fixed-partitions";=0A=
> +                       #address-cells =3D <1>;=0A=
> +                       #size-cells =3D <1>;=0A=
> +                       partition@0 {=0A=
> +                               reg =3D <0x00000000 0x40000000>;=0A=
> +                               label =3D "user";=0A=
> +                       };=0A=
>                  };=0A=
>          };=0A=
>   };=0A=
> @@ -131,13 +136,18 @@=0A=
>                  spi-max-frequency =3D <50000000>;=0A=
>                  m25p,fast-read;=0A=
>   =0A=
> -               partition@u-boot {=0A=
> -                       reg =3D <0x00000000 0x00100000>;=0A=
> -                       label =3D "u-boot";=0A=
> -               };=0A=
> -               partition@u-boot-env {=0A=
> -                       reg =3D <0x00100000 0x00040000>;=0A=
> -                       label =3D "u-boot-env";=0A=
> +               partitions {=0A=
> +                       compatible =3D "fixed-partitions";=0A=
> +                       #address-cells =3D <1>;=0A=
> +                       #size-cells =3D <1>;=0A=
> +                       partition@0 {=0A=
> +                               reg =3D <0x00000000 0x00100000>;=0A=
> +                               label =3D "u-boot";=0A=
> +                       };=0A=
> +                       partition@100000 {=0A=
> +                               reg =3D <0x00100000 0x00040000>;=0A=
> +                               label =3D "u-boot-env";=0A=
> +                       };=0A=
>                  };=0A=
>          };=0A=
>   };=0A=
> =0A=
> I amended your patch with it, but if you don't agree with it, I can=0A=
> still modify it, the branch is not immutable yet.=0A=
=0A=
Looks good to me. Thanks.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Gregory=0A=
> =0A=
>>=0A=
>>   arch/arm/boot/dts/Makefile                    |   1 +=0A=
>>   .../boot/dts/armada-385-db-88f6820-amc.dts    | 184 ++++++++++++++++++=
=0A=
>>   arch/arm/boot/dts/armada-xp-98dx3236.dtsi     |   2 +-=0A=
>>   arch/arm/boot/dts/armada-xp-db-dxbc2.dts      |  18 +-=0A=
>>   arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts |  18 +-=0A=
>>   5 files changed, 208 insertions(+), 15 deletions(-)=0A=
>>   create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts=0A=
>>=0A=
>> -- =0A=
>> 2.18.0=0A=
>>=0A=
> =0A=
=0A=

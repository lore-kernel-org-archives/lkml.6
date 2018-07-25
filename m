Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7054D20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bibVZW2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7054D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbeGYJge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:36:34 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:27012 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbeGYJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1532507156;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=31GQ4dx5TuWCHRDQQ+xKyV6nWoG6OqzpEZLM+7YrHls=;
        b=bibVZW2+uNde2BsDgN/cEMAbhLjYZgdlBljhaqZI7x11E6uDKS7Sx4BWUqUcC9nIsn
        KkNoA+TYW2B78EEIF2RKC928FU/MLkbtYAQEH3HlZwIDSaRHOUcIggp80CiXoAgNVwAT
        mJCUMSFeAaLDSjdOSIE9kw3umgKV/AL21FswJM5t0KhxsAs2GBLt7MZvFbbWa+wqSXfh
        qi7pRGVt9+1qa5UJ4ic8xKksqgC9g5JYXDDEcI/JXj6b9TMLmWyY6V54mqIAexLsAXh3
        VmGh29wiZ0x2hZ52txjEV3OLfXbdQu9t2hXNk7r6wy7GDcBAzFTvPa1dKloYdBf7Gq4e
        6nYw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qET/2Lw=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P8PqddA
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 10:25:52 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH 09/32] ARM: dts: omap3-gta04: make NAND partitions compatible with recent U-Boot
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
Date:   Wed, 25 Jul 2018 10:25:53 +0200
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D53ED583-D242-4BD9-BF84-80D4CB427ABB@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com> <20180725080735.GA7467@lenoch> <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
To:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 25.07.2018 um 10:18 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
>=20
>> Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
>>=20
>> On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:
>>> Vendor defined U-Boot has changed the partition scheme a while ago:
>>>=20
>>> * kernel partition 6MB
>>> * file system partition uses the remainder up to end of the NAND
>>> * increased size of the environment partition (to get an OneNAND =
compatible base address)
>>> * shrink the U-Boot partition
>>>=20
>>> Let's be compatible (e.g. Debian kernel built from upstream).
>>=20
>> That, in fact, is breaking compatibility.
>=20
> With what? Nobody is using the old u-boot partition scheme any more
> (it is >5 years old).
>=20
>> So once you are touching this
>> what about relying on partitioning provided by bootloader just to =
prevent
>> something like this happening again?
>=20
> Well, we define what compatible means here (since we are the vendor).
> And people complain with us. We simply recommend them to upgrade the
> boot-loader.

I should also mention that a modern and fully configured kernel binary =
is
already too big for a 4MB kernel partition.
>=20
>=20
>>=20
>> 	ladis
>>=20
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> arch/arm/boot/dts/omap3-gta04.dtsi | 12 ++++++------
>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> index 65f77a0b5dd4..03fe404cbf56 100644
>>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>>> @@ -645,22 +645,22 @@
>>>=20
>>> 		bootloaders@80000 {
>>> 			label =3D "U-Boot";
>>> -			reg =3D <0x80000 0x1e0000>;
>>> +			reg =3D <0x80000 0x1c0000>;
>>> 		};
>>>=20
>>> -		bootloaders_env@260000 {
>>> +		bootloaders_env@240000 {
>>> 			label =3D "U-Boot Env";
>>> -			reg =3D <0x260000 0x20000>;
>>> +			reg =3D <0x240000 0x40000>;
>>> 		};
>>>=20
>>> 		kernel@280000 {
>>> 			label =3D "Kernel";
>>> -			reg =3D <0x280000 0x400000>;
>>> +			reg =3D <0x280000 0x600000>;
>>> 		};
>>>=20
>>> -		filesystem@680000 {
>>> +		filesystem@880000 {
>>> 			label =3D "File System";
>>> -			reg =3D <0x680000 0xf980000>;
>>> +			reg =3D <0x880000 0>;	/* 0 =3D =
MTDPART_SIZ_FULL */
>>> 		};
>>> 	};
>>> };
>>> --=20
>>> 2.12.2
>>>=20
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe =
linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel


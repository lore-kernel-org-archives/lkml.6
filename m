Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C791EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBE2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="bg5ONnd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBE2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeGYJa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:30:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:14288 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbeGYJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1532506790;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=uMXSj1B1e2GKa8h5FAaQeCfkU/UWQk7pS2UQvlzGuG0=;
        b=bg5ONnd5aAnzq5DEUdAmI/2RCoyo2fEHfMboQIZUnzGSYJBx1TjPhhu/ohM0oWRdkE
        eIKOOw18OxfhN1RZUP0lcMYAhGR4VKb0LkC2lCWToV8WmHpLAuqMGU5IBo2VnCFAvkUs
        4PWv8dfuuupBdvJi4fMq7fzdH8F83RbxzKpv6SakbUPCriPlbMYMwH+jDj75XeQhtd+6
        0OX2KpeCH/nlxBWGdmzem7ts22XvVVbHMevPyRpNiXnHsQhlxDfAkXbWDht50Lc6t+rs
        HiGhviNKIfM5DWaWAcV4obN682J/reRAFPTbgmQxRsx9H0k4gcEckrsT6M9VI2mjbmOo
        iyJQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qET/2Lw=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P8JgdXU
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 10:19:42 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 20/32] ARM: dts: omap3-gta04: add devconf0 setup for mcbsp1 clock pins
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180725081251.GC7467@lenoch>
Date:   Wed, 25 Jul 2018 10:19:44 +0200
Cc:     Marek Belisko <marek@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5FEB3CE-9ADC-4C21-A4D9-E9FBC20B4DBC@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <5dbe024d9465eab668ba9aac3732ded225859e6f.1532501910.git.hns@goldelico.com> <20180725081251.GC7467@lenoch>
To:     Ladislav Michl <ladis@linux-mips.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 25.07.2018 um 10:12 schrieb Ladislav Michl <ladis@linux-mips.org>:
>=20
> On Wed, Jul 25, 2018 at 08:58:52AM +0200, H. Nikolaus Schaller wrote:
>> McBSP1 needs sepcial "pinctrl" for the clocks.
>=20
> Nit: "special" perhaps?

Thanks! Seems to be missing in the spell checker of checkpatch (or I =
didn't notice the message).

BR,
Nikolaus

>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-gta04.dtsi | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>> index 935a2a707737..f6abdef556c1 100644
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -187,6 +187,24 @@
>> 		reset-gpios =3D <&tca6507 0 GPIO_ACTIVE_LOW>;	/* =
W2CBW003 reset through tca6507 */
>> 	};
>>=20
>> +	/* devconf0 setup for mcbsp1 clock pins */
>> +	pinmux_mcbsp1@48002274 {
>> +		compatible =3D "pinctrl-single";
>> +		reg =3D <0x48002274 4>;   /* CONTROL_DEVCONF0 */
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +		pinctrl-single,bit-per-mux;
>> +		pinctrl-single,register-width =3D <32>;
>> +		pinctrl-single,function-mask =3D <0x7>;	/* MCBSP1 CLK =
pinmux */
>> +		#pinctrl-cells =3D <2>;
>> +		pinctrl-names =3D "default";
>> +		pinctrl-0 =3D <&mcbsp1_devconf0_pins>;
>> +		mcbsp1_devconf0_pins: pinmux_mcbsp1_devconf0_pins {
>> +			/*                   offset bits mask */
>> +			pinctrl-single,bits =3D <0x00 0x08 0x1c>;	=
/* set MCBSP1_CLKR */
>> +		};
>> +	};
>> +
>> 	/* devconf1 setup for tvout pins */
>> 	pinmux_tv_out@480022d8 {
>> 		compatible =3D "pinctrl-single";
>> --=20
>> 2.12.2
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


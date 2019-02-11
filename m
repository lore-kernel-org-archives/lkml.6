Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9130DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5960A21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="GDbniqTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfBKSO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:14:26 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12433 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfBKSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549908860;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WwMHh9+IvrYI0LpPcien93u8h/U0Z53iVl6fzumYbvg=;
        b=GDbniqTc1eccMSsvh9IVKmzL5QRu/zci/IrIH0d50JS0PmuZXacZ5I//nWUoov7Fo6
        rcsPo5J3kCFTbfAO2IdhXxss1J/mTIYh1WEQMP0EvVIwCl0rtcd5wWXL5AWVTMBPzWPg
        6brDSI5oU5OB2tjTaQZ5pVNvIv+NXWnGi1afl6vhrBmr6j/wpGLfOJqG0Oa2hfFPjnZY
        p4WLPh2cj8lis9XxYfoK34QkGA6fmmZq/vvpUa09qHN8gJ6apvCOVTComHs2jZEy5svB
        QcoD0J804FCxm4TVv9JqYJfDqowbDpGiQu88m6L3/RZ8utb/wJ9QSDhm6mllLbPd/1Gh
        0X7w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDeo4w=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1BIECTFs
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Feb 2019 19:14:12 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH] ARM: dts: omap3-gta04: declare backlight in lcd node
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190211162007.15626-1-andreas@kemnade.info>
Date:   Mon, 11 Feb 2019 19:14:12 +0100
Cc:     Benoit Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E556C766-1B1D-4352-9D64-D18B631ADB7D@goldelico.com>
References: <20190211162007.15626-1-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 11.02.2019 um 17:20 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> The lcd display of the gta04 has a backlight but the backlight
> was not referenced in the lcd node, so screen blanking did
> not turn off the backlight. Fix that.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Works fine.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

> ---
> the backlight property for the driver was accepted here:
> =
https://lore.kernel.org/lkml/a54e7427-ff84-d105-aab7-c5eab42e6df9@ti.com/
>=20
> arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 8c55d33ff694..3b88eb5f1a72 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -142,6 +142,7 @@
> 			spi-cpol;
> 			spi-cpha;
>=20
> +			backlight=3D <&backlight>;
> 			label =3D "lcd";
> 			port {
> 				lcd_in: endpoint {
> @@ -151,7 +152,7 @@
> 		};
> 	};
>=20
> -	backlight {
> +	backlight: backlight {
> 		compatible =3D "pwm-backlight";
> 		pwms =3D <&pwm11 0 12000000 0>;
> 		pwm-names =3D "backlight";
> --=20
> 2.11.0
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel


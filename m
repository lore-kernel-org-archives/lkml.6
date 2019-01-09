Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC42C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AA320859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="S78HqNN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAISFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:05:17 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:11347 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfAISFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:05:17 -0500
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 13:05:16 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547057115;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wysRQKKoplqUxoirt3IpkaAX49muiYxSK1V8wy9PtjU=;
        b=S78HqNN5xl2L2qjYi+YYs+bXeVCcScD/6MlSR/kr7Q3V0AU31ox6WUFTBpXfU4LkkP
        UGj3W0eXhgPHm1iHh0ibr6naWDJvmI3GOlvM4kNSiKwEW7Hf1szXSNR+Os++TQ9st7UC
        56VHV7ZIkkQf1niGr23licLf5qSMUWGnDY9uXEkga0NEptBYCeNKvvNnJiwrP+76k54G
        bPG6fx+Tt7P0MRjUPXg3ZxzxWl1vcMvjG2ffo8uSS3gBT+IGEtsv1BWgxCBBuY8v+Gox
        K6H4IsMV9bFRnDTno6i5ygFz10ntVIGmJxwqf4Q708mN+5H17T9875ssKGcn5yH5HDDX
        K1Zg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSZXA4PLVY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 608499v09I56SBE
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 19:05:06 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190109185751.3268420b@aktux>
Date:   Wed, 9 Jan 2019 19:05:05 +0100
Cc:     Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <209232E2-690B-4805-9F09-79B7EEB1EEDB@goldelico.com>
References: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com> <20190109185751.3268420b@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> Am 09.01.2019 um 18:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Hi,
>=20
> On Wed,  9 Jan 2019 18:47:52 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>> From: Andreas Kemnade <andreas@kemnade.info>
>>=20
>> gta04a[34] have bluetooth chips which simply understand
>> h4 protocol.
>>=20
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>=20
> what about upstreaming the full patch based on mainline and not your
> on-top-of-other-stuff rebased version of this patch?

What do you mean? This patch is basically based on mainline (v5.0-rc1),
but I did not want to push it now, but a different one in the same patch
stack and this happened due to an still unknown error in my send-mail =
tool
which picked the wrong one after doing a test.

So please simply ignore the noise and don't worry about this patch.

BR,
Nikolaus

>=20
> Regards,
> Andreas
>=20
>> ---
>> arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi =
b/arch/arm/boot/dts/omap3-gta04.dtsi
>> index 499e3b0e920b..ec7b1e31c07e 100644
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -722,6 +722,8 @@
>>=20
>> 	bluetooth: bluetooth {
>> 		compatible =3D "wi2wi,w2cbw003-bluetooth";
>> +		speed =3D <3000000>;
>> +		flow;
>> 		vdd-supply =3D <&vaux4>;
>> 	};
>> };
>=20


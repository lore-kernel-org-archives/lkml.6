Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959A72089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wZVPyw4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959A72089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeGNOJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 10:09:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40846 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeGNOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 10:09:23 -0400
Date:   Sat, 14 Jul 2018 15:50:08 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1531576208.2831.1@smtp.crapouillou.net>
In-Reply-To: <20180714133250.GW16084@piout.net>
References: <20180713151424.13000-1-paul@crapouillou.net>
        <20180714131920.GU16084@piout.net> <1531574734.2831.0@smtp.crapouillou.net>
        <20180714133250.GW16084@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531576211; bh=KN9BC55cGoOdW/YBjewJLOT4OprP5FXIs83pNxHY4ds=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=wZVPyw4jDILkh7m+C0Q6g3zaIFzhKh2o7xJGuIxfcYCg4iahwoUyjqi1vvXwBMVukPDTZOkz+sEuYEBmaU3GkHAXzlSFsjc8Z0NcFJluiqECGuhEABuKQ1FXE8Zdx709oqMvqdhCjhPO3PSmgbFIhg8SeRLfo2VrZQ/cOJIwQO8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam. 14 juil. 2018 =E0 15:32, Alexandre Belloni=20
<alexandre.belloni@bootlin.com> a =E9crit :
> On 14/07/2018 15:25:33+0200, Paul Cercueil wrote:
>>  Hi Alexandre,
>>=20
>>  Le sam. 14 juil. 2018 =E0 15:19, Alexandre Belloni
>>  <alexandre.belloni@bootlin.com> a =E9crit :
>>  > Hello,
>>  >
>>  > On 13/07/2018 17:14:24+0200, Paul Cercueil wrote:
>>  > >  The RTC in the JZ4725B works just like the one in the JZ4740.
>>  > >
>>  > >  The RTC in the JZ4760 and JZ4770 work just like the one in the
>>  > > JZ4780.
>>  > >
>>  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >  ---
>>  > >   Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt=20
>> |  3
>>  > > +++
>>  > >   drivers/rtc/rtc-jz4740.c                                    =20
>> | 11
>>  > > ++++++++++-
>>  > >   2 files changed, 13 insertions(+), 1 deletion(-)
>>  > >
>>  > >  diff --git
>>  > > a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > > b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > >  index 41c7ae18fd7b..a9e821de84f2 100644
>>  > >  ---=20
>> a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > >  +++=20
>> b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > >  @@ -4,6 +4,9 @@ Required properties:
>>  > >
>>  > >   - compatible: One of:
>>  > >     - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
>>  > >  +  - "ingenic,jz4725b-rtc" - for use with the JZ4725B SoC
>>  > >  +  - "ingenic,jz4760-rtc" - for use with the JZ4760 SoC
>>  > >  +  - "ingenic,jz4770-rtc" - for use with the JZ4770 SoC
>>  > >     - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
>>  > >   - reg: Address range of rtc register set
>>  > >   - interrupts: IRQ number for the alarm interrupt
>>  > >  diff --git a/drivers/rtc/rtc-jz4740.c=20
>> b/drivers/rtc/rtc-jz4740.c
>>  > >  index d0a891777f44..1c867e3a0ea5 100644
>>  > >  --- a/drivers/rtc/rtc-jz4740.c
>>  > >  +++ b/drivers/rtc/rtc-jz4740.c
>>  > >  @@ -54,6 +54,9 @@
>>  > >
>>  > >   enum jz4740_rtc_type {
>>  > >   	ID_JZ4740,
>>  > >  +	ID_JZ4725B,
>>  > >  +	ID_JZ4760,
>>  > >  +	ID_JZ4770,
>>  >
>>  > I wouldn't introduce those ids unless there are handling=20
>> differences at
>>  > some point.
>>=20
>>  Well there are handling differences, see below.
>>=20
>>  > >   	ID_JZ4780,
>>  > >   };
>>  > >
>>  > >  @@ -114,7 +117,7 @@ static inline int=20
>> jz4740_rtc_reg_write(struct
>>  > > jz4740_rtc *rtc, size_t reg,
>>  > >   {
>>  > >   	int ret =3D 0;
>>  > >
>>  > >  -	if (rtc->type >=3D ID_JZ4780)
>>  > >  +	if (rtc->type >=3D ID_JZ4760)
>>  >
>>  > This would avoid that change (and the test would preferably be
>>  > (rtc->type =3D=3D ID_JZ4780))
>>=20
>>  That branch should be taken if the SoC is JZ4760, JZ4770 or JZ4780.
>>  It should not be taken if the SoC is JZ4740 or JZ4725B.
>=20
> Sure but you can achieve that with only 2 ids...
>=20
>>=20
>>  > >   		ret =3D jz4780_rtc_enable_write(rtc);
>>  > >   	if (ret =3D=3D 0)
>>  > >   		ret =3D jz4740_rtc_wait_write_ready(rtc);
>>  > >  @@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
>>  > >
>>  > >   static const struct of_device_id jz4740_rtc_of_match[] =3D {
>>  > >   	{ .compatible =3D "ingenic,jz4740-rtc", .data =3D (void=20
>> *)ID_JZ4740 },
>>  > >  +	{ .compatible =3D "ingenic,jz4725b-rtc", .data =3D (void=20
>> *)ID_JZ4725B
>>  > > },
>>  > >  +	{ .compatible =3D "ingenic,jz4760-rtc", .data =3D (void=20
>> *)ID_JZ4760 },
>>  > >  +	{ .compatible =3D "ingenic,jz4770-rtc", .data =3D (void=20
>> *)ID_JZ4770 },
>=20
> By doing the correct mapping here e.g:
>=20
> { .compatible =3D "ingenic,jz4725b-rtc", .data =3D (void *)ID_JZ4740 },

Not very pretty and future-proof if you ask me...
But you're the boss...

>>  > >   	{ .compatible =3D "ingenic,jz4780-rtc", .data =3D (void=20
>> *)ID_JZ4780 },
>>  > >   	{},
>>  > >   };
>>  > >  @@ -428,6 +434,9 @@ static const struct dev_pm_ops=20
>> jz4740_pm_ops =3D {
>>  > >
>>  > >   static const struct platform_device_id jz4740_rtc_ids[] =3D {
>>  > >   	{ "jz4740-rtc", ID_JZ4740 },
>>  > >  +	{ "jz4725b-rtc", ID_JZ4725B },
>>  > >  +	{ "jz4760-rtc", ID_JZ4760 },
>>  > >  +	{ "jz4770-rtc", ID_JZ4770 },
>=20
> And here
>=20
>>  > >   	{ "jz4780-rtc", ID_JZ4780 },
>>  > >   	{}
>>  > >   };
>>  > >  --
>>  > >  2.11.0
>>  > >
>>  >
>>  > --
>>  > Alexandre Belloni, Bootlin (formerly Free Electrons)
>>  > Embedded Linux and Kernel engineering
>>  > https://bootlin.com
>>=20
>=20
> --
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
=


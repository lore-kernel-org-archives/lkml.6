Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E5BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2E820671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="B8dgAHes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2E820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeGTTxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:53:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:51460 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:53:40 -0400
Date:   Fri, 20 Jul 2018 21:03:59 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
To:     Rob Herring <robh@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1532113439.2309.1@smtp.crapouillou.net>
In-Reply-To: <20180720153956.GA18135@rob-hp-laptop>
References: <20180713151424.13000-1-paul@crapouillou.net>
        <20180714131920.GU16084@piout.net> <1531574734.2831.0@smtp.crapouillou.net>
        <20180714133250.GW16084@piout.net> <1531576208.2831.1@smtp.crapouillou.net>
        <20180720153956.GA18135@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532113443; bh=bB8rOYJxw/4X8MsyWOE/5Uso6+prxUUoJw3u0FZptb4=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=B8dgAHes8D3Ki2jYNnxjT2ZmQHJH8zlE2U244tCCibnafLUN65n18syJsBOG2n8HkEz7fP831/WWJnvPYAWw+gYeC+tJuh2B5h8a8yXHJovOY8z2200Qjapj+4uEnklpOxCmgtD38u3PrA7gKG+Vxa8y0j31ZPV7shQFvGBOLD4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 20 juil. 2018 =E0 17:39, Rob Herring <robh@kernel.org> a =E9crit :
> On Sat, Jul 14, 2018 at 03:50:08PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le sam. 14 juil. 2018 =E0 15:32, Alexandre Belloni
>>  <alexandre.belloni@bootlin.com> a =E9crit :
>>  > On 14/07/2018 15:25:33+0200, Paul Cercueil wrote:
>>  > >  Hi Alexandre,
>>  > >
>>  > >  Le sam. 14 juil. 2018 =E0 15:19, Alexandre Belloni
>>  > >  <alexandre.belloni@bootlin.com> a =E9crit :
>>  > >  > Hello,
>>  > >  >
>>  > >  > On 13/07/2018 17:14:24+0200, Paul Cercueil wrote:
>>  > >  > >  The RTC in the JZ4725B works just like the one in the=20
>> JZ4740.
>>  > >  > >
>>  > >  > >  The RTC in the JZ4760 and JZ4770 work just like the one=20
>> in the
>>  > >  > > JZ4780.
>>  > >  > >
>>  > >  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > >  > >  ---
>>  > >  > >  =20
>> Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > > |  3
>>  > >  > > +++
>>  > >  > >   drivers/rtc/rtc-jz4740.c
>>  > > | 11
>>  > >  > > ++++++++++-
>>  > >  > >   2 files changed, 13 insertions(+), 1 deletion(-)
>>  > >  > >
>>  > >  > >  diff --git
>>  > >  > >=20
>> a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > >  > >=20
>> b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > >  > >  index 41c7ae18fd7b..a9e821de84f2 100644
>>  > >  > >  ---
>>  > > a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > >  > >  +++
>>  > > b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  > >  > >  @@ -4,6 +4,9 @@ Required properties:
>>  > >  > >
>>  > >  > >   - compatible: One of:
>>  > >  > >     - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
>>  > >  > >  +  - "ingenic,jz4725b-rtc" - for use with the JZ4725B SoC
>>  > >  > >  +  - "ingenic,jz4760-rtc" - for use with the JZ4760 SoC
>>  > >  > >  +  - "ingenic,jz4770-rtc" - for use with the JZ4770 SoC
>>  > >  > >     - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
>>  > >  > >   - reg: Address range of rtc register set
>>  > >  > >   - interrupts: IRQ number for the alarm interrupt
>>  > >  > >  diff --git a/drivers/rtc/rtc-jz4740.c
>>  > > b/drivers/rtc/rtc-jz4740.c
>>  > >  > >  index d0a891777f44..1c867e3a0ea5 100644
>>  > >  > >  --- a/drivers/rtc/rtc-jz4740.c
>>  > >  > >  +++ b/drivers/rtc/rtc-jz4740.c
>>  > >  > >  @@ -54,6 +54,9 @@
>>  > >  > >
>>  > >  > >   enum jz4740_rtc_type {
>>  > >  > >   	ID_JZ4740,
>>  > >  > >  +	ID_JZ4725B,
>>  > >  > >  +	ID_JZ4760,
>>  > >  > >  +	ID_JZ4770,
>>  > >  >
>>  > >  > I wouldn't introduce those ids unless there are handling
>>  > > differences at
>>  > >  > some point.
>>  > >
>>  > >  Well there are handling differences, see below.
>>  > >
>>  > >  > >   	ID_JZ4780,
>>  > >  > >   };
>>  > >  > >
>>  > >  > >  @@ -114,7 +117,7 @@ static inline int
>>  > > jz4740_rtc_reg_write(struct
>>  > >  > > jz4740_rtc *rtc, size_t reg,
>>  > >  > >   {
>>  > >  > >   	int ret =3D 0;
>>  > >  > >
>>  > >  > >  -	if (rtc->type >=3D ID_JZ4780)
>>  > >  > >  +	if (rtc->type >=3D ID_JZ4760)
>>  > >  >
>>  > >  > This would avoid that change (and the test would preferably=20
>> be
>>  > >  > (rtc->type =3D=3D ID_JZ4780))
>>  > >
>>  > >  That branch should be taken if the SoC is JZ4760, JZ4770 or=20
>> JZ4780.
>>  > >  It should not be taken if the SoC is JZ4740 or JZ4725B.
>>  >
>>  > Sure but you can achieve that with only 2 ids...
>>  >
>>  > >
>>  > >  > >   		ret =3D jz4780_rtc_enable_write(rtc);
>>  > >  > >   	if (ret =3D=3D 0)
>>  > >  > >   		ret =3D jz4740_rtc_wait_write_ready(rtc);
>>  > >  > >  @@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
>>  > >  > >
>>  > >  > >   static const struct of_device_id jz4740_rtc_of_match[] =3D=20
>> {
>>  > >  > >   	{ .compatible =3D "ingenic,jz4740-rtc", .data =3D (void
>>  > > *)ID_JZ4740 },
>>  > >  > >  +	{ .compatible =3D "ingenic,jz4725b-rtc", .data =3D (void
>>  > > *)ID_JZ4725B
>>  > >  > > },
>>  > >  > >  +	{ .compatible =3D "ingenic,jz4760-rtc", .data =3D (void
>>  > > *)ID_JZ4760 },
>>  > >  > >  +	{ .compatible =3D "ingenic,jz4770-rtc", .data =3D (void
>>  > > *)ID_JZ4770 },
>>  >
>>  > By doing the correct mapping here e.g:
>>  >
>>  > { .compatible =3D "ingenic,jz4725b-rtc", .data =3D (void *)ID_JZ4740=20
>> },
>>=20
>>  Not very pretty and future-proof if you ask me...
>=20
> Looks to me like this can be handled entirely in DT without driver
> changes like the other patches. Correct usage of compatible strings is
> what gives you future-proofing. And no driver change is better than
> needless changing.

If I make e.g. the jz4760 and jz4770 use the jz4780 compatible string,=20
but
then I want to implement a new feature that only exists on the jz4780,=20
how
can I do it without breaking everything?

> It may look a bit wierd if 4780 is the fallback for 4770, but if the
> 4780 is older, then that actually makes sense.

The 4770 is older than the 4780.

Thanks,
-Paul
=


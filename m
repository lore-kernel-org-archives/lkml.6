Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB7EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C10E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AfaBhmnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C10E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbeGWPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:22:23 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:37276 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeGWPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:22:22 -0400
Date:   Mon, 23 Jul 2018 16:20:40 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
To:     Rob Herring <robh@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <1532355640.2289.0@smtp.crapouillou.net>
In-Reply-To: <CAL_JsqKrJC7v79L89PCP-hihYLSNjp05xMxQQaVZPLPk26MuHw@mail.gmail.com>
References: <20180713151424.13000-1-paul@crapouillou.net>
        <20180714131920.GU16084@piout.net> <1531574734.2831.0@smtp.crapouillou.net>
        <20180714133250.GW16084@piout.net> <1531576208.2831.1@smtp.crapouillou.net>
        <20180720153956.GA18135@rob-hp-laptop>
        <1532113439.2309.1@smtp.crapouillou.net>
        <CAL_JsqKrJC7v79L89PCP-hihYLSNjp05xMxQQaVZPLPk26MuHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532355649; bh=AOoGM+ZvZBappI5UarUBwUkfiY0eQGFPObJTkNbFw4c=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=AfaBhmnrV+8c7Yagr1gfhzRRA/lv4enYkfSDfvOspgUnbcSBVbBON0h14DZwV4ScDEddKq4j83euL/gWoHYCmTBMTJs3LyLNUWhBg9bR9MprTzfpu2BAKU7ztcJ9WWg/ELBjBH1W0EOku0zQrc40VfhOGjd+wpbJC7GFsWze0Ys=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 23 juil. 2018 =E0 16:18, Rob Herring <robh@kernel.org> a =E9crit :
> On Fri, Jul 20, 2018 at 1:04 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi,
>>=20
>>  Le ven. 20 juil. 2018 =E0 17:39, Rob Herring <robh@kernel.org> a=20
>> =E9crit :
>>  > On Sat, Jul 14, 2018 at 03:50:08PM +0200, Paul Cercueil wrote:
>>  >>
>>  >>
>>  >>  Le sam. 14 juil. 2018 =E0 15:32, Alexandre Belloni
>>  >>  <alexandre.belloni@bootlin.com> a =E9crit :
>>  >>  > On 14/07/2018 15:25:33+0200, Paul Cercueil wrote:
>>  >>  > >  Hi Alexandre,
>>  >>  > >
>>  >>  > >  Le sam. 14 juil. 2018 =E0 15:19, Alexandre Belloni
>>  >>  > >  <alexandre.belloni@bootlin.com> a =E9crit :
>>  >>  > >  > Hello,
>>  >>  > >  >
>>  >>  > >  > On 13/07/2018 17:14:24+0200, Paul Cercueil wrote:
>>  >>  > >  > >  The RTC in the JZ4725B works just like the one in the
>>  >> JZ4740.
>>  >>  > >  > >
>>  >>  > >  > >  The RTC in the JZ4760 and JZ4770 work just like the=20
>> one
>>  >> in the
>>  >>  > >  > > JZ4780.
>>  >>  > >  > >
>>  >>  > >  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  > >  > >  ---
>>  >>  > >  > >
>>  >> Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  >>  > > |  3
>>  >>  > >  > > +++
>>  >>  > >  > >   drivers/rtc/rtc-jz4740.c
>>  >>  > > | 11
>>  >>  > >  > > ++++++++++-
>>  >>  > >  > >   2 files changed, 13 insertions(+), 1 deletion(-)
>>  >>  > >  > >
>>  >>  > >  > >  diff --git
>>  >>  > >  > >
>>  >> a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  >>  > >  > >
>>  >> b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  >>  > >  > >  index 41c7ae18fd7b..a9e821de84f2 100644
>>  >>  > >  > >  ---
>>  >>  > >=20
>> a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  >>  > >  > >  +++
>>  >>  > >=20
>> b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
>>  >>  > >  > >  @@ -4,6 +4,9 @@ Required properties:
>>  >>  > >  > >
>>  >>  > >  > >   - compatible: One of:
>>  >>  > >  > >     - "ingenic,jz4740-rtc" - for use with the JZ4740=20
>> SoC
>>  >>  > >  > >  +  - "ingenic,jz4725b-rtc" - for use with the JZ4725B=20
>> SoC
>>  >>  > >  > >  +  - "ingenic,jz4760-rtc" - for use with the JZ4760=20
>> SoC
>>  >>  > >  > >  +  - "ingenic,jz4770-rtc" - for use with the JZ4770=20
>> SoC
>>  >>  > >  > >     - "ingenic,jz4780-rtc" - for use with the JZ4780=20
>> SoC
>>  >>  > >  > >   - reg: Address range of rtc register set
>>  >>  > >  > >   - interrupts: IRQ number for the alarm interrupt
>>  >>  > >  > >  diff --git a/drivers/rtc/rtc-jz4740.c
>>  >>  > > b/drivers/rtc/rtc-jz4740.c
>>  >>  > >  > >  index d0a891777f44..1c867e3a0ea5 100644
>>  >>  > >  > >  --- a/drivers/rtc/rtc-jz4740.c
>>  >>  > >  > >  +++ b/drivers/rtc/rtc-jz4740.c
>>  >>  > >  > >  @@ -54,6 +54,9 @@
>>  >>  > >  > >
>>  >>  > >  > >   enum jz4740_rtc_type {
>>  >>  > >  > >    ID_JZ4740,
>>  >>  > >  > >  + ID_JZ4725B,
>>  >>  > >  > >  + ID_JZ4760,
>>  >>  > >  > >  + ID_JZ4770,
>>  >>  > >  >
>>  >>  > >  > I wouldn't introduce those ids unless there are handling
>>  >>  > > differences at
>>  >>  > >  > some point.
>>  >>  > >
>>  >>  > >  Well there are handling differences, see below.
>>  >>  > >
>>  >>  > >  > >    ID_JZ4780,
>>  >>  > >  > >   };
>>  >>  > >  > >
>>  >>  > >  > >  @@ -114,7 +117,7 @@ static inline int
>>  >>  > > jz4740_rtc_reg_write(struct
>>  >>  > >  > > jz4740_rtc *rtc, size_t reg,
>>  >>  > >  > >   {
>>  >>  > >  > >    int ret =3D 0;
>>  >>  > >  > >
>>  >>  > >  > >  - if (rtc->type >=3D ID_JZ4780)
>>  >>  > >  > >  + if (rtc->type >=3D ID_JZ4760)
>>  >>  > >  >
>>  >>  > >  > This would avoid that change (and the test would=20
>> preferably
>>  >> be
>>  >>  > >  > (rtc->type =3D=3D ID_JZ4780))
>>  >>  > >
>>  >>  > >  That branch should be taken if the SoC is JZ4760, JZ4770 or
>>  >> JZ4780.
>>  >>  > >  It should not be taken if the SoC is JZ4740 or JZ4725B.
>>  >>  >
>>  >>  > Sure but you can achieve that with only 2 ids...
>>  >>  >
>>  >>  > >
>>  >>  > >  > >            ret =3D jz4780_rtc_enable_write(rtc);
>>  >>  > >  > >    if (ret =3D=3D 0)
>>  >>  > >  > >            ret =3D jz4740_rtc_wait_write_ready(rtc);
>>  >>  > >  > >  @@ -300,6 +303,9 @@ static void=20
>> jz4740_rtc_power_off(void)
>>  >>  > >  > >
>>  >>  > >  > >   static const struct of_device_id=20
>> jz4740_rtc_of_match[] =3D
>>  >> {
>>  >>  > >  > >    { .compatible =3D "ingenic,jz4740-rtc", .data =3D (void
>>  >>  > > *)ID_JZ4740 },
>>  >>  > >  > >  + { .compatible =3D "ingenic,jz4725b-rtc", .data =3D (voi=
d
>>  >>  > > *)ID_JZ4725B
>>  >>  > >  > > },
>>  >>  > >  > >  + { .compatible =3D "ingenic,jz4760-rtc", .data =3D (void
>>  >>  > > *)ID_JZ4760 },
>>  >>  > >  > >  + { .compatible =3D "ingenic,jz4770-rtc", .data =3D (void
>>  >>  > > *)ID_JZ4770 },
>>  >>  >
>>  >>  > By doing the correct mapping here e.g:
>>  >>  >
>>  >>  > { .compatible =3D "ingenic,jz4725b-rtc", .data =3D (void=20
>> *)ID_JZ4740
>>  >> },
>>  >>
>>  >>  Not very pretty and future-proof if you ask me...
>>  >
>>  > Looks to me like this can be handled entirely in DT without driver
>>  > changes like the other patches. Correct usage of compatible=20
>> strings is
>>  > what gives you future-proofing. And no driver change is better=20
>> than
>>  > needless changing.
>>=20
>>  If I make e.g. the jz4760 and jz4770 use the jz4780 compatible=20
>> string,
>>  but
>>  then I want to implement a new feature that only exists on the=20
>> jz4780,
>>  how
>>  can I do it without breaking everything?
>=20
> You specify both:
>=20
> compatible =3D "ingenic,jz4760-rtc", "ingenic,jz4780-rtc";
>=20
> You match on the less specific compatible until you have features or
> bugs to handle for the more specific compatible. In your case, you
> would have to start matching on the 4760 and 4770 and not support the
> feature for those. A bit backwards from normal, but would still work.

Right, I didn't think about that.
Thanks!

>>  > It may look a bit wierd if 4780 is the fallback for 4770, but if=20
>> the
>>  > 4780 is older, then that actually makes sense.
>>=20
>>  The 4770 is older than the 4780.
>=20
> As I said, it's weird, but it will all still work. You could fix this
> if you want. It would only matter if you had a old dtb with a new
> kernel and care about that case working.
>=20
> Rob
=


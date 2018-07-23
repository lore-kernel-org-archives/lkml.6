Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D2CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1346620856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="riM8Smhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1346620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbeGWPUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388021AbeGWPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:20:37 -0400
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com [209.85.220.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF23720875;
        Mon, 23 Jul 2018 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532355547;
        bh=s+wGLghMOqtwnYcXidDbYhBUEfMLNE6E/1ZBimC201E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=riM8Smhi7uZheWh+h0vcokKk51hzYKhUrGDhZ1tR9OrtsRnr9bBQCW9JrvlISW4mO
         OqyA5du5WcMp0acH+/9u8j4NxxVxGD+00Gty42q0DuRT65cSPiyC3MmULtY39+3TtQ
         9I9KVPgZIi807otePeF3Kmt7o27i/T7Bqd9YcbA4=
Received: by mail-qk0-f170.google.com with SMTP id 26-v6so486385qks.9;
        Mon, 23 Jul 2018 07:19:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlFRZ77Smfwv8qubULjHZYtl5jxpQZRK4I0HGUDDbAgk6UobEZMU
        6T6aQzWBtYa/Tp1zaTki0BSpGDPgD7+pWVHFTQ==
X-Google-Smtp-Source: AAOMgpcrGfwf4Ejtf919JnO4luBf39gLaWukNkZ5yd5+NjKUmhmSmgXxYpStnaBN5H+Wt1yx3CcBzdoleDJKH+TwN1Q=
X-Received: by 2002:a37:1a69:: with SMTP id a102-v6mr11968146qka.43.1532355546802;
 Mon, 23 Jul 2018 07:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180713151424.13000-1-paul@crapouillou.net> <20180714131920.GU16084@piout.net>
 <1531574734.2831.0@smtp.crapouillou.net> <20180714133250.GW16084@piout.net>
 <1531576208.2831.1@smtp.crapouillou.net> <20180720153956.GA18135@rob-hp-laptop>
 <1532113439.2309.1@smtp.crapouillou.net>
In-Reply-To: <1532113439.2309.1@smtp.crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jul 2018 08:18:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKrJC7v79L89PCP-hihYLSNjp05xMxQQaVZPLPk26MuHw@mail.gmail.com>
Message-ID: <CAL_JsqKrJC7v79L89PCP-hihYLSNjp05xMxQQaVZPLPk26MuHw@mail.gmail.com>
Subject: Re: [PATCH] rtc: jz4740: Add support for the JZ4725B, JZ4760, JZ4770
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 1:04 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> Le ven. 20 juil. 2018 =C3=A0 17:39, Rob Herring <robh@kernel.org> a =C3=
=A9crit :
> > On Sat, Jul 14, 2018 at 03:50:08PM +0200, Paul Cercueil wrote:
> >>
> >>
> >>  Le sam. 14 juil. 2018 =C3=A0 15:32, Alexandre Belloni
> >>  <alexandre.belloni@bootlin.com> a =C3=A9crit :
> >>  > On 14/07/2018 15:25:33+0200, Paul Cercueil wrote:
> >>  > >  Hi Alexandre,
> >>  > >
> >>  > >  Le sam. 14 juil. 2018 =C3=A0 15:19, Alexandre Belloni
> >>  > >  <alexandre.belloni@bootlin.com> a =C3=A9crit :
> >>  > >  > Hello,
> >>  > >  >
> >>  > >  > On 13/07/2018 17:14:24+0200, Paul Cercueil wrote:
> >>  > >  > >  The RTC in the JZ4725B works just like the one in the
> >> JZ4740.
> >>  > >  > >
> >>  > >  > >  The RTC in the JZ4760 and JZ4770 work just like the one
> >> in the
> >>  > >  > > JZ4780.
> >>  > >  > >
> >>  > >  > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  > >  > >  ---
> >>  > >  > >
> >> Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> >>  > > |  3
> >>  > >  > > +++
> >>  > >  > >   drivers/rtc/rtc-jz4740.c
> >>  > > | 11
> >>  > >  > > ++++++++++-
> >>  > >  > >   2 files changed, 13 insertions(+), 1 deletion(-)
> >>  > >  > >
> >>  > >  > >  diff --git
> >>  > >  > >
> >> a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> >>  > >  > >
> >> b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> >>  > >  > >  index 41c7ae18fd7b..a9e821de84f2 100644
> >>  > >  > >  ---
> >>  > > a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> >>  > >  > >  +++
> >>  > > b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> >>  > >  > >  @@ -4,6 +4,9 @@ Required properties:
> >>  > >  > >
> >>  > >  > >   - compatible: One of:
> >>  > >  > >     - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
> >>  > >  > >  +  - "ingenic,jz4725b-rtc" - for use with the JZ4725B SoC
> >>  > >  > >  +  - "ingenic,jz4760-rtc" - for use with the JZ4760 SoC
> >>  > >  > >  +  - "ingenic,jz4770-rtc" - for use with the JZ4770 SoC
> >>  > >  > >     - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
> >>  > >  > >   - reg: Address range of rtc register set
> >>  > >  > >   - interrupts: IRQ number for the alarm interrupt
> >>  > >  > >  diff --git a/drivers/rtc/rtc-jz4740.c
> >>  > > b/drivers/rtc/rtc-jz4740.c
> >>  > >  > >  index d0a891777f44..1c867e3a0ea5 100644
> >>  > >  > >  --- a/drivers/rtc/rtc-jz4740.c
> >>  > >  > >  +++ b/drivers/rtc/rtc-jz4740.c
> >>  > >  > >  @@ -54,6 +54,9 @@
> >>  > >  > >
> >>  > >  > >   enum jz4740_rtc_type {
> >>  > >  > >    ID_JZ4740,
> >>  > >  > >  + ID_JZ4725B,
> >>  > >  > >  + ID_JZ4760,
> >>  > >  > >  + ID_JZ4770,
> >>  > >  >
> >>  > >  > I wouldn't introduce those ids unless there are handling
> >>  > > differences at
> >>  > >  > some point.
> >>  > >
> >>  > >  Well there are handling differences, see below.
> >>  > >
> >>  > >  > >    ID_JZ4780,
> >>  > >  > >   };
> >>  > >  > >
> >>  > >  > >  @@ -114,7 +117,7 @@ static inline int
> >>  > > jz4740_rtc_reg_write(struct
> >>  > >  > > jz4740_rtc *rtc, size_t reg,
> >>  > >  > >   {
> >>  > >  > >    int ret =3D 0;
> >>  > >  > >
> >>  > >  > >  - if (rtc->type >=3D ID_JZ4780)
> >>  > >  > >  + if (rtc->type >=3D ID_JZ4760)
> >>  > >  >
> >>  > >  > This would avoid that change (and the test would preferably
> >> be
> >>  > >  > (rtc->type =3D=3D ID_JZ4780))
> >>  > >
> >>  > >  That branch should be taken if the SoC is JZ4760, JZ4770 or
> >> JZ4780.
> >>  > >  It should not be taken if the SoC is JZ4740 or JZ4725B.
> >>  >
> >>  > Sure but you can achieve that with only 2 ids...
> >>  >
> >>  > >
> >>  > >  > >            ret =3D jz4780_rtc_enable_write(rtc);
> >>  > >  > >    if (ret =3D=3D 0)
> >>  > >  > >            ret =3D jz4740_rtc_wait_write_ready(rtc);
> >>  > >  > >  @@ -300,6 +303,9 @@ static void jz4740_rtc_power_off(void)
> >>  > >  > >
> >>  > >  > >   static const struct of_device_id jz4740_rtc_of_match[] =3D
> >> {
> >>  > >  > >    { .compatible =3D "ingenic,jz4740-rtc", .data =3D (void
> >>  > > *)ID_JZ4740 },
> >>  > >  > >  + { .compatible =3D "ingenic,jz4725b-rtc", .data =3D (void
> >>  > > *)ID_JZ4725B
> >>  > >  > > },
> >>  > >  > >  + { .compatible =3D "ingenic,jz4760-rtc", .data =3D (void
> >>  > > *)ID_JZ4760 },
> >>  > >  > >  + { .compatible =3D "ingenic,jz4770-rtc", .data =3D (void
> >>  > > *)ID_JZ4770 },
> >>  >
> >>  > By doing the correct mapping here e.g:
> >>  >
> >>  > { .compatible =3D "ingenic,jz4725b-rtc", .data =3D (void *)ID_JZ474=
0
> >> },
> >>
> >>  Not very pretty and future-proof if you ask me...
> >
> > Looks to me like this can be handled entirely in DT without driver
> > changes like the other patches. Correct usage of compatible strings is
> > what gives you future-proofing. And no driver change is better than
> > needless changing.
>
> If I make e.g. the jz4760 and jz4770 use the jz4780 compatible string,
> but
> then I want to implement a new feature that only exists on the jz4780,
> how
> can I do it without breaking everything?

You specify both:

compatible =3D "ingenic,jz4760-rtc", "ingenic,jz4780-rtc";

You match on the less specific compatible until you have features or
bugs to handle for the more specific compatible. In your case, you
would have to start matching on the 4760 and 4770 and not support the
feature for those. A bit backwards from normal, but would still work.

> > It may look a bit wierd if 4780 is the fallback for 4770, but if the
> > 4780 is older, then that actually makes sense.
>
> The 4770 is older than the 4780.

As I said, it's weird, but it will all still work. You could fix this
if you want. It would only matter if you had a old dtb with a new
kernel and care about that case working.

Rob

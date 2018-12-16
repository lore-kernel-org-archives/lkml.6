Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F6EC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122B21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 14:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="kpCkiwt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbeLPOTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:19:02 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47650 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbeLPOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 09:19:02 -0500
Date:   Sun, 16 Dec 2018 15:18:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk,
        prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Message-Id: <1544969932.1649.1@crapouillou.net>
In-Reply-To: <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
        <20181212220922.18759-16-paul@crapouillou.net>
        <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
        <1544709795.18952.1@crapouillou.net>
        <20181213204219.onem3q6dcmakusl2@pengutronix.de>
        <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
        <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544969939; bh=Hq0ZCESR3VxDldevdsZM7ZBAIOVzdtDgctxCR8ptZxw=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=kpCkiwt8CzWBqSxf3PO2XKz2pv714bSG/ju7bnOTcthGFgwwX/s/S89ZPxETnVvQu+mZCgmWYFY/fYruHETa+6BD01b8ZDJoHAl0etWfET5yqAvlsF9V1BKhn0PsicOtXTS7sRSzuHiJO2hVto2EJlpt1+mUmFAL75SX6rs40j4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 14 d=E9c. 2018 =E0 15:26, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> a =E9crit :
> Hello,
>=20
> On Fri, Dec 14, 2018 at 02:50:20PM +0100, Linus Walleij wrote:
>>  On Thu, Dec 13, 2018 at 9:42 PM Uwe Kleine-K=F6nig
>>  <u.kleine-koenig@pengutronix.de> wrote:
>>  > [Adding Linus Walleij to Cc:]
>>  > On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
>>  > > Le jeu. 13 d=E9c. 2018 =E0 10:24, Uwe Kleine-K=F6nig
>>  > > <u.kleine-koenig@pengutronix.de> a =E9crit :
>>  > > > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
>>  > > > >  The PWM in the JZ4725B works the same as in the JZ4740,=20
>> except that
>>  > > > > it
>>  > > > >  only has 6 channels available instead of 8.
>>  > > >
>>  > > > this driver is probed only from device tree? If yes, it might=20
>> be
>>  > > > sensible to specify the number of PWMs there and get it from=20
>> there.
>>  > > > There doesn't seem to be a generic binding for that, but=20
>> there are
>>  > > > several drivers that could benefit from it. (This is a bigger=20
>> project
>>  > > > though and shouldn't stop your patch. Still more as it=20
>> already got
>>  > > > Thierry's ack.)
>>  > >
>>  > > I think there needs to be a proper guideline, as there doesn't=20
>> seem to be
>>  > > a consensus about this. I learned from emails with Rob and=20
>> Linus (Walleij)
>>  > > that I should not have in devicetree what I can deduce from the=20
>> compatible
>>  > > string.
>>  >
>>  > I understood them a bit differently. It is ok to deduce things=20
>> from the
>>  > compatible string. But if you define a generic property (say)=20
>> "num-pwms"
>>  > that is used uniformly in most bindings this is ok, too. (And=20
>> then the
>>  > two different devices could use the same compatible.)
>>  >
>>  > An upside of the generic "num-pwms" property is that the pwm core=20
>> could
>>  > sanity check pwm phandles before passing them to the hardware=20
>> drivers.
>>=20
>>  I don't know if this helps, but in GPIO we have "ngpios" which is
>>  used to augment an existing block as to the number of lines actually
>>  used with it.
>>=20
>>  The typical case is that an ASIC engineer synthesize a block for
>>  32 GPIOs but only 12 of them are routed to external pads. So
>>  we augment the behaviour of that driver to only use 12 of the
>>  32 lines.
>>=20
>>  I guess using the remaining 20 lines "works" in a sense but they
>>  have no practical use and will just bias electrons in the silicon
>>  for no use.
>=20
> This looks very similar to the case under discussion.
>=20
>>  So if the PWM case is something similar, then by all means add
>>  num-pwms.
>=20
> .. or "npwms" to use the same nomenclature as the gpio binding?

If we're going to do something like this, should it be the drivers or
the core (within pwmchip_add) that checks for this "npwms" property?

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=


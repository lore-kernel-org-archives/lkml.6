Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768A1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5A821874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551216869;
	bh=JyaDGX3hs9RLtLz2dOXSGcTto7IId9FywDR6kkZChyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=USmtUPE+JS83cjiZ6aFA2k55na9gcvjJEUCuYQlZNtTsgBAKvXc1mxUN7uv74wm9l
	 KpV9hRuyItandcsGtWminpvL0vacKz68tkepd5Ot3mEetFeHsEsykPTUVyRadHXCqO
	 qA67FgRibBbTH8ylqn3EQeB07mpeV0UHp9C3ttOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfBZVe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfBZVe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:34:27 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46321218CD;
        Tue, 26 Feb 2019 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551216865;
        bh=JyaDGX3hs9RLtLz2dOXSGcTto7IId9FywDR6kkZChyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KLhBP4BDca/U6Yr1HD173qYXg0lBczYcTJgPWKAyKvIZlHHgRQfcURQIsyS76hlkm
         sGYCPdfU9nGPUaYcdR3LG83eVkFgo8l19pGSCwWr8XLmH+izm9UY7iMI5nwyQtM6cn
         X00qGFGDHJVtrG8e9VRXVteJwNjRSpwoKJMq0ZpY=
Received: by mail-qk1-f169.google.com with SMTP id x6so8586688qki.6;
        Tue, 26 Feb 2019 13:34:25 -0800 (PST)
X-Gm-Message-State: AHQUAuZ3yA+aSIZfukS0orR/FCZtGDPfJqsl8LJElJ4luqrQbdef2PmS
        jWVgANKeCICEHm+OPOj+EeZWmtA/XKMp2S5rMg==
X-Google-Smtp-Source: AHgI3IZuDcM7Pvc1Y1u4qp0F76hvY3pHxmdySWtRxhm3/zmKveZBQuALhlestLEWggBE2Wn//2C08K7oCrc+aUouar4=
X-Received: by 2002:a37:a381:: with SMTP id m123mr1712984qke.147.1551216864323;
 Tue, 26 Feb 2019 13:34:24 -0800 (PST)
MIME-Version: 1.0
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com> <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net> <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net> <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Feb 2019 15:34:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
Message-ID: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 8:26 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Guenter
>
> Best Regards!
> Anson Huang
>
> > -----Original Message-----
> > From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> > Roeck
> > Sent: 2019=E5=B9=B42=E6=9C=8824=E6=97=A5 11:20
> > To: Anson Huang <anson.huang@nxp.com>; Rob Herring <robh@kernel.org>
> > Cc: mark.rutland@arm.com; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > catalin.marinas@arm.com; will.deacon@arm.com; wim@linux-watchdog.org;
> > Aisheng Dong <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel
> > Baluta <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>;
> > horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb.de;
> > bjorn.andersson@linaro.org; jagan@amarulasolutions.com;
> > enric.balletbo@collabora.com; marc.w.gonzalez@free.fr; olof@lixom.net;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-watchdog@vger.kernel.org; dl-linux-im=
x
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
> > binding
> >
> > On 2/23/19 7:04 PM, Anson Huang wrote:
> > > Hi, Guenter/Rob
> > >
> > > Best Regards!
> > > Anson Huang
> > >
> > >> -----Original Message-----
> > >> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> > >> Roeck
> > >> Sent: 2019=E5=B9=B42=E6=9C=8824=E6=97=A5 1:08
> > >> To: Rob Herring <robh@kernel.org>; Anson Huang
> > <anson.huang@nxp.com>
> > >> Cc: mark.rutland@arm.com; shawnguo@kernel.org;
> > >> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > >> catalin.marinas@arm.com; will.deacon@arm.com; wim@linux-
> > watchdog.org;
> > >> Aisheng Dong <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel
> > >> Baluta <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>;
> > >> horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb.de;
> > >> bjorn.andersson@linaro.org; jagan@amarulasolutions.com;
> > >> enric.balletbo@collabora.com; marc.w.gonzalez@free.fr;
> > >> olof@lixom.net; devicetree@vger.kernel.org;
> > >> linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > >> linux-watchdog@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > >> Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add
> > >> watchdog binding
> > >>
> > >> On 2/22/19 11:52 AM, Rob Herring wrote:
> > >>> On Mon, Feb 18, 2019 at 06:53:48AM +0000, Anson Huang wrote:
> > >>>> Add i.MX8QXP system controller watchdog binding.
> > >>>>
> > >>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > >>>> ---
> > >>>> Changes since V1:
> > >>>>  - update dts node name to "watchdog";
> > >>>> ---
> > >>>>    Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1=
0
> > >> ++++++++++
> > >>>>    1 file changed, 10 insertions(+)
> > >>>>
> > >>>> diff --git
> > >>>> a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > >>>> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > >>>> index 4b79751..f388ec6 100644
> > >>>> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > >>>> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > >>>> @@ -136,6 +136,12 @@ Required properties:
> > >>>>                             resource id for thermal driver to get =
temperature
> > >> via
> > >>>>                             SCU IPC.
> > >>>>
> > >>>> +Watchdog bindings based on SCU Message Protocol
> > >>>> +------------------------------------------------------------
> > >>>> +
> > >>>> +Required properties:
> > >>>> +- compatible: should be "fsl,imx8qxp-sc-wdt";
> > >>>> +
> > >>>>    Example (imx8qxp):
> > >>>>    -------------
> > >>>>    lsio_mu1: mailbox@5d1c0000 {
> > >>>> @@ -188,6 +194,10 @@ firmware {
> > >>>>                          tsens-num =3D <1>;
> > >>>>                          #thermal-sensor-cells =3D <1>;
> > >>>>                  };
> > >>>> +
> > >>>> +                watchdog: watchdog {
> > >>>> +                        compatible =3D "fsl,imx8qxp-sc-wdt";
> > >>>
> > >>> As-is, there's no reason for this to be in DT. The parent node's
> > >>> driver can instantiate the wdog.
> > >>>
> > >>
> > >> As the driver is currently written, you are correct, since it doesn'=
t
> > >> accept watchdog timeout configuration through devicetree.
> > >>
> > >> Question is if that is intended. Is it ?
> > >
> > > I am a little confused, do you mean we no need to have "watchdog" nod=
e
> > in side "scu"
> > > node? Or we need to modify the watchdog node's compatible string to "
> > > fsl,imx-sc-wdt" to make it more generic for other platforms? If yes, =
I can
> > resend the patch series to modify it.
> > >
> >
> > I think Rob suggested that the SCU parent driver should instantiate the
> > watchdog without explicit watchdog node. That would be possible, but it
> > currently uses
> > devm_of_platform_populate() to do the instantiation, and changing that
> > would be a mess. Besides, it does sem to me that your suggested node wo=
uld
> > describe the hardware, so I am not sure I understand the reasoning.

It would just be a call to create a platform device instead. How is that a =
mess?

It's describing firmware. We have DT for describing h/w we've failed
to make discoverable. We should not repeat that and just describe
firmware in DT. Make the firmware discoverable! Though there are cases
like firmware provided clocks where we still need something in DT, but
this is not one of them.

> >
> > For my part I referred to
> >       watchdog_init_timeout(imx_sc_wdd, DEFAULT_TIMEOUT, &pdev-
> > >dev); in the driver, which guarantees that the timeout property will n=
ot be
> > used to set the timeout. A more common implementation would have been
> >
> >       imx_sc_wdd->timeout =3D DEFAULT_TIMEOUT;
> >       ret =3D watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
> >
> > where 'timeout' is the module parameter. Which is actually not used in =
your
> > driver.
> > Hmm ... I wasn't careful enough with my review. The timeout initializat=
ion as-
> > is doesn't make sense. I'll comment on that in the patch.
>
> I understand now, in our cases, I would still prefer to have watchdog nod=
e under
> the SCU parent node, since there could be other property setting differen=
ce between
> different i.MX platforms with system controller watchdog inside, using th=
e SCU node
> to instantiate makes us a little confused about the watchdog, so if it is=
 NOT that critical,
> I think we should keep watchdog node. But to make the watchdog driver mor=
e generic
> for other i.MX platforms, I changed the compatible string to "fsl,imx-sc-=
wdt" in driver, and
> each SoC should has it as fallback if it can reuse this watchdog driver.

You handle differences between SoCs by having specific compatibles. So
"fsl,imx-sc-wdt" moves in the wrong direction assuming we have a node
in the first place.

Rob

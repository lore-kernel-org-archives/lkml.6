Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD756222D0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vf9FeNEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbfBNJ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:29:35 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36182 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403924AbfBNJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:29:34 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so11541286itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0NcH0FDVmvKPVuauPZK+VSPbhR4N1OpqM/82JWavvhU=;
        b=Vf9FeNEc8YaLBhHNo4+Rej+sGgAXcr3eSQYpqkq1ntRYeLsBsitdLSlWuGTqGVDoBB
         SW9Vkh61VNyZ9aMlZIJz0SzgBTn7Z+BFVZfr6H1os/4AAnU850Fk3rYjMb05cAi+DHoT
         SnCKNcRrnga+oIVdcoi8BcF7TCSEN/YiDeMJ0JeLfd5Ub+MujLQMgBbkbHfIJYMMEIzu
         aD0NhVDGaHYGwFYt5lzA1bNDv0i5zOENRT1/H72XEkcLClmtIFNIqWNXHFX7q4Lqup24
         F8rNwbksYc7T0L1iF5nEEr9B+nYShYq6zbWU1Euhs2MqUXPNBgQmynh9HQBwBmHABJc/
         7wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NcH0FDVmvKPVuauPZK+VSPbhR4N1OpqM/82JWavvhU=;
        b=EAKIpDnDmZlwBvC85cIksh5BZT5mkH+6bPwdvz3oRqFA4aDTd99dNqeSOzS9nGMhlE
         iwnReAPXAESUfgw+dfIEcafmVOOrdhluzoVuPtgt/fyeVUUbtTsc/ENwdrC/PwMGqkJr
         nPnaLFHs4qSiaONgXTAGu6gOFLFpuVmVbuuqT6q3cbnyL7JmZGqctcuOgC9sU17VUQEA
         t8yTloUqRPWhvYQ73pALUsaIsBdaQ4OLso7wKvhUFKuIxgdkWL9Wbr0eL0DI+oixwiLm
         wycgS8YbqnlAeTUy7wndc2iczIa6GaQfYUSjRz13nwEWu8YzXesDmoVqAe1yoVasktiI
         t3bA==
X-Gm-Message-State: AHQUAubKdPGNEMZzxQ3kqxgNzC0NGXwS/7DMtVhphJDZ0CX8iLSSHLyo
        DUChDjSMYdIL//HSF9i2tsp0AVC07tSOY/y0tTB6Xw==
X-Google-Smtp-Source: AHgI3Ia5VWRiAscGLGg15IVILikBFOCErFA2VkkHyWyDoVt7PcZUip/M65LzxTPTx3Voh/FB0npMtiel3n4imRO73mw=
X-Received: by 2002:a24:2b8c:: with SMTP id h134mr1614936ita.53.1550136573562;
 Thu, 14 Feb 2019 01:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20190213134335.10838-1-brgl@bgdev.pl> <20190213134335.10838-3-brgl@bgdev.pl>
 <20190213204834.GA31342@bogus>
In-Reply-To: <20190213204834.GA31342@bogus>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Feb 2019 10:29:22 +0100
Message-ID: <CAMRc=MeyMnRMzmexgNBF5PkP-Hs2G2sS4hCP4mTZR5jxC=ej1w@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: add DT bindings for max77650
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 13 lut 2019 o 21:48 Rob Herring <robh@kernel.org> napisa=C5=82(a)=
:
>
> On Wed, Feb 13, 2019 at 02:43:26PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the DT binding document for the battery charger module of max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/max7=
7650-charger.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-ch=
arger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > new file mode 100644
> > index 000000000000..16e24173c80e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> > @@ -0,0 +1,27 @@
> > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > +
> > +This module is part of the MAX77650 MFD device. For more details
> > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > +
> > +The charger is represented as a sub-node of the PMIC node on the devic=
e tree.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:                Must be "maxim,max77650-charger"
> > +
> > +Optional properties:
> > +--------------------
> > +- min-input-voltage: Minimum CHGIN regulation voltage (in microvolts).=
 Must be
> > +                     one of: 4000000, 4100000, 4200000, 4300000, 44000=
00,
> > +                     4500000, 4600000, 4700000.
> > +- current-limit:     CHGIN input current limit (in microamps). Must be=
 one of:
> > +                     95000, 190000, 285000, 380000, 475000.
>
> Unit suffix? Really, these should be common properties. We have
> some I think. Charger bindings are a mess though...
>

Do you mean a suffix like: ua for microamps and uv for microvolts? I'm
not seeing any other such properties.

Bart

> > +
> > +Example:
> > +--------
> > +
> > +     charger {
> > +             compatible =3D "maxim,max77650-charger";
> > +             maxim,vchgin-min =3D <4200000>;
> > +             maxim,ichgin-lim =3D <285000>;
>
> Doesn't match above.
>
> > +     };
> > --
> > 2.20.1
> >

Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95102C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D8C222D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550153906;
	bh=ppQ40leumj7276kuJ6+PBZFlSMzO2EfUr+Y/f9pfN6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iKKGfPwHhVauh4W+68bN+v3Z5MaxJYQ6fk905K6to8J42UIVH5PSmD6kGNv2Vbaq7
	 t6zJGbCMz98JtDpK3hFLCW16qG0q0CkhE6mGyHVNg9bY6/DK1lWcSZq/3X5q375dkh
	 Di1UAtf2jzJUGJ9eYIrihdvdntK5GDFskNPfEDY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407210AbfBNOSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407195AbfBNOSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:18:24 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6E1222DC;
        Thu, 14 Feb 2019 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550153903;
        bh=ppQ40leumj7276kuJ6+PBZFlSMzO2EfUr+Y/f9pfN6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eKkQkOSlvXhALEOy3vPOMlkSL8iRW/Yh4alEht8lTjC1o1x6+Jbx0c3/gHV59ubWr
         dcaDNA8/ZWmnDX369+f9uRUUufFhf8Cadm+dO75GJmo8jwO11q8BfBzemMeLwpMQoG
         ZELcl6RU801xf4cauDXUUUPyXFyQLc3/Kv5iNG4k=
Received: by mail-qt1-f171.google.com with SMTP id o6so6963037qtk.6;
        Thu, 14 Feb 2019 06:18:23 -0800 (PST)
X-Gm-Message-State: AHQUAubfTlg9JzIwg3wv3ul5UhVZuslpCC5AklePXxRGjoLdq9rbml9r
        o+Uja3UsTsd3UVvo07csGIqKdDEoF3shNJI9uw==
X-Google-Smtp-Source: AHgI3IYl9XA/pXWO8mOOe0Uz+3U9+oWQ9tY8lUql0kgM+PCyHXGGLS6dZkqlLteoppiXGHqM7n/mg0GhmgTDZwLzkHE=
X-Received: by 2002:ac8:25d1:: with SMTP id f17mr3137369qtf.38.1550153902723;
 Thu, 14 Feb 2019 06:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20190213134335.10838-1-brgl@bgdev.pl> <20190213134335.10838-3-brgl@bgdev.pl>
 <20190213204834.GA31342@bogus> <CAMRc=MeyMnRMzmexgNBF5PkP-Hs2G2sS4hCP4mTZR5jxC=ej1w@mail.gmail.com>
In-Reply-To: <CAMRc=MeyMnRMzmexgNBF5PkP-Hs2G2sS4hCP4mTZR5jxC=ej1w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Feb 2019 08:18:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKokJhAXyOV1y-TNYfNAsd236vz0kLQkg+rpTKPZynWPw@mail.gmail.com>
Message-ID: <CAL_JsqKokJhAXyOV1y-TNYfNAsd236vz0kLQkg+rpTKPZynWPw@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: add DT bindings for max77650
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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

On Thu, Feb 14, 2019 at 3:29 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> =C5=9Br., 13 lut 2019 o 21:48 Rob Herring <robh@kernel.org> napisa=C5=82(=
a):
> >
> > On Wed, Feb 13, 2019 at 02:43:26PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Add the DT binding document for the battery charger module of max7765=
0.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++=
++
> > >  1 file changed, 27 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/supply/ma=
x77650-charger.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-=
charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charg=
er.txt
> > > new file mode 100644
> > > index 000000000000..16e24173c80e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > > @@ -0,0 +1,27 @@
> > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > > +
> > > +This module is part of the MAX77650 MFD device. For more details
> > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > +
> > > +The charger is represented as a sub-node of the PMIC node on the dev=
ice tree.
> > > +
> > > +Required properties:
> > > +--------------------
> > > +- compatible:                Must be "maxim,max77650-charger"
> > > +
> > > +Optional properties:
> > > +--------------------
> > > +- min-input-voltage: Minimum CHGIN regulation voltage (in microvolts=
). Must be
> > > +                     one of: 4000000, 4100000, 4200000, 4300000, 440=
0000,
> > > +                     4500000, 4600000, 4700000.
> > > +- current-limit:     CHGIN input current limit (in microamps). Must =
be one of:
> > > +                     95000, 190000, 285000, 380000, 475000.
> >
> > Unit suffix? Really, these should be common properties. We have
> > some I think. Charger bindings are a mess though...
> >
>
> Do you mean a suffix like: ua for microamps and uv for microvolts? I'm
> not seeing any other such properties.

See bindings/property-units.txt

Rob

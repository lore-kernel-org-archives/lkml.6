Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA1BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF5D2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HrSLwR9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfBDUti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:49:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34514 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfBDUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:49:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so2242451otk.1;
        Mon, 04 Feb 2019 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tord4prjwOyjm36JPqP6avPb7bbeEZzoWDKJvQIGCQA=;
        b=HrSLwR9XJJbiuRMaCDrGJGSfib9zpAelRfvut2zDcp88SBz1UVj+1YvPB2QTRi9D/t
         TLJmUGnMQTbo7ABMj0HCBfCBeodzc1BccKkDTCMu1o/GFgqgYXYpjcOpMihXowY97vX5
         Sek73EP9mnoOcb5DgSVc5Vx9UrZFsVCQSiEHS5h3wtqg7xVcqBeIPO3KLkD3vPuFl8oS
         qKWu+FetIxaY380DRdIBSBMgr2tI8rzS3EMoUBh1rO7//A2w1epZUg2YeHxkyXPw2aE7
         5WXUZAM14DdquEdOtYTcEv/s8aA5u0WlcisDp+M9OyByPOpyHjSBtHP/Kl3gLPGtQy9j
         1zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tord4prjwOyjm36JPqP6avPb7bbeEZzoWDKJvQIGCQA=;
        b=fda5Ilvy2BXypsWXJibyXIKzEZaq0F1DJJXmOnweEL4HDdtbjs9pgLu97fn/vG/36X
         qAMNmzLJX+1xVcjqEZ+mjSmg1Fn/7O71b+hZfhOF4M1GzWzhi5F0rIGy9aChVtsgySNE
         IgE3lKyZ0NCFp4FmC5ZiLzm/9bqqcinevftQWEsuy3tPKEJ6g67pb7+mk2T/BlGX42de
         S1poFk4jF5yZSx5lZSKPhZmQqCuyE/Y8TzvzVpjd6TGo3ty3joXYl515nfjCYlkp+7es
         XRU9sLlRp217jS8gAl6wgdV+fZCYkweane9Oaq3KtWQwmskao0OxMctz2TgOGNuysWli
         26FA==
X-Gm-Message-State: AHQUAuYLEI47I8PoxU50abPvME6FYXa6+eiAczFhtNP/7SrpjLxVnIta
        D7p5tEN7WKrQP7pE8HNyXpHlJWMBvVXt9E49kZQ=
X-Google-Smtp-Source: AHgI3IZtxfCzW6NJ3v6eHXfXL6pGpISmEjJTIQBnGGW0QKPOSKtMRALRQdYHlwd4w9vR55gOzLGxHuWUQFWKRYN6GW0=
X-Received: by 2002:aca:3586:: with SMTP id c128mr712196oia.47.1549313377317;
 Mon, 04 Feb 2019 12:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com> <20190129102521.4141-2-linux.amoon@gmail.com>
 <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com> <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com>
In-Reply-To: <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Feb 2019 21:49:26 +0100
Message-ID: <CAFBinCBjF5iOkUjhxSGXpQa7Nc1=bWAzA=XjrfXRYxSPZO15nQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, Feb 4, 2019 at 9:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > > @@ -36,6 +43,8 @@
> > >                 regulator-min-microvolt = <5000000>;
> > >                 regulator-max-microvolt = <5000000>;
> > >
> > > +               vin-supply = <&p5v0>;
> > did you find out why this patch fixes the USB_OTG_PWR regulator?
> > based on just reading the patch I can't find an explanation myself
> >
>
> As per the device tree binding we need this setting to enable power input source
> [0] Documentation/devicetree/bindings/regulator/fixed-regulator.txt
>
> *I have observed few more place where this setting is missing*
OK, I understand that we should describe the hierarchy of the regulators

> > have you tested without this patch to rule out that you hit some bug
> > in the regulator framework back when you wrote the patch?
> > (I don't have an Odroid-C2 so I can't test this myself).
> >
>
> Yes I have tested this patch.Some device like usb camera and usb hard drive
> when connected to usb port will generate warning message.
> which shows us that not enough power is being set to the port.
I don't understand why adding "p5v0" as parent of "usb_otg_pwr"
changes the output of "usb_otg_pwr":
- "p5v0" is a fixed regulator which cannot be controlled at all (apart
from removing power from it)
- "usb_otg_pwr" does not have any current limits set inside the .dts
- "usb_otg_pwr" has the same fixed voltage as the new "p5v0" regulator

what are your steps-to-reproduce for your original issue ("reset
high-speed USB device number 3 using dwc2")?


Regards
Martin

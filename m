Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479ADC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCB92081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgzrVt+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfBDUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:04:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40176 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfBDUE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:04:57 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so1945879oth.7;
        Mon, 04 Feb 2019 12:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdNKk9nvat9w/9d/QSXjnvAWHsniXIPePf5/7xOPDAQ=;
        b=RgzrVt+Ciu+oAPB0kbcPF38EMaJMR8p7PU3D8ldh+wR8G7MSXdFCtrQSWzIQNI7A1h
         ChcZz0TZUKJX2wlQeSb7LEjGoXk2Q2vnv51Vlncr7hSaUU8qYgel3CXaWySO6k93VAbL
         a+14udI0zDz31HB3yM+IfZBuju8CAbx1f+UsTyW8j8IT/VXc6lEL1lv9rFBBW94mwk/i
         JTdaVh15hiMHgx/T35lgbHuiIuIp7xVYKz/qtfYBhEEbBjg+OFj8jV8XSbAOxY7qqaxU
         SCWHqIU23obclGrRcBaHEdtYn1QvBqXaZ8DLSjO4GQxYwesNzrlXU1A8W8IFuJG0CmQA
         yKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdNKk9nvat9w/9d/QSXjnvAWHsniXIPePf5/7xOPDAQ=;
        b=G6Q3Nty0Uj1KypREzt4ZGVOub5m0Wxblq0U6igbpEZehSKL19/SNXcvxL+RMlIHomV
         gjKfv44ur/WA+h8RmBzxwE91arYJR4OupIrIpUR7HPt+ngW2JgOpn0wFhbczCqg5sds6
         bQ9O+wm+cGxzgZ9JQceEXFd5GvecRRcrmo/LFB2RWhiIPLyslp+n4h7usn6hNfMg2sx9
         DHvOtQxLPYRrbsdxX2psHvr3V4y6Ovf2uQrInJs5t+E4t9y6rr1MSJSQguPdaCMbz5f/
         FwSbICDSziSQQZrCBucUPuw1gcj1ggzrUk+QgUJvzXY6znGiF+peFDO4qVRsAWBCh9MQ
         uneQ==
X-Gm-Message-State: AHQUAuai+iEIY/5XjgJQm6ozI5F+iR6vbOI/bJrqjB6IqpW50PuAoaZA
        SKJdwAm1TL5ZJAAeDpA82l8vZIpx+inpqYne3Q0=
X-Google-Smtp-Source: AHgI3IZMvbXODUZBbxu1Pth4DtEM4TyJk5Z7WPQKgsybgsckgchpBvI/XwLh4pbBKJY04tqF8HrGjzV/AHRArxLBZ0M=
X-Received: by 2002:aca:39c6:: with SMTP id g189mr591597oia.201.1549310695898;
 Mon, 04 Feb 2019 12:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com> <20190129102521.4141-2-linux.amoon@gmail.com>
 <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
In-Reply-To: <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 5 Feb 2019 01:34:42 +0530
Message-ID: <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

Hi Martin,

Thanks for your review comments.

On Mon, 4 Feb 2019 at 19:29, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Jan 29, 2019 at 11:25 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add missing vin-supply node 5.0V regulator setting to power
> > to usb ports, changes help fix the usb reset warning.
> >
> > [  795.380156] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  798.356073] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  801.331999] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  804.307919] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  807.283844] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> >
> > Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > changes from prevoius
> >
> >  regulator                      use open bypass  opmode voltage current     min     max
> > ---------------------------------------------------------------------------------------
> >  regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV
> >     c9100000.usb                  1                                 0mA     0mV     0mV
> >     c9100000.usb                  1                                 0mA     0mV     0mV
> >     c9000000.usb                  1                                 0mA     0mV     0mV
> >     c9000000.usb                  1                                 0mA     0mV     0mV
> >  P5V0                             1    1      0 unknown  5000mV     0mA  5000mV  5000mV
> >     USB_OTG_PWR                   4    2      0 unknown  5000mV     0mA  5000mV  5000mV
> >        phy-c0000020.phy.1         2                                 0mA     0mV     0mV
> >        phy-c0000000.phy.0         2                                 0mA     0mV     0mV
> > --
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > index 2e1cd5e3a246..da729ed00408 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > @@ -28,6 +28,13 @@
> >                 reg = <0x0 0x0 0x0 0x80000000>;
> >         };
> >
> > +       p5v0: regulator-p5v0 {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "P5V0";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +       };
> > +
> >         usb_otg_pwr: regulator-usb-pwrs {
> >                 compatible = "regulator-fixed";
> >
> > @@ -36,6 +43,8 @@
> >                 regulator-min-microvolt = <5000000>;
> >                 regulator-max-microvolt = <5000000>;
> >
> > +               vin-supply = <&p5v0>;
> did you find out why this patch fixes the USB_OTG_PWR regulator?
> based on just reading the patch I can't find an explanation myself
>

As per the device tree binding we need this setting to enable power input source
[0] Documentation/devicetree/bindings/regulator/fixed-regulator.txt

*I have observed few more place where this setting is missing*

> have you tested without this patch to rule out that you hit some bug
> in the regulator framework back when you wrote the patch?
> (I don't have an Odroid-C2 so I can't test this myself).
>

Yes I have tested this patch.Some device like usb camera and usb hard drive
when connected to usb port will generate warning message.
which shows us that not enough power is being set to the port.

>
> Regards
> Martin

Best Regards



-Anand

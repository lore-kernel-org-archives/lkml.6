Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A04C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126A02080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHqISbjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfBETx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:53:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38355 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfBETx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:53:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id e12so7907262otl.5;
        Tue, 05 Feb 2019 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAazEzP0AmczIR8hnl6k673OVHEao5Qycj49uG7Q4W4=;
        b=SHqISbjyLvYyJyF1pUWvNbVYPPWCPS+UnJ8GM3X72AAOHfuGkx9aKB0p8H49zPJLZI
         W1i7QoHLJdYNa3CJg3WQfOz2759P9mShR93p/dCRwE7WugcQuJUn7ju7JVRxVt/u1kSM
         gw7PIbPfAbjbyR4xvmlhEawJMojn3HR6COLy1IiJxZOz5tvY+2U454bPjFUeVFCKMkbG
         Fp/WYKb0u4YJfFzJkbxBXbm5bRBtX81Zg5E3dKxB0tevBPmvIkK74QZO7imXL6xrXaMu
         S7hBOZ/GJfAtLJPf1UA1YInQSPflTWkYiTLhV90E9W1nWSjMX4totIWkrQ3pwwW1O6DT
         mxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAazEzP0AmczIR8hnl6k673OVHEao5Qycj49uG7Q4W4=;
        b=r3doJL9jch88rcwzQdD22lR3GaG11+vBm4ZOIspdc28CSD9YNykbV3J/vP/mnpEYWf
         Pfep6xaEaOMDtS6CEG9JKaflW60qu0OlIhn8gvrKczBvQ8yzRKsq5GZr4si+xXxMuS5I
         p3sXBSxhfOOG52cihJKxUogG4rwJL2Btb9t20tMxnET6nMyDLUji9pxRLqfZVi9L9F/E
         /BGykFTKrakLxHo0h7oV/ENou8SNAz2Z9dLfClTTVGlJs1cswFLZp7Yvk/wiGFsDdA2O
         d6Qnag19nHh45fJ0ZVurN563CN8iL4CjsoDtlFMT6Pq8l232PozfhifThPPFB5K2wFcJ
         PPyQ==
X-Gm-Message-State: AHQUAuaO/Ell3I87utIo/jEAFVyDspjvtHRYbdIsvkQLGnFrTxrrSZan
        3SxVyLwSFrbE1tBOsdM91JgQXREvq3D26aVfKt8=
X-Google-Smtp-Source: AHgI3IbOs/NvbnBIEyAt1I3ymLP5OW3XBJtK9nMv8oS04YsfoAdHyaOoJGIVlmEq4XufBUaToL4HDR3Py6m/jKHBjUg=
X-Received: by 2002:aca:915:: with SMTP id 21mr3517231oij.163.1549396437046;
 Tue, 05 Feb 2019 11:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com> <20190129102521.4141-2-linux.amoon@gmail.com>
 <CAFBinCDj=Y9HWEhJYMjo9FviAosxpHW5d61CceZ7HPV4ObZ79Q@mail.gmail.com>
 <CANAwSgSnR-DWffg3vKStuXQXahLf8ONssxr4+byL=PSr5JR=xA@mail.gmail.com> <CAFBinCBjF5iOkUjhxSGXpQa7Nc1=bWAzA=XjrfXRYxSPZO15nQ@mail.gmail.com>
In-Reply-To: <CAFBinCBjF5iOkUjhxSGXpQa7Nc1=bWAzA=XjrfXRYxSPZO15nQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 6 Feb 2019 01:23:45 +0530
Message-ID: <CANAwSgT_q6zDVC8UVz+hrzA5Hn34eT_k-ZGB2LTO3dauT45T7g@mail.gmail.com>
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

hi Martin,

On Tue, 5 Feb 2019 at 02:19, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Feb 4, 2019 at 9:04 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > @@ -36,6 +43,8 @@
> > > >                 regulator-min-microvolt = <5000000>;
> > > >                 regulator-max-microvolt = <5000000>;
> > > >
> > > > +               vin-supply = <&p5v0>;
> > > did you find out why this patch fixes the USB_OTG_PWR regulator?
> > > based on just reading the patch I can't find an explanation myself
> > >
> >
> > As per the device tree binding we need this setting to enable power input source
> > [0] Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> >
> > *I have observed few more place where this setting is missing*
> OK, I understand that we should describe the hierarchy of the regulators
>
> > > have you tested without this patch to rule out that you hit some bug
> > > in the regulator framework back when you wrote the patch?
> > > (I don't have an Odroid-C2 so I can't test this myself).
> > >
> >
> > Yes I have tested this patch.Some device like usb camera and usb hard drive
> > when connected to usb port will generate warning message.
> > which shows us that not enough power is being set to the port.
> I don't understand why adding "p5v0" as parent of "usb_otg_pwr"
> changes the output of "usb_otg_pwr":
> - "p5v0" is a fixed regulator which cannot be controlled at all (apart
> from removing power from it)
> - "usb_otg_pwr" does not have any current limits set inside the .dts
> - "usb_otg_pwr" has the same fixed voltage as the new "p5v0" regulator
>
> what are your steps-to-reproduce for your original issue ("reset
> high-speed USB device number 3 using dwc2")?
>

I have tried to reproduce this but some how I cannot get the logs
I might have enable some more debug options to reproduce but currently
it's lost.
because of over flashing of the operating system on sdcards.

But definitely this fix the power issue needed to get usb-storage
device to work on Odroid c1/c2 boards.

>
> Regards
> Martin

Best Regards

-Anand

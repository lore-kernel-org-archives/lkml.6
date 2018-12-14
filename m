Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54911C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB84C20643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeLNNiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:38:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37864 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbeLNNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:38:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id g125so3001619qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUVAg2Ax7nILc1ZQj4+Tg6FHQWQrVG8S8WRiii29Y74=;
        b=omn0G12Wp01Sq9I/XpHiXSi7CU6F9e6+4m80vxV2Ve3V2spRKJnjT0EvaLPB4byTaw
         Y1jgQIshuhPhvcdUQVPnbthT2DOJLedw0gBhlL/1xMtW7Xg/E0fUDswxBRt0mZVA8evb
         xRpleqBrN5SNDyaqMHTXC/Xxae5coMVQGeqJKmGNND/ohyI30tye7lZ6UQte6RYQ1+Fy
         kehp4eoCwvLZlviP3m1f8ydruw5F9CHbRX885goTm7z898SRe92s05RQkfVsM6WGoqvx
         pxk1NbHKLcMLzJDrF3hiGThVfhcw03yu7Bcza/yl+LGDWrfpArmBTy1NGUejvMjh6lhF
         f5qA==
X-Gm-Message-State: AA+aEWatXlO+oFWubVMblQj/ezrEx//1ND5U9gtLDvziw0FyKHwP2Gkq
        11o/roDIE/RYkTPQ+9L7D0F7vA/Tp9owWQbE8d0tnQ==
X-Google-Smtp-Source: AFSGD/WUebGg1iPOAeFdKKoOCd+aBtLC/5cYlPzJn7wcrkM9nT4K0NQYAKU55mFf3PLng7hoyo6cWMEjsBpuCHj/Raw=
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr2515368qkf.194.1544794684335;
 Fri, 14 Dec 2018 05:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20181201190153.GB4995@arks.localdomain> <20181214080700.GA4189@rocks>
 <CAO-hwJJRuBbHKCmW4vcmjdDkNEF0==wuLC5ymSkw8mOHnkdwwQ@mail.gmail.com> <20181214133409.GB4189@rocks>
In-Reply-To: <20181214133409.GB4189@rocks>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 14 Dec 2018 14:37:52 +0100
Message-ID: <CAO-hwJJsE0eFqYb8A9qFqohy6vXj4EB9qJ3myB_PPzbDa=Jo3Q@mail.gmail.com>
Subject: Re: [PATCH] HID: asus: Add support for the ASUS T101HA keyboard dock
To:     kernelrocks@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, mbrugger@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 2:34 PM Aleix Roca Nonell <kernelrocks@gmail.com> wrote:
>
> Hi Benjamin! :D
>
> On Fri, Dec 14, 2018 at 09:25:20AM +0100, Benjamin Tissoires wrote:
> > Hi Aleix,
> >
> > On Fri, Dec 14, 2018 at 9:07 AM Aleix Roca Nonell <kernelrocks@gmail.com> wrote:
> > >
> > > Kind remminder ping :)
> >
> > Hehe, I have seen the patch floating by and realized I would need more
> > than 2 minutes to answer it so it fell a little bit behind in my TODO
> > list.
> >
> > Let's try to work on this now.
> >
> > >
> > > I'm also adding my fellow Matthias in CC
> > >
> > > On Sat, Dec 01, 2018 at 08:01:53PM +0100, Aleix Roca Nonell wrote:
> > > > The ASUS T101HA keyboard dock generates HID events using the ASUS vendor
> > > > specific UsagePage 0xff31. In consequence, some multimedia keys such as
> > > > brightness up and down are not working with hid-generic.
> > > >
> > > > This commit adds the T101HA dock into the supported device list of the
> > > > hid-asus driver. It also prevents the dock's integrated touchpad to be
> > > > bound with hid-asus given that it is already working fine with
> > > > hid-multitouch.
> > > >
> > > > Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> > > > ---
> > > >
> > > > This is my very first kernel patch done in my free time (be aware of the
> > > > newbie!!) so please, let me know if I can improve anything and I will
> > > > happily do it :)
> > > >
> > > >  drivers/hid/hid-asus.c | 12 ++++++++++++
> > > >  drivers/hid/hid-ids.h  |  1 +
> > > >  2 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > > > index ab8bd40a77ed..d8b55dca97c6 100644
> > > > --- a/drivers/hid/hid-asus.c
> > > > +++ b/drivers/hid/hid-asus.c
> > > > @@ -42,6 +42,7 @@ MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
> > > >  MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> > > >
> > > >  #define T100_TPAD_INTF 2
> > > > +#define T101HA_TPAD_INTF 2
> > > >
> > > >  #define T100CHI_MOUSE_REPORT_ID 0x06
> > > >  #define FEATURE_REPORT_ID 0x0d
> > > > @@ -70,6 +71,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> > > >  #define QUIRK_T100_KEYBOARD          BIT(6)
> > > >  #define QUIRK_T100CHI                        BIT(7)
> > > >  #define QUIRK_G752_KEYBOARD          BIT(8)
> > > > +#define QUIRK_T101HA_DOCK            BIT(9)
> > > >
> > > >  #define I2C_KEYBOARD_QUIRKS                  (QUIRK_FIX_NOTEBOOK_REPORT | \
> > > >                                                QUIRK_NO_INIT_REPORTS | \
> > > > @@ -649,6 +651,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > > >       int ret;
> > > >       struct asus_drvdata *drvdata;
> > > >
> > > > +     if (id->driver_data & QUIRK_T101HA_DOCK) {
> > > > +             struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> >
> > I know the hid-asus driver already does this for the other devices,
> > but it would be nice not to. USB is part of the low level transport
> > and HID drivers should have no reasons to assume the USB driver is
> > used and that it will stay forever.
> >
> > What I ask when we have such a case is to check on the report
> > descriptor to see if there is anything we could use in it (usually the
> > application) to skip this HID interface.
> >
> > Besides that, there is not much more to say.
>
> Great I will do that!
>
> > For having a look at the report descriptor, you can either use printk
> > in the kernel, or use hid-recorder as root in
> > https://gitlab.freedesktop.org/libevdev/hid-tools.
>
> Regarding the descriptor, shouldn't be ok to check
> /sys/kernel/debug/hid/<dev>/rdesc ?

Yep, that works too. I knew there was an other way from the kernel but
couldn't remember it :)

I am more used to hid-recorder as it agregates everything in a more
compact way and you can then replay the traces with hid-replay.

Cheers,
Benjamin

>
> Thank you!
>
> >
> > Cheers,
> > Benjamin
> >
> > > > +
> > > > +             /* use hid-multitouch for T101HA touchpad */
> > > > +             if (intf->altsetting->desc.bInterfaceNumber == T101HA_TPAD_INTF)
> > > > +                     return -ENODEV;
> > > > +     }
> > > > +
> > > >       drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> > > >       if (drvdata == NULL) {
> > > >               hid_err(hdev, "Can't alloc Asus descriptor\n");
> > > > @@ -830,6 +840,8 @@ static const struct hid_device_id asus_devices[] = {
> > > >       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> > > >               USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
> > > >         QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
> > > > +     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> > > > +             USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD), QUIRK_T101HA_DOCK },
> > > >       { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
> > > >       { HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
> > > >       { HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index 4206428c0ba2..f1eee2778b70 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -184,6 +184,7 @@
> > > >  #define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD        0x17e0
> > > >  #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD       0x1807
> > > >  #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD       0x8502
> > > > +#define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD        0x183d
> > > >  #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD  0x184a
> > > >  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD   0x8585
> > > >  #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD   0x0101
> > > > --
> > > > 2.19.2
> > > >

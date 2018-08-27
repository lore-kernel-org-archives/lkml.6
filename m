Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFBB208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5XFsbXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFBB208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeH0X12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:27:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36503 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0X12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:27:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id c21-v6so122813lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wC5ePYAgfLOKGLVzOO7/GDB1HxkmhVt61ZHB8eyFgCE=;
        b=v5XFsbXzdR+ZcYOMI26/pskx3tAnhxaBmhescZ36EtWgpHtUPruk80UH8bsZXjH7lN
         hixQBAB92nMByxxhniAAeNJ1XrcY3vjU1HOHusBFM50PdiFXJ1WCSK9btdbKGXSSo37y
         vYc0Ayvz/gSao/SRiVSrNhjrck8LB+89WMc4re//rkIeeURAGRPvBhxdHOAoe9g0G9KJ
         zr1P2mXCphJ9OWpitIUlgcvsmcgip2Nalb3KqliysCnEXepbRxHkPkBegQY97hxgmRxl
         QbEmRSHM9q78+qgKSD4K8+pCfB3rzGGBZbSJ7772791INQQKE5aX26EUITKzMm44URWv
         ee5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wC5ePYAgfLOKGLVzOO7/GDB1HxkmhVt61ZHB8eyFgCE=;
        b=AsMoOs6IdnZukTYu8H2yvIftbx1N3GATvQC1sUHhcHJwQ8LiwgtZw4VWBXvxYj6wkK
         6NCuSkfyiuLG3OBlZ3NlvOzIT2UV0Q0INPnw1O286H8CKJJbE8lNx2vdSZAdoo9j9ptA
         5qTIv7JXp4O2On2myV+bDxXspCO1vPelc273Z1LjBAWd1fIT2YYpZefpZ0MFA2gYY0he
         yUEri4H7We546kD3fnbSgEMIYDCq82qpbD1rlT6OwJuGn44sDcK403YOtxmmlQL+TjL3
         047WTKTINPLVdjwBqs/y7bXeGrmSbIFO8PS5ALe29j+ssrVjtA1KSoolXj51qyTFtAvo
         GquA==
X-Gm-Message-State: APzg51Ck/zBGWiGHIXKGMZE89iOqA628eatiYk2azlGxMdip/Iq5+DV7
        DsM17qB2APkeka4/XyhXH7VqIlX4F1Ykg1zeCsngEQ==
X-Google-Smtp-Source: ANB0Vdb/uv4Lux2+GfzcSw/IC3RrZeGWOQELBFm7WloLKgQkDaN5l/cvwKldyarACwgJAtJk+yj5bKyW2XrKDkHqy/E=
X-Received: by 2002:a19:a5c2:: with SMTP id o185-v6mr9629986lfe.85.1535398766597;
 Mon, 27 Aug 2018 12:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180823164005.201582-1-seobrien@chromium.org> <CAO-hwJLegX7Uuw8WSErg8W7L0jXj7v2RGiABnrujLonHBYRrog@mail.gmail.com>
In-Reply-To: <CAO-hwJLegX7Uuw8WSErg8W7L0jXj7v2RGiABnrujLonHBYRrog@mail.gmail.com>
From:   "Sean O'Brien" <seobrien@google.com>
Date:   Mon, 27 Aug 2018 12:39:15 -0700
Message-ID: <CABBVx+CnSzemH5+o1XMq+aHfymBwh3QEm5mCV3TRTvL0mpxCKQ@mail.gmail.com>
Subject: Re: [PATCH] HID: add support for Apple Magic Keyboards
To:     benjamin.tissoires@redhat.com
Cc:     seobrien@chromium.org, jikos@kernel.org, dtor@chromium.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 5:19 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Sean,
>
> On Thu, Aug 23, 2018 at 6:40 PM Sean O'Brien <seobrien@chromium.org> wrote:
> >
> > USB device
> >         Vendor 05ac (Apple)
> >         Device 026c (Magic Keyboard with Numeric Keypad)
> >
> > Bluetooth devices
> >         Vendor 004c (Apple)
> >         Device 0267 (Magic Keyboard)
> >         Device 026c (Magic Keyboard with Numeric Keypad)
> >
> > Support already exists for the Magic Keyboard over USB connection.
> > This patch adds support for the Magic Keyboard over Bluetooth
> > connection, and for the Magic Keyboard with Numeric Keypad over
> > Bluetooth and USB connection.
> >
> > Signed-off-by: Sean O'Brien <seobrien@chromium.org>
> > ---
> >
> >  drivers/hid/hid-apple.c  | 9 ++++++++-
> >  drivers/hid/hid-ids.h    | 2 ++
> >  drivers/hid/hid-quirks.c | 3 +++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 25b7bd56ae11..1cb41992aaa1 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -335,7 +335,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >                 struct hid_field *field, struct hid_usage *usage,
> >                 unsigned long **bit, int *max)
> >  {
> > -       if (usage->hid == (HID_UP_CUSTOM | 0x0003)) {
> > +       if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
> > +                       usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
> >                 /* The fn key on Apple USB keyboards */
> >                 set_bit(EV_REP, hi->input->evbit);
> >                 hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
> > @@ -472,6 +473,12 @@ static const struct hid_device_id apple_devices[] = {
> >                 .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
> >                 .driver_data = APPLE_HAS_FN },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
> > +               .driver_data = APPLE_HAS_FN },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> > +               .driver_data = APPLE_HAS_FN },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> > +               .driver_data = APPLE_HAS_FN },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
> >                 .driver_data = APPLE_HAS_FN },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 79bdf0c7e351..5dbe3fb82690 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -88,6 +88,7 @@
> >  #define USB_DEVICE_ID_ANTON_TOUCH_PAD  0x3101
> >
> >  #define USB_VENDOR_ID_APPLE            0x05ac
> > +#define BT_VENDOR_ID_APPLE             0x004c
> >  #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE        0x0304
> >  #define USB_DEVICE_ID_APPLE_MAGICMOUSE 0x030d
> >  #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD      0x030e
> > @@ -157,6 +158,7 @@
> >  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
> >  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
> >  #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
> > +#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI   0x0290
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO    0x0291
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS    0x0292
> > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > index 249d49b6b16c..a3b3aecf8628 100644
> > --- a/drivers/hid/hid-quirks.c
> > +++ b/drivers/hid/hid-quirks.c
> > @@ -270,6 +270,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO) },
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
> > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
>
> Unless the device doesn't work without this hunk, please drop this
> from the submission. Since v4.16 this is not required anymore and is
> doomed to be removed.
>

I'll do that.  Thank you.

> Cheers,
> Benjamin
>
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
> >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
> >  #endif
> > --
> > 2.18.0.1017.ga543ac7ca45-goog
> >

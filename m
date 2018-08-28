Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A3BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4A6208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4A6208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeH1LAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:00:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34208 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeH1LAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:00:03 -0400
Received: by mail-qk0-f194.google.com with SMTP id d15-v6so353218qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 00:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjrZnQLv29ZlEU6RAj8VkcOw+PHZgbRFBH5JX+Xwn30=;
        b=KM/j6K6TOVJDrCHFr20O5mfH7UmlGz/JcxRNSNL3WYzHrlt+OxDU31NnMyfmZ9p6Gn
         YdT8F0L/nJ/wdcFNRYwgfUVuGF+rqX9wSGf6t4Bx3vkKZsNq4Ry4fwvUHL1VR/PRJ0uS
         iRKpgG4gpdQoOjQQbHKijfj2aTr3rD5tOiiiD1ataQjk6M49LJpwjOFEM+CK0CkjXiZT
         u4YatRURDwGuCLUOFTqU26iw1Khxq1X15yGJiHgl6rWs94rexX6QRo9oEASa5zOvJY1x
         eflJUVafmEcM71TxoJVqQtRFCDRe2QdrxHumUGctO0IJpPIntdLmbiy1mHfIjh70tuaY
         CcxA==
X-Gm-Message-State: APzg51D621ponp2uF2MJ92HS4uQ5kfmP9b/EvSaC2MfuC6Kf+M6oyf0h
        DvRUJyrymgCAqfYaEDkiuWc/aki1qDJcWY6sEjMIWg==
X-Google-Smtp-Source: ANB0Vdb/RYqGgLTvZM8ZYtWaFS4pg9hdGZFRoXxbgKjZZkDay+J+IvtGX2WExuVd5+ipqxtz3jAjY4Bl6nHv++qap/I=
X-Received: by 2002:a37:6888:: with SMTP id d130-v6mr274450qkc.192.1535440188263;
 Tue, 28 Aug 2018 00:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180827200215.172838-1-seobrien@chromium.org>
In-Reply-To: <20180827200215.172838-1-seobrien@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 28 Aug 2018 09:09:36 +0200
Message-ID: <CAO-hwJJRzdtOXxWrTC62M81jAD747Snvq9SkuC7YYAH0A4E36A@mail.gmail.com>
Subject: Re: [PATCH] [v2] HID: add support for Apple Magic Keyboards
To:     seobrien@chromium.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:02 PM Sean O'Brien <seobrien@chromium.org> wrote:
>
> USB device
>         Vendor 05ac (Apple)
>         Device 026c (Magic Keyboard with Numeric Keypad)
>
> Bluetooth devices
>         Vendor 004c (Apple)
>         Device 0267 (Magic Keyboard)
>         Device 026c (Magic Keyboard with Numeric Keypad)
>
> Support already exists for the Magic Keyboard over USB connection.
> Add support for the Magic Keyboard over Bluetooth connection, and for
> the Magic Keyboard with Numeric Keypad over Bluetooth and USB
> connection.
>
> Signed-off-by: Sean O'Brien <seobrien@chromium.org>
> ---

Looks good now.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

However, now that I read it, I believe the quirk APPLE_HAS_FN could be
autodetected or at least renamed to something better (or inverted to
not have 80% of the devices that need it). Anyway, that's for someone
who will want to do it, I am not requesting this to be changed.

Cheers,
Benjamin

>
>  drivers/hid/hid-apple.c | 9 ++++++++-
>  drivers/hid/hid-ids.h   | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 25b7bd56ae11..1cb41992aaa1 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -335,7 +335,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                 struct hid_field *field, struct hid_usage *usage,
>                 unsigned long **bit, int *max)
>  {
> -       if (usage->hid == (HID_UP_CUSTOM | 0x0003)) {
> +       if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
> +                       usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
>                 /* The fn key on Apple USB keyboards */
>                 set_bit(EV_REP, hi->input->evbit);
>                 hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
> @@ -472,6 +473,12 @@ static const struct hid_device_id apple_devices[] = {
>                 .driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
>                 .driver_data = APPLE_HAS_FN },
> +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
> +               .driver_data = APPLE_HAS_FN },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> +               .driver_data = APPLE_HAS_FN },
> +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
> +               .driver_data = APPLE_HAS_FN },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
>                 .driver_data = APPLE_HAS_FN },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 79bdf0c7e351..5dbe3fb82690 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -88,6 +88,7 @@
>  #define USB_DEVICE_ID_ANTON_TOUCH_PAD  0x3101
>
>  #define USB_VENDOR_ID_APPLE            0x05ac
> +#define BT_VENDOR_ID_APPLE             0x004c
>  #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE        0x0304
>  #define USB_DEVICE_ID_APPLE_MAGICMOUSE 0x030d
>  #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD      0x030e
> @@ -157,6 +158,7 @@
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
>  #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
> +#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI   0x0290
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO    0x0291
>  #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS    0x0292
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>

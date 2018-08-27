Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBF4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D914620858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeH0QGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:06:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41384 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeH0QGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:06:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id t39-v6so16884707qtc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJlteMXGTeT+AsYsw/xMb1iVkI0dINgLeuvsP8B/rQY=;
        b=cW1OxnpNKUKMFJucJnKE2uw8joVtJgkBvlYEnvMNybBzQ24idPfFKpPySRlhmFTeJj
         inCAxFeFydCq5h0PkOck4U7iEosSGJGd7LbXJ76PptCF+Rdm6YaM/rgSQt95Zw7bWhij
         tn3Cca0zU7zCeiYxSWbJIG2PggGWVn0CGmeEssP+KkK/l5ZokatC5312vN2BMTx7zTp1
         A+jCaEqPrTMwXpxfYXkMSUE3wHUT7h3cnN0S+0iHNHFStThSkcoa+nS6264xbra3d/ow
         UAu0L9HqbeFPero7csTHwvbkKFnX3ZXOYX64ZjCvI6zy7xN+F+hXxAnU0anOU+vF+rwI
         3GPg==
X-Gm-Message-State: APzg51DBZQnY5/nQM7rZwzWxDG9DczrdulrZNytuT/nO6k2DuUMmml78
        lHFpEvRiSf7lpE1Rfp7CEqu99ycnuiGqIqBXJzxP3Q==
X-Google-Smtp-Source: ANB0VdYRRt3GkppeRCedYiQAfpPtu9Tbmy4rgLzshd0LEgVDpEaxyWNHPIDWkCDhTMWKngC3kBqy3t7LfioAP0pdsTQ=
X-Received: by 2002:a0c:d067:: with SMTP id d36-v6mr13378408qvh.216.1535372376971;
 Mon, 27 Aug 2018 05:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180823164005.201582-1-seobrien@chromium.org>
In-Reply-To: <20180823164005.201582-1-seobrien@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 27 Aug 2018 14:19:25 +0200
Message-ID: <CAO-hwJLegX7Uuw8WSErg8W7L0jXj7v2RGiABnrujLonHBYRrog@mail.gmail.com>
Subject: Re: [PATCH] HID: add support for Apple Magic Keyboards
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

Hi Sean,

On Thu, Aug 23, 2018 at 6:40 PM Sean O'Brien <seobrien@chromium.org> wrote:
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
> This patch adds support for the Magic Keyboard over Bluetooth
> connection, and for the Magic Keyboard with Numeric Keypad over
> Bluetooth and USB connection.
>
> Signed-off-by: Sean O'Brien <seobrien@chromium.org>
> ---
>
>  drivers/hid/hid-apple.c  | 9 ++++++++-
>  drivers/hid/hid-ids.h    | 2 ++
>  drivers/hid/hid-quirks.c | 3 +++
>  3 files changed, 13 insertions(+), 1 deletion(-)
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
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 249d49b6b16c..a3b3aecf8628 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -270,6 +270,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO) },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
> +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },

Unless the device doesn't work without this hunk, please drop this
from the submission. Since v4.16 this is not required anymore and is
doomed to be removed.

Cheers,
Benjamin

>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
>  #endif
> --
> 2.18.0.1017.ga543ac7ca45-goog
>

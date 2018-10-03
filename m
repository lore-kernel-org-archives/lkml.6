Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCFD20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCFD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJCOZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:25:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39420 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeJCOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:25:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id w21-v6so3380098lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbKFOmhhG2wPDr/6GkxPPaWm1FM5Q60C4sKk2R/x1bA=;
        b=RtgZV7CrCNSDjzhrKMukRrj/BToN4NapuykpS71uMNfYAP5yDVLmX/RW4QBl9v6YpA
         /papXPRtWqjxyf2Uq7Uv/YjKFQmmo9+NEwKKZxrUokl4IjDiyWCKuoU2YgsjCE6xxgx3
         oHed715jSlfX4TQfCfL4Z00NXd+IvuhN01sUcXO2A52ELM04zq7I/F9NrJ/kzndjLKKP
         GkGCVZWfnpAENNyB6iYXvT6MhkkUcENKDtpShsNhQpHJ6Vzs39UmpYcE1DrcKBjoArYX
         J8AKI82SeLXuojP82EeHpznZlbEokWBW7CsspjsJNeydW4KOHLrhJnAG0TOTNaALhZ0j
         BSZw==
X-Gm-Message-State: ABuFfoiXD8w1cqdJJ60r/28sZQJpequi2XsStLaxOh82IF9rnn6jz6R0
        qCNu1hLkIUUBsVmVlLcJ2CWsrNpqQO0saC0D1Yv6dQ==
X-Google-Smtp-Source: ACcGV63j0pAii697qVZGaTMMovQPZElIsCBfzswk3M65FNRUMDrC+SO2AmJM1SwunvdM5neQ5asiLFOzB+uRHc5XChg=
X-Received: by 2002:a19:910c:: with SMTP id t12-v6mr178320lfd.98.1538552307456;
 Wed, 03 Oct 2018 00:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181002225337.7349-1-seobrien@chromium.org>
In-Reply-To: <20181002225337.7349-1-seobrien@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 3 Oct 2018 09:38:15 +0200
Message-ID: <CAO-hwJLco_8AK7P2n1zhdbEqh9MdwBrOjNi9raQVy7zB0B5=aw@mail.gmail.com>
Subject: Re: [PATCH] [v4] HID: add support for Apple Magic Trackpad 2
To:     seobrien@chromium.org
Cc:     marek.wyborski@emwesoft.com, lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jiri Kosina <jikos@kernel.org>, claudio@ponyfleisch.ch
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 12:53 AM Sean O'Brien <seobrien@chromium.org> wrote:
>
> USB device
>         Vendor 05ac (Apple)
>         Device 0265 (Magic Trackpad 2)
> Bluetooth device
>         Vendor 004c (Apple)
>         Device 0265 (Magic Trackpad 2)
>
> Add support for Apple Magic Trackpad 2 over USB and bluetooth, putting
> the device in multi-touch mode.
>
> Signed-off-by: Claudio Mettler <claudio@ponyfleisch.ch>
> Signed-off-by: Marek Wyborski <marek.wyborski@emwesoft.com>
> Signed-off-by: Sean O'Brien <seobrien@chromium.org>
> ---

Thanks for the quick respin.

This version is now good and looks like the rest of the code (I wish
we had a better handling than just parsing everything like we do here,
sigh).

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
>  drivers/hid/hid-ids.h        |   1 +
>  drivers/hid/hid-magicmouse.c | 142 ++++++++++++++++++++++++++++++++---
>  2 files changed, 132 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5146ee029db4..bb0cd212c7cc 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -92,6 +92,7 @@
>  #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE        0x0304
>  #define USB_DEVICE_ID_APPLE_MAGICMOUSE 0x030d
>  #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD      0x030e
> +#define USB_DEVICE_ID_APPLE_MAGICTRACKPAD2     0x0265
>  #define USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI      0x020e
>  #define USB_DEVICE_ID_APPLE_FOUNTAIN_ISO       0x020f
>  #define USB_DEVICE_ID_APPLE_GEYSER_ANSI        0x0214
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index b454c4386157..1d5ea678d268 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -54,6 +54,8 @@ module_param(report_undeciphered, bool, 0644);
>  MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
>
>  #define TRACKPAD_REPORT_ID 0x28
> +#define TRACKPAD2_USB_REPORT_ID 0x02
> +#define TRACKPAD2_BT_REPORT_ID 0x31
>  #define MOUSE_REPORT_ID    0x29
>  #define DOUBLE_REPORT_ID   0xf7
>  /* These definitions are not precise, but they're close enough.  (Bits
> @@ -91,6 +93,17 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
>  #define TRACKPAD_RES_Y \
>         ((TRACKPAD_MAX_Y - TRACKPAD_MIN_Y) / (TRACKPAD_DIMENSION_Y / 100))
>
> +#define TRACKPAD2_DIMENSION_X (float)16000
> +#define TRACKPAD2_MIN_X -3678
> +#define TRACKPAD2_MAX_X 3934
> +#define TRACKPAD2_RES_X \
> +       ((TRACKPAD2_MAX_X - TRACKPAD2_MIN_X) / (TRACKPAD2_DIMENSION_X / 100))
> +#define TRACKPAD2_DIMENSION_Y (float)11490
> +#define TRACKPAD2_MIN_Y -2478
> +#define TRACKPAD2_MAX_Y 2587
> +#define TRACKPAD2_RES_Y \
> +       ((TRACKPAD2_MAX_Y - TRACKPAD2_MIN_Y) / (TRACKPAD2_DIMENSION_Y / 100))
> +
>  /**
>   * struct magicmouse_sc - Tracks Magic Mouse-specific data.
>   * @input: Input device through which we report events.
> @@ -183,6 +196,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>  {
>         struct input_dev *input = msc->input;
>         int id, x, y, size, orientation, touch_major, touch_minor, state, down;
> +       int pressure = 0;
>
>         if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
>                 id = (tdata[6] << 2 | tdata[5] >> 6) & 0xf;
> @@ -194,6 +208,17 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>                 touch_minor = tdata[4];
>                 state = tdata[7] & TOUCH_STATE_MASK;
>                 down = state != TOUCH_STATE_NONE;
> +       } else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
> +               id = tdata[8] & 0xf;
> +               x = (tdata[1] << 27 | tdata[0] << 19) >> 19;
> +               y = -((tdata[3] << 30 | tdata[2] << 22 | tdata[1] << 14) >> 19);
> +               size = tdata[6];
> +               orientation = (tdata[8] >> 5) - 4;
> +               touch_major = tdata[4];
> +               touch_minor = tdata[5];
> +               pressure = tdata[7];
> +               state = tdata[3] & 0xC0;
> +               down = state == 0x80;
>         } else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
>                 id = (tdata[7] << 2 | tdata[6] >> 6) & 0xf;
>                 x = (tdata[1] << 27 | tdata[0] << 19) >> 19;
> @@ -215,7 +240,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>         /* If requested, emulate a scroll wheel by detecting small
>          * vertical touch motions.
>          */
> -       if (emulate_scroll_wheel) {
> +       if (emulate_scroll_wheel && (input->id.product !=
> +                       USB_DEVICE_ID_APPLE_MAGICTRACKPAD2)) {
>                 unsigned long now = jiffies;
>                 int step_x = msc->touches[id].scroll_x - x;
>                 int step_y = msc->touches[id].scroll_y - y;
> @@ -269,10 +295,14 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
>                 input_report_abs(input, ABS_MT_POSITION_X, x);
>                 input_report_abs(input, ABS_MT_POSITION_Y, y);
>
> +               if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2)
> +                       input_report_abs(input, ABS_MT_PRESSURE, pressure);
> +
>                 if (report_undeciphered) {
>                         if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE)
>                                 input_event(input, EV_MSC, MSC_RAW, tdata[7]);
> -                       else /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
> +                       else if (input->id.product !=
> +                                       USB_DEVICE_ID_APPLE_MAGICTRACKPAD2)
>                                 input_event(input, EV_MSC, MSC_RAW, tdata[8]);
>                 }
>         }
> @@ -287,6 +317,7 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>
>         switch (data[0]) {
>         case TRACKPAD_REPORT_ID:
> +       case TRACKPAD2_BT_REPORT_ID:
>                 /* Expect four bytes of prefix, and N*9 bytes of touch data. */
>                 if (size < 4 || ((size - 4) % 9) != 0)
>                         return 0;
> @@ -308,6 +339,22 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>                  * ts = data[1] >> 6 | data[2] << 2 | data[3] << 10;
>                  */
>                 break;
> +       case TRACKPAD2_USB_REPORT_ID:
> +               /* Expect twelve bytes of prefix and N*9 bytes of touch data. */
> +               if (size < 12 || ((size - 12) % 9) != 0)
> +                       return 0;
> +               npoints = (size - 12) / 9;
> +               if (npoints > 15) {
> +                       hid_warn(hdev, "invalid size value (%d) for TRACKPAD2_USB_REPORT_ID\n",
> +                                       size);
> +                       return 0;
> +               }
> +               msc->ntouches = 0;
> +               for (ii = 0; ii < npoints; ii++)
> +                       magicmouse_emit_touch(msc, ii, data + ii * 9 + 12);
> +
> +               clicks = data[1];
> +               break;
>         case MOUSE_REPORT_ID:
>                 /* Expect six bytes of prefix, and N*8 bytes of touch data. */
>                 if (size < 6 || ((size - 6) % 8) != 0)
> @@ -352,6 +399,9 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>                 magicmouse_emit_buttons(msc, clicks & 3);
>                 input_report_rel(input, REL_X, x);
>                 input_report_rel(input, REL_Y, y);
> +       } else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
> +               input_mt_sync_frame(input);
> +               input_report_key(input, BTN_MOUSE, clicks & 1);
>         } else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
>                 input_report_key(input, BTN_MOUSE, clicks & 1);
>                 input_mt_report_pointer_emulation(input, true);
> @@ -364,6 +414,7 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>  static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hdev)
>  {
>         int error;
> +       int mt_flags = 0;
>
>         __set_bit(EV_KEY, input->evbit);
>
> @@ -380,6 +431,22 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
>                         __set_bit(REL_WHEEL, input->relbit);
>                         __set_bit(REL_HWHEEL, input->relbit);
>                 }
> +       } else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
> +               /* setting the device name to ensure the same driver settings
> +                * get loaded, whether connected through bluetooth or USB
> +                */
> +               input->name = "Apple Inc. Magic Trackpad 2";
> +
> +               __clear_bit(EV_MSC, input->evbit);
> +               __clear_bit(BTN_0, input->keybit);
> +               __clear_bit(BTN_RIGHT, input->keybit);
> +               __clear_bit(BTN_MIDDLE, input->keybit);
> +               __set_bit(BTN_MOUSE, input->keybit);
> +               __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> +               __set_bit(BTN_TOOL_FINGER, input->keybit);
> +
> +               mt_flags = INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
> +                               INPUT_MT_TRACK;
>         } else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
>                 /* input->keybit is initialized with incorrect button info
>                  * for Magic Trackpad. There really is only one physical
> @@ -402,14 +469,13 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
>
>         __set_bit(EV_ABS, input->evbit);
>
> -       error = input_mt_init_slots(input, 16, 0);
> +       error = input_mt_init_slots(input, 16, mt_flags);
>         if (error)
>                 return error;
>         input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255 << 2,
>                              4, 0);
>         input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255 << 2,
>                              4, 0);
> -       input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
>
>         /* Note: Touch Y position from the device is inverted relative
>          * to how pointer motion is reported (and relative to how USB
> @@ -418,6 +484,7 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
>          * inverse of the reported Y.
>          */
>         if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
> +               input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
>                 input_set_abs_params(input, ABS_MT_POSITION_X,
>                                      MOUSE_MIN_X, MOUSE_MAX_X, 4, 0);
>                 input_set_abs_params(input, ABS_MT_POSITION_Y,
> @@ -427,7 +494,25 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
>                                   MOUSE_RES_X);
>                 input_abs_set_res(input, ABS_MT_POSITION_Y,
>                                   MOUSE_RES_Y);
> +       } else if (input->id.product ==  USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
> +               input_set_abs_params(input, ABS_MT_PRESSURE, 0, 253, 0, 0);
> +               input_set_abs_params(input, ABS_PRESSURE, 0, 253, 0, 0);
> +               input_set_abs_params(input, ABS_MT_ORIENTATION, -3, 4, 0, 0);
> +               input_set_abs_params(input, ABS_X, TRACKPAD2_MIN_X,
> +                                    TRACKPAD2_MAX_X, 0, 0);
> +               input_set_abs_params(input, ABS_Y, TRACKPAD2_MIN_Y,
> +                                    TRACKPAD2_MAX_Y, 0, 0);
> +               input_set_abs_params(input, ABS_MT_POSITION_X,
> +                                    TRACKPAD2_MIN_X, TRACKPAD2_MAX_X, 0, 0);
> +               input_set_abs_params(input, ABS_MT_POSITION_Y,
> +                                    TRACKPAD2_MIN_Y, TRACKPAD2_MAX_Y, 0, 0);
> +
> +               input_abs_set_res(input, ABS_X, TRACKPAD2_RES_X);
> +               input_abs_set_res(input, ABS_Y, TRACKPAD2_RES_Y);
> +               input_abs_set_res(input, ABS_MT_POSITION_X, TRACKPAD2_RES_X);
> +               input_abs_set_res(input, ABS_MT_POSITION_Y, TRACKPAD2_RES_Y);
>         } else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
> +               input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
>                 input_set_abs_params(input, ABS_X, TRACKPAD_MIN_X,
>                                      TRACKPAD_MAX_X, 4, 0);
>                 input_set_abs_params(input, ABS_Y, TRACKPAD_MIN_Y,
> @@ -447,7 +532,8 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
>
>         input_set_events_per_packet(input, 60);
>
> -       if (report_undeciphered) {
> +       if (report_undeciphered &&
> +           input->id.product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
>                 __set_bit(EV_MSC, input->evbit);
>                 __set_bit(MSC_RAW, input->mscbit);
>         }
> @@ -465,7 +551,8 @@ static int magicmouse_input_mapping(struct hid_device *hdev,
>                 msc->input = hi->input;
>
>         /* Magic Trackpad does not give relative data after switching to MT */
> -       if (hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD &&
> +       if ((hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD ||
> +            hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) &&
>             field->flags & HID_MAIN_ITEM_RELATIVE)
>                 return -1;
>
> @@ -494,11 +581,20 @@ static int magicmouse_input_configured(struct hid_device *hdev,
>  static int magicmouse_probe(struct hid_device *hdev,
>         const struct hid_device_id *id)
>  {
> -       const u8 feature[] = { 0xd7, 0x01 };
> +       const u8 *feature;
> +       const u8 feature_mt[] = { 0xD7, 0x01 };
> +       const u8 feature_mt_trackpad2_usb[] = { 0x02, 0x01 };
> +       const u8 feature_mt_trackpad2_bt[] = { 0xF1, 0x02, 0x01 };
>         u8 *buf;
>         struct magicmouse_sc *msc;
>         struct hid_report *report;
>         int ret;
> +       int feature_size;
> +
> +       if (id->vendor == USB_VENDOR_ID_APPLE &&
> +           id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
> +           hdev->type != HID_TYPE_USBMOUSE)
> +               return 0;
>
>         msc = devm_kzalloc(&hdev->dev, sizeof(*msc), GFP_KERNEL);
>         if (msc == NULL) {
> @@ -532,7 +628,14 @@ static int magicmouse_probe(struct hid_device *hdev,
>         if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE)
>                 report = hid_register_report(hdev, HID_INPUT_REPORT,
>                         MOUSE_REPORT_ID, 0);
> -       else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
> +       else if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
> +               if (id->vendor == BT_VENDOR_ID_APPLE)
> +                       report = hid_register_report(hdev, HID_INPUT_REPORT,
> +                               TRACKPAD2_BT_REPORT_ID, 0);
> +               else /* USB_VENDOR_ID_APPLE */
> +                       report = hid_register_report(hdev, HID_INPUT_REPORT,
> +                               TRACKPAD2_USB_REPORT_ID, 0);
> +       } else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
>                 report = hid_register_report(hdev, HID_INPUT_REPORT,
>                         TRACKPAD_REPORT_ID, 0);
>                 report = hid_register_report(hdev, HID_INPUT_REPORT,
> @@ -546,7 +649,20 @@ static int magicmouse_probe(struct hid_device *hdev,
>         }
>         report->size = 6;
>
> -       buf = kmemdup(feature, sizeof(feature), GFP_KERNEL);
> +       if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
> +               if (id->vendor == BT_VENDOR_ID_APPLE) {
> +                       feature_size = sizeof(feature_mt_trackpad2_bt);
> +                       feature = feature_mt_trackpad2_bt;
> +               } else { /* USB_VENDOR_ID_APPLE */
> +                       feature_size = sizeof(feature_mt_trackpad2_usb);
> +                       feature = feature_mt_trackpad2_usb;
> +               }
> +       } else {
> +               feature_size = sizeof(feature_mt);
> +               feature = feature_mt;
> +       }
> +
> +       buf = kmemdup(feature, feature_size, GFP_KERNEL);
>         if (!buf) {
>                 ret = -ENOMEM;
>                 goto err_stop_hw;
> @@ -560,10 +676,10 @@ static int magicmouse_probe(struct hid_device *hdev,
>          * but there seems to be no other way of switching the mode.
>          * Thus the super-ugly hacky success check below.
>          */
> -       ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(feature),
> +       ret = hid_hw_raw_request(hdev, buf[0], buf, feature_size,
>                                 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>         kfree(buf);
> -       if (ret != -EIO && ret != sizeof(feature)) {
> +       if (ret != -EIO && ret != feature_size) {
>                 hid_err(hdev, "unable to request touch data (%d)\n", ret);
>                 goto err_stop_hw;
>         }
> @@ -579,6 +695,10 @@ static const struct hid_device_id magic_mice[] = {
>                 USB_DEVICE_ID_APPLE_MAGICMOUSE), .driver_data = 0 },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>                 USB_DEVICE_ID_APPLE_MAGICTRACKPAD), .driver_data = 0 },
> +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
> +               USB_DEVICE_ID_APPLE_MAGICTRACKPAD2), .driver_data = 0 },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
> +               USB_DEVICE_ID_APPLE_MAGICTRACKPAD2), .driver_data = 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, magic_mice);
> --
> 2.19.0.605.g01d371f741-goog
>

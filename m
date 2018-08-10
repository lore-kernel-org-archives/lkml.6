Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E0D215B2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E0D215B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeHJMGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:06:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42927 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeHJMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:06:08 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so9580510qto.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QFW3MMWoCxCU6p/h+NghAF9nep3RwhT98qrJGZ2uTM=;
        b=mLaiMl/r4xPELWYMT3FBhIdpKgb1GtCJzwAOKTwohx4MnPkKqS9P/fkFs/pLPdjvzo
         RrWoWQfLWNnAmLru9ifn9scDyuZGIq/rliDBRJJh6Ggq7odvd+/gZecHJetPgfp7NmXO
         iefx/s7xXD+KTmPswFDlAxFyR7ZzajCr6VI354+9LA2rqYWzF0zLQh2wM1nWOxrK8c+u
         ScS6adVhZKEe/MXnJm3kRwVk1dIYhcb35/2Yyde0NpaWVT6RXKXCvYHI2eSk6OevO9EH
         DiJV3qkchuootYFKczt3/58xTgisNGSPbHjQE2KKzfervXRwxoHntfu0Bn2s1hfD7xWN
         gyDA==
X-Gm-Message-State: AOUpUlEmh5q7CWwZX11caqNaq/U2d2eYz1H2Zb5FZGQzJGnvz2ggOETf
        pcYS8mXo2VU0nmo5LoSWhgnqTirrjIVw/5Wh2MYm+w==
X-Google-Smtp-Source: AA+uWPxam4ZKG7+ug0gpQEjwlAnv5RgfDDePfF3Wf2eSPQIJ7uXBPSgad64uYBge5Rcy3M56t9RSrWxWEkLBF02aMys=
X-Received: by 2002:a0c:9843:: with SMTP id e3-v6mr5104560qvd.44.1533893822511;
 Fri, 10 Aug 2018 02:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
In-Reply-To: <20180810001714.14659-1-andrew.smirnov@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 10 Aug 2018 11:36:50 +0200
Message-ID: <CAO-hwJ+HOmVT5=D5h8Rv6Cuhi=S+tJu3vMKidjNB=_pGCK8jPw@mail.gmail.com>
Subject: Re: [PATCH] hid: microsoft: Add rumble support for Xbox One S controller
To:     andrew.smirnov@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        juha.kuikka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Aug 10, 2018 at 2:17 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add HID quirk driver for Xbox One S controller over bluetooth.
>
> This driver only adds support for rumble. Standard controller
> functionality is exposed by default HID driver.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/hid/Kconfig         |   8 ++
>  drivers/hid/hid-ids.h       |   1 +
>  drivers/hid/hid-microsoft.c | 142 ++++++++++++++++++++++++++++++++++--
>  drivers/hid/hid-quirks.c    |   1 +
>  4 files changed, 147 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a49a10437c40..b2e983cb32f0 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -589,6 +589,14 @@ config HID_MICROSOFT
>         ---help---
>         Support for Microsoft devices that are not fully compliant with HID standard.
>
> +config MICROSOFT_FF
> +       bool "Microsoft Xbox One S controller force feedback support"
> +       depends on HID_MICROSOFT
> +       select INPUT_FF_MEMLESS
> +       ---help---
> +       Say Y here if you have a Microsoft Xbox One S controller and want to enable
> +       force feedback support for it.
> +

Is there really a need to have a kernel that doesn't enable FF on
those particular devices?
It adds a lot of #ifdefs in the code and I would think users want it
enabled by default.

>  config HID_MONTEREY
>         tristate "Monterey Genius KB29E keyboard"
>         depends on HID
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c7981ddd8776..c8b4bc7fe053 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -798,6 +798,7 @@
>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
>  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
> +#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER 0x02fd
>
>  #define USB_VENDOR_ID_MOJO             0x8282
>  #define USB_DEVICE_ID_RETRO_ADAPTER    0x3201
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 96e7d3231d2f..e2bd31d54e62 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -29,10 +29,29 @@
>  #define MS_NOGET               0x10
>  #define MS_DUPLICATE_USAGES    0x20
>
> +struct ms_data {
> +       unsigned long quirks;
> +       struct hid_device *hdev;
> +       struct work_struct ff_worker;
> +       __u8 strong;
> +       __u8 weak;
> +       __u8 *output_report_dmabuf;
> +};
> +
> +struct xb1s_ff_report {
> +       __u8    report_id;
> +       __u8    enable;
> +       __u8    magnitude[4];
> +       __u8    duration_10ms;
> +       __u8    start_delay_10ms;
> +       __u8    loop_count;
> +};
> +
>  static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>                 unsigned int *rsize)
>  {
> -       unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
> +       struct ms_data *ms = hid_get_drvdata(hdev);
> +       unsigned long quirks = ms->quirks;
>
>         /*
>          * Microsoft Wireless Desktop Receiver (Model 1028) has
> @@ -134,7 +153,8 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                 struct hid_field *field, struct hid_usage *usage,
>                 unsigned long **bit, int *max)
>  {
> -       unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
> +       struct ms_data *ms = hid_get_drvdata(hdev);
> +       unsigned long quirks = ms->quirks;

Could you split the change of the quirks mechanism in its own patch.
This will make the whole code easier to review and spot errors if
there are.

>
>         if (quirks & MS_ERGONOMY) {
>                 int ret = ms_ergonomy_kb_quirk(hi, usage, bit, max);
> @@ -153,7 +173,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>                 struct hid_field *field, struct hid_usage *usage,
>                 unsigned long **bit, int *max)
>  {
> -       unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
> +       struct ms_data *ms = hid_get_drvdata(hdev);
> +       unsigned long quirks = ms->quirks;
>
>         if (quirks & MS_DUPLICATE_USAGES)
>                 clear_bit(usage->code, *bit);
> @@ -164,7 +185,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>  static int ms_event(struct hid_device *hdev, struct hid_field *field,
>                 struct hid_usage *usage, __s32 value)
>  {
> -       unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
> +       struct ms_data *ms = hid_get_drvdata(hdev);
> +       unsigned long quirks = ms->quirks;
>         struct input_dev *input;
>
>         if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
> @@ -219,12 +241,96 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
>         return 0;
>  }
>
> +#ifdef CONFIG_MICROSOFT_FF
> +
> +#define XB1S_FF_REPORT         3
> +#define ENABLE_WEAK            BIT(0)
> +#define ENABLE_STRONG          BIT(1)
> +#define MAGNITUDE_WEAK         3
> +#define MAGNITUDE_STRONG       2
> +
> +static void ms_ff_worker(struct work_struct *work)
> +{
> +       struct ms_data *ms = container_of(work, struct ms_data, ff_worker);
> +       struct hid_device *hdev = ms->hdev;
> +       struct xb1s_ff_report *r =
> +               (struct xb1s_ff_report *) ms->output_report_dmabuf;
> +       int ret;
> +
> +       memset(r, 0, sizeof(*r));
> +
> +       r->report_id = XB1S_FF_REPORT;
> +       r->enable = ENABLE_WEAK | ENABLE_STRONG;
> +       /*
> +        * Specifying maximum duration and maximum loop count should
> +        * cover maximum duration of a single effect: 65536 ms
> +        */
> +       r->duration_10ms = U8_MAX;
> +       r->loop_count = U8_MAX;
> +       r->magnitude[MAGNITUDE_STRONG] = ms->strong; /* left actuator */
> +       r->magnitude[MAGNITUDE_WEAK] = ms->weak;     /* right actuator */
> +
> +       ret = hid_hw_output_report(hdev, (__u8 *)r, sizeof(*r));
> +       if (ret)
> +               hid_warn(hdev, "failed to send FF report\n");
> +}
> +
> +static int ms_play_effect(struct input_dev *dev, void *data,
> +                         struct ff_effect *effect)
> +{
> +       struct hid_device *hid = input_get_drvdata(dev);
> +       struct ms_data *ms = hid_get_drvdata(hid);
> +
> +       if (effect->type != FF_RUMBLE)
> +               return 0;
> +
> +       /* Magnitude is 0..100 so scale the 16-bit input here */
> +       ms->strong = ((u32) effect->u.rumble.strong_magnitude * 100) / U16_MAX;
> +       ms->weak = ((u32) effect->u.rumble.weak_magnitude * 100) / U16_MAX;
> +
> +       schedule_work(&ms->ff_worker);
> +       return 0;
> +}
> +
> +static int ms_init_ff(struct hid_device *hdev, struct ms_data *ms)
> +{
> +       struct hid_input *hidinput = list_entry(hdev->inputs.next,
> +                                               struct hid_input, list);
> +       struct input_dev *input_dev = hidinput->input;
> +
> +       ms->hdev = hdev;
> +       INIT_WORK(&ms->ff_worker, ms_ff_worker);
> +
> +       ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
> +                                               sizeof(struct xb1s_ff_report),
> +                                               GFP_KERNEL);
> +       if (ms->output_report_dmabuf == NULL)
> +               return -ENOMEM;
> +
> +       input_set_capability(input_dev, EV_FF, FF_RUMBLE);
> +       return input_ff_create_memless(input_dev, NULL, ms_play_effect);
> +}
> +
> +#else
> +static int ms_init_ff(struct hid_device *hdev, struct ms_data *ms)
> +{
> +       return 0;
> +}
> +#endif
> +
>  static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>         unsigned long quirks = id->driver_data;
> +       struct ms_data *ms;
>         int ret;
>
> -       hid_set_drvdata(hdev, (void *)quirks);
> +       ms = devm_kzalloc(&hdev->dev, sizeof(*ms), GFP_KERNEL);
> +       if (ms == NULL)
> +               return -ENOMEM;
> +
> +       ms->quirks = quirks;
> +
> +       hid_set_drvdata(hdev, ms);
>
>         if (quirks & MS_NOGET)
>                 hdev->quirks |= HID_QUIRK_NOGET;
> @@ -242,11 +348,32 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 goto err_free;
>         }
>
> +       if (IS_ENABLED(CONFIG_MICROSOFT_FF) &&
> +           hdev->product == USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) {

nitpick:
I'd rather have this test (against the PID) in ms_init_ff. In the long
run, we might want to add more devices and it would be better to have
the test where it should be.
An even better solution would be to add a new MS_QUIRK_FF and test
this here (or in ms_init_ff()).

> +               ret = ms_init_ff(hdev, ms);
> +               if (ret) {
> +                       hid_err(hdev,
> +                               "could not initialize ff, continuing anyway");
> +               }
> +       }
> +
>         return 0;
>  err_free:
>         return ret;
>  }
>
> +static void ms_remove(struct hid_device *hdev)
> +{
> +       hid_hw_stop(hdev);
> +
> +       if (IS_ENABLED(CONFIG_MICROSOFT_FF) &&
> +           hdev->product == USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) {

A quirk would be better (see my previous comment)

> +               struct ms_data *ms = hid_get_drvdata(hdev);
> +
> +               cancel_work_sync(&ms->ff_worker);
> +       }
> +}
> +
>  static const struct hid_device_id ms_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV),
>                 .driver_data = MS_HIDINPUT },
> @@ -281,6 +408,10 @@ static const struct hid_device_id ms_devices[] = {
>
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
>                 .driver_data = MS_PRESENTER },
> +#ifdef CONFIG_MICROSOFT_FF
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
> +               .driver_data = 0 },
> +#endif

That seems fragile. Also even if we keep the Kconfig option, is there
any point at conditioning the handling of this device from
hid-microsoft?
If it works with or without the Kconfig, I'd just drop the #ifdef.

>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, ms_devices);
> @@ -293,6 +424,7 @@ static struct hid_driver ms_driver = {
>         .input_mapped = ms_input_mapped,
>         .event = ms_event,
>         .probe = ms_probe,
> +       .remove = ms_remove,
>  };
>  module_hid_driver(ms_driver);
>
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 249d49b6b16c..10fefd0ed43c 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -496,6 +496,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) },

You don't need to add your device to hid_have_special_driver since
v4.15 or v4.16. So please drop this :)

Cheers,
Benjamin

>  #endif
>  #if IS_ENABLED(CONFIG_HID_MONTEREY)
>         { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
> --
> 2.17.1
>

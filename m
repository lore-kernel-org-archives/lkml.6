Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E61C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2EF2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbeLQNYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:24:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46374 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbeLQNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:24:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so13930324qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOv5Io6KYEbf8p+mXxSQp+4uYFaT+3H5awjSceyRG6Q=;
        b=sreIH71RTDik1ihPepqCoQnIbfyO5yv6lDA+wPa4YhZycrEhSvLWnoC2aqoh3Zh+h2
         nC5hEpO9Z+5ZlN+A+rXI7cXyAXyd25VspB9M8rgno4xDVNfN5em0Uo5XabidbFcSLd1t
         Er/+dhJzVlJVrR2pjjN5hSv1f7O3RqEaXlWLSU+/Klny+HOne2oZL0LQ8gKQuve3zhn4
         SeYecQAgBY15eYqy0kHMZKL+vT2QMCnwJEgi9akkl9Hg+Km96u/K43BF9WyWhvP2ib9b
         6zzgC8YOteEd0lft0v3B9VA0jXJetfNxnaIVpAyfVrrvlDGfg9jKS7GGmig90q95slFZ
         vfVA==
X-Gm-Message-State: AA+aEWYPW94kUch1SmaNMNxyO8YI6PFXgpvBLVpUlyugaaK1zal+gbQ6
        rBSiSvGfv3g5+aeXwFoSoHL5H34w02kSU0sHvoGFCg==
X-Google-Smtp-Source: AFSGD/XTnsKbZaWpv0Yli+zb5W9+2r30aXlnZ3F9Rz5twLtXoTQNpGd7CmfgSwmqZd5hsDGoIazFWYgw653A2KzjNtE=
X-Received: by 2002:a0c:96c9:: with SMTP id b9mr12454644qvd.238.1545053041470;
 Mon, 17 Dec 2018 05:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20181216155319.GA17189@arks.localdomain>
In-Reply-To: <20181216155319.GA17189@arks.localdomain>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 17 Dec 2018 14:23:49 +0100
Message-ID: <CAO-hwJ+L_D98q5byOvYFiOxYgFEgJZ8s2xTe3Mb7R2UW8mhyOQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: asus: Add support for the ASUS T101HA keyboard dock
To:     kernelrocks@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, mbrugger@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 4:52 PM Aleix Roca Nonell <kernelrocks@gmail.com> wrote:
>
> The ASUS T101HA keyboard dock generates HID events using the ASUS vendor
> specific UsagePage 0xff31. In consequence, some multimedia keys such as
> brightness up and down are not working with hid-generic.
>
> This commit adds the T101HA dock into the supported device list of the
> hid-asus driver. It also prevents the dock's integrated touchpad to be
> bound with hid-asus given that it is already working fine with
> hid-multitouch.
>
> Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> ---
>
> Changes in v2:
> - use the report descriptor's application usage to identify the dock's
>   touchpad instead of the usb interface id

Thanks for the quick respin.

Pushed into 4.21/hid-asus.

Cheers,
Benjamin

>
> drivers/hid/hid-asus.c | 8 ++++++++
> drivers/hid/hid-ids.h  | 1 +
> 2 files changed, 9 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index ab8bd40a77ed..951bb17ae8b2 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -70,6 +70,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_T100_KEYBOARD            BIT(6)
>  #define QUIRK_T100CHI                  BIT(7)
>  #define QUIRK_G752_KEYBOARD            BIT(8)
> +#define QUIRK_T101HA_DOCK              BIT(9)
>
>  #define I2C_KEYBOARD_QUIRKS                    (QUIRK_FIX_NOTEBOOK_REPORT | \
>                                                  QUIRK_NO_INIT_REPORTS | \
> @@ -699,6 +700,11 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 return ret;
>         }
>
> +       /* use hid-multitouch for T101HA touchpad */
> +       if (id->driver_data & QUIRK_T101HA_DOCK &&
> +           hdev->collection->usage == HID_GD_MOUSE)
> +               return -ENODEV;
> +
>         ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>         if (ret) {
>                 hid_err(hdev, "Asus hw start failed: %d\n", ret);
> @@ -830,6 +836,8 @@ static const struct hid_device_id asus_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>                 USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
>           QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +               USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD), QUIRK_T101HA_DOCK },
>         { HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4206428c0ba2..f1eee2778b70 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -184,6 +184,7 @@
>  #define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD  0x17e0
>  #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD 0x1807
>  #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD 0x8502
> +#define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD  0x183d
>  #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD    0x184a
>  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD     0x8585
>  #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD     0x0101
> --
> 2.20.0
>

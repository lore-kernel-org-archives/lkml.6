Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F28020827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F28020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeKISah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:30:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34098 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKISah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:30:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so335250qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTL1h3GlRLENvMzfIDyp2J6S2JIS+lLHff9sHE3aPvY=;
        b=X887jwMuw6PxIC8Fg6U7T06rLwhxxw2weyNRLd3SfzzWXPiWfuSKq0xkrjVng9we34
         sS127YaSXr6J9krLnqNV1t1E+uKJbcTzty5ovg919fky+odOKFHMuoK8Nka3lHmsblRx
         MwO6FQbg5wiDxhMWpKbEffNNbAlh5lP46tJQzZjs66vylrJHkzWaYpq380dxrsrO6KZE
         4TY3tdUxR7nfLx6ORy7EshbZ/Y8rS2flW7KxTSXn+aa0agSUztsnhWe+9GMaxuiLr32n
         w1423V/4XbJlpzb0oBt+EEGXamokr04bVI/59vxe+BLYcBYmLia9lGFqvu4DZSJth4XX
         i7Vw==
X-Gm-Message-State: AGRZ1gIoP/pWyj5MWH2j6wog416rGu55swB5lmEKrr0sPDlvyBRPzaQf
        tSjkeANPnxe2q20s9ZPhLay+7WvzI5pWnZHcnnNr+Q==
X-Google-Smtp-Source: AJdET5dmkLvqFpehV92hQfCL3trlr+Ge61nN6UK0cA/MWyA2ihSc8jtGPqCQ+pDSL5qWSOxN7tehYKJ+7UOWdbhky9k=
X-Received: by 2002:ac8:2f98:: with SMTP id l24mr7547693qta.83.1541753462457;
 Fri, 09 Nov 2018 00:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20181108235921.62193-1-bleung@chromium.org>
In-Reply-To: <20181108235921.62193-1-bleung@chromium.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 9 Nov 2018 09:50:50 +0100
Message-ID: <CAO-hwJ+FpX6evn-6J1TU6RmXq-3OhGGB21Qb4LdfNNcRuYkQEQ@mail.gmail.com>
Subject: Re: [PATCH] HID: input: Ignore battery reported by Symbol DS4308
To:     bleung@chromium.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 12:59 AM Benson Leung <bleung@chromium.org> wrote:
>
> The Motorola/Zebra Symbol DS4308-HD is a handheld USB barcode scanner
> which does not have a battery, but reports one anyway that always has
> capacity 2.
>
> Let's apply the IGNORE quirk to prevent it from being treated like a
> power supply so that userspaces don't get confused that this
> accessory is almost out of power and warn the user that they need to charge
> their wired barcode scanner.
>
> Reported here: https://bugs.chromium.org/p/chromium/issues/detail?id=804720
>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-ids.h   | 1 +
>  drivers/hid/hid-input.c | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c0d668944dbe..07f6348b9f86 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1043,6 +1043,7 @@
>  #define USB_VENDOR_ID_SYMBOL           0x05e0
>  #define USB_DEVICE_ID_SYMBOL_SCANNER_1 0x0800
>  #define USB_DEVICE_ID_SYMBOL_SCANNER_2 0x1300
> +#define USB_DEVICE_ID_SYMBOL_SCANNER_3 0x1200
>
>  #define USB_VENDOR_ID_SYNAPTICS                0x06cb
>  #define USB_DEVICE_ID_SYNAPTICS_TP     0x0001
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index a2f74e6adc70..44ea8e7c71a9 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -325,6 +325,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
>                 USB_DEVICE_ID_ELECOM_BM084),
>           HID_BATTERY_QUIRK_IGNORE },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
> +               USB_DEVICE_ID_SYMBOL_SCANNER_3),
> +         HID_BATTERY_QUIRK_IGNORE },
>         {}
>  };
>
> --
> 2.19.1.930.g4563a0d9d0-goog
>

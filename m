Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7590921773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLockwgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeLTIqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:46:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37001 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeLTIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:46:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id g125so506125qke.4;
        Thu, 20 Dec 2018 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=EOwgCUvZ74kmHVV7W4HoF6+v84HqgH+3RyqhHyrdvcg=;
        b=KLockwgg0k11EZ++bTLxYEUkSjGe3ossmToCnGYIVGz+jFAjgeSZwrh4HkIkBrEnMS
         cIQQwd8J9XC8OJpd7mdBZv3uqB/tJMrCjEB2AV5O2UwpbtFTtMc4PzdVDjNQnITztAEW
         FC9NjJWUpP/FS4Nhmy9Xdundv9YRCv6Y8CrTqzF3HVJcg8d98AeCYp74k3RYOW1CspfO
         0P2YtfpoNx1kzcDOoZmPnNRSAp3OiQTvwB0pJn+lVorTDxCMJHtyALqoqS2zKe6+bSU6
         kmNp1K33gSiFA8es0O3CAgciUeaQCga8y3J0SDXO6yYxOHt2kCLD84QsYhbBhHpNK2s5
         /Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EOwgCUvZ74kmHVV7W4HoF6+v84HqgH+3RyqhHyrdvcg=;
        b=fLBRqHmxRGQkjZTYd/fiQErOyESQ/zNnRk0wufDw8eAi7EQoPniMqNkefBEBcmuSpQ
         BKjM0VRWSNdkYY89kNW00TmVnhcCUivu7qGeqDB4asvDliMHiK5ldDfukycbPDnmVop7
         Xf9QSXwAkylxq1YSmZi3ovuZiPBnwywXUnfuOb89y77pLl3x7a5RmokoRANJ7Mp6NO1t
         HQPZyNCYnYNI6x4Zq93DUCrGkuV5eWdzFxoaRS3HdTLQlVv4TDxpE3Dc/2kiRw7nBcsg
         RKhLNEbz9MIbUP7qVeSZTKv4Xrek0Ek32rxytzThXA18wS7YHjUMao5F4cURBro6ltB3
         cudw==
X-Gm-Message-State: AA+aEWbw6zeIM/v3QRQEad5UxAQG7sLOqZWkiVaBKZyblgqlZ7DCdTCu
        NvxjjY/YLnAfI21YGeo+ISGKBW+B+3EGhK7hMAA=
X-Google-Smtp-Source: AFSGD/UdTKm/b7AXjKKoW0pwH6lR1CZD2/dc9enzIpw8qrvY5Nloaq7Tf4zisxqlQAwB75VOoqG+HepV4O8mURh35U4=
X-Received: by 2002:a37:bd5:: with SMTP id 204mr22232345qkl.242.1545295579755;
 Thu, 20 Dec 2018 00:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181121235020.29461-1-rajatja@google.com>
 <20181121235020.29461-5-rajatja@google.com>
In-Reply-To: <20181121235020.29461-5-rajatja@google.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Thu, 20 Dec 2018 00:46:08 -0800
Message-ID: <CAA93t1qvPeDDnQ4294kZpfwEbvDMJdx30=aY1SBdx2vVyvzW0g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] Bluetooth: btusb: Use the hw_reset method to allow
 resetting the BT chip
To:     Rajat Jain <rajatja@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 3:50 PM Rajat Jain <rajatja@google.com> wrote:
>
> If the platform provides it, use the reset gpio to reset the BT
> chip (requested by the HCI core if needed). This has been found helpful
> on some of Intel bluetooth controllers where the firmware gets stuck and
> the only way out is a hard reset pin provided by the platform.

Hi Folks,

I was wondering if you got a change to look at this patchset, and if
there is any feedback.

Thanks,

Rajat


>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: Better error handling for gpiod_get_optional()
> v2: Handle the EPROBE_DEFER case.
>
>  drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e8e148480c91..e7631f770fae 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -29,6 +29,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/suspend.h>
> +#include <linux/gpio/consumer.h>
>  #include <asm/unaligned.h>
>
>  #include <net/bluetooth/bluetooth.h>
> @@ -475,6 +476,8 @@ struct btusb_data {
>         struct usb_endpoint_descriptor *diag_tx_ep;
>         struct usb_endpoint_descriptor *diag_rx_ep;
>
> +       struct gpio_desc *reset_gpio;
> +
>         __u8 cmdreq_type;
>         __u8 cmdreq;
>
> @@ -490,6 +493,26 @@ struct btusb_data {
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>  };
>
> +
> +static void btusb_hw_reset(struct hci_dev *hdev)
> +{
> +       struct btusb_data *data = hci_get_drvdata(hdev);
> +       struct gpio_desc *reset_gpio = data->reset_gpio;
> +
> +       /*
> +        * Toggle the hard reset line if the platform provides one. The reset
> +        * is going to yank the device off the USB and then replug. So doing
> +        * once is enough. The cleanup is handled correctly on the way out
> +        * (standard USB disconnect), and the new device is detected cleanly
> +        * and bound to the driver again like it should be.
> +        */
> +       bt_dev_dbg(hdev, "%s: Initiating HW reset via gpio", __func__);
> +       clear_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
> +       gpiod_set_value(reset_gpio, 1);
> +       mdelay(100);
> +       gpiod_set_value(reset_gpio, 0);
> +}
> +
>  static inline void btusb_free_frags(struct btusb_data *data)
>  {
>         unsigned long flags;
> @@ -2917,6 +2940,7 @@ static int btusb_probe(struct usb_interface *intf,
>                        const struct usb_device_id *id)
>  {
>         struct usb_endpoint_descriptor *ep_desc;
> +       struct gpio_desc *reset_gpio;
>         struct btusb_data *data;
>         struct hci_dev *hdev;
>         unsigned ifnum_base;
> @@ -3030,6 +3054,16 @@ static int btusb_probe(struct usb_interface *intf,
>
>         SET_HCIDEV_DEV(hdev, &intf->dev);
>
> +       reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
> +                                       GPIOD_OUT_LOW);
> +       if (IS_ERR(reset_gpio)) {
> +               err = PTR_ERR(reset_gpio);
> +               goto out_free_dev;
> +       } else if (reset_gpio) {
> +               data->reset_gpio = reset_gpio;
> +               hdev->hw_reset = btusb_hw_reset;
> +       }
> +
>         hdev->open   = btusb_open;
>         hdev->close  = btusb_close;
>         hdev->flush  = btusb_flush;
> @@ -3085,6 +3119,7 @@ static int btusb_probe(struct usb_interface *intf,
>                 set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
>                 set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>                 set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> +               set_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
>
>                 if (id->driver_info & BTUSB_INTEL) {
>                         hdev->setup = btusb_setup_intel;
> @@ -3225,6 +3260,8 @@ static int btusb_probe(struct usb_interface *intf,
>         return 0;
>
>  out_free_dev:
> +       if (data->reset_gpio)
> +               gpiod_put(data->reset_gpio);
>         hci_free_dev(hdev);
>         return err;
>  }
> @@ -3268,6 +3305,9 @@ static void btusb_disconnect(struct usb_interface *intf)
>         if (data->oob_wake_irq)
>                 device_init_wakeup(&data->udev->dev, false);
>
> +       if (data->reset_gpio)
> +               gpiod_put(data->reset_gpio);
> +
>         hci_free_dev(hdev);
>  }
>
> --
> 2.19.1.1215.g8438c0b245-goog
>

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5324C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754F720866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e07Qqxzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfAVWhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:37:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36105 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfAVWhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:37:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so145107lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RKo0OskvtIxiyLVJM2Q0EcH/DmpGbO82wrangcGhXOk=;
        b=e07QqxzxmghZ2JT5gkMYCvtcCg80c5+dYvc2Oa0dSSMtxn3rg0SUw2Q0V9kQNJMR+D
         sxKmzwLN8/WaH9hnBUKRQNUMVj+QW+xiJBo2wGQZtLzJuYUaZcpsZb1JqiICW6dyDscy
         F0OxsVG6Qp5wmx3eZ8k2l/Zl2xjd3O3MHgPI7xwONPQfVIwHBkueSwVh+di3kTM55p0d
         Vv0hMDV4vkZ7FWnC1M/GC/sKRnbNziw84f+bWrV9/4SWyET/sV7qZZlZFU9fk/86K5Lm
         6UjpehBQpRE2VF4GUEDdn6FKWW3i/kUHf5UNIR5ntk9H8BpqACIWpTevQ+uVUkJ2fuTX
         EbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RKo0OskvtIxiyLVJM2Q0EcH/DmpGbO82wrangcGhXOk=;
        b=BggjQghJLqX9xtyzZqCrfuZKvRrUbSFq8ufKwTZBw69GmgRBEYeMDe+NBXioQh9m9m
         oU1kffQULOxRjTULyW1V5kirWlpU5qMEvF1sp2sdb85oJ+9sqRr922+k+R+HHHuqMIbK
         wzjeKLqma7EZ4tAxc4Sso8FImih0NGq+b1Irn3O8rMRyN6O2CSvc1FAOktzdZhvG2ZfM
         JfJ5E35epLRp6N4A2V7yklCZxUO1QY1g9rLepjpvCtKccLEdKjV7b7GoRR6h+gCjkiy4
         vMzaARtk+1dydDGqui1sCPvgyCcQUTW/CeJOVRFhlESUkkITfJxbIZ1xFa8CM1of1Dz+
         SvdA==
X-Gm-Message-State: AJcUukcnQ1z3HPTmfvc14YGMqmzzKhXzMX9Tm042/0l/ELpje0/mOaC0
        yQ0k3eCz3S4ok1sbMZWf4D0d2eX8kvxxQ9G839sIOQ==
X-Google-Smtp-Source: ALg8bN6WZsjfbnMhAfjRinNwUOz2CzUrd7oufEXc7ViRkm4BTRBKMsGFPzIyeFP4TjPLC+Umpds+F1C7rdCLQe0C+zk=
X-Received: by 2002:a19:2906:: with SMTP id p6mr21489163lfp.17.1548196630422;
 Tue, 22 Jan 2019 14:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
 <20190118223407.64818-5-rajatja@google.com> <710EDC24-B0F2-4FDB-9C30-F78CDF74C0E5@holtmann.org>
In-Reply-To: <710EDC24-B0F2-4FDB-9C30-F78CDF74C0E5@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Jan 2019 14:36:33 -0800
Message-ID: <CACK8Z6HNNAUfodirhWtvk5rvrVa_s0YYnMDVD8UrFk2XDeyahw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] Bluetooth: btusb: Use the hw_reset method to allow
 resetting the BT chip
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        chethan.tumkur.narayan@intel.com,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:51 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Rajat,
>
> > If the platform provides it, use the reset gpio to reset the BT
> > chip (requested by the HCI core if needed). This has been found helpful
> > on some of Intel bluetooth controllers where the firmware gets stuck an=
d
> > the only way out is a hard reset pin provided by the platform.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: Use data->flags instead of clearing the quirk in btusb_hw_reset()
> > v3: Better error handling for gpiod_get_optional()
> > v2: Handle the EPROBE_DEFER case.
> >
> > drivers/bluetooth/btusb.c | 45 +++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 45 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 59869643cc29..7cf1e4f749e9 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -29,6 +29,7 @@
> > #include <linux/of_device.h>
> > #include <linux/of_irq.h>
> > #include <linux/suspend.h>
> > +#include <linux/gpio/consumer.h>
> > #include <asm/unaligned.h>
> >
> > #include <net/bluetooth/bluetooth.h>
> > @@ -439,6 +440,7 @@ static const struct dmi_system_id btusb_needs_reset=
_resume_table[] =3D {
> > #define BTUSB_BOOTING         9
> > #define BTUSB_DIAG_RUNNING    10
> > #define BTUSB_OOB_WAKE_ENABLED        11
> > +#define BTUSB_HW_RESET_DONE  12
>
> I think you mean BTUSB_HW_RESET_ACTIVE or BTUSB_HW_RESET_IN_PROGRESS.

Sure, will do.

>
> >
> > struct btusb_data {
> >       struct hci_dev       *hdev;
> > @@ -476,6 +478,8 @@ struct btusb_data {
> >       struct usb_endpoint_descriptor *diag_tx_ep;
> >       struct usb_endpoint_descriptor *diag_rx_ep;
> >
> > +     struct gpio_desc *reset_gpio;
> > +
> >       __u8 cmdreq_type;
> >       __u8 cmdreq;
> >
> > @@ -491,6 +495,30 @@ struct btusb_data {
> >       int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> > };
> >
> > +
> > +static void btusb_hw_reset(struct hci_dev *hdev)
> > +{
> > +     struct btusb_data *data =3D hci_get_drvdata(hdev);
> > +     struct gpio_desc *reset_gpio =3D data->reset_gpio;
> > +
> > +     /*
> > +      * Toggle the hard reset line if the platform provides one. The r=
eset
> > +      * is going to yank the device off the USB and then replug. So do=
ing
> > +      * once is enough. The cleanup is handled correctly on the way ou=
t
> > +      * (standard USB disconnect), and the new device is detected clea=
nly
> > +      * and bound to the driver again like it should be.
> > +      */
> > +     if (test_and_set_bit(BTUSB_HW_RESET_DONE, &data->flags)) {
> > +             bt_dev_warn(hdev, "last reset failed? Not resetting again=
\n");
> > +             return;
> > +     }
> > +
> > +     bt_dev_dbg(hdev, "Initiating HW reset via gpio\n=E2=80=9D);
>
> The bt_dev_ functions don=E2=80=99t need the \n at the end.

Sure, will do.

>
> > +     gpiod_set_value(reset_gpio, 1);
> > +     mdelay(100);
> > +     gpiod_set_value(reset_gpio, 0);
> > +}
> > +
> > static inline void btusb_free_frags(struct btusb_data *data)
> > {
> >       unsigned long flags;
> > @@ -2915,6 +2943,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                      const struct usb_device_id *id)
> > {
> >       struct usb_endpoint_descriptor *ep_desc;
> > +     struct gpio_desc *reset_gpio;
> >       struct btusb_data *data;
> >       struct hci_dev *hdev;
> >       unsigned ifnum_base;
> > @@ -3028,6 +3057,16 @@ static int btusb_probe(struct usb_interface *int=
f,
> >
> >       SET_HCIDEV_DEV(hdev, &intf->dev);
> >
> > +     reset_gpio =3D gpiod_get_optional(&data->udev->dev, "reset",
> > +                                     GPIOD_OUT_LOW);
> > +     if (IS_ERR(reset_gpio)) {
> > +             err =3D PTR_ERR(reset_gpio);
> > +             goto out_free_dev;
> > +     } else if (reset_gpio) {
> > +             data->reset_gpio =3D reset_gpio;
> > +             hdev->hw_reset =3D btusb_hw_reset;
> > +     }
> > +
> >       hdev->open   =3D btusb_open;
> >       hdev->close  =3D btusb_close;
> >       hdev->flush  =3D btusb_flush;
> > @@ -3083,6 +3122,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
;
> >               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > +             set_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
> >
> >               if (id->driver_info & BTUSB_INTEL) {
> >                       hdev->setup =3D btusb_setup_intel;
> > @@ -3223,6 +3263,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >       return 0;
> >
> > out_free_dev:
> > +     if (data->reset_gpio)
> > +             gpiod_put(data->reset_gpio);
> >       hci_free_dev(hdev);
> >       return err;
> > }
> > @@ -3266,6 +3308,9 @@ static void btusb_disconnect(struct usb_interface=
 *intf)
> >       if (data->oob_wake_irq)
> >               device_init_wakeup(&data->udev->dev, false);
> >
> > +     if (data->reset_gpio)
> > +             gpiod_put(data->reset_gpio);
> > +
> >       hci_free_dev(hdev);
> > }
>
> Regards
>
> Marcel
>

Thanks,

Rajat

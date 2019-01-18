Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DF4C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC8D20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mT7wLWq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfARUwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:52:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41410 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfARUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:52:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so11447920lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d55kv1Odtp4wUVXwmNpwnomEyVkO6+qn4xgL1ctrvlE=;
        b=mT7wLWq+OspjuepeD9b5H8I/yhIMHHSjXy16IdNJYxfURPj67q7P61Iv8gILMgjo7u
         IhnfcsusSO46GMzdjxdvx69W1Q2qDZJ9Am58wqkWBbUSZcygFvaXoLMFKbpFDANMyqXl
         zTYKjTdhv0Fp/rJ3Wmfr/WQakT3wDkQlE3vXZnF89PQ0gEbsENt9iOzGBCw0DU7tCNFw
         3hw6RSiqyi0c0xIwJoQWmNgYh1ya+ewfrBahKUkLDBTfKVKy/FWWSvdSsheXM2P87TVy
         K118ebZW5hpNonFaQAr8W8GIU7ipNZxSpDP9O5U8VahOumzpPMHW47i+Rer5oHk6BY/R
         lquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d55kv1Odtp4wUVXwmNpwnomEyVkO6+qn4xgL1ctrvlE=;
        b=q2CEJkyQ+zey6I+/RfpjtRR+icaxzP7rGTxbe3CgOSqfmdqvb1m+EC83Q2KFEFFT9E
         ykuGNEoV/Mv0QokivUFTGZij467cXuSCFG2kdGgf1cJuC96MSu+RcWlZjovTiKPePXzH
         9MAj39hjSVnUZ5Z6ARVzOtveInuQgOapmevaoaS14GZOLzO+lQyzE8gLIIfH9nqQm/Y8
         07LSp5Nw0z2dWVaPLRLNVhg7Yr1UbUiGjgKZD814tKt5EYgNyDYPxuP3LoOKTYvrLduh
         8tk8al4gEXBBFiDm8XGaBQ19XeDTjaLyIRAKlOEr15VqMq4OeEVPyNZwUVfVTRYREjWc
         BmWA==
X-Gm-Message-State: AJcUukc8tf3plT89MVznT7Jd7I/p4wOrh9xWwkvoXPeR2+FzTEdRlqb9
        KuPCRueUqYpNSiI+o5bnRF0iKEZi/xvWc4SPSvRU0g==
X-Google-Smtp-Source: ALg8bN4OrTiIvnstWDLlTKb2DnhvR+1yikkcy+nUey94Ld7W1AG/noZkT94PZ1f7pQ8sVNLJ53r/exzoSBKNrluH9dY=
X-Received: by 2002:a19:c995:: with SMTP id z143mr12162960lff.79.1547844726265;
 Fri, 18 Jan 2019 12:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181121235020.29461-1-rajatja@google.com>
 <20181121235020.29461-5-rajatja@google.com> <BE2BC4DD-B10C-4ED8-8770-DE042478A152@holtmann.org>
In-Reply-To: <BE2BC4DD-B10C-4ED8-8770-DE042478A152@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 18 Jan 2019 12:51:29 -0800
Message-ID: <CACK8Z6GnpbpsL9J28-qd4fmjnro5yWoAZe9U7YDM1LGxhFn9Bg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] Bluetooth: btusb: Use the hw_reset method to allow
 resetting the BT chip
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Thanks for your review.

On Fri, Jan 18, 2019 at 3:04 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
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
> > v3: Better error handling for gpiod_get_optional()
> > v2: Handle the EPROBE_DEFER case.
> >
> > drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index e8e148480c91..e7631f770fae 100644
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
> > @@ -475,6 +476,8 @@ struct btusb_data {
> >       struct usb_endpoint_descriptor *diag_tx_ep;
> >       struct usb_endpoint_descriptor *diag_rx_ep;
> >
> > +     struct gpio_desc *reset_gpio;
> > +
> >       __u8 cmdreq_type;
> >       __u8 cmdreq;
> >
> > @@ -490,6 +493,26 @@ struct btusb_data {
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
> > +     bt_dev_dbg(hdev, "%s: Initiating HW reset via gpio", __func__);
>
> No __func__ here. That bt_dev_dbg does all of that via dynamic debug alre=
ady.

Will fix.

>
> > +     clear_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
> > +     gpiod_set_value(reset_gpio, 1);
> > +     mdelay(100);
> > +     gpiod_set_value(reset_gpio, 0);
> > +}
> > +
> > static inline void btusb_free_frags(struct btusb_data *data)
> > {
> >       unsigned long flags;
> > @@ -2917,6 +2940,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                      const struct usb_device_id *id)
> > {
> >       struct usb_endpoint_descriptor *ep_desc;
> > +     struct gpio_desc *reset_gpio;
> >       struct btusb_data *data;
> >       struct hci_dev *hdev;
> >       unsigned ifnum_base;
> > @@ -3030,6 +3054,16 @@ static int btusb_probe(struct usb_interface *int=
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
>
> How do we ensure that this is the right =E2=80=9Creset=E2=80=9D line. And=
 it also needs to be bound to some hardware unless
> we can guarantee that this is always the same.

The BIOS / ACPI ensures that. The kernel driver just uses the ACPI
provided reset line.

>
> >       hdev->open   =3D btusb_open;
> >       hdev->close  =3D btusb_close;
> >       hdev->flush  =3D btusb_flush;
> > @@ -3085,6 +3119,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
;
> >               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > +             set_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
>
> You are not messing with the quirks here please. Clearing quirks is crazy=
. Use the data->flags since this should be all btusb.c specific.

Do I understand it right that you do not want me to clear the quirks
in btusb_hw_reset() and use data->flags instead? Sure, I will do that.
But I'm not sure if that's all you meant, because you commented on
btusb_probe() code where I'm setting the quirk (not clearing it) so
that the hci core can call the hw_reset() callback on timeout.

Thanks,

Rajat
>
> >
> >               if (id->driver_info & BTUSB_INTEL) {
> >                       hdev->setup =3D btusb_setup_intel;
> > @@ -3225,6 +3260,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >       return 0;
> >
> > out_free_dev:
> > +     if (data->reset_gpio)
> > +             gpiod_put(data->reset_gpio);
> >       hci_free_dev(hdev);
> >       return err;
> > }
> > @@ -3268,6 +3305,9 @@ static void btusb_disconnect(struct usb_interface=
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

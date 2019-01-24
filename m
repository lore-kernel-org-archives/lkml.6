Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A7C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FE921855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qm9Oxp+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfAXUGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:06:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46307 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbfAXUGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:06:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so5225217lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I44R5by7utG/5Cuuk2f4UjloCvOrI5Cx4uHif7F31LM=;
        b=qm9Oxp+YgeCHc1SPFddkkVXbLPcQA58VtGcIQX69gDDtCze6TffAljuOoLBpIWn39m
         L+vDe15nPgYpyUBDmzofGFpEfHWmhIfjvi/N+qzmFEbcwWkXPtOC2AKKrviBu6TIRxhs
         8kikYHtFba+h+efHg1qZHwQR1qEOYEDxnI1QrqEoLv4Fyx7wgi9ENX9QcoY1+XXPAoNc
         fakQo59z59q6hNznEDPQvlFSn7iB7KIhQlYEezhQ9LV4m7ozdXXe27w6WhHq7tpi3KJK
         zU9Wwrt7jWH+v1q9uvH3pT7XGqVMSpzh4uor0Aqp43z7PYFGIJ2SWxF2pYC18dgaciCi
         c+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I44R5by7utG/5Cuuk2f4UjloCvOrI5Cx4uHif7F31LM=;
        b=ChNgeCADJqrhOBTe2U4RxHOp2vJGdYa2DcUQ1Dztcc2OaAdzKaZmYpZawAialG0QVV
         r4ppecL6QMp+mz+Z+wCKeD3/7OoGHTbXbObPqcckKKfyFNXoc/ecahCZov3Y8kmw35xq
         8Z9VVsx7l7BL6myBTI5lUF1fEXg1h8sYhHsF5MdpTBEMcJIbJ0wV8O/umSBrn0/EvXz8
         7x8fM6oZplJck/RbHQpUe2xZ0WdJ4iH/RjXZo9oFfcKfStl0I3JbZ05lyaMwfjXvL2lm
         a8926l5q9eREn7BIOOjHNWiXZ7EMUSKVcbQ6PJRUwZx4Nf0DlC7nXwYreNfmKSaE1vmP
         dOtg==
X-Gm-Message-State: AJcUukc7+0Wuo8m0CbWOCL+sKQB8WSHuXikywCf4AojM15aqF7TcUL5s
        bTvtF2HH0W1PsPZ5JUjcOjw25BfeuzIM1IsKsU3V0Q==
X-Google-Smtp-Source: ALg8bN79xzF84mpqT9PowT9KxU6sSIHpBORgXfYF2wq0WumkJp46k8uDupCVefo8QOvu1yfsK2Ca0BciK0uEtWYLY3Q=
X-Received: by 2002:a19:2906:: with SMTP id p6mr6259390lfp.17.1548360372533;
 Thu, 24 Jan 2019 12:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190123205725.239661-1-rajatja@google.com>
 <20190123205725.239661-4-rajatja@google.com> <7A112914-5B41-4D26-807B-021B7AC907C6@holtmann.org>
In-Reply-To: <7A112914-5B41-4D26-807B-021B7AC907C6@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 24 Jan 2019 12:05:35 -0800
Message-ID: <CACK8Z6ENnMzD48CZwg7LyiTGRMJ9Eu6_bFDbEyxfrvDO5_AY2g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] Bluetooth: btusb: Use the cmd_timeout method to
 reset the Intel BT chip
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

On Thu, Jan 24, 2019 at 1:46 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Rajat,
>
> > If the platform provides it, use the reset gpio to reset the Intel BT
> > chip, as part of cmd_timeout handling. This has been found helpful on
> > Intel bluetooth controllers where the firmware gets stuck and the only
> > way out is a hard reset pin provided by the platform.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v5: Rename the hook to cmd_timeout, and wait for 5 timeouts before
> >    resetting the device.
> > v4: Use data->flags instead of clearing the quirk in btusb_hw_reset()
> > v3: Better error handling for gpiod_get_optional()
> > v2: Handle the EPROBE_DEFER case.
> >
> > drivers/bluetooth/btusb.c | 54 +++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 54 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 4761499db9ee..8949ea30a1bc 100644
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
> > +#define BTUSB_HW_RESET_ACTIVE        12
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
> > @@ -489,8 +493,39 @@ struct btusb_data {
> >       int (*setup_on_usb)(struct hci_dev *hdev);
> >
> >       int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> > +     unsigned num_cmd_timeout;
>
> Make this cmd_timeout_count or cmd_timeout_cnt.

Sure, will do.

>
> > };
> >
> > +
> > +static void btusb_intel_cmd_timeout(struct hci_dev *hdev,
> > +                                 struct hci_command_hdr *cmd)
> > +{
> > +     struct btusb_data *data =3D hci_get_drvdata(hdev);
> > +     struct gpio_desc *reset_gpio =3D data->reset_gpio;
> > +
> > +     bt_dev_err(hdev, "btusb num_cmd_timeout =3D %u", ++data->num_cmd_=
timeout);
>
> I would prefer if you don=E2=80=99t do the increase in the bt_dev_err(). =
And you can also scrap the =E2=80=9Cbtusb =E2=80=9C prefix here since that =
is all present via bt_dev_err if really needed at some point. Actually I qu=
estion the whole bt_dev_err here in the first place since the core will put=
 our the error. You are just repeating it here.

will do.

>
> > +
> > +     if (data->num_cmd_timeout < 5)
> > +             return;
>
> So I would propose to do just this:
>
>         if (++data->cmd_timeout_count < 5)
>                 return;

will do.


>
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
> > +     if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> > +             bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> > +             return;
> > +     }
> > +
> > +     bt_dev_err(hdev, "Initiating HW reset via gpio");
> > +     gpiod_set_value(reset_gpio, 1);
> > +     mdelay(100);
> > +     gpiod_set_value(reset_gpio, 0);
> > +}
> > +
> > static inline void btusb_free_frags(struct btusb_data *data)
> > {
> >       unsigned long flags;
> > @@ -2915,6 +2950,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                      const struct usb_device_id *id)
> > {
> >       struct usb_endpoint_descriptor *ep_desc;
> > +     struct gpio_desc *reset_gpio;
> >       struct btusb_data *data;
> >       struct hci_dev *hdev;
> >       unsigned ifnum_base;
> > @@ -3028,6 +3064,15 @@ static int btusb_probe(struct usb_interface *int=
f,
> >
> >       SET_HCIDEV_DEV(hdev, &intf->dev);
> >
> > +     reset_gpio =3D gpiod_get_optional(&data->udev->dev, "reset",
> > +                                     GPIOD_OUT_LOW);
>
> Any reason to not use the devm_gpiod_get_optional() version here?

Yes, we're using the &data->udev->dev device (parent of the USB
interface) to fetch the gpio, so if we use the devm_* variant, the
gpio resource will not be freed immediately if the btusb_probe fails.
I'll add a comment in the code to make this more clear.

>
> > +     if (IS_ERR(reset_gpio)) {
> > +             err =3D PTR_ERR(reset_gpio);
> > +             goto out_free_dev;
> > +     } else if (reset_gpio) {
> > +             data->reset_gpio =3D reset_gpio;
> > +     }
> > +
> >       hdev->open   =3D btusb_open;
> >       hdev->close  =3D btusb_close;
> >       hdev->flush  =3D btusb_flush;
> > @@ -3085,6 +3130,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
;
> >               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > +             if (data->reset_gpio)
> > +                     hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> >       }
>
> Always assign hdev->cmd_timeout =3D btusb_intel_cmd_timeout and put it af=
ter btintel_set_bdaddr and before the quirks.

will do.

>
> Move the if (data->reset_gpio) check into btusb_intel_cmd_timeout() funct=
ion and print a warning that no reset GPIO is present.

There'll be Intel platforms already out there which will obviously not
have the reset pin described in the ACPI as of today. So I'm not sure
if it is right for all of them to start complaining about a missing
"reset gpio" in case of timeout post this change. Thus I would prefer
to assign hdev->cmd_timeout only if ACPI does provide a gpio i.e.
newer platforms that want to support this feature. Thoughts?

Thanks,

Rajat

>
> >
> >       if (id->driver_info & BTUSB_INTEL_NEW) {
> > @@ -3097,6 +3144,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
;
> >               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > +             if (data->reset_gpio)
> > +                     hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> >       }
> >
> >       if (id->driver_info & BTUSB_MARVELL)
> > @@ -3226,6 +3275,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >       return 0;
> >
> > out_free_dev:
> > +     if (data->reset_gpio)
> > +             gpiod_put(data->reset_gpio);
> >       hci_free_dev(hdev);
> >       return err;
> > }
> > @@ -3269,6 +3320,9 @@ static void btusb_disconnect(struct usb_interface=
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

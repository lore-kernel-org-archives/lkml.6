Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697BE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLJtpU71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfAVWf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:35:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38954 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfAVWfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:35:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so130698lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V9deSiVGRtf7KOnz/GlOSFbMEK4BRjaxktbduYIKVnY=;
        b=bLJtpU71FMFxg38hzIqCSyVkh3i+x6LofTwhqnw900O5vvBbCCJrFvYB1PKOoYSJQg
         KzGI4/9AAO2rGvpMv9qJhrJKhCo18WreWlVBvOy+TuskE/F6hG3xLH2rqDk1XnNin12P
         87qC4o9JkJSEJXIWBf14CEnseK8gN2QcxSaM3Hxf80KNcUXL2j3QfENcgDfKj1JvquII
         6/HkN+gReEXUGOWrDK0Hsd8/BCPbmJVjrsOQ3E1by5sN1cN9WcxhXotGpccYw6ZP6BBZ
         hcspsGaKSZTVRxBYb5LHBppWqGKZooYG8Qf/JGHgQabW++B8ftGH7tG4UaqssENlQb41
         3igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V9deSiVGRtf7KOnz/GlOSFbMEK4BRjaxktbduYIKVnY=;
        b=gbQ2lG8jsE7w+ZRZmi9HMU7PtvPcf5mCW4DhOkh4xKFgHszlDc5+GLmcuLRhTUU2nj
         y4QAqThi3qir6G8nISBFiFCRUancHJ8L+jHdUqfkObSpVqWklSJE7Y+oazDYr9dKflgO
         lwyQwAPN+9eUroBFWRUJ7PDh6dMN0Unak/zQisB9TfWLSSo4L1ijq9aWqw2ckfdFnLtR
         mmLYL+pGU4F5RAU3174LQtKgyb3D7L3n+2+6AATQIvvpfkcOUChRpLQqDFePAHGdIQNe
         6XL921259OjePJmct0S9fBfCuF5GPvZVMgv3ZhZlMGPHIdvQ76J+gnQbdI4ZaUv/GcPG
         YAOQ==
X-Gm-Message-State: AJcUukefr+VNtHMQwvMqg9mVM9vGhnE4slHf4Dh6gCPrz3Hhvidr36vM
        fvORP1Oev5iWa/oAYUfIGvWWnPsSWf3u1NjlcPCjkQ==
X-Google-Smtp-Source: ALg8bN7P/BeHol1mQj+NCdReRKq5Fwg5E2xrUHUo/LsMsXcwGXxqebbLyM6AvCqOmgRyHbiIOlmiW62lKYL+kQ700jk=
X-Received: by 2002:a19:9e11:: with SMTP id h17mr22648197lfe.73.1548196551023;
 Tue, 22 Jan 2019 14:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
 <20190118223407.64818-4-rajatja@google.com> <46DE7349-6B10-4B2F-92C2-74D6EEFFF301@holtmann.org>
In-Reply-To: <46DE7349-6B10-4B2F-92C2-74D6EEFFF301@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Jan 2019 14:35:14 -0800
Message-ID: <CACK8Z6G5d836tHb999+jgkRPmcN4sPW=t5dL=Z-UbJkziGSAXg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Bluetooth: btusb: Collect the common Intel
 assignments together
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
> > The BTUSB_INTEL and BTUSB_INTEL_NEW have common functions & quirks are
> > assigned to hdev structure. Lets collect them together instead of
> > repeating them in different code branches.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: same as v1
> > v3: same as v1
> > v2: same as v1
> >
> > drivers/bluetooth/btusb.c | 27 ++++++++++++---------------
> > 1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 4761499db9ee..59869643cc29 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3075,28 +3075,25 @@ static int btusb_probe(struct usb_interface *in=
tf,
> >               data->diag =3D usb_ifnum_to_if(data->udev, ifnum_base + 2=
);
> >       }
> > #endif
> > +     if (id->driver_info & BTUSB_INTEL ||
> > +         id->driver_info & BTUSB_INTEL_NEW) {
> >
> > -     if (id->driver_info & BTUSB_INTEL) {
> >               hdev->manufacturer =3D 2;
> > -             hdev->setup =3D btusb_setup_intel;
> > -             hdev->shutdown =3D btusb_shutdown_intel;
> > -             hdev->set_diag =3D btintel_set_diag_mfg;
> >               hdev->set_bdaddr =3D btintel_set_bdaddr;
> >               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
;
> >               set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > -     }
> >
> > -     if (id->driver_info & BTUSB_INTEL_NEW) {
> > -             hdev->manufacturer =3D 2;
> > -             hdev->send =3D btusb_send_frame_intel;
> > -             hdev->setup =3D btusb_setup_intel_new;
> > -             hdev->hw_error =3D btintel_hw_error;
> > -             hdev->set_diag =3D btintel_set_diag;
> > -             hdev->set_bdaddr =3D btintel_set_bdaddr;
> > -             set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)=
;
> > -             set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> > -             set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> > +             if (id->driver_info & BTUSB_INTEL) {
> > +                     hdev->setup =3D btusb_setup_intel;
> > +                     hdev->shutdown =3D btusb_shutdown_intel;
> > +                     hdev->set_diag =3D btintel_set_diag_mfg;
> > +             } else {
> > +                     hdev->send =3D btusb_send_frame_intel;
> > +                     hdev->setup =3D btusb_setup_intel_new;
> > +                     hdev->hw_error =3D btintel_hw_error;
> > +                     hdev->set_diag =3D btintel_set_diag;
> > +             }
> >       }
>
> please scrap this patch since it is not making anything easier or simpler=
. You think it does, but it really doesn=E2=80=99t.

OK, will do.

Thanks,

Rajat

>
> Regards
>
> Marcel
>

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6765C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD7920866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNRdemVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAVWfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:35:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34995 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfAVWfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:35:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so147601lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QCFQ3/LFXyB79F8POK8jmGSXV3ke7RikEsl2ThYyROI=;
        b=tNRdemVe11eGyQYmbwSwlv4x+G3+rX24JksmHOU3/qAONuaKJnrVdsAcSOl8g391wi
         2uhVScAriP4gC2l7bPI6neqT8Oo8a5KDsK2l/VWO15c2DIAy6VUvc50MZyZEEZgOYSgB
         5wybwRfyolTwawB0RlAswL60VQaWxU9c8OhBsGAR6zuE0Q0PF3gb/bZmiTWu3ZrKVLFl
         lSalDQ+23N20sx26SDl1BHGeUzwonPgf2l4/o0MSzdU6ZAnJvWwXbYswbxPdgwX7cF7Q
         VL0fKemCDfcprSkxMjIkWYYXJt4srUssuVVfvlvH53oho15KBnhDADrgD9Zh1vFMy0+H
         WHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QCFQ3/LFXyB79F8POK8jmGSXV3ke7RikEsl2ThYyROI=;
        b=oK1voRv8hJgPqIxfmuGr2GzrpfXmPSID1ukYr9SOi0+JtwN84oJbpAhqeg1W2UjIRO
         4uTuWe8Q/LxfBzsUq28xunsX13+m7kGWmf0urAu+12qWCVZmu/wy/EtSY0L1kJNN3KkV
         vUjZPV2NLjR6S2lrNQRc0tSg+aeBmLYzaOvjlCSMlyi1W9iE0O983vH2SN1ixaiyTnMJ
         sDy1MvZZ7y6pLSujX9yzq4VnkTplsfPSF+g5M/NxcQM8wTDPTP/tf4JAYdPg6NT1G1lU
         qXpYwXY76CV7UnnsXreLeGDMSsxmpfH+zOuvmQqTeFmC0oot0sKs33kGhPtQ1LyepOpi
         U7Uw==
X-Gm-Message-State: AJcUukddSZyOm5anmmxzBXYup4C7kzPh7Qa0ay4g1beB5rDPjcZo4Y4a
        f669WjjdQj3qC4IpZkJ3EQYFWFEp8SOF/3XK7l6XpQ==
X-Google-Smtp-Source: ALg8bN6//9MPig48NtGEAeFaPuk8Y78gGdXHbuCvU2euV9KADpbRVltAgq+HhrzyQU/6JU+mYxc2XIoFYUq0Ivgpmjs=
X-Received: by 2002:a19:2906:: with SMTP id p6mr21485955lfp.17.1548196528984;
 Tue, 22 Jan 2019 14:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
 <20190118223407.64818-3-rajatja@google.com> <D1490A23-9076-4BAA-A932-CDE1C073475B@holtmann.org>
In-Reply-To: <D1490A23-9076-4BAA-A932-CDE1C073475B@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Jan 2019 14:34:52 -0800
Message-ID: <CACK8Z6FyBxibu-oeAnhZgcSxx_uzGcHsOqJ1S=RGeEZJj3K_og@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] Bluetooth: Reset Bluetooth chip after multiple
 command timeouts
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
> > Add a quirk and a hook to allow the HCI core to reset the BT chip
> > if needed (after a number of timed out commands). Use that new hook to
> > initiate BT chip reset if the controller fails to respond to certain
> > number of commands (currently 5) including the HCI reset commands.
> > This is done based on a newly introduced quirk. This is done based
> > on some initial work by Intel.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: same as v1
> > v3: same as v1
> > v2: same as v1
> >
> > include/net/bluetooth/hci.h      |  8 ++++++++
> > include/net/bluetooth/hci_core.h |  2 ++
> > net/bluetooth/hci_core.c         | 15 +++++++++++++--
> > 3 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index c36dc1e20556..af02fa5ffe54 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -192,6 +192,14 @@ enum {
> >        *
> >        */
> >       HCI_QUIRK_NON_PERSISTENT_SETUP,
> > +
> > +     /* When this quirk is set, hw_reset() would be run to reset the
> > +      * hardware, after a certain number of commands (currently 5)
> > +      * time out because the device fails to respond.
> > +      *
> > +      * This quirk should be set before hci_register_dev is called.
> > +      */
> > +     HCI_QUIRK_HW_RESET_ON_TIMEOUT,
> > };
> >
> > /* HCI device flags */
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index e5ea633ea368..b86218304b80 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -313,6 +313,7 @@ struct hci_dev {
> >       unsigned int    acl_cnt;
> >       unsigned int    sco_cnt;
> >       unsigned int    le_cnt;
> > +     unsigned int    timeout_cnt;
> >
> >       unsigned int    acl_mtu;
> >       unsigned int    sco_mtu;
> > @@ -437,6 +438,7 @@ struct hci_dev {
> >       int (*post_init)(struct hci_dev *hdev);
> >       int (*set_diag)(struct hci_dev *hdev, bool enable);
> >       int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> > +     void (*hw_reset)(struct hci_dev *hdev);
> > };
> >
> > #define HCI_PHY_HANDLE(handle)        (handle & 0xff)
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 7352fe85674b..ab3a6a8b7ba6 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2569,13 +2569,24 @@ static void hci_cmd_timeout(struct work_struct =
*work)
> >       struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> >                                           cmd_timer.work);
> >
> > +     hdev->timeout_cnt++;
> >       if (hdev->sent_cmd) {
> >               struct hci_command_hdr *sent =3D (void *) hdev->sent_cmd-=
>data;
> >               u16 opcode =3D __le16_to_cpu(sent->opcode);
> >
> > -             bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
> > +             bt_dev_err(hdev, "command 0x%4.4x tx timeout (cnt =3D %u)=
",
> > +                        opcode, hdev->timeout_cnt);
> >       } else {
> > -             bt_dev_err(hdev, "command tx timeout");
> > +             bt_dev_err(hdev, "command tx timeout (cnt =3D %u)",
> > +                        hdev->timeout_cnt);
> > +     }
> > +
> > +     if (test_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks) &&
> > +         hdev->timeout_cnt >=3D 5) {
> > +             hdev->timeout_cnt =3D 0;
> > +             if (hdev->hw_reset)
> > +                     hdev->hw_reset(hdev);
> > +             return;
> >       }
>
> so I really do not see the need for the quirk here. Either hdev->hw_reset=
 is provided, then execute it, if it is not provided then don=E2=80=99t. Th=
e quirk is just duplicate information.

Sure, will do.

>
> I also don=E2=80=99t like hdev->hw_reset since that implies that the only=
 way of handling a command timeout is a hardware reset. I prefer you call t=
his hdev->cmd_timeout and also scrap the timeout_cnt. Let the driver decide=
 what number of timeouts it wants to react on. The number 5 is just an arbi=
trary number you picked based on one hardware manufacturer.

Sure, I can move the timeout_cnt from hdev to btusb_data so that the
btusb can track the number of the timeouts..

Thanks,

Rajat

>
> Regards
>
> Marcel
>

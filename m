Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32785C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6433218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WouYq4kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfAXULX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:11:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39646 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfAXULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:11:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so6392343ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HG5FNm/40qWdHQsWrUQRMWT/agpt5B2Q6/gk2f7JfZE=;
        b=WouYq4kx3ch3DRkgzhCmjF4AiZ+q05wfeAxbg9N/kksxRerTzVHL3tson1EUF0cfd2
         Het0ejVSUjEIFk5p4kdG9qx4UIdhV+IC+uRnfavg89BDbOC3ok21PFqXyRFYOo5+fOZM
         0LVImucOuepsNtdqEy25Qo28R1SkvAG7GbjS3J3ZFj/0/3EPyZvR+oSxPv+2yizNKhjj
         CxTQTDUqwCY/kT+9e4A+oAdCeJ4IOTzO67vpXN4oy3YCPVBngLvfS82dBjMKLiEET4AP
         0BYY+0oEc0EMiVuBZQgjNnWbmc5PrGzkJP5DKRf7/fnDT1BPzAp+MH5BbH4SWDCx2rxm
         b/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HG5FNm/40qWdHQsWrUQRMWT/agpt5B2Q6/gk2f7JfZE=;
        b=ADPCm3rwsJ5HquwVXwr/028a+nu3Gq8w6Ki8OI8ECXeZlq30BQ58cvKm7CRgNzQnAu
         OHWL0u2Tx41B8TpWAuz9wzOQa8C9t7mT1G7gSa0+HWH5lTp/0gxFa7S746kjquHngFGi
         hcpuDbXQcENTNgBLzt0215x9rwpx2oQR57p4NT8+P8tjSwvneaORAiLT9WIP63pVerCj
         WQgMWn/hpqUgD+uL7sE8miM4tlxyjU6rzHcyyeHa2t9J5RAOdFTcwyeX4SkR9TfWJRt/
         xd84NxTxR2MJJ1KKdNYvLgCn2btXrO7YNElmfCCSqRScWobZfeQtxPThj43vlJ2c07kw
         r+wg==
X-Gm-Message-State: AJcUukcFfih9bq70bGZxT68pvZioitisH0eHYAGh7dAksTkpQa63djYZ
        vzlQAPLuiAUr1eP2mXxLPJg6QLIIt9CLNw6WTZaRLw==
X-Google-Smtp-Source: ALg8bN5iyDfUFaULY+MEuCxsUhn6+b26/wDUddQ77zFqokyiY6uRCisCg5+1tQkI0s8DnTvQqNTyEV7IsD9pKp0xnUI=
X-Received: by 2002:a2e:9395:: with SMTP id g21-v6mr6401932ljh.78.1548360679132;
 Thu, 24 Jan 2019 12:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190123205725.239661-1-rajatja@google.com>
 <20190123205725.239661-3-rajatja@google.com> <D868735A-05A4-405A-9101-8D59F4208B9E@holtmann.org>
In-Reply-To: <D868735A-05A4-405A-9101-8D59F4208B9E@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 24 Jan 2019 12:10:42 -0800
Message-ID: <CACK8Z6HSEXJSSFryusJVS632d1WwAUt1rW0Q2QTBO-375mMS+Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] Bluetooth: Allow driver specific cmd timeout handling
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

Hi Marcel,

On Thu, Jan 24, 2019 at 1:36 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Rajat,
>
> > Add a hook to allow the BT driver to do device or command specific
> > handling in case of timeouts. This is to be used by Intel driver to
> > reset the device after certain number of timeouts.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v5: Drop the quirk, and rename the hook function to cmd_timeout()
> > v4: same as v1
> > v3: same as v1
> > v2: same as v1
> >
> > include/net/bluetooth/hci_core.h |  1 +
> > net/bluetooth/hci_core.c         | 10 ++++++++--
> > 2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index e5ea633ea368..624d5f2b1f36 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -437,6 +437,7 @@ struct hci_dev {
> >       int (*post_init)(struct hci_dev *hdev);
> >       int (*set_diag)(struct hci_dev *hdev, bool enable);
> >       int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> > +     void (*cmd_timeout)(struct hci_dev *hdev, struct hci_command_hdr =
*cmd);
> > };
> >
> > #define HCI_PHY_HANDLE(handle)        (handle & 0xff)
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 7352fe85674b..c6917f57581a 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2568,16 +2568,22 @@ static void hci_cmd_timeout(struct work_struct =
*work)
> > {
> >       struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> >                                           cmd_timer.work);
> > +     struct hci_command_hdr *sent =3D NULL;
> >
> >       if (hdev->sent_cmd) {
> > -             struct hci_command_hdr *sent =3D (void *) hdev->sent_cmd-=
>data;
> > -             u16 opcode =3D __le16_to_cpu(sent->opcode);
> > +             u16 opcode;
> > +
> > +             sent =3D (void *) hdev->sent_cmd->data;
> > +             opcode =3D __le16_to_cpu(sent->opcode);
> >
> >               bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
> >       } else {
> >               bt_dev_err(hdev, "command tx timeout");
> >       }
> >
> > +     if (hdev->cmd_timeout)
> > +             hdev->cmd_timeout(hdev, sent);
> > +
>
> drop the sent parameter. You are not using it and if at some point in the=
 future you might want to use it, then we add it and fix up all users.

Sure, will do.

>
> And frankly, I would move the hdev->cmd_timeout call into the hdev->sent_=
cmd block since I do not even know if it makes sense to deal with the fallb=
ack case where hdev->sent_cmd is not available. Unless you have that kind o=
f error case, but that is only possible if you have external injection of H=
CI commands.

Ummm ... my preference would be to keep it outside the block so that
the hook is always invoked in any timeout, to be consistent (whether
externally injected or not). Let me know if that is OK. I plan to send
out an iteration keeping it outside, but I'll be happy to move it in
if you feel strongly about it.

Thanks,

Rajat

>
> Regards
>
> Marcel
>

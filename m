Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeENRiQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:38:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36348 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbeENRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:38:15 -0400
X-Google-Smtp-Source: AB8JxZoPCtKgkQXpZBJgFDwgKiEtv8N2ynMsKNVsJd4HELjLDtj0ARF2ZAauoHGXrpbw4sFIxe40HColEVGmfRG1B4U=
MIME-Version: 1.0
In-Reply-To: <20180514172849.27224-1-josef.simanek@gmail.com>
References: <1525831988-32017-1-git-send-email-ming_qian@realsil.com.cn> <20180514172849.27224-1-josef.simanek@gmail.com>
From: =?UTF-8?B?Sm9zZWYgxaBpbcOhbmVr?= <josef.simanek@gmail.com>
Date: Mon, 14 May 2018 19:38:13 +0200
Message-ID: <CAFp7Qwq02F66GpNCgeJx7H6VuRK9-kXs5E125m+SYWzR2+9GKw@mail.gmail.com>
Subject: Re: media: uvcvideo: Support realtek's UVC 1.5 device
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EHcNX9020471

I'm really sorry, but this message was originally meant to be sent
(and was already also sent) to linux-media. Please ignore here.

2018-05-14 19:28 GMT+02:00 Josef Šimánek <josef.simanek@gmail.com>:
>
> > The length of UVC 1.5 video control is 48, and it id 34 for UVC 1.1.
> > Change it to 48 for UVC 1.5 device,
> > and the UVC 1.5 device can be recognized.
> >
> > More changes to the driver are needed for full UVC 1.5 compatibility.
> > However, at least the UVC 1.5 Realtek RTS5847/RTS5852 cameras have
> > been reported to work well.
> >
> > Signed-off-by: ming_qian <ming_qian@realsil.com.cn>
> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Hello! I have sucessfully tested this patch on Kernel 4.16.1 (Fedora 28) with Dell XPS 9370
> using following device (output from lsusb):
>
> Bus 001 Device 002: ID 0bda:58f4 Realtek Semiconductor Corp.
>
> You can also find related dmesg output at https://bugs.launchpad.net/dell-sputnik/+bug/1763748/comments/35
>
> Tested-by: Josef Šimánek <josef.simanek@gmail.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index aa0082f..32dfb32 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -171,6 +171,8 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
> >       int ret;
> >
> >       size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
> > +     if (stream->dev->uvc_version >= 0x0150)
> > +             size = 48;
> >       if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
> >                       query == UVC_GET_DEF)
> >               return -EIO;
> > @@ -259,6 +261,8 @@ static int uvc_set_video_ctrl(struct uvc_streaming *stream,
> >       int ret;
> >
> >       size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
> > +     if (stream->dev->uvc_version >= 0x0150)
> > +             size = 48;
> >       data = kzalloc(size, GFP_KERNEL);
> >       if (data == NULL)
> >               return -ENOMEM;

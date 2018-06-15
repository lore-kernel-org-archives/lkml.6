Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D5CEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4723D208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPSStXvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4723D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756003AbeFOIDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:03:07 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37377 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755792AbeFOIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:03:04 -0400
Received: by mail-yw0-f195.google.com with SMTP id j134-v6so3073606ywg.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TUywPvvy+T+3/1XCUXGEFR/s9n7XvS1JZLvJf8YoPoA=;
        b=gPSStXvfT3YUbH2ePjau5UM44Yi1hTTyKq1awZ1Jr3DGw7KT3HGNLgo7YmrYTEV/UP
         eOcNUOHwQPBdrUNOX+WiwM5XnsOc7j7Mn5ud8Uu2Q9hzRN2QEnN6ztmDi/IY8EFcXElU
         /Sa+cTpC9ak/Kdrz0+0r/L/4sGRylgKr1cmUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TUywPvvy+T+3/1XCUXGEFR/s9n7XvS1JZLvJf8YoPoA=;
        b=A5WMuXaU+K89k00i0yZ0WWXbegmCAC4vKL88U9+ALd7+r6xybSTNq0tYeZPbvnHpGj
         YNPE6QiC870XwWgVV58Jnc74yEsYFxv2qf2bYOF3ZkmwbwE1P1WKAHujnSsfUi1a5Nc8
         CWVblbdZ5EPpreo2jjCiIKIsMTVE4/HuS10zUXeiI7yLB0NAjNRWtD2PDcmoOmX5WuxL
         w0UpiE7vFueTA2W9fo5cN30ZYIy7x+5mWxS41tGDjIT0vxCNJ8iJaUJqw6VoN7MLJGvW
         XrjHHjpIhbLUfktYanZtWmNltdLNg2pxlVP1sHCky+NR4nLor4mp5kqE4NsxtiPbfMID
         DqHA==
X-Gm-Message-State: APt69E19w8IMhtZAOq9VhyqZLqcjIh72YEt+1KgsiwL95yDUdh+ZXOHz
        8GfZwTc9+k4bzVJDKVVLFwVu5cjmeKs=
X-Google-Smtp-Source: ADUXVKIdArk2+VZtC47I7peN6jIizY5zAV36Rsh5fYmH9gPnYXDiWDHX46TVrJl1s6ONMTAcfzme0w==
X-Received: by 2002:a81:e30e:: with SMTP id q14-v6mr277625ywl.23.1529049783330;
        Fri, 15 Jun 2018 01:03:03 -0700 (PDT)
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com. [209.85.161.177])
        by smtp.gmail.com with ESMTPSA id y21-v6sm3239882ywd.0.2018.06.15.01.03.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 01:03:02 -0700 (PDT)
Received: by mail-yw0-f177.google.com with SMTP id s201-v6so3066809ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 01:03:02 -0700 (PDT)
X-Received: by 2002:a0d:dc81:: with SMTP id f123-v6mr267212ywe.66.1529049781634;
 Fri, 15 Jun 2018 01:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180605103328.176255-1-tfiga@chromium.org> <20180605103328.176255-2-tfiga@chromium.org>
 <89dca3ae-cbbc-4b5b-1c8a-207951997839@linaro.org>
In-Reply-To: <89dca3ae-cbbc-4b5b-1c8a-207951997839@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 15 Jun 2018 17:02:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B=8cKgvBThPB1YMUfHtuVUnLqPoAQ6rkf6Lyi=18Obgg@mail.gmail.com>
Message-ID: <CAAFQd5B=8cKgvBThPB1YMUfHtuVUnLqPoAQ6rkf6Lyi=18Obgg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] media: docs-rst: Add decoder UAPI specification
 to Codec Interfaces
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Thu, Jun 14, 2018 at 9:34 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
>
> On 06/05/2018 01:33 PM, Tomasz Figa wrote:
> > Due to complexity of the video decoding process, the V4L2 drivers of
> > stateful decoder hardware require specific sequencies of V4L2 API calls
> > to be followed. These include capability enumeration, initialization,
> > decoding, seek, pause, dynamic resolution change, flush and end of
> > stream.
> >
> > Specifics of the above have been discussed during Media Workshops at
> > LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> > Conference Europe 2014 in D=C3=BCsseldorf. The de facto Codec API that
> > originated at those events was later implemented by the drivers we alre=
ady
> > have merged in mainline, such as s5p-mfc or mtk-vcodec.
> >
> > The only thing missing was the real specification included as a part of
> > Linux Media documentation. Fix it now and document the decoder part of
> > the Codec API.
> >
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >  Documentation/media/uapi/v4l/dev-codec.rst | 771 +++++++++++++++++++++
> >  Documentation/media/uapi/v4l/v4l2.rst      |  14 +-
> >  2 files changed, 784 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/media/uapi/v4l/dev-codec.rst b/Documentation=
/media/uapi/v4l/dev-codec.rst
> > index c61e938bd8dc..0483b10c205e 100644
> > --- a/Documentation/media/uapi/v4l/dev-codec.rst
> > +++ b/Documentation/media/uapi/v4l/dev-codec.rst
>
> <snip>
>
> > +Initialization sequence
> > +-----------------------
> > +
> > +1. (optional) Enumerate supported OUTPUT formats and resolutions. See
> > +   capability enumeration.
> > +
> > +2. Set a coded format on the source queue via :c:func:`VIDIOC_S_FMT`
> > +
> > +   a. Required fields:
> > +
> > +      i.   type =3D OUTPUT
> > +
> > +      ii.  fmt.pix_mp.pixelformat set to a coded format
> > +
> > +      iii. fmt.pix_mp.width, fmt.pix_mp.height only if cannot be
> > +           parsed from the stream for the given coded format;
> > +           ignored otherwise;
>
> Can we say that if width !=3D 0 and height !=3D 0 then the user knows the
> real coded resolution? And vise versa if width/height are both zero the
> driver should parse the stream metadata?
>
> Also what about fmt.pix_mp.plane_fmt.sizeimage, as per spec (S_FMT) this
> field should be filled with correct image size? If the coded
> width/height is zero sizeimage will be unknown. I think we have two
> options, the user fill sizeimage with bigger enough size or the driver
> has to have some default size.

First of all, thanks for review!

It's a bit more tricky, because not all hardware may permit the
resolution of CAPTURE buffers, based on what userspace set on OUTPUT
queue.

I'd say that the hardware should always parse these data from the
stream, if it has such ability. If it parses, it should update the
OUTPUT format and, if CAPTURE format as set by userspace is not
compatible with HW requirements, it should adjust CAPTURE format
appropriately. It would then send a source change event, mandating the
userspace to read the new format.

That would be still compatible with old userspace (GStreamer), since
on hardware it used to work, the resulting CAPTURE format would be
compatible with hardware.

As for sizeimage on OUTPUT, it doesn't really make much sense, because
OUTPUT queue is fed with compressed bitstream. Existing drivers accept
this coming from userspace. If there is a specific HW requirement
(e.g. constant buffer size or at least N bytes), the driver should
adjust it appropriately on S_FMT then.

>
> > +
> > +   b. Return values:
> > +
> > +      i.  EINVAL: unsupported format.
> > +
> > +      ii. Others: per spec
> > +
> > +   .. note::
> > +
> > +      The driver must not adjust pixelformat, so if
> > +      ``V4L2_PIX_FMT_H264`` is passed but only
> > +      ``V4L2_PIX_FMT_H264_SLICE`` is supported, S_FMT will return
> > +      -EINVAL. If both are acceptable by client, calling S_FMT for
> > +      the other after one gets rejected may be required (or use
> > +      :c:func:`VIDIOC_ENUM_FMT` to discover beforehand, see Capability
> > +      enumeration).
> > +
> > +3.  (optional) Get minimum number of buffers required for OUTPUT queue
> > +    via :c:func:`VIDIOC_G_CTRL`. This is useful if client intends to u=
se
> > +    more buffers than minimum required by hardware/format (see
> > +    allocation).
> > +
> > +    a. Required fields:
> > +
> > +       i. id =3D ``V4L2_CID_MIN_BUFFERS_FOR_OUTPUT``
> > +
> > +    b. Return values: per spec.
> > +
> > +    c. Return fields:
> > +
> > +       i. value: required number of OUTPUT buffers for the currently s=
et
> > +          format;
> > +
> > +4.  Allocate source (bitstream) buffers via :c:func:`VIDIOC_REQBUFS` o=
n OUTPUT
> > +    queue.
> > +
> > +    a. Required fields:
> > +
> > +       i.   count =3D n, where n > 0.
> > +
> > +       ii.  type =3D OUTPUT
> > +
> > +       iii. memory =3D as per spec
> > +
> > +    b. Return values: Per spec.
> > +
> > +    c. Return fields:
> > +
> > +       i. count: adjusted to allocated number of buffers
> > +
> > +    d. The driver must adjust count to minimum of required number of
> > +       source buffers for given format and count passed. The client
> > +       must check this value after the ioctl returns to get the
> > +       number of buffers allocated.
> > +
> > +    .. note::
> > +
> > +       Passing count =3D 1 is useful for letting the driver choose
> > +       the minimum according to the selected format/hardware
> > +       requirements.
> > +
> > +    .. note::
> > +
> > +       To allocate more than minimum number of buffers (for pipeline
> > +       depth), use G_CTRL(``V4L2_CID_MIN_BUFFERS_FOR_OUTPUT)`` to
> > +       get minimum number of buffers required by the driver/format,
> > +       and pass the obtained value plus the number of additional
> > +       buffers needed in count to :c:func:`VIDIOC_REQBUFS`.
> > +
> > +5.  Begin parsing the stream for stream metadata via :c:func:`VIDIOC_S=
TREAMON` on
> > +    OUTPUT queue. This step allows the driver to parse/decode
> > +    initial stream metadata until enough information to allocate
> > +    CAPTURE buffers is found. This is indicated by the driver by
> > +    sending a ``V4L2_EVENT_SOURCE_CHANGE`` event, which the client
> > +    must handle.
> > +
> > +    a. Required fields: as per spec.
> > +
> > +    b. Return values: as per spec.
> > +
> > +    .. note::
> > +
> > +       Calling :c:func:`VIDIOC_REQBUFS`, :c:func:`VIDIOC_STREAMON`
> > +       or :c:func:`VIDIOC_G_FMT` on the CAPTURE queue at this time is =
not
> > +       allowed and must return EINVAL.
> > +
> > +6.  This step only applies for coded formats that contain resolution
> > +    information in the stream.
>
> maybe an example of such coded formats will be good to have.

I think we should make it more like "for coded formats that the
hardware is able to parse resolution information from the stream".
Obviously we can still list formats, which include such information,
but we should add a note saying that such capability is
hardware-specific.

Best regards,
Tomasz

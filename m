Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3566C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805F4208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZ5P6Gi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805F4208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeH1MIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:08:48 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36088 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeH1MIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:08:48 -0400
Received: by mail-yb0-f196.google.com with SMTP id d34-v6so273048yba.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 01:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tD8Vv2x73GofKXCwUQxCEH6SLdz9je5BpZ4ax6wXzm0=;
        b=VZ5P6Gi9je5V352nIL7zuR9xSN6fdia49TSBkQeT8Cv5mP3HpOj83j2/N30JOOsd3a
         L8d1E4JUq3YzG8k7Hfe5Qm4u+BkHu0fZOZe9xA3GaBHNAzAwKubZyEbloQbUxFaEQ40G
         0g0mD85oC8PjkC/CgAcyhF/MN3Oeo6MCJXtqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tD8Vv2x73GofKXCwUQxCEH6SLdz9je5BpZ4ax6wXzm0=;
        b=M9ez47ypIw2g/Fb3z0SuHoHwWe0/Tk5uquNG+28jIFzwafceMjrocF/K8oy9tSR42K
         bY4jOIwBb4T6kWTZpA5BHBfrzheiDqHThzY2H983/72SgBkDrD9ZrcslytKbxHgnvALH
         JwpCh/km8OKBxSWwT9gIetRzSkR/uOfk6Xw5uGwejpb6nl+kkcbnHCGmSeIjhmhU5ZP2
         HLslr/M7yRlN9DXMbHgkyaRBcUTewpXexW0jvhWolydyvTQYIkMRuDXD3kPZedzTw0G9
         LfbTxSL1TmosBCbm+G0mcgD30OlFJnXsxqfEaJpJEnh03hVLzbRAFtjGuvOxddLPTN+C
         Sq+A==
X-Gm-Message-State: APzg51BFzewWDnyjwaN4yGcBNQJ5UZeRLYxUrQ7gN1pJoHOp5pc7AzMb
        6/7vATyJ7uEZ7/Pad3uLZA7LB6gH75m3LA==
X-Google-Smtp-Source: ANB0Vdb0YfdEgTR9yYALXfFNSIr3xAffswpQclxMBtlsS3XNJPhQoTQVjkH6B0k2Cs+jlox4ZFTQMw==
X-Received: by 2002:a25:7616:: with SMTP id r22-v6mr192820ybc.237.1535444297179;
        Tue, 28 Aug 2018 01:18:17 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id t193-v6sm150365ywc.43.2018.08.28.01.18.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 01:18:16 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id q129-v6so258940ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 01:18:16 -0700 (PDT)
X-Received: by 2002:a81:470a:: with SMTP id u10-v6mr210609ywa.164.1535443895958;
 Tue, 28 Aug 2018 01:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com> <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
 <d8a30e78e6a33db10360995d800f2c0d19acc500.camel@collabora.com>
 <53987ca7a536a21b2eb49626d777a9bf894d6910.camel@bootlin.com>
 <CAAFQd5B68ArBgSj-Oso8=MzSrvVGB=h+MVO12qqgACmBrZtRkw@mail.gmail.com> <faca77cc213e4737c689f80ac5e830833bbe87ae.camel@bootlin.com>
In-Reply-To: <faca77cc213e4737c689f80ac5e830833bbe87ae.camel@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 28 Aug 2018 17:11:24 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Az89KTS_+VBUMHX3Eice+OKQn66Hw0rBusf4g6rSJ7VA@mail.gmail.com>
Message-ID: <CAAFQd5Az89KTS_+VBUMHX3Eice+OKQn66Hw0rBusf4g6rSJ7VA@mail.gmail.com>
Subject: Re: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Pawel Osciak <posciak@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        jenskuske@gmail.com, linux-sunxi@googlegroups.com,
        thomas.petazzoni@bootlin.com, groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:45 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Wed, 2018-08-22 at 22:38 +0900, Tomasz Figa wrote:
> > On Wed, Aug 22, 2018 at 10:07 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, 2018-08-21 at 13:07 -0400, Nicolas Dufresne wrote:
> > > > Le mardi 21 ao=C3=BBt 2018 =C3=A0 13:58 -0300, Ezequiel Garcia a =
=C3=A9crit :
> > > > > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > > > > From: Pawel Osciak <posciak@chromium.org>
> > > > > >
> > > > > > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > > > > > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > > > > > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > > > > > [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> > > > > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > > > ---
> > > > > >
> > > > >
> > > > > [..]
> > > > > > diff --git a/include/uapi/linux/videodev2.h
> > > > > > b/include/uapi/linux/videodev2.h
> > > > > > index 242a6bfa1440..4b4a1b25a0db 100644
> > > > > > --- a/include/uapi/linux/videodev2.h
> > > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > > @@ -626,6 +626,7 @@ struct v4l2_pix_format {
> > > > > >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') =
/*
> > > > > > H264 with start codes */
> > > > > >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1'=
) /*
> > > > > > H264 without start codes */
> > > > > >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') =
/*
> > > > > > H264 MVC */
> > > > > > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4'=
) /*
> > > > > > H264 parsed slices */
> > > > >
> > > > > As pointed out by Tomasz, the Rockchip VPU driver expects start c=
odes
> > > > > [1], so the userspace
> > > > > should be aware of it. Perhaps we could document this pixel forma=
t
> > > > > better as:
> > > > >
> > > > > #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /=
*
> > > > > H264 parsed slices with start codes */
> > > > >
> > > > > And introduce another pixel format:
> > > > >
> > > > > #define V4L2_PIX_FMT_H264_SLICE_NO_SC v4l2_fourcc(TODO) /* H264
> > > > > parsed slices without start codes */
> > > > >
> > > > > For cedrus to use, as it seems it doesn't need start codes.
> > > >
> > > > I must admit that this RK requirement is a bit weird for slice data=
.
> > > > Though, userspace wise, always adding start-code would be compatibl=
e,
> > > > as the driver can just offset to remove it.
> > >
> > > This would mean that the stateless API no longer takes parsed bitstre=
am
> > > data but effectively the full bitstream, which defeats the purpose of
> > > the _SLICE pixel formats.
> > >
> >
> > Not entirely. One of the purposes of the _SLICE pixel format was to
> > specify it in a way that adds a requirement of providing the required
> > controls by the client.
>
> I think we need to define what we want the stateless APIs (and these
> formats) to precisely reflect conceptually. I've started discussing this
> in the Request API and V4L2 capabilities thread.
>
> > > > Another option, because I'm not fan of adding dedicated formats for
> > > > this, the RK driver could use data_offset (in mplane v4l2 buffers),
> > > > just write a start code there. I like this solution because I would=
 not
> > > > be surprise if some drivers requires in fact an HW specific header,
> > > > that the driver can generate as needed.
> > >
> > > I like this idea, because it implies that the driver should deal with
> > > the specificities of the hardware, instead of making the blurrying th=
e
> > > lines of stateless API for covering these cases.
> >
> > The spec says
> >
> > "Offset in bytes to video data in the plane. Drivers must set this
> > field when type refers to a capture stream, applications when it
> > refers to an output stream."
> >
> > which would mean that user space would have to know to reserve some
> > bytes at the beginning for the driver to add the start code there. (Or
> > the driver memmove()ing the data forward when the buffer is queued,
> > assuming that there is enough space in the buffer, but it should
> > normally be the case.)
> >
> > Sounds like a pixel format with full bitstream data and some offsets
> > to particular parts inside given inside a control might be the most
> > flexible and cleanest solution.
>
> I can't help but think that bringing the whole bitstream over to the
> kernel with a dedicated pix fmt just for the sake of having 3 start code
> bytes is rather overkill anyway.
>
> I believe moving the data around to be the best call for this situation.
> Or maybe there's a way to alloc more data *before* the bufer that is
> exposed to userspace, so userspace can fill it normally and the driver
> can bring-in the necessary heading start code bytes before the buffer?

After thinking this over for some time, I believe it boils down to
whether we can have an in-kernel library for turning H264 (and other
codec) header structs back into a bitstream, if we end up with more
than one driver need to do it. If that's fine, I think we're okay with
having just the parsed pixel format around.

Note that I didn't think about this with the Rockchip driver in mind,
since it indeed only needs few bytes.

Best regards,
Tomasz

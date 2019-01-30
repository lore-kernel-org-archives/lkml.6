Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD256C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5CA21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJnsR660"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfA3I5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:57:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44375 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfA3I5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:57:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so18310787edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jjgfw3PjFnnbx3+AH1+14Uv6ddbGESd7bkKA7umb7Ig=;
        b=IJnsR660p3xBx2YdhJnUZ8+QWcMQOB1Vr678VQsteZEgdVIxldt7W9tsDKIqOGCH1t
         kOc6p8OR5xor2Hl/GEQq7DaBXL/IGPR71e9bbKATftN8oS2M5OQupajs+0pBP4fclUQ5
         WfuSUXBd5kbKIE2143+nXj9TRanKd6c7KOQzWExJu8zOm97yVOvSh6nzv+rP1FjILKtP
         26h+04XtzGX36IaNSL40rGs0HO+/FG8/XhTBYz/GGpm189kmRFoG6daSOmqQsNX3713/
         Ltn8pYhAV3pmNJt93nz1N3A02TnIpHAwTmaNR36h72z9es3VFk01kwDYYdOFCP5Wt9qp
         nT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jjgfw3PjFnnbx3+AH1+14Uv6ddbGESd7bkKA7umb7Ig=;
        b=af7eWwm/Ygj7GvELBRJ6ACW6DjOGCh8xegpy//nIifgGv/ZE0gC84R8F1EFkcMF9jq
         84HFp4WDgVLEA3VycJ/sq51MRFAtRs51Un1QXoK7u8R3sM5UQhN4zqXku6yCSSM8VAtB
         DO8yAGG6iXM6X8iaSrnl380wa/QvX4ePzvzWfRwffk9VjURzNWe5YzBbyYm1AMIsVY7t
         BtSMoYtJb2w5xlpty1K2adgd4zEwcwAgZ3Yy1PAe7aOKKt00bsJHw/VXXFQjaufGgbMQ
         1m5MI5zyym5ZY8UTNJrGRFvxoJA2YoumAOIWi3Na8rFpNyE6vHdqeAnsgEmjhyqEMHTG
         be4g==
X-Gm-Message-State: AJcUukdOxKSd26n3f9W9cqUgn738FFPdG/s0B/Vq2Rxibi7/WLKpGa+O
        FIBbT4ECUVcXH40znvcbxy7R9lnxSm8/1jljtPLttQ==
X-Google-Smtp-Source: ALg8bN7iOf4do2IgChTrm45tQFcHunqdC4Uyiii2Q3S7r00V82I4Vlu/walV2p3TgkdzSfxJpEnUS+PntDHTfmecuLI=
X-Received: by 2002:a17:906:f212:: with SMTP id gt18mr25975605ejb.201.1548838621031;
 Wed, 30 Jan 2019 00:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20190128072948.45788-1-linfish@google.com> <20190130074522.155770-1-linfish@google.com>
 <6de7d597-f89a-e20d-a1fd-3f683f4916b8@xs4all.nl>
In-Reply-To: <6de7d597-f89a-e20d-a1fd-3f683f4916b8@xs4all.nl>
From:   Fish Lin <linfish@google.com>
Date:   Wed, 30 Jan 2019 16:56:50 +0800
Message-ID: <CAHpF3df09Ho=EzbkBNbFmM9vThWhk4P3DjwYYxnY85kHEtDtFg@mail.gmail.com>
Subject: Re: [PATCH v2] [media] v4l: add I / P frame min max QP definitions
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

For I frame min QP, if global min QP is set, the QP choose algorithm
should meet both of them, hence QP will >=3D
max(V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP,
V4L2_CID_MPEG_VIDEO_H264_MIN_QP).
And this is also the same to the P frame and max QP.
I can add some description to describe this behavior in the document.

Thanks,
Fish


Hans Verkuil <hverkuil-cisco@xs4all.nl> =E6=96=BC 2019=E5=B9=B41=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 1/30/19 8:45 AM, Fish Lin wrote:
> > Add following V4L2 QP parameters for H.264:
> >  * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP
> >  * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP
> >  * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP
> >  * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP
> >
> > These controls will limit QP range for intra and inter frame,
> > provide more manual control to improve video encode quality.
>
> How will this interact with V4L2_CID_MPEG_VIDEO_H264_MIN/MAX_QP?
>
> Or are drivers supposed to have either V4L2_CID_MPEG_VIDEO_H264_MIN/MAX_Q=
P
> or these new controls? If so, then that should be documented.
>
> Regards,
>
>         Hans
>
> >
> > Signed-off-by: Fish Lin <linfish@google.com>
> > ---
> > Changelog since v1:
> > - Add description in document.
> >
> >  .../media/uapi/v4l/extended-controls.rst         | 16 ++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls.c             |  4 ++++
> >  include/uapi/linux/v4l2-controls.h               |  6 ++++++
> >  3 files changed, 26 insertions(+)
> >
> > diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Docum=
entation/media/uapi/v4l/extended-controls.rst
> > index 286a2dd7ec36..f5989fad34f9 100644
> > --- a/Documentation/media/uapi/v4l/extended-controls.rst
> > +++ b/Documentation/media/uapi/v4l/extended-controls.rst
> > @@ -1214,6 +1214,22 @@ enum v4l2_mpeg_video_h264_entropy_mode -
> >      Quantization parameter for an B frame for H264. Valid range: from =
0
> >      to 51.
> >
> > +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP (integer)``
> > +    Minimum quantization parameter for H264 I frame, to limit I frame
> > +    quality in a range. Valid range: from 0 to 51.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP (integer)``
> > +    Maximum quantization parameter for H264 I frame, to limit I frame
> > +    quality in a range. Valid range: from 0 to 51.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP (integer)``
> > +    Minimum quantization parameter for H264 P frame, to limit P frame
> > +    quality in a range. Valid range: from 0 to 51.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP (integer)``
> > +    Maximum quantization parameter for H264 P frame, to limit P frame
> > +    quality in a range. Valid range: from 0 to 51.
> > +
> >  ``V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP (integer)``
> >      Quantization parameter for an I frame for MPEG4. Valid range: from=
 1
> >      to 31.
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-=
core/v4l2-ctrls.c
> > index 5e3806feb5d7..e2b0af0d2283 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> > @@ -825,6 +825,10 @@ const char *v4l2_ctrl_get_name(u32 id)
> >       case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER:return "H=
264 Number of HC Layers";
> >       case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP:
> >                                                               return "H=
264 Set QP Value for HC Layers";
> > +     case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP:           return "H=
264 I-Frame Minimum QP Value";
> > +     case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP:           return "H=
264 I-Frame Maximum QP Value";
> > +     case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP:           return "H=
264 P-Frame Minimum QP Value";
> > +     case V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP:           return "H=
264 P-Frame Maximum QP Value";
> >       case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:              return "M=
PEG4 I-Frame QP Value";
> >       case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:              return "M=
PEG4 P-Frame QP Value";
> >       case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:              return "M=
PEG4 B-Frame QP Value";
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index 3dcfc6148f99..9519673e6437 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -533,6 +533,12 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type=
 {
> >  };
> >  #define V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER   (V4L2_CID=
_MPEG_BASE+381)
> >  #define V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP        (=
V4L2_CID_MPEG_BASE+382)
> > +
> > +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP      (V4L2_CID_MPEG_BA=
SE+390)
> > +#define V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP      (V4L2_CID_MPEG_BA=
SE+391)
> > +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP      (V4L2_CID_MPEG_BA=
SE+392)
> > +#define V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP      (V4L2_CID_MPEG_BA=
SE+393)
> > +
> >  #define V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP (V4L2_CID_MPEG_BASE+400)
> >  #define V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP (V4L2_CID_MPEG_BASE+401)
> >  #define V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP (V4L2_CID_MPEG_BASE+402)
> >
>


--=20
Fish Lin | Software Engineer | linfish@google.com | +886-921-925519

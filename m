Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A9CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFD121773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3eS4jQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfBLJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:24:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41587 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfBLJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:24:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id x7so1549022eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2PNDl6nV9RU+JZecDYjLTg1r/ZivStlLro7rUaCjEkM=;
        b=g3eS4jQbWrfvbpoXVnsCs5rW+UWTKuikGotEIjX8R0Wl8X3rc4d08hpy3qsugMLpwO
         VMngwniqjBHC5rukdeQB0PRBbrvwJ0e/2Y1RiYdF5HgGLGBD92qFQJjHTmlg/iAe7ufM
         FfP9M+azZyoiLZZbWwuE04vumc0h4/vpPLRbPL35AXYVOzruYaQ6FpLRkkHV0t0cKQ8t
         OOU9krdmCLedaFxmkG14bz5PFk9Sl9LLbPrIUU790X/EKXI4E/vtboRwFrpFiPR1Vk8j
         E6HhdRgFkQ4PgcIey9MpQuYKNGtqYsxVESVXF6MoNBJnU/qM10x3h/oyJqnqJo7FqRMJ
         KivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2PNDl6nV9RU+JZecDYjLTg1r/ZivStlLro7rUaCjEkM=;
        b=Alw9mpsTgQEcP/rZn36kb1Gx9jJ6GKLFywXXxf8B3nCcx8HWYFLPMpbCftwGaS4yW2
         jsyv58PkSujaP8LgAjeADYoC6/vFGv3tijRzM6gN5d6qOk2Ues1b/xRQ/X0FRRVAZOAn
         Yre/mKT6udeWw5Kcsq4LjYYKlqoFDHMk4CcBH70fSZgPQaOwoah6i+RTuusu7MOrZV3R
         m4U8Zd6hE9A5VZuzs/5Gig7whi2zJ5BRTUA97//zOeyKIpX4g0YJz3KA3cXEPmM7/qGU
         8O1vUn1kvYa9lW4XfgZ/NkvQFtvJyZnXLJ72eG5rhUYImYBuFulAfQTcfvN958SHVqw+
         KPVA==
X-Gm-Message-State: AHQUAuY0BU8VRgM3FsZWqS0DgjHv3C5RtTgtCWpn/ttxuUpCppNOEaUb
        n2eYIxtQVzFp3ymDa3edjNDdIB8wCs1b68P4c5owjw==
X-Google-Smtp-Source: AHgI3IacLRzP2VBziTvZqIibqVEkU1xcS7+MKd2Wc6sdt6FTmePbkAhJ3QsqtNbSjX3R66wktJs/HpgyFmN1Xtv7TQU=
X-Received: by 2002:a50:ac55:: with SMTP id w21mr2269277edc.121.1549963437454;
 Tue, 12 Feb 2019 01:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20190128072948.45788-1-linfish@google.com> <20190130091116.256989-1-linfish@google.com>
 <66239266-1d83-8fde-1cd2-632be8f1d0e5@xs4all.nl>
In-Reply-To: <66239266-1d83-8fde-1cd2-632be8f1d0e5@xs4all.nl>
From:   Fish Lin <linfish@google.com>
Date:   Tue, 12 Feb 2019 17:23:46 +0800
Message-ID: <CAHpF3degqmbU+y4RfSC+jQdB5m7-yRfvA__mAnz01-THZSEfkw@mail.gmail.com>
Subject: Re: [PATCH v3] [media] v4l: add I / P frame min max QP definitions
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

Got it, I'll submit another patch after your patch merged.

Thanks,
Fish


Hans Verkuil <hverkuil-cisco@xs4all.nl> =E6=96=BC 2019=E5=B9=B42=E6=9C=888=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:58=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 1/30/19 10:11 AM, Fish Lin wrote:
> > Add following V4L2 QP parameters for H.264:
> >  * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP
> >  * V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP
> >  * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP
> >  * V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP
> >
> > These controls will limit QP range for intra and inter frame,
> > provide more manual control to improve video encode quality.
> >
> > Signed-off-by: Fish Lin <linfish@google.com>
> > ---
> > Changelog since v2:
> > - Add interaction with V4L2_CID_MPEG_VIDEO_H264_MIN/MAX_QP
> >   description in the document.
> >
> > Changelog since v1:
> > - Add description in document.
> >
> >  .../media/uapi/v4l/extended-controls.rst      | 24 +++++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls.c          |  4 ++++
> >  include/uapi/linux/v4l2-controls.h            |  6 +++++
> >  3 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Docum=
entation/media/uapi/v4l/extended-controls.rst
> > index 286a2dd7ec36..402e41eb24ee 100644
> > --- a/Documentation/media/uapi/v4l/extended-controls.rst
> > +++ b/Documentation/media/uapi/v4l/extended-controls.rst
> > @@ -1214,6 +1214,30 @@ enum v4l2_mpeg_video_h264_entropy_mode -
> >      Quantization parameter for an B frame for H264. Valid range: from =
0
> >      to 51.
> >
> > +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP (integer)``
> > +    Minimum quantization parameter for H264 I frame, to limit I frame
> > +    quality in a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is set, the quantization parameter
>
> is set -> is also set
>
> > +    should be chosen to meet both of the requirement.
>
> both of the requirement -> both requirements
>
> Ditto for the other three controls below.
>
> However, you might want to wait a little bit since I have this patch pend=
ing:
>
> https://patchwork.linuxtv.org/patch/54388/
>
> which will require a rebase of your patch anyway.
>
> Regards,
>
>         Hans
>
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP (integer)``
> > +    Maximum quantization parameter for H264 I frame, to limit I frame
> > +    quality in a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is set, the quantization parameter
> > +    should be chosen to meet both of the requirement.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP (integer)``
> > +    Minimum quantization parameter for H264 P frame, to limit P frame
> > +    quality in a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MIN_QP is set, the quantization parameter
> > +    should be chosen to meet both of the requirement.
> > +
> > +``V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP (integer)``
> > +    Maximum quantization parameter for H264 P frame, to limit P frame
> > +    quality in a range. Valid range: from 0 to 51. If
> > +    V4L2_CID_MPEG_VIDEO_H264_MAX_QP is set, the quantization parameter
> > +    should be chosen to meet both of the requirement.
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

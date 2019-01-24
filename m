Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95907C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BACB21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FfTdq+XQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAXInr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:43:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36982 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfAXInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:43:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so4211153oia.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IHbjA+eWfsPVp3mqIPGqB0gvsgYr2/M02Hhjj1xngA=;
        b=FfTdq+XQZ4NWG8TH7qepr9aYPo7mEkzskhdaaPadSV4OuaP6Sy6C+jpk2Xb2g5ZfPv
         rqklvjpgb4jyY5+dyTb7m24XRZPuEXdYWReal2+c9kd3utZCVsOmiMIma9T9IiwDtHR4
         Ie9he1TDbYp9RI3dS+vVsQy5vvvOSujgpf7sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IHbjA+eWfsPVp3mqIPGqB0gvsgYr2/M02Hhjj1xngA=;
        b=UX8nv0t/DJ4tdzKshOln0J6sF9sK3cLkgQrx3QoZErx+gq6A4O37qADWHdlgRdsqWw
         vPA1zYj3dxp706BAbdrj3CkSvCuUr487yZjzugH6AP83mMffaqw8Bqu4ta3kw3qi8FXF
         j4rWSoceuPsIVD8Pw2d8dLY56NB3V6AO5JadjA0PQFwM1KHUwxcG83Wp/O7t4WL3Swgv
         a/SR+0MDX/4FjzY6KoieFQPA7BZpGmc/LTnIZh453vrq0CPixmxJ6TAl/Jc1I4hM5XSP
         ZwuFsPOc2yqPoatC2BLmzUm1uln6QroSLQfvCZd4gTeEefzmBb2FjOZyIze0tKO/fkTc
         lR5w==
X-Gm-Message-State: AJcUuke+OBav3lajEG1VCF+FL0NXhuMIazpMlmj/IxCuJBrj4P7ZirV/
        i9BH4QgPGLBEY/plzJuQfl3OV5iy4lA=
X-Google-Smtp-Source: ALg8bN7sdapplUGwennUI0zvCldkGmAT+CvYvyj6+ERQ1+V3fFnXGEk5fsI6ki/IZovP9P8O8ReddQ==
X-Received: by 2002:aca:53cd:: with SMTP id h196mr562870oib.355.1548319424528;
        Thu, 24 Jan 2019 00:43:44 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id 30sm8969477ots.52.2019.01.24.00.43.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:43:43 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id u16so4540142otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:43 -0800 (PST)
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr3906261otr.299.1548319423408;
 Thu, 24 Jan 2019 00:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org> <20190117162008.25217-10-stanimir.varbanov@linaro.org>
In-Reply-To: <20190117162008.25217-10-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 24 Jan 2019 17:43:31 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUumC2BmWar3yUmVT8vz8x-Nr_tuMc=1VSJvmQYGdPudw@mail.gmail.com>
Message-ID: <CAPBb6MUumC2BmWar3yUmVT8vz8x-Nr_tuMc=1VSJvmQYGdPudw@mail.gmail.com>
Subject: Re: [PATCH 09/10] venus: vdec: allow bigger sizeimage set by clients
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 1:21 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> In most of the cases the client will know better what could be
> the maximum size for compressed data buffers. Change the driver
> to permit the user to set bigger size for the compressed buffer
> but make reasonable sanitation.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 282de21cf2e1..7a9370df7515 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -142,6 +142,7 @@ vdec_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
>         struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
>         struct v4l2_plane_pix_format *pfmt = pixmp->plane_fmt;
>         const struct venus_format *fmt;
> +       u32 szimage;
>
>         memset(pfmt[0].reserved, 0, sizeof(pfmt[0].reserved));
>         memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
> @@ -170,14 +171,18 @@ vdec_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
>         pixmp->num_planes = fmt->num_planes;
>         pixmp->flags = 0;
>
> -       pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> -                                                    pixmp->width,
> -                                                    pixmp->height);
> +       szimage = venus_helper_get_framesz(pixmp->pixelformat, pixmp->width,
> +                                          pixmp->height);
>
> -       if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +       if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> +               pfmt[0].sizeimage = szimage;
>                 pfmt[0].bytesperline = ALIGN(pixmp->width, 128);
> -       else
> +       } else {
> +               pfmt[0].sizeimage = clamp_t(u32, pfmt[0].sizeimage, 0, SZ_4M);
> +               if (szimage > pfmt[0].sizeimage)
> +                       pfmt[0].sizeimage = szimage;

pfmt[0].sizeimage = max(clamp_t(u32, pfmt[0].sizeimage, 0, SZ_4M),
                                        szimage)?

>                 pfmt[0].bytesperline = 0;
> +       }
>
>         return fmt;
>  }
> @@ -275,6 +280,7 @@ static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>                 inst->ycbcr_enc = pixmp->ycbcr_enc;
>                 inst->quantization = pixmp->quantization;
>                 inst->xfer_func = pixmp->xfer_func;
> +               inst->input_buf_size = pixmp->plane_fmt[0].sizeimage;
>         }
>
>         memset(&format, 0, sizeof(format));
> @@ -737,6 +743,8 @@ static int vdec_queue_setup(struct vb2_queue *q,
>                 sizes[0] = venus_helper_get_framesz(inst->fmt_out->pixfmt,
>                                                     inst->out_width,
>                                                     inst->out_height);
> +               if (inst->input_buf_size > sizes[0])
> +                       sizes[0] = inst->input_buf_size;

               sizes[0] = max(venus_helper_get_framesz(inst->fmt_out->pixfmt,
                                                   inst->out_width,
                                                 inst->out_height),
                                      inst->input_buf_size)?



>                 inst->input_buf_size = sizes[0];
>                 *num_buffers = max(*num_buffers, in_num);
>                 inst->num_input_bufs = *num_buffers;
> --
> 2.17.1
>

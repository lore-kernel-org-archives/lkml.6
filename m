Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269E82086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG6KQPPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269E82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeKZUg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:36:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44466 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKZUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:36:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so13808739wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jwAGUSJpReVLkr5hP7nDzH1OIe8/MwJOpl/HUzuKt6U=;
        b=NG6KQPPSnu4bRTA4iasMnrjlWjTm/ikqSDahO+WYfqOpolQSBg0CYTRIb7r91EcaVG
         yKeN4VaaE16JEsOa9PrAF8gl1p7WxYOwtIzsWLvYLI01qpIL3ytS039/6nYl9nR2Tgjw
         gO2QfgbTHLzABXrw7Ltn507r1Q2duZL2op7aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jwAGUSJpReVLkr5hP7nDzH1OIe8/MwJOpl/HUzuKt6U=;
        b=ZlaDU4AdG6yL2xIyIF7kkXutkN6Ec7P0OBoaM9MagA+irF22W6AqJNghSQyCz8g9SJ
         yP7EdwPaNCbxNb4tDvTfUUBqlL+aei2wg8YSIRRCUcLIFurhJsL6m4JR7SLAqmw9h1xC
         H3bUYpP+Qm7m2kxy+qw0hPGD9Ymzna0ox1t9L10pY1WJG6SLY0XP4PbMw5XyI5ojaM+u
         0B1ou64+VLMURuRBkvAih1jM2aie7kwraJ6U+VN/VTPRqixSJQ3gP1dLfLW4z+Uh1mp1
         WcDt1ZvEbTKW5QrA8wpE9XoVKl119/o9U+yuYMaq/Y1k9fZzPcc5R9TcQi1DyFSLXeod
         zZyg==
X-Gm-Message-State: AA+aEWaOez1DW+mlLge+iGckez2jEzoZlwlXBKcrrmMmSVb3a2jGpWEL
        YmZzwnDky+tLna2Q7uaPg8gttA==
X-Google-Smtp-Source: AFSGD/W2V2vGS/tVrZQfnoagA3MyAXOmorjRcgiGzLnuAoU9/chpyzmivqbjjQ9bdxSh+bU+t/KWgQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr11365680wrh.250.1543225402805;
        Mon, 26 Nov 2018 01:43:22 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id r196sm214361wmd.40.2018.11.26.01.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 01:43:21 -0800 (PST)
Subject: Re: [PATCH v2] media: venus: amend buffer size for bitstream plane
To:     Malathi Gottam <mgottam@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1542696783-23016-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <986d29fb-bc31-a6e3-1a10-499bebd8f5f5@linaro.org>
Date:   Mon, 26 Nov 2018 11:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542696783-23016-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

thanks for the patch!

On 11/20/18 8:53 AM, Malathi Gottam wrote:
> Accept the buffer size requested by client and compare it
> against driver calculated size and set the maximum to
> bitstream plane.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index ce85962..ecfdbd6 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -303,6 +303,7 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
>  	struct v4l2_plane_pix_format *pfmt = pixmp->plane_fmt;
>  	const struct venus_format *fmt;
> +	__u32 sizeimage;

please use u32 for kernel internal variables.

Otherwise looks good to me:

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

>  
>  	memset(pfmt[0].reserved, 0, sizeof(pfmt[0].reserved));
>  	memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
> @@ -334,9 +335,10 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  	pixmp->num_planes = fmt->num_planes;
>  	pixmp->flags = 0;
>  
> -	pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> -						     pixmp->width,
> -						     pixmp->height);
> +	sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
> +					     pixmp->width,
> +					     pixmp->height);
> +	pfmt[0].sizeimage = max(ALIGN(pfmt[0].sizeimage, SZ_4K), sizeimage);
>  
>  	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>  		pfmt[0].bytesperline = ALIGN(pixmp->width, 128);
> @@ -408,8 +410,10 @@ static int venc_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>  
>  	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>  		inst->fmt_out = fmt;
> -	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +	else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>  		inst->fmt_cap = fmt;
> +		inst->output_buf_size = pixmp->plane_fmt[0].sizeimage;
> +	}
>  
>  	return 0;
>  }
> @@ -908,6 +912,7 @@ static int venc_queue_setup(struct vb2_queue *q,
>  		sizes[0] = venus_helper_get_framesz(inst->fmt_cap->pixfmt,
>  						    inst->width,
>  						    inst->height);
> +		sizes[0] = max(sizes[0], inst->output_buf_size);
>  		inst->output_buf_size = sizes[0];
>  		break;
>  	default:
> 

-- 
regards,
Stan

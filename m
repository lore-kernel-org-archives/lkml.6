Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F07BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E38E20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJ4kBn+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E38E20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeKZXrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:47:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55464 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeKZXrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:47:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so18047255wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 04:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LctftIN0IH9KwXOdA6CaBuuSTofypnJVmeb0Ubk74FE=;
        b=LJ4kBn+lLlRB3uvnPlhtf/NuLNUwObZ+lRsqsw5h48fovgl3102vk/O2xFAWDN9/U1
         iZEEzvhXiZhFiUEnKSImyui/yAV2828+WHMUKflxxLlrvk7ZWOCwGc1WKPnas93nYFJm
         kmBLilD5YfBp+LYq+Uzfanv86m5mXVN8lbdnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LctftIN0IH9KwXOdA6CaBuuSTofypnJVmeb0Ubk74FE=;
        b=dXxXNK0MebnuiIPAtiT78VSbe0KrxaOmlqOClIrIEEIFleAYXy6K+LVEd/ppzKR1KM
         Dci21x4CGTDvFl4rFMRXdkM+bvJgufEyj5OplR3Jqgvte2mcgNyZWky7SXpNwj4jkBLf
         LGPQGAnQFUilo7Zv/1Osw/I+G7ox5/g91yJf5HrNhhP2BtvklDnYLRwXxJzVRvaHovSk
         EhXcJkHTaym3sb1uYWYTOon1P0dEO207Zke13cs4VkoYzz5tOW2oVMapdvLQYjvE3EUV
         fHhbFr7+cNXkQiPLomIFKC4RSR4+O8a24x18272ve5GcMpYEsq9wNRBYapw8q/a8Z9ke
         k/9Q==
X-Gm-Message-State: AA+aEWbUKTKQnIYGdNCfO6WqS/JXpA0PM6g0ZYWFWi5//5ay4XWMoVUy
        MmkZx6b4aMOCFLhfCITuoYUmOg==
X-Google-Smtp-Source: AFSGD/Ww9uRNhT8gH/5gydzwrHor7ICOfBqynwivPB1gvk5YByT720yoezyb1cNVq23pio6/XGq1PQ==
X-Received: by 2002:a1c:d83:: with SMTP id 125mr16920389wmn.116.1543236790811;
        Mon, 26 Nov 2018 04:53:10 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o81sm947994wmd.10.2018.11.26.04.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 04:53:09 -0800 (PST)
Subject: Re: [PATCH v3] media: venus: amend buffer size for bitstream plane
To:     Malathi Gottam <mgottam@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b55f0011-a6b0-7e12-9525-c0a636ed0432@linaro.org>
Date:   Mon, 26 Nov 2018 14:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Thanks for the patch!

On 11/26/18 12:12 PM, Malathi Gottam wrote:
> Accept the buffer size requested by client and compare it
> against driver calculated size and set the maximum to
> bitstream plane.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index ce85962..e43dd3d 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -303,6 +303,7 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>  	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
>  	struct v4l2_plane_pix_format *pfmt = pixmp->plane_fmt;
>  	const struct venus_format *fmt;
> +	u32 sizeimage;
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

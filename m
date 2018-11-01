Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24FAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E8C2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYaHWFbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E8C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeKAVk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:40:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35506 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbeKAVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:40:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id z16-v6so2038809wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q5lswyodOMjqPgoCH0kHtwsx/mpC876GHRYElJ66Q78=;
        b=HYaHWFbn+fStUCHTYUt0OOnrY3rLQo9dao4QXxtRxO4QnWnSsp2V52ywqiy61luXKp
         PcjWB1E/pyvxcezZSf06T3Hpm+t/lfE+LP1xPOFrNhCRDNv5TlM+wzjfNEYnBGgLs2FA
         IT/iA7HzPmEge0s00eEXc2xRXvWsMEcbygkvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q5lswyodOMjqPgoCH0kHtwsx/mpC876GHRYElJ66Q78=;
        b=GeYpW+2EMv5XynSl5AO6J4e1sLDKAYnP32SuNxH8NoGPV/BlsVv9oK5YEk/2D8Zu/h
         fr7TCXsLJmYlmRNB6ajixKFYT5xkN3rXqQikO4tft8LewIcnAiXksKugv5H5AGtL32Hm
         mU6hMxRFXnmSx+ZPYBg9Y7rEdgAYNrBZEuP9IUCoh/NEi137i2mtD3scA8ke867HcMdJ
         aNwLYR9NHq8zQDZbG8a/qPDplbZRx+uzaztlQLtNXHHmrToMRplNojujCmL2cI2sYSZm
         ZCFNmo4fvTQL89lgo5zHK4srtSVbkWdRlTv5YfGnU5EAa0buOKdqGEbbpuLJNHa7moI0
         /tgw==
X-Gm-Message-State: AGRZ1gJA1HW6380mC2rDgjFWFDXZvj94SQRSUGYQeZoG9U9c5d39cI8W
        vaxScBhDKcjyUg2Xy1dgKPobmg==
X-Google-Smtp-Source: AJdET5eTAPTil2Kal5n5yHqYXimCl9hz1PXhl9G9PrVRSXh250D02KsB16UbnsJ28yDvzcbSwUSiFQ==
X-Received: by 2002:adf:83a4:: with SMTP id 33-v6mr6288585wre.13.1541075886665;
        Thu, 01 Nov 2018 05:38:06 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id m2-v6sm25059617wrj.80.2018.11.01.05.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:38:05 -0700 (PDT)
Subject: Re: [PATCH] media: venus: add support for USERPTR to queue
To:     Malathi Gottam <mgottam@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1539071557-1500-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <eef03e29-0057-0101-6188-f91715a9eb06@linaro.org>
Date:   Thu, 1 Nov 2018 14:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539071557-1500-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Thanks for the patch!

On 10/9/18 10:52 AM, Malathi Gottam wrote:
> Add USERPTR to queue access methods by adding this
> support to io_modes on both the planes.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 754c19a..b86994c 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1096,7 +1096,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>  	int ret;
>  
>  	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> -	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +	src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
>  	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	src_vq->ops = &venc_vb2_ops;
>  	src_vq->mem_ops = &vb2_dma_sg_memops;
> @@ -1112,7 +1112,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
>  		return ret;
>  
>  	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> -	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> +	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
>  	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>  	dst_vq->ops = &venc_vb2_ops;
>  	dst_vq->mem_ops = &vb2_dma_sg_memops;
> 

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan

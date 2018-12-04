Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB36C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A790D20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTXkq8vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A790D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLDUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:21:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52727 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:21:48 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so17634620iti.2;
        Tue, 04 Dec 2018 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sE5QIdCwlHZodoyWz/2AASxLZxGSkRr6fPg+cim71HY=;
        b=oTXkq8vWtwVKp/2ca5frpM2+0Y2ThcUJnviM0V1cGM+68GZBmATKywfpydMXuVZ41O
         bKPb+zBWpeo7yAgGe75M5MsPDO5omt/EwDc/LhKeQwknx+KlnfJ2N0dI0fuUvaZmggt/
         aRpVio1G3i+Bix9v/+qtz1dGAuxT+T2cdigdiyljzhoVdctJjDgDj1rk4f8fj5IPMy0v
         D+IPX6pSIz8f2YtugLDwdEIMq4rzXvZtRhMpTmaA8+kq7NC1lZe5v9B/8jtImUTpjDDG
         knEjjiAgLEDMms5osX0uMne0r/4Tu6clxIzPY6ndyGb71M2i8904WwSYa5aXhFn/LxlT
         bFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sE5QIdCwlHZodoyWz/2AASxLZxGSkRr6fPg+cim71HY=;
        b=UckbIUOTsjhNTOrZ6wiMee4moVK2UhlEHf5wXb8Xk52Z1ZjBzCrIMs3z1pEnSp8k4H
         uimxBwLX56KLx6DLph9OrTzmMZ1QpDS6r5uirY6ptEa9d5WSEqJoncgURRO0u5AH/PBK
         +Wk/uo9GDwDiI2rkEbncBjQh/jgAqjAj/WpYJ1Ref/h2f6wuq1/4OThoNxdtahPW9o+W
         FJvnWHVMRrNKz/hmjDEuGYLjRz1Vc1PbVR5ti6PTY7Gp9QT4rV0bsfAZVgP0ODOOjGa7
         ZpUUQtU1quqMcKy0KTwn1LEhha3c2obVXhJsIIBavXrZYBoknn1C1vkxWD55LJEa+j4m
         zHTg==
X-Gm-Message-State: AA+aEWZ4ZuRqNzGFk7chZ9EczBCQRjCxCQGTSM4Y17sr48BI3G8VliBl
        3gBLC691lMszXNaAeBaUNRINEve02HikZyQroo8=
X-Google-Smtp-Source: AFSGD/WXH8ujjh18r5cpBnhi+Tl9d8YtagAP6wp534BOYsVTeKHCAz0YkVVxvN03S371Y/XXCZMStk/U61r/huLA9Ss=
X-Received: by 2002:a24:5314:: with SMTP id n20mr12051408itb.132.1543954907130;
 Tue, 04 Dec 2018 12:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20181204165604.19462-1-robert.foss@collabora.com>
In-Reply-To: <20181204165604.19462-1-robert.foss@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 4 Dec 2018 15:21:35 -0500
Message-ID: <CAF6AEGt+SJPoTChr=zn+g8Vth_F_D39EmWGXpo3qbsUgL=638A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] drm/msm: Move fence put to where failure occurs
To:     Robert Foss <robert.foss@collabora.com>
Cc:     David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:56 AM Robert Foss <robert.foss@collabora.com> wrote:
>
> If dma_fence_wait fails to wait for a supplied in-fence in
> msm_ioctl_gem_submit, make sure we release that in-fence.
>
> Also remove this dma_fence_put() from the 'out' label.
>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: stable@vger.kernel.org

Fyi, this is queued up in msm-next/fixes

BR,
-R


> ---
>  drivers/gpu/drm/msm/msm_gem_submit.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index a90aedd6883a..d5e6665a4c8f 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -411,7 +411,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>         struct msm_file_private *ctx = file->driver_priv;
>         struct msm_gem_submit *submit;
>         struct msm_gpu *gpu = priv->gpu;
> -       struct dma_fence *in_fence = NULL;
>         struct sync_file *sync_file = NULL;
>         struct msm_gpu_submitqueue *queue;
>         struct msm_ringbuffer *ring;
> @@ -444,6 +443,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>         ring = gpu->rb[queue->prio];
>
>         if (args->flags & MSM_SUBMIT_FENCE_FD_IN) {
> +               struct dma_fence *in_fence;
> +
>                 in_fence = sync_file_get_fence(args->fence_fd);
>
>                 if (!in_fence)
> @@ -453,11 +454,13 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>                  * Wait if the fence is from a foreign context, or if the fence
>                  * array contains any fence from a foreign context.
>                  */
> -               if (!dma_fence_match_context(in_fence, ring->fctx->context)) {
> +               ret = 0;
> +               if (!dma_fence_match_context(in_fence, ring->fctx->context))
>                         ret = dma_fence_wait(in_fence, true);
> -                       if (ret)
> -                               return ret;
> -               }
> +
> +               dma_fence_put(in_fence);
> +               if (ret)
> +                       return ret;
>         }
>
>         ret = mutex_lock_interruptible(&dev->struct_mutex);
> @@ -583,8 +586,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>         }
>
>  out:
> -       if (in_fence)
> -               dma_fence_put(in_fence);
>         submit_cleanup(submit);
>         if (ret)
>                 msm_gem_submit_free(submit);
> --
> 2.17.1
>

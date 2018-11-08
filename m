Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F624ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD2E206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsp/oxd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD2E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKIGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:10:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41653 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeKIGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:10:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id v18-v6so3355828wrt.8;
        Thu, 08 Nov 2018 12:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUyckdV6468wco59uAlOjG0UpyoPTEzPWCvVczTvD+E=;
        b=Gsp/oxd9Qt+0W8ZABMcu4IJu14TkVKfwLFi0SwaPRA0eXsocT2DIC7vg8hy+6fqWUG
         xHNRSvv5N6FYLKeJYbPY3nnlLgP4oDmUKbRo3eG2wC/6gY0rPDZrnfby+iJHavdfrCu4
         eJ/SWRjnReVyjs3FRe89HwgmUbvpk5EVU3gYbn6pBzBeArEm55XHw+AFHgJWm49TPAE6
         eW+3aY1FqDDxctNDXiCApFebVFwMOD+gus2BaX/mYtHBykbL09Rj6UWf/254b4AUkm5Y
         mFLQ8723z9KT6FMrQzvvXDuFlwSM5esoudefFHuSkiO+hiF1AX8HbdstYD+LzrN0IVH6
         rtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUyckdV6468wco59uAlOjG0UpyoPTEzPWCvVczTvD+E=;
        b=ZuppD4LdK7jaVU5gqYDyaQECISTd36lvbP0oK1H6ysVmMHQYQCERgLr/d0UYBVt8RR
         5PRAp31pDv89r6atIAofOI1Kxiae4TLgd+OcVMsXoc0Vpm2q/jcJYBrqoRz5fq1Z2D5J
         QFa/Dm9S3RYFCWQcWFgo3pp5Pn1rMlq5dDjhdveZLlXF17iHe2i7jrW+1HW6RO+N/D3X
         EfCGcsgiWT0SgnvMwWb03TbgZYE+/HNRfnSc31QGyTsX9AKjntgI2QOJTudeR8UYmuA8
         1jC6b1CVzHEM8E/cLJ0ibTMklCLmmVV8LrgRObWDwVCPaiUvqEujnxPHKdujR8m8iphR
         X9YQ==
X-Gm-Message-State: AGRZ1gLqLMFUpx/gqxKrUK23Z+vRhajSY14jOUpU21hyA8X9OBJbexT+
        Cav9kOETH4M5kljE3XdRIYX1x5/Vw7uS3bniQUkz9w==
X-Google-Smtp-Source: AJdET5fUP52Id2xqDydk1mHWOINpxkKWnNjix6AsQoH70WAc7wQ32HKpzhkdNv1MmpxKX4JVlL2Ua5W/Wf89lPSCA7g=
X-Received: by 2002:adf:ee47:: with SMTP id w7-v6mr5024979wro.173.1541709220322;
 Thu, 08 Nov 2018 12:33:40 -0800 (PST)
MIME-Version: 1.0
References: <1541678023-143862-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1541678023-143862-1-git-send-email-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Nov 2018 15:33:26 -0500
Message-ID: <CADnq5_NrRBH_2jNqJq-vQoSraPNvfihFDuyLTK3erR_W=qyUzw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/radeon: remove set but not used variable 'rdev'
To:     yuehaibing@huawei.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 9:04 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> From: Yue Haibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/radeon/radeon_object.c: In function 'radeon_bo_unref':
> drivers/gpu/drm/radeon/radeon_object.c:317:24: warning:
>  variable 'rdev' set but not used [-Wunused-but-set-variable]
>
> It not used  any more after commit
>   e7e31600d3e2 ("drm/radeon: remove taking mclk_lock from radeon_bo_unref")
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_object.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
> index ba2fd29..c4b2e14 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -314,11 +314,9 @@ struct radeon_bo *radeon_bo_ref(struct radeon_bo *bo)
>  void radeon_bo_unref(struct radeon_bo **bo)
>  {
>         struct ttm_buffer_object *tbo;
> -       struct radeon_device *rdev;
>
>         if ((*bo) == NULL)
>                 return;
> -       rdev = (*bo)->rdev;
>         tbo = &((*bo)->tbo);
>         ttm_bo_put(tbo);
>         *bo = NULL;
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

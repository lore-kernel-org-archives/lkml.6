Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D88DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327112087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TzjRTYf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327112087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeLCRos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:44:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33731 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLCRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:44:48 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so9013451itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vePMyb35njo9Q/1fS/MXk3qMdTWSgBmpTI6xzm1xoLQ=;
        b=TzjRTYf+0tBx/0onTmsLwawNJwOGyF4gTOBBs/OmbaB6SIfH2nspeqWpJdjgTKYBZ/
         3MsloZQVyvkBMy/WO7+6ymJY8Yz7I4ha+x57MuBcnAomwpJ6oeRJHxMnQoY0R8Ny0UFo
         yjQdCVazdtq6+8gsJkPObIKx1Oxf+iNNaLPhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vePMyb35njo9Q/1fS/MXk3qMdTWSgBmpTI6xzm1xoLQ=;
        b=Id7zjW8ql3WKg7382B91t4ih/g54l8SUDQ4l8ArU+28iq4Q5RJfOss8iGusmESdhBu
         PilD765hgTVHAxCC/1gCc/VsK2Hc9KB3TrSf4Iba4ep3E4JoeCnlGE9FBjc/SnH3DRV4
         TDYF41dh1D6KJPO4ssd1AbTi6r0aeTHLFzqm88LIyJLvNFqcw3U9U1LqmIq8SRsWP3EM
         umaOKn0Fj+/xMfCXAzt3bjfK/ozcz4ZVa0bT5dSjib5iA6qIG9kizy83j3ICymdusVXP
         ukX6tEfn3XrELHjOR8/OhRsa6tMnDJoWb2hkqWU5FfADtegZdlpHaKtYhyj379iD213c
         lppg==
X-Gm-Message-State: AA+aEWZLFKz3o3LaH3i9Oq3Z3tStNQetQUh8/UvYEv24Pw+cSuYbu2YK
        wjBPgRMge3dz5jS0r3DksKxgghdbT3S2xQizh/jALA==
X-Google-Smtp-Source: AFSGD/Xqb+8VI0yXXP3POQxnjWijfhuC/fSRnap/bfwZyBZN1A4soQ1THtosMW2ZOmRDDPCsKLpyQWIxqbRsyYBXaO8=
X-Received: by 2002:a24:4e0d:: with SMTP id r13mr8237884ita.140.1543859085591;
 Mon, 03 Dec 2018 09:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20181201005759.28093-1-eric@anholt.net> <20181201005759.28093-2-eric@anholt.net>
In-Reply-To: <20181201005759.28093-2-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Mon, 3 Dec 2018 17:44:34 +0000
Message-ID: <CAApk1dWzDOXqyUegibhjMYam-7k5Rn5KLRaYHrxu3mCeHRaznA@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/v3d: Drop unused v3d_flush_caches().
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be needed for the CSD, which does not have a way to clean the
L1T/L2T before reporting completion.
In any case it's unused now, so I don't see a problem with removing it.

On Sat, 1 Dec 2018 at 00:58, Eric Anholt <eric@anholt.net> wrote:
>
> Now that I've specified how the end-of-pipeline flushing should work,
> we're never going to use this function.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.h |  1 -
>  drivers/gpu/drm/v3d/v3d_gem.c | 21 ---------------------
>  2 files changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index bcd3d567bec2..239b56d76f3e 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -314,7 +314,6 @@ void v3d_exec_put(struct v3d_exec_info *exec);
>  void v3d_tfu_job_put(struct v3d_tfu_job *exec);
>  void v3d_reset(struct v3d_dev *v3d);
>  void v3d_invalidate_caches(struct v3d_dev *v3d);
> -void v3d_flush_caches(struct v3d_dev *v3d);
>
>  /* v3d_irq.c */
>  void v3d_irq_init(struct v3d_dev *v3d);
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 8b4af512450f..34103205b7cb 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -175,20 +175,6 @@ v3d_invalidate_slices(struct v3d_dev *v3d, int core)
>                        V3D_SET_FIELD(0xf, V3D_SLCACTL_ICC));
>  }
>
> -/* Invalidates texture L2 cachelines */
> -static void
> -v3d_invalidate_l2t(struct v3d_dev *v3d, int core)
> -{
> -       V3D_CORE_WRITE(core,
> -                      V3D_CTL_L2TCACTL,
> -                      V3D_L2TCACTL_L2TFLS |
> -                      V3D_SET_FIELD(V3D_L2TCACTL_FLM_CLEAR, V3D_L2TCACTL_FLM));
> -       if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
> -                      V3D_L2TCACTL_L2TFLS), 100)) {
> -               DRM_ERROR("Timeout waiting for L2T invalidate\n");
> -       }
> -}
> -
>  void
>  v3d_invalidate_caches(struct v3d_dev *v3d)
>  {
> @@ -199,13 +185,6 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
>         v3d_flush_l2t(v3d, 0);
>  }
>
> -void
> -v3d_flush_caches(struct v3d_dev *v3d)
> -{
> -       v3d_invalidate_l1td(v3d, 0);
> -       v3d_invalidate_l2t(v3d, 0);
> -}
> -
>  static void
>  v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
>                          struct dma_fence *fence)
> --
> 2.20.0.rc1
>

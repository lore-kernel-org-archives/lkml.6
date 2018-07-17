Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DAAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2312205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEmaxgeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2312205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGQQts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:49:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeGQQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:49:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so1846741wrp.0;
        Tue, 17 Jul 2018 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wJeVfkqlzMDDKWZVno6QTkyJFyg4jcZ53Mrg3Ri8GGQ=;
        b=NEmaxgeAxG+tn8X4JdqOdUbVbXG/p6QHTlg6aW9DEYSGUZLeek50OgLa//spmPuMEd
         uzJnaR6k4XLaRLTjG9jJ7mhkOvQgw/IeklbSUFiFAoI5UO3W1iNtdT7WV3GUBFCWTr/8
         Hmp+jo9rSyIviCjolpoHqJKGa6L2s6zdeKrpPkWJY6BRD8xfqmXJFRYbOULt6Zuh2yrg
         61l2NDzVyn2XJl4Y+DXzr8EmxL1lWquUt5cQ6y3ff7Vr+PHgE1IO5UT6dgvS65bQnQU7
         TNjeV54jsNBZl0cjD81QCiKmhKuz4JhBY47+QqqO3/17bAKGHfARuk1VJwYswdkZbicj
         iYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wJeVfkqlzMDDKWZVno6QTkyJFyg4jcZ53Mrg3Ri8GGQ=;
        b=MJ0aP3BLQaEGqC2QmZNMBOPvC5mFNcAkxL2ylq8mKZ59pgchCeofDvGBENAw4CfY5y
         GHlwcde0MCOnSdIWcyM++CwznMDChCAV4Poz4oDRrH6FQl92P461/tB51xohJY31CBi0
         GZwVh96J0iJXZq1aayYxiwYW5yAaH/sbYJdzgF4rYuwCiusBYaCVcOqFfnRgfOvQ/aiT
         8UAyR6SR3F3wX4XSdrW4fynK1t7oqTquOyit3jV6omnPKdtYuBkWdOd+YIhfOy9sI7bW
         hefbTwIJpPwRku38DJV76BVvrtZo+arjLWKvNHMOviHa6AcdSuOBa6vL3iAzVT3Z5TqV
         PDjA==
X-Gm-Message-State: AOUpUlHVbGjFxTtcC/2hIS1jaVAPx67pmcCv0YmuQZM+URXh3ww3Z6Pu
        ReQ5b9HzTleBqTNREE+mE4G+x9Lr8x8bUjLE7IM=
X-Google-Smtp-Source: AAOMgpdiSlwub4TCp9kc7I2C5MTJYyOeKNwwvRlZpB5FYf7Y7vOAKEYbay+hmbA2plQilQ0epKG2d+ojnFQId4LnIFs=
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr1979398wri.139.1531844182802;
 Tue, 17 Jul 2018 09:16:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9563:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 09:16:22
 -0700 (PDT)
In-Reply-To: <20180717092929.19311-1-colin.king@canonical.com>
References: <20180717092929.19311-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 Jul 2018 12:16:22 -0400
Message-ID: <CADnq5_OfYsDNBETcKAL6QZRn=xPSsa-c8FTkjif+N2-5+Q=nWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "successed" -> "succeeded"
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 5:29 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in dev_err error message.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9883fa9bb41b..e9feb3c58389 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2004,7 +2004,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>                                 continue;
>
>                         r = block->version->funcs->hw_init(adev);
> -                       DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"successed");
> +                       DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
>                         if (r)
>                                 return r;
>                 }
> @@ -2039,7 +2039,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>                                 continue;
>
>                         r = block->version->funcs->hw_init(adev);
> -                       DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"successed");
> +                       DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
>                         if (r)
>                                 return r;
>                 }
> @@ -3092,7 +3092,7 @@ static int amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
>   * @adev: amdgpu device pointer
>   *
>   * attempt to do soft-reset or full-reset and reinitialize Asic
> - * return 0 means successed otherwise failed
> + * return 0 means succeeded otherwise failed
>   */
>  static int amdgpu_device_reset(struct amdgpu_device *adev)
>  {
> @@ -3170,7 +3170,7 @@ static int amdgpu_device_reset(struct amdgpu_device *adev)
>   * @from_hypervisor: request from hypervisor
>   *
>   * do VF FLR and reinitialize Asic
> - * return 0 means successed otherwise failed
> + * return 0 means succeeded otherwise failed
>   */
>  static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>                                      bool from_hypervisor)
> @@ -3295,7 +3295,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 dev_info(adev->dev, "GPU reset(%d) failed\n", atomic_read(&adev->gpu_reset_counter));
>                 amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
>         } else {
> -               dev_info(adev->dev, "GPU reset(%d) successed!\n",atomic_read(&adev->gpu_reset_counter));
> +               dev_info(adev->dev, "GPU reset(%d) succeeded!\n",atomic_read(&adev->gpu_reset_counter));
>         }
>
>         amdgpu_vf_error_trans_all(adev);
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeA3JYV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:24:21 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50694 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeA3JYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:24:17 -0500
X-Google-Smtp-Source: AH8x226y4P6tA7M2EbO0jhWc7sMMtIIlilX0ivBGIOpkBsr6UXPm9gTfSEVxrD2iIQR8d+YCluth1g==
Date: Tue, 30 Jan 2018 10:24:13 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Christian.Koenig@amd.com
Subject: Re: [PATCH 4/4] drm/amdgpu: Use drm_oom_badness for amdgpu.
Message-ID: <20180130092413.GD25930@phenom.ffwll.local>
Mail-Followup-To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Christian.Koenig@amd.com
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <1516294072-17841-5-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516294072-17841-5-git-send-email-andrey.grodzovsky@amd.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2018 at 11:47:52AM -0500, Andrey Grodzovsky wrote:
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 46a0c93..6a733cdc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -828,6 +828,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = amdgpu_kms_compat_ioctl,
>  #endif
> +	.oom_file_badness = drm_oom_badness,

Would be neat if we could roll this out for all gem drivers (once it's no
longer an RFC ofc).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

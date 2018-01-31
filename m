Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeAaIHe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:07:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54941 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeAaIHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:07:32 -0500
X-Google-Smtp-Source: AH8x225kzTaAGKoxhtMDrJqu3+oeCJflltc+2F4HPJNiFxsaCNLySFn0gn3jIHdzDFix0bZb3ATLKQ==
Date: Wed, 31 Jan 2018 09:07:28 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Print the pid when debug logging an ioctl error.
Message-ID: <20180131080728.GV25930@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180130215643.11016-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130215643.11016-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 01:56:43PM -0800, Eric Anholt wrote:
> When we debug print what ioctl we're calling into, we include the pid.
> If you have multiple processes rendering simulataneously, the error
> return also needs the pid so you can see which of the ioctl calls was
> the one to fail.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index a9ae6dd2d593..38c302607738 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -842,7 +842,7 @@ long drm_ioctl(struct file *filp,
>  	if (kdata != stack_kdata)
>  		kfree(kdata);
>  	if (retcode)
> -		DRM_DEBUG("ret = %d\n", retcode);
> +		DRM_DEBUG("pid=%d, ret = %d\n", task_pid_nr(current), retcode);
>  	return retcode;
>  }
>  EXPORT_SYMBOL(drm_ioctl);
> -- 
> 2.15.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

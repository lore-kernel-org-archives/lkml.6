Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeBSJoD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:44:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40468 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeBSJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:44:01 -0500
X-Google-Smtp-Source: AH8x226xdd5z3mijyR/DJxTwZo+E6N5nmUQzKHn8VE9FZsJ/7ye4185CQVGumLKwFi502UsIjw8UoA==
Date: Mon, 19 Feb 2018 10:43:57 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Colin King <colin.king@canonical.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bochs: make structure bochs_bo_driver static
Message-ID: <20180219094357.GL22199@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180207111353.30261-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207111353.30261-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 11:13:53AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The structure bochs_bo_driver is local to the source and does not need to
> be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/gpu/drm/bochs/bochs_mm.c:197:22: warning: symbol 'bochs_bo_driver'
> was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/gpu/drm/bochs/bochs_mm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index 704e879711e4..b1d5aee46316 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -194,7 +194,7 @@ static struct ttm_tt *bochs_ttm_tt_create(struct ttm_bo_device *bdev,
>  	return tt;
>  }
>  
> -struct ttm_bo_driver bochs_bo_driver = {
> +static struct ttm_bo_driver bochs_bo_driver = {
>  	.ttm_tt_create = bochs_ttm_tt_create,
>  	.ttm_tt_populate = ttm_pool_populate,
>  	.ttm_tt_unpopulate = ttm_pool_unpopulate,
> -- 
> 2.15.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

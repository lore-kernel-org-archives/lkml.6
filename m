Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbeEaTbP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:31:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52230 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754067AbeEaTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:31:13 -0400
X-Google-Smtp-Source: ADUXVKLMa6AIrbJE2YDBkDhTbsI84dmmkDXgn1lHrzMeOrXMVzi1f+OFzcByhYf8Dr3qNmFeTqWYIDB/2UdZSKr/DBU=
MIME-Version: 1.0
In-Reply-To: <20180530164144.21526-1-colin.king@canonical.com>
References: <20180530164144.21526-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 May 2018 15:31:11 -0400
Message-ID: <CADnq5_OHuFW+5w+p3=2=D2Yaevf_hyT1MSdc9Q6dJdMS=WGDcA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu/df: fix potential array out-of-bounds read
To: Colin King <colin.king@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:41 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The comparison with the number of elements in array df_v3_7_channel_number
> is off-by-one and can produce an array out-of-bounds read if
> fb_channel_number is equal to the number of elements of the array. Fix
> this by changing the comparison to >= instead of >.
>
> Detected by CoverityScan, CID#1469489 ("Out-of-bounds read")
>
> Fixes: 13b581502d51 ("drm/amdgpu/df: implement df v3_6 callback functions (v2)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 60608b3df881..d5ebe566809b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -64,7 +64,7 @@ static u32 df_v3_6_get_hbm_channel_number(struct amdgpu_device *adev)
>         int fb_channel_number;
>
>         fb_channel_number = adev->df_funcs->get_fb_channel_number(adev);
> -       if (fb_channel_number > ARRAY_SIZE(df_v3_6_channel_number))
> +       if (fb_channel_number >= ARRAY_SIZE(df_v3_6_channel_number))
>                 fb_channel_number = 0;
>
>         return df_v3_6_channel_number[fb_channel_number];
> --
> 2.17.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

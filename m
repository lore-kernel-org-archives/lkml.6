Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAD9206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stp8Ca+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfAPWEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:04:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56106 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbfAPWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:04:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so3677891wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOxVuc5LMQHFxfouqC9cbGJtkIdS/u3Tkh9TMygSuOA=;
        b=stp8Ca+52UX+7x8ZS5uwLsaMMcXzQiwaCUMOLbqLfZMJh3XUiiXcoLmm5VqLWir+G2
         PzwoSLkU0xMsTHa7YyXIDeMP9K5XQ4u8nYyjzqKTHs0BxtoE2Bxm5hjQJST5D6cnVIeD
         epvTKL/toSkfVNLdHLqc+o1ppZ+j/zbcU0Rrf+Di5LFqcjaX0EINT0+gk5Udgy8IBBsX
         eoSLdx/uDJZAw3XEZZDM3+oUBeWa0VkJQd3ezYh6bf7+WRZqVwhW2Cok9Ann5FAeiloQ
         nQ4tjkRyxF4ITKIeuUi4HhknfNA4j7mM1qTqj9wlvluxBKGBiIxfplfFybYHQ9xHFs8+
         N99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOxVuc5LMQHFxfouqC9cbGJtkIdS/u3Tkh9TMygSuOA=;
        b=FTscD6rwf92V3Kj2fr+3EXnU9vL99xzVs98bQQzQVNof68SE8BZsY4yzHAbVgXEQhg
         jchn+s/DfxQbq28Ayh24a1VmrrgThIX8Mo68ssemboZD+B/rE19aNmamlaEAO+raPqPc
         +ty/LVf/r+XQwLPSxFxHRnu0eLz+PhXaeVDqMugC/ae6iyMMDamMs0ZR6xHUxaqtaB+T
         6IiI4t4HGWJlRJ6SGF0RHNOmA3+VuqI+FvlJpekiB6xW3V2tN5pan+u6pgL2zvTamYgA
         HRb0XADft6e92jqeZte2Km7fJ5Te4l8dgf577bem081xQJXn1EkBV/k8SZ5SX7m3meEF
         37og==
X-Gm-Message-State: AJcUukf5a5nfuzkL4cv8a+Nn83Cl/cg1IZzy0lXZhc9aLES9/ZMVGMfm
        Z9BivpzBnaPmJK9EbVVHdtNU/gAVLR1IvN5GO2/VdGsP
X-Google-Smtp-Source: ALg8bN420dPAoazQt+6/GAWU3IsXcX/m6GfAowJCifI7FPSdnCuZnSt/sNYZWqMlyN1wMiucQI0Zh5UrL5BvxjzFGhI=
X-Received: by 2002:a1c:47:: with SMTP id 68mr8761742wma.89.1547676258217;
 Wed, 16 Jan 2019 14:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20190115052202.GA8537@embeddedor>
In-Reply-To: <20190115052202.GA8537@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 16 Jan 2019 17:04:06 -0500
Message-ID: <CADnq5_M7rkXD704Wd4GoeLx5mPukqtBfT_PmYu3aWGHJGXeebg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace kzalloc with kcalloc
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 2:58 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Replace kzalloc() function with its 2-factor argument form, kcalloc().
>
> This patch replaces cases of:
>
>         kzalloc(a * b, gfp)
>
> with:
>         kcalloc(a, b, gfp)
>
> Also, improve the coding style and the use of sizeof during
> allocation by changing sizeof(struct dc_surface_update) and
> sizeof(struct dc_plane_state) to sizeof(*updates) and
> sizeof(*surfaces), correspondingly.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a3e65e457348..4c201de38329 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5782,11 +5782,14 @@ dm_determine_update_type_for_commit(struct dc *dc,
>         struct dm_crtc_state *new_dm_crtc_state, *old_dm_crtc_state;
>         struct dc_stream_status *status = NULL;
>
> -       struct dc_surface_update *updates = kzalloc(MAX_SURFACES * sizeof(struct dc_surface_update), GFP_KERNEL);
> -       struct dc_plane_state *surface = kzalloc(MAX_SURFACES * sizeof(struct dc_plane_state), GFP_KERNEL);
> +       struct dc_surface_update *updates;
> +       struct dc_plane_state *surface;
>         struct dc_stream_update stream_update;
>         enum surface_update_type update_type = UPDATE_TYPE_FAST;
>
> +       updates = kcalloc(MAX_SURFACES, sizeof(*updates), GFP_KERNEL);
> +       surface = kcalloc(MAX_SURFACES, sizeof(*surface), GFP_KERNEL);
> +
>         if (!updates || !surface) {
>                 DRM_ERROR("Plane or surface update failed to allocate");
>                 /* Set type to FULL to avoid crashing in DC*/
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

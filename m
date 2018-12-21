Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD40C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687321908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehpCOr9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbeLUMgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:36:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41934 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeLUMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:36:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so3798305lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 04:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwvx7uSOhKtXGy/ganBgMM+fixWD0qDglwsUDXDSPJU=;
        b=ehpCOr9egMAdG/KUuWITMUrSuatVdvtsVcxnueN/SkX0GkmhIQkuxvIewAvcQvtZIF
         HMA81+CVOBx8kfQ8NMfffFmUZ+5SomyeMYbMT8+uKUNFAnCx42h/ok+Q3IPaPknWjuaX
         Q1x5NvYeQzQwniSAU2Y05RCRyTedLmPj+KKiE0C0YOM4F+YsghYC2MFyUJmh5yvTiyFw
         e/R+bLDVytWAkA/RZDycnzTLoQkOitlbw9SHuVEVHdNK7hIFsqQjsUA8KWzG/r2PxIEd
         dE/bKiuSV5c7MLnHEEtD3NPNr9Hhy2nPves55Ya/8yuq/4GpC/LdCxYbeFfXQW/+bNKJ
         y8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwvx7uSOhKtXGy/ganBgMM+fixWD0qDglwsUDXDSPJU=;
        b=AC7MT8U841PsHAdTYmI6QvjC5CXaVb0jVQO8wqyzcw9CP5y2hcFQIP25vHnnbuUQ9Z
         KUy3Pz7ay7o6STeVTekeLumQmirfeynPwCGS6loPsrW7dfGGQkwGOirCKUr/dueetSjm
         yG7RqIrK9Nv4fU57+rkcbXkAnXd7v2KBihd3Xd2I4IGPYTp4gKdPTZ07WsYtYSD6JFg9
         ccj5IjxgdG3Q69KZ7umA4QJQZYwzPicGAm1hTe0k3Sg4Uww+0t56mNQ/4LkOxubLAfcG
         0CgT0k4ZwiX6ymhMFM5tnlgypf4jt93OAK/VOwMFuhgNWGsQY7HBvdDD9Zpf4YIgBEp/
         /Fug==
X-Gm-Message-State: AA+aEWYzJ19p37L5pZg45VdYcjUCjSdj/AmNLDjXssP9YMjTOYrLSpTG
        YUMpORTvPBISQ5RB/cUDex/wLanlgRBHXF4kggg=
X-Google-Smtp-Source: AFSGD/VoDSA0EJwlfEjmM63tyv+Aqa0EM6kwaFwYUh0mRcRfMTG7ONu6x+BHctvuL1pd15XJvZAJfyspXxnlAC7pveU=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr1389795lfb.72.1545395762566;
 Fri, 21 Dec 2018 04:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 21 Dec 2018 18:05:49 +0530
Message-ID: <CAFqt6zbRVuJ2=5nMb1S3am86tPE6117cSU32Rtyrwf8Ajk_Xrg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     rex.zhu@amd.com, evan.quan@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, airlied@linux.ie,
        Hawking.Zhang@amd.com, ray.huang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 2:49 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove hwmgr_ppt.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> index e5a60aa44b5d..07d180ce4d18 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -28,7 +28,6 @@
>  #include "hardwaremanager.h"
>  #include "hwmgr_ppt.h"
>  #include "ppatomctrl.h"
> -#include "hwmgr_ppt.h"
>  #include "power_state.h"
>  #include "smu_helper.h"
>
> --
> 2.17.1
>

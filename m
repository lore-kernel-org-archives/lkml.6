Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E661C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF67C20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V19hKMoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF67C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeKTFod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:44:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35971 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKTFod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:44:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so3078263wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyVQd7Zu55XoxKk2eazLcdZEj1oLXx5+jhm9Tt2Spgw=;
        b=V19hKMoJKzrxASiERUlf7wFMVaWlXo07BFUxbhH5zuk6UY8yekzoDG02B+uFcciRQj
         TvJ2uBTqD3dsEWtepd+2qlkbfJw1dphs5HnNsMpO1oDXLlyJPwIZkUTLPoKwCD0lqzqs
         USYtjToDAvZyDGzV6JpUCLOcr19xxPEXQE7WCC2v5dkUQi7aEMiQ7TCR3/EJY4AFHACj
         DDrkghQ+w1y4+ELz+HKT24lyuv0a87JycnNL+dtLAFl7fU0qhuVHEkRyDrv1kPepNVS3
         WN1rbxj0VYHZ+/aVA2IvQ64VknYcEWY1ZPth+7iKf5cpkg3s66ob+uPDheFxC0Wrz03W
         rEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyVQd7Zu55XoxKk2eazLcdZEj1oLXx5+jhm9Tt2Spgw=;
        b=XK+6CtMsx0Ubd++bmeS5BG4RDazAJ2slJAHy7eIlXLDsgH8Fb21tdhDJoQUGQJpooA
         9YMdn+7JeQteH2bOyXIkXIxcUCIM9gBa8JIMyIwri/Rw3HnC0G0G9hMlnIpuAczgmoic
         DMF3XhuORRw1QU2gEnppGoeh0OH1NpEM6cb8iQUdDIAXxr6MLtj3fPamNifkIOwo4KNq
         rBc1dyIzEyVTFObcNFG7a6ik6+UyP26Uv2Pwzi9BoYrDCpHf0rRTb8FyqpJQ1+B3LXhL
         7G2S9z0gcnayQMuDoRQSA3upNl38/KH4WJo8sQFefp1Uofq33RzzuWVYK3Fk+Pm5t9+8
         qJhA==
X-Gm-Message-State: AA+aEWb/0Tnpkh8IsPAcrVFVwOTkk660T7jLI/ioa252WG198ihaW9Fy
        v2DNolwT8x6uD2suU9DTcXAfZtCFAmLAy9M8tyc=
X-Google-Smtp-Source: AFSGD/XUelczv1wDMg9XQLdhGYjjx/s0pKQwFsZNs67IyJwgdblZXnSAZuFuzqPueaGXuq3Os6NNvLTQHE3fPJ0dg3Q=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr6916605wro.29.1542655170955;
 Mon, 19 Nov 2018 11:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20181119163219.GA26520@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181119163219.GA26520@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 19 Nov 2018 14:19:17 -0500
Message-ID: <CADnq5_NY+B8=heDKwsYPnbp5c7McGkHqFo15zgzMjJyMAwiB5w@mail.gmail.com>
Subject: Re: [PATCH] drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: Remove duplicate header
To:     brajeswar.linux@gmail.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Leo Liu <leo.liu@amd.com>,
        David Panariti <David.Panariti@amd.com>,
        "S, Shirish" <shirish.s@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, sabyasachi.linux@gmail.com,
        jrdr.linux@gmail.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:17 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove gca/gfx_8_0_enum.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 3d0f277a6523..4ca1ecf1ffd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -44,7 +44,6 @@
>  #include "gca/gfx_8_0_d.h"
>  #include "gca/gfx_8_0_enum.h"
>  #include "gca/gfx_8_0_sh_mask.h"
> -#include "gca/gfx_8_0_enum.h"
>
>  #include "dce/dce_10_0_d.h"
>  #include "dce/dce_10_0_sh_mask.h"
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

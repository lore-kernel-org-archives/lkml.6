Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3242FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CFA21527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuGKi4SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CFA21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbeKVGlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:41:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39994 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388729AbeKVGlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:41:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so6960154wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86mYLKT9oGNdx98UvpSwk/L4cpWIkqbF2PLCIi0AmOg=;
        b=IuGKi4SAgOt4W7mB7qvPbiFn1iAZMNlSA13zaYFU2vvGEBD8WSNLpwZ4/HWEQlHD7u
         XokX8LWNagUYl5A/YoLVmLXcrvVhUKlEKgFs99wB4LNMPAsVdjAlK4h5r/a/p4o/CYg0
         Kc38/ayuVAhP0qIlnH4bkrnQbX0cHi5Vg9FrAcxNiJPI9S1FucDQTdLiptI8jjXUyO+P
         FQOMfnd2C0eW2IhtoyCJ4gbhj44EDqY2DKaaPAZHU25uYi1auSWfkoL4j04bsEtKlMLT
         L0pmuKU5dwSKUZJxMvXvQkqo+fB1ctOVC0VXjOmLN5C2Pol7jV12JdsntHtYBuBgKRGx
         hWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86mYLKT9oGNdx98UvpSwk/L4cpWIkqbF2PLCIi0AmOg=;
        b=kO02Pm0iC5e5S8rC01A6ztu4ws6Ofd+lVP3+MfsPI2L5mLzcB5CwborJcTJ+rZ1kGw
         YtHnUR4r1RLPzUgA546ToWvYBiJCbdZjrT0AfX7PYfhTJlzxJR1Jwk4O8Awktwh/DiMc
         UNEvGFhUn2OEqDTcnleNHIcpgEZR4hhDNBUrJEKA7fdX8WMAjSgQNJEQTM8/Wt+YwEcp
         5PypFwjYrQAkeTH1zYJjf19VZ592DOSd8hRyqVRAvGKZQyMqwmqaL5KnJE1i09gIFGF0
         aDIRrRAWJcNDScl9Rr6q+7zTR02TeFGPUIXoWVUGn22CYidvxD6C4ka50kctXs6BEFj+
         yAyg==
X-Gm-Message-State: AGRZ1gKJRu8eRW0jhX4TDmDYjRzfHz7rmyPrigIRN57b9t9bV5VlLHUf
        PtHWxKZSH8fGaFDHnDVhGdquhdk6LQ6M2Px/KkWTfdCDmbc=
X-Google-Smtp-Source: AJdET5doddrf2C8oPNnDjaC2TRMp0t40dYrpjRoybRkN6uv7vASq/yHaEEJ1E45UVMPw0Nhogp7ljbWvWXlTrwoSKlA=
X-Received: by 2002:a1c:9d97:: with SMTP id g145mr6886658wme.121.1542830761076;
 Wed, 21 Nov 2018 12:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20181121135151.GA2536@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181121135151.GA2536@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Nov 2018 15:05:48 -0500
Message-ID: <CADnq5_NknpPEDTpx+5h_8N=WTXhgbqxsMPsymPs_K+RTDeYedw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove duplicate header
To:     brajeswar.linux@gmail.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Pixel Ding <Pixel.Ding@amd.com>, "monk.liu" <Monk.Liu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!
On Wed, Nov 21, 2018 at 9:24 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove gca/gfx_8_0_sh_mask.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 64e875d528dd..6a0fcd67662a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -37,7 +37,6 @@
>  #include "gmc/gmc_8_2_sh_mask.h"
>  #include "oss/oss_3_0_d.h"
>  #include "oss/oss_3_0_sh_mask.h"
> -#include "gca/gfx_8_0_sh_mask.h"
>  #include "dce/dce_10_0_d.h"
>  #include "dce/dce_10_0_sh_mask.h"
>  #include "smu/smu_7_1_3_d.h"
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37241C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E745E218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqmzLssn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfBRWkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:40:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50293 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfBRWkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:40:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so638304wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBIykNBAhVI6jmd4+3Q+w/gteMb700Is5iJHyxCFpSI=;
        b=nqmzLssnIpPwziDaCKpcHc0Qz/a7XK5eXL1UQCM1hYOBWMEct5IHueDjGWWwcuKkYu
         kzgKA5rEXA0ZMC8JVvj+RZpWUQY+cA9Pqxw4lRIIzFagqLdKR+qYDpqkA3mrT1Yewzzc
         Xd61hofcMYUy6VYVJFo3P9BrMEBLoYn+YsIz7J3FODpXBwURBhO4YtJ7Tee2Y6xNu1Sw
         0UsF66kZGwYMlgrzIcI2DVTVmBO10M+smWtAbV4KWv2r/Ic03EBTJKOjUTcadjR6bMhF
         2avyetem8R4rvjcf+xjzKTzT7u7E5J2oqisWq0m+nZZsxurVfYI8NETk+4qVxdBarMEM
         J+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBIykNBAhVI6jmd4+3Q+w/gteMb700Is5iJHyxCFpSI=;
        b=i/n7eO996BONdsYaOmLJyKLnIlnXBVnKwwuwJdMmaTC3eogISl6FBmP9OEh1rqpOHq
         2D3c5N8UWbUQa1Y2eQ44NfPC2NLsu/jE30kEKPRVIg1TALFV+CEqdNyYOdD6L1pMny/+
         PK75zRNaixHX/5sQ9/MoMUnGXPYE0CIkcw1HFFJmHSCPtRRpyPuA01TovUV8EsACd72K
         DwcwS1kF7tjgXAhaTqr739erWjP0RmmS1Az5rs8ObeJFPcLfPicakzRKyAfyCxHQrPgT
         B7Ha4bv8iitc3GniK7AmXp/3L9Qwk1HM2s9CWV4ck1FUV0F9cHA4XyJwx0oR3JJl5uJe
         2Njw==
X-Gm-Message-State: AHQUAubMg2TmhrpJ40gjqO/8AQyI5VaL/Lm3+bt30jpYUJvJyUBfjvOA
        VsWnA9wNyho9xt8uJyAfzt06LQvcjIQDH8E5BsY=
X-Google-Smtp-Source: AHgI3IaD2qQd9sDxCpC7k9Amma5nvLraIDz5JfHX8LJBhqnrKnJK+LRnEfgoOS6zcSnB8G1vCmkma1tPchYloMBgOaA=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr665761wme.82.1550529635282;
 Mon, 18 Feb 2019 14:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20190215170253.GA30719@embeddedor>
In-Reply-To: <20190215170253.GA30719@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Feb 2019 17:40:23 -0500
Message-ID: <CADnq5_OtPhhES1gm=0CZBPYYJqCpQccjYrmwTTftw8gwVSL30w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay/polaris10_smumgr: Mark expected
 switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 1:50 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 52abca065764..92de1bbb2e33 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -2330,6 +2330,7 @@ static uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
>                 case DRAM_LOG_BUFF_SIZE:
>                         return offsetof(SMU74_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>                 }
> +               /* fall through */

These should be breaks, although I don't think we ever currently hit
this case.  I've sent out a patch to fix it and applied the rest of
the radeon and amdgpu patches.  Thanks!

Alex

>         case SMU_Discrete_DpmTable:
>                 switch (member) {
>                 case UvdBootLevel:
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

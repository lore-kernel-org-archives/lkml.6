Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60782176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJcCTH7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfBRWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:23:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40522 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbfBRWXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:23:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15so584445wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4t5SMg7xoRewEtO9DUFeoO6FjevSLB5vU8d7mNvL3I=;
        b=NJcCTH7AIoNTI5X1/C4Zdkrpt3WrKZO0V7bQ9Ykx3GkmU0TQ5zOrMlPTHbdDFHhi4K
         6P5WmVrPrMIrUgGkttrGwhpKPOnjvd5TseWOf+pg/N7Fggpo/oo+LikpIObnmrdZn/S/
         rbJCw/CQFUKXBhVsAuKtojw63cbdgHJPe+RBMiTyz6mBYYi1D7KHn0vjQ+87eQW5PlUX
         lACjv8bJ4P7I8ADGHNn91yWQF6PnFFRLJiOXauxWPxD2mc0v/K0ra897eCCAynu0OF1g
         f9mukJU02ax0gC4fLRg9ZI2NM49pNwGoGfMmJraeumGIjhTq1cf9pqdJ2gu2Pal/sFV/
         5JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4t5SMg7xoRewEtO9DUFeoO6FjevSLB5vU8d7mNvL3I=;
        b=ixy+jSwk9rKyb+CdGz0axXhbgQcV9a82Sgpf5DMLPclh9UkvUhXzIRlhuv57sjCrWH
         KvoCI0DwM3LkgeinamdZe/H1LRvrDMsi3eMPh/OvfK9V8ZUyHqQzN3SzcVoDkN6+oQ5H
         fFaN4Cexaj2fAHz51H3PjMBO4vOYZgHQpjeLaLAd/hzwSK50Nqeo3oP2pzFLX/xNY+SR
         93EQcIOoMN+lWkGU5M40PWF7O5dzyI99d1ckF3aDzAkkqPnbvurp3KlEx8HQt20j/kwC
         yT5gZ/lEpxApo7aynqGniv5QnPEXlCBp/tbjdSAtK72/noKMxekfOtdeFNtVRq84Prlt
         Xwvg==
X-Gm-Message-State: AHQUAubSsY1ZhJ5JLcSuqoYaNQs+v8ofcIKneoOVz/dR+hIufgly9tS8
        MAVrTZZZE1FYi4DLHkmGvKWjKJrkzkfX1vrdkTk=
X-Google-Smtp-Source: AHgI3Ib0hyFhFatiXGI3Q2rkmsyGLUSXGhFmVgseFm81+e3Ft0ZbUtWjNM+R2ojKeoJ+7ux3iscPg1wzeIzvJ7piLSI=
X-Received: by 2002:a1c:f701:: with SMTP id v1mr551917wmh.153.1550528612968;
 Mon, 18 Feb 2019 14:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20190215202926.GA4578@embeddedor>
In-Reply-To: <20190215202926.GA4578@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Feb 2019 17:23:19 -0500
Message-ID: <CADnq5_PoxekMe1OMq-CFqMWjxdCC=ZG9OHY_MEiEeNWJTHhKAw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/evergreen_cs: fix missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
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

On Fri, Feb 15, 2019 at 5:40 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to case CB_TARGET_MASK.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: dd220a00e8bd ("drm/radeon/kms: add support for streamout v7")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> NOTE: Notice that this code has been out there since 2012. So, it
> would be helpful if someone can double-check this.

Applied.  thanks!

Alex

>
>  drivers/gpu/drm/radeon/evergreen_cs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
> index f471537c852f..1e14c6921454 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
>                         return -EINVAL;
>                 }
>                 ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
> +               break;
>         case CB_TARGET_MASK:
>                 track->cb_target_mask = radeon_get_ib_value(p, idx);
>                 track->cb_dirty = true;
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

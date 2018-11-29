Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE824C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D5C20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vqw6KfOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D5C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeK3EoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:44:16 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45485 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeK3EoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:44:16 -0500
Received: by mail-io1-f67.google.com with SMTP id w7so2227675iom.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juYTrX9EC1a7xwaofwx/cNxmEs5rX3YXv+A9hOov0MU=;
        b=Vqw6KfOBpJbkzjabgnpW/EQeWu4mTZXESsQ5Zvirc6q8Unc1elIluzVr9tIlOgc0An
         ZX1dT7bREsxM2EwvccLX7YrjQLXuQ5uOpuPg4HpjANS1Doy2VW5jH2S2EMJWEJ9JJMGf
         GaIU0aXsI1ELgZJZqMKpTK/SayJjXV35L7x8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juYTrX9EC1a7xwaofwx/cNxmEs5rX3YXv+A9hOov0MU=;
        b=Wdb6S/B+dsj6tF2/CB4yolYVJ22q/wDKfr/jH26pO26d0ZWH85wYsZMe4ZJUNPhS/u
         fq9GpOwWl6/jW5CEgtpavb12fAu85qZZ5uKf1pflIexHAlS5wXAGMG9M9wZaiAf2IRCw
         Rb/dutYrPYIBcMw1B9WFCDjJHxpJq1m7Li8hF12IlYS2n4Kgfx8/oOhZIxGnZfpEQSVB
         1kPq9eeoiL1Iz41dwAi/waVvKJiJGk/kKqWRf9ZwHQUEMF6XdAPlm+HZtLSLwpZvEG+h
         FDx4ZCEh0n9r3jHqCvdxLPmczoc/b/Y1cnwMqgS+BPyrXQvvEjpB/a0fn1uRB2PEBuOb
         YkVA==
X-Gm-Message-State: AA+aEWZG/cXSTIz/9Xyb+mLmxDjyLMAdTXS2hQyR0DHmBBqaFUS3tAV6
        ndKUHkEojObeRZ6cbogPAt3zOCJFWkjm5gRfRnyL8bzR4Bw=
X-Google-Smtp-Source: AFSGD/WVP8jU6YR1Rd1qnhBv5y55EMGObqXw9WZ5e9KbyoqpSjQerNeyT60a591MDKuvWGUIwgnWvB0hCC3goJMDHLI=
X-Received: by 2002:a6b:ce06:: with SMTP id p6mr1814852iob.189.1543513087333;
 Thu, 29 Nov 2018 09:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20181128230927.10951-1-eric@anholt.net> <20181128230927.10951-3-eric@anholt.net>
In-Reply-To: <20181128230927.10951-3-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Thu, 29 Nov 2018 17:37:56 +0000
Message-ID: <CAApk1dUe+FvFnKCTjPmYi=vGZQeRZW0XQk_AOiPmahZD__g7oQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/v3d: Fix prime imports of buffers from other drivers.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 at 23:09, Eric Anholt <eric@anholt.net> wrote:
>
> v3d_bo_get_pages() checks this to decide to map the imported buffer
> instead of the backing shmem file.  The caller was about to set this
> value anyway, and there's no error path in between.  Ideally we
> wouldn't even allocate the shmem file for our imports, but that's a
> more invasive fix.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> Cc: Dave Emett <david.emett@broadcom.com>

Reviewed-by: Dave Emett <david.emett@broadcom.com>
> ---
>
> I've been sitting on this one because I don't like it and was hoping
> the shmem library would pan out.  This is a useful patch for now,
> though.
>
>  drivers/gpu/drm/v3d/v3d_bo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 54d96518a131..a08766d39eab 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -293,6 +293,7 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>         bo->resv = attach->dmabuf->resv;
>
>         bo->sgt = sgt;
> +       obj->import_attach = attach;
>         v3d_bo_get_pages(bo);
>
>         v3d_mmu_insert_ptes(bo);
> --
> 2.20.0.rc1
>

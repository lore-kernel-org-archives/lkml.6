Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF35C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B050E206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNCZIH+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfAPV7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:59:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52543 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbfAPV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:59:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so3708717wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AR3kOZxdFfwztSZ6gPzl2fyWZdxG8W80s0p4EG4rA8E=;
        b=CNCZIH+oHhEzDeuGbDAjhpPn9FRBgiw9ZVFeMd/QQ50gA8+W2XVkD9K3yOfJUZgUGc
         exzToW4f79F4X/3gpZFuWtR1WfJWvahMmujtYw8qvjCYUzcoE1mvEqjUZQlesIcSIMMu
         4SRXRIsrgFScz4nce6lb7oUd25oOBg9eESJ4aV4XcCcTmkHiDT7KqEgVvtAg8WRjpZNe
         jIfKOILDFq+CnWLZExq4r83O8JDg9RH03qkNc72qxoypevtnpwCzWktJB8Ib3gnCY4Mq
         Xs9xGfLuu8g7LCOVFewAiLdzfW0ID2Q/a7tepyp5HMPIRaXFrQbVZFa4h2PuFdGTM7LU
         Wu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AR3kOZxdFfwztSZ6gPzl2fyWZdxG8W80s0p4EG4rA8E=;
        b=TVG+m/PKAbFSQmJT2lteRFR7GqXL1w42i36x/EYG6Nz+6cM42MhB4jWBDxznrGo0lS
         3tEOnyzrSNUPydEnSNaVVFxeybwVdYHZbIhrw8DMHVGSjmkVUM/a+9DrlMXouvpUVB2C
         B6hqWDBbNu/l3m/DUPxL5GxPO7qno7mkLDvtnWJK/xvRHb2nEPQQttl4WhG2+0TT+Zz7
         wi9BRpVwMBi+GMbE4QWSC2JcZkhGQ9F6C9LLh33FX5JGPCzQadVLNu67/GNEibxlBf3G
         ziDD+y/gpsUgPe9lxWcyyN3RIPsreC/6mbb3FhUsnqLNzIyBn5wefP+QFU5FjPEuoMzT
         BEPg==
X-Gm-Message-State: AJcUukd5l9klPgg6r7AhQVk3weeoLWWnQoPxlRV+uGneAyIvF/w657X2
        hd1X6lNJSkSzRP+l1vmVrDhq3NiAn2lpf/ZzqVY=
X-Google-Smtp-Source: ALg8bN5GSkuKvJHJ9dSo76zA5TRb7aKRF/87BztYw/TnpzWlYCtnf/0gaIWmxcEBvw3vwhOHi1udefIceFlbIQMCMxI=
X-Received: by 2002:a1c:6243:: with SMTP id w64mr8919240wmb.153.1547675944054;
 Wed, 16 Jan 2019 13:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20190114202652.15204-1-malat@debian.org>
In-Reply-To: <20190114202652.15204-1-malat@debian.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 16 Jan 2019 16:58:51 -0500
Message-ID: <CADnq5_PgUBbSEbAsZrhnWQszmdOmHDynUfaQ_pB+f9scuyb-vQ@mail.gmail.com>
Subject: Re: [PATCH] drm: radeon: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 3:29 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
>
> This commit remove the following warning:
>
>   drivers/gpu/drm/radeon/evergreen_cs.c:1301:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/gpu/drm/radeon/evergreen_cs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
> index f471537c852f..fbf346185790 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -1299,6 +1299,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
>                         return -EINVAL;
>                 }
>                 ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
> +               /* fall through */

I think this should actually be a break here.

Alex

>         case CB_TARGET_MASK:
>                 track->cb_target_mask = radeon_get_ib_value(p, idx);
>                 track->cb_dirty = true;
> --
> 2.19.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

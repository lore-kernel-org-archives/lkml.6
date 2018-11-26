Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD87DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F920817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn81JXRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0F920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeK0H3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:29:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36007 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeK0H3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:29:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so20377509wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm34nqBewsdKnvHwz6/2dGfE+MVkc3un/JxnAwCnuWk=;
        b=Rn81JXRWLwM6GCPwesT7w34hM3jh5+hxdVynHpgcSVkBocRZzC06I5w5DrOisjU68q
         EV5HpdGbgSWMRwOkz06bKuCRnG+950Wx/IgeGC1dV0eZMUuWw79TsIof8V5xdVcIWFwH
         5rJ90lbLYWUH5g3CpfVAXGHoQD0imW3fU9JmUvr0n3lNAMSwdBnAwO5f/KTT8XaqCQPV
         5ND+3+flYhLmIrY03YyyoH6ESdiDSrN5s7WQudhcZSN9O7YZ6kiJxrXexfWm1JEB3Ypv
         ZoAtjhfLq/NjWHOVQgxIf6JIOYtgPBPsCzxRYTVgfiIAQ7IKCMWA8v0QgGWY9Er/PmrK
         sfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm34nqBewsdKnvHwz6/2dGfE+MVkc3un/JxnAwCnuWk=;
        b=K+jrXEsIxjkeQdF9T0wsLNcHzvSQoqsZKerduOSLcWCWh/g2EjhzrlINMunhODiXqM
         MDFpGDe41c9rsS5UZKsuhro4+5ZGyDrxV147u9UIXZUlza40UL0iQ7Ajwh/ad0KMK+5/
         d/sBT+cH/LljWOTtP0aZ95aNJ2j+cQLemyS6R8jVaask5y5hvQHFr3/DevW34r0v8yIz
         KVr8gHCJ+DSjs/NoYVT/GwfC4AiKTvYKroGi6D2G/qoQEWReF0QT4Z0sLyEk+PDoxzmP
         LxJuWOhFsUbtN0Zf1y0bhuBKXOOQaunakDCJolcMoOTzKHZh/ybuYFdQ13WTl91mfeCQ
         X1Xg==
X-Gm-Message-State: AA+aEWYELSgGIg0QxAFMRrXD/T9UOjGgXBT1MI3w2KCL8lqvtisetmaK
        Ak9gdlIgd6gbiMcYtvQLrVFuQbYho2AsPzWxbPs=
X-Google-Smtp-Source: AFSGD/UzwGxcx6gcbMHmJ62STP49YktqfDB7s4QJMTzb4urGNIX7X/CAG0xujayFzVJDZ9Lk+ARXnjzxWTv6HVIXs/g=
X-Received: by 2002:a5d:5351:: with SMTP id t17mr24652135wrv.288.1543264441969;
 Mon, 26 Nov 2018 12:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20181122140714.GA3219@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181122140714.GA3219@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Nov 2018 15:33:48 -0500
Message-ID: <CADnq5_PhesnKq+AxhF+9WsqWYMSpjSRBRLtCpCZ_E2O+DjPEow@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdkfd: Remove duplicate header
To:     brajeswar.linux@gmail.com
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
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

On Fri, Nov 23, 2018 at 2:41 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove gca/gfx_8_0_enum.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
> index fd60a116be37..c3a5dcfe877a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
> @@ -24,7 +24,6 @@
>  #include "kfd_device_queue_manager.h"
>  #include "gca/gfx_8_0_enum.h"
>  #include "gca/gfx_8_0_sh_mask.h"
> -#include "gca/gfx_8_0_enum.h"
>  #include "oss/oss_3_0_sh_mask.h"
>
>  static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

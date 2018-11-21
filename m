Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B632C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62644214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEyIe/DY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62644214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbeKVGmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:42:00 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41271 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388729AbeKVGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:41:59 -0500
Received: by mail-wr1-f43.google.com with SMTP id x10so6986179wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nUVpsv1jmqy6A3ngstHwab19Gy9/pHRfWv9zW5u6C4=;
        b=YEyIe/DY+ajUuNlE2SIdLkL8RpCzS+6PzV5ltRN0ydxYlwSQSLSJS8l6e6xacFhRPQ
         XCfO2eedZskv6uf76LpGMkbWeglRnQUchz9wXSHnCZafCE4867aCFO5Qeaubkg6mGKww
         LkBo7QqZIUymFFrf6B1kf2Adt8KSsOV7bGGmuNWrX+ulPnO4DJTq4WE5Xnht+hMix9yH
         yIp4iYFKVk/0Pzw/NvCYKcbzLup3XUYeOleT2bHw8/tYD21xeAF3TB4WUpdNgcioPYzJ
         muS8NC8CmmqPoBeszv6+d1UZpytpjIBmqIqO+7uI9FVdkhYt8ysfjeHSnd19BQ2/9XDx
         U6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nUVpsv1jmqy6A3ngstHwab19Gy9/pHRfWv9zW5u6C4=;
        b=M7geHKzQhMMmhNmcAdFB07/Mni4vHCxGNQptQ1OyDIA3rBYzsiSUEfqx/vcKVIGhRD
         1grkN+iNBPOpk9kpF/G0FzmtKJ99dXLzVIjiv8ZzNfgUcqDw9I/9BIZh0i9E9Dmv7nA+
         2qIuD4W3eQqbRdIUvIaJ0frbHypQudkJGIg1pGzodf11cJJG9aCf1hcYJ0pW2tI/DFgn
         63IE7HMaq49aijsCsKfWP7wlv/Qbo23q7dN31Q/D4ijZHr2aOgyboFSqAVg8RzON04oI
         VLNrt7HiYUS8SGXn3iYukjtP786Xr+hi2XcDwofHgMiOCCpy8+Peg/woYH5wcR3LajzG
         tYjg==
X-Gm-Message-State: AA+aEWbV5c+bHdCpzKaxITDB5Kd9p87dYFtNOBsJd83ZrXxt9Aq0e2zo
        t2c/kSeOsKYP5Ig7uH7YFYNjf9rCl9hv2EbXFCy69XKH48aBww==
X-Google-Smtp-Source: AFSGD/X9hZr/lv6KzBhtNt73lk93ZJxC35m+9OiqYJ00Lctb5mQqF/53WTj77f5F6j6pwkLW9QZXxPkEnb+11Ldz3fY=
X-Received: by 2002:a5d:48c5:: with SMTP id p5-v6mr7149392wrs.15.1542830773149;
 Wed, 21 Nov 2018 12:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20181121120913.GA2289@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181121120913.GA2289@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Nov 2018 15:06:01 -0500
Message-ID: <CADnq5_NdkoPuXzJZ=2x0nO5Rfd5BnXgCg5j1+wDF=bUGaatQzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display/amdgpu_dm/amdgpu_dm.c: Remove duplicate header
To:     brajeswar.linux@gmail.com
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "S, Shirish" <shirish.s@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>, Anthony.Koo@amd.com,
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
On Wed, Nov 21, 2018 at 9:25 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove dm_services_types.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e224f23e2215..62a96c683584 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -38,7 +38,6 @@
>  #include "amd_shared.h"
>  #include "amdgpu_dm_irq.h"
>  #include "dm_helpers.h"
> -#include "dm_services_types.h"
>  #include "amdgpu_dm_mst_types.h"
>  #if defined(CONFIG_DEBUG_FS)
>  #include "amdgpu_dm_debugfs.h"
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

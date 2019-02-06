Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C19C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AB02073F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FW7aFPpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfBFP2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:28:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39776 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfBFP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:28:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so6205450edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FQiSRbpqA93TECFSrxCLQjdku8nIKmM/RdCWCjE8VcQ=;
        b=FW7aFPpRfzIMyCJXU4F34XSh0Lm9GBQWax2cxx/IcHI3IR1/eM813oupuepQcSzRIc
         PdDUzyhlMQ3gQtL2rESEDOLys563hx7S+DqD4WAiwl1pTU38IunTNKHzkGXz8zZ1JKT/
         /hnq+wTNpnzT25Y73GJsH+qOlR60pgGgDF19g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FQiSRbpqA93TECFSrxCLQjdku8nIKmM/RdCWCjE8VcQ=;
        b=UARZxnvZgrLmY11AKHbVUGaIrGrkTjQUwPxN/mR07/5yzF5w2LMcbg9bBrH89qJ/xp
         QSadR2ii2vs7juEUh0Y2hiqDa8xpYM4nn5NsNGpAx4W2hJlVo+kBKyMPNdxNhJfB5bBG
         P8KUaCuzb7uavmcEHyVK9C1FiNcY838yDHZj48/MmUuhqDl66gjTtMxhLtpY/aU9X8XG
         CwaeCq5R1A+fKYEV8yinS9iiw1Dqt34V0XUnPK9HKJ6hHBosaZB0IAB4VdnGCe9d1Ttz
         8UhsjqmPOeCG4NThplFNzsl+cRv/hfVtXRkgBPtiQ1gRZ4jfj1MaoyGurpHPjC6iKdPC
         JA+w==
X-Gm-Message-State: AHQUAuapg91IKZrylYw2iVKuGUvThvguJdUcVm9YtWNCcNp2RphbAGGW
        nUcegZs7plbLVyYRoCGseGYFOg==
X-Google-Smtp-Source: AHgI3IaWbySBxY3x+Wc8p/ZGF6gTwbq/LO2dLaQso3K78URzriahyh31zA9lO8bhybucXNe81YQaxQ==
X-Received: by 2002:a05:6402:14cd:: with SMTP id f13mr6865052edx.224.1549466882548;
        Wed, 06 Feb 2019 07:28:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r24sm654457eda.15.2019.02.06.07.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 07:28:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 16:27:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     stable@vger.kernel.org, Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/vkms: Fix license inconsistent
Message-ID: <20190206152759.GJ3271@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        stable@vger.kernel.org, Haneen Mohammed <hamohammed.sa@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190206140116.7qvy2lpwbcd7wds6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206140116.7qvy2lpwbcd7wds6@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:01:16PM -0200, Rodrigo Siqueira wrote:
> Fixes license inconsistent related to the VKMS driver and remove the
> redundant boilerplate comment.
> 
> Fixes: 854502fa0a38 ("drm/vkms: Add basic CRTC initialization")
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
> Changes in V2:
>   - Add "Cc: stable@vger.kernel.org" tag

Since cc: stable please apply this patch to drm-misc-fixes, not
drm-misc-next like usual.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
>  drivers/gpu/drm/vkms/vkms_crc.c    | 3 ++-
>  drivers/gpu/drm/vkms/vkms_crtc.c   | 8 +-------
>  drivers/gpu/drm/vkms/vkms_drv.c    | 7 +------
>  drivers/gpu/drm/vkms/vkms_drv.h    | 2 ++
>  drivers/gpu/drm/vkms/vkms_gem.c    | 8 +-------
>  drivers/gpu/drm/vkms/vkms_output.c | 8 +-------
>  drivers/gpu/drm/vkms/vkms_plane.c  | 8 +-------
>  7 files changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
> index 9d9e8146db90..d7b409a3c0f8 100644
> --- a/drivers/gpu/drm/vkms/vkms_crc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> @@ -1,4 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
> +
>  #include "vkms_drv.h"
>  #include <linux/crc32.h>
>  #include <drm/drm_atomic.h>
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 5a095610726b..6ddaa1610807 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -1,10 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
>  
>  #include "vkms_drv.h"
>  #include <drm/drm_atomic_helper.h>
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index b13f99a5c849..738dd6206d85 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -1,9 +1,4 @@
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
>  
>  /**
>   * DOC: vkms (Virtual Kernel Modesetting)
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index e4469cd3d254..81f1cfbeb936 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -1,3 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
>  #ifndef _VKMS_DRV_H_
>  #define _VKMS_DRV_H_
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
> index 80311daed47a..138b0bb325cf 100644
> --- a/drivers/gpu/drm/vkms/vkms_gem.c
> +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> @@ -1,10 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
>  
>  #include <linux/shmem_fs.h>
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index c5b16efed51a..3b162b25312e 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -1,10 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
>  
>  #include "vkms_drv.h"
>  #include <drm/drm_atomic_helper.h>
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 418817600ad1..0e67d2d42f0c 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -1,10 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
>  
>  #include "vkms_drv.h"
>  #include <drm/drm_plane_helper.h>
> -- 
> 2.20.1
> 
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech
> Graduate Student
> Department of Computer Science
> University of São Paulo



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

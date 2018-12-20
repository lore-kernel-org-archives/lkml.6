Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E64C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748CA20869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IseERiMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbeLTNRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:17:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33828 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbeLTNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:17:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so1541629lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ThT/lweRcA70uhNnYHBgtOJiRmzbAI5/i2Pt5N4Ej8w=;
        b=IseERiMiDKldZ3aeJB0ekIwvG47RJnfsipT2eCLkQgSW00zUYn9icSzAOhoZF4GmkU
         Yij0lmLMXEQuTwGAArCqylkvceGBWlOQnr1ObkdE3nvdANiHs5KAoE9R62XGsGf5t3DG
         VidzYwDi6T9oqGsATlS86sQq9ym5yJTzFID0lN9Twi/RX8jEluiLlBmT+PSGSOJ5uXY2
         fYW65xBHxc8IQybAVLCmeFf2UwwBdIDpTZX7gaHgjQ/b4GLyIZeD+ugmDesjBUYt9IQJ
         ZOFnvbcl8XgyT09+lxsx7iTwUWIsBIWSv3SCfykCuOeUMZ5y7qZd2KZ0MLcLQ6eVcSg/
         srIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ThT/lweRcA70uhNnYHBgtOJiRmzbAI5/i2Pt5N4Ej8w=;
        b=kj1Zob0loxPDcrL3vF6LszPrziT4hMb0sDc5oTW2/JTQv35cgUYJv0EfbHDjVbiqoL
         5dPCZ7Wq9rjePi/EBL5foS3Zp+qtDP7b8EzppgwZlH2wjN4YHAYplWbQ+RO7xNeo3She
         2jTVjK4+vyAjEkDvuOEuLvTX6d2CTGp7RsK9cwlTmev6ThK5MffOU3R2USwtYFjkj0ze
         CS5xaYI2dCv9SEdBtK8lYCrhMO2SZSmTxPTEW45oOyqExCbCTAp8hMybZMI7pqsqW01M
         F8iReYC0RuZ3rEV6+IUZkcmNmraV/RpQ1rl25IvcYFzPPrACZDEtE3dIMrhWWuvb7XRk
         qJNA==
X-Gm-Message-State: AA+aEWYcd/z7KEzBT/7JIJJkdepssJbrLRcwD8+E2lV8LB99hBJEaa/I
        UHIr6qcd5PGS59qDtj15fRwvunNt
X-Google-Smtp-Source: AFSGD/VgGqNwhCvmqdr6hi08IHyjutBZ/Z4nU6efCoKtjX8cz5XDC5FYuPfmUjsa7OPt+CYHa/rxtw==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr15038213lju.116.1545311852240;
        Thu, 20 Dec 2018 05:17:32 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id j76-v6sm4162494ljb.12.2018.12.20.05.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:17:31 -0800 (PST)
Subject: Re: [PATCH 14/14] drm/bochs: move remaining fb bits to kms
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181219115127.31359-1-kraxel@redhat.com>
 <20181219115127.31359-15-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <3c8d11ff-95cc-8e78-e226-b803ddff8e94@gmail.com>
Date:   Thu, 20 Dec 2018 15:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219115127.31359-15-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 1:51 PM, Gerd Hoffmann wrote:
> bochs_fbdev.c is almost empty now.  Move the remaining framebuffer bits
> over to bochs_kms.c.  Pure code motion. No functional change.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/bochs/bochs_fbdev.c | 29 -----------------------------
>   drivers/gpu/drm/bochs/bochs_kms.c   | 17 +++++++++++++++++
>   drivers/gpu/drm/bochs/Makefile      |  2 +-
>   3 files changed, 18 insertions(+), 30 deletions(-)
>   delete mode 100644 drivers/gpu/drm/bochs/bochs_fbdev.c
>
> diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
> deleted file mode 100644
> index 7cac3f5253..0000000000
> --- a/drivers/gpu/drm/bochs/bochs_fbdev.c
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> -
> -#include "bochs.h"
> -#include <drm/drm_atomic_helper.h>
> -#include <drm/drm_gem_framebuffer_helper.h>
> -
> -/* ---------------------------------------------------------------------- */
> -
> -static struct drm_framebuffer *
> -bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
> -		    const struct drm_mode_fb_cmd2 *mode_cmd)
> -{
> -	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
> -	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
> -		return ERR_PTR(-EINVAL);
> -
> -	return drm_gem_fb_create(dev, file, mode_cmd);
> -}
> -
> -const struct drm_mode_config_funcs bochs_mode_funcs = {
> -	.fb_create = bochs_gem_fb_create,
> -	.atomic_check = drm_atomic_helper_check,
> -	.atomic_commit = drm_atomic_helper_commit,
> -};
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index a1a0129f3e..3688d0b616 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -9,6 +9,7 @@
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_plane_helper.h>
>   #include <drm/drm_atomic_uapi.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>   
>   static int defx = 1024;
>   static int defy = 768;
> @@ -256,6 +257,22 @@ static void bochs_connector_init(struct drm_device *dev)
>   	}
>   }
>   
> +static struct drm_framebuffer *
> +bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
> +		    const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
> +	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
> +		return ERR_PTR(-EINVAL);
> +
> +	return drm_gem_fb_create(dev, file, mode_cmd);
> +}
> +
> +const struct drm_mode_config_funcs bochs_mode_funcs = {
> +	.fb_create = bochs_gem_fb_create,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};
>   
>   int bochs_kms_init(struct bochs_device *bochs)
>   {
> diff --git a/drivers/gpu/drm/bochs/Makefile b/drivers/gpu/drm/bochs/Makefile
> index 98ef60a19e..e9e0f8f5eb 100644
> --- a/drivers/gpu/drm/bochs/Makefile
> +++ b/drivers/gpu/drm/bochs/Makefile
> @@ -1,3 +1,3 @@
> -bochs-drm-y := bochs_drv.o bochs_mm.o bochs_kms.o bochs_fbdev.o bochs_hw.o
> +bochs-drm-y := bochs_drv.o bochs_mm.o bochs_kms.o bochs_hw.o
>   
>   obj-$(CONFIG_DRM_BOCHS)	+= bochs-drm.o


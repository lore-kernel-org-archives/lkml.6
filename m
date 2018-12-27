Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5B42148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DVULk7bU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbeL0MJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 07:09:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41890 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbeL0MJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 07:09:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id a20so8302338edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 04:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GcWCqfedkueofyQnuZgmOcR/5gSP4PtRs9I8Z9HPg70=;
        b=DVULk7bUjbViCGAGuHzoD4l6gW5MHQQt2hMI4oqRKknr0K8bsspOxH1kWGdsOoFyMx
         mIm19neQ2msIoNzaM96ofEGjHcuOEqM47AklGFnoeoyxTlo4futIzWRZWBsFDY8wuYXu
         p7f9JeHJM3cLpEnnQox7vuNKLz5YoSmkUL6vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GcWCqfedkueofyQnuZgmOcR/5gSP4PtRs9I8Z9HPg70=;
        b=RE4dBH1JyGIxHIxuqRdJ/OAbMBd0UyCGpDPlBOwCaxSztMaWsi5PC4sl2ptUeebMcW
         jIUKMsglNvA0l3SonlF8S8q3d8aDzlxCxCh6bi1PYwVR1xBWi/dhOUJgnQ2fYir4WXWn
         ecVUH04Ne87G+l51fXPEJChu2Sw4W/caqWyID/s01fwPfrXv1kAbmBPCLO8mgaA57Axi
         iCHCh+3rK+SlRy1NTWmLFce6l/2pdxiIGRZTTczPXdZOjIZhxj9H6jfJuf6S6Fe0k7Pg
         +RH9A+2tvSfZnDFdEnuoF6YHywK2uFfF+sm1+74psdGbwxzj/WFa4ykOdinNEQsuruCu
         R4zA==
X-Gm-Message-State: AA+aEWZhZ1Ft8J4NKR4oII2cmd0kW9h2Ht6IjD/PqTwG0j3HpMQ+Ni3c
        HPEKzGWMx+LhplegWZM21J+nyw==
X-Google-Smtp-Source: AFSGD/WQz7DuJslWQ4ddRAxo6Rjsa5yU535Ii5yFJPEhgu+jx4Op2PTuG2j/k/GG1Rcy9WW5f/zr6g==
X-Received: by 2002:a50:a974:: with SMTP id m49mr19060640edc.220.1545912563332;
        Thu, 27 Dec 2018 04:09:23 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id d56sm11527606ede.76.2018.12.27.04.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 04:09:22 -0800 (PST)
Date:   Thu, 27 Dec 2018 13:09:19 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 1/7] drm: move DRM_IF_VERSION to drm_internal.h
Message-ID: <20181227120919.GD9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20181226210215.GA27610@ravnborg.org>
 <20181226210353.13993-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226210353.13993-1-sam@ravnborg.org>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 10:03:47PM +0100, Sam Ravnborg wrote:
> Move DRM_IF_VERSION out of drmP.h to allow users
> to get rid of the drmP include.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_internal.h | 2 ++
>  include/drm/drmP.h             | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index 51e06defc8d8..e9374cd43610 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -26,6 +26,8 @@
>  #define DRM_IF_MAJOR 1
>  #define DRM_IF_MINOR 4
>  
> +#define DRM_IF_VERSION(maj, min) (maj << 16 | min)
> +
>  struct drm_prime_file_private;
>  struct dma_buf;
>  
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 05350424a4d3..b6b8436b5123 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -95,8 +95,6 @@ struct dma_buf_attachment;
>  struct pci_dev;
>  struct pci_controller;
>  
> -#define DRM_IF_VERSION(maj, min) (maj << 16 | min)
> -
>  #define DRM_SWITCH_POWER_ON 0
>  #define DRM_SWITCH_POWER_OFF 1
>  #define DRM_SWITCH_POWER_CHANGING 2
> -- 
> 2.12.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

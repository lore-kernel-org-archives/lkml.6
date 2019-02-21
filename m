Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC58C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8A8214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HU8MCviB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfBUJiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:38:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47102 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfBUJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:38:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so22463205edy.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReoiAJmgj456nojJUZ4xuw/Jy7Hmc2sVoEkMfntNpfQ=;
        b=HU8MCviBRTmSHR28WV6DPjfsjV1aVpC5d+3udPvhLLKMqzYPqe+CQcmgoGcsa6GEiA
         4mOeIDoo93UCRlQ9Gj/pXX1oGcML3bQfGmwIwZWv8nyd9+ptqtzsAKzdqHY61lkDo/Y0
         q2AatprA3Arg28+nGybWnvjAL6+kL3ixauHx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ReoiAJmgj456nojJUZ4xuw/Jy7Hmc2sVoEkMfntNpfQ=;
        b=nRO3v3VlUvNDgXy9j4UfN6BlkQfSyDxFfS4yyzkeuIs0vFSNmDHcfqFua4VZEc0RGu
         SJSJuJRy0y/Ubg3DJ4os1w7QKub3WYqXFBB3igvQiPdjIprQNl9scq6a8koogv01QuYR
         E+M4oWeX1lu+6mwDaOgloBZlxaetc0rU8K7Xpir8hAaBXPwK2WiX8Z4fI4gruXVUKWgJ
         TJkZ5dEV0h/ZBOGiis/fZ3wkpMNtiTeHkjoByWYu7HJHji/cWt4b0c3HqvOJXRnYa+jS
         fZUZgyPFUXMBX3Baz/VH6P7geuOBiDNTeIAMEsViJD45ItyONJGzcRuY1o6uHKAIeQd1
         6F8g==
X-Gm-Message-State: AHQUAuY6946fHQtUXSgS5SzJ8roiXyr7t3aHhDRzZjOIGlVLLViaUV/D
        Dqb6XNX37jaXzMbJD7hNLZ8+qA==
X-Google-Smtp-Source: AHgI3IahAb+LbY5r6pGAfD0r4ybBd03aj5GT/cGOShodANkzYEcbqb6NttQE5UaAYj60KpnH6CT7OA==
X-Received: by 2002:a50:9938:: with SMTP id k53mr25676145edb.134.1550741880302;
        Thu, 21 Feb 2019 01:38:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k15sm2893697eda.22.2019.02.21.01.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 01:37:59 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:37:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] drm: Add a helper function for printing a
 debugfs_regset32.
Message-ID: <20190221093757.GL2665@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20190220210343.28157-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220210343.28157-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 01:03:37PM -0800, Eric Anholt wrote:
> The debugfs_regset32 is nice to use for reducing boilerplate in
> dumping a bunch of regs in debugfs, but we also want to be able to
> print to dmesg them at runtime for driver debugging.  drm_printer lets
> us format debugfs and the printk the same way.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/drm_print.c | 16 ++++++++++++++++
>  include/drm/drm_print.h     |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 0e7fc3e7dfb4..5ecc0f04cd0c 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -253,3 +253,19 @@ void drm_err(const char *format, ...)
>  	va_end(args);
>  }
>  EXPORT_SYMBOL(drm_err);
> +

A bit of kerneldoc would be nice. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset)
> +{
> +	int namelen = 0;
> +	int i;
> +
> +	for (i = 0; i < regset->nregs; i++)
> +		namelen = max(namelen, (int)strlen(regset->regs[i].name));
> +
> +	for (i = 0; i < regset->nregs; i++) {
> +		drm_printf(p, "%*s = 0x%08x\n",
> +			   namelen, regset->regs[i].name,
> +			   readl(regset->base + regset->regs[i].offset));
> +	}
> +}
> +EXPORT_SYMBOL(drm_print_regset32);
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index afbc3beef089..3a4247319e63 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -30,6 +30,7 @@
>  #include <linux/printk.h>
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
> +#include <linux/debugfs.h>
>  
>  /**
>   * DOC: print
> @@ -84,6 +85,7 @@ void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf);
>  __printf(2, 3)
>  void drm_printf(struct drm_printer *p, const char *f, ...);
>  void drm_puts(struct drm_printer *p, const char *str);
> +void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
>  
>  __printf(2, 0)
>  /**
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

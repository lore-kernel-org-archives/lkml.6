Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB17C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB38217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i07yiM0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeLSNPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:15:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33551 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:15:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so16954024eds.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWruOZVgSTkbsWuB7OPsHmKijGk6Ct/8w3ZKuP/1zNM=;
        b=i07yiM0dMgWIw0zV8ykOanoKMEk0mp86tIBL02LcN99yvx7EXammZ6l+ZmESC3cU1x
         NUAXkIovjU8M8uNN30E02E1vVj/KD2FPIn26njcFsz0ypCHI2Z+yunFGAwbPXoXf5INY
         OZozFLRan4cfIbTgZb1EQ7bFmbqLI6wATdSKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UWruOZVgSTkbsWuB7OPsHmKijGk6Ct/8w3ZKuP/1zNM=;
        b=KsIAACvj/QuEGTbpUF5H98LSGAx97iUeiZmXbC3TK7YZXJxgDE/vGFS0cBB29GHKMA
         fWngftA8T2b9UVezzsPFlbcQS4EjISaPKGiiYYwngUFUcDyLf7lrslxW3Ra/kKAtsHvI
         WRvDf+42I2KhAJ/aN0xjpBVwy54ZIUwqqKLzyO3ajPngsFTw7/woEmdBFEPDL9x4OaZ8
         OG/ThVaGOPj2mfbnKiZKOn9tbGNiS8RR88QTm1rmnXjhxeIulqN9+TvWQEQjLct5PHML
         wT1pkFAqVbRniuj0/gkryKBlEDkltv9hnqey1vdps4VW6R1cWc7ECt5odps/wWZZiVu3
         HLyw==
X-Gm-Message-State: AA+aEWZiwJ8fkmRYtgshSJRdNa6y1ak2K7YGFVGhXrag6P5vWGOTyF4Z
        u+FSnAf+hn8kkIyHg15LqXq3Jw==
X-Google-Smtp-Source: AFSGD/XlwLgHXzF2u0mN/8vcBc4He8vZaWpuXatoeFkzReetRCCps5umC1UzQjG6wt3AOefhhie2uQ==
X-Received: by 2002:a50:a086:: with SMTP id 6mr7556848edo.88.1545225311432;
        Wed, 19 Dec 2018 05:15:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z40sm5185086edz.86.2018.12.19.05.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:15:10 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:15:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 7/7] drm: Complete remove drm_mode_object dependency
Message-ID: <20181219131508.GU21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181218133836.pahcbhb5tlr4fwvf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218133836.pahcbhb5tlr4fwvf@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:38:36AM -0200, Shayenne Moura wrote:
> This patch finalizes the KMS cleanup task dependency from drm_display_mode
> It removes the use of drm_mode_object from drm_display_mode struct
> and it removes the use of base.id and base.type.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

I didn't yet compile-test all the drivers, but aside from that this looks
all good.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  include/drm/drm_modes.h | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
> index baded6514456..9ecc1e835565 100644
> --- a/include/drm/drm_modes.h
> +++ b/include/drm/drm_modes.h
> @@ -136,8 +136,7 @@ enum drm_mode_status {
>         .hdisplay = (hd), .hsync_start = (hss), .hsync_end = (hse), \
>         .htotal = (ht), .hskew = (hsk), .vdisplay = (vd), \
>         .vsync_start = (vss), .vsync_end = (vse), .vtotal = (vt), \
> -       .vscan = (vs), .flags = (f), \
> -       .base.type = DRM_MODE_OBJECT_MODE
> +       .vscan = (vs), .flags = (f)
>  
>  #define CRTC_INTERLACE_HALVE_V (1 << 0) /* halve V values for interlacing */
>  #define CRTC_STEREO_DOUBLE     (1 << 1) /* adjust timings for stereo modes */
> @@ -213,20 +212,6 @@ struct drm_display_mode {
>          */
>         struct list_head head;
>  
> -       /**
> -        * @base:
> -        *
> -        * A display mode is a normal modeset object, possibly including public
> -        * userspace id.
> -        *
> -        * FIXME:
> -        *
> -        * This can probably be removed since the entire concept of userspace
> -        * managing modes explicitly has never landed in upstream kernel mode
> -        * setting support.
> -        */
> -       struct drm_mode_object base;
> -
>         /**
>          * @name:
>          *
> @@ -429,14 +414,14 @@ struct drm_display_mode {
>  /**
>   * DRM_MODE_FMT - printf string for &struct drm_display_mode
>   */
> -#define DRM_MODE_FMT    "%d:\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
> +#define DRM_MODE_FMT    "\"%s\" %d %d %d %d %d %d %d %d %d %d 0x%x 0x%x"
>  
>  /**
>   * DRM_MODE_ARG - printf arguments for &struct drm_display_mode
>   * @m: display mode
>   */
>  #define DRM_MODE_ARG(m) \
> -       (m)->base.id, (m)->name, (m)->vrefresh, (m)->clock, \
> +       (m)->name, (m)->vrefresh, (m)->clock, \
>         (m)->hdisplay, (m)->hsync_start, (m)->hsync_end, (m)->htotal, \
>         (m)->vdisplay, (m)->vsync_start, (m)->vsync_end, (m)->vtotal, \
>         (m)->type, (m)->flags
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

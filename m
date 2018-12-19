Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47337C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090612133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AWTWSQJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeLSNM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:12:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40236 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:12:58 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so10870927edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d3beWpGlXWIqv3Q1J0W7TmoMyGgmDR+Q4OramTWjqhc=;
        b=AWTWSQJyFtJd3XPQsQAvvtxz79mWmc4gDdfn7p9gQhrnlIB3fnBjtQoj4acdpmOpCM
         gelmUQpY5GFTIZ1aMWqB3ljm8ym3TIGaSH7UDMUTqDSvGkjvrcYVblixh8itJKotYXe+
         9bc0U5ig+v3zsSdw26x8O7Bc5PyNlXtvniskk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=d3beWpGlXWIqv3Q1J0W7TmoMyGgmDR+Q4OramTWjqhc=;
        b=ZZ9VCMf3RCpdyS50lnjZOkG0U0o/jWGahtpg+xK0ikoA0HEcwiqWWTiM5Tw3TlqKBW
         c5fV1+buYhF9f2gkw/pfr9FwRVDoVAueFuJ5Ep4zK1x57aM+SaAo7bq8eOcoEPGuZiYE
         bQKC96+ztVDO+ifDFxGN19q/n/pXSDDH6zw9poC/ky5j5HMX1fk0aqUuFjrCwJDrx3q5
         qrqBQJRhgwSAK56gAoGAOl4rWgODV29UMsOhIpptA+LufelPcdhjPTrWoNlRc7W1w3K8
         9JpEFPUQaCTiDPa9xyUQvqCz0LCAHvwheAmXdR6HPXNVznSS/LzeXjpDAAB7TA2FhoCM
         ahVQ==
X-Gm-Message-State: AA+aEWYoOkG9Z9Z+okh0bw4nB4a9kyAH83hez4XvGQfzmgjYDTQlOk86
        +H4/s+uf+2wBmKUdwMCG552sQQ==
X-Google-Smtp-Source: AFSGD/WLG2h/7j0huSU+ApuFAHPMCOMibxgD0NIJ08TFAWYHVa47wEelObU6rOfQJNLbZ6LHwsEw5g==
X-Received: by 2002:a17:906:60b:: with SMTP id s11-v6mr16621088ejb.25.1545225176714;
        Wed, 19 Dec 2018 05:12:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a15-v6sm2668920ejj.5.2018.12.19.05.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:12:56 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:12:54 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/7] drm: i915: Delete base.id prints
Message-ID: <20181219131254.GR21184@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181218133821.sykwt6wdeo7uf6o7@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218133821.sykwt6wdeo7uf6o7@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:38:21AM -0200, Shayenne Moura wrote:
> This patch removes base.id prints from drm_display_mode                         
> objects in i915 files. It removes dependency from drm_mode_object.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Again I think better to switch to DRM_MODE_FMT/ARG.
-Daniel

> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 7f455bca528e..61dd7bb3fa85 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -2948,8 +2948,8 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
>  	for (i = 0; i < tabs; i++)
>  		seq_putc(m, '\t');
>  
> -	seq_printf(m, "id %d:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> -		   mode->base.id, mode->name,
> +	seq_printf(m, "name:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> +		   mode->name,
>  		   mode->vrefresh, mode->clock,
>  		   mode->hdisplay, mode->hsync_start,
>  		   mode->hsync_end, mode->htotal,
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

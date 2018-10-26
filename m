Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0766C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980B720651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="PoBw/ZJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980B720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJZXWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:08 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34411 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeJZXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:06 -0400
Received: by mail-yb1-f194.google.com with SMTP id n140-v6so571051yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbd3LnR6odrKTptuAkKzcDvLSt27S6Jods9Tybg/Zm8=;
        b=PoBw/ZJChVmLIzcKupLOjfndWroDwIavppohDLVlyVY3j/e0u5BI/y4LB0mcRYFi2y
         3uoDL4dftEFeqjlrEMDxJO2TD7f2plRYPXHlaO/legOVv2RabY5Xa13Kzs5m9zO7UgSK
         5lJ4vJsmw/WPPpogpOfJ/WdprVUZbVbGlbPNaBcXTCqLqL8rs0as41XErNTft7oio/MS
         EaDkjNfUvoWCKYn486u1r6k+8NjnpO7T0yQalUmwMw2Gllezpd+uswTGjIm3g9UuY1bR
         QbO+rjBbis03XeC1fJDtT7kD1p/7+QhUfm/tKYmw8sgoan7+UHSrz6T0chCqUprGfGyb
         nsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbd3LnR6odrKTptuAkKzcDvLSt27S6Jods9Tybg/Zm8=;
        b=W2Xqqr8HlT2DmI8es2nbJo2rwYA0IN09oVfMPYkfT/DGdOdKfbvXiZ8Y4+U4sRcfDF
         CHUIZRLdESdEO+HB9Y/5+pB7L6DAGK2kRcXHCMPzxfqjDSratEzE2HflagBP7XVbzdRo
         VnsjScp7vW63KuvVD7RaEhyT2NSG3H/wspPAE1qZ4Y+6IWLsDzya/jX8I/EAyF9R/N5b
         yXDtpu1bdvb6i9H+mwIcJw9tawJPGVrBZGV1jKZ528+KZJAf5FtNKRqtg/Z3SQzLKfGz
         d7B8yn+MrhDO4U3X223aPqO9t3DvbkoQQzw0Kj8ARUO5A3Z27yhFwsXuwCbg7NFEIFeA
         7pmw==
X-Gm-Message-State: AGRZ1gLNBYcpbx1hP2BETtEawjfNB2utkDb1x/scVLuCliz+7X0j3HfB
        JcB4SeqM6rAKLTRvBrP3HR9FiQ==
X-Google-Smtp-Source: AJdET5exfF3c5RlP3Ee81hW78KoGnVxkR8a7cMz0ba9pGZ1UGS82NhE/MW/bBVlZtlOuM8qCGeUbGw==
X-Received: by 2002:a25:abf0:: with SMTP id v103-v6mr3733691ybi.262.1540565085273;
        Fri, 26 Oct 2018 07:44:45 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id d63-v6sm1771426ywf.100.2018.10.26.07.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 07:44:44 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:44:44 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] drm/panel: simple: Innolux TV123WAM is actually
 P120ZDG-BF1
Message-ID: <20181026144444.GT154160@art_vandelay>
References: <20181025222134.174583-1-dianders@chromium.org>
 <20181025222134.174583-6-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025222134.174583-6-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:21:34PM -0700, Douglas Anderson wrote:
> As far as I can tell the panel that was added in commit da50bd4258db
> ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> wasn't actually an Innolux TV123WAM but was actually an Innolux
> P120ZDG-BF1.
> 
> As far as I can tell the Innolux TV123WAM isn't a real panel and but
> it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> Let's unmosh.
> 
> Here's my evidence:
> 
> * Searching for TV123WAM on the Internet turns up a TI panel.  While
>   it's possible that an Innolux panel has the same model number as the
>   TI Panel, it seems a little doubtful.  Looking up the datasheet from
>   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
> 
> * As far as I know, the patch adding the Innolux Panel was supposed to
>   be for the board that's sitting in front of me as I type this
>   (support for that board is not yet upstream).  On the back of that
>   panel I see Innolux P120ZDZ-EZ1 rev B1.
> 
> * Someone pointed me at a datasheet that's supposed to be for the
>   panel in front of me (sorry, I can't share the datasheet).  That
>   datasheet has the string "p120zdg-bf1"
> 
> * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
>   that are 2160x1440.  They don't have datasheets, but the fact that
>   the resolution matches is a good sign.
> 
> In any case, let's update the name and also the physical size to match
> the correct panel.
> 
> Fixes: da50bd4258db ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> Cc: Sandeep Panda <spanda@codeaurora.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 88592f9a0018..a04ffb3b2174 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1373,7 +1373,7 @@ static const struct panel_desc innolux_n156bge_l21 = {
>  	},
>  };
>  
> -static const struct drm_display_mode innolux_tv123wam_mode = {
> +static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
>  	.clock = 206016,
>  	.hdisplay = 2160,
>  	.hsync_start = 2160 + 48,
> @@ -1387,13 +1387,13 @@ static const struct drm_display_mode innolux_tv123wam_mode = {
>  	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
>  };
>  
> -static const struct panel_desc innolux_tv123wam = {
> -	.modes = &innolux_tv123wam_mode,
> +static const struct panel_desc innolux_p120zdg_bf1 = {
> +	.modes = &innolux_p120zdg_bf1_mode,
>  	.num_modes = 1,
>  	.bpc = 8,
>  	.size = {
> -		.width = 259,
> -		.height = 173,
> +		.width = 254,
> +		.height = 169,
>  	},
>  	.delay = {
>  		.hpd_absent_delay = 200,
> @@ -2456,8 +2456,8 @@ static const struct of_device_id platform_of_match[] = {
>  		.compatible = "innolux,n156bge-l21",
>  		.data = &innolux_n156bge_l21,
>  	}, {
> -		.compatible = "innolux,tv123wam",
> -		.data = &innolux_tv123wam,
> +		.compatible = "innolux,p120zdg-bf1",
> +		.data = &innolux_p120zdg_bf1,
>  	}, {
>  		.compatible = "innolux,zj070na-01p",
>  		.data = &innolux_zj070na_01p,
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

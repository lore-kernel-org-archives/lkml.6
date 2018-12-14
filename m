Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587ABC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981A1206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="R+dHKaD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeLNPxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:53:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40136 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbeLNPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:53:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so3478638qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d57IrQvV+Fuzr2jRDg965wDhghkCT90mOvfDiC0upPo=;
        b=R+dHKaD/CXrNO5MNpHAg/K7ZhOm6laLzjK++Hb3gEnvvZnD50lLVptcwYgSVVeskIf
         HIeHuKCa8f2/MNJOKSmLu6WRV4Io1HT6Gg1MkLk989iRmndF5ZUAjWZKCHvsJwFRM6dd
         0TXTeZYdlEoqr5xOEgVNARX6N0tOJokr78PTGVLXWgjO3YyBfJWv6RnqzQUhhE7rTwsa
         ncQyLQxzz+/tqvCSTEGBPt57WGXE8r1h7bwNswKroMJW04BU9rF8rDAirjle+Xt9Dfxk
         ndJ4CVmmhE6WPikhM0KbMcoudzY44qXc6vK/wr8/24mbqyC/h5RlFJCHqal7XBxIuqC1
         DcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d57IrQvV+Fuzr2jRDg965wDhghkCT90mOvfDiC0upPo=;
        b=HkHUPRALFRxojwq++75rsc8NRzBneZWuCrgwcjYI2vKwCamGOFGaCP7aY1sTiy7GZV
         cxbCAUs7VPchbJKp3kW+qExLThoR6tBz14I+CXyOgFhGVWoFec+3uL2lbCXdz7BNyEHK
         n815w2bVBwfbjnjRPLlrcOpeJd1iXPQKNd1Vdgv3GT0fErDCY7Lmjiw6EoS+9hfzbyhA
         xCv5cj4TlWTSDGlYh/2SGhQpXJhOrL4QPC7zK7ti9XS0kZy4MRreXvunCok2waSonao9
         OVt6A75mvkbnXYi6rhSzmE5e9jAVCziGfQXwQ+QaH54yb6Zft8xpJ3iQ0nFdE8f1SAc7
         my4Q==
X-Gm-Message-State: AA+aEWY8goQF83X/CWRqVFuy6taeDj2OqtDV9fB2xx+M5oh2LAEfmrb1
        WPZqkZCZJa/pMMr+fsvYRY/shw==
X-Google-Smtp-Source: AFSGD/VYAmt24EpgmhNU2nBwBVDCsMwKdnj1kPx2j0O5/EQuvKe9EqoVU1FJRHbz4kyNCn+cyh1PmQ==
X-Received: by 2002:a37:c0db:: with SMTP id v88mr2983118qkv.288.1544802809261;
        Fri, 14 Dec 2018 07:53:29 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id t40sm3273564qth.46.2018.12.14.07.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 07:53:28 -0800 (PST)
Date:   Fri, 14 Dec 2018 10:53:28 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: Re: [DPU =?iso-8859-1?Q?PATCH=A0?= =?iso-8859-1?Q?=5D?= drm/msm/dpu:
 Ignore alpha for XBGR8888 format
Message-ID: <20181214155328.GS154160@art_vandelay>
References: <1543578770-25708-1-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543578770-25708-1-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 05:22:50PM +0530, Jayant Shekhar wrote:
> Alpha enable in the pixel format will help in
> selecting the blend rule. By keeping alpha enable
> to true we are allowing foreground alpha to blend
> with the layer. If alpha is don't care, then we
> should not allow pixel alpha to be part of blend
> equation.
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Pushed to dpu-staging/for-next.

Thanks for your patch!

Sean

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> index bfcd165..d743e7c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
> @@ -216,7 +216,7 @@ struct dpu_media_color_map {
>  	INTERLEAVED_RGB_FMT(XBGR8888,
>  		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
>  		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
> -		true, 4, 0,
> +		false, 4, 0,
>  		DPU_FETCH_LINEAR, 1),
>  
>  	INTERLEAVED_RGB_FMT(RGBA8888,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

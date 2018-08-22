Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6294AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A48F2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="RAJshmTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A48F2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeHVQW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:22:27 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35946 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeHVQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:22:27 -0400
Received: by mail-yb0-f196.google.com with SMTP id d34-v6so614345yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jzz5lqyzj9c66rnltmG2lL1I83fDrpeSSVojr+t8KIY=;
        b=RAJshmTBtHkHOrCsM0T6NgGJLXlMeg/LV+LUKitK3b70S+Z3V8XryfDr/4tjVJ0pHw
         qHqUrRjga6kJ38/TeaIpLSKlTYNIWhIqtXz9wtmQLsD60fdZMpLpTUqJg3tUtDJiVznx
         Mvr1BC5Q8SEtlBzqtjk0H936wTQF7HLq0rhYDhv9+81BVOpWhG4mSPr7mgCIgiRN1ZfC
         7w0Glk3GaEBBmtjk+Rjd3QSi16oh2tx7w4yhZgfYsTV/sy7l1NV13xn5b15r6mEmi9P2
         b/IxKCxjdigHcThRt/+E2njMJnlaXtvxJeo6PQpwHOAwesj2Vbi2v3YrjuUWM6KTbgs8
         AWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jzz5lqyzj9c66rnltmG2lL1I83fDrpeSSVojr+t8KIY=;
        b=rCqgAsTA0Q5Qg0mSz9cPX3m/KCpoWysClp4XqFpc0QgXNmEXEm11Za9/euTExvIAZ9
         Y3Ior/CEaU7IZmFTU2Rs7c/5qIy5UrLHZXMLjiQQP1KqdpLPOlDb6mTEJ+YdaGHB9uJ2
         YIYGtcxkC6/Qa7udAIQC9fbgDpqQziHjqVRwNc/GH0Rs8dbAliKra962OVHBqzZcmDy8
         cNhafoZhc4nnjlB5VFrJVGjqTGO5oYfaa4NN+E1gK07Za0qPfnNKCL4Xa0r7LZswQYiI
         qRKTixjVFijXIyVHImUsq9DE7/LOAbGj/TfSzbaxRVIWTaSNsqyVcMMxrRBPXF42oGtt
         Jr9Q==
X-Gm-Message-State: AOUpUlEWaI8dmF8pIMsZrng+YTN4+npQYh0SfvnfKSnCKLfYb7u6e9hR
        U2ZNsK/rqv62mn1HeQ91WIX5qw==
X-Google-Smtp-Source: AA+uWPxb4Ry2bUmNy9dSXD28jV6DMBy+AhYf3TIgNyALP+yVlB/U4HLA/dfxjotXeffmIgNqvy7CeA==
X-Received: by 2002:a25:e482:: with SMTP id b124-v6mr28577302ybh.127.1534942657469;
        Wed, 22 Aug 2018 05:57:37 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id w6-v6sm713420ywg.3.2018.08.22.05.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 05:57:37 -0700 (PDT)
Date:   Wed, 22 Aug 2018 08:57:36 -0400
From:   Sean Paul <sean@poorly.run>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        John Stultz <john.stultz@linaro.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/4] drm/fb: Stop leaking physical address
Message-ID: <20180822125736.GV164269@art_vandelay>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
 <20180822085405.10787-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180822085405.10787-4-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:54:05AM +0200, Daniel Vetter wrote:
> For buffer sharing, use dma-buf instead. We can't set smem_start to 0
> unconditionally since that's used by the fbdev mmap default
> implementation. And we have plenty of userspace which would like to
> keep that working.
> 
> This might break legit userspace - if it does we need to look at a
> case-by-cases basis how to handle that. Worst case I expect overrides
> for only specific drivers, since anything remotely modern should be
> using dma-buf/prime now (which is about 7 years old now for DRM
> drivers).
> 
> This issue was uncovered because Noralf's rework to implement a
> generic fb_probe also implements it's own fb_mmap callback. Which
> means smem_start didn't have to be set anymore, which blew up some
> blob in userspace rather badly.
> 
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

After clarifying on IRC, I think this makes sense. The chance to break userspace
requires a very specific configuration that I don't expect will be common.

Acked-by: Sean Paul <seanpaul@chromium.org>

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 4b0dd20bccb8..bcb78693c4f7 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -2673,6 +2673,8 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
>  
>  	info = fb_helper->fbdev;
>  	info->var.pixclock = 0;
> +	/* don't leak any physical addresses to userspace */
> +	info->flags |= FBINFO_HIDE_SMEM_START;
>  
>  	/* Need to drop locks to avoid recursive deadlock in
>  	 * register_framebuffer. This is ok because the only thing left to do is
> -- 
> 2.18.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

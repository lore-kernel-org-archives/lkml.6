Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4093AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A9220700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="S0Z43LIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A9220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLFQOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:14:33 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33443 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeLFQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:14:33 -0500
Received: by mail-yb1-f195.google.com with SMTP id f125so843530ybc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t09BdzwjWvguY4YKHSIexRTDwMCnh+rppGbPm+alkWw=;
        b=S0Z43LIk/cYa+e0A9HYsjtezzTaPCKUzgdQO4d8U/kMcaB/eF2hxD92sTzM6nQ9Bkj
         DYwE0czN0PutNK5bRq2SHC9ZxRRrno+NaY8UunN8T1BXqg4CGSYGLPb4trgu8KP1E6nM
         pv4/tiPUZbc6Cx8+Hlpl9Wt4067+RNEA3rV7jUHEn0ka6HHyLMWa4rxL4JHdU5wHAglO
         Sv1RnIsTVzo3E7MlyQRjlJvWj4eO1+dRfQd8xoPeSqFgxHWvgBVbtwzIohWKq7XcjGpb
         imms3xvbVZDsJ/S2TOTsGrvqK0Q/F8tLuodrMP/mg2kPOCwXsbgGgWTMx1u/0qdayoZT
         8Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t09BdzwjWvguY4YKHSIexRTDwMCnh+rppGbPm+alkWw=;
        b=gRshcrwt0T/BJubcEUW6B5O02H8sUnsSsMW1Rs+CRuG7b5qgsYICEgomNwJuezSWNt
         jeGHlwpXJ7xQmVgEibq0VP1mqPP1QzqcGUuv+V15WzPtO1zyjITzh2Qz8MNFDmP9dbon
         wes0B1NfldWa8nspI8CGUZcSgMkhyvQ821zObdMGBeaoaao+/AJnNn0PM9cMHVNa0A25
         n6+fcTlVeh0KKLta22XUxhAQoXxwnZ34DK/HADIPk4JF4x9YaAy9LoYl8wglIAkpghDh
         8FcSKQcPSah81DM4Mz/kn4POlwi0W1vtJoz0BwgTZlARngJ07V9N4aE/nCPEYuH2Gy+6
         u0ig==
X-Gm-Message-State: AA+aEWZAbRVk2GiQkgPePLAMxUgZj4yqYbM9M87ADS38AmrMZkzSdCYz
        YiOjHAvKeUwo62Df7JWYoXS95w==
X-Google-Smtp-Source: AFSGD/XMk5LBqQD2HR2hbtXp+rNpOegozeqAM5inh1n43QKHI3bv+2zsPHiR0pBhjIeAc1TGjuYTrA==
X-Received: by 2002:a5b:d07:: with SMTP id y7-v6mr5525982ybp.385.1544112872110;
        Thu, 06 Dec 2018 08:14:32 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id n16sm564259ywn.31.2018.12.06.08.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:14:31 -0800 (PST)
Date:   Thu, 6 Dec 2018 11:14:31 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: Re: [DPU PATCH] drm/msm/dpu: Fix vblank refcount mismatch
Message-ID: <20181206161431.GA154160@art_vandelay>
References: <1544078813-10945-1-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544078813-10945-1-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 12:16:53PM +0530, Jayant Shekhar wrote:
> _dpu_crtc_vblank_enable_no_lock releases crtc_lock as
> its needed for power handle operations. This opens up a
> window where in a thread running dpu_crtc_disable and a thread
> running dpu_crtc_vblank can race in using dpu_crtc->enabled.

Looks like you're using an old kernel. Both power_handle and
vblank_enable_no_lock were removed.

If you want something more up-to-date for testing, grab the mtp-testing
branch from my dpu-staging tree [1]

Sean

[1]- https://gitlab.freedesktop.org/seanpaul/dpu-staging.git

> 
> dpu_crtc_disable will change the state, where as dpu_crtc_vblank
> use the variable. The fix is to cache the crtc enabled state
> while holding the lock and use it as a gate in calling
> _dpu_crtc_vblank_enable_no_lock.
> 
> This issue was introduced with the commit cf871c48
> (drm/msm/dpu: Remove suspend state tracking from crtc).
> 
> Below are stack traces of thread 1 and thread 2 in good case
> and bad case:
> 
> Bad case:
> -------------
> Thread 1
> dpu_encoder_phys_vid_control_vblank_irq+0xd0/0x170
> dpu_encoder_register_vblank_callback+0xb8/0x100
> _dpu_crtc_vblank_enable_no_lock+0x240/0x288
> dpu_crtc_disable+0xc4/0x288
> drm_atomic_helper_commit_modeset_disables+0x19c/0x350
> msm_atomic_commit_tail+0x48/0x144
> commit_tail+0x44/0x70
> drm_atomic_helper_commit+0xf0/0xf8
> drm_atomic_commit+0x40/0x4c
> drm_mode_atomic_ioctl+0x374/0x90c
> drm_ioctl_kernel+0xac/0xec
> drm_ioctl+0x218/0x384
> drm_compat_ioctl+0xd8/0xe8
> 
> Thread 2:
> dpu_encoder_phys_vid_control_vblank_irq+0x74/0x170
> dpu_encoder_register_vblank_callback+0xb8/0x100
> _dpu_crtc_vblank_enable_no_lock+0x240/0x288
> dpu_crtc_vblank+0xa8/0x118
> dpu_kms_disable_vblank+0x20/0x2c
> vblank_ctrl_worker+0xa0/0xe0
> kthread_worker_fn+0xe4/0x1a4
> kthread+0x11c/0x12c
> ret_from_fork+0x10/0x18
> 
> Good case:
> --------------
> Thread 1:
> dpu_encoder_phys_vid_control_vblank_irq+0xd0/0x170
> dpu_encoder_phys_vid_irq_control+0xc8/0x110
> _dpu_encoder_irq_control+0x48/0xa0
> _dpu_encoder_resource_control_helper+0xb4/0x10c
> dpu_encoder_resource_control+0x4e0/0x664
> dpu_encoder_virt_enable+0xb8/0x120
> dpu_kms_encoder_enable+0x34/0xcc
> drm_atomic_helper_commit_modeset_enables+0x120/0x1b8
> msm_atomic_commit_tail+0x5c/0x144
> commit_tail+0x44/0x70
> drm_atomic_helper_commit+0xf0/0xf8
> drm_atomic_commit+0x40/0x4c
> drm_mode_atomic_ioctl+0x374/0x90c
> 
> Thread 2:
> dpu_crtc_vblank+0xc8/0x118
> dpu_kms_disable_vblank+0x20/0x2c
> vblank_ctrl_worker+0xa0/0xe0
> kthread_worker_fn+0xe4/0x1a4
> kthread+0x11c/0x12c
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 630cbaa..e81ad8c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -877,6 +877,7 @@ static void dpu_crtc_disable(struct drm_crtc *crtc)
>  	struct drm_encoder *encoder;
>  	struct msm_drm_private *priv;
>  	unsigned long flags;
> +	bool crtc_en;
>  
>  	if (!crtc || !crtc->dev || !crtc->dev->dev_private || !crtc->state) {
>  		DPU_ERROR("invalid crtc\n");
> @@ -901,11 +902,21 @@ static void dpu_crtc_disable(struct drm_crtc *crtc)
>  				atomic_read(&dpu_crtc->frame_pending));
>  
>  	trace_dpu_crtc_disable(DRMID(crtc), false, dpu_crtc);
> -	if (dpu_crtc->enabled && dpu_crtc->vblank_requested) {
> -		_dpu_crtc_vblank_enable_no_lock(dpu_crtc, false);
> -	}
> +
> +	/*
> +	 * Cache vblank enabled before calling _dpu_crtc_vblank_enable_no_lock,
> +	 * because we release crtc_lock inside and acquire it back. While lock
> +	 * is released, there are cases where dpu_crtc_vblank comes in between
> +	 * while disable is going on. dpu_crtc_vblank further calls
> +	 * _dpu_crtc_vblank_enable_no_lock which tries vblank disable again
> +	 * resulting in refcount mismatch.
> +	 */
> +	crtc_en = dpu_crtc->enabled;
>  	dpu_crtc->enabled = false;
>  
> +	if (crtc_en && dpu_crtc->vblank_requested)
> +		_dpu_crtc_vblank_enable_no_lock(dpu_crtc, false);
> +
>  	if (atomic_read(&dpu_crtc->frame_pending)) {
>  		trace_dpu_crtc_disable_frame_pending(DRMID(crtc),
>  				     atomic_read(&dpu_crtc->frame_pending));
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

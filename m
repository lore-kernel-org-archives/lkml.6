Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2232621726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="SyEAaaX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfAVULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:11:47 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43076 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfAVULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:11:47 -0500
Received: by mail-yb1-f194.google.com with SMTP id e12so2969714ybn.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TCPEP+CqMrDN6Pz8Hrg0eJY1fvSU3/CK0BJWcCFFugQ=;
        b=SyEAaaX6s4C9u/Yf4s9uGz0e+Z8lRFui2pAZbB2DZ2ZbsoXqmJ/rEyo2WeyhrzEhek
         Gz0hvkE00pymmpj7ZlBqY0Ww7Jir4D/GkgfIZoYFEdIqrKV38rMTqk7zvK1b8d7ie8I4
         Yds/k1E41P/eF9ZusCGRgwSlpbWklWQ/Y3/sN2SaKTGSujsFO0cVAWF8K+uoMD4Jubb8
         FqPRZtdSVtvpPiXx/iDb6xcvetJmjELjFAN3NlBHxJkBFzPetRbgkI928SWONNMmrW3g
         hS+YoEFBzTNnVQ+Ex541HvI2+kR2fwl1axPU1Z49FX19JvZDzpvPxKFQUv3oyHC/hitJ
         EAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TCPEP+CqMrDN6Pz8Hrg0eJY1fvSU3/CK0BJWcCFFugQ=;
        b=gxOPLkyWc61X6iS24CvLk/WtP6fIvyQq83zYs2Ut7wa7tsrSh9WlYEa32+/B3dVlVj
         ZX3Bf8V6mKYC74YojMFQi5z7lS9Zkw7ZXgc9/gBj/wR+K4mKiNQArg3ROSIcR4t1GT9z
         msZcRAidDSp1dHnwe2+1OFyETgPch+bUtrLYOP0R3ZUPfRTE2EZEfL+yRjtozOH4TlcS
         8+XWIWb5wUeWLmh8c4gKowtmz6ktrgnzoyZfHqD5hkqTVvDmHwhy1DQqvIXp/EwD97Fp
         mX91oIl8Tm9ukr8ppQF8gC/kbDjllJ2y1u9jyjxOEVOjkxCfUgkFFRmCGVvOYUccppgd
         DMmw==
X-Gm-Message-State: AJcUukfftzrXz6nE2fZ0+QCipE0QNgZldsLiMEY1aY8Oahbmw71oQDrO
        y2sz/61nP5PDN3/q1QxUnCmHKQ==
X-Google-Smtp-Source: ALg8bN4Nb0836VsIJZOm5XT8nyAARUG1OS0yaevnBzv+OBCae2BLNTjMS6IAqTxz7PGbVFWcpmevPw==
X-Received: by 2002:a25:690a:: with SMTP id e10mr22373790ybc.279.1548187905824;
        Tue, 22 Jan 2019 12:11:45 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id j16sm7135844ywg.4.2019.01.22.12.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:11:45 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:11:44 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhinavk@codeaurora.org,
        robdclark@gmail.com, nganji@codeaurora.org, seanpaul@chromium.org,
        hoegsberg@chromium.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org
Subject: Re: [Freedreno] [v1] drm/msm/dpu: Cleanup dpu plane interface
Message-ID: <20190122201144.GK114153@art_vandelay>
References: <1545139238-8395-1-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545139238-8395-1-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:50:38PM +0530, Jayant Shekhar wrote:
> Remove unused functions from dpu plane interface
> and unused variables from dpu plane state structure.
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Applied to dpu-staging, thanks!

Sean
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> index 7fed0b6..0e6063a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> @@ -28,23 +28,18 @@
>  /**
>   * struct dpu_plane_state: Define dpu extension of drm plane state object
>   * @base:	base drm plane state object
> - * @property_state: Local storage for msm_prop properties
> - * @property_values:	cached plane property values
>   * @aspace:	pointer to address space for input/output buffers
> - * @input_fence:	dereferenced input fence pointer
>   * @stage:	assigned by crtc blender
>   * @multirect_index: index of the rectangle of SSPP
>   * @multirect_mode: parallel or time multiplex multirect mode
>   * @pending:	whether the current update is still pending
>   * @scaler3_cfg: configuration data for scaler3
>   * @pixel_ext: configuration data for pixel extensions
> - * @scaler_check_state: indicates status of user provided pixel extension data
>   * @cdp_cfg:	CDP configuration
>   */
>  struct dpu_plane_state {
>  	struct drm_plane_state base;
>  	struct msm_gem_address_space *aspace;
> -	void *input_fence;
>  	enum dpu_stage stage;
>  	uint32_t multirect_index;
>  	uint32_t multirect_mode;
> @@ -107,12 +102,6 @@ void dpu_plane_get_ctl_flush(struct drm_plane *plane, struct dpu_hw_ctl *ctl,
>  void dpu_plane_flush(struct drm_plane *plane);
>  
>  /**
> - * dpu_plane_kickoff - final plane operations before commit kickoff
> - * @plane: Pointer to drm plane structure
> - */
> -void dpu_plane_kickoff(struct drm_plane *plane);
> -
> -/**
>   * dpu_plane_set_error: enable/disable error condition
>   * @plane: pointer to drm_plane structure
>   */
> @@ -147,14 +136,6 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
>  void dpu_plane_clear_multirect(const struct drm_plane_state *drm_state);
>  
>  /**
> - * dpu_plane_wait_input_fence - wait for input fence object
> - * @plane:   Pointer to DRM plane object
> - * @wait_ms: Wait timeout value
> - * Returns: Zero on success
> - */
> -int dpu_plane_wait_input_fence(struct drm_plane *plane, uint32_t wait_ms);
> -
> -/**
>   * dpu_plane_color_fill - enables color fill on plane
>   * @plane:  Pointer to DRM plane object
>   * @color:  RGB fill color value, [23..16] Blue, [15..8] Green, [7..0] Red
> @@ -164,12 +145,4 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
>  int dpu_plane_color_fill(struct drm_plane *plane,
>  		uint32_t color, uint32_t alpha);
>  
> -/**
> - * dpu_plane_set_revalidate - sets revalidate flag which forces a full
> - *	validation of the plane properties in the next atomic check
> - * @plane: Pointer to DRM plane object
> - * @enable: Boolean to set/unset the flag
> - */
> -void dpu_plane_set_revalidate(struct drm_plane *plane, bool enable);
> -
>  #endif /* _DPU_PLANE_H_ */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
Sean Paul, Software Engineer, Google / Chromium OS

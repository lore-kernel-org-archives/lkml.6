Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DC3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E496217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gu/92RTk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AUd3U2pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeLRRAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:00:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44726 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:00:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F1C06076A; Tue, 18 Dec 2018 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545152441;
        bh=97s/uwaXgQiS+M+mDMfe0ViAYYmU9l5quClUgsjMwK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu/92RTklv0OAXtHMWM9SoKUAKgJRhJr1ZuZHqqB7kQFMAhQ096xxlbrWVyniZK5z
         nXwL/6/GcDl8b0JpnnlYLCcYKl3APFNRr4WJ2DkrwBAVA6ZU/sICEpbU8GgNFbUvEV
         sZZ6RSZzDhSiJWdHlRpWy+9oKrDSxJjeGzgiK1V0=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37257605A5;
        Tue, 18 Dec 2018 17:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545152440;
        bh=97s/uwaXgQiS+M+mDMfe0ViAYYmU9l5quClUgsjMwK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUd3U2pdr8b36ifUGqkDFWg4oWSF4jvJlhe+JQg2EEd5ov9q0P/z8/xiJxI6sHxur
         aRGy1xs+GtyHlsLpGN5URBL/IwTfooMqB7yFwyveznSiPrgGbfrYjYaIjMxuy/RK9N
         4LJlT3wUc2ZTHFgJ48JszkkxvLGWmyZtCGnio5K8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37257605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 18 Dec 2018 10:00:37 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhinavk@codeaurora.org,
        robdclark@gmail.com, nganji@codeaurora.org, seanpaul@chromium.org,
        hoegsberg@chromium.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org
Subject: Re: [Freedreno] [v1] drm/msm/dpu: Cleanup dpu plane interface
Message-ID: <20181218170036.GB18380@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Jayant Shekhar <jshekhar@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, abhinavk@codeaurora.org,
        robdclark@gmail.com, nganji@codeaurora.org, seanpaul@chromium.org,
        hoegsberg@chromium.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org
References: <1545139238-8395-1-git-send-email-jshekhar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545139238-8395-1-git-send-email-jshekhar@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:50:38PM +0530, Jayant Shekhar wrote:
> Remove unused functions from dpu plane interface
> and unused variables from dpu plane state structure.
> 
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

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
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

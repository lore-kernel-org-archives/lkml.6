Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ADEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BEC21534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g24vVkLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BEC21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeHTNcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:32:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38448 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHTNcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:32:08 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 500E0CD;
        Mon, 20 Aug 2018 12:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534760226;
        bh=b7RwFsgCCJANq5WQQueCwm9PZoa1YMzkCG241Zh53gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g24vVkLPZzIcuX3WCPmskCxjliVsTL5Rg1T68UgNqVuIirotINWCPwZnfspXvI5aM
         hzQZtq9uRr9/nBUhfIL2ZFmExgtx9NYIZhm4RevXbJ6aQlOnubNVn2hMRQA/5woTY1
         96KuID1i+ZNVThcDaQXtzE0bfayonrCRJnfeNFmI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH 2/3] drm: rcar-du: Rename var to a more precise name
Date:   Mon, 20 Aug 2018 13:18:02 +0300
Message-ID: <2728893.bj0XmGXJbu@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1532971214-17962-3-git-send-email-jacopo@jmondi.org>
References: <1532971214-17962-1-git-send-email-jacopo@jmondi.org> <1532971214-17962-3-git-send-email-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Monday, 30 July 2018 20:20:13 EEST Jacopo Mondi wrote:
> Rename the 'value' variable, only used to for writing to DMSR register to a
> more precise 'dmsr' name.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>

I think this simple change can be squashed with patch 1/3.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c index 6d55cec..4d7907c 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -208,7 +208,7 @@ static void rcar_du_crtc_set_display_timing(struct
> rcar_du_crtc *rcrtc) const struct drm_display_mode *mode =
> &rcrtc->crtc.state->adjusted_mode; struct rcar_du_device *rcdu =
> rcrtc->group->dev;
>  	unsigned long mode_clock = mode->clock * 1000;
> -	u32 value;
> +	u32 dsmr;
>  	u32 escr;
> 
>  	if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
> @@ -299,11 +299,11 @@ static void rcar_du_crtc_set_display_timing(struct
> rcar_du_crtc *rcrtc) rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ?
> OTAR2 : OTAR, 0);
> 
>  	/* Signal polarities */
> -	value = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? DSMR_VSL : 0)
> -	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? DSMR_HSL : 0)
> -	      | ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? DSMR_ODEV : 0)
> -	      | DSMR_DIPM_DISP | DSMR_CSPM;
> -	rcar_du_crtc_write(rcrtc, DSMR, value);
> +	dsmr = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? DSMR_VSL : 0)
> +	       | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? DSMR_HSL : 0)
> +	       | ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? DSMR_ODEV : 0)
> +	       | DSMR_DIPM_DISP | DSMR_CSPM;
> +	rcar_du_crtc_write(rcrtc, DSMR, dsmr);
> 
>  	/* Display timings */
>  	rcar_du_crtc_write(rcrtc, HDSR, mode->htotal - mode->hsync_start - 19);


-- 
Regards,

Laurent Pinchart




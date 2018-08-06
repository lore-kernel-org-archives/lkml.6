Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A8EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A3E21A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jnxch544"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A3E21A52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbeHFR67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:58:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37018 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:58:59 -0400
Received: from [192.168.0.67] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD6541BEB;
        Mon,  6 Aug 2018 17:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533570555;
        bh=InzS7AsdJaFHmxa6AQSDUxEnqs5wtUvC4UHPxQPS8FU=;
        h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
        b=jnxch544XMlttYIcUT1CB/n6egi8Z0PvvZeRTWNUEHCpkxzU70QEEsVmcqH1KHo3/
         YdosEKkbUdIfBV+RD4Oy/pIrDQrSPBQ6Q0XJk0KU6GoNII9XRfnBAHZhbEVa6NvKcb
         2+RvQ9uKu8LjcxZnVJ+14b9IuLt+L6XZBPVshL8o=
Subject: Re: [PATCH 2/3] drm: rcar-du: Rename var to a more precise name
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <1532971214-17962-1-git-send-email-jacopo@jmondi.org>
 <1532971214-17962-3-git-send-email-jacopo@jmondi.org>
Reply-To: kieran.bingham+renesas@ideasonboard.com
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <8ddd8179-a0c7-1fbe-0390-ea8fd8c0ff7b@ideasonboard.com>
Date:   Mon, 6 Aug 2018 16:49:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532971214-17962-3-git-send-email-jacopo@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thankyou for the patch,

On 30/07/18 18:20, Jacopo Mondi wrote:
> Rename the 'value' variable, only used to for writing to DMSR register to a
> more precise 'dmsr' name.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> index 6d55cec..4d7907c 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -208,7 +208,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  	const struct drm_display_mode *mode = &rcrtc->crtc.state->adjusted_mode;
>  	struct rcar_du_device *rcdu = rcrtc->group->dev;
>  	unsigned long mode_clock = mode->clock * 1000;
> -	u32 value;
> +	u32 dsmr;
>  	u32 escr;
>  
>  	if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
> @@ -299,11 +299,11 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? OTAR2 : OTAR, 0);
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

Quite nit-picky I'm afraid, but here, you have increased the indent such
that the '|' operator is now aligned with the first '(', rather than the
'=' as used by the rest of the driver.

Was this intentional ?

I think it should be brought forwards to align under the '=' to match.


> +	rcar_du_crtc_write(rcrtc, DSMR, dsmr);
>  
>  	/* Display timings */
>  	rcar_du_crtc_write(rcrtc, HDSR, mode->htotal - mode->hsync_start - 19);
> 


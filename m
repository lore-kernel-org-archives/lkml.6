Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CBEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4040321A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XXdhJxN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4040321A5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbeHFTSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:18:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41900 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFTSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:18:18 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A24C41BEB;
        Mon,  6 Aug 2018 19:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533575296;
        bh=cVVOObWIEo3Pv2o7NvaypVzQbSkL+mt4iAGorAsiPq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXdhJxN+EJ4QOP9VSeGX5H+vHXusrWLNdjoePO4f6RSkD1FspFyY1HhNQlT/TQrit
         fu2IgyjBlFf559NhpUWDYm1Ko2zO20kz/ZCcD/LrWH2AHuegcBkCV0IEWhoeMHsiOB
         GkK6KO4jqByxBIgipVmfWSE+KZJ3vNkTS8w7k/8E=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     kieran.bingham+renesas@ideasonboard.com
Cc:     Jacopo Mondi <jacopo@jmondi.org>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR RENESAS" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH 2/3] drm: rcar-du: Rename var to a more precise name
Date:   Mon, 06 Aug 2018 20:08:59 +0300
Message-ID: <2766858.dkh6WOvVc0@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <8ddd8179-a0c7-1fbe-0390-ea8fd8c0ff7b@ideasonboard.com>
References: <1532971214-17962-1-git-send-email-jacopo@jmondi.org> <1532971214-17962-3-git-send-email-jacopo@jmondi.org> <8ddd8179-a0c7-1fbe-0390-ea8fd8c0ff7b@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Monday, 6 August 2018 18:49:12 EEST Kieran Bingham wrote:
> On 30/07/18 18:20, Jacopo Mondi wrote:
> > Rename the 'value' variable, only used to for writing to DMSR register to
> > a more precise 'dmsr' name.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > ---
> > 
> >  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c index 6d55cec..4d7907c 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > @@ -208,7 +208,7 @@ static void rcar_du_crtc_set_display_timing(struct
> > rcar_du_crtc *rcrtc)> 
> >  	const struct drm_display_mode *mode = &rcrtc->crtc.state-
>adjusted_mode;
> >  	struct rcar_du_device *rcdu = rcrtc->group->dev;
> >  	unsigned long mode_clock = mode->clock * 1000;
> > 
> > -	u32 value;
> > +	u32 dsmr;
> > 
> >  	u32 escr;
> >  	
> >  	if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
> > 
> > @@ -299,11 +299,11 @@ static void rcar_du_crtc_set_display_timing(struct
> > rcar_du_crtc *rcrtc)> 
> >  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? OTAR2 : OTAR, 0);
> >  	
> >  	/* Signal polarities */
> > 
> > -	value = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? DSMR_VSL : 0)
> > -	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? DSMR_HSL : 0)
> > -	      | ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? DSMR_ODEV : 0)
> > -	      | DSMR_DIPM_DISP | DSMR_CSPM;
> > -	rcar_du_crtc_write(rcrtc, DSMR, value);
> > +	dsmr = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? DSMR_VSL : 0)
> > +	       | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? DSMR_HSL : 0)
> > +	       | ((mode->flags & DRM_MODE_FLAG_INTERLACE) ? DSMR_ODEV : 0)
> > +	       | DSMR_DIPM_DISP | DSMR_CSPM;
> 
> Quite nit-picky I'm afraid, but here, you have increased the indent such
> that the '|' operator is now aligned with the first '(', rather than the
> '=' as used by the rest of the driver.
> 
> Was this intentional ?
> 
> I think it should be brought forwards to align under the '=' to match.

Agreed.

For the record, this change was part of patch 1/3 that I provided on its own 
to Jacopo, who then split it out. I'd be inclined to squash the two changes 
back together, I don't think this rename requires a patch of its own.

> > +	rcar_du_crtc_write(rcrtc, DSMR, dsmr);
> > 
> >  	/* Display timings */
> >  	rcar_du_crtc_write(rcrtc, HDSR, mode->htotal - mode->hsync_start - 19);

-- 
Regards,

Laurent Pinchart




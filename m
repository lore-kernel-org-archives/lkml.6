Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7993ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8643E21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8643E21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391379AbeIVCHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:07:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39857 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391251AbeIVCHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:07:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id o15-v6so2998303qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YwAldcT1nHBcLILO5Q5qY3KltnsJP3C4zM2OL8rHJ9Q=;
        b=BMLiWll6tyhbZthjEhSz7NGvhTMonx0ddi4Y+E12O8v3c/oBYnfE5+7SGdZUwxG2OQ
         coH9Rj58FKyijfm0wFXqW1e1U/t3EU/3zvOvOg6m8/a+Hloz0IhJ0lIuRrvL2N4hYdiU
         mAGLZjh69G7EF7uyQTOUPZf2/Tjd/LxNNPFv3IuwdxIw8/oZ27rS8xxtENQVcsQ1VNOs
         H31RiuehMzo/+ptSKvATcTzQ5e3cLugqs+QAM2WDiXc4Kl8cTNG3//RYpw9CuJfgnh1U
         SZtOCcqf4/6ptoaEXVveHiC5tEMk9NCAkE9LrNrH6AjSz3ReGCbifw7jnwfp49LuKKxK
         k5Qw==
X-Gm-Message-State: APzg51Bdx+MRjIRPu6J0e73/iUl9XvEhEAv6fSbpD+wkryP0bY2OFST2
        f/b6HQxotfmVoFBCB9ouM18AgQ==
X-Google-Smtp-Source: ANB0Vdarw2oi5Ycr+nDjprFgfJhL2BOAs0Mbr4Pd+VzwzK/z4bSA5rc76KL5x1Mh/RO1MqISmGCM+w==
X-Received: by 2002:aed:3baf:: with SMTP id r44-v6mr32607044qte.77.1537561039181;
        Fri, 21 Sep 2018 13:17:19 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id c184-v6sm15385933qkd.43.2018.09.21.13.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 13:17:18 -0700 (PDT)
Message-ID: <472fd6a7a46d44c079ce45b67ed23dee35dd96cf.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH 3/6] drm/i915: Leave intel_conn->mst_port
 set, use mst_port_gone instead
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Fri, 21 Sep 2018 16:17:16 -0400
In-Reply-To: <20180921092746.GC11082@phenom.ffwll.local>
References: <20180918230637.20700-1-lyude@redhat.com>
         <20180918230637.20700-4-lyude@redhat.com>
         <20180921092746.GC11082@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 11:27 +0200, Daniel Vetter wrote:
> On Tue, Sep 18, 2018 at 07:06:19PM -0400, Lyude Paul wrote:
> > Currently we set intel_connector->mst_port to NULL to signify that the
> > MST port has been removed from the system so that we can prevent further
> > action on the port such as connector probes, mode probing, etc.
> > However, we're going to need access to intel_connector->mst_port in
> > order to fixup ->best_encoder() so that it can always return the correct
> > encoder for an MST port to prevent legacy DPMS prop changes from
> > failing. This should be safe, so instead keep intel_connector->mst_port
> > always set and instead add intel_connector->mst_port_gone in order to
> > signify whether or not the connector has disappeared from the system.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> Hm, how exactly do legacy DPMS setprop blow up here? Or at least I can't
> come up with a scenario that's specific to legacy props, atomic should be
> equally affected. By the time we land in this code, the core code already
> remapping it to be purely an atomic update.
So, what I've been seeing with X that's been blowing this up:
 * Hotplug event gets received, X does reprobe
 * Notices MST connectors are now disconnected, sets DPMS from on->off
 * During atomic_check, drm_atomic_helper_check_modeset() is called
 * update_connector_routing() gets called
 * funcs->best_encoder() returns NULL for the encoder
 * update_connector_routing() fails atomic commit with "No suitable encoder
   found", line 320 of drm_atomic_helper
> 
> Another thought: Should we handle at least some of this in the probe
> helpers? I.e. once you unplugged a drm_connector, it always shows
> disconnected and mode list is gone, instead of duplicating this over all
> drivers. We could just check connector->registered.
oooh, good idea! I will certainly go do that
> 
> Thanks, Daniel
> > ---
> >  drivers/gpu/drm/i915/intel_dp_mst.c | 14 +++++++-------
> >  drivers/gpu/drm/i915/intel_drv.h    |  1 +
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/intel_dp_mst.c
> > index 4ecd65375603..fcb9b87b9339 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -311,9 +311,8 @@ static int intel_dp_mst_get_ddc_modes(struct
> > drm_connector *connector)
> >  	struct edid *edid;
> >  	int ret;
> >  
> > -	if (!intel_dp) {
> > +	if (intel_connector->mst_port_gone)
> >  		return intel_connector_update_modes(connector, NULL);
> > -	}
> >  
> >  	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr,
> > intel_connector->port);
> >  	ret = intel_connector_update_modes(connector, edid);
> > @@ -328,9 +327,10 @@ intel_dp_mst_detect(struct drm_connector *connector,
> > bool force)
> >  	struct intel_connector *intel_connector =
> > to_intel_connector(connector);
> >  	struct intel_dp *intel_dp = intel_connector->mst_port;
> >  
> > -	if (!intel_dp)
> > +	if (intel_connector->mst_port_gone)
> >  		return connector_status_disconnected;
> > -	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
> > intel_connector->port);
> > +	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
> > +				      intel_connector->port);
> >  }
> >  
> >  static void
> > @@ -370,7 +370,7 @@ intel_dp_mst_mode_valid(struct drm_connector
> > *connector,
> >  	int bpp = 24; /* MST uses fixed bpp */
> >  	int max_rate, mode_rate, max_lanes, max_link_clock;
> >  
> > -	if (!intel_dp)
> > +	if (intel_connector->mst_port_gone)
> >  		return MODE_ERROR;
> >  
> >  	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
> > @@ -402,7 +402,7 @@ static struct drm_encoder
> > *intel_mst_atomic_best_encoder(struct drm_connector *c
> >  	struct intel_dp *intel_dp = intel_connector->mst_port;
> >  	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
> >  
> > -	if (!intel_dp)
> > +	if (intel_connector->mst_port_gone)
> >  		return NULL;
> >  	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
> >  }
> > @@ -514,7 +514,7 @@ static void intel_dp_destroy_mst_connector(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  						   connector);
> >  	/* prevent race with the check in ->detect */
> >  	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL);
> > -	intel_connector->mst_port = NULL;
> > +	intel_connector->mst_port_gone = true;
> >  	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex);
> >  
> >  	drm_connector_put(connector);
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > b/drivers/gpu/drm/i915/intel_drv.h
> > index 8fc61e96754f..87ce772ae7f8 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -409,6 +409,7 @@ struct intel_connector {
> >  	void *port; /* store this opaque as its illegal to dereference it */
> >  
> >  	struct intel_dp *mst_port;
> > +	bool mst_port_gone;
> >  
> >  	/* Work struct to schedule a uevent on link train failure */
> >  	struct work_struct modeset_retry_work;
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 
> 
-- 
Cheers,
	Lyude Paul


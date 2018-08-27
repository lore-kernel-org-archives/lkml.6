Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A67C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1FE2088E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1FE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeH0VdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:33:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45550 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeH0VdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:33:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id g44-v6so18333880qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=k0WvnEBJZv5JjK/q2tu4Fot7jyy3TQljWSq+0IXWu7E=;
        b=aNpdYmAyxprfeDodn9ONVbRlPCYIAdHdxaboQy+f5N5A365tOeN5qKHbZmx4h8zlIO
         21dd1lr0E/Vs8N3Bgp2fPyuix7iOsaus6JYuP4fXSOObidRy2C4nmt7W+RH/9PsYFTBM
         Q+Rcol2waq2RtPBdHA2RjQroK+NPswEOwF4t3k9R6QSPMAJ2uWeLa2v/zfz27ZOdxNCs
         QwjEBPW+yijx8OtURFE4AViFNP0E9aM52FbUxMfV5AACwE7vahc+C+6K1pFx7Owc4Ahk
         bSh6723VD70sK9gMe9BxiE2S8Z7unQg5+DWZV/9/frIwu+i0TiSAh9Rbs2fEKGRiSIzh
         fheQ==
X-Gm-Message-State: APzg51CoBSSBMIDB0obThsD115DpK2pv5B8cn0mTUu/LxU+OqZflpiP1
        l9749+UGtYyntBunB8yoZCC+hA==
X-Google-Smtp-Source: ANB0Vdbxutul1kTkgEMtzulLRmC6cC1ADAakfeiu7kR3D4y7JReTWT19H9+h4bjmDxvM5X97tChO7A==
X-Received: by 2002:a0c:d4ad:: with SMTP id u42-v6mr14738630qvh.247.1535391949482;
        Mon, 27 Aug 2018 10:45:49 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id o5-v6sm10446065qtc.63.2018.08.27.10.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 10:45:49 -0700 (PDT)
Message-ID: <d2a170d48fb58d0115898b19765e32cbeceee42c.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v4] drm/i915: Re-apply "Perform link quality
 check, unconditionally during long pulse"
From:   Lyude Paul <lyude@redhat.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Mon, 27 Aug 2018 13:45:48 -0400
In-Reply-To: <20180827120844.GR5565@intel.com>
References: <20180825191035.3945-1-lyude@redhat.com>
         <20180827120844.GR5565@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 15:08 +0300, Ville Syrjälä wrote:
> On Sat, Aug 25, 2018 at 03:10:35PM -0400, Lyude Paul wrote:
> > From: Jan-Marek Glogowski <glogow@fbihome.de>
> > 
> > This re-applies the workaround for "some DP sinks, [which] are a
> > little nuts" from commit 1a36147bb939 ("drm/i915: Perform link
> > quality check unconditionally during long pulse").
> > It makes the secondary AOC E2460P monitor connected via DP to an
> > acer Veriton N4640G usable again.
> > 
> > This hunk was dropped in commit c85d200e8321 ("drm/i915: Move SST
> > DP link retraining into the ->post_hotplug() hook")
> > 
> > Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the
> > ->post_hotplug() hook")
> > [Cleaned up commit message, added stable cc]
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> > Cc: stable@vger.kernel.org
> > ---
> > Resending this to update patchwork; will push in a little bit
> > 
> >  drivers/gpu/drm/i915/intel_dp.c | 33 +++++++++++++++++++--------------
> >  1 file changed, 19 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > b/drivers/gpu/drm/i915/intel_dp.c
> > index b3f6f04c3c7d..db8515171270 100644
> > --- a/drivers/gpu/drm/i915/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > @@ -4333,18 +4333,6 @@ intel_dp_needs_link_retrain(struct intel_dp
> > *intel_dp)
> >  	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
> >  }
> >  
> > -/*
> > - * If display is now connected check links status,
> > - * there has been known issues of link loss triggering
> > - * long pulse.
> > - *
> > - * Some sinks (eg. ASUS PB287Q) seem to perform some
> > - * weird HPD ping pong during modesets. So we can apparently
> > - * end up with HPD going low during a modeset, and then
> > - * going back up soon after. And once that happens we must
> > - * retrain the link to get a picture. That's in case no
> > - * userspace component reacted to intermittent HPD dip.
> > - */
> >  int intel_dp_retrain_link(struct intel_encoder *encoder,
> >  			  struct drm_modeset_acquire_ctx *ctx)
> >  {
> > @@ -5031,7 +5019,8 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
> >  }
> >  
> >  static int
> > -intel_dp_long_pulse(struct intel_connector *connector)
> > +intel_dp_long_pulse(struct intel_connector *connector,
> > +		    struct drm_modeset_acquire_ctx *ctx)
> >  {
> >  	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
> >  	struct intel_dp *intel_dp = intel_attached_dp(&connector->base);
> > @@ -5090,6 +5079,22 @@ intel_dp_long_pulse(struct intel_connector
> > *connector)
> >  		 */
> >  		status = connector_status_disconnected;
> >  		goto out;
> > +	} else {
> > +		/*
> > +		 * If display is now connected check links status,
> > +		 * there has been known issues of link loss triggering
> > +		 * long pulse.
> > +		 *
> > +		 * Some sinks (eg. ASUS PB287Q) seem to perform some
> > +		 * weird HPD ping pong during modesets. So we can apparently
> > +		 * end up with HPD going low during a modeset, and then
> > +		 * going back up soon after. And once that happens we must
> > +		 * retrain the link to get a picture. That's in case no
> > +		 * userspace component reacted to intermittent HPD dip.
> > +		 */
> > +		struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)-
> > >base;
> > +
> > +		intel_dp_retrain_link(encoder, ctx);
> 
> We should really have a comment here that this is purely duct tape for
> sinks that fail to signal a hpd when the link goes bad (either that or
> we fail to process the hpd correctly).
I'm fine with adding another patch to clarify that comment as well

> 
> I suppose a better way to do this hack would be to do the link quality
> check at the end of modeset, or from a delayed work. As is this depends
> on userspace/fbdev doing an explicit probe after the modeset which seems
> pretty fragile.
I think having that at the end of a modeset in addition to this would be a
good idea as well, I don't see any harm in having an additional check in the
long pulse handler in case something causes the link to become unstable at
some point in the future after the initial modeset

Jan, do you think you could provide some dmesg logs for this issue?
> 
> >  	}
> >  
> >  	/*
> > @@ -5151,7 +5156,7 @@ intel_dp_detect(struct drm_connector *connector,
> >  				return ret;
> >  		}
> >  
> > -		status = intel_dp_long_pulse(intel_dp->attached_connector);
> > +		status = intel_dp_long_pulse(intel_dp->attached_connector,
> > ctx);
> >  	}
> >  
> >  	intel_dp->detect_done = false;
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


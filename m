Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7773AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D97A208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D97A208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeH0V0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:26:36 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37431 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0V0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:26:36 -0400
Received: by mail-qk0-f194.google.com with SMTP id f17-v6so11057550qkh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KjB4sNLdATLnYeMf4MAveAHT4dXCurZcPmaGBF0Ls/4=;
        b=BI+keXHlLWq/nhyLqVWrfq4PApkrYmqWJgkjbIjLwDfwlmBxaslssajAwqDAptmD4h
         dL0XfZoa8vtb53hyqAFGPQ9o8b9RygKgP9IQe2uuTn5zeVsiloTkHLxle3GLcG08Yup+
         /b8x5aIm3VXxk/bKRX41XSm3Po6W93xyrHVXKtpyskIcU1GzzQ5mVApROldI6I4sPurA
         XJjy/hABVxJ7KSFpBg+bBTRy1z0MJTiNOrhZDAi2h/lZ4Wn7sVcRtFVmGXMuethLCvwt
         WD0Bh6F7vXhyID550RPHK6omYN/3nm3vT+fFT3dyTli5aOygBvZJor6GfsidmjDUmdyi
         Xiyw==
X-Gm-Message-State: APzg51BlDfvUNVawk4ODisOpbJusXOsz0lfiPksBKn0JzD3WJhNEOWNS
        A8MN86rQNVgXieIYNOaicHnWvQ==
X-Google-Smtp-Source: ANB0VdZtqxkVm8Bm2m2G+dqA71IMDcpxAlNMoPj4A67+g1eMeBvPZI3TTMVBoPMY0OV+2EU/9HsCiQ==
X-Received: by 2002:a37:d4dd:: with SMTP id s90-v6mr14767552qks.268.1535391543660;
        Mon, 27 Aug 2018 10:39:03 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id n25-v6sm11692077qtb.32.2018.08.27.10.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 10:39:03 -0700 (PDT)
Message-ID: <c87f70879c87b0d29880e32f6632c4c7acd337bb.camel@redhat.com>
Subject: Re: [PATCH v4] drm/i915: Re-apply "Perform link quality check,
 unconditionally during long pulse"
From:   Lyude Paul <lyude@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Jan-Marek Glogowski <glogow@fbihome.de>, stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Aug 2018 13:39:02 -0400
In-Reply-To: <871sak5hdu.fsf@intel.com>
References: <20180825191035.3945-1-lyude@redhat.com>
         <871sak5hdu.fsf@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 11:43 +0300, Jani Nikula wrote:
> On Sat, 25 Aug 2018, Lyude Paul <lyude@redhat.com> wrote:
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
> 
> Is there a bugzilla? Reference to a list discussion? Something with a
> dmesg where someone can actually verify this is the right fix?
This patch has actually been on the list for a while now-I have had mdnavare
take a look at it as well (they said it looked fine with the only change being
in regards to the comment), and it'd been on the list for a while already.

> 
> IMO needs an ack from Ville too. He should be in Cc: in the first place
> as the author of the regressing commit.
> 
> 'dim fixes c85d200e8321' gives you the output:
aaah-I had thought it was just for generating the Fixes line, I will be more
careful about that in the future
> 
> Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the
> ->post_hotplug() hook")
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.17+
> 
> BR,
> Jani.
> 
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
> 
> 
-- 
Cheers,
	Lyude Paul


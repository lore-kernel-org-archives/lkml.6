Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315D6205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315D6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeH3BXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:23:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:36968 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbeH3BXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:23:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 14:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,304,1531810800"; 
   d="scan'208";a="84479265"
Received: from pprajyul-mobl1.amr.corp.intel.com (HELO intel.com) ([10.254.115.13])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2018 14:22:35 -0700
Date:   Wed, 29 Aug 2018 14:22:35 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jan-Marek Glogowski <glogow@fbihome.de>, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH v4] drm/i915: Re-apply "Perform link quality
 check, unconditionally during long pulse"
Message-ID: <20180829212235.GL6418@intel.com>
References: <20180825191035.3945-1-lyude@redhat.com>
 <871sak5hdu.fsf@intel.com>
 <c87f70879c87b0d29880e32f6632c4c7acd337bb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c87f70879c87b0d29880e32f6632c4c7acd337bb.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:39:02PM -0400, Lyude Paul wrote:
> On Mon, 2018-08-27 at 11:43 +0300, Jani Nikula wrote:
> > On Sat, 25 Aug 2018, Lyude Paul <lyude@redhat.com> wrote:
> > > From: Jan-Marek Glogowski <glogow@fbihome.de>
> > > 
> > > This re-applies the workaround for "some DP sinks, [which] are a
> > > little nuts" from commit 1a36147bb939 ("drm/i915: Perform link
> > > quality check unconditionally during long pulse").
> > > It makes the secondary AOC E2460P monitor connected via DP to an
> > > acer Veriton N4640G usable again.
> > > 
> > > This hunk was dropped in commit c85d200e8321 ("drm/i915: Move SST
> > > DP link retraining into the ->post_hotplug() hook")
> > > 
> > > Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the
> > > ->post_hotplug() hook")
> > > [Cleaned up commit message, added stable cc]
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> > > Cc: stable@vger.kernel.org
> > > ---
> > > Resending this to update patchwork; will push in a little bit
> > 
> > Is there a bugzilla? Reference to a list discussion? Something with a
> > dmesg where someone can actually verify this is the right fix?
> This patch has actually been on the list for a while now-I have had mdnavare
> take a look at it as well (they said it looked fine with the only change being
> in regards to the comment), and it'd been on the list for a while already.
> 
> > 
> > IMO needs an ack from Ville too. He should be in Cc: in the first place
> > as the author of the regressing commit.
> > 
> > 'dim fixes c85d200e8321' gives you the output:
> aaah-I had thought it was just for generating the Fixes line, I will be more
> careful about that in the future

Hi Lyude,

I understand that this patch was a while on the mailing list and no
proper attention, but besides the commit message information that
dim is generating I have a feeling now that this patch wasn't quite
ready yet and shouldn't be rushed in like it was.

Since you modified few versions ideally it would be good to have extra eyes
and the mandatory "Reviewed-by" there.

Also it is a good idea to give few days for different timezones to
comment out (after the re-sping I mean)

And finally based on the discussions it seems that there is still
some work to get done or a different way to handle this other
this back and forth of reapply-revert-reapply...

I just noticed it when preparing drm-intel-fixes pull request.

Since I'm not 100% confident this patch should be here I'm removing it
from this week's pull request.

But probably adding it next week if Jani and Ville give and ack
or indication that it is right or at least he best we could do now.

thanks,
Rodrigo.


> > 
> > Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the
> > ->post_hotplug() hook")
> > Cc: Manasi Navare <manasi.d.navare@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v4.17+
> > 
> > BR,
> > Jani.
> > 
> > > 
> > >  drivers/gpu/drm/i915/intel_dp.c | 33 +++++++++++++++++++--------------
> > >  1 file changed, 19 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > > b/drivers/gpu/drm/i915/intel_dp.c
> > > index b3f6f04c3c7d..db8515171270 100644
> > > --- a/drivers/gpu/drm/i915/intel_dp.c
> > > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > > @@ -4333,18 +4333,6 @@ intel_dp_needs_link_retrain(struct intel_dp
> > > *intel_dp)
> > >  	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
> > >  }
> > >  
> > > -/*
> > > - * If display is now connected check links status,
> > > - * there has been known issues of link loss triggering
> > > - * long pulse.
> > > - *
> > > - * Some sinks (eg. ASUS PB287Q) seem to perform some
> > > - * weird HPD ping pong during modesets. So we can apparently
> > > - * end up with HPD going low during a modeset, and then
> > > - * going back up soon after. And once that happens we must
> > > - * retrain the link to get a picture. That's in case no
> > > - * userspace component reacted to intermittent HPD dip.
> > > - */
> > >  int intel_dp_retrain_link(struct intel_encoder *encoder,
> > >  			  struct drm_modeset_acquire_ctx *ctx)
> > >  {
> > > @@ -5031,7 +5019,8 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
> > >  }
> > >  
> > >  static int
> > > -intel_dp_long_pulse(struct intel_connector *connector)
> > > +intel_dp_long_pulse(struct intel_connector *connector,
> > > +		    struct drm_modeset_acquire_ctx *ctx)
> > >  {
> > >  	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
> > >  	struct intel_dp *intel_dp = intel_attached_dp(&connector->base);
> > > @@ -5090,6 +5079,22 @@ intel_dp_long_pulse(struct intel_connector
> > > *connector)
> > >  		 */
> > >  		status = connector_status_disconnected;
> > >  		goto out;
> > > +	} else {
> > > +		/*
> > > +		 * If display is now connected check links status,
> > > +		 * there has been known issues of link loss triggering
> > > +		 * long pulse.
> > > +		 *
> > > +		 * Some sinks (eg. ASUS PB287Q) seem to perform some
> > > +		 * weird HPD ping pong during modesets. So we can apparently
> > > +		 * end up with HPD going low during a modeset, and then
> > > +		 * going back up soon after. And once that happens we must
> > > +		 * retrain the link to get a picture. That's in case no
> > > +		 * userspace component reacted to intermittent HPD dip.
> > > +		 */
> > > +		struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)-
> > > >base;
> > > +
> > > +		intel_dp_retrain_link(encoder, ctx);
> > >  	}
> > >  
> > >  	/*
> > > @@ -5151,7 +5156,7 @@ intel_dp_detect(struct drm_connector *connector,
> > >  				return ret;
> > >  		}
> > >  
> > > -		status = intel_dp_long_pulse(intel_dp->attached_connector);
> > > +		status = intel_dp_long_pulse(intel_dp->attached_connector,
> > > ctx);
> > >  	}
> > >  
> > >  	intel_dp->detect_done = false;
> > 
> > 
> -- 
> Cheers,
> 	Lyude Paul
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

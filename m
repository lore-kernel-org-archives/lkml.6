Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D542C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCB1208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCB1208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH0M3n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:29:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:64242 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeH0M3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:29:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 01:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="84768943"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2018 01:43:58 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     Jan-Marek Glogowski <glogow@fbihome.de>, stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/i915: Re-apply "Perform link quality check, unconditionally during long pulse"
In-Reply-To: <20180825191035.3945-1-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180825191035.3945-1-lyude@redhat.com>
Date:   Mon, 27 Aug 2018 11:43:41 +0300
Message-ID: <871sak5hdu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2018, Lyude Paul <lyude@redhat.com> wrote:
> From: Jan-Marek Glogowski <glogow@fbihome.de>
>
> This re-applies the workaround for "some DP sinks, [which] are a
> little nuts" from commit 1a36147bb939 ("drm/i915: Perform link
> quality check unconditionally during long pulse").
> It makes the secondary AOC E2460P monitor connected via DP to an
> acer Veriton N4640G usable again.
>
> This hunk was dropped in commit c85d200e8321 ("drm/i915: Move SST
> DP link retraining into the ->post_hotplug() hook")
>
> Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the ->post_hotplug() hook")
> [Cleaned up commit message, added stable cc]
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> Cc: stable@vger.kernel.org
> ---
> Resending this to update patchwork; will push in a little bit

Is there a bugzilla? Reference to a list discussion? Something with a
dmesg where someone can actually verify this is the right fix?

IMO needs an ack from Ville too. He should be in Cc: in the first place
as the author of the regressing commit.

'dim fixes c85d200e8321' gives you the output:

Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the ->post_hotplug() hook")
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.17+

BR,
Jani.

>
>  drivers/gpu/drm/i915/intel_dp.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index b3f6f04c3c7d..db8515171270 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -4333,18 +4333,6 @@ intel_dp_needs_link_retrain(struct intel_dp *intel_dp)
>  	return !drm_dp_channel_eq_ok(link_status, intel_dp->lane_count);
>  }
>  
> -/*
> - * If display is now connected check links status,
> - * there has been known issues of link loss triggering
> - * long pulse.
> - *
> - * Some sinks (eg. ASUS PB287Q) seem to perform some
> - * weird HPD ping pong during modesets. So we can apparently
> - * end up with HPD going low during a modeset, and then
> - * going back up soon after. And once that happens we must
> - * retrain the link to get a picture. That's in case no
> - * userspace component reacted to intermittent HPD dip.
> - */
>  int intel_dp_retrain_link(struct intel_encoder *encoder,
>  			  struct drm_modeset_acquire_ctx *ctx)
>  {
> @@ -5031,7 +5019,8 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
>  }
>  
>  static int
> -intel_dp_long_pulse(struct intel_connector *connector)
> +intel_dp_long_pulse(struct intel_connector *connector,
> +		    struct drm_modeset_acquire_ctx *ctx)
>  {
>  	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
>  	struct intel_dp *intel_dp = intel_attached_dp(&connector->base);
> @@ -5090,6 +5079,22 @@ intel_dp_long_pulse(struct intel_connector *connector)
>  		 */
>  		status = connector_status_disconnected;
>  		goto out;
> +	} else {
> +		/*
> +		 * If display is now connected check links status,
> +		 * there has been known issues of link loss triggering
> +		 * long pulse.
> +		 *
> +		 * Some sinks (eg. ASUS PB287Q) seem to perform some
> +		 * weird HPD ping pong during modesets. So we can apparently
> +		 * end up with HPD going low during a modeset, and then
> +		 * going back up soon after. And once that happens we must
> +		 * retrain the link to get a picture. That's in case no
> +		 * userspace component reacted to intermittent HPD dip.
> +		 */
> +		struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
> +
> +		intel_dp_retrain_link(encoder, ctx);
>  	}
>  
>  	/*
> @@ -5151,7 +5156,7 @@ intel_dp_detect(struct drm_connector *connector,
>  				return ret;
>  		}
>  
> -		status = intel_dp_long_pulse(intel_dp->attached_connector);
> +		status = intel_dp_long_pulse(intel_dp->attached_connector, ctx);
>  	}
>  
>  	intel_dp->detect_done = false;

-- 
Jani Nikula, Intel Open Source Graphics Center

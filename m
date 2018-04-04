Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-426418-1522856098-2-14029836411683557939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522856098; b=d8INmw5Svf7oYk3oc+5w7BfXCwfTUwlmQ6XgBef7ZywrlprdjL
    pEQGFpWtAjtWoQMCq5j9BrIpAGUWV4JLNh4tdCcet/R3Ro+353lYp5ZH3pOba9lu
    l5VW3szuBQtNIu1nwvvHhmQiljJsflFsulkgTdMl2jkU7dvR7nLN6LhKbTD6rdAG
    B2FM9WRGpHxkXi4C0o07URX5JOqDZBMmJK39u+yrHLhGjhXSa1VErYZM8EVuQd6d
    VS780STjB0IiPt0yTs8aWrMEjg7akcv5WsPNdp33GRH1+c/qIFwGhoSK2qSZJqdA
    HI4nnjpSQjQGYdEgN2pEt/E8WaM/bKh+bUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522856098; bh=krGgJfB4ey7
    GG6b4W9mNCox0TH7bgT3NJ6uj2/SnXd4=; b=ZQSrCejmQBlVoNcE8OfAskFiUJJ
    JY8A1tNkMLB7Nxt/2DH8v8gKvdz2AvRTgO5a33W+bUKkPv5jatSjzo9m6y8w5ILj
    DPhQCkQuTeU2UmSeUxrcPSw34mJLBWumiYmWv/vlxJRV0tu1TjeMh8kxUFJ1TeOz
    A0CzhERdQVeSoiGI4hF7llw10wGiSuwSJ7s1W1VUEgjY8aiXSWUwT+wLE304DJbW
    xHNA1uMoT8DHAmWV6LjqEQt2zPHeNEYRWzwhgE0/9Rwc7MvYmmXBLWBfnoI7wfmh
    1/WSwILLzigD3BzK+xSr01Bh9gYreKVjT77x2IxiQ9qHJmO5qcoADgxxPOA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCwP525cBd7LTe1e5IIBGAsIBeDs0LKXACXMKKwIlMcRWmXJ77I5IMolu1fydIcZFHyHgYPN2j5sBuDwt0nE6WJBUN2g3+wCkSOXh+vmYSfeSPdWJ4iQ
    ppFubPNJ0FWtGc7zNBwnQc0fkht0NabJkFIwek8zZn7jdFr/yWPoJoxekCa3GaqVumyRy6UFw2DQX2kjXxcWZG24I+xACx42yx4vpiUgTN/3lJ6YtPs14PWF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=CHO7OG3I3ADhSFNjfKcA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeDDPej (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:34:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:8863 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbeDDPef (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 11:34:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,406,1517904000";
   d="scan'208";a="44853987"
Date: Wed, 4 Apr 2018 18:34:29 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org, Laura Abbott <labbott@redhat.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: Keep AUX block running when disabling DPMS
 for MST
Message-ID: <20180404153429.GE5453@intel.com>
References: <20180402212142.19841-1-lyude@redhat.com>
 <20180402212617.21247-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180402212617.21247-1-lyude@redhat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 05:26:16PM -0400, Lyude Paul wrote:
> While enabling/disabling DPMS before link training with MST hubs is
> perfectly valid; unfortunately disabling DPMS results in some devices
> disabling their AUX CH block as well. For SST this isn't as much of a
> problem, but for MST we need to be able to continue handling aux
> transactions even when none of the sinks are turned on since it's
> possible for us to have a single atomic commit which results in
> disabling each downstream sink, followed by subsequently re-enabling
> each sink.
> 
> If we don't do this, we'll end up stalling any pending ESI interrupts
> from the sink for up to 1ms. Unfortunately, dropping ESIs during this
> timespan makes it so that link fallback retraining for MST (which I will
> be submitting to the ML shortly) fails due to the channel EQ failure
> interrupts potentially getting dropped. Additionally, when performing a
> modeset that brings the hub status's link status from bad -> good having
> ESIs disabled for that long causes us to miss the hub's response to us
> trying to start link training as well.
> 
> Since any sink with MST is going to support DisplayPort 1.2 anyway, save
> us the hassle of trying to wait until the sink comes back up and just
> never shut the aux block down.
> 
> Changes since v2:
>  - Fix patch name, no functional changes
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: stable@vger.kernel.org
> Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
> ---
>  drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index 62f82c4298ac..0479c377981b 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp, int mode)
>  		return;
>  
>  	if (mode != DRM_MODE_DPMS_ON) {
> +		unsigned char data = intel_dp->is_mst ?
> +			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;

This smells like a workaround for an actual bug somewhere. Why exactly
is the slower wakeup or the AUX block a problem for MST but not for SST
when the link training is exactly the same for SST and MST?

> +
>  		if (downstream_hpd_needs_d0(intel_dp))
>  			return;
>  
> -		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER,
> -					 DP_SET_POWER_D3);
> +		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER, data);
>  	} else {
>  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
>  
> -- 
> 2.14.3

-- 
Ville Syrjälä
Intel OTC

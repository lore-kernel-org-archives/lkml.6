Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3265618-1522946345-2-1936710914425445869
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522946344; b=psIhATPNZBTxFUaHpyXiXhh9yTwZdA4EHVpgBdnbYO7ZUmBuFB
    77fTTIi36nqvIYT4Sxh2o+bLe5Yrxxsw/IGTe3d3YrUhCfbYGfxH2Y61f2zhHoGW
    nfGxNLAveOLmAQzVat+XVAmuoxYgZj1eLvHD3qz2EJOpqXQfOKL4UKN3UqwJZSaM
    NC8JvGnjkN6ir79UIkvnjs8D4vG0AZ9X2Y15WfKCieEQkQYErrya09NNP8XhHd2Y
    uDNWb7oUzIkcYEzhSvINVN2FIuptImYGpd5ubWTvVeG+QA9d9+zG381YElDN9in8
    tUYXIMQC7JDdbSnY9wwWLaSGW2LMLsTHiaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522946344; bh=NN4pC1159UY
    sIJdxLIs0MojgbQ1ickX+qFzht+lzSnE=; b=MBF2H8+xmTxvDIq70tiPhDXaYcz
    A5ywyCsyfe+CKd4Tk+6sDIrtfwuC06kcboFYGIuLPd8hRX9yaIIxQJtLT2qFX7iu
    aKh1hgQRfCxVajm1GeLMWWfJhUwi9W5UDID0cK95qlDCireUVLJj7kzXOFy0ox5Z
    UXsDaU9zTg6n4qVkAld9mg1Z3BC3XSpkCCtkn6M8YsQK9zIn7Xmp5BJ3/5ta0PNW
    6PZBMaRSk34UL0St/462X72yQmt2A7KYensguc+suo2+roGDF3fGWzJK+uFuU8iW
    qHkvbdpXTPBhRxoaJiQIhAxOmclfkhOT9I138R46JBTwQt80f+miJ5AUMGA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNgFegRbNcfnmyxpL6hRT04fsYfr3q1qLJsP/SdqlW/v0hFV6oj3Aqyi1PfVyBIZ4zdqYur3A3A3RuBu+dcqMmPWYuBIdxocackxB3Fr2n5OQ2HOPyS2
    3KvzWHSxWrgeqizz/916AOXuumngIUvckfYhzUQdDkkZmrMAmSKEWD5G1gvYacMQsM6lhlR0pBfeHlNViUpqpwpJsZV4HoJJsgMsv6O6cGwVja+pqps9EdMV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=J402YrzAYX2RDIqVBIgA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeDEQjA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 12:39:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:16652 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeDEQi7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 12:38:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,411,1517904000";
   d="scan'208";a="45203816"
Date: Thu, 5 Apr 2018 19:38:53 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Lyude Paul <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Laura Abbott <labbott@redhat.com>, stable@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dp: Send DPCD ON for MST before phy_up
Message-ID: <20180405163853.GK5453@intel.com>
References: <20180404232721.28044-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180404232721.28044-1-lyude@redhat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 07:27:21PM -0400, Lyude Paul wrote:
> As it turns out, the aux block being off was not the real problem here,
> as transition from D3 to D0 is mandated by the DP spec to take a maximum
> of 1ms, whereas we're allowed a 100ms timeframe to respond to ESI irqs.
> The real problem here is a bit more subtle.
> 
> When doing a modeset where the problem of the sink timing out to our
> sideband requests when transitioning from D3 to D0 occurs, the timeout
> is from the aux block not coming on. However, nothing else times out
> other than the initial phy_up message because the DPCD on call in
> intel_ddi_enable_dp() ends up waking up the AUX block on the hub, not
> the phy_up sideband message. This means that the real fix we need is to
> use the DPMS on before sending a phy_up to ensure that the hub is ready
> to accept sideband messages.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
> ---
>  drivers/gpu/drm/i915/intel_ddi.c    | 6 +++++-
>  drivers/gpu/drm/i915/intel_dp_mst.c | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
> index a6672a9abd85..9bd675f73f7b 100644
> --- a/drivers/gpu/drm/i915/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/intel_ddi.c
> @@ -2324,7 +2324,11 @@ static void intel_ddi_pre_enable_dp(struct intel_encoder *encoder,
>  		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
>  
>  	intel_ddi_init_dp_buf_reg(encoder);
> -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> +	/* for MST, we do DPMS_ON outside of here so that DPMS_ON can happen
> +	 * before drm_dp_send_power_updown_phy()
> +	 */
> +	if (!intel_dp->is_mst)

Just 'is_mst' should do here.

And in general I'd like to see the enable and disable paths remain
symmetric. Ie. also move out the dpms call in the disable path (or
maybe move the phy_power_up/down in?).

> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
>  	intel_dp_start_link_train(intel_dp);
>  	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
>  		intel_dp_stop_link_train(intel_dp);
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index c3de0918ee13..eff9a4eae1f0 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -223,6 +223,7 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
>  
>  	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
>  
> +	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
>  	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port, true);

This could use a comment to remind people that the order does matter.

>  	if (intel_dp->active_mst_links == 0)
>  		intel_dig_port->base.pre_enable(&intel_dig_port->base,
> -- 
> 2.14.3

-- 
Ville Syrjälä
Intel OTC

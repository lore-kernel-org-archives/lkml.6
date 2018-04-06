Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2112517-1523042539-2-5343085622607362469
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
    1523042539; b=pLhTTyRY7sLvlkuuJ8PqyqXdh8tebUde9d3G22rjo7Od1GRpvf
    LmFxouYNUvshN5ohyu0hqJ2d0TmdiS4qN9Kd8+7XymIGZ5smIQFoMqihLjiX9LR+
    80wCO1TKkzqkABtjX+UP0fygZ2y1mUbCBSklyt2igWPLbwJdJuEp+qLW/5A+8IMe
    tuw1LMdXiHgLohYN+QmTjk4KZow4MS20l9bk5BfUnaZ7wqubR4ZxyKe2TnmhFZDQ
    Es3vSL6s6mSuF25UmPaSruaIGzXrHxulsHZxS9lVjn/muiKPTmZJX5VbJtGKzGFK
    3R1SvHHA5WGhPXjWANs21i6mp0LsqPKGLi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523042539; bh=ve1McAV7Y6e
    Nmz3BkI0zJ2viL7tGaYhW4Qm66a1ZS18=; b=Tn2uAORA+hZc/PRtLdukW/2HshB
    WV5CullhzvbAt16fhzouQUTpeWVnehu+PyjT73/P94aew0bAwGcTrpAJGIgBWgGO
    r7vwCf/6x/SvWMLiMCYY97qatX7NUY+VAec/7kGzx30xcC3VCO6LAw6p8PhJZCcx
    LeVujdRjlHPGVpg4SGjNig63ITt0whDrPHF8ZI39jhOMvROU5624x+wI2yVUH2qC
    VxGBc9NiwsB/Iwj32l7RFWpXDSic2FuD27wAHrS0nfIkEx6jYynCVGj2eBf8cEAy
    YF8HlescXfWf0OZdYLGGqazcVBpowL83QxJ3g/Rl9uGPuAjdxSVlO+drfkA==
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
X-CM-Envelope: MS4wfKwqIeyB6Mb9Xlq/+2HBVCwigu0AeGfrfPDdA0idihq5ggdv4r5c2ZS6mRLeymdcayzNthQY6abNV1dRlxaImKCKqiblsOL/TBPKyMHW3ace+t/1KaGD
    kVhzChEWU559t4qKTr4hLLzZ6Lbm61DDQQpbIHhQZep6Nnc7KakQgtC/RHsnFFWRkOvsasRMw+GnQOstDeUXYKqtRn+H4FoeZQjfY1oY9Jy4Tid55QVJo8X9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=EHeH4C2DknFoe5FAJSkA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDFTWH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 15:22:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:59216 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDFTWF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 15:22:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31320515"
Date: Fri, 6 Apr 2018 22:21:58 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Cc: Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org,
        Laura Abbott <labbott@redhat.com>, stable@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/i915/dp: Send DPCD ON for MST before phy_up
Message-ID: <20180406192158.GA17795@intel.com>
References: <20180406185249.22952-1-lyude@redhat.com>
 <1523042910.11823.16.camel@dk-H97M-D3H>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523042910.11823.16.camel@dk-H97M-D3H>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 12:28:30PM -0700, Dhinakaran Pandiyan wrote:
> 
> 
> 
> On Fri, 2018-04-06 at 14:52 -0400, Lyude Paul wrote:
> > When doing a modeset where the sink is transitioning from D3 to D0 , it
> > would sometimes be possible for the initial power_up_phy() to start
> > timing out. This would only be observed in the last action before the
> > sink went into D3 mode was intel_dp_sink_dpms(DRM_MODE_DPMS_OFF). We
> > originally thought this might be an issue with us accidentally shutting
> > off the aux block when putting the sink into D3, but since the DP spec
> > mandates that sinks must wake up within 1ms while we have 100ms to
> > respond to an ESI irq, this didn't really add up. Turns out that the
> > problem is more subtle then that:
> > 
> > It turns out that the timeout is from us not enabling DPMS on the MST
> > hub before actually trying to initiate sideband communications. This
> > would cause the first sideband communication (power_up_phy()), to start
> > timing out because the sink wasn't ready to respond. Afterwards, we
> > would call intel_dp_sink_dpms(DRM_MODE_DPMS_ON) in
> > intel_ddi_pre_enable_dp(), which would actually result in waking up the
> > sink so that sideband requests would work again.
> > 
> > Since DPMS is what lets us actually bring the hub up into a state where
> > sideband communications become functional again, we just need to make
> > sure to enable DPMS on the display before attempting to perform sideband
> > communications.
> > 
> 
> Matches my understanding of the problem
> 
> Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> 
> It's better to get an ack from Ville considering I was okay with the
> D3_AUX_ON solution too.

lgtm
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> 
> > Changes since v1:
> > - Remove comment above if (!intel_dp->is_mst) - vsryjala
> > - Move intel_dp_sink_dpms() for MST into intel_dp_post_disable_mst() to
> >   keep enable/disable paths symmetrical
> > - Improve commit message - dhnkrn
> > Changes since v2:
> > - Only send DPMS off when we're disabling the last sink, and only send
> >   DPMS on when we're enabling the first sink - dhnkrn
> > Changes since v3:
> > - Check against is_mst, not intel_dp->is_mst - dhnkrn/vsyrjala
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
> > ---
> >  drivers/gpu/drm/i915/intel_ddi.c    | 8 ++++++--
> >  drivers/gpu/drm/i915/intel_dp_mst.c | 8 +++++++-
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
> > index a6672a9abd85..92cb26b18a9b 100644
> > --- a/drivers/gpu/drm/i915/intel_ddi.c
> > +++ b/drivers/gpu/drm/i915/intel_ddi.c
> > @@ -2324,7 +2324,8 @@ static void intel_ddi_pre_enable_dp(struct intel_encoder *encoder,
> >  		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
> >  
> >  	intel_ddi_init_dp_buf_reg(encoder);
> > -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> > +	if (!is_mst)
> > +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> >  	intel_dp_start_link_train(intel_dp);
> >  	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
> >  		intel_dp_stop_link_train(intel_dp);
> > @@ -2422,12 +2423,15 @@ static void intel_ddi_post_disable_dp(struct intel_encoder *encoder,
> >  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
> >  	struct intel_digital_port *dig_port = enc_to_dig_port(&encoder->base);
> >  	struct intel_dp *intel_dp = &dig_port->dp;
> > +	bool is_mst = intel_crtc_has_type(old_crtc_state,
> > +					  INTEL_OUTPUT_DP_MST);
> >  
> >  	/*
> >  	 * Power down sink before disabling the port, otherwise we end
> >  	 * up getting interrupts from the sink on detecting link loss.
> >  	 */
> > -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
> > +	if (!is_mst)
> > +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
> >  
> >  	intel_disable_ddi_buf(encoder);
> >  
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> > index c3de0918ee13..9e6956c08688 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -180,9 +180,11 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
> >  	intel_dp->active_mst_links--;
> >  
> >  	intel_mst->connector = NULL;
> > -	if (intel_dp->active_mst_links == 0)
> > +	if (intel_dp->active_mst_links == 0) {
> > +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_OFF);
> >  		intel_dig_port->base.post_disable(&intel_dig_port->base,
> >  						  old_crtc_state, NULL);
> > +	}
> >  
> >  	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> >  }
> > @@ -223,7 +225,11 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
> >  
> >  	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> >  
> > +	if (intel_dp->active_mst_links == 0)
> > +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> > +
> >  	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port, true);
> > +
> >  	if (intel_dp->active_mst_links == 0)
> >  		intel_dig_port->base.pre_enable(&intel_dig_port->base,
> >  						pipe_config, NULL);

-- 
Ville Syrjälä
Intel OTC

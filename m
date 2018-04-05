Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3387485-1522950494-2-961882876780502080
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='ISO-8859-1', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522950493; b=k2DOXT8wn2zohaY1dN0tM++MK+39Ldj8hejz7tE+5d0QrLnsEN
    Pcu1eeucicr+9mIPkAq+zGPP0hEpOoqrOiGuVDcKJsAs+eYN6O/g33ciRo0d065s
    +jTdqfD0k7DgAcvySQGWBAUuQ84G7PanL5+tRQc8qzpvDnekgbQbMTVnMG1JAoit
    TryaY3bn00D5c2oUXCZLyvEm2VynItcf1GXkxpvRKfsf3irwv3spVaePIfSnNnwZ
    GyJeCZ5eyskRbDSjzizTv2mayQ+ZsNPFyXdqiFEPY5nuDFDoUHA0S+ei1Q44P7Gz
    ZtbUtLueRIE3lVreIjWUdktzABajYzEfTr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:reply-to:to:cc
    :date:in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522950493;
    bh=Y7Vm7j1fZS5/xLezaGzSJY+vKGoSPbPxYSeoAZAofiY=; b=Gxo12RVJypkW
    NaeKvVbnETN/8sDmb+X2Ua5MrVGEb/AIbq4EEHbcdnVHhJLYy8T7WJqePeMzp/7T
    TdPnB8xzU2kFx102SUaOrON/CCdPBS+FbgSjfVk7eCZMtSDpMBZAqyUSluWe1XV8
    lmcdX/0EYOGmygY6QEe6+bcflIX9h8iphqE0BJFOwqW3t87tIhNfrbXJXR4fu80g
    PjmcoYklgKebigtWbK59egWY8oYaYmn9fY7sVoca+xIiBk/SftSniPPsYrZoyd7V
    RLd5XQ0NCDlmpXIsq123Oo4ZCZKRp9kkdR9mWddKZdBCWsNCDDkYSXTthmPN5Pam
    FbkdokZftA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNqs0YE/R49SUJQWwqEdi4LF26eHXKDrwXyd7/+QYZry4GOImu1nAH0j7mJP/ZA/gj3cSbxmiPexgB52r/htq2tk/cintroRmy7pXDdaQPN+4HQJWWkN
    6RAA9iNuE9rCiDWI/hEYfCgHmp6Te5Ftn6ZJB79PI1rD5aJmbzJW+qHTACOy9okJdHbmju2lOHpG/RpaKuw2iyevKLliM3tNct6Wmc64qHAYihwBhceVN4xs
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=unC3xbkhgIKkgdBOvdkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeDERsF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 13:48:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:61096 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbeDERsD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 13:48:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,411,1517904000";
   d="scan'208";a="217900657"
Message-ID: <1522951938.2418.12.camel@dk-H97M-D3H>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/dp: Send DPCD ON for MST before
 phy_up
From: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Reply-To: dhinakaran.pandiyan@intel.com
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>
Date: Thu, 05 Apr 2018 11:12:18 -0700
In-Reply-To: <20180405163853.GK5453@intel.com>
References: <20180404232721.28044-1-lyude@redhat.com>
         <20180405163853.GK5453@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>




On Thu, 2018-04-05 at 19:38 +0300, Ville Syrjälä wrote:
> On Wed, Apr 04, 2018 at 07:27:21PM -0400, Lyude Paul wrote:
> > As it turns out, the aux block being off was not the real problem here,
> > as transition from D3 to D0 is mandated by the DP spec to take a maximum
> > of 1ms, whereas we're allowed a 100ms timeframe to respond to ESI irqs.
> > The real problem here is a bit more subtle.
> > 
> > When doing a modeset where the problem of the sink timing out to our
> > sideband requests when transitioning from D3 to D0 occurs, the timeout
> > is from the aux block not coming on. However, nothing else times out
> > other than the initial phy_up message because the DPCD on call in
> > intel_ddi_enable_dp() ends up waking up the AUX block on the hub, not
> > the phy_up sideband message. 


This is the case only when intel_dp_sink_dpms(DRM_MODE_DPMS_OFF) was the
last action. With power_down_phy in post_disable() and power_up_phy in
pre_enable(), we weren't seeing this issue.




> This means that the real fix we need is to
> > use the DPMS on before sending a phy_up to ensure that the hub is ready
> > to accept sideband messages.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: stable@vger.kernel.org
> > Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
> > ---
> >  drivers/gpu/drm/i915/intel_ddi.c    | 6 +++++-
> >  drivers/gpu/drm/i915/intel_dp_mst.c | 1 +
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
> > index a6672a9abd85..9bd675f73f7b 100644
> > --- a/drivers/gpu/drm/i915/intel_ddi.c
> > +++ b/drivers/gpu/drm/i915/intel_ddi.c
> > @@ -2324,7 +2324,11 @@ static void intel_ddi_pre_enable_dp(struct intel_encoder *encoder,
> >  		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
> >  
> >  	intel_ddi_init_dp_buf_reg(encoder);
> > -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> > +	/* for MST, we do DPMS_ON outside of here so that DPMS_ON can happen
> > +	 * before drm_dp_send_power_updown_phy()
> > +	 */
> > +	if (!intel_dp->is_mst)
> 
> Just 'is_mst' should do here.
> 
> And in general I'd like to see the enable and disable paths remain
> symmetric. Ie. also move out the dpms call in the disable path (or
> maybe move the phy_power_up/down in?).
> 
> > +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> >  	intel_dp_start_link_train(intel_dp);
> >  	if (port != PORT_A || INTEL_GEN(dev_priv) >= 9)
> >  		intel_dp_stop_link_train(intel_dp);
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> > index c3de0918ee13..eff9a4eae1f0 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -223,6 +223,7 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
> >  
> >  	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> >  
> > +	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> >  	drm_dp_send_power_updown_phy(&intel_dp->mst_mgr, connector->port, true);
> 
> This could use a comment to remind people that the order does matter.
> 
> >  	if (intel_dp->active_mst_links == 0)
> >  		intel_dig_port->base.pre_enable(&intel_dig_port->base,
> > -- 
> > 2.14.3
> 

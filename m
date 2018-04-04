Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891550-1522870588-2-14362821501351379448
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
    1522870588; b=Io1tLhzOn9CCuj6XAoENsvce/h5SFzxR5i/Q46H0tly96+5ByD
    vguHI4pqFaxyj0TQSUAOp79h+Mi6v83/WmOHDuwecFBQA0J0T96Boj+2iWLk2htg
    l3tKvDSqfDqsbNz11g+nAG8FPkLg4hqrQQxSmhH8PGxObIGFAshuYZ8/kQW+F/Ub
    IBbRHDlcZI2ZrzkzuPRSSC8gPTQq4bHt9jb1CQXNil9SqgkdujXfdtZoq1rmuOIo
    cf/WqqLGiEX9NyocQMUM7l6Ns8AkW8ANW+aldFl3uqcjXWh6EDvQBAMmpzvCKPYR
    l03JMeTAarfuwQkCgN6PEqq84dFyaGsWWa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522870588; bh=lzpH5CdJx0p
    dDHzkseS46E25Hor7Gm8/5ZriakBw6T0=; b=STh4ogk7VMqC+HCgv+Mx5ubmuue
    34I2/lz7XcONj94W4CyqDmvUeeY+UNR7U98pSn3DamJWLMZBbgAGQaP4My7iKncX
    RXmaNP8cA6jyipZAGCEY3ov2iHboRxgO8vqjLVwS/NBw0abwBQQIZ8i6iHs1xA4/
    G/eoU7sZ3m2NPE25iaL1BcgL5MgL3x77k9P80GGyR8ELJwEWER/Eptd6bLBtkAiz
    iC3nGZHdb3qUymlmZLqD41Jz+u9CODygXAI3n6FTD4EQXOzFdMI9yVFlKRmINkKV
    aQb8rC+hVF4kul9/Ps/zmNzThZ2/nrPOi0so1SFtxGQOQyMj1sVnQuhz1Jg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfCRP6yPX1NJinFlQC7of391LwJdRmVQUhZlFnUgMIhg8OPVOOObAYW+ZWn0UoHqXDLmKorbd1nibtkL1dxnsagR07R5yl/J5SuXJXTl592vDQbp7YlVP
    H23wugTUrcHiFCq6QDGihOPmt4Q73LRmf8VH9BxYCnTV27VjPI+TYhEIDQEiKBnnRGQhMPVhYHW6uuU6wsJWrvOdDZxDhZ+8PoJO2Bssvw3/HdUS0UgUf0X0
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=z3vVis7cH64Y3roKpigA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDDTg0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 15:36:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:57768 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbeDDTg0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 15:36:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="31061638"
Date: Wed, 4 Apr 2018 22:35:55 +0300
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
Message-ID: <20180404193555.GI5453@intel.com>
References: <20180402212142.19841-1-lyude@redhat.com>
 <20180402212617.21247-1-lyude@redhat.com>
 <20180404153429.GE5453@intel.com>
 <1522867061.12403.6.camel@redhat.com>
 <20180404185313.GG5453@intel.com>
 <1522868412.12403.13.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522868412.12403.13.camel@redhat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 03:00:12PM -0400, Lyude Paul wrote:
> On Wed, 2018-04-04 at 21:53 +0300, Ville Syrjälä wrote:
> > On Wed, Apr 04, 2018 at 02:37:41PM -0400, Lyude Paul wrote:
> > > On Wed, 2018-04-04 at 18:34 +0300, Ville Syrjälä wrote:
> > > > On Mon, Apr 02, 2018 at 05:26:16PM -0400, Lyude Paul wrote:
> > > > > While enabling/disabling DPMS before link training with MST hubs is
> > > > > perfectly valid; unfortunately disabling DPMS results in some devices
> > > > > disabling their AUX CH block as well. For SST this isn't as much of a
> > > > > problem, but for MST we need to be able to continue handling aux
> > > > > transactions even when none of the sinks are turned on since it's
> > > > > possible for us to have a single atomic commit which results in
> > > > > disabling each downstream sink, followed by subsequently re-enabling
> > > > > each sink.
> > > > > 
> > > > > If we don't do this, we'll end up stalling any pending ESI interrupts
> > > > > from the sink for up to 1ms. Unfortunately, dropping ESIs during this
> > > > > timespan makes it so that link fallback retraining for MST (which I
> > > > > will
> > > > > be submitting to the ML shortly) fails due to the channel EQ failure
> > > > > interrupts potentially getting dropped. Additionally, when performing
> > > > > a
> > > > > modeset that brings the hub status's link status from bad -> good
> > > > > having
> > > > > ESIs disabled for that long causes us to miss the hub's response to us
> > > > > trying to start link training as well.
> > > > > 
> > > > > Since any sink with MST is going to support DisplayPort 1.2 anyway,
> > > > > save
> > > > > us the hassle of trying to wait until the sink comes back up and just
> > > > > never shut the aux block down.
> > > > > 
> > > > > Changes since v2:
> > > > >  - Fix patch name, no functional changes
> > > > > 
> > > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > > Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> > > > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable
> > > > > MST
> > > > > hub.")
> > > > > ---
> > > > >  drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > > > > b/drivers/gpu/drm/i915/intel_dp.c
> > > > > index 62f82c4298ac..0479c377981b 100644
> > > > > --- a/drivers/gpu/drm/i915/intel_dp.c
> > > > > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > > > > @@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp
> > > > > *intel_dp,
> > > > > int mode)
> > > > >  		return;
> > > > >  
> > > > >  	if (mode != DRM_MODE_DPMS_ON) {
> > > > > +		unsigned char data = intel_dp->is_mst ?
> > > > > +			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;
> > > > 
> > > > This smells like a workaround for an actual bug somewhere. Why exactly
> > > > is the slower wakeup or the AUX block a problem for MST but not for SST
> > > > when the link training is exactly the same for SST and MST?
> > > 
> > > I actually thought about this but I still think this is the appropriate
> > > fix.
> > > So; the real reason for the wakeup not being a problem with SST is that
> > > for
> > > DPMS on with SST, we actually do a wait to make sure that the hub is ready
> > > before continuing. And yes: I'm fairly sure SST does actually have around
> > > the
> > > same wakeup time that MST does, but with the wait we do it doesn't reallhy
> > > make a difference. With MST, we could do this but there's a few reasons I
> > > don't think we should:
> > >  * We don't need to. D3_AUX_ON is a part of the 1.2 spec, so any hub that
> > > has
> > >    MST is going to be guaranteed to have this.
> > >  * Turning off the aux block means that there's a high chance we're going
> > > to
> > >    miss ESIs from sinks
> > 
> > And how exactly do we lose irqs? The hub/whatever throws the up req msgs
> > away if we don't read them within some really short time?
> Oh-additionally I did forget to mention that i have actually witnessed the
> channel eq failures in the ESI getting dropped without this patch.

Not sure what that means. I don't think there is any sideband messaging
involved in link training so not sure what is dropped in this case. The
link status/etc. are just polled directly by the upstream device.

> Meaning if
> we miss them, there's a chance the hub may just not choose to send them again
> for whatever reason.
> > 
> > >  * It's faster to keep the aux block on anyway
> > > 
> > > 
> > > > 
> > > > > +
> > > > >  		if (downstream_hpd_needs_d0(intel_dp))
> > > > >  			return;
> > > > >  
> > > > > -		ret = drm_dp_dpcd_writeb(&intel_dp->aux,
> > > > > DP_SET_POWER,
> > > > > -					 DP_SET_POWER_D3);
> > > > > +		ret = drm_dp_dpcd_writeb(&intel_dp->aux,
> > > > > DP_SET_POWER,
> > > > > data);
> > > > >  	} else {
> > > > >  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
> > > > >  
> > > > > -- 
> > > > > 2.14.3
> > > > 
> > > > 
> > > 
> > > -- 
> > > Cheers,
> > > 	Lyude Paul
> > 
> > 
> -- 
> Cheers,
> 	Lyude Paul

-- 
Ville Syrjälä
Intel OTC

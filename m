Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-719175-1522868006-2-16186703817624342401
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
    1522868005; b=Ghlgl67lj8/cw4Jx5rCAu9fX58Iua12PlNLGpMVuRAdMcCbY7r
    d99mZFVG3zZTlDWPuWKcZCFkSeDfDeSvp4cMlmOZXaGb8/FuVg7ntTGCPMonXo9n
    z8xcHejsIdvLwHVB7hStKT68dsjEKIycapKK+s6GenJoQlvZHlnqcOSipbVETOmj
    TCKlW7xE8IiiypVanYxt+bMs44fC5VJCU0jpPvqANlT74n5/nYOpZdH9CdzoJFxr
    6ktQJfnszK5A6bEeMfvTjcbZvl09gzgqcWINPLd4jDk9cXmgA8bJ+sYOxGaPXwY/
    LiGEMBVSImCEKkn9TC/8oB/cbHxcjFQWY3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522868005; bh=qVk65IYC5/w
    Pjgwryw7CsR3w2eQWFxdDSbf2uAOOveI=; b=bfZ4Qy3OKLGqOQExguY0eFsayVZ
    8XxH2Rdfb1xjgY1aAznv1f++Q4w5UNEuCtZDcYoRbIxlEXUil9NXjgGcLi/OBJwo
    mjFyTGeyeNfQMVoOj4vhlf9KIg9cgC5/2DafS5If4Y5kz9b+vEhynsagb8cERay8
    MjDWA3CrqlQFKH0MzB6+3OayW/SNbumqaBpiehwtyJYsWN3n4gMTGTd6EniTsAq4
    +Z+Rxo/g1xhyxhaN0hAN7r7Z+VbfEYTc6m4BXghxR7ZqCnBQs1xBgR5pLsBaI8Xw
    Fw+XkP+pg1sZcbP0sbo+ys9URE03UjAzf5TrAc0yD++vbeghLi7XM6PnZcw==
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
X-CM-Envelope: MS4wfITBdaOUkrUqQquBYGec5i2FXeZM/7EnUPZ2gLED8U+9/2jklLcgcXM6hqohvlnzIL/dBc+makSTecEJVbnPHC0lmFOqwIAfZeywPWKQfSYXMNceH1W1
    HsPZ1m8G35uifNPpOFew/lklqaNKFktEOaMrgW2WPpGdLZSgOvPOzj7X2y2PgE9ZNJ3FgyyNbDg0HaP5fAqPitnCZ4rOMjDSRHXKF/aZ4jh1dedACaTbGAvY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=VUikG38Sawh5lcqwdkcA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeDDSxU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 14:53:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:19909 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeDDSxU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 14:53:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="34312710"
Date: Wed, 4 Apr 2018 21:53:13 +0300
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
Message-ID: <20180404185313.GG5453@intel.com>
References: <20180402212142.19841-1-lyude@redhat.com>
 <20180402212617.21247-1-lyude@redhat.com>
 <20180404153429.GE5453@intel.com>
 <1522867061.12403.6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522867061.12403.6.camel@redhat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 02:37:41PM -0400, Lyude Paul wrote:
> On Wed, 2018-04-04 at 18:34 +0300, Ville Syrjälä wrote:
> > On Mon, Apr 02, 2018 at 05:26:16PM -0400, Lyude Paul wrote:
> > > While enabling/disabling DPMS before link training with MST hubs is
> > > perfectly valid; unfortunately disabling DPMS results in some devices
> > > disabling their AUX CH block as well. For SST this isn't as much of a
> > > problem, but for MST we need to be able to continue handling aux
> > > transactions even when none of the sinks are turned on since it's
> > > possible for us to have a single atomic commit which results in
> > > disabling each downstream sink, followed by subsequently re-enabling
> > > each sink.
> > > 
> > > If we don't do this, we'll end up stalling any pending ESI interrupts
> > > from the sink for up to 1ms. Unfortunately, dropping ESIs during this
> > > timespan makes it so that link fallback retraining for MST (which I will
> > > be submitting to the ML shortly) fails due to the channel EQ failure
> > > interrupts potentially getting dropped. Additionally, when performing a
> > > modeset that brings the hub status's link status from bad -> good having
> > > ESIs disabled for that long causes us to miss the hub's response to us
> > > trying to start link training as well.
> > > 
> > > Since any sink with MST is going to support DisplayPort 1.2 anyway, save
> > > us the hassle of trying to wait until the sink comes back up and just
> > > never shut the aux block down.
> > > 
> > > Changes since v2:
> > >  - Fix patch name, no functional changes
> > > 
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > Cc: Laura Abbott <labbott@redhat.com>
> > > Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST
> > > hub.")
> > > ---
> > >  drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > > b/drivers/gpu/drm/i915/intel_dp.c
> > > index 62f82c4298ac..0479c377981b 100644
> > > --- a/drivers/gpu/drm/i915/intel_dp.c
> > > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > > @@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp,
> > > int mode)
> > >  		return;
> > >  
> > >  	if (mode != DRM_MODE_DPMS_ON) {
> > > +		unsigned char data = intel_dp->is_mst ?
> > > +			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;
> > 
> > This smells like a workaround for an actual bug somewhere. Why exactly
> > is the slower wakeup or the AUX block a problem for MST but not for SST
> > when the link training is exactly the same for SST and MST?
> I actually thought about this but I still think this is the appropriate fix.
> So; the real reason for the wakeup not being a problem with SST is that for
> DPMS on with SST, we actually do a wait to make sure that the hub is ready
> before continuing. And yes: I'm fairly sure SST does actually have around the
> same wakeup time that MST does, but with the wait we do it doesn't reallhy
> make a difference. With MST, we could do this but there's a few reasons I
> don't think we should:
>  * We don't need to. D3_AUX_ON is a part of the 1.2 spec, so any hub that has
>    MST is going to be guaranteed to have this.
>  * Turning off the aux block means that there's a high chance we're going to
>    miss ESIs from sinks

And how exactly do we lose irqs? The hub/whatever throws the up req msgs
away if we don't read them within some really short time?

>  * It's faster to keep the aux block on anyway
> 
> 
> > 
> > > +
> > >  		if (downstream_hpd_needs_d0(intel_dp))
> > >  			return;
> > >  
> > > -		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER,
> > > -					 DP_SET_POWER_D3);
> > > +		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER,
> > > data);
> > >  	} else {
> > >  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
> > >  
> > > -- 
> > > 2.14.3
> > 
> > 
> -- 
> Cheers,
> 	Lyude Paul

-- 
Ville Syrjälä
Intel OTC

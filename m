Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-719175-1522867080-2-14303466374404054011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='ISO-8859-1', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522867079; b=TxZXe5uQxdGMSqWSUceUhmYKcTkbTRFt2oThLS/lj3gwK5wgw1
    3zZ7A5Bb8sELJQTzwzd3rNLJ9y16xXONHUE79iGBaLoV7X8PJM5LagVLxEHj5Kil
    bVZ52RzC978eX+b32kZPMc0yYKveAqkOT7ss5baavnS6Zs459LIbmLhIb6N1+GF1
    nTtCLeu3KOosKNZRXrI0zeRp48nvVvF3RvhNcssIQ1O6KkquTcMOv5jasY3dc0dL
    IvzMLXSUh/l9o7umC4Mte9DOd/ooS4f0bgDu4mrB+3KdprssvfygamjmrK9XdZF7
    6hrUj4XGTNv5aAU2m6MIaZEWbsOoMQ5615cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522867079;
    bh=rZoXiFNjkNZuDmXkDw5D92ALWctx7XA+VwjGKQgfLOg=; b=UYHWM2eQMM5Z
    ImZheLqVxba2dhlzqAuFkIXsC7CzEcvSzmjZVILc0ucEBYQH6FrE5IO1DnC5rdJG
    bVwzbYtHeouy6IEUN3frA6zqVB5sWmGbc+m4mcHHTO+F3+67/BUYaQHUi+vxyC1Z
    yTqH9iaqXyu2zln05B6YA4AAoZtOAP11r51Z6DEcgEohw+kmoqtGYWspvS0UKUzz
    nKdYB2vgWuFlEJCMjLzwVLMZmRPGF2D7LCUUMuaT/bRNYjy5jiGA4XBcXXxe7pbl
    wdaBfZILdpdGUbHO04FNmNz0aBYVdFjfl94Zt14QTmEPos7zS1iL6bAYnH3tchRh
    PYW9ynj/3w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vxtat+My;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Vxtat+My;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/6/6kDI5Ozw2mr/Z5WwEGm0vyH5UX98oawK7aORqo/MtUyawLM/TFBWAhhfZqmQG/rJZt3IU6DJhOeQz0owW7rWyl1SDePOIem2K+tVFW/8BnRUNcZ
    5Dhd1EUHCDVyxE5QNdGmwj+b60t0jJ8SJuFUtx79qqg4kb58YiUQWiLLmNb4pjAhxuTCeEehthjUJNT0kv6VbVVxUCaJZ5wQimhZWVHX2F74KLVyDZ7QWitV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=i0_Obo9wnmxgy_uwGYEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDDSho (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 14:37:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:47029 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeDDShn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 14:37:43 -0400
X-Google-Smtp-Source: AIpwx4/l/u4ALxufSQtMRAbkfWaIQVu4tq76CuYSqVRfYg78+UUtOp8KELrMkpa+K2UX8zay17urOA==
Message-ID: <1522867061.12403.6.camel@redhat.com>
Subject: Re: [PATCH v2] drm/i915: Keep AUX block running when disabling DPMS
 for MST
From: Lyude Paul <lyude@redhat.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Laura Abbott <labbott@redhat.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Apr 2018 14:37:41 -0400
In-Reply-To: <20180404153429.GE5453@intel.com>
References: <20180402212142.19841-1-lyude@redhat.com>
         <20180402212617.21247-1-lyude@redhat.com> <20180404153429.GE5453@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-04 at 18:34 +0300, Ville Syrjälä wrote:
> On Mon, Apr 02, 2018 at 05:26:16PM -0400, Lyude Paul wrote:
> > While enabling/disabling DPMS before link training with MST hubs is
> > perfectly valid; unfortunately disabling DPMS results in some devices
> > disabling their AUX CH block as well. For SST this isn't as much of a
> > problem, but for MST we need to be able to continue handling aux
> > transactions even when none of the sinks are turned on since it's
> > possible for us to have a single atomic commit which results in
> > disabling each downstream sink, followed by subsequently re-enabling
> > each sink.
> > 
> > If we don't do this, we'll end up stalling any pending ESI interrupts
> > from the sink for up to 1ms. Unfortunately, dropping ESIs during this
> > timespan makes it so that link fallback retraining for MST (which I will
> > be submitting to the ML shortly) fails due to the channel EQ failure
> > interrupts potentially getting dropped. Additionally, when performing a
> > modeset that brings the hub status's link status from bad -> good having
> > ESIs disabled for that long causes us to miss the hub's response to us
> > trying to start link training as well.
> > 
> > Since any sink with MST is going to support DisplayPort 1.2 anyway, save
> > us the hassle of trying to wait until the sink comes back up and just
> > never shut the aux block down.
> > 
> > Changes since v2:
> >  - Fix patch name, no functional changes
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST
> > hub.")
> > ---
> >  drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > b/drivers/gpu/drm/i915/intel_dp.c
> > index 62f82c4298ac..0479c377981b 100644
> > --- a/drivers/gpu/drm/i915/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > @@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp *intel_dp,
> > int mode)
> >  		return;
> >  
> >  	if (mode != DRM_MODE_DPMS_ON) {
> > +		unsigned char data = intel_dp->is_mst ?
> > +			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;
> 
> This smells like a workaround for an actual bug somewhere. Why exactly
> is the slower wakeup or the AUX block a problem for MST but not for SST
> when the link training is exactly the same for SST and MST?
I actually thought about this but I still think this is the appropriate fix.
So; the real reason for the wakeup not being a problem with SST is that for
DPMS on with SST, we actually do a wait to make sure that the hub is ready
before continuing. And yes: I'm fairly sure SST does actually have around the
same wakeup time that MST does, but with the wait we do it doesn't reallhy
make a difference. With MST, we could do this but there's a few reasons I
don't think we should:
 * We don't need to. D3_AUX_ON is a part of the 1.2 spec, so any hub that has
   MST is going to be guaranteed to have this.
 * Turning off the aux block means that there's a high chance we're going to
   miss ESIs from sinks
 * It's faster to keep the aux block on anyway


> 
> > +
> >  		if (downstream_hpd_needs_d0(intel_dp))
> >  			return;
> >  
> > -		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER,
> > -					 DP_SET_POWER_D3);
> > +		ret = drm_dp_dpcd_writeb(&intel_dp->aux, DP_SET_POWER,
> > data);
> >  	} else {
> >  		struct intel_lspcon *lspcon = dp_to_lspcon(intel_dp);
> >  
> > -- 
> > 2.14.3
> 
> 
-- 
Cheers,
	Lyude Paul

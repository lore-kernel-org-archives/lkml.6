Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891550-1522872682-2-13255835102880036861
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
    1522872681; b=RFNBao6R+bgmBhlFpvEz8fYu9K1GzGqVvnvhVfoRjVPaczxxL5
    DHu9P/aSHXLeanGkXwezbSAp11iIeZM1UhR1J7R1VuQ4tZSUXxnWyNBlxQlED1Ne
    v1QyEpK5wsQZVTTDKnJu0V9Pdx7UQfAkgNmFKZ/vWIwwDHxuBUoqoWKmm7u6sFSR
    c06W22zw+D+usyHdLEQujx+ThnVVtIhzUChO1ZR3vVnGJ1c3iYIniwdDU1McZV/j
    BaYwfoZ3kM1ZeGh0J+U27vzoFkz0LxsGNmnUpiN7kz8QC8DPnFtSPSABuFQkkjmM
    /rc9J7MJyTA19egOV46TYukiFEt2rW3kyvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522872681;
    bh=RFs9Ybyvt3FSM473F5qdCXou8wbeAhLz0HXItYwpRrI=; b=rPab50v3eByR
    faARBXLa+aGqtwouaHrGZvLlODur5D+cytzvht6/TUEOtjFqzmaJ/w9xtD0sH+oT
    qc3460zOc72k67aYmOfNKD0N8ScznqbYfUOCyo+x30P1ILzqBau1Qk5IXjB3HRax
    zA8+gmvdFgYbhNfl+nlIu45fnHTwlm7hULW2NTWiB1YgOB3/USK5oHncpDeqE9QY
    NNyfGGSNA7XDXKCLUy3RT+nQaA8nfjc2pFA5f38sWOvL14mVVUlTBCT25QVmPe+o
    dUUvRalPm+YT8ee3V0s0DtP6y7iU/aUF3yhq7/iUmLDnPmFqt6mSPhjaoyqgPFK5
    8OGH6uwoSg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h3Lc24bT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h3Lc24bT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNcXGJnPDT8R3B/+w0vqZfzRfQIeUQtm7D9Gx/cT43/vb9C3l/JjX/FL6aYGfzUpvguB0pvrhFnoCiAlPrlbBGvMN6Covh8Gy1BhoEhlJdJ2HWPJUgBS
    RE0GI1/vDnfdUOf1w6Eki4z4jFGrLt4rAZxdnuBJDdEgFPG91gaAHGchqMWL4Oac8oLx8qd+Wjs8YZX2AmwO/RsxWW15IvnR7bI7dl1KLe/m2btDpgm+U944
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=VSOjU4_meCy3iPWEZ9YA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeDDULL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 16:11:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38815 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeDDULK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 16:11:10 -0400
X-Google-Smtp-Source: AIpwx4/aPRgsxcMtMEx4EIOYZ54fntamuYN3O4OtWo9TvnfL2SsrpZOhk6mOpzJ7y2TUPAVK3ENv7w==
Message-ID: <1522872668.5025.6.camel@redhat.com>
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
Date: Wed, 04 Apr 2018 16:11:08 -0400
In-Reply-To: <20180404193555.GI5453@intel.com>
References: <20180402212142.19841-1-lyude@redhat.com>
         <20180402212617.21247-1-lyude@redhat.com> <20180404153429.GE5453@intel.com>
         <1522867061.12403.6.camel@redhat.com> <20180404185313.GG5453@intel.com>
         <1522868412.12403.13.camel@redhat.com> <20180404193555.GI5453@intel.com>
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

On Wed, 2018-04-04 at 22:35 +0300, Ville Syrjälä wrote:
> On Wed, Apr 04, 2018 at 03:00:12PM -0400, Lyude Paul wrote:
> > On Wed, 2018-04-04 at 21:53 +0300, Ville Syrjälä wrote:
> > > On Wed, Apr 04, 2018 at 02:37:41PM -0400, Lyude Paul wrote:
> > > > On Wed, 2018-04-04 at 18:34 +0300, Ville Syrjälä wrote:
> > > > > On Mon, Apr 02, 2018 at 05:26:16PM -0400, Lyude Paul wrote:
> > > > > > While enabling/disabling DPMS before link training with MST hubs
> > > > > > is
> > > > > > perfectly valid; unfortunately disabling DPMS results in some
> > > > > > devices
> > > > > > disabling their AUX CH block as well. For SST this isn't as much
> > > > > > of a
> > > > > > problem, but for MST we need to be able to continue handling aux
> > > > > > transactions even when none of the sinks are turned on since it's
> > > > > > possible for us to have a single atomic commit which results in
> > > > > > disabling each downstream sink, followed by subsequently re-
> > > > > > enabling
> > > > > > each sink.
> > > > > > 
> > > > > > If we don't do this, we'll end up stalling any pending ESI
> > > > > > interrupts
> > > > > > from the sink for up to 1ms. Unfortunately, dropping ESIs during
> > > > > > this
> > > > > > timespan makes it so that link fallback retraining for MST (which
> > > > > > I
> > > > > > will
> > > > > > be submitting to the ML shortly) fails due to the channel EQ
> > > > > > failure
> > > > > > interrupts potentially getting dropped. Additionally, when
> > > > > > performing
> > > > > > a
> > > > > > modeset that brings the hub status's link status from bad -> good
> > > > > > having
> > > > > > ESIs disabled for that long causes us to miss the hub's response
> > > > > > to us
> > > > > > trying to start link training as well.
> > > > > > 
> > > > > > Since any sink with MST is going to support DisplayPort 1.2
> > > > > > anyway,
> > > > > > save
> > > > > > us the hassle of trying to wait until the sink comes back up and
> > > > > > just
> > > > > > never shut the aux block down.
> > > > > > 
> > > > > > Changes since v2:
> > > > > >  - Fix patch name, no functional changes
> > > > > > 
> > > > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > > > Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> > > > > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to
> > > > > > enable
> > > > > > MST
> > > > > > hub.")
> > > > > > ---
> > > > > >  drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > > > > > b/drivers/gpu/drm/i915/intel_dp.c
> > > > > > index 62f82c4298ac..0479c377981b 100644
> > > > > > --- a/drivers/gpu/drm/i915/intel_dp.c
> > > > > > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > > > > > @@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp
> > > > > > *intel_dp,
> > > > > > int mode)
> > > > > >  		return;
> > > > > >  
> > > > > >  	if (mode != DRM_MODE_DPMS_ON) {
> > > > > > +		unsigned char data = intel_dp->is_mst ?
> > > > > > +			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;
> > > > > 
> > > > > This smells like a workaround for an actual bug somewhere. Why
> > > > > exactly
> > > > > is the slower wakeup or the AUX block a problem for MST but not for
> > > > > SST
> > > > > when the link training is exactly the same for SST and MST?
> > > > 
> > > > I actually thought about this but I still think this is the
> > > > appropriate
> > > > fix.
> > > > So; the real reason for the wakeup not being a problem with SST is
> > > > that
> > > > for
> > > > DPMS on with SST, we actually do a wait to make sure that the hub is
> > > > ready
> > > > before continuing. And yes: I'm fairly sure SST does actually have
> > > > around
> > > > the
> > > > same wakeup time that MST does, but with the wait we do it doesn't
> > > > reallhy
> > > > make a difference. With MST, we could do this but there's a few
> > > > reasons I
> > > > don't think we should:
> > > >  * We don't need to. D3_AUX_ON is a part of the 1.2 spec, so any hub
> > > > that
> > > > has
> > > >    MST is going to be guaranteed to have this.
> > > >  * Turning off the aux block means that there's a high chance we're
> > > > going
> > > > to
> > > >    miss ESIs from sinks
> > > 
> > > And how exactly do we lose irqs? The hub/whatever throws the up req msgs
> > > away if we don't read them within some really short time?
> > 
> > Oh-additionally I did forget to mention that i have actually witnessed the
> > channel eq failures in the ESI getting dropped without this patch.
> 
> Not sure what that means. I don't think there is any sideband messaging
> involved in link training so not sure what is dropped in this case. The
> link status/etc. are just polled directly by the upstream device.
no, no nononono they are not always with MST. mdnavare is right regarding the
channel EQ occasionally being the only indicator that there's something wrong
with the link training. I've seen this with my caldigit ts3 with the mst hub
hooked up to it. I'm not entirely sure why, but my guess would be that there's
a displayport repeater somewhere in the TS3 that's not an mst branch device.
I'd think chances are that from the source's perspective, we might be doing
link training with that instead of the actual hub, which means that if link
training between the hub and said repeater failed the only way it would be
reported would be through the channel eq because it's detected by the MST hub.

There's some other behavior regarding this that makes me a little more sure of
this. I've got an old Dell P2415Qb monitor with MST on it that actually does
manage to train at the full 5.4 GBit/s on the caldigit TS3 without needing
fallback retraining. Keep in mind, this monitor is kind of infamous across our
office for having a lot of probably-against-spec MST bugs that don't really
happen on other devices. That being said, it trains and doesn't ever throw
channel EQ failed notifications. But unlike the EVGA MST hub I have which does
throw the EQ failed notifications, the screen flickers so often it's really
difficult for me to believe it's actually link trained properly. This is
mainly where my theory of link status problems that aren't actually visible to
the source comes in, because if that's the case then the most likely
explanation is that the problematic P2415Qb never sends channel EQ failures
because it's firmware just isn't smart enough to monitor the symbol failure
rate and detect that link retraining is required.
> 
> > Meaning if
> > we miss them, there's a chance the hub may just not choose to send them
> > again
> > for whatever reason.
> > > 
> > > >  * It's faster to keep the aux block on anyway
> > > > 
> > > > 
> > > > > 
> > > > > > +
> > > > > >  		if (downstream_hpd_needs_d0(intel_dp))
> > > > > >  			return;
> > > > > >  
> > > > > > -		ret = drm_dp_dpcd_writeb(&intel_dp->aux,
> > > > > > DP_SET_POWER,
> > > > > > -					 DP_SET_POWER_D3);
> > > > > > +		ret = drm_dp_dpcd_writeb(&intel_dp->aux,
> > > > > > DP_SET_POWER,
> > > > > > data);
> > > > > >  	} else {
> > > > > >  		struct intel_lspcon *lspcon =
> > > > > > dp_to_lspcon(intel_dp);
> > > > > >  
> > > > > > -- 
> > > > > > 2.14.3
> > > > > 
> > > > > 
> > > > 
> > > > -- 
> > > > Cheers,
> > > > 	Lyude Paul
> > > 
> > > 
> > 
> > -- 
> > Cheers,
> > 	Lyude Paul
> 
> 
-- 
Cheers,
	Lyude Paul

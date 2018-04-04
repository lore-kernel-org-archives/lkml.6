Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891550-1522871210-2-16772379289129703408
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
    1522871209; b=NZbU1S9ybwgvG3HNXxq4g5tTOJTH8HuG2bmOa6LLcjjn/ezBSL
    KY/468lB3qh/qNDhhYSMm8s18Q/xIoO+RK0Uatn1Qbcb2Bkk68rB0jDNc3nPgY0E
    VBaYG0ynLI/IEhxV7ByFdmxXCRa2KtKq+s4kATShr2meP4z5Hv019d6Dk1tbHj/1
    tnbdatinQK1MK3hs/2EXG9UbOyQVP6SSQh6bzsGDp74RnCrhguQ20oSZBkWHf5PY
    hv3QZkLAUwpiYUe/hXGP9QF2quT92lySKk2iwfpal+tpO4uPe62HRctamzi4EQhF
    jC5RBoc9aueEz60dWSFdkLBF54NJk/ojHHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522871209;
    bh=jXPkpnUrvUtn4He/WfyVisvAZrfGZ4a2F1887SGnfD8=; b=FeiWVsPFtPGj
    PRQH3I5L7VvJSxsOrMyEBdsB55msurKw7lx3MLBAmYiK6Ndq2poKR89K2YXeaAJu
    vCiTvo73QE1DcdrkG2/L/3IgsFrQ4Md5JBkFXIdJiPjqRQvUrdtRUHVlpcu9vSGX
    vMaOgrSoFqAg6RzoCwzuIa+uUQcLk9L1Q1KM+oB2Vw/3OtRnxWX4/W26gKcBpvy8
    iFQw6v0im5kyyxIK/4fYjLTLKmTDB1kuTiqcZpG5NzcAoaziZ60CyTlKsWaoih/Y
    crJYiP9z4Mx72EsoSBSU+oc/SIgEhPF6BC4OBoDNOUZmoW1G55Um3olujHX56iRc
    fJrOv0q5iA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lKWSTDFD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lKWSTDFD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOMm7QwU+IwwGYr3rYENUvLuOnjKcYxnEpOqBJkYALXPKkjylZWropHZUQ7i/Lk7Enc1g0cy6hi2ih+MKpNVMuNF9vmEQuXC34+35qcC0Sk/Yk4Jpcg3
    j93dhD/pTaQO0LaK3mfrRXn1KtDSW+WREGc/yDM+I2ZABRNel307bqldBKEFo4R2TcrXjhpIRlIBrTolTUZCKQM4Kq5aAyG1y8RIpG16/M1iYs+ZS7TZxk8/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=VSOjU4_meCy3iPWEZ9YA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDDTqq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 15:46:46 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33992 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeDDTqp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 15:46:45 -0400
X-Google-Smtp-Source: AIpwx49jLodGj+fbyiX189NEv+QfJmUGhRFfkH5v2JG3tTmM5/RBxtTx+uv4m1FFA/ukuBLWNzNx1w==
Message-ID: <1522871203.3935.10.camel@redhat.com>
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
Date: Wed, 04 Apr 2018 15:46:43 -0400
In-Reply-To: <20180404193126.GH5453@intel.com>
References: <20180402212142.19841-1-lyude@redhat.com>
         <20180402212617.21247-1-lyude@redhat.com> <20180404153429.GE5453@intel.com>
         <1522867061.12403.6.camel@redhat.com> <20180404185313.GG5453@intel.com>
         <1522868349.12403.12.camel@redhat.com> <20180404193126.GH5453@intel.com>
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

On Wed, 2018-04-04 at 22:31 +0300, Ville Syrjälä wrote:
> On Wed, Apr 04, 2018 at 02:59:09PM -0400, Lyude Paul wrote:
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
> > That's my hypothesis at least. I'm betting that on the fact that when I
> > was
> > implementing MST retraining before we put the intel_dp_check_mst_status()
> > (or
> > whatever it's called) into the dig workqueue, getting the sink to go down
> > and
> > come back up was a lot more unreliable whenever I introduced anything that
> > would block the esi handler for longer then a very brief period of time
> > (say,
> > 50-100ms?). I've seen some notes elsewhere too that seemed to imply for
> > SST,
> > things were pretty sensitive to irq latency (line 1050, intel_dp.c) so it
> > wouldn't be terribly surprising if it's the same for MST. At the very
> > least,
> > now that we've got the ESI handler running in the dig worker things seem
> > to
> > have gotten a /lot/ more reliable now that we can basically go the whole
> > modeset without blocking the ESI handler for very long.
> 
> Hmm. OK, so the spec seems to be saying that we have 100ms to read
> the UP_REQ/DOWN_REPLY msg after the IRQ_HPD. That's still a lot more
> than the 1ms max allowed wakeup time. Looks like there's a extended
> wakeup time request/grant mechanism now, but without the explicit
> grant (which we don't do) the 1ms still holds.
mm, that is true. There were definitely interrupts getting dropped though with
this patch, although it was rather rare. The other thing too (and this was a
lot easier to reproduce) was that when we do a modeset that lowers the link
rate:

 * check modeset
 * commit disables so we can reprogram the vcpi (puts sink into D3)
 * commit enables
    * actually send request to put sink into D0
    * Go to start link training...
    * *TIMEOUT on response from hub*
    * continue modeset...
 * commit finishes
 * short period of time after the commit finishes, we receive the response
   from the hub where we tried to start link training

This being said: I think it may actually be a good idea for us to consider
waiting for the hub anyway when we're turning it on like we do with SST, since
we could be waking it up from a D3 state we didn't set ourselves anyway, but
either way I think since we can at least benefit from not having to deal with
the wakeup time at all in modesets like this (and it's not really problematic
to other hubs), we probably should do that as well with or without a busy
wait.
> 
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

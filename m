Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-719175-1522867692-2-6959593874013223795
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
    1522867692; b=bf6IC7Gcr1aEWkFiZPJrLtTBvTvKR/F0XRzWMsfEllzqAyZbht
    s27SBQnHQW/Fz0Xsp8tQr0zJ8DYzcZmFMGhKU8O452p0x9QUhrHzPHjPCqJ7/8U8
    4s/4JgFkY6C026GtSdbhdz9r5tINY9dTbcLRssguPKuQvC06c1HJnxxWnjP2cY3D
    GqcwnHf0hdDfuRUDOi5u8bH6XNKAPFM8AHTDryFZwsQJacU/OjR3orbD+5t7FR3z
    Jr5gpA3Q+NPFaHaeUWR/lBun5yWUfmo29KkKRRGICuVpmzgRWPMta6fIXe2aKHi4
    5jP4dZWBGsb2iAvVtj6Yn5wYMp3zjgo2uulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522867692;
    bh=mpU4qs6N8VAIpT06k21nG03H1CpDIuVzW+yGCMz+mnc=; b=pkek9N+1MgXt
    UEE5xxp7TSvUJHg7GzWwL7Cr2UeD+530jgFQx0sa2vUG/Sx9BFqd3R6dk7tDZoV0
    Cdn4quLTFxzC+XlnTLxJZQW/13sbnLsT1WO1bbSSg6OPRMLt/PTm/smNQgNo0LG4
    B2ICNskhkbghy4/ykz5bVcaTZhmVMfkpDG0i692KOfqNrtr8XjBjaY4XT2N2unMg
    Mrt4pD9RkLE2Vc4yIRRs2LH5JKGykt0k3GtvoayVpdduGk5jbHByTul8Ex7G/Tpa
    SA6DVZIGgqBu/jbWZHYSVj9q1v2aKwPjjfnP/ZBFoj2Nz1cvu4uemQWzgkN+77pY
    JYxhg2REYA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XkLzDk+y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XkLzDk+y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMFKZ4g8tsodwf+jcsrJU4m5BxrAWXSFi+TNcSjiGHUl/Zbz3uwjXeqgr7DAfL0sauDHLsiig/S+9HeRf3LFhhhI7A5h0QgeEXydhsM5F7p8XhPoiXHS
    AeGqKpvMnL3EHJZPHsDJwWYicJVwSFomDaw8wAsva+82p7ATAw4Uiat9JYfVwkUdipouTfYxBy7PEAGR1X4Ob/VItI1shD6WzgQ2brGtu7IJbnLSBAvJV7mY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8
    a=VUikG38Sawh5lcqwdkcA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeDDSsJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 14:48:09 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41250 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeDDSsI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 14:48:08 -0400
X-Google-Smtp-Source: AIpwx4+0mksvfslKQKFwgwbjqssDbCtzuHKn1UbNLMQdU3ovnnz6fD+A+yY9ZYhLZ/BYmPQ8Mc12lw==
Message-ID: <1522867686.12403.8.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Keep AUX block running when
 disabling DPMS for MST
From: Lyude Paul <lyude@redhat.com>
To: Manasi Navare <manasi.d.navare@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>
Date: Wed, 04 Apr 2018 14:48:06 -0400
In-Reply-To: <20180404184435.GA2804@intel.com>
References: <20180402212142.19841-1-lyude@redhat.com>
         <20180402212617.21247-1-lyude@redhat.com> <20180404153429.GE5453@intel.com>
         <20180404184435.GA2804@intel.com>
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

On Wed, 2018-04-04 at 11:44 -0700, Manasi Navare wrote:
> On Wed, Apr 04, 2018 at 06:34:29PM +0300, Ville Syrjälä wrote:
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
> > > Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable
> > > MST hub.")
> > > ---
> > >  drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/intel_dp.c
> > > b/drivers/gpu/drm/i915/intel_dp.c
> > > index 62f82c4298ac..0479c377981b 100644
> > > --- a/drivers/gpu/drm/i915/intel_dp.c
> > > +++ b/drivers/gpu/drm/i915/intel_dp.c
> > > @@ -2589,11 +2589,13 @@ void intel_dp_sink_dpms(struct intel_dp
> > > *intel_dp, int mode)
> > >  		return;
> > >  
> > >  	if (mode != DRM_MODE_DPMS_ON) {
> > > +		unsigned char data = intel_dp->is_mst ?
> > > +			DP_SET_POWER_D3_AUX_ON : DP_SET_POWER_D3;
> > 
> > This smells like a workaround for an actual bug somewhere. Why exactly
> > is the slower wakeup or the AUX block a problem for MST but not for SST
> > when the link training is exactly the same for SST and MST?
> > 
> 
> The problem occurs only in case of MST because the Channel EQ failure is
> notified
> through ESI sideband AUX messages which potentially  can get dropped because
> of disabling
> DPMS. But in case of SST, we detect the channel EQ failure write during the
> EQ TPS sequence
> which happens on the main link.

mhm- that is the big problem it causes, at least with this patchset. I've been
considering maybe looking into probing downstream sinks with remote dpcd reads
to see their link training status, as I think that might actually be the real
reason for why there's this weird difference between the channel eq status in
the esi and the actual link training status of the hub in the dpcd registers
that are shared with SST. but that's for a later date :)
> 
> Manasi
>  
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
> > -- 
> > Ville Syrjälä
> > Intel OTC
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
-- 
Cheers,
	Lyude Paul

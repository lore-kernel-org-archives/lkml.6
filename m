Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486815-1522349194-2-2683079490287782344
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='ISO-8859-1', cc='ISO-8859-1', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522349193; b=e6/cRdDtLA8JdJnICACcjUBqtdwgKasUVmnUsUueNVFeT83vBT
    WwK6cJyBAUSvXAWO/yudfXz5bttTcd6hQqRyPTOygOgdOrTVIeDIgESMwx3dk9Qw
    o9MF1u1Y0vCAlSVUeMDb4JD4OngTYXO447YRGfFx3C6jvOOXR6Jhr4GaMXwv4ieg
    rkPYpQJi8VcyknAkrtiMg2WhnX/3La68rgLvLtdAqcrYqSEmKHHluXBPcf74K9dy
    +GJ5NID7mUpYbFB8Y84tb/N7vbOFub4e8FaUZ3gTBFSajUP5RLB2vEuK4ixrhZpp
    BRTOQUq+dMqAfEtoBLag5txWFe7mSFdR3UIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522349193;
    bh=SeosKom7cIjRVZEL8QUBTR4UJn6SA5kdImhydvJgekw=; b=ZX4CmRaXDZIE
    o2Rxpqw/ClnlsZZG0WQMCwk5btjPqR7fp5YSwhu1TqzJhN7/x/SgV2xSuAVpynXg
    lHpueyROjaBIB57kaYUp5PUfkOTfvthpHH8CGB7yGt//57dnBuoESTLvTn9XJlPv
    Kb0wUzrnepkTK2+tFF1ulul7lTLEeVmmZb7LftMw5H5ualSVMhFy5O9qrT+m8L5I
    zJVdecsf12oDVso6hJoes01BGpxR8RngsPXTsdjaYt7dQnmdRdSN54axvUs98BgU
    a6a00BC2k4swQ1R8l33tGFT0/2tVExz2aHiZsIEkFZQ3JL+faMXRNldmC38MCwgh
    WQZV/CyWTg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO0xOYop2I/db1lRhlIJ2b2cgD91u+v/++OuP090Ht/3n92NOTxB1ZGzPlX64Gt4o9IwfLoOO+LDt6qiM9ydnoHZOdoaBDAoMC0BjKFJ8mWKqGZCWi26
    M1hOTSQD2pdSQ/IofXbvmZ5VeFQYhYL78Siqct38jpeoH2cNKT3K+ylWRfEaN/uyXJeYhLZjOFHOY+TGlAVSduHAiz3vVMYBIUi6MI+OxzpsGc8qPu3U5/ZN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=taGs_qngAAAA:8 a=QyXUC8HyAAAA:8 a=F5OasDLRAAAA:8 a=P1BnusSwAAAA:8
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8
    a=AiO9hSr6ja2oc0JwRagA:9 a=hLLMjuQ0dyX2o153:21 a=5vwx64XSD-NIZUMA:21
    a=QEXdDO2ut3YA:10 a=DM_PlaNYpjARcMQr2apF:22 a=UUmgAkjOvJY8lVOI6Cee:22
    a=D0XLA9XvdZm18NrgonBM:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeC2Sqa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:46:30 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45884 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeC2Sq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:46:29 -0400
Message-ID: <1522349182.2654.24.camel@codethink.co.uk>
Subject: Re: [PATCH AUTOSEL for 4.4 016/115] drm: Defer disabling the vblank
 IRQ until the next interrupt (for instant-off)
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@redhat.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 29 Mar 2018 19:46:22 +0100
In-Reply-To: <20180329164207.GY5453@intel.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
         <20180303223010.27106-16-alexander.levin@microsoft.com>
         <1522341133.2654.22.camel@codethink.co.uk>
         <20180329164207.GY5453@intel.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-29 at 19:42 +0300, Ville Syrjälä wrote:
> On Thu, Mar 29, 2018 at 05:32:13PM +0100, Ben Hutchings wrote:
> > On Sat, 2018-03-03 at 22:30 +0000, Sasha Levin wrote:
> > > > > > From: Chris Wilson <chris@chris-wilson.co.uk>
> > > 
> > > [ Upstream commit 608b20506941969ea30d8c08dc9ae02bb87dbf7d ]
> > 
> > I think we need this one too:
> > 
> > commit 75cff0837c14eaf632efabb8d7ab9eec6394d20d
> > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > Date:   Fri Mar 24 17:30:58 2017 +0000
> > 
> >     drm: Make the decision to keep vblank irq enabled earlier
> 
> Why are we backporting optimizations anyway?

That's a good question.  I don't know the reasoning behind picking the
first commit (608b20506941).  I'm only suggesting the second commit
because it appears to be an important fix for the first.

Ben.

> > 
> > Ben.
> > 
> > > On vblank instant-off systems, we can get into a situation where the cost
> > > of enabling and disabling the vblank IRQ around a drmWaitVblank query
> > > dominates. And with the advent of even deeper hardware sleep state,
> > > touching registers becomes ever more expensive.  However, we know that if
> > > the user wants the current vblank counter, they are also very likely to
> > > immediately queue a vblank wait and so we can keep the interrupt around
> > > and only turn it off if we have no further vblank requests queued within
> > > the interrupt interval.
> > > 
> > > After vblank event delivery, this patch adds a shadow of one vblank where
> > > the interrupt is kept alive for the user to query and queue another vblank
> > > event. Similarly, if the user is using blocking drmWaitVblanks, the
> > > interrupt will be disabled on the IRQ following the wait completion.
> > > However, if the user is simply querying the current vblank counter and
> > > timestamp, the interrupt will be disabled after every IRQ and the user
> > > will enabled it again on the first query following the IRQ.
> > > 
> > > v2: Mario Kleiner -
> > > After testing this, one more thing that would make sense is to move
> > > the disable block at the end of drm_handle_vblank() instead of at the
> > > top.
> > > 
> > > Turns out that if high precision timestaming is disabled or doesn't
> > > work for some reason (as can be simulated by echo 0 >
> > > /sys/module/drm/parameters/timestamp_precision_usec), then with your
> > > delayed disable code at its current place, the vblank counter won't
> > > increment anymore at all for instant queries, ie. with your other
> > > "instant query" patches. Clients which repeatedly query the counter
> > > and wait for it to progress will simply hang, spinning in an endless
> > > query loop. There's that comment in vblank_disable_and_save:
> > > 
> > > "* Skip this step if there isn't any high precision timestamp
> > >  * available. In that case we can't account for this and just
> > >  * hope for the best.
> > >  */
> > > 
> > > With the disable happening after leading edge of vblank (== hw counter
> > > increment already happened) but before the vblank counter/timestamp
> > > handling in drm_handle_vblank, that step is needed to keep the counter
> > > progressing, so skipping it is bad.
> > > 
> > > Now without high precision timestamping support, a kms driver must not
> > > set dev->vblank_disable_immediate = true, as this would cause problems
> > > for clients, so this shouldn't matter, but it would be good to still
> > > make this robust against a future kms driver which might have
> > > unreliable high precision timestamping, e.g., high precision
> > > timestamping that intermittently doesn't work.
> > > 
> > > v3: Patch before coffee needs extra coffee.
> > > 
> > > Testcase: igt/kms_vblank
> > > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Michel Dänzer <michel@daenzer.net>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Dave Airlie <airlied@redhat.com>,
> > > Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
> > > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Link: http://patchwork.freedesktop.org/patch/msgid/20170315204027.20160-1-chris@chris-wilson.co.uk
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > ---
> > >  drivers/gpu/drm/drm_irq.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> > > index 8090989185b2..4ddbc49125cd 100644
> > > --- a/drivers/gpu/drm/drm_irq.c
> > > +++ b/drivers/gpu/drm/drm_irq.c
> > > @@ -1271,9 +1271,9 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
> > >  	if (atomic_dec_and_test(&vblank->refcount)) {
> > >  		if (drm_vblank_offdelay == 0)
> > >  			return;
> > > -		else if (dev->vblank_disable_immediate || drm_vblank_offdelay < 0)
> > > +		else if (drm_vblank_offdelay < 0)
> > >  			vblank_disable_fn((unsigned long)vblank);
> > > -		else
> > > +		else if (!dev->vblank_disable_immediate)
> > >  			mod_timer(&vblank->disable_timer,
> > >  				  jiffies + ((drm_vblank_offdelay * HZ)/1000));
> > >  	}
> > > @@ -1902,6 +1902,16 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
> > >  	wake_up(&vblank->queue);
> > >  	drm_handle_vblank_events(dev, pipe);
> > >  
> > > +	/* With instant-off, we defer disabling the interrupt until after
> > > +	 * we finish processing the following vblank. The disable has to
> > > +	 * be last (after drm_handle_vblank_events) so that the timestamp
> > > +	 * is always accurate.
> > > +	 */
> > > +	if (dev->vblank_disable_immediate &&
> > > +	    drm_vblank_offdelay > 0 &&
> > > +	    !atomic_read(&vblank->refcount))
> > > +		vblank_disable_fn((unsigned long)vblank);
> > > +
> > >  	spin_unlock_irqrestore(&dev->event_lock, irqflags);
> > >  
> > >  	return true;
> > > -- 
> > > 2.14.1
> > 
> > -- 
> > Ben Hutchings
> > Software Developer, Codethink Ltd.
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.

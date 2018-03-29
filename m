Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1260408-1522341737-2-969482586703635397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522341736; b=ABnxSELEde1kimbKGHcwuhnw8uv2MtlehSMGB7GcrvqUAx62Zr
    lU0SOr4Du7Rh/tZkK/oRvzi1MKh7JMS4MkQ0Hjkw23mtpSmEwSzTg1D4rwGrAk/U
    fDlLsMZ1CrP2e7APuFBMpGqFpUKEOtUYM9iSzk71CNK8XRfYtVZIKyc7I/D6FZSJ
    KUvrsgrpm+X4RNq9lWN+Uxf4XmhdNCPrAHjfhIHIEDc36mLNR4P5eYmrDB/KKcA+
    LcGlGWClSoNwfeH99bTxNl0QfReYmv3aMGh5e3PlC7NpojMfjaXPZfCtVfbph3yu
    /qlJmL5jn840w+8l/NmHfwgWHMCnF0NkqRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522341736; bh=k3l++F2bg0j
    SF1CvT6yg1TFjY+CXfn3KCOt2r5IaOOw=; b=v91IcWsLMieIpX4H+EGm6xmqT1G
    AfS/AugHXGCFbTjTLgToYhwqQkcsg+ZhFqr467i2tw5m+/d0lrt35BYYvy0UYhgX
    LS7SAnQobXc2q4p1kfNCUtMgYGx4JHjKo8dy0ZEFOxbOvAKxHqnAVLqslK3Ad/BP
    whK02ywZIS5mPx0zCOT3cB+wJ8qfJoglqMQLXLj8PRYKkaKAxuM9FAH64w1LlS8Q
    RvuINSOOlGpaa+7kTzr6A0jYTpfM1f8ybrpOgCN1VTO27LIR2b0cUoYOYpPcAQNk
    N0nZE7A3OLn253lx/9ZSAcZ3XzCynhxVyiV9aehsaIc1b+ciOkDAoEiWl+Q==
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
X-CM-Envelope: MS4wfFJswKTidrGDKmsGoJDIRZ46igHZq7taiet33ftT0TMhV//pF0XsqvzuFKENozrqxfcUvjnrhSwEtw5w9UMhuzqfnGd65LPR+MCGqkf3yyoV3IZ6nXJg
    GX5xwYuf7SpEEcRilYw+U7B9UW+Et7aIi9ZOCmc7GhDEewysQcO/XMn0Iniqtgqd5aRFoCLWADE9GxJp4WM6YMBMbCzA2jlGFi0BTgzBVKooJ1bU19cuMrNT
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=v2DPQv5-lfwA:10
    a=taGs_qngAAAA:8 a=QyXUC8HyAAAA:8 a=F5OasDLRAAAA:8 a=P1BnusSwAAAA:8
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8
    a=pFpKLmO2iCk2hQ3DpEEA:9 a=faoAIjnEkXQysz-V:21 a=w7DXGT8BjzMJKk_6:21
    a=wPNLvfGTeEIA:10 a=DM_PlaNYpjARcMQr2apF:22 a=UUmgAkjOvJY8lVOI6Cee:22
    a=D0XLA9XvdZm18NrgonBM:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeC2QmN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 12:42:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:33191 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeC2QmM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 29 Mar 2018 12:42:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37924014"
Date: Thu, 29 Mar 2018 19:42:07 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@redhat.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH AUTOSEL for 4.4 016/115] drm: Defer disabling the vblank
 IRQ until the next interrupt (for instant-off)
Message-ID: <20180329164207.GY5453@intel.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
 <20180303223010.27106-16-alexander.levin@microsoft.com>
 <1522341133.2654.22.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522341133.2654.22.camel@codethink.co.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 05:32:13PM +0100, Ben Hutchings wrote:
> On Sat, 2018-03-03 at 22:30 +0000, Sasha Levin wrote:
> > From: Chris Wilson <chris@chris-wilson.co.uk>
> > 
> > [ Upstream commit 608b20506941969ea30d8c08dc9ae02bb87dbf7d ]
> 
> I think we need this one too:
> 
> commit 75cff0837c14eaf632efabb8d7ab9eec6394d20d
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Fri Mar 24 17:30:58 2017 +0000
> 
>     drm: Make the decision to keep vblank irq enabled earlier

Why are we backporting optimizations anyway?

> 
> Ben.
> 
> > On vblank instant-off systems, we can get into a situation where the cost
> > of enabling and disabling the vblank IRQ around a drmWaitVblank query
> > dominates. And with the advent of even deeper hardware sleep state,
> > touching registers becomes ever more expensive.  However, we know that if
> > the user wants the current vblank counter, they are also very likely to
> > immediately queue a vblank wait and so we can keep the interrupt around
> > and only turn it off if we have no further vblank requests queued within
> > the interrupt interval.
> > 
> > After vblank event delivery, this patch adds a shadow of one vblank where
> > the interrupt is kept alive for the user to query and queue another vblank
> > event. Similarly, if the user is using blocking drmWaitVblanks, the
> > interrupt will be disabled on the IRQ following the wait completion.
> > However, if the user is simply querying the current vblank counter and
> > timestamp, the interrupt will be disabled after every IRQ and the user
> > will enabled it again on the first query following the IRQ.
> > 
> > v2: Mario Kleiner -
> > After testing this, one more thing that would make sense is to move
> > the disable block at the end of drm_handle_vblank() instead of at the
> > top.
> > 
> > Turns out that if high precision timestaming is disabled or doesn't
> > work for some reason (as can be simulated by echo 0 >
> > /sys/module/drm/parameters/timestamp_precision_usec), then with your
> > delayed disable code at its current place, the vblank counter won't
> > increment anymore at all for instant queries, ie. with your other
> > "instant query" patches. Clients which repeatedly query the counter
> > and wait for it to progress will simply hang, spinning in an endless
> > query loop. There's that comment in vblank_disable_and_save:
> > 
> > "* Skip this step if there isn't any high precision timestamp
> >  * available. In that case we can't account for this and just
> >  * hope for the best.
> >  */
> > 
> > With the disable happening after leading edge of vblank (== hw counter
> > increment already happened) but before the vblank counter/timestamp
> > handling in drm_handle_vblank, that step is needed to keep the counter
> > progressing, so skipping it is bad.
> > 
> > Now without high precision timestamping support, a kms driver must not
> > set dev->vblank_disable_immediate = true, as this would cause problems
> > for clients, so this shouldn't matter, but it would be good to still
> > make this robust against a future kms driver which might have
> > unreliable high precision timestamping, e.g., high precision
> > timestamping that intermittently doesn't work.
> > 
> > v3: Patch before coffee needs extra coffee.
> > 
> > Testcase: igt/kms_vblank
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Michel Dänzer <michel@daenzer.net>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Dave Airlie <airlied@redhat.com>,
> > Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Link: http://patchwork.freedesktop.org/patch/msgid/20170315204027.20160-1-chris@chris-wilson.co.uk
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > ---
> >  drivers/gpu/drm/drm_irq.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> > index 8090989185b2..4ddbc49125cd 100644
> > --- a/drivers/gpu/drm/drm_irq.c
> > +++ b/drivers/gpu/drm/drm_irq.c
> > @@ -1271,9 +1271,9 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
> >  	if (atomic_dec_and_test(&vblank->refcount)) {
> >  		if (drm_vblank_offdelay == 0)
> >  			return;
> > -		else if (dev->vblank_disable_immediate || drm_vblank_offdelay < 0)
> > +		else if (drm_vblank_offdelay < 0)
> >  			vblank_disable_fn((unsigned long)vblank);
> > -		else
> > +		else if (!dev->vblank_disable_immediate)
> >  			mod_timer(&vblank->disable_timer,
> >  				  jiffies + ((drm_vblank_offdelay * HZ)/1000));
> >  	}
> > @@ -1902,6 +1902,16 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
> >  	wake_up(&vblank->queue);
> >  	drm_handle_vblank_events(dev, pipe);
> >  
> > +	/* With instant-off, we defer disabling the interrupt until after
> > +	 * we finish processing the following vblank. The disable has to
> > +	 * be last (after drm_handle_vblank_events) so that the timestamp
> > +	 * is always accurate.
> > +	 */
> > +	if (dev->vblank_disable_immediate &&
> > +	    drm_vblank_offdelay > 0 &&
> > +	    !atomic_read(&vblank->refcount))
> > +		vblank_disable_fn((unsigned long)vblank);
> > +
> >  	spin_unlock_irqrestore(&dev->event_lock, irqflags);
> >  
> >  	return true;
> > -- 
> > 2.14.1
> -- 
> Ben Hutchings
> Software Developer, Codethink Ltd.

-- 
Ville Syrjälä
Intel OTC

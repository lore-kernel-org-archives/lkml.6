Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1224189-1522341142-2-7420756150944329617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='ISO-8859-1', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522341141; b=rn/3f5HKB9wc7otYDGEZKNVrgxlaUYWoolncM0UuIXDZ+nIs+0
    AbqJAS1vLp7iroUm72WrnYSMxUjTA3tUiIvh5Y84qRhk6mWXya0OVGB30vgizzIO
    braWeG3Vefufz+IxQa42iKvmt/Jp24DFEP5MErgELsyQSW/UA096Ai0skeNJpVfw
    2DZNOLoHTbt3z/aStcvftRtYNgfbExobiOz37V+3iYcFkKYt3aH48IbKRcJVbNdX
    eWeB9rA21LmSsPcUge+otULLvevNTXPvnR/d7LioaOD4OHLPC0Sz9s90Q91dG+FR
    MViMKAFXYgGlFrsXtx6LNZ+TRz5Ko3Hr4omQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522341141;
    bh=aT9+Yy5lJF9Cb+CdlrkJyjfS/Onb7jJjS/hKgD03RIs=; b=RE17OTNG2+tU
    ewVTYSUHTRxYDN7DoYwjZjyYiW+eWNRMPJtLVXjhJxh+VuiUNGbcU1IltPrwPuw+
    rOYk13w4HkJxJAYe4fCw1Ifesq8K9mSGvv2z+Q4L7hssJJvWICeCW+R+IlQHUzs5
    W2hXzqN4fTkvGU8AL1nKeDwsGHaL86BSfh8+ysWe41RXSApu1DjeCqrW8jzoizH+
    QGZ/DRPCrHqEmh7ZrMIKNbRLmap4OtICOCC2lV8KrbYJT+/sCQ4l8jg8WiC0ciLJ
    5yxFi8XSOyJ9tQ7orHfhBhMCbvJnOICgS6Ai8tsl7E9m7PwtqTos/mnunVdR1GJG
    IIa+W/10Hw==
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
X-CM-Envelope: MS4wfI9yB3qPW4ILPPVo3Y02fnymOYLo7JPwcs9sLV2pWk8vjbJMhdrWJtYCG1QeinkLTyslNETNMSBiGJX/ZA7w4bGJIv0VlLdbc+1fvKocDrOGJT0/lKr4
    8nLyHslcVrF3b+q1Sjxz1tBSa9g959FgZNOyqejkKqedMq2mncC1p5/RBS3rEZUa1HddPHSydTFw9ZZnr2ba9G5utAh6ymmNT10ZtSonYVKaOG01YUp68xaF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=taGs_qngAAAA:8 a=QyXUC8HyAAAA:8 a=F5OasDLRAAAA:8 a=P1BnusSwAAAA:8
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=yMhMjlubAAAA:8
    a=QmMcfP126UTFR-epMHsA:9 a=L9vgI6RYAClAsE_i:21 a=UvIqbRyXZMG0VPuZ:21
    a=QEXdDO2ut3YA:10 a=DM_PlaNYpjARcMQr2apF:22 a=UUmgAkjOvJY8lVOI6Cee:22
    a=D0XLA9XvdZm18NrgonBM:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeC2QcS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 12:32:18 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43851 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC2QcR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 12:32:17 -0400
Message-ID: <1522341133.2654.22.camel@codethink.co.uk>
Subject: Re: [PATCH AUTOSEL for 4.4 016/115] drm: Defer disabling the vblank
 IRQ until the next interrupt (for instant-off)
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@redhat.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 29 Mar 2018 17:32:13 +0100
In-Reply-To: <20180303223010.27106-16-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
         <20180303223010.27106-16-alexander.levin@microsoft.com>
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

On Sat, 2018-03-03 at 22:30 +0000, Sasha Levin wrote:
> From: Chris Wilson <chris@chris-wilson.co.uk>
> 
> [ Upstream commit 608b20506941969ea30d8c08dc9ae02bb87dbf7d ]

I think we need this one too:

commit 75cff0837c14eaf632efabb8d7ab9eec6394d20d
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Fri Mar 24 17:30:58 2017 +0000

    drm: Make the decision to keep vblank irq enabled earlier

Ben.

> On vblank instant-off systems, we can get into a situation where the cost
> of enabling and disabling the vblank IRQ around a drmWaitVblank query
> dominates. And with the advent of even deeper hardware sleep state,
> touching registers becomes ever more expensive.  However, we know that if
> the user wants the current vblank counter, they are also very likely to
> immediately queue a vblank wait and so we can keep the interrupt around
> and only turn it off if we have no further vblank requests queued within
> the interrupt interval.
> 
> After vblank event delivery, this patch adds a shadow of one vblank where
> the interrupt is kept alive for the user to query and queue another vblank
> event. Similarly, if the user is using blocking drmWaitVblanks, the
> interrupt will be disabled on the IRQ following the wait completion.
> However, if the user is simply querying the current vblank counter and
> timestamp, the interrupt will be disabled after every IRQ and the user
> will enabled it again on the first query following the IRQ.
> 
> v2: Mario Kleiner -
> After testing this, one more thing that would make sense is to move
> the disable block at the end of drm_handle_vblank() instead of at the
> top.
> 
> Turns out that if high precision timestaming is disabled or doesn't
> work for some reason (as can be simulated by echo 0 >
> /sys/module/drm/parameters/timestamp_precision_usec), then with your
> delayed disable code at its current place, the vblank counter won't
> increment anymore at all for instant queries, ie. with your other
> "instant query" patches. Clients which repeatedly query the counter
> and wait for it to progress will simply hang, spinning in an endless
> query loop. There's that comment in vblank_disable_and_save:
> 
> "* Skip this step if there isn't any high precision timestamp
>  * available. In that case we can't account for this and just
>  * hope for the best.
>  */
> 
> With the disable happening after leading edge of vblank (== hw counter
> increment already happened) but before the vblank counter/timestamp
> handling in drm_handle_vblank, that step is needed to keep the counter
> progressing, so skipping it is bad.
> 
> Now without high precision timestamping support, a kms driver must not
> set dev->vblank_disable_immediate = true, as this would cause problems
> for clients, so this shouldn't matter, but it would be good to still
> make this robust against a future kms driver which might have
> unreliable high precision timestamping, e.g., high precision
> timestamping that intermittently doesn't work.
> 
> v3: Patch before coffee needs extra coffee.
> 
> Testcase: igt/kms_vblank
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Michel Dänzer <michel@daenzer.net>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Dave Airlie <airlied@redhat.com>,
> Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Link: http://patchwork.freedesktop.org/patch/msgid/20170315204027.20160-1-chris@chris-wilson.co.uk
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/gpu/drm/drm_irq.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
> index 8090989185b2..4ddbc49125cd 100644
> --- a/drivers/gpu/drm/drm_irq.c
> +++ b/drivers/gpu/drm/drm_irq.c
> @@ -1271,9 +1271,9 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
>  	if (atomic_dec_and_test(&vblank->refcount)) {
>  		if (drm_vblank_offdelay == 0)
>  			return;
> -		else if (dev->vblank_disable_immediate || drm_vblank_offdelay < 0)
> +		else if (drm_vblank_offdelay < 0)
>  			vblank_disable_fn((unsigned long)vblank);
> -		else
> +		else if (!dev->vblank_disable_immediate)
>  			mod_timer(&vblank->disable_timer,
>  				  jiffies + ((drm_vblank_offdelay * HZ)/1000));
>  	}
> @@ -1902,6 +1902,16 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
>  	wake_up(&vblank->queue);
>  	drm_handle_vblank_events(dev, pipe);
>  
> +	/* With instant-off, we defer disabling the interrupt until after
> +	 * we finish processing the following vblank. The disable has to
> +	 * be last (after drm_handle_vblank_events) so that the timestamp
> +	 * is always accurate.
> +	 */
> +	if (dev->vblank_disable_immediate &&
> +	    drm_vblank_offdelay > 0 &&
> +	    !atomic_read(&vblank->refcount))
> +		vblank_disable_fn((unsigned long)vblank);
> +
>  	spin_unlock_irqrestore(&dev->event_lock, irqflags);
>  
>  	return true;
> -- 
> 2.14.1
-- 
Ben Hutchings
Software Developer, Codethink Ltd.

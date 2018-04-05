Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3962421-1522968906-2-17606800633933225880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522968905; b=PjateEJLZ68NTHpj9feMKm2X5UbdCbDDzQh0RFzoA/Aogtzm8n
    XZwMZ2v/2cqguU5UfP8hhDfBLG7RRVjN+ZsdhAq+nxMZf6wBto9spJGXI+5SaSkh
    OEllflZXEScoziSeOgvA2vZc1pEiUh/fFJ9+I8d0NsCYOyAb2PuwAKIv8sbObIPG
    J7ajPLUydbIhckkFKEmM98rGr1/dwA8tM8EFk6K7TkE5gwTJ2pvkWC4U/MN5jgNt
    e//9hZHjcq3LDWhoACEcO93mJHJZGfFZDww9AvRK7pcFK7mdJ/iR2yVZX6F2MA6E
    yVgRVetbRNIFW9wCDjxHNe/74Q8gGnO1VwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:reply-to:to:cc
    :date:in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522968905;
    bh=XXnbxLAfdgNwiwx3ccuexPI0lLQQyLkVvyOcyk0+hec=; b=c3VIj+Y4WA9A
    OFBLKsl3u5b0WK3x+A5hdYF3/xq02fu7LqtFBgNc+yHAJDCZHaxYascaBnPNEUAw
    Baei8Knx+1eXDQG1yOe2+z9RFvWW4lzV9zFoOAAfee+D1lp7umWtNfVUQXpMHh/R
    d9ijTGkpvulqQ9StG2CRBE3YI8fEL7i69v9e/+rBzgOzU8iK9pVpCmRr26PcSeAa
    u3Db1mHG9i3lFBkwtKq6VqzrQHtSfmUZfIvpGV6iSW/w+BI3hAUBWDuMIJ6MZifm
    cF07kNxxGfRo01toV3aLvlE0+NANkIh+K5lS3l5QUHPqe5EJrto/0yo1djz2CB0i
    CtqCPadIPQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfA7jt+6lIRSkAdUvam9uMNzl3J3At1fo5hN+zrSXCiZvLyLuPdtPzezCaN2bLp7xve7VwhXsCK0y6HiROqxD2zTFQGOMlCYZh10NBCwEHBOcp1I1/d3R
    GsXXCxSpM+ImlUQTreVVWCQb5TTTnQtl8wll0tsUmuJ/6yVz8Oe1yMoZiYPhHhNbofMWDCIZ+d1KP3cTqIPc8pPmpBE0EuQzOOJppZ2s1F8+CU9Paqj4/Obx
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=1Yo2vfLtYH_QzLFqMCgA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeDEWyv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 18:54:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:25150 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752729AbeDEWys (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 18:54:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,412,1517904000";
   d="scan'208";a="31402956"
Message-ID: <1522970344.2418.51.camel@dk-H97M-D3H>
Subject: Re: [Intel-gfx] [PATCH v3] drm/i915/dp: Send DPCD ON for MST before
 phy_up
From: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Reply-To: dhinakaran.pandiyan@intel.com
To: Lyude Paul <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Laura Abbott <labbott@redhat.com>
Date: Thu, 05 Apr 2018 16:19:04 -0700
In-Reply-To: <20180405211930.1209-1-lyude@redhat.com>
References: <20180405203601.23242-1-lyude@redhat.com>
         <20180405211930.1209-1-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>




On Thu, 2018-04-05 at 17:19 -0400, Lyude Paul wrote:
> When doing a modeset where the sink is transitioning from D3 to D0 , it
> would sometimes be possible for the initial power_up_phy() to start
> timing out. This would only be observed in the last action before the
> sink went into D3 mode was intel_dp_sink_dpms(DRM_MODE_DPMS_OFF). We
> originally thought this might be an issue with us accidentally shutting
> off the aux block when putting the sink into D3, but since the DP spec
> mandates that sinks must wake up within 1ms while we have 100ms to
> respond to an ESI irq, this didn't really add up. Turns out that the
> problem is more subtle then that:
> 
> It turns out that the timeout is from us not enabling DPMS on the MST
> hub before actually trying to initiate sideband communications. This
> would cause the first sideband communication (power_up_phy()), to start
> timing out because the sink wasn't ready to respond. Afterwards, we
> would call intel_dp_sink_dpms(DRM_MODE_DPMS_ON) in
> intel_ddi_pre_enable_dp(), which would actually result in waking up the
> sink so that sideband requests would work again.
> 
> Since DPMS is what lets us actually bring the hub up into a state where
> sideband communications become functional again, we just need to make
> sure to enable DPMS on the display before attempting to perform sideband
> communications.
> 
> Changes since v1:
> - Remove comment above if (!intel_dp->is_mst) - vsryjala
> - Move intel_dp_sink_dpms() for MST into intel_dp_post_disable_mst() to
>   keep enable/disable paths symmetrical
> - Improve commit message - dhnkrn
> Changes since v2:
> - Only send DPMS off when we're disabling the last sink, and only send
>   DPMS on when we're enabling the first sink - dhnkrn
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: ad260ab32a4d9 ("drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.")
> ---
>  drivers/gpu/drm/i915/intel_ddi.c    | 6 ++++--
>  drivers/gpu/drm/i915/intel_dp_mst.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
> index a6672a9abd85..c0bf7419e1c1 100644
> --- a/drivers/gpu/drm/i915/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/intel_ddi.c
> @@ -2324,7 +2324,8 @@ static void intel_ddi_pre_enable_dp(struct intel_encoder *encoder,
>  		intel_prepare_dp_ddi_buffers(encoder, crtc_state);
>  
>  	intel_ddi_init_dp_buf_reg(encoder);
> -	intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> +	if (!intel_dp->is_mst)
> +		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);



I believe Ville recommended to check for
	is_mst = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST)
here. The question is, are there cases where 
intel_dp->is_mst != is_mst? A disconnect in the middle of a modeset
would cause intel_dp->is_mst to be false, wouldn't it?
